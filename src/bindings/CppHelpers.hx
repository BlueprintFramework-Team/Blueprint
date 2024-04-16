package bindings;

import cpp.RawPointer;
import cpp.ConstCharStar;

/**
 * Helpers for C++ things you can't do in Haxe.
 */
@:include('stdio.h')
extern class CppHelpers {
	inline static function sizeOf(value:Any):cpp.UInt64 {
		return untyped __cpp__("sizeof({0})", value);
	}

	inline static function malloc<T>(count:Int, starClass:Any):T {
		return cast untyped __cpp__("malloc({0} * sizeof({1}))", count, starClass);
	}

	/**
	 * Create a c pointer in a haxe file.
	 * RECOMMENDED FOR VARIABLES INSIDE FUNCTIONS!
	 * @param value The value to point to.
	 * @return RawPointer<T>
	 */
	inline static function makePointer<T>(value:T):RawPointer<T> {
		return untyped __cpp__("&{0}", value);
	}

	inline static function boolToInt(bool:Bool):Int {
		return untyped __cpp__("{0}", bool);
	}

	//@:native("printf")
	inline static function nativeTrace(toTrace:ConstCharStar, formatParams:cpp.Rest<Any>):Void {
		return untyped __cpp__("printf({0}, {1})", toTrace, formatParams);
	}

	inline static function free<T>(pointer:T):Void {
		return untyped __cpp__('free({0})', pointer);
	}
}
