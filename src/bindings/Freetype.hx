package bindings;

import cpp.Star;
import cpp.ConstStar;
import cpp.ConstCharStar;
import cpp.Pointer;

typedef FTErr = Int;

@:include("freetype/ftimage.h")
@:native("FT_Generic")
@:structAccess
extern class FreetypeGeneric {}

@:include("freetype/ftimage.h")
@:native("FT_Library")
@:structAccess
extern class FreetypeLib {}

@:include("freetype/ftimage.h")
@:native("FT_Vector")
@:structAccess
extern class FreetypeVector {
    public var x:cpp.UInt64;
    public var y:cpp.UInt64;
}

@:include("freetype/fttypes.h")
@:native("FT_Matrix")
@:structAccess
extern class FreetypeMatrix {
    public var xx:cpp.UInt64;
    public var xy:cpp.UInt64;
    public var yx:cpp.UInt64;
    public var yy:cpp.UInt64;
}

@:include("freetype/fttypes.h")
@:native("FT_BBox")
@:structAccess
extern class FreetypeBBox {
    public var xMin:cpp.UInt64;
    public var yMin:cpp.UInt64;
    public var xMax:cpp.UInt64;
    public var yMax:cpp.UInt64;
}

@:include("freetype/freetype.h")
@:native("FT_Bitmap")
@:structAccess
extern class FreetypeBitmap {
    public var rows:cpp.UInt32;
    public var width:cpp.UInt32;
    public var pitch:Int;
    public var buffer:cpp.Star<cpp.UInt8>;
    public var num_grays:cpp.UInt16;
    public var pixel_mode:cpp.UInt8;
    public var palette_mode:cpp.UInt8;
    public var palette:cpp.Star<cpp.Void>;
}

@:include("freetype/freetype.h")
@:native("FT_Bitmap_Size")
@:structAccess
extern class FreetypeBitmapSize {
    public var width:cpp.Int16;
    public var height:cpp.Int16;

    public var size:cpp.UInt64;

    public var x_ppem:cpp.UInt64;
    public var y_ppem:cpp.UInt64;
}

@:include("freetype/fttypes.h")
@:native("FT_Size_Metrics")
@:structAccess
extern class FreetypeSizeMetrics {
    public var x_ppem:cpp.UInt16;
    public var y_ppem:cpp.UInt16;

    public var x_scale:cpp.Int64;
    public var y_scale:cpp.Int64;

    public var ascender:cpp.Int64;
    public var descender:cpp.Int64;
    public var height:cpp.Int64;
    public var max_advance:cpp.Int64;
}

@:include("freetype/fttypes.h")
@:native("FT_Size_Internal")
@:structAccess
extern class FreetypeSizeInternal {}

@:include("freetype/fttypes.h")
@:native("FT_Size")
@:structAccess
extern class FreetypeSize {
    public var face:FreetypeFace;
    public var generic:FreetypeGeneric;
    public var metrics:FreetypeSizeMetrics;
    public var internal:FreetypeSizeInternal;
}

@:include("freetype/freetype.h")
@:native("FT_Face")
@:structAccess
extern class FreetypeFace {
    public var num_faces:cpp.Int64;
    public var face_index:cpp.Int64;

    public var face_flags:cpp.Int64;
    public var style_flags:cpp.Int64;

    public var num_glyphs:cpp.Int64;

    public var family_name:Star<cpp.Char>;
    public var style_name:Star<cpp.Char>;

    public var num_fixed_sizes:Int;
    public var available_sizes:cpp.Star<FreetypeBitmapSize>;

    public var num_charmaps:Int;
    public var charmaps:cpp.Star<FreetypeCharMap>;

    public var generic:FreetypeGeneric;

    public var bbox:FreetypeBBox;

    public var units_per_EM:cpp.UInt16;
    public var ascender:cpp.Int16;
    public var descender:cpp.Int16;
    public var height:cpp.Int16;

    public var max_advance_width:cpp.Int16;
    public var max_advance_height:cpp.Int16;

    public var underline_position:cpp.Int16;
    public var underline_thickness:cpp.Int16;

    public var glyph:FreetypeGlyphSlot;
    public var size:FreetypeSize;
    public var charmap:FreetypeCharMap;
}

@:include("freetype/freetype.h")
@:native("FT_Glyph_Metrics")
@:structAccess
extern class FreetypeGlyphMetrics {
    public var width:cpp.UInt64;
    public var height:cpp.UInt64;

    public var horiBearingX:cpp.UInt64;
    public var horiBearingY:cpp.UInt64;
    public var horiAdvance:cpp.UInt64;

    public var vertBearingX:cpp.UInt64;
    public var vertBearingY:cpp.UInt64;
    public var vertAdvance:cpp.UInt64;
}

@:include("freetype/freetype.h")
@:native("FT_Glyph_Format")
enum FreetypeGlyphFormat {
    @:extern("FT_GLYPH_FORMAT_NONE")
    NONE;
    @:extern("FT_GLYPH_FORMAT_COMPOSITE")
    COMPOSITE;
    @:extern("FT_GLYPH_FORMAT_BITMAP")
    BITMAP;
    @:extern("FT_GLYPH_FORMAT_OUTLINE")
    OUTLINE;
    @:extern("FT_GLYPH_FORMAT_PLOTTER")
    PLOTTER;
    @:extern("FT_GLYPH_FORMAT_SVG")
    SVG;
}

@:include("freetype/freetype.h")
@:native("FT_Outline")
@:structAccess
extern class FreetypeOutline {
    public var n_contours:cpp.Int16;
    public var n_points:cpp.Int16;

    public var points:cpp.Star<FreetypeVector>;
    public var tags:cpp.CastCharStar;
    public var contours:cpp.Star<cpp.Int16>;

    public var flags:Int;
}

@:include("freetype/freetype.h")
@:native("FT_SubGlyph")
@:structAccess
extern class FreetypeSubGlyph {}

@:include("freetype/freetype.h")
@:native("FT_Slot_Internal")
@:structAccess
extern class FreetypeSlotInternal {}

@:include("freetype/freetype.h")
@:native("FT_GlyphSlot")
@:structAccess
extern class FreetypeGlyphSlot {
    public var library:FreetypeLib;
    public var face:FreetypeFace;
    public var next:FreetypeGlyphSlot;
    public var glyphIndex:cpp.UInt32;
    public var generic:FreetypeGeneric;

    public var metrics:FreetypeGlyphMetrics;
    public var linearHoriAdvance:cpp.UInt64;
    public var linearVertAdvance:cpp.UInt64;
    public var advance:FreetypeVector;

    public var format:FreetypeGlyphFormat;

    public var bitmap:FreetypeBitmap;
    public var bitmap_left:Int;
    public var bitmap_right:Int;

    public var outline:FreetypeOutline;

    public var num_subglyphs:cpp.UInt32;
    public var subglyphs:FreetypeSubGlyph;

    public var control_data:cpp.Star<cpp.Void>;
    public var control_len:cpp.Int64;

    public var lsb_delta:cpp.Int64;
    public var rsb_delta:cpp.Int64;

    public var other:cpp.Star<cpp.Void>;

    public var internal:FreetypeSlotInternal;
}

@:include("freetype/freetype.h")
@:native("FT_Size_Request_Type_")
enum SizeRequestType {
    @:extern("FT_SIZE_REQUEST_TYPE_NOMINAL")
    NOMINAL;
    @:extern("FT_SIZE_REQUEST_TYPE_REAL_DIM")
    REAL_DIM;
    @:extern("FT_SIZE_REQUEST_TYPE_BBOX")
    BBOX;
    @:extern("FT_SIZE_REQUEST_TYPE_CELL")
    CELL;
    @:extern("FT_SIZE_REQUEST_TYPE_SCALES")
    SCALES;
    @:extern("FT_SIZE_REQUEST_TYPE_MAX")
    MAX;
}

@:include("freetype/freetype.h")
@:native("FT_Size_Request")
@:structAccess
extern class FreetypeSizeRequest {}

@:include("freetype/freetype.h")
@:native("FT_Render_Mode")
enum FtRenderMode {
    @:extern("FT_RENDER_MODE_NORMAL")
    NORMAL;
    @:extern("FT_RENDER_MODE_LIGHT")
    LIGHT;
    @:extern("FT_RENDER_MODE_MONO")
    MONO;
    @:extern("FT_RENDER_MODE_LCD")
    LCD;
    @:extern("FT_RENDER_MODE_LCD_V")
    LCD_V;
    @:extern("FT_RENDER_MODE_SDF")
    SDF;
    @:extern("FT_RENDER_MODE_MAX")
    MAX;
}

@:include("freetype/freetype.h")
@:native("FT_CharMap")
@:structAccess
extern class FTCharMap {
    public var face:FreetypeFace;
    // public var encoding:FreetypeEncoding;
    public var platformID:cpp.UInt16;
    public var encodingID:cpp.UInt16;
}
typedef FreetypeCharMap = cpp.RawPointer<FTCharMap>;

@:include("freetype/freetype.h")
@:native("FT_Parameter")
@:structAccess
extern class FreetypeParameter {
    public var tag:cpp.UInt64;
    public var data:Pointer<cpp.Void>;
}

@:include("freetype/freetype.h")
extern class Freetype {
    @:native("FT_Init_Freetype")
    static function init(lib:Pointer<FreetypeLib>):FTErr;

    @:native("FT_Done_Freetype")
    static function done(lib:FreetypeLib):FTErr;

    @:native("FT_New_Face")
    static function newFace(lib:FreetypeLib, filePath:ConstCharStar, index:cpp.Int32, facePtr:Pointer<FreetypeFace>):FTErr;

    @:native("FT_New_Memory_Face")
    static function newMemoryFace(lib:FreetypeLib, bytes:ConstStar<cpp.Int8>, size:cpp.Int32, index:cpp.Int32, facePtr:Pointer<FreetypeFace>):FTErr;

    // TODO: FT_Open_Face, FT_Attach_Stream & FT_Open_Args

    @:native("FT_Attach_File")
    static function attachFile(face:FreetypeFace, filePath:ConstCharStar):FTErr;

    @:native("FT_Reference_Face")
    static function referenceFace(face:FreetypeFace):FTErr;

    @:native("FT_Done_Face")
    static function doneFace(face:FreetypeFace):FTErr;

    @:native("FT_Select_Size")
    static function selectSize(face:FreetypeFace, strikeIndex:Int):FTErr;

    @:native("FT_Request_Size")
    static function requestSize(face:FreetypeFace, request:FreetypeSizeRequest):FTErr;

    @:native("FT_Set_Char_Size")
    static function setCharSize(face:FreetypeFace, width:cpp.Int64, height:cpp.Int64, horiRes:cpp.UInt32, vertRes:cpp.UInt32):FTErr;

    @:native("FT_Set_Pixel_Sizes")
    static function setPixelSizes(face:FreetypeFace, pixelWidth:cpp.UInt32, pixelHeight:cpp.UInt32):FTErr;

    @:native("FT_Load_Glyph")
    static function loadGlyph(face:FreetypeFace, glyphIndex:cpp.UInt32, loadFlags:cpp.UInt32):FTErr;

    @:native("FT_Load_Char")
    static function loadChar(face:FreetypeFace, charCode:cpp.UInt64, loadFlags:cpp.UInt32):FTErr;

    @:native("FT_Set_Transform")
    static function setTransform(face:FreetypeFace, matrix:Pointer<FreetypeMatrix>, delta:Pointer<FreetypeVector>):Void;

    @:native("FT_Get_Transform")
    static function getTransform(face:FreetypeFace, matrix:Pointer<FreetypeMatrix>, delta:Pointer<FreetypeVector>):Void;

    @:native("FT_Render_Glyph")
    static function renderGlpyh(slot:FreetypeGlyphSlot, renderMode:FtRenderMode):FTErr;

    @:native("FT_Get_Kerning")
    static function getKerning(face:FreetypeFace, leftGlyph:cpp.UInt32, rightGlyph:cpp.UInt32, kernMode:cpp.UInt32, kerning:Pointer<FreetypeVector>):FTErr;

    @:native("FT_Get_Track_Kerning")
    static function getTrackKerning(face:FreetypeFace, pointSize:cpp.Int64, degree:Int, kerning:Pointer<cpp.Int64>):FTErr;

    // TODO: FT_Select_Charmap  & FT_Encoding

    @:native("FT_Set_Charmap")
    static function setCharmap(face:FreetypeFace, charMap:FreetypeCharMap):FTErr;

    @:native("FT_Get_Charmap_Index")
    static function getCharmapIndex(charMap:FreetypeCharMap):Int;

    @:native("FT_Get_Char_Index")
    static function getCharIndex(face:FreetypeFace, charCode:cpp.UInt64):cpp.UInt32;

    @:native("FT_Get_First_Char")
    static function getFirstChar(face:FreetypeFace, agIndex:Pointer<cpp.UInt32>):cpp.UInt64;

    @:native("FT_Get_Next_Char")
    static function getNextChar(face:FreetypeFace, charCode:cpp.UInt64, agIndex:Pointer<cpp.UInt32>):cpp.UInt64;

    @:native("FT_Face_Properties")
    static function faceProperties(face:FreetypeFace, numProperties:cpp.UInt32, properties:cpp.Star<FreetypeParameter>):FTErr;

    @:native("FT_Get_Name_Index")
    static function getNameIndex(face:FreetypeFace, glyphName:cpp.ConstCharStar):cpp.Int32;

    @:native("FT_Get_Glyph_Name")
    static function getGlyphName(face:FreetypeFace, glyphIndex:cpp.UInt32, buffer:Pointer<cpp.Void>, bufferMax:cpp.UInt32):FTErr;

    @:native("FT_Get_Postscript_Name")
    static function getPostscriptName(face:FreetypeFace):cpp.ConstCharStar;

    @:native("FT_Get_SubGlyph_Info")
    static function getSubglyphInfo(glyph:FreetypeGlyphSlot, subIndex:cpp.UInt32, pIndex:Pointer<Int>, pFlags:Pointer<cpp.UInt32>, pArg1:Pointer<Int>, pArg2:Pointer<Int>, pTransform:Pointer<FreetypeMatrix>):FTErr;

    @:native("FT_Get_FSType_Flags")
    static function getFSTypeFlags(face:FreetypeFace):cpp.UInt16;

    @:native("FT_Face_GetCharVariantIndex")
    static function faceGetCharVariantIndex(face:FreetypeFace, charCode:cpp.UInt64, variantSelector:cpp.UInt64):cpp.UInt32;

    @:native("FT_Face_GetCharVariantIsDefault")
    static function faceGetCharVariantIsDefault(face:FreetypeFace, charCode:cpp.UInt64, variantSelector:cpp.UInt64):Int;

    @:native("FT_Face_GetVariantSelectors")
    static function faceGetVariantSelectors(face:FreetypeFace):Star<cpp.Int32>;

    @:native("FT_Face_GetVariantsOfChar")
    static function faceGetVariantsOfChar(face:FreetypeFace, charCode:cpp.UInt64):Star<cpp.UInt32>;

    @:native("FT_Face_GetCharsOfVariant")
    static function faceGetCharsOfVariant(face:FreetypeFace, variantSelector:cpp.UInt64):Star<cpp.UInt32>;

    @:native("FT_Library_Version")
    static function libraryVersion(lib:FreetypeLib, major:Pointer<Int>, minor:Pointer<Int>, patch:Pointer<Int>):Void;

    @:native("FT_Face_CheckTrueTypePatents")
    static function faceCheckTrueTypePatents(face:FreetypeFace):cpp.UInt8;

    @:native("FT_Face_SetUnpatentedHinting")
    static function faceSetUnpatentedHinting(face:FreetypeFace, value:cpp.UInt8):cpp.UInt8;
}