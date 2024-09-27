package bindings.freetype;

import cpp.RawPointer;
import bindings.freetype.Freetype;
import bindings.freetype.FreetypeGlyph;

// ok real talk why does ftimage feel like a buncha misc functions that should be in another header
// theres outline funcs, glyph formats, FUN FACT, THERES MATRICES AND VECTORS IN THAT HEADER.
@:include("freetype/ftimage.h")
@:native("FT_Bitmap")
@:structAccess
extern class FTBitmap {
    @:native("rows")
    var rows:cpp.UInt32;
    @:native("width")
    var width:cpp.UInt32;
    @:native("pitch")
    var pitch:Int;
    @:native("buffer")
    var buffer:RawPointer<cpp.UInt8>;
    @:native("num_grays")
    var numGrays:cpp.UInt16;
    @:native("pixel_mode")
    var pixelMode:cpp.UInt8;
    @:native("palette_mode")
    var paletteMode:cpp.UInt8;
    @:native("palette")
    var palette:RawPointer<cpp.Void>;
}
typedef FTBitmapPtr = RawPointer<FTBitmap>;

@:include("freetype/freetype.h")
@:native("FT_Bitmap_Size")
extern class FTBitmapSize {
    @:native("width")
    var width:cpp.Int16;
    @:native("height")
    var height:cpp.Int16;

    @:native("size")
    var size:cpp.UInt64;

    @:native("x_ppem")
    var xPpem:cpp.UInt64;
    @:native("y_ppem")
    var yPpem:cpp.UInt64;
}

@:include("freetype/ftcolor.h")
@:native("FT_Color")
extern class FTColor {
    var red:cpp.UInt8;
    var green:cpp.UInt8;
    var blue:cpp.UInt8;
    var alpha:cpp.UInt8;
}

@:include("freetype/ftbitmap.h")
extern class FreetypeBitmap {
    @:native("FT_Bitmap_Init")
    static function init(bitmap:FTBitmapPtr):Void;

    @:native("FT_Bitmap_Bopy")
    static function copy(lib:FTLibrary, source:FTBitmapPtr, target:FTBitmapPtr):FTErr;

    @:native("FT_Bitmap_Embolden")
    static function embolden(lib:FTLibrary, bitmap:FTBitmapPtr, xStrength:cpp.Int64, yStrength:cpp.Int64):FTErr;

    @:native("FT_Bitmap_Convert")
    static function convert(lib:FTLibrary, source:FTBitmapPtr, target:FTBitmapPtr, alignment:Int):FTErr;

    @:native("FT_Bitmap_Blend")
    static function blend(lib:FTLibrary, source:FTBitmapPtr, sourceOffset:FTVector, target:FTBitmapPtr, targetOffset:FTVector, color:FTColor):FTErr;

    @:native("FT_GlyphSlot_Own_Bitmap")
    static function glyphSlotOwnBitmap(slot:FTGlyphSlot):FTErr;

    @:native("FT_Bitmap_Done")
    static function done(lib:FTLibrary, bitmap:FTBitmapPtr):FTErr;
}