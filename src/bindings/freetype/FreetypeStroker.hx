package bindings.freetype;

import cpp.RawPointer;
import bindings.freetype.Freetype;
import bindings.freetype.FreetypeGlyph;

@:include("freetype/ftstroke.h")
@:native("FT_StrokerRec_")
extern class FTStrokerRec {}
typedef FTStroker = RawPointer<FTStrokerRec>;

@:include("freetype/ftstroke.h")
@:native("FT_Stroker_LineJoin")
extern enum abstract FTStrokerLineJoin(cpp.UInt32) {
	@:native("FT_STROKER_LINEJOIN_ROUND")
	var ROUND;
	@:native("FT_STROKER_LINEJOIN_BEVEL")
	var BEVEL;
	@:native("FT_STROKER_LINEJOIN_MITER_VARIABLE")
	var MITER_VARIABLE;
	@:native("FT_STROKER_LINEJOIN_MITER")
	var MITER;
	@:native("FT_STROKER_LINEJOIN_MITER_FIXED")
	var MITER_FIXED;
}

@:include("freetype/ftstroke.h")
@:native("FT_Stroker_LineCap")
extern enum abstract FTStrokerLineCap(cpp.UInt32) {
	@:native("FT_STROKER_LINECAP_BUTT")
	var BUTT;
	@:native("FT_STROKER_LINECAP_ROUND")
	var ROUND;
	@:native("FT_STROKER_LINECAP_SQUARE")
	var SQUARE;
}

@:include("freetype/ftstroke.h")
@:native("FT_StrokerBorder")
extern enum abstract FTStrokerBorder(cpp.UInt32) {
	@:native("FT_STROKER_BORDER_LEFT")
	var LEFT;
	@:native("FT_STROKER_BORDER_RIGHT")
	var RIGHT;
}

@:include("freetype/ftstroke.h")
extern class FreetypeStroker {
	@:native("FT_Outline_GetInsideBorder")
	static function getInsideBorder():FTStrokerBorder;

	@:native("FT_Outline_GetOutsideBorder")
	static function getOutsideBorder():FTStrokerBorder;

	@:native("FT_Stroker_New") // calling it init instead of new to potentially avoid stuff with haxe
	static function init(lib:FTLibrary, stroker:RawPointer<FTStroker>):FTErr;

	@:native("FT_Stroker_Set")
	static function set(stroker:FTStroker, radius:cpp.Int64, cap:FTStrokerLineCap, join:FTStrokerLineJoin, miterLimit:cpp.Int64):Void;

	@:native("FT_Stroker_Rewind")
	static function rewind(stroker:FTStroker):Void;

	@:native("FT_Stroker_ParseOutline")
	static function parseOutline(stroker:FTStroker, outline:FTOutline, opened:cpp.UInt8):FTErr;

	@:native("FT_Stroker_BeginSubPath")
	static function beginSubPath(stroker:FTStroker, to:RawPointer<FTVector>, open:cpp.UInt8):FTErr;

	@:native("FT_Stroker_EndSubPath")
	static function endSubPath(stroker:FTStroker):FTErr;

	@:native("FT_Stroker_LineTo")
	static function lineTo(stroker:FTStroker, to:RawPointer<FTVector>):FTErr;

	@:native("FT_Stroker_ConicTo")
	static function conicTo(stroker:FTStroker, control:RawPointer<FTVector>, to:RawPointer<FTVector>):FTErr;

	@:native("FT_Stroker_CubicTo")
	static function cubicTo(stroker:FTStroker, control1:RawPointer<FTVector>, control2:RawPointer<FTVector>, to:RawPointer<FTVector>):FTErr;

	@:native("FT_Stroker_GetBorderCounts")
	static function getBorderCounts(stroker:FTStroker, border:FTStrokerBorder, numPoints:RawPointer<cpp.UInt32>, numContours:RawPointer<cpp.UInt32>):FTErr;

	@:native("FT_Stroker_ExportBorder")
	static function exportBorder(stroker:FTStroker, border:FTStrokerBorder, outline:RawPointer<FTOutline>):Void;

	@:native("FT_Stroker_GetCounts")
	static function getCounts(stroker:FTStroker, numPoints:RawPointer<cpp.UInt32>, numContours:RawPointer<cpp.UInt32>):FTErr;

	@:native("FT_Stroker_Export")
	static function export(stroker:FTStroker, outline:RawPointer<FTOutline>):Void;

	@:native("FT_Stroker_Done")
	static function done(stroker:FTStroker):Void;

	@:native("FT_Glyph_Stroke")
	static function glyphStroke(glyph:RawPointer<FTGlyph>, stroker:FTStroker, destroy:cpp.UInt8):FTErr;

	@:native("FT_Glyph_StrokeBorder")
	static function glyphStrokeBorder(glyph:RawPointer<FTGlyph>, stroker:FTStroker, inside:cpp.UInt8, destroy:cpp.UInt8):FTErr;
}