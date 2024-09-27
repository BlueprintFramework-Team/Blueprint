package bindings.freetype;

import cpp.Callable;
import cpp.RawPointer;
import bindings.freetype.Freetype;
import bindings.freetype.FreetypeBitmap;

// Stuff that should be in ftimage or freetype but it fits better here imo
@:include("freetype/freetype.h")
@:native("FT_Glyph_Metrics")
extern class FTGlyphMetrics {
    @:native("width")
    var width:cpp.UInt64;
    @:native("height")
    var height:cpp.UInt64;

    @:native("horiBearingX")
    var horiBearingX:cpp.UInt64;
    @:native("horiBearingY")
    var horiBearingY:cpp.UInt64;
    @:native("horiAdvance")
    var horiAdvance:cpp.UInt64;

    @:native("vertBearingX")
    var vertBearingX:cpp.UInt64;
    @:native("vertBearingY")
    var vertBearingY:cpp.UInt64;
    @:native("vertAdvance")
    var vertAdvance:cpp.UInt64;
}

@:include("freetype/ftimage.h")
@:native("FT_Glyph_Format")
extern enum abstract FTGlyphFormat(cpp.UInt32) {
    @:native("FT_GLYPH_FORMAT_NONE")
    var NONE;
    @:native("FT_GLYPH_FORMAT_COMPOSITE")
    var COMPOSITE;
    @:native("FT_GLYPH_FORMAT_BITMAP")
    var BITMAP;
    @:native("FT_GLYPH_FORMAT_OUTLINE")
    var OUTLINE;
    @:native("FT_GLYPH_FORMAT_PLOTTER")
    var PLOTTER;
    @:native("FT_GLYPH_FORMAT_SVG")
    var SVG;
}

@:include("freetype/freetype.h")
@:native("FT_SubGlyph")
extern class FTSubGlyph {}

@:include("freetype/freetype.h")
@:native("FT_Slot_Internal")
extern class FTSlotInternal {}

@:include("freetype/freetype.h")
@:native("FT_GlyphSlot")
extern class FTGlyphSlot {
    @:native("library")
    var library:FTLibrary;
    @:native("face")
    var face:FTFace;
    @:native("next")
    var next:FTGlyphSlot;
    @:native("glyph_index")
    var glyphIndex:cpp.UInt32;
    @:native("generic")
    var generic:FTGeneric;

    @:native("metrics")
    var metrics:FTGlyphMetrics;
    @:native("linearHoriAdvance")
    var linearHoriAdvance:cpp.UInt64;
    @:native("linearVertAdvance")
    var linearVertAdvance:cpp.UInt64;
    @:native("advance")
    var advance:FTVector;

    @:native("format")
    var format:FTGlyphFormat;

    @:native("bitmap")
    var bitmap:FTBitmap;
    @:native("bitmap_left")
    var bitmapLeft:Int;
    @:native("bitmap_top")
    var bitmapTop:Int;

    @:native("outline")
    var outline:FTOutline;

    @:native("num_subglyphs")
    var numSubglyphs:cpp.UInt32;
    @:native("subglyphs")
    var subglyphs:FTSubGlyph;

    @:native("control_data")
    var controlData:RawPointer<cpp.Void>;
    @:native("control_len")
    var controlLength:cpp.Int64;

    @:native("lsb_delta")
    var lsbDelta:cpp.Int64;
    @:native("rsb_delta")
    var rsbDelta:cpp.Int64;

    @:native("other")
    var other:RawPointer<cpp.Void>;

    @:native("internal")
    var internal:FTSlotInternal;
}

// ok now to ftglyph
typedef FTGlyphInit = Callable<(glyph:Any, slot:FTGlyphSlot) -> FTErr>;
typedef FTGlyphDone = Callable<(glyph:Any) -> Void>;
typedef FTGlyphTransform = Callable<(glyph:Any, matrix:RawPointer<FTMatrix>, delta:RawPointer<FTVector>) -> FTErr>;
typedef FTGlyphGetBBox = Callable<(glyph:Any, bbox:RawPointer<FTBBox>) -> FTErr>;
typedef FTGlyphCopy = Callable<(source:Any, target:Any) -> FTErr>;
typedef FTGlyphPrepare = Callable<(glyph:Any, slot:FTGlyphSlot) -> FTErr>;

@:include("freetype/ftglyph.h")
@:native("FT_Glyph_Class")
extern class FTGlyphClass {
    var size:cpp.Int64;
    var format:FTGlyphFormat;

    var init:FTGlyphInit;
    var done:FTGlyphDone;
    var copy:FTGlyphCopy;
    var transform:FTGlyphTransform;
    var bbox:FTGlyphGetBBox;
    var prepare:FTGlyphGetBBox;
}

@:include("freetype/ftglyph.h")
@:native("FT_GlyphRec_")
extern class FTGlyphRec {
    var library:FTLibrary;
    var clazz:RawPointer<FTGlyphClass>;
    var format:FTGlyphFormat;
    var advance:FTVector;
}
typedef FTGlyph = RawPointer<FTGlyphRec>;

@:include("freetype/ftglyph.h")
@:native("FT_BitmapGlyph")
extern class FTBitmapGlyph {
    var root:FTGlyph;
    var left:Int;
    var top:Int;
    var bitmap:FTBitmap;
}

@:include("freetype/ftglyph.h")
@:native("FT_OutlineGlyph")
extern class FTOutlineGlyph {
    var root:FTGlyph;
    var outline:FTOutline;
}

@:include("freetype/ftglyph.h")
@:native("FT_SvgGlyph")
extern class FTSvgGlyph {
    var root:FTGlyph;
    @:native("svg_document")
    var document:RawPointer<cpp.UInt8>;
    @:native("svg_document_length")
    var docLength:cpp.UInt64;

    @:native("glyph_index")
    var glyphIndex:cpp.UInt32;

    @:native("metrics")
    var metrics:FTSizeMetrics;
    @:native("units_per_EM")
    var unitsPerEM:cpp.UInt16;

    @:native("start_glyph_id")
    var startGlyphID:cpp.UInt16;
    @:native("end_glyph_id")
    var endGlyphID:cpp.UInt16;

    var transform:FTMatrix;
    var delta:FTVector;
}

@:include("freetype/ftstroke.h")
@:native("FT_Glyph_BBox_Mode")
extern enum abstract FTGlyphBBoxMode(cpp.UInt32) {
	@:native("FT_GLYPH_BBOX_UNSCALED")
	var UNSCALED;
	@:native("FT_GLYPH_BBOX_SUBPIXELS")
	var SUBPIXELS;
	@:native("FT_GLYPH_BBOX_GRIDFIT")
	var GRIDFIT;
	@:native("FT_GLYPH_BBOX_TRUNCATE")
	var TRUNCATE;
	@:native("FT_GLYPH_BBOX_PIXELS")
	var PIXELS;
}

@:include("freetype/ftglyph.h")
extern class FreetypeGlyph {
    @:native("FT_New_Glyph")
    static function init(library:FTLibrary, format:FTGlyphFormat, glyph:FTGlyph):FTErr;

    @:native("FT_Get_Glyph")
    static function get(slot:FTGlyphSlot, glyph:RawPointer<FTGlyph>):FTErr;

    @:native("FT_Glyph_Copy")
    static function copy(source:FTGlyph, target:RawPointer<FTGlyph>):FTErr;

    @:native("FT_Glyph_Transform")
    static function transform(glyph:FTGlyph, matrix:RawPointer<FTMatrix>, delta:RawPointer<FTVector>):FTErr;

    @:native("FT_Glyph_Get_CBox")
    static function getCBox(glyph:FTGlyph, bboxMode:FTGlyphBBoxMode, cbox:RawPointer<FTBBox>):Void;

    @:native("FT_Glyph_To_Bitmap")
    static function toBitmap(glyph:RawPointer<FTGlyph>, renderMode:FTRenderMode, origin:RawPointer<FTVector>, destroy:Int):FTErr;

    @:native("FT_Done_Glyph")
    static function done(glyph:FTGlyph):Void;

    @:native("FT_Matrix_Multiply")
    static function multiplyMatrix(a:RawPointer<FTMatrix>, b:RawPointer<FTMatrix>):Void;

    @:native("FT_Matrix_Invert")
    static function invertMatrix(matrix:RawPointer<FTMatrix>):Void;
}