package blueprint.sound;

import bindings.AL;
import bindings.ALC;
import bindings.DrWav;
import bindings.StbVorbis;
import bindings.CppHelpers;
import math.Vector3;
import cpp.Native;

class Sound {
	private static var curSounds:Array<Sound> = []; // For sound clearing.

	private var data(default, set):SoundData;
	private var source:cpp.UInt32 = 0;

	public var looping(default, set):Bool;
	public var pitch(default, set):Float;
	public var gain(default, set):Float;

	public var time(get, set):Float;
	public var playing(get, set):Bool;
	public var keepOnSwitch:Bool = false;

	public var position(default, set):Vector3;
	public var velocity(default, set):Vector3;

	public function new(?filePath:String, autoPlay:Bool = false, looping:Bool = false, gain:Float = 1.0, pitch:Float = 1.0) {
		curSounds.push(this);
		AL.genSources(1, cpp.Pointer.addressOf(source));

		if (filePath != null)
			loadFromFile(filePath);

		this.position = new Vector3(1, 0, 0);
		this.velocity = new Vector3(0, 0, 0);
		this.pitch = pitch;
		this.gain = gain;
		this.looping = looping;

		if (autoPlay)
			play();
	}

	public function loadFromFile(filePath:String):Sound {
		data = SoundData.getCachedSound(filePath);
		if (data != null)
			AL.sourcei(source, AL.BUFFER, data.buffer);

		return this;
	}

	public function play(resetTime:Bool = false):Sound {
		if (resetTime)
			time = 0;

		if (source != 0) 
			AL.sourcePlay(source);

		return this;
	}

	public function stop(resetTime:Bool = false):Sound {
		if (source != 0) 
			AL.sourceStop(source);

		if (resetTime)
			time = 0;

		return this;
	}

	public function pause():Sound {
		if (source != 0)
			AL.sourcePause(source);

		return this;
	}

	public function destroy():Void {
		stop();

		if (source != 0)
			AL.deleteSources(1, cpp.Pointer.addressOf(source));

		data = null;
		curSounds.remove(this);
	}

	private function set_data(newData:SoundData) {
		if (data != null) data.useCount--;
		if (newData != null) newData.useCount++;
		return data = newData;
	}

	private function set_looping(value:Bool):Bool {
		if (source != 0)
			AL.sourcei(source, AL.LOOPING, value ? AL.TRUE : AL.FALSE);

		return looping = value;
	}

	private function set_pitch(value:Float):Float {
		if (source != 0)
			AL.sourcef(source, AL.PITCH, value);

		return pitch = value;
	}

	private function set_gain(value:Float):Float {
		if (source != 0)
			AL.sourcef(source, AL.GAIN, value);

		return gain = value;
	}

	private function get_time():Float {
		var _time:Single = 0;

		if (source != 0) 
			AL.getSourcef(source, AL.SEC_OFFSET, cpp.Pointer.addressOf(_time));

		return _time;
	}

	private function set_time(value:Float):Float {
		if (source != 0) 
			AL.sourcef(source, AL.SEC_OFFSET, value);

		return time;
	}

	private function get_playing():Bool {
		var state:Int = 0;

		if (source != 0) 
			AL.getSourcei(source, AL.SOURCE_STATE, cpp.Pointer.addressOf(state));

		return state == AL.PLAYING;
	}

	private function set_playing(value:Bool):Bool {
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

	public static function clearSounds() {
		var i:Int = 0; // So I have more control over the iterator. (Removing stuff can mess up for loops.)
		while (i < curSounds.length) {
			if (curSounds[i].keepOnSwitch)
				i++;
			else
				curSounds[i].destroy();
		}
	}
}
