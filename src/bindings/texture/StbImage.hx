package bindings.texture;

import cpp.CastCharStar;
import cpp.ConstCharStar;
import cpp.RawPointer;
import cpp.Callable;
import cpp.Star;
import cpp.FILE;

@:include("texture/stb_image.h")
@:native("stbi__context")
@:structAccess
extern class StbiContextStruct {
    var img_x:cpp.UInt32;
    var img_y:cpp.UInt32;
    var img_n:Int;
    var img_out_n:Int;

    var io:StbiIoCallbacks;
    var io_user_data:RawPointer<cpp.Void>;

    var read_from_callbacks:Int;
    var buflen:Int;
    var buffer_start:RawPointer<cpp.UInt32>;
    var callback_already_read:Int;

    var img_buffer:RawPointer<cpp.UInt32>;
    var img_buffer_end:RawPointer<cpp.UInt32>;
    var img_buffer_original:RawPointer<cpp.UInt32>;
    var img_buffer_original_end:RawPointer<cpp.UInt32>;
}
typedef StbiContext = cpp.RawPointer<StbiContextStruct>;

@:include("texture/stb_image.h")
@:native("stbi_io_callbacks")
@:structAccess
extern class StbiIoCallbacksStruct {
    var read:Callable<(user:RawPointer<cpp.Void>, data:RawPointer<cpp.Char>, size:Int) -> Int>;
    var skip:Callable<(user:RawPointer<cpp.Void>, n:Int) -> Void>;
    var eof:Callable<(user:RawPointer<cpp.Void>) -> Int>;
}
typedef StbiIoCallbacks = cpp.Struct<StbiIoCallbacksStruct>;

typedef UChar = cpp.UInt8; //Prevents confusion.
typedef UShort = cpp.UInt16;

@:include("texture/stb_image.h")
extern class StbImage {
    @:native("stbi_load_from_memory")
    static function loadFromMemory(buffer:RawPointer<UChar>, length:Int, x:RawPointer<Int>, y:RawPointer<Int>, channelsInFile:RawPointer<Int>, desiredChannels:Int):RawPointer<UChar>;

    @:native("stbi_load_from_callbacks")
    static function loadFromCallbacks(callbacks:RawPointer<StbiIoCallbacks>, user:RawPointer<cpp.Void>, x:RawPointer<Int>, y:RawPointer<Int>, channelsInFile:RawPointer<Int>, desiredChannels:Int):RawPointer<UChar>;

    @:native("stbi_load")
    static function load(fileName:ConstCharStar, x:RawPointer<Int>, y:RawPointer<Int>, channelsInFile:RawPointer<Int>, desiredChannels:Int):RawPointer<UChar>;

    @:native("stbi_load_from_file")
    static function loadFromFile(file:FILE, x:RawPointer<Int>, y:RawPointer<Int>, channelsInFile:RawPointer<Int>, desiredChannels:Int):RawPointer<UChar>;

    @:native("stbi_load_gif_from_memory")
    static function loadGifFromMemory(buffer:RawPointer<UChar>, length:Int, delays:RawPointer<Star<Int>>, x:RawPointer<Int>, y:RawPointer<Int>, z:RawPointer<Int>, comp:RawPointer<Int>, reqComp:Int):RawPointer<UChar>;

    /* im totally not lazy.
    #ifdef STBI_WINDOWS_UTF8
    STBIDEF int stbi_convert_wchar_to_utf8(char *buffer, size_t bufferlen, const wchar_t* input);
    #endif
    */

    @:native("stbi_load_16_from_memory")
    static function load16FromMemory(buffer:RawPointer<UChar>, length:Int, x:RawPointer<Int>, y:RawPointer<Int>, channelsInFile:RawPointer<Int>, desiredChannels:Int):RawPointer<UShort>;

    @:native("stbi_load_16_from_callbacks")
    static function load16FromCallbacks(callbacks:RawPointer<StbiIoCallbacks>, user:RawPointer<cpp.Void>, x:RawPointer<Int>, y:RawPointer<Int>, channelsInFile:RawPointer<Int>, desiredChannels:Int):RawPointer<UShort>;

    @:native("stbi_load_16")
    static function load16(fileName:ConstCharStar, x:RawPointer<Int>, y:RawPointer<Int>, channelsInFile:RawPointer<Int>, desiredChannels:Int):RawPointer<UShort>;

    @:native("stbi_load_from_file_16")
    static function load16FromFile(file:FILE, x:RawPointer<Int>, y:RawPointer<Int>, channelsInFile:RawPointer<Int>, desiredChannels:Int):RawPointer<UShort>;

    @:native("stbi_loadf_from_memory")
    static function loadFloatFromMemory(buffer:RawPointer<UChar>, length:Int, x:RawPointer<Int>, y:RawPointer<Int>, channelsInFile:RawPointer<Int>, desiredChannels:Int):Float;

    @:native("stbi_loadf_from_callbacks")
    static function loadFloatFromCallbacks(callbacks:RawPointer<StbiIoCallbacks>, user:RawPointer<cpp.Void>, x:RawPointer<Int>, y:RawPointer<Int>, channelsInFile:RawPointer<Int>, desiredChannels:Int):Float;

    @:native("stbi_loadf")
    static function loadFloat(fileName:ConstCharStar, x:RawPointer<Int>, y:RawPointer<Int>, channelsInFile:RawPointer<Int>, desiredChannels:Int):Float;

    @:native("stbi_loadf_from_file")
    static function loadFloatFromFile(file:FILE, x:RawPointer<Int>, y:RawPointer<Int>, channelsInFile:RawPointer<Int>, desiredChannels:Int):Float;

    @:native("stbi_hdr_to_ldr_gamma")
    static function hdrToLdrGamma(gamma:Float):Void;

    @:native("stbi_hdr_to_ldr_scale")
    static function hdrToLdrScale(scale:Float):Void;

    @:native("stbi_ldr_to_hdr_gamma")
    static function ldrToHdrGamma(gamma:Float):Void;

    @:native("stbi_ldr_to_hdr_scale")
    static function ldrToHdrScale(scale:Float):Void;

    @:native("stbi_is_hdr_from_memory")
    static function _isHdrFromMemory(buffer:RawPointer<UChar>, length:Int):Int;
    static inline function isHdrFromMemory(buffer:RawPointer<UChar>, length:Int):Bool
        return _isHdrFromMemory(buffer, length) != 0;   

    @:native("stbi_is_hdr_from_callbacks")
    static function _isHdrFromCallbacks(callbacks:RawPointer<StbiIoCallbacks>, user:RawPointer<cpp.Void>):Int;
    static inline function isHdrFromCallbacks(callbacks:RawPointer<StbiIoCallbacks>, user:RawPointer<cpp.Void>):Bool
        return _isHdrFromCallbacks(callbacks, user) != 0;   

    @:native("stbi_is_hdr")
    static function _isHdr(fileName:ConstCharStar):Int;
    static inline function isHdr(fileName:String):Bool
        return _isHdr(ConstCharStar.fromString(fileName)) != 0;

    @:native("stbi_is_hdr_from_file")
    static function _isHdrFromFile(file:FILE):Int;
    static inline function isHdrFromFile(file:FILE):Bool
        return _isHdrFromFile(file) != 0;   

    @:native("stbi_failure_reason")
    static function failureReason():ConstCharStar;

    inline static function freeImage(retvalFromLoad:Any):Void {
        untyped __cpp__("stbi_image_free({0})", retvalFromLoad);
    }

    @:native("stbi_info_from_memory")
    static function infoFromMemory(buffer:RawPointer<UChar>, length:Int, x:RawPointer<Int>, y:RawPointer<Int>, comp:RawPointer<Int>):Int;

    @:native("stbi_info_from_callbacks")
    static function infoFromCallbacks(callbacks:RawPointer<StbiIoCallbacks>, user:RawPointer<cpp.Void>, x:RawPointer<Int>, y:RawPointer<Int>, comp:RawPointer<Int>):Int;

    @:native("stbi_info")
    static function info(fileName:ConstCharStar, x:RawPointer<Int>, y:RawPointer<Int>, comp:RawPointer<Int>):Int;

    @:native("stbi_info_from_file")
    static function infoFromFile(file:FILE, x:RawPointer<Int>, y:RawPointer<Int>, comp:RawPointer<Int>):Int;

    @:native("stbi_is_16_bit_from_memory")
    static function _is16BitFromMemory(buffer:RawPointer<UChar>, length:Int):Int;
    static inline function is16BitFromMemory(buffer:RawPointer<UChar>, length:Int):Bool
        return _is16BitFromMemory(buffer, length) != 0;

    @:native("stbi_is_16_bit_from_callbacks")
    static function _is16BitFromCallbacks(callbacks:RawPointer<StbiIoCallbacks>, user:RawPointer<cpp.Void>):Int;
    static inline function is16BitFromCallbacks(callbacks:RawPointer<StbiIoCallbacks>, user:RawPointer<cpp.Void>):Bool
        return _is16BitFromCallbacks(callbacks, user) != 0;

    @:native("stbi_is_16_bit")
    static function _is16Bit(fileName:ConstCharStar):Int;
    static inline function is16Bit(fileName:String):Bool
        return _is16Bit(ConstCharStar.fromString(fileName)) != 0;

    @:native("stbi_is_16_bit_from_file")
    static function _is16BitFromFile(file:FILE):Int;
    static inline function is16BitFromFile(file:FILE):Bool
        return _is16BitFromFile(file) != 0;

    @:native("stbi_set_unpremultiply_on_load")
    static function setUnpremultiplyOnLoad(shouldUnpremultiply:Int):Void;

    @:native("stbi_convert_iphone_png_to_rgb")
    static function convertIphonePngToRgb(shouldConvert:Int):Void;

    @:native("stbi_set_flip_vertically_on_load")
    static function setFlipVerticallyOnLoad(shouldFlip:Int):Void;

    @:native("stbi_set_unpremultiply_on_load_thread")
    static function setUnpremultiplyOnLoadThread(shouldUnpremultiply:Int):Void;

    @:native("stbi_convert_iphone_png_to_rgb_thread")
    static function convertIphonePngToRgbThread(shouldConvert:Int):Void;

    @:native("stbi_set_flip_vertically_on_load_thread")
    static function setFlipVerticallyOnLoadThread(shouldFlip:Int):Void;

    @:native("stbi_zlib_decode_malloc_guesssize")
    static function zlibDecodeMallocGuessSize(buffer:ConstCharStar, length:Int, initialSize:Int, outLength:RawPointer<Int>):CastCharStar;

    @:native("stbi_zlib_decode_malloc_guesssize_headerflag")
    static function zlibDecodeMallocGuessSizeHeaderFlag(buffer:ConstCharStar, length:Int, initialSize:Int, outLength:RawPointer<Int>, parseHeader:Int):CastCharStar;

    @:native("stbi_zlib_decode_malloc")
    static function zlibDecodeMalloc(buffer:ConstCharStar, length:Int, outLength:RawPointer<Int>):CastCharStar;

    @:native("stbi_zlib_decode_buffer")
    static function zlibDecodeBuffer(oBuffer:CastCharStar, oLen:Int, iBuffer:ConstCharStar, iLen:Int):Int;

    @:native("stbi_zlib_decode_noheader_malloc")
    static function zlibDecodeNoHeaderMalloc(buffer:ConstCharStar, length:Int, outLength:RawPointer<Int>):CastCharStar;

    @:native("stbi_zlib_decode_noheader_buffer")
    static function zlibDecodeNoHeaderBuffer(oBuffer:CastCharStar, oLen:Int, iBuffer:ConstCharStar, iLen:Int):Int;
}