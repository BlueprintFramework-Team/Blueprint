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

	public var looping:Bool;
	public var pitch(default, set):Float;
	public var gain(default, set):Float;

	@:isVar public var time(get, set):Float;
	public var length(default, null):Float;
	public var playing(default, set):Bool;
	public var keepOnSwitch:Bool = false;

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

		if (autoPlay)
			play();
		SoundData.curSounds.push(this);
	}

	function update() {
		if (data.bufferNum < BUFFER_COUNT)
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
		if (data == null) return this;
		@:bypassAccessor set_time((atTime != null) ? atTime : time);

		if (source != 0) {
			AL.sourcePlay(source);
			@:bypassAccessor AL.sourcef(source, AL.SEC_OFFSET, time - Math.floor(time * data.sampleRate) / data.sampleRate);
		}

		@:bypassAccessor playing = true;
		return this;
	}

	public function stop(resetTime:Bool = false):SoundPlayer {
		if (data == null) return this;

		if (source != 0) 
			AL.sourceStop(source);

		if (resetTime)
			time = 0;
		else 
			@:bypassAccessor time = get_time();

		@:bypassAccessor playing = false;
		return this;
	}

	public function pause():SoundPlayer {
		if (data == null) return this;
		
		if (source != 0)
			AL.sourcePause(source);

		@:bypassAccessor time = get_time();
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
				@:bypassAccessor time = 0.0;
				unqueueAllBuffers();
				data.destroy();
			}
			if (newData != null)
				length = newData.getLength();
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

	function get_time():Float {
		@:privateAccess return time + (Game.lastTime - SoundData.lastSoundUpdate) * CppHelpers.boolToInt(playing);
	}

	function set_time(value:Float):Float {
		if (data == null || source <= 0) return 0;

		if (playing)
			AL.sourceStop(source);

		data.seek(value);

		unqueueAllBuffers();
		data.startSource(source);
		
		if (playing) {
			AL.sourcePlay(source);
			AL.sourcef(source, AL.SEC_OFFSET, value - Math.floor(value * data.sampleRate) / data.sampleRate);
		}

		return time = value;
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