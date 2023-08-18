package blueprint.sound;

import bindings.AL;
import bindings.ALC;
import bindings.DrWav;
import bindings.StbVorbis;
import bindings.CppHelpers;
import math.Vector3;
import cpp.Native;

class Sound {
	private var buffer:cpp.UInt32 = 0;
	private var source:cpp.UInt32 = 0;

	public var looping(default, set):Bool;
	public var pitch(default, set):Float;
	public var gain(default, set):Float;

	public var time(get, set):Float;
	public var playing(get, set):Bool;

	public var position(default, set):Vector3;
	public var velocity(default, set):Vector3;

	public function new(?filePath:String, autoPlay:Bool = false, looping:Bool = false, gain:Float = 1.0, pitch:Float = 1.0) {
		if (filePath != null) {
			loadFromFile(filePath);
		}

		this.looping = looping;
		this.gain = gain;
		this.pitch = pitch;

		if (autoPlay) {
			play();
		}
	}

	public function loadFromFile(filePath:String):Sound {
		AL.genBuffers(1, cpp.Pointer.addressOf(buffer));

		var format:Int = 0;
		var extension:String = filePath.substring(filePath.lastIndexOf('.') + 1).toLowerCase();

		switch (extension) {
			case 'wav':
				var channels:cpp.UInt32 = 0;
				var length:cpp.UInt32 = 0;
				var sampleRate:cpp.UInt32 = 0;
				var totalFrameCount:cpp.UInt64 = 0;
				var sampleData:cpp.Pointer<cpp.Int16> = DrWav.openFileAndReadPCMFramesShort16(filePath, cpp.Pointer.addressOf(channels),
					cpp.Pointer.addressOf(sampleRate), cpp.Pointer.addressOf(totalFrameCount), null);

				if (sampleData == null) {
					trace('Failed to load WAV audio from ${filePath}.');
				} else {
					format = channels > 1 ? AL.FORMAT_STEREO16 : AL.FORMAT_MONO16;

					// I swear to god. Haxe (via hxcpp) is one of the most ANNOYING programming languages I have EVER had to deal with.
					// Seriously. Does it make ANY SENSE to ANYONE why a cpp.UInt64 ISN'T replaced with an "unsigned long long" OR EVEN an "unsigned long".
					// It just uses a stupid extra type which makes things more painful for the developer. ISTG porting dr_wav even MINORLY was H E L L because of this shit.
					// Like no joke, I feel like I could rip my hair out. I have to MANUALLY use UNTYPED CPP just to FUCKING GET THE LENGTH TOO.
					// Honestly I should've just wrote this whole function in cpp, but where is the fun in that y'know? Anyways, sorry for the ramble, hxcpp is just pain.
					// - MidnightBloxxer or something I guess.

					// also btw idk why we multiply by 4 and not 2 but 2 cuts it off half way so ig i missed something somewhere but whatever /shrug
					AL.bufferData(buffer, format, cast sampleData, untyped __cpp__('{0} * (unsigned long)(4)', totalFrameCount), cast sampleRate);
				}

				DrWav.free(cast sampleData, null);
			case 'ogg':
				var sampleData:cpp.Pointer<cpp.Int16> = null;
				var channels:Int = 0;
				var sampleRate:Int = 0;
				var totalFrameCount:Int = 0;

				untyped __cpp__('short *output;
						{0} = {1}({2}, {3}, {4}, &output);
						{5} = output', totalFrameCount,
					StbVorbis.decodeFileName, filePath, cpp.Pointer.addressOf(channels), cpp.Pointer.addressOf(sampleRate), sampleData);

				format = channels > 1 ? AL.FORMAT_STEREO16 : AL.FORMAT_MONO16;

				AL.bufferData(buffer, format, cast sampleData, totalFrameCount * 4, sampleRate);
				CppHelpers.free(cast sampleData);
			default:
				trace('Format ${extension.toUpperCase()} is not supported for sounds at this time!');
		}

		AL.genSources(1, cpp.Pointer.addressOf(source));
		AL.sourcei(source, AL.BUFFER, buffer);

		this.position = new Vector3(1, 0, 0);
		this.velocity = new Vector3(0, 0, 0);
		this.pitch = 1.0;
		this.gain = 1.0;
		this.looping = false;

		return this;
	}

	public function play(resetTime:Bool = false):Sound {
		if (resetTime) {
			time = 0;
		}

		if (source != 0) {
			AL.sourcePlay(source);
		}

		return this;
	}

	public function stop(resetTime:Bool = false):Sound {
		if (source != 0) {
			AL.sourceStop(source);
		}

		if (resetTime) {
			time = 0;
		}

		return this;
	}

	public function pause():Sound {
		if (source != 0) {
			AL.sourcePause(source);
		}

		return this;
	}

	public function destroy():Void {
		stop();

		if (source != 0 && buffer != 0) {
			AL.deleteSources(1, cpp.Pointer.addressOf(source));
			AL.deleteBuffers(1, cpp.Pointer.addressOf(buffer));
		}
	}

	private function set_looping(value:Bool):Bool {
		if (source != 0) {
			AL.sourcei(source, AL.LOOPING, value ? AL.TRUE : AL.FALSE);
		}

		return looping = value;
	}

	private function set_pitch(value:Float):Float {
		if (source != 0) {
			AL.sourcef(source, AL.PITCH, value);
		}

		return pitch = value;
	}

	private function set_gain(value:Float):Float {
		if (source != 0) {
			AL.sourcef(source, AL.GAIN, value);
		}

		return gain = value;
	}

	private function get_time():Float {
		var _time:Single = 0;

		if (source != 0) {
			AL.getSourcef(source, AL.SEC_OFFSET, cpp.Pointer.addressOf(_time));
		}

		return _time;
	}

	private function set_time(value:Float):Float {
		if (source != 0) {
			AL.sourcef(source, AL.SEC_OFFSET, value);
		}

		return time;
	}

	private function get_playing():Bool {
		var _playing:Bool = false;
		var state:Int = 0;

		if (source != 0) {
			AL.getSourcei(source, AL.SOURCE_STATE, cpp.Pointer.addressOf(state));
		}

		if (state == AL.PLAYING) {
			_playing = true;
		}

		return _playing;
	}

	private function set_playing(value:Bool):Bool {
		if (value) {
			play();
		} else {
			pause();
		}

		return playing;
	}

	private function set_position(value:Vector3):Vector3 {
		AL.source3f(source, AL.POSITION, value.x, value.y, value.z);
		return position = value;
	}

	private function set_velocity(value:Vector3):Vector3 {
		AL.source3f(source, AL.VELOCITY, value.x, value.y, value.z);
		return velocity = value;
	}
}
