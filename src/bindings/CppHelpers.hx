package bindings;

/**
 * Helpers for C++ things you can't do in Haxe.
 */
extern class CppHelpers {
    inline static function sizeOf(value:Dynamic):cpp.UInt64 {
        return untyped __cpp__("sizeof({0})", value);
    }

    inline static function tempPointer(value:Dynamic):Dynamic {
        return untyped __cpp__("&{0}", value);
    }

    inline static function traceChar(toTrace:cpp.Star<cpp.Char>):Void {
        return untyped __cpp__('printf({0}, "\\n")', toTrace);
    }
}