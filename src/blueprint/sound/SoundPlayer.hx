package blueprint.sound;

import cpp.RawPointer;
import bindings.CppHelpers;
import bindings.audio.AL;
import bindings.Glfw;

import math.Vector3;
import blueprint.Game;
import blueprint.sound.AudioFormat;
import ThreadHelper.ThreadLoopFlag;

@:allow(blueprint.sound.SoundData)
class SoundPlayer {
	public var data(default, set):AudioFormat;
	private var source:cpp.UInt32 = 0;

	public var shortSound:Bool = false;
	public var looping:Bool;
	public var pitch(default, set):Float;
	public var gain(default, set):Float;

	public var time(get, set):Float;
	public var length(default, null):Float;
	public var playing(default, set):Bool;
	public var keepOnSwitch:Bool = false;
	public var finished:Signal<SoundPlayer->Void>;

	public var position(default, set):Vector3;
	public var velocity(default, set):Vector3;

	public function new(?filePath:String, autoPlay:Bool = false, looping:Bool = false, gain:Float = 1.0, pitch:Float = 1.0) {
		AL.genSources(1, RawPointer.addressOf(source));

		if (filePath != null)
			data = SoundData.getSoundData(filePath);

		this.position = new Vector3(1, 0, 0);
		this.velocity = new Vector3(0, 0, 0);
		this.pitch = pitch;
		this.gain = gain;
		this.looping = looping;
		this.finished = new Signal();

		if (autoPlay)
			play();
		SoundData.curSounds.push(this);
	}

	function update() {
		if (shortSound)
			return;

		var buffersProcessed = 0;
		AL.getSourcei(source, AL.BUFFERS_PROCESSED, CppHelpers.makePointer(buffersProcessed));

		while (buffersProcessed > 0) {
			data.queueBuffers(source);
			--buffersProcessed;
		}
	}

	extern inline function unqueueAllBuffers() {
		final queuedBuffers:Int = 0;
		AL.getSourcei(source, AL.BUFFERS_QUEUED, CppHelpers.makePointer(queuedBuffers));
		final buffers:RawPointer<cpp.UInt32> = CppHelpers.malloc(queuedBuffers, cpp.UInt32); 
		AL.sourceUnqueueBuffers(source, queuedBuffers, buffers);
		CppHelpers.free(buffers);
	}

	public function play(?atTime:Float):SoundPlayer {
		final startTime:Float = (atTime != null) ? atTime : time;
		if (data == null || startTime >= length) return this;
		if (atTime != null)
			time = atTime;
		lastStartTimestamp = Glfw.getTime();

		if (source != 0) {
			AL.sourcePlay(source);
			AL.sourcef(source, AL.SEC_OFFSET, shortSound ? lastStartTime : lastStartTime - Math.floor(lastStartTime * data.sampleRate) / data.sampleRate);
		}

		@:bypassAccessor playing = true;
		return this;
	}

	public function stop(resetTime:Bool = false):SoundPlayer {
		if (data == null || !playing) return this;

		if (source != 0) 
			AL.sourceStop(source);

		if (resetTime)
			time = 0;
		else
			lastStartTime = time;

		@:bypassAccessor playing = false;
		return this;
	}

	public function pause():SoundPlayer {
		if (data == null|| !playing) return this;
		
		if (source != 0)
			AL.sourcePause(source);

		lastStartTime = time;
		@:bypassAccessor playing = false;
		return this;
	}

	public function destroy():Void {
		if (source != 0)
			AL.deleteSources(1, cpp.RawPointer.addressOf(source));

		data = null;
		SoundData.curSounds.remove(this);
	}

	function set_data(newData:AudioFormat) {
		if (data != newData) {
			if (data != null) {
				stop();
				length = 0.0;
				lastStartTime = 0.0;
				unqueueAllBuffers();
				data.destroy();
			}
			if (newData != null) {
				length = newData.getLength();
				newData.seek(0.0);
				newData.startSource(source);
				shortSound = (newData.bufferNum < BUFFER_COUNT);
			}
		}

		return data = newData;
	}

	function set_pitch(value:Float):Float {
		if (data == null || source <= 0) return pitch;
		
		AL.sourcef(source, AL.PITCH, value);
		return pitch = value;
	}

	function set_gain(value:Float):Float {
		if (data == null || source <= 0) return gain;

		AL.sourcef(source, AL.GAIN, value);
		return gain = value;
	}

	private var lastStartTime:Float;
	private var lastStartTimestamp:Float;
	function get_time():Float {
		return lastStartTime + (Glfw.getTime() - lastStartTimestamp) * CppHelpers.boolToInt(playing);
	}

	function set_time(value:Float):Float {
		if (data == null || source <= 0) return 0;
		value = Math.min(Math.max(value, 0), length);

		if (playing)
			AL.sourceRewind(source);

		data.seek(value);
		if (!shortSound) {
			unqueueAllBuffers();
			data.startSource(source);
		}
		
		playing = playing && (value < length);
		if (playing) {
			AL.sourcePlay(source);
			AL.sourcef(source, AL.SEC_OFFSET, (shortSound) ? value : value - Math.floor(value * data.sampleRate) / data.sampleRate);
		}

		lastStartTime = value;
		lastStartTimestamp = Glfw.getTime();
		return value;
	}

	function set_playing(value:Bool):Bool {
		if (data == null || source <= 0) return false;

		if (value)
			play();
		else
			pause();

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