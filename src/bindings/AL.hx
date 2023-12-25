package bindings;

/**
 * Bindings for `include/AL/al.h`.
 * @author Leather128
 */
@:include('AL/al.h')
extern class AL {
	// defines //
	static inline final NONE:Int = 0;
	static inline final FALSE:Int = 0;
	static inline final TRUE:Int = 1;
	static inline final SOURCE_RELATIVE:Int = 0x202;
	static inline final CONE_INNER_ANGLE:Int = 0x1001;
	static inline final CONE_OUTER_ANGLE:Int = 0x1002;
	static inline final PITCH:Int = 0x1003;
	static inline final POSITION:Int = 0x1004;
	static inline final DIRECTION:Int = 0x1005;
	static inline final VELOCITY:Int = 0x1006;
	static inline final LOOPING:Int = 0x1007;
	static inline final BUFFER:Int = 0x1009;
	static inline final GAIN:Int = 0x100A;
	static inline final MIN_GAIN:Int = 0x100D;
	static inline final MAX_GAIN:Int = 0x100E;
	static inline final ORIENTATION:Int = 0x100F;
	static inline final SOURCE_STATE:Int = 0x1010;
	static inline final INITIAL:Int = 0x1011;
	static inline final PLAYING:Int = 0x1012;
	static inline final PAUSED:Int = 0x1013;
	static inline final STOPPED:Int = 0x1014;
	static inline final BUFFERS_QUEUED:Int = 0x1015;
	static inline final BUFFERS_PROCESSED:Int = 0x1016;
	static inline final REFERENCE_DISTANCE:Int = 0x1020;
	static inline final ROLLOFF_FACTOR:Int = 0x1021;
	static inline final CONE_OUTER_GAIN:Int = 0x1022;
	static inline final MAX_DISTANCE:Int = 0x1023;
	static inline final SEC_OFFSET:Int = 0x1024;
	static inline final SAMPLE_OFFSET:Int = 0x1025;
	static inline final BYTE_OFFSET:Int = 0x1026;
	static inline final SOURCE_TYPE:Int = 0x1027;
	static inline final STATIC:Int = 0x1028;
	static inline final STREAMING:Int = 0x1029;
	static inline final UNDETERMINED:Int = 0x1030;
	static inline final FORMAT_MONO8:Int = 0x1100;
	static inline final FORMAT_MONO16:Int = 0x1101;
	static inline final FORMAT_STEREO8:Int = 0x1102;
	static inline final FORMAT_STEREO16:Int = 0x1103;
	static inline final FREQUENCY:Int = 0x2001;
	static inline final BITS:Int = 0x2002;
	static inline final CHANNELS:Int = 0x2003;
	static inline final SIZE:Int = 0x2004;
	static inline final UNUSED:Int = 0x2010;
	static inline final PENDING:Int = 0x2011;
	static inline final PROCESSED:Int = 0x2012;
	static inline final NO_ERROR:Int = 0;
	static inline final INVALID_NAME:Int = 0xA001;
	static inline final INVALID_ENUM:Int = 0xA002;
	static inline final INVALID_VALUE:Int = 0xA003;
	static inline final INVALID_OPERATION:Int = 0xA004;
	static inline final OUT_OF_MEMORY:Int = 0xA005;
	static inline final VENDOR:Int = 0xB001;
	static inline final VERSION:Int = 0xB002;
	static inline final RENDERER:Int = 0xB003;
	static inline final EXTENSIONS:Int = 0xB004;
	static inline final DOPPLER_FACTOR:Int = 0xC000;
	static inline final DOPPLER_VELOCITY:Int = 0xC001;
	static inline final SPEED_OF_SOUND:Int = 0xC003;
	static inline final DISTANCE_MODEL:Int = 0xD000;
	static inline final INVERSE_DISTANCE:Int = 0xD001;
	static inline final INVERSE_DISTANCE_CLAMPED:Int = 0xD002;
	static inline final LINEAR_DISTANCE:Int = 0xD003;
	static inline final LINEAR_DISTANCE_CLAMPED:Int = 0xD004;
	static inline final EXPONENT_DISTANCE:Int = 0xD005;
	static inline final EXPONENT_DISTANCE_CLAMPED:Int = 0xD006;

	// functions //
	@:native('alGetError')
	static function getError():Int;

	@:native('alEnable')
	static function enable(capability:Int):Void;

	@:native('alDisable')
	static function disable(capability:Int):Void;

	@:native('alIsEnabled')
	static function isEnabled(capability:Int):Bool;

	@:native('alDopplerFactor')
	static function dopplerFactor(value:Single):Void;

	@:native('alDopplerVelocity')
	static function dopplerVelocity(value:Single):Void;

	@:native('alSpeedOfSound')
	static function speedOfSound(value:Single):Void;

	@:native('alDistanceModel')
	static function distanceModel(distanceModel:Int):Void;

	@:native('alGetString')
	static function getString(parameter:Int):cpp.ConstCharStar;

	@:native('alGetBooleanv')
	static function getBooleanv(parameter:Int, value:cpp.Pointer<Bool>):Void;

	@:native('alGetIntegerv')
	static function getIntegerv(parameter:Int, value:cpp.Pointer<Int>):Void;

	@:native('alGetFloatv')
	static function getFloatv(parameter:Int, value:cpp.Pointer<Single>):Void;

	@:native('alGetDoublev')
	static function getDoublev(parameter:Int, value:cpp.Pointer<Double>):Void;

	@:native('alGetBoolean')
	static function getBoolean(parameter:Int):Bool;

	@:native('alGetInteger')
	static function getInteger(parameter:Int):Int;

	@:native('alGetFloat')
	static function getFloat(parameter:Int):Single;

	@:native('alGetDouble')
	static function getDouble(parameter:Int):Double;

	@:native('alIsExtensionPresent')
	static function isExtensionPresent(extension:cpp.ConstCharStar):Bool;

	@:native('alGetProcAddress')
	static function getProcAddress(func:cpp.ConstCharStar):Any;

	@:native('alGetEnumValue')
	static function getEnumValue(enumName:cpp.ConstCharStar):Int;

	@:native('alListenerf')
	static function listenerf(parameter:Int, value:Single):Void;

	@:native('alListener3f')
	static function listener3f(parameter:Int, value1:Single, value2:Single, value3:Single):Void;

	@:native('alListenerfv')
	static function listenerfv(parameter:Int, value:cpp.Pointer<Single>):Void;

	@:native('alListeneri')
	static function listeneri(parameter:Int, value:Int):Void;

	@:native('alListener3i')
	static function listener3i(parameter:Int, value1:Int, value2:Int, value3:Int):Void;

	@:native('alListeneriv')
	static function listeneriv(parameter:Int, value:cpp.Pointer<Any>):Void;

	@:native('alGetListenerf')
	static function getListenerf(parameter:Int, value:cpp.Pointer<Single>):Void;

	@:native('alGetListener3f')
	static function getListener3f(parameter:Int, value1:cpp.Pointer<Single>, value2:cpp.Pointer<Single>, value3:cpp.Pointer<Single>):Void;

	@:native('alGetListenerfv')
	static function getListenerfv(parameter:Int, values:cpp.Pointer<Single>):Void;

	@:native('alGetListeneri')
	static function getListeneri(parameter:Int, value:cpp.Pointer<Int>):Void;

	@:native('alGetListener3i')
	static function getListener3i(parameter:Int, value1:cpp.Pointer<Int>, value2:cpp.Pointer<Int>, value3:cpp.Pointer<Int>):Void;

	@:native('alGetListeneriv')
	static function getListeneriv(parameter:Int, values:cpp.Pointer<Array<Int>>):Void;

	@:native('alGenSources')
	static function genSources(n:Int, source:cpp.Pointer<cpp.UInt32>):Void;

	@:native('alDeleteSources')
	static function deleteSources(n:Int, source:cpp.Pointer<cpp.UInt32>):Void;

	@:native('alIsSource')
	static function isSource(source:cpp.UInt32):Bool;

	@:native('alSourcef')
	static function sourcef(source:cpp.UInt32, parameter:Int, value:Single):Void;

	@:native('alSource3f')
	static function source3f(source:cpp.UInt32, parameter:Int, value1:Single, value2:Single, value3:Single):Void;

	@:native('alSourcefv')
	static function sourcefv(source:cpp.UInt32, parameter:Int, values:cpp.Pointer<Array<Single>>):Void;

	@:native('alSourcei')
	static function sourcei(source:cpp.UInt32, parameter:Int, value:Int):Void;

	@:native('alSource3i')
	static function source3i(source:cpp.UInt32, parameter:Int, value1:Int, value2:Int, value3:Int):Void;

	@:native('alSourceiv')
	static function sourceiv(source:cpp.UInt32, parameter:Int, values:cpp.Pointer<Array<Int>>):Void;

	@:native('alGetSourcef')
	static function getSourcef(source:cpp.UInt32, parameter:Int, value:cpp.Pointer<Single>):Void;

	@:native('alGetSource3f')
	static function getSource3f(source:cpp.UInt32, parameter:Int, value1:cpp.Pointer<Single>, value2:cpp.Pointer<Single>, value3:cpp.Pointer<Single>):Void;

	@:native('alGetSourcefv')
	static function getSourcefv(source:cpp.UInt32, parameter:Int, values:cpp.Pointer<Array<Single>>):Void;

	@:native('alGetSourcei')
	static function getSourcei(source:cpp.UInt32, parameter:Int, value:cpp.Pointer<Int>):Void;

	@:native('alGetSource3i')
	static function getSource3i(source:cpp.UInt32, parameter:Int, value1:cpp.Pointer<Int>, value2:cpp.Pointer<Int>, value3:cpp.Pointer<Int>):Void;

	@:native('alGetSourceiv')
	static function getSourceiv(source:cpp.UInt32, parameter:Int, values:cpp.Pointer<Array<Int>>):Void;

	@:native('alSourcePlay')
	static function sourcePlay(source:cpp.UInt32):Void;

	@:native('alSourceStop')
	static function sourceStop(source:cpp.UInt32):Void;

	@:native('alSourceRewind')
	static function sourceRewind(source:cpp.UInt32):Void;

	@:native('alSourcePause')
	static function sourcePause(source:cpp.UInt32):Void;

	@:native('alSourcePlayv')
	static function sourcePlayv(n:Int, sources:cpp.Pointer<cpp.UInt32>):Void;

	@:native('alSourceStopv')
	static function sourceStopv(n:Int, sources:cpp.Pointer<cpp.UInt32>):Void;

	@:native('alSourceRewindv')
	static function sourceRewindv(n:Int, sources:cpp.Pointer<cpp.UInt32>):Void;

	@:native('alSourcePausev')
	static function sourcePausev(n:Int, sources:cpp.Pointer<cpp.UInt32>):Void;

	@:native('alSourceQueueBuffers')
	static function sourceQueueBuffers(source:cpp.UInt32, nb:Int, buffers:cpp.Pointer<cpp.UInt32>):Void;

	@:native('alSourceUnqueueBuffers')
	static function sourceUnqueueBuffers(source:cpp.UInt32, nb:Int, buffers:cpp.Pointer<cpp.UInt32>):Void;

	@:native('alGenBuffers')
	static function genBuffers(n:Int, buffer:cpp.Pointer<cpp.UInt32>):Void;

	@:native('alDeleteBuffers')
	static function deleteBuffers(n:Int, buffer:cpp.Pointer<cpp.UInt32>):Void;

	@:native('alIsBuffer')
	static function isBuffer(buffer:cpp.UInt32):Bool;

	inline static function bufferData(buffer:cpp.UInt32, format:Int, data:Any, size:cpp.UInt64, sampleRate:Int):Void {
		untyped __cpp__("alBufferData({0}, {1}, {2}, {3}, {4})", buffer, format, data, size, sampleRate);
	}

	@:native('alBufferf')
	static function bufferf(buffer:cpp.UInt32, parameter:Int, value:Single):Void;

	@:native('alBuffer3f')
	static function buffer3f(buffer:cpp.UInt32, parameter:Int, value1:Single, value2:Single, value3:Single):Void;

	@:native('alBufferfv')
	static function bufferfv(buffer:cpp.UInt32, parameter:Int, values:cpp.Pointer<Array<Single>>):Void;

	@:native('alBufferi')
	static function bufferi(buffer:cpp.UInt32, parameter:Int, value:Int):Void;

	@:native('alBuffer3i')
	static function buffer3i(buffer:cpp.UInt32, parameter:Int, value1:Int, value2:Int, value3:Int):Void;

	@:native('alBufferiv')
	static function bufferiv(buffer:cpp.UInt32, parameter:Int, values:cpp.Pointer<Array<Int>>):Void;

	@:native('alGetBufferf')
	static function getBufferf(buffer:cpp.UInt32, parameter:Int, value:cpp.Pointer<Single>):Void;

	@:native('alGetBuffer3f')
	static function getBuffer3f(buffer:cpp.UInt32, parameter:Int, value1:cpp.Pointer<Single>, value2:cpp.Pointer<Single>, value3:cpp.Pointer<Single>):Void;

	@:native('alGetBufferfv')
	static function getBufferfv(buffer:cpp.UInt32, parameter:Int, values:cpp.Pointer<Array<Single>>):Void;

	@:native('alGetBufferi')
	static function getBufferi(buffer:cpp.UInt32, parameter:Int, value:cpp.Pointer<Int>):Void;

	@:native('alGetBuffer3i')
	static function getBuffer3i(buffer:cpp.UInt32, parameter:Int, value1:cpp.Pointer<Int>, value2:cpp.Pointer<Int>, value3:cpp.Pointer<Int>):Void;

	@:native('alGetBufferiv')
	static function getBufferiv(buffer:cpp.UInt32, parameter:Int, values:cpp.Pointer<Array<Int>>):Void;
}

typedef Double = Float; // cpp.Float64;
