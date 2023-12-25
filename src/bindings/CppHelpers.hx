package bindings;

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

	inline static function tempPointer(value:Any) {
		return untyped __cpp__("&{0}", value);
	}

	//@:native("printf")
	inline static function nativeTrace(toTrace:ConstCharStar, formatParams:cpp.Rest<Any>):Void {
		return untyped __cpp__("printf({0}, {1})", toTrace, formatParams);
	}

	inline static function free(pointer:Any):Void {
		return untyped __cpp__('free({0})', pointer);
	}
}
