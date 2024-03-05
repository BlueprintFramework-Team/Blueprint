package bindings.audio;

/**
 * Bindings for `include/AL/alc.h`.
 * @author Leather128
 */
@:include('AL/alc.h')
extern class ALC {
	// defines //
	static inline final FREQUENCY:Int = 0x1007;
	static inline final REFRESH:Int = 0x1008;
	static inline final SYNC:Int = 0x1009;
	static inline final MONO_SOURCES:Int = 0x1010;
	static inline final STEREO_SOURCES:Int = 0x1011;
	static inline final NO_ERROR:Int = 0;
	static inline final INVALID_DEVICE:Int = 0xA001;
	static inline final INVALID_CONTEXT:Int = 0xA002;
	static inline final INVALID_ENUM:Int = 0xA003;
	static inline final INVALID_VALUE:Int = 0xA004;
	static inline final OUT_OF_MEMORY:Int = 0xA005;
	static inline final MAJOR_VERSION:Int = 0x1000;
	static inline final MINOR_VERSION:Int = 0x1001;
	static inline final ATTRIBUTES_SIZE:Int = 0x1002;
	static inline final ALL_ATTRIBUTES:Int = 0x1003;
	static inline final DEFAULT_DEVICE_SPECIFIER:Int = 0x1004;
	static inline final DEVICE_SPECIFIER:Int = 0x1005;
	static inline final EXTENSIONS:Int = 0x1006;
	static inline final EXT_CAPTURE:Int = 1;
	static inline final CAPTURE_DEVICE_SPECIFIER:Int = 0x310;
	static inline final CAPTURE_DEFAULT_DEVICE_SPECIFIER:Int = 0x311;
	static inline final CAPTURE_SAMPLES:Int = 0x312;
	static inline final ENUMERATE_ALL_EXT:Int = 1;
	static inline final DEFAULT_ALL_DEVICES_SPECIFIER:Int = 0x1012;
	static inline final ALL_DEVICES_SPECIFIER:Int = 0x1013;

	// functions //
	@:native('alcOpenDevice')
	static function openDevice(?deviceName:cpp.ConstCharStar):Device;

	@:native('alcCloseDevice')
	static function closeDevice(device:Device):Bool;

	@:native('alcCreateContext')
	static function createContext(device:Device, ?attributeList:Int):Context;

	@:native('alcMakeContextCurrent')
	static function makeContextCurrent(context:Context):Bool;

	@:native('alcProcessContext')
	static function processContext(context:Context):Void;

	@:native('alcSuspendContext')
	static function suspendContext(context:Context):Void;

	@:native('alcDestroyContext')
	static function destroyContext(context:Context):Void;

	@:native('alcGetCurrentContext')
	static function getCurrentContext():Context;

	@:native('alcGetContextsDevice')
	static function getContextsDevice(context:Context):Device;

	@:native('alcGetError')
	static function getError(device:Device):Int;

	@:native('alcIsExtensionPresent')
	static function isExtensionPresent(device:Device, extension:cpp.ConstCharStar):Bool;

	@:native('alcGetProcAddress')
	static function getProcAddress(device:Device, func:cpp.ConstCharStar):Any;

	@:native('alcGetEnumValue')
	static function getEnumValue(device:Device, enumName:cpp.ConstCharStar):Int;

	@:native('alcGetString')
	static function getString(device:Device, parameter:Int):cpp.ConstCharStar;

	@:native('alcGetIntegerv')
	static function getIntegerv(device:Device, parameter:Int, size:Int, ?values:cpp.RawPointer<Int>):Void;

	@:native('alcCaptureOpenDevice')
	static function captureOpenDevice(deviceName:cpp.ConstCharStar, frequency:UInt, format:Int, bufferSize:Int):Device;

	@:native('alcCaptureCloseDevice')
	static function captureCloseDevice(device:Device):Bool;

	@:native('alcCaptureStart')
	static function captureStart(device:Device):Void;

	@:native('alcCaptureStop')
	static function captureStop(device:Device):Void;

	@:native('alcCaptureSamples')
	static function captureSamples(device:Device, buffer:Any, samples:Int):Void;
}

@:native('ALCdevice')
@:include('AL/alc.h')
@:structAccess
extern class ALCdevice {}

@:native('ALCcontext')
@:include('AL/alc.h')
@:structAccess
extern class ALCcontext {}

typedef Device = cpp.RawPointer<ALCdevice>;
typedef Context = cpp.RawPointer<ALCcontext>;
