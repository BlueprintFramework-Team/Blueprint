package bindings.texture;

import cpp.Char;
import cpp.ConstCharStar;
import cpp.Pointer;
import cpp.ConstPointer;
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
    var io_user_data:Star<cpp.Void>;

    var read_from_callbacks:Int;
    var buflen:Int;
    var buffer_start:Star<cpp.UInt32>;
    var callback_already_read:Int;

    var img_buffer:Star<cpp.UInt32>;
    var img_buffer_end:Star<cpp.UInt32>;
    var img_buffer_original:Star<cpp.UInt32>;
    var img_buffer_original_end:Star<cpp.UInt32>;
}
typedef StbiContext = cpp.RawPointer<StbiContextStruct>;

@:include("texture/stb_image.h")
@:native("stbi_io_callbacks")
@:structAccess
extern class StbiIoCallbacksStruct {
    var read:Callable<(user:Star<cpp.Void>, data:Star<cpp.Char>, size:Int) -> Int>;
    var skip:Callable<(user:Star<cpp.Void>, n:Int) -> Void>;
    var eof:Callable<(user:Star<cpp.Void>) -> Int>;
}
typedef StbiIoCallbacks = cpp.Struct<StbiIoCallbacksStruct>;

typedef UChar = cpp.UInt8; //Prevents confusion.
typedef UShort = cpp.UInt16;

@:include("texture/stb_image.h")
extern class StbImage {
    @:native("stbi_load_from_memory")
    static function loadFromMemory(buffer:ConstPointer<UChar>, length:Int, x:Pointer<Int>, y:Pointer<Int>, channelsInFile:Pointer<Int>, desiredChannels:Int):Star<UChar>;

    @:native("stbi_load_from_callbacks")
    static function loadFromCallbacks(callbacks:ConstPointer<StbiIoCallbacks>, user:Star<cpp.Void>, x:Pointer<Int>, y:Pointer<Int>, channelsInFile:Pointer<Int>, desiredChannels:Int):Star<UChar>;

    @:native("stbi_load")
    static function load(fileName:ConstCharStar, x:Pointer<Int>, y:Pointer<Int>, channelsInFile:Pointer<Int>, desiredChannels:Int):Star<UChar>;

    @:native("stbi_load_from_file")
    static function loadFromFile(file:FILE, x:Pointer<Int>, y:Pointer<Int>, channelsInFile:Pointer<Int>, desiredChannels:Int):Star<UChar>;

    @:native("stbi_load_gif_from_memory")
    static function loadGifFromMemory(buffer:ConstPointer<UChar>, length:Int, delays:Pointer<Star<Int>>, x:Pointer<Int>, y:Pointer<Int>, z:Pointer<Int>, comp:Pointer<Int>, reqComp:Int):Star<UChar>;

    /* im totally not lazy.
    #ifdef STBI_WINDOWS_UTF8
    STBIDEF int stbi_convert_wchar_to_utf8(char *buffer, size_t bufferlen, const wchar_t* input);
    #endif
    */

    @:native("stbi_load_16_from_memory")
    static function load16FromMemory(buffer:ConstPointer<UChar>, length:Int, x:Pointer<Int>, y:Pointer<Int>, channelsInFile:Pointer<Int>, desiredChannels:Int):Star<UShort>;

    @:native("stbi_load_16_from_callbacks")
    static function load16FromCallbacks(callbacks:ConstPointer<StbiIoCallbacks>, user:Star<cpp.Void>, x:Pointer<Int>, y:Pointer<Int>, channelsInFile:Pointer<Int>, desiredChannels:Int):Star<UShort>;

    @:native("stbi_load_16")
    static function load16(fileName:ConstCharStar, x:Pointer<Int>, y:Pointer<Int>, channelsInFile:Pointer<Int>, desiredChannels:Int):Star<UShort>;

    @:native("stbi_load_from_file_16")
    static function load16FromFile(file:FILE, x:Pointer<Int>, y:Pointer<Int>, channelsInFile:Pointer<Int>, desiredChannels:Int):Star<UShort>;

    @:native("stbi_loadf_from_memory")
    static function loadFloatFromMemory(buffer:ConstPointer<UChar>, length:Int, x:Pointer<Int>, y:Pointer<Int>, channelsInFile:Pointer<Int>, desiredChannels:Int):Float;

    @:native("stbi_loadf_from_callbacks")
    static function loadFloatFromCallbacks(callbacks:ConstPointer<StbiIoCallbacks>, user:Star<cpp.Void>, x:Pointer<Int>, y:Pointer<Int>, channelsInFile:Pointer<Int>, desiredChannels:Int):Float;

    @:native("stbi_loadf")
    static function loadFloat(fileName:ConstCharStar, x:Pointer<Int>, y:Pointer<Int>, channelsInFile:Pointer<Int>, desiredChannels:Int):Float;

    @:native("stbi_loadf_from_file")
    static function loadFloatFromFile(file:FILE, x:Pointer<Int>, y:Pointer<Int>, channelsInFile:Pointer<Int>, desiredChannels:Int):Float;

    @:native("stbi_hdr_to_ldr_gamma")
    static function hdrToLdrGamma(gamma:Float):Void;

    @:native("stbi_hdr_to_ldr_scale")
    static function hdrToLdrScale(scale:Float):Void;

    @:native("stbi_ldr_to_hdr_gamma")
    static function ldrToHdrGamma(gamma:Float):Void;

    @:native("stbi_ldr_to_hdr_scale")
    static function ldrToHdrScale(scale:Float):Void;

    @:native("stbi_is_hdr_from_memory")
    static function _isHdrFromMemory(buffer:ConstPointer<UChar>, length:Int):Int;
    static inline function isHdrFromMemory(buffer:ConstPointer<UChar>, length:Int):Bool
        return _isHdrFromMemory(buffer, length) != 0;   

    @:native("stbi_is_hdr_from_callbacks")
    static function _isHdrFromCallbacks(callbacks:ConstPointer<StbiIoCallbacks>, user:Star<cpp.Void>):Int;
    static inline function isHdrFromCallbacks(callbacks:ConstPointer<StbiIoCallbacks>, user:Star<cpp.Void>):Bool
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
    static function infoFromMemory(buffer:ConstPointer<UChar>, length:Int, x:Pointer<Int>, y:Pointer<Int>, comp:Pointer<Int>):Int;

    @:native("stbi_info_from_callbacks")
    static function infoFromCallbacks(callbacks:ConstPointer<StbiIoCallbacks>, user:Star<cpp.Void>, x:Pointer<Int>, y:Pointer<Int>, comp:Pointer<Int>):Int;

    @:native("stbi_info")
    static function info(fileName:ConstCharStar, x:Pointer<Int>, y:Pointer<Int>, comp:Pointer<Int>):Int;

    @:native("stbi_info_from_file")
    static function infoFromFile(file:FILE, x:Pointer<Int>, y:Pointer<Int>, comp:Pointer<Int>):Int;

    @:native("stbi_is_16_bit_from_memory")
    static function _is16BitFromMemory(buffer:ConstPointer<UChar>, length:Int):Int;
    static inline function is16BitFromMemory(buffer:ConstPointer<UChar>, length:Int):Bool
        return _is16BitFromMemory(buffer, length) != 0;

    @:native("stbi_is_16_bit_from_callbacks")
    static function _is16BitFromCallbacks(callbacks:ConstPointer<StbiIoCallbacks>, user:Star<cpp.Void>):Int;
    static inline function is16BitFromCallbacks(callbacks:ConstPointer<StbiIoCallbacks>, user:Star<cpp.Void>):Bool
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
    static function zlibDecodeMallocGuessSize(buffer:ConstCharStar, length:Int, initialSize:Int, outLength:Pointer<Int>):Star<Char>;

    @:native("stbi_zlib_decode_malloc_guesssize_headerflag")
    static function zlibDecodeMallocGuessSizeHeaderFlag(buffer:ConstCharStar, length:Int, initialSize:Int, outLength:Pointer<Int>, parseHeader:Int):Star<Char>;

    @:native("stbi_zlib_decode_malloc")
    static function zlibDecodeMalloc(buffer:ConstCharStar, length:Int, outLength:Pointer<Int>):Star<Char>;

    @:native("stbi_zlib_decode_buffer")
    static function zlibDecodeBuffer(oBuffer:Star<Char>, oLen:Int, iBuffer:ConstCharStar, iLen:Int):Int;

    @:native("stbi_zlib_decode_noheader_malloc")
    static function zlibDecodeNoHeaderMalloc(buffer:ConstCharStar, length:Int, outLength:Pointer<Int>):Star<Char>;

    @:native("stbi_zlib_decode_noheader_buffer")
    static function zlibDecodeNoHeaderBuffer(oBuffer:Star<Char>, oLen:Int, iBuffer:ConstCharStar, iLen:Int):Int;
}