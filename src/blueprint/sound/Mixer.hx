package blueprint.sound;

import bindings.audio.AL;
import bindings.audio.ALC;

import math.Vector3;

// WARNING: This class may not work with multiple instances, so I'd recommend only using one for now.
// - Midnight
class Mixer {
	public var failed:Bool = false;

	public var device:Device;
	public var context:Context;

	public var position(default, set):Vector3 = new Vector3();
	public var velocity(default, set):Vector3 = new Vector3();
	public var orientation(default, set):Array<Single>;

	public var gain(default, set):Single;

	private function set_position(value:Vector3):Vector3 {
		AL.listener3f(AL.POSITION, value.x, value.y, value.z);
		return position.copyFrom(value);
	}

	private function set_velocity(value:Vector3):Vector3 {
		AL.listener3f(AL.VELOCITY, value.x, value.y, value.z);
		return velocity.copyFrom(value);
	}

	private function set_orientation(value:Array<Single>):Array<Single> {
		AL.listenerfv(AL.ORIENTATION, cpp.Pointer.arrayElem(value, 0).raw);
		return orientation = value;
	}

	private function set_gain(value:Single):Single {
		AL.listenerf(AL.GAIN, value);
		return gain = value;
	}

	public function new() {
		var defaultDevice:String = ALC.getString(null, ALC.DEFAULT_DEVICE_SPECIFIER);
		device = ALC.openDevice(defaultDevice);

		if (device == null) {
			trace('Failed to open an OpenAL device.');
			failed = true;
			return;
		}

		context = ALC.createContext(device, null);

		if (!ALC.makeContextCurrent(context)) {
			trace('Failed to create OpenAL context.');
			failed = true;
			return;
		}

		var error:Int = AL.getError();

		if (error != AL.NO_ERROR) {
			trace('Failed to make OpenAL context current. Error: ${error}');
			failed = true;
			return;
		}

		position = position.setFull(0, 0, 0);
		velocity = velocity.setFull(0, 0, 0);

		orientation = [
			1, 0, 0,
			0, 1, 0,
		];

		gain = 1.0;
	}

	public function destroy():Void {
		ALC.makeContextCurrent(null);
		ALC.destroyContext(context);
		ALC.closeDevice(device);

		device = null;
		context = null;
	}
}
