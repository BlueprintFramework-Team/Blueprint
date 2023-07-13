package bindings;

#if !macro
/**
 * 
 * 
 * 
 * 
 * 
 * TODO: fix the binding issue with line 1855. (i made a helper function for these bindings. hince why its broken)
 * 
 * 
 * 
 * 
 * 
 */

import cpp.ConstCharStar;
import cpp.Callable;
import cpp.Pointer;
import cpp.Star;
import cpp.ConstStar;
import cpp.ConstPointer;

typedef GlEnum = UInt;
typedef GlBool = UInt;
typedef GlBitField = UInt;
// typedef void GLvoid; not used. commenting this for later.
typedef GlByte = cpp.Int8;
typedef GlUByte = cpp.UInt8;
typedef GlShort = cpp.Int16;
typedef GlUShort = cpp.UInt16;
typedef GlInt = Int;
typedef GlUInt = cpp.UInt32;
typedef GlClampX = cpp.Int32;
typedef GlSizeI = Int;
typedef GlFloat = cpp.Float32;
// typedef khronos_float_t GLclampf;
typedef GlDouble = Float;
// typedef double GLclampd;
// typedef void *GLeglClientBufferEXT;
// typedef void *GLeglImageOES;
typedef GlChar = cpp.Char;
// typedef char GLcharARB;
// typedef unsigned int GLhandleARB;
// typedef khronos_uint16_t GLhalf;
// typedef khronos_uint16_t GLhalfARB;
typedef GlFixed = cpp.Int32;
typedef GlIntPointer = Star<Int>;
// typedef khronos_intptr_t GLintptrARB;
typedef GlSizeIPointer = Star<cpp.Int64>;
// typedef khronos_ssize_t GLsizeiptrARB;
typedef GlInt64 = cpp.Int64;
// typedef khronos_int64_t GLint64EXT;
typedef GlUInt64 = cpp.UInt64;
// typedef khronos_uint64_t GLuint64EXT;

@:include("includeWorkaround.h")
@:native("GLsync")
@:structAccess
extern class GlSyncStruct {}
typedef GlSync = cpp.RawPointer<GlSyncStruct>;
// struct _cl_context;
// struct _cl_event;

typedef GlDebugProc = Callable<(source:GlEnum, type:GlEnum, severity:GlEnum, length:GlSizeI, message:ConstCharStar, userParam:ConstStar<cpp.Void>) -> Void>;
// typedef void (APIENTRY *GLDEBUGPROCARB)(GLenum source,GLenum type,GLuint id,GLenum severity,GLsizei length,const GLchar *message,const void *userParam);
// typedef void (APIENTRY *GLDEBUGPROCKHR)(GLenum source,GLenum type,GLuint id,GLenum severity,GLsizei length,const GLchar *message,const void *userParam);
// typedef void (APIENTRY *GLDEBUGPROCAMD)(GLuint id,GLenum category,GLenum severity,GLsizei length,const GLchar *message,void *userParam);

typedef GladLoadProc = (name:ConstCharStar) -> Void;

@:include("includeWorkaround.h")
@:native("gladGLversionStruct")
@:structAccess
extern class GladGLversionStruct {
    var major:Int;
    var minor:Int;
}
typedef VersionStruct = cpp.Struct<GladGLversionStruct>;

@:include("includeWorkaround.h")
extern class Glad {
	public static inline function loadHelper(loadProc:GladLoadProc):Int {
		return untyped __cpp__("gladLoadGLLoader((GLADloadproc){0})", loadProc);
	}

	/**
	 * NOTE: INSERT A NON-VARIABLE INTERGER FOR `arrayLength`!
	 */
	static inline function bufferFloatArray(target:GlEnum, array:Array<cpp.Float32>, usage:GlEnum, arrayLength:Int):Void {
		return untyped __cpp__(
			"float _cArray[{3}];
			for (int i = 0; i < {0}->length; i++) {
				_cArray[i] = {0}->__get(i);
			}
			glBufferData({1}, sizeof(_cArray), _cArray, {2})",
		array, target, usage, arrayLength);
	}

	/**
	 * NOTE: INSERT A NON-VARIABLE INTERGER FOR `arrayLength`!
	 */
	static inline function bufferSubFloatArray(target:GlEnum, offset:GlIntPointer, array:Array<cpp.Float32>, arrayLength:Int):Void {
		return untyped __cpp__(
			"float _cArray[{3}];
			for (int i = 0; i < {0}->length; i++) {
				_cArray[i] = {0}->__get(i);
			}
			glBufferSubData({1}, {2}, sizeof(_cArray), _cArray)",
		array, target, offset, arrayLength);
	}

	/**
	 * NOTE: INSERT A NON-VARIABLE INTERGER FOR `arrayLength`!
	 */
	 static inline function bufferIntArray(target:GlEnum, array:Array<cpp.UInt32>, usage:GlEnum, arrayLength:Int):Void {
		return untyped __cpp__(
			"unsigned int _cArray[{3}];
			for (int i = 0; i < {0}->length; i++) {
				_cArray[i] = {0}->__get(i);
			}
			glBufferData({1}, sizeof(_cArray), _cArray, {2})",
		array, target, usage, arrayLength);
	}

	/**
	 * NOTE: INSERT A NON-VARIABLE INTERGER FOR `arrayLength`!
	 */
	static inline function bufferSubIntArray(target:GlEnum, offset:GlIntPointer, array:Array<cpp.UInt32>, arrayLength:Int):Void {
		return untyped __cpp__(
			"unsigned int _cArray[{3}];
			for (int i = 0; i < {0}->length; i++) {
				_cArray[i] = {0}->__get(i);
			}
			glBufferSubData({1}, {2}, sizeof(_cArray), _cArray)",
		array, target, offset, arrayLength);
	}

	static inline function vertexFloatAttrib(varIndex:cpp.UInt32, size:Int, normalized:GlBool, stride:Int, offset:Int):Void {
		return untyped __cpp__("glVertexAttribPointer({0}, {1}, GL_FLOAT, {2}, {3} * sizeof(float), (void*)({4} * sizeof(float)))", varIndex, size, normalized, stride, offset);
	}

    @:native("GLVersion")
    public static var version:VersionStruct;

    @:native("gladLoadGL")
    public static function loadGL():Int;

    @:native("gladLoadGLLoader")
    public static function loadGLLoader(loadProc:GladLoadProc):Int;

    @:native("gladLoadGLES1Loader")
    public static function loadGLES1Loader(loadProc:GladLoadProc):Int;

    @:native("gladLoadGLES2Loader")
    public static function loadGLES2Loader(loadProc:GladLoadProc):Int;

    @:native("gladLoadGLSC2Loader")
    public static function loadGLSC2Loader(loadProc:GladLoadProc):Int;

	@:native("GL_DEPTH_BUFFER_BIT")
	public static var DEPTH_BUFFER_BIT:Int;
	@:native("GL_STENCIL_BUFFER_BIT")
	public static var STENCIL_BUFFER_BIT:Int;
	@:native("GL_COLOR_BUFFER_BIT")
	public static var COLOR_BUFFER_BIT:Int;
	@:native("GL_FALSE")
	public static var FALSE:Int;
	@:native("GL_TRUE")
	public static var TRUE:Int;
	@:native("GL_POINTS")
	public static var POINTS:Int;
	@:native("GL_LINES")
	public static var LINES:Int;
	@:native("GL_LINE_LOOP")
	public static var LINE_LOOP:Int;
	@:native("GL_LINE_STRIP")
	public static var LINE_STRIP:Int;
	@:native("GL_TRIANGLES")
	public static var TRIANGLES:Int;
	@:native("GL_TRIANGLE_STRIP")
	public static var TRIANGLE_STRIP:Int;
	@:native("GL_TRIANGLE_FAN")
	public static var TRIANGLE_FAN:Int;
	@:native("GL_NEVER")
	public static var NEVER:Int;
	@:native("GL_LESS")
	public static var LESS:Int;
	@:native("GL_EQUAL")
	public static var EQUAL:Int;
	@:native("GL_LEQUAL")
	public static var LEQUAL:Int;
	@:native("GL_GREATER")
	public static var GREATER:Int;
	@:native("GL_NOTEQUAL")
	public static var NOTEQUAL:Int;
	@:native("GL_GEQUAL")
	public static var GEQUAL:Int;
	@:native("GL_ALWAYS")
	public static var ALWAYS:Int;
	@:native("GL_ZERO")
	public static var ZERO:Int;
	@:native("GL_ONE")
	public static var ONE:Int;
	@:native("GL_SRC_COLOR")
	public static var SRC_COLOR:Int;
	@:native("GL_ONE_MINUS_SRC_COLOR")
	public static var ONE_MINUS_SRC_COLOR:Int;
	@:native("GL_SRC_ALPHA")
	public static var SRC_ALPHA:Int;
	@:native("GL_ONE_MINUS_SRC_ALPHA")
	public static var ONE_MINUS_SRC_ALPHA:Int;
	@:native("GL_DST_ALPHA")
	public static var DST_ALPHA:Int;
	@:native("GL_ONE_MINUS_DST_ALPHA")
	public static var ONE_MINUS_DST_ALPHA:Int;
	@:native("GL_DST_COLOR")
	public static var DST_COLOR:Int;
	@:native("GL_ONE_MINUS_DST_COLOR")
	public static var ONE_MINUS_DST_COLOR:Int;
	@:native("GL_SRC_ALPHA_SATURATE")
	public static var SRC_ALPHA_SATURATE:Int;
	@:native("GL_NONE")
	public static var NONE:Int;
	@:native("GL_FRONT_LEFT")
	public static var FRONT_LEFT:Int;
	@:native("GL_FRONT_RIGHT")
	public static var FRONT_RIGHT:Int;
	@:native("GL_BACK_LEFT")
	public static var BACK_LEFT:Int;
	@:native("GL_BACK_RIGHT")
	public static var BACK_RIGHT:Int;
	@:native("GL_FRONT")
	public static var FRONT:Int;
	@:native("GL_BACK")
	public static var BACK:Int;
	@:native("GL_LEFT")
	public static var LEFT:Int;
	@:native("GL_RIGHT")
	public static var RIGHT:Int;
	@:native("GL_FRONT_AND_BACK")
	public static var FRONT_AND_BACK:Int;
	@:native("GL_NO_ERROR")
	public static var NO_ERROR:Int;
	@:native("GL_INVALID_ENUM")
	public static var INVALID_ENUM:Int;
	@:native("GL_INVALID_VALUE")
	public static var INVALID_VALUE:Int;
	@:native("GL_INVALID_OPERATION")
	public static var INVALID_OPERATION:Int;
	@:native("GL_OUT_OF_MEMORY")
	public static var OUT_OF_MEMORY:Int;
	@:native("GL_CW")
	public static var CW:Int;
	@:native("GL_CCW")
	public static var CCW:Int;
	@:native("GL_POINT_SIZE")
	public static var POINT_SIZE:Int;
	@:native("GL_POINT_SIZE_RANGE")
	public static var POINT_SIZE_RANGE:Int;
	@:native("GL_POINT_SIZE_GRANULARITY")
	public static var POINT_SIZE_GRANULARITY:Int;
	@:native("GL_LINE_SMOOTH")
	public static var LINE_SMOOTH:Int;
	@:native("GL_LINE_WIDTH")
	public static var LINE_WIDTH:Int;
	@:native("GL_LINE_WIDTH_RANGE")
	public static var LINE_WIDTH_RANGE:Int;
	@:native("GL_LINE_WIDTH_GRANULARITY")
	public static var LINE_WIDTH_GRANULARITY:Int;
	@:native("GL_POLYGON_MODE")
	public static var POLYGON_MODE:Int;
	@:native("GL_POLYGON_SMOOTH")
	public static var POLYGON_SMOOTH:Int;
	@:native("GL_CULL_FACE")
	public static var CULL_FACE:Int;
	@:native("GL_CULL_FACE_MODE")
	public static var CULL_FACE_MODE:Int;
	@:native("GL_FRONT_FACE")
	public static var FRONT_FACE:Int;
	@:native("GL_DEPTH_RANGE")
	public static var DEPTH_RANGE:Int;
	@:native("GL_DEPTH_TEST")
	public static var DEPTH_TEST:Int;
	@:native("GL_DEPTH_WRITEMASK")
	public static var DEPTH_WRITEMASK:Int;
	@:native("GL_DEPTH_CLEAR_VALUE")
	public static var DEPTH_CLEAR_VALUE:Int;
	@:native("GL_DEPTH_FUNC")
	public static var DEPTH_FUNC:Int;
	@:native("GL_STENCIL_TEST")
	public static var STENCIL_TEST:Int;
	@:native("GL_STENCIL_CLEAR_VALUE")
	public static var STENCIL_CLEAR_VALUE:Int;
	@:native("GL_STENCIL_FUNC")
	public static var STENCIL_FUNC:Int;
	@:native("GL_STENCIL_VALUE_MASK")
	public static var STENCIL_VALUE_MASK:Int;
	@:native("GL_STENCIL_FAIL")
	public static var STENCIL_FAIL:Int;
	@:native("GL_STENCIL_PASS_DEPTH_FAIL")
	public static var STENCIL_PASS_DEPTH_FAIL:Int;
	@:native("GL_STENCIL_PASS_DEPTH_PASS")
	public static var STENCIL_PASS_DEPTH_PASS:Int;
	@:native("GL_STENCIL_REF")
	public static var STENCIL_REF:Int;
	@:native("GL_STENCIL_WRITEMASK")
	public static var STENCIL_WRITEMASK:Int;
	@:native("GL_VIEWPORT")
	public static var VIEWPORT:Int;
	@:native("GL_DITHER")
	public static var DITHER:Int;
	@:native("GL_BLEND_DST")
	public static var BLEND_DST:Int;
	@:native("GL_BLEND_SRC")
	public static var BLEND_SRC:Int;
	@:native("GL_BLEND")
	public static var BLEND:Int;
	@:native("GL_LOGIC_OP_MODE")
	public static var LOGIC_OP_MODE:Int;
	@:native("GL_DRAW_BUFFER")
	public static var DRAW_BUFFER:Int;
	@:native("GL_READ_BUFFER")
	public static var READ_BUFFER:Int;
	@:native("GL_SCISSOR_BOX")
	public static var SCISSOR_BOX:Int;
	@:native("GL_SCISSOR_TEST")
	public static var SCISSOR_TEST:Int;
	@:native("GL_COLOR_CLEAR_VALUE")
	public static var COLOR_CLEAR_VALUE:Int;
	@:native("GL_COLOR_WRITEMASK")
	public static var COLOR_WRITEMASK:Int;
	@:native("GL_DOUBLEBUFFER")
	public static var DOUBLEBUFFER:Int;
	@:native("GL_STEREO")
	public static var STEREO:Int;
	@:native("GL_LINE_SMOOTH_HINT")
	public static var LINE_SMOOTH_HINT:Int;
	@:native("GL_POLYGON_SMOOTH_HINT")
	public static var POLYGON_SMOOTH_HINT:Int;
	@:native("GL_UNPACK_SWAP_BYTES")
	public static var UNPACK_SWAP_BYTES:Int;
	@:native("GL_UNPACK_LSB_FIRST")
	public static var UNPACK_LSB_FIRST:Int;
	@:native("GL_UNPACK_ROW_LENGTH")
	public static var UNPACK_ROW_LENGTH:Int;
	@:native("GL_UNPACK_SKIP_ROWS")
	public static var UNPACK_SKIP_ROWS:Int;
	@:native("GL_UNPACK_SKIP_PIXELS")
	public static var UNPACK_SKIP_PIXELS:Int;
	@:native("GL_UNPACK_ALIGNMENT")
	public static var UNPACK_ALIGNMENT:Int;
	@:native("GL_PACK_SWAP_BYTES")
	public static var PACK_SWAP_BYTES:Int;
	@:native("GL_PACK_LSB_FIRST")
	public static var PACK_LSB_FIRST:Int;
	@:native("GL_PACK_ROW_LENGTH")
	public static var PACK_ROW_LENGTH:Int;
	@:native("GL_PACK_SKIP_ROWS")
	public static var PACK_SKIP_ROWS:Int;
	@:native("GL_PACK_SKIP_PIXELS")
	public static var PACK_SKIP_PIXELS:Int;
	@:native("GL_PACK_ALIGNMENT")
	public static var PACK_ALIGNMENT:Int;
	@:native("GL_MAX_TEXTURE_SIZE")
	public static var MAX_TEXTURE_SIZE:Int;
	@:native("GL_MAX_VIEWPORT_DIMS")
	public static var MAX_VIEWPORT_DIMS:Int;
	@:native("GL_SUBPIXEL_BITS")
	public static var SUBPIXEL_BITS:Int;
	@:native("GL_TEXTURE_1D")
	public static var TEXTURE_1D:Int;
	@:native("GL_TEXTURE_2D")
	public static var TEXTURE_2D:Int;
	@:native("GL_TEXTURE_WIDTH")
	public static var TEXTURE_WIDTH:Int;
	@:native("GL_TEXTURE_HEIGHT")
	public static var TEXTURE_HEIGHT:Int;
	@:native("GL_TEXTURE_BORDER_COLOR")
	public static var TEXTURE_BORDER_COLOR:Int;
	@:native("GL_DONT_CARE")
	public static var DONT_CARE:Int;
	@:native("GL_FASTEST")
	public static var FASTEST:Int;
	@:native("GL_NICEST")
	public static var NICEST:Int;
	@:native("GL_BYTE")
	public static var BYTE:Int;
	@:native("GL_UNSIGNED_BYTE")
	public static var UNSIGNED_BYTE:Int;
	@:native("GL_SHORT")
	public static var SHORT:Int;
	@:native("GL_UNSIGNED_SHORT")
	public static var UNSIGNED_SHORT:Int;
	@:native("GL_INT")
	public static var INT:Int;
	@:native("GL_UNSIGNED_INT")
	public static var UNSIGNED_INT:Int;
	@:native("GL_FLOAT")
	public static var FLOAT:Int;
	@:native("GL_CLEAR")
	public static var CLEAR:Int;
	@:native("GL_AND")
	public static var AND:Int;
	@:native("GL_AND_REVERSE")
	public static var AND_REVERSE:Int;
	@:native("GL_COPY")
	public static var COPY:Int;
	@:native("GL_AND_INVERTED")
	public static var AND_INVERTED:Int;
	@:native("GL_NOOP")
	public static var NOOP:Int;
	@:native("GL_XOR")
	public static var XOR:Int;
	@:native("GL_OR")
	public static var OR:Int;
	@:native("GL_NOR")
	public static var NOR:Int;
	@:native("GL_EQUIV")
	public static var EQUIV:Int;
	@:native("GL_INVERT")
	public static var INVERT:Int;
	@:native("GL_OR_REVERSE")
	public static var OR_REVERSE:Int;
	@:native("GL_COPY_INVERTED")
	public static var COPY_INVERTED:Int;
	@:native("GL_OR_INVERTED")
	public static var OR_INVERTED:Int;
	@:native("GL_NAND")
	public static var NAND:Int;
	@:native("GL_SET")
	public static var SET:Int;
	@:native("GL_TEXTURE")
	public static var TEXTURE:Int;
	@:native("GL_COLOR")
	public static var COLOR:Int;
	@:native("GL_DEPTH")
	public static var DEPTH:Int;
	@:native("GL_STENCIL")
	public static var STENCIL:Int;
	@:native("GL_STENCIL_INDEX")
	public static var STENCIL_INDEX:Int;
	@:native("GL_DEPTH_COMPONENT")
	public static var DEPTH_COMPONENT:Int;
	@:native("GL_RED")
	public static var RED:Int;
	@:native("GL_GREEN")
	public static var GREEN:Int;
	@:native("GL_BLUE")
	public static var BLUE:Int;
	@:native("GL_ALPHA")
	public static var ALPHA:Int;
	@:native("GL_RGB")
	public static var RGB:Int;
	@:native("GL_RGBA")
	public static var RGBA:Int;
	@:native("GL_POINT")
	public static var POINT:Int;
	@:native("GL_LINE")
	public static var LINE:Int;
	@:native("GL_FILL")
	public static var FILL:Int;
	@:native("GL_KEEP")
	public static var KEEP:Int;
	@:native("GL_REPLACE")
	public static var REPLACE:Int;
	@:native("GL_INCR")
	public static var INCR:Int;
	@:native("GL_DECR")
	public static var DECR:Int;
	@:native("GL_VENDOR")
	public static var VENDOR:Int;
	@:native("GL_RENDERER")
	public static var RENDERER:Int;
	@:native("GL_VERSION")
	public static var VERSION:Int;
	@:native("GL_EXTENSIONS")
	public static var EXTENSIONS:Int;
	@:native("GL_NEAREST")
	public static var NEAREST:Int;
	@:native("GL_LINEAR")
	public static var LINEAR:Int;
	@:native("GL_NEAREST_MIPMAP_NEAREST")
	public static var NEAREST_MIPMAP_NEAREST:Int;
	@:native("GL_LINEAR_MIPMAP_NEAREST")
	public static var LINEAR_MIPMAP_NEAREST:Int;
	@:native("GL_NEAREST_MIPMAP_LINEAR")
	public static var NEAREST_MIPMAP_LINEAR:Int;
	@:native("GL_LINEAR_MIPMAP_LINEAR")
	public static var LINEAR_MIPMAP_LINEAR:Int;
	@:native("GL_TEXTURE_MAG_FILTER")
	public static var TEXTURE_MAG_FILTER:Int;
	@:native("GL_TEXTURE_MIN_FILTER")
	public static var TEXTURE_MIN_FILTER:Int;
	@:native("GL_TEXTURE_WRAP_S")
	public static var TEXTURE_WRAP_S:Int;
	@:native("GL_TEXTURE_WRAP_T")
	public static var TEXTURE_WRAP_T:Int;
	@:native("GL_REPEAT")
	public static var REPEAT:Int;
	@:native("GL_COLOR_LOGIC_OP")
	public static var COLOR_LOGIC_OP:Int;
	@:native("GL_POLYGON_OFFSET_UNITS")
	public static var POLYGON_OFFSET_UNITS:Int;
	@:native("GL_POLYGON_OFFSET_POINT")
	public static var POLYGON_OFFSET_POINT:Int;
	@:native("GL_POLYGON_OFFSET_LINE")
	public static var POLYGON_OFFSET_LINE:Int;
	@:native("GL_POLYGON_OFFSET_FILL")
	public static var POLYGON_OFFSET_FILL:Int;
	@:native("GL_POLYGON_OFFSET_FACTOR")
	public static var POLYGON_OFFSET_FACTOR:Int;
	@:native("GL_TEXTURE_BINDING_1D")
	public static var TEXTURE_BINDING_1D:Int;
	@:native("GL_TEXTURE_BINDING_2D")
	public static var TEXTURE_BINDING_2D:Int;
	@:native("GL_TEXTURE_INTERNAL_FORMAT")
	public static var TEXTURE_INTERNAL_FORMAT:Int;
	@:native("GL_TEXTURE_RED_SIZE")
	public static var TEXTURE_RED_SIZE:Int;
	@:native("GL_TEXTURE_GREEN_SIZE")
	public static var TEXTURE_GREEN_SIZE:Int;
	@:native("GL_TEXTURE_BLUE_SIZE")
	public static var TEXTURE_BLUE_SIZE:Int;
	@:native("GL_TEXTURE_ALPHA_SIZE")
	public static var TEXTURE_ALPHA_SIZE:Int;
	@:native("GL_DOUBLE")
	public static var DOUBLE:Int;
	@:native("GL_PROXY_TEXTURE_1D")
	public static var PROXY_TEXTURE_1D:Int;
	@:native("GL_PROXY_TEXTURE_2D")
	public static var PROXY_TEXTURE_2D:Int;
	@:native("GL_R3_G3_B2")
	public static var R3_G3_B2:Int;
	@:native("GL_RGB4")
	public static var RGB4:Int;
	@:native("GL_RGB5")
	public static var RGB5:Int;
	@:native("GL_RGB8")
	public static var RGB8:Int;
	@:native("GL_RGB10")
	public static var RGB10:Int;
	@:native("GL_RGB12")
	public static var RGB12:Int;
	@:native("GL_RGB16")
	public static var RGB16:Int;
	@:native("GL_RGBA2")
	public static var RGBA2:Int;
	@:native("GL_RGBA4")
	public static var RGBA4:Int;
	@:native("GL_RGB5_A1")
	public static var RGB5_A1:Int;
	@:native("GL_RGBA8")
	public static var RGBA8:Int;
	@:native("GL_RGB10_A2")
	public static var RGB10_A2:Int;
	@:native("GL_RGBA12")
	public static var RGBA12:Int;
	@:native("GL_RGBA16")
	public static var RGBA16:Int;
	@:native("GL_UNSIGNED_BYTE_3_3_2")
	public static var UNSIGNED_BYTE_3_3_2:Int;
	@:native("GL_UNSIGNED_SHORT_4_4_4_4")
	public static var UNSIGNED_SHORT_4_4_4_4:Int;
	@:native("GL_UNSIGNED_SHORT_5_5_5_1")
	public static var UNSIGNED_SHORT_5_5_5_1:Int;
	@:native("GL_UNSIGNED_INT_8_8_8_8")
	public static var UNSIGNED_INT_8_8_8_8:Int;
	@:native("GL_UNSIGNED_INT_10_10_10_2")
	public static var UNSIGNED_INT_10_10_10_2:Int;
	@:native("GL_TEXTURE_BINDING_3D")
	public static var TEXTURE_BINDING_3D:Int;
	@:native("GL_PACK_SKIP_IMAGES")
	public static var PACK_SKIP_IMAGES:Int;
	@:native("GL_PACK_IMAGE_HEIGHT")
	public static var PACK_IMAGE_HEIGHT:Int;
	@:native("GL_UNPACK_SKIP_IMAGES")
	public static var UNPACK_SKIP_IMAGES:Int;
	@:native("GL_UNPACK_IMAGE_HEIGHT")
	public static var UNPACK_IMAGE_HEIGHT:Int;
	@:native("GL_TEXTURE_3D")
	public static var TEXTURE_3D:Int;
	@:native("GL_PROXY_TEXTURE_3D")
	public static var PROXY_TEXTURE_3D:Int;
	@:native("GL_TEXTURE_DEPTH")
	public static var TEXTURE_DEPTH:Int;
	@:native("GL_TEXTURE_WRAP_R")
	public static var TEXTURE_WRAP_R:Int;
	@:native("GL_MAX_3D_TEXTURE_SIZE")
	public static var MAX_3D_TEXTURE_SIZE:Int;
	@:native("GL_UNSIGNED_BYTE_2_3_3_REV")
	public static var UNSIGNED_BYTE_2_3_3_REV:Int;
	@:native("GL_UNSIGNED_SHORT_5_6_5")
	public static var UNSIGNED_SHORT_5_6_5:Int;
	@:native("GL_UNSIGNED_SHORT_5_6_5_REV")
	public static var UNSIGNED_SHORT_5_6_5_REV:Int;
	@:native("GL_UNSIGNED_SHORT_4_4_4_4_REV")
	public static var UNSIGNED_SHORT_4_4_4_4_REV:Int;
	@:native("GL_UNSIGNED_SHORT_1_5_5_5_REV")
	public static var UNSIGNED_SHORT_1_5_5_5_REV:Int;
	@:native("GL_UNSIGNED_INT_8_8_8_8_REV")
	public static var UNSIGNED_INT_8_8_8_8_REV:Int;
	@:native("GL_UNSIGNED_INT_2_10_10_10_REV")
	public static var UNSIGNED_INT_2_10_10_10_REV:Int;
	@:native("GL_BGR")
	public static var BGR:Int;
	@:native("GL_BGRA")
	public static var BGRA:Int;
	@:native("GL_MAX_ELEMENTS_VERTICES")
	public static var MAX_ELEMENTS_VERTICES:Int;
	@:native("GL_MAX_ELEMENTS_INDICES")
	public static var MAX_ELEMENTS_INDICES:Int;
	@:native("GL_CLAMP_TO_EDGE")
	public static var CLAMP_TO_EDGE:Int;
	@:native("GL_TEXTURE_MIN_LOD")
	public static var TEXTURE_MIN_LOD:Int;
	@:native("GL_TEXTURE_MAX_LOD")
	public static var TEXTURE_MAX_LOD:Int;
	@:native("GL_TEXTURE_BASE_LEVEL")
	public static var TEXTURE_BASE_LEVEL:Int;
	@:native("GL_TEXTURE_MAX_LEVEL")
	public static var TEXTURE_MAX_LEVEL:Int;
	@:native("GL_SMOOTH_POINT_SIZE_RANGE")
	public static var SMOOTH_POINT_SIZE_RANGE:Int;
	@:native("GL_SMOOTH_POINT_SIZE_GRANULARITY")
	public static var SMOOTH_POINT_SIZE_GRANULARITY:Int;
	@:native("GL_SMOOTH_LINE_WIDTH_RANGE")
	public static var SMOOTH_LINE_WIDTH_RANGE:Int;
	@:native("GL_SMOOTH_LINE_WIDTH_GRANULARITY")
	public static var SMOOTH_LINE_WIDTH_GRANULARITY:Int;
	@:native("GL_ALIASED_LINE_WIDTH_RANGE")
	public static var ALIASED_LINE_WIDTH_RANGE:Int;
	@:native("GL_TEXTURE0")
	public static var TEXTURE0:Int;
	@:native("GL_TEXTURE1")
	public static var TEXTURE1:Int;
	@:native("GL_TEXTURE2")
	public static var TEXTURE2:Int;
	@:native("GL_TEXTURE3")
	public static var TEXTURE3:Int;
	@:native("GL_TEXTURE4")
	public static var TEXTURE4:Int;
	@:native("GL_TEXTURE5")
	public static var TEXTURE5:Int;
	@:native("GL_TEXTURE6")
	public static var TEXTURE6:Int;
	@:native("GL_TEXTURE7")
	public static var TEXTURE7:Int;
	@:native("GL_TEXTURE8")
	public static var TEXTURE8:Int;
	@:native("GL_TEXTURE9")
	public static var TEXTURE9:Int;
	@:native("GL_TEXTURE10")
	public static var TEXTURE10:Int;
	@:native("GL_TEXTURE11")
	public static var TEXTURE11:Int;
	@:native("GL_TEXTURE12")
	public static var TEXTURE12:Int;
	@:native("GL_TEXTURE13")
	public static var TEXTURE13:Int;
	@:native("GL_TEXTURE14")
	public static var TEXTURE14:Int;
	@:native("GL_TEXTURE15")
	public static var TEXTURE15:Int;
	@:native("GL_TEXTURE16")
	public static var TEXTURE16:Int;
	@:native("GL_TEXTURE17")
	public static var TEXTURE17:Int;
	@:native("GL_TEXTURE18")
	public static var TEXTURE18:Int;
	@:native("GL_TEXTURE19")
	public static var TEXTURE19:Int;
	@:native("GL_TEXTURE20")
	public static var TEXTURE20:Int;
	@:native("GL_TEXTURE21")
	public static var TEXTURE21:Int;
	@:native("GL_TEXTURE22")
	public static var TEXTURE22:Int;
	@:native("GL_TEXTURE23")
	public static var TEXTURE23:Int;
	@:native("GL_TEXTURE24")
	public static var TEXTURE24:Int;
	@:native("GL_TEXTURE25")
	public static var TEXTURE25:Int;
	@:native("GL_TEXTURE26")
	public static var TEXTURE26:Int;
	@:native("GL_TEXTURE27")
	public static var TEXTURE27:Int;
	@:native("GL_TEXTURE28")
	public static var TEXTURE28:Int;
	@:native("GL_TEXTURE29")
	public static var TEXTURE29:Int;
	@:native("GL_TEXTURE30")
	public static var TEXTURE30:Int;
	@:native("GL_TEXTURE31")
	public static var TEXTURE31:Int;
	@:native("GL_ACTIVE_TEXTURE")
	public static var ACTIVE_TEXTURE:Int;
	@:native("GL_MULTISAMPLE")
	public static var MULTISAMPLE:Int;
	@:native("GL_SAMPLE_ALPHA_TO_COVERAGE")
	public static var SAMPLE_ALPHA_TO_COVERAGE:Int;
	@:native("GL_SAMPLE_ALPHA_TO_ONE")
	public static var SAMPLE_ALPHA_TO_ONE:Int;
	@:native("GL_SAMPLE_COVERAGE")
	public static var SAMPLE_COVERAGE:Int;
	@:native("GL_SAMPLE_BUFFERS")
	public static var SAMPLE_BUFFERS:Int;
	@:native("GL_SAMPLES")
	public static var SAMPLES:Int;
	@:native("GL_SAMPLE_COVERAGE_VALUE")
	public static var SAMPLE_COVERAGE_VALUE:Int;
	@:native("GL_SAMPLE_COVERAGE_INVERT")
	public static var SAMPLE_COVERAGE_INVERT:Int;
	@:native("GL_TEXTURE_CUBE_MAP")
	public static var TEXTURE_CUBE_MAP:Int;
	@:native("GL_TEXTURE_BINDING_CUBE_MAP")
	public static var TEXTURE_BINDING_CUBE_MAP:Int;
	@:native("GL_TEXTURE_CUBE_MAP_POSITIVE_X")
	public static var TEXTURE_CUBE_MAP_POSITIVE_X:Int;
	@:native("GL_TEXTURE_CUBE_MAP_NEGATIVE_X")
	public static var TEXTURE_CUBE_MAP_NEGATIVE_X:Int;
	@:native("GL_TEXTURE_CUBE_MAP_POSITIVE_Y")
	public static var TEXTURE_CUBE_MAP_POSITIVE_Y:Int;
	@:native("GL_TEXTURE_CUBE_MAP_NEGATIVE_Y")
	public static var TEXTURE_CUBE_MAP_NEGATIVE_Y:Int;
	@:native("GL_TEXTURE_CUBE_MAP_POSITIVE_Z")
	public static var TEXTURE_CUBE_MAP_POSITIVE_Z:Int;
	@:native("GL_TEXTURE_CUBE_MAP_NEGATIVE_Z")
	public static var TEXTURE_CUBE_MAP_NEGATIVE_Z:Int;
	@:native("GL_PROXY_TEXTURE_CUBE_MAP")
	public static var PROXY_TEXTURE_CUBE_MAP:Int;
	@:native("GL_MAX_CUBE_MAP_TEXTURE_SIZE")
	public static var MAX_CUBE_MAP_TEXTURE_SIZE:Int;
	@:native("GL_COMPRESSED_RGB")
	public static var COMPRESSED_RGB:Int;
	@:native("GL_COMPRESSED_RGBA")
	public static var COMPRESSED_RGBA:Int;
	@:native("GL_TEXTURE_COMPRESSION_HINT")
	public static var TEXTURE_COMPRESSION_HINT:Int;
	@:native("GL_TEXTURE_COMPRESSED_IMAGE_SIZE")
	public static var TEXTURE_COMPRESSED_IMAGE_SIZE:Int;
	@:native("GL_TEXTURE_COMPRESSED")
	public static var TEXTURE_COMPRESSED:Int;
	@:native("GL_NUM_COMPRESSED_TEXTURE_FORMATS")
	public static var NUM_COMPRESSED_TEXTURE_FORMATS:Int;
	@:native("GL_COMPRESSED_TEXTURE_FORMATS")
	public static var COMPRESSED_TEXTURE_FORMATS:Int;
	@:native("GL_CLAMP_TO_BORDER")
	public static var CLAMP_TO_BORDER:Int;
	@:native("GL_BLEND_DST_RGB")
	public static var BLEND_DST_RGB:Int;
	@:native("GL_BLEND_SRC_RGB")
	public static var BLEND_SRC_RGB:Int;
	@:native("GL_BLEND_DST_ALPHA")
	public static var BLEND_DST_ALPHA:Int;
	@:native("GL_BLEND_SRC_ALPHA")
	public static var BLEND_SRC_ALPHA:Int;
	@:native("GL_POINT_FADE_THRESHOLD_SIZE")
	public static var POINT_FADE_THRESHOLD_SIZE:Int;
	@:native("GL_DEPTH_COMPONENT16")
	public static var DEPTH_COMPONENT16:Int;
	@:native("GL_DEPTH_COMPONENT24")
	public static var DEPTH_COMPONENT24:Int;
	@:native("GL_DEPTH_COMPONENT32")
	public static var DEPTH_COMPONENT32:Int;
	@:native("GL_MIRRORED_REPEAT")
	public static var MIRRORED_REPEAT:Int;
	@:native("GL_MAX_TEXTURE_LOD_BIAS")
	public static var MAX_TEXTURE_LOD_BIAS:Int;
	@:native("GL_TEXTURE_LOD_BIAS")
	public static var TEXTURE_LOD_BIAS:Int;
	@:native("GL_INCR_WRAP")
	public static var INCR_WRAP:Int;
	@:native("GL_DECR_WRAP")
	public static var DECR_WRAP:Int;
	@:native("GL_TEXTURE_DEPTH_SIZE")
	public static var TEXTURE_DEPTH_SIZE:Int;
	@:native("GL_TEXTURE_COMPARE_MODE")
	public static var TEXTURE_COMPARE_MODE:Int;
	@:native("GL_TEXTURE_COMPARE_FUNC")
	public static var TEXTURE_COMPARE_FUNC:Int;
	@:native("GL_BLEND_COLOR")
	public static var BLEND_COLOR:Int;
	@:native("GL_BLEND_EQUATION")
	public static var BLEND_EQUATION:Int;
	@:native("GL_CONSTANT_COLOR")
	public static var CONSTANT_COLOR:Int;
	@:native("GL_ONE_MINUS_CONSTANT_COLOR")
	public static var ONE_MINUS_CONSTANT_COLOR:Int;
	@:native("GL_CONSTANT_ALPHA")
	public static var CONSTANT_ALPHA:Int;
	@:native("GL_ONE_MINUS_CONSTANT_ALPHA")
	public static var ONE_MINUS_CONSTANT_ALPHA:Int;
	@:native("GL_FUNC_ADD")
	public static var FUNC_ADD:Int;
	@:native("GL_FUNC_REVERSE_SUBTRACT")
	public static var FUNC_REVERSE_SUBTRACT:Int;
	@:native("GL_FUNC_SUBTRACT")
	public static var FUNC_SUBTRACT:Int;
	@:native("GL_MIN")
	public static var MIN:Int;
	@:native("GL_MAX")
	public static var MAX:Int;
	@:native("GL_BUFFER_SIZE")
	public static var BUFFER_SIZE:Int;
	@:native("GL_BUFFER_USAGE")
	public static var BUFFER_USAGE:Int;
	@:native("GL_QUERY_COUNTER_BITS")
	public static var QUERY_COUNTER_BITS:Int;
	@:native("GL_CURRENT_QUERY")
	public static var CURRENT_QUERY:Int;
	@:native("GL_QUERY_RESULT")
	public static var QUERY_RESULT:Int;
	@:native("GL_QUERY_RESULT_AVAILABLE")
	public static var QUERY_RESULT_AVAILABLE:Int;
	@:native("GL_ARRAY_BUFFER")
	public static var ARRAY_BUFFER:Int;
	@:native("GL_ELEMENT_ARRAY_BUFFER")
	public static var ELEMENT_ARRAY_BUFFER:Int;
	@:native("GL_ARRAY_BUFFER_BINDING")
	public static var ARRAY_BUFFER_BINDING:Int;
	@:native("GL_ELEMENT_ARRAY_BUFFER_BINDING")
	public static var ELEMENT_ARRAY_BUFFER_BINDING:Int;
	@:native("GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING")
	public static var VERTEX_ATTRIB_ARRAY_BUFFER_BINDING:Int;
	@:native("GL_READ_ONLY")
	public static var READ_ONLY:Int;
	@:native("GL_WRITE_ONLY")
	public static var WRITE_ONLY:Int;
	@:native("GL_READ_WRITE")
	public static var READ_WRITE:Int;
	@:native("GL_BUFFER_ACCESS")
	public static var BUFFER_ACCESS:Int;
	@:native("GL_BUFFER_MAPPED")
	public static var BUFFER_MAPPED:Int;
	@:native("GL_BUFFER_MAP_POINTER")
	public static var BUFFER_MAP_POINTER:Int;
	@:native("GL_STREAM_DRAW")
	public static var STREAM_DRAW:Int;
	@:native("GL_STREAM_READ")
	public static var STREAM_READ:Int;
	@:native("GL_STREAM_COPY")
	public static var STREAM_COPY:Int;
	@:native("GL_STATIC_DRAW")
	public static var STATIC_DRAW:Int;
	@:native("GL_STATIC_READ")
	public static var STATIC_READ:Int;
	@:native("GL_STATIC_COPY")
	public static var STATIC_COPY:Int;
	@:native("GL_DYNAMIC_DRAW")
	public static var DYNAMIC_DRAW:Int;
	@:native("GL_DYNAMIC_READ")
	public static var DYNAMIC_READ:Int;
	@:native("GL_DYNAMIC_COPY")
	public static var DYNAMIC_COPY:Int;
	@:native("GL_SAMPLES_PASSED")
	public static var SAMPLES_PASSED:Int;
	@:native("GL_SRC1_ALPHA")
	public static var SRC1_ALPHA:Int;
	@:native("GL_BLEND_EQUATION_RGB")
	public static var BLEND_EQUATION_RGB:Int;
	@:native("GL_VERTEX_ATTRIB_ARRAY_ENABLED")
	public static var VERTEX_ATTRIB_ARRAY_ENABLED:Int;
	@:native("GL_VERTEX_ATTRIB_ARRAY_SIZE")
	public static var VERTEX_ATTRIB_ARRAY_SIZE:Int;
	@:native("GL_VERTEX_ATTRIB_ARRAY_STRIDE")
	public static var VERTEX_ATTRIB_ARRAY_STRIDE:Int;
	@:native("GL_VERTEX_ATTRIB_ARRAY_TYPE")
	public static var VERTEX_ATTRIB_ARRAY_TYPE:Int;
	@:native("GL_CURRENT_VERTEX_ATTRIB")
	public static var CURRENT_VERTEX_ATTRIB:Int;
	@:native("GL_VERTEX_PROGRAM_POINT_SIZE")
	public static var VERTEX_PROGRAM_POINT_SIZE:Int;
	@:native("GL_VERTEX_ATTRIB_ARRAY_POINTER")
	public static var VERTEX_ATTRIB_ARRAY_POINTER:Int;
	@:native("GL_STENCIL_BACK_FUNC")
	public static var STENCIL_BACK_FUNC:Int;
	@:native("GL_STENCIL_BACK_FAIL")
	public static var STENCIL_BACK_FAIL:Int;
	@:native("GL_STENCIL_BACK_PASS_DEPTH_FAIL")
	public static var STENCIL_BACK_PASS_DEPTH_FAIL:Int;
	@:native("GL_STENCIL_BACK_PASS_DEPTH_PASS")
	public static var STENCIL_BACK_PASS_DEPTH_PASS:Int;
	@:native("GL_MAX_DRAW_BUFFERS")
	public static var MAX_DRAW_BUFFERS:Int;
	@:native("GL_DRAW_BUFFER0")
	public static var DRAW_BUFFER0:Int;
	@:native("GL_DRAW_BUFFER1")
	public static var DRAW_BUFFER1:Int;
	@:native("GL_DRAW_BUFFER2")
	public static var DRAW_BUFFER2:Int;
	@:native("GL_DRAW_BUFFER3")
	public static var DRAW_BUFFER3:Int;
	@:native("GL_DRAW_BUFFER4")
	public static var DRAW_BUFFER4:Int;
	@:native("GL_DRAW_BUFFER5")
	public static var DRAW_BUFFER5:Int;
	@:native("GL_DRAW_BUFFER6")
	public static var DRAW_BUFFER6:Int;
	@:native("GL_DRAW_BUFFER7")
	public static var DRAW_BUFFER7:Int;
	@:native("GL_DRAW_BUFFER8")
	public static var DRAW_BUFFER8:Int;
	@:native("GL_DRAW_BUFFER9")
	public static var DRAW_BUFFER9:Int;
	@:native("GL_DRAW_BUFFER10")
	public static var DRAW_BUFFER10:Int;
	@:native("GL_DRAW_BUFFER11")
	public static var DRAW_BUFFER11:Int;
	@:native("GL_DRAW_BUFFER12")
	public static var DRAW_BUFFER12:Int;
	@:native("GL_DRAW_BUFFER13")
	public static var DRAW_BUFFER13:Int;
	@:native("GL_DRAW_BUFFER14")
	public static var DRAW_BUFFER14:Int;
	@:native("GL_DRAW_BUFFER15")
	public static var DRAW_BUFFER15:Int;
	@:native("GL_BLEND_EQUATION_ALPHA")
	public static var BLEND_EQUATION_ALPHA:Int;
	@:native("GL_MAX_VERTEX_ATTRIBS")
	public static var MAX_VERTEX_ATTRIBS:Int;
	@:native("GL_VERTEX_ATTRIB_ARRAY_NORMALIZED")
	public static var VERTEX_ATTRIB_ARRAY_NORMALIZED:Int;
	@:native("GL_MAX_TEXTURE_IMAGE_UNITS")
	public static var MAX_TEXTURE_IMAGE_UNITS:Int;
	@:native("GL_FRAGMENT_SHADER")
	public static var FRAGMENT_SHADER:Int;
	@:native("GL_VERTEX_SHADER")
	public static var VERTEX_SHADER:Int;
	@:native("GL_MAX_FRAGMENT_UNIFORM_COMPONENTS")
	public static var MAX_FRAGMENT_UNIFORM_COMPONENTS:Int;
	@:native("GL_MAX_VERTEX_UNIFORM_COMPONENTS")
	public static var MAX_VERTEX_UNIFORM_COMPONENTS:Int;
	@:native("GL_MAX_VARYING_FLOATS")
	public static var MAX_VARYING_FLOATS:Int;
	@:native("GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS")
	public static var MAX_VERTEX_TEXTURE_IMAGE_UNITS:Int;
	@:native("GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS")
	public static var MAX_COMBINED_TEXTURE_IMAGE_UNITS:Int;
	@:native("GL_SHADER_TYPE")
	public static var SHADER_TYPE:Int;
	@:native("GL_FLOAT_VEC2")
	public static var FLOAT_VEC2:Int;
	@:native("GL_FLOAT_VEC3")
	public static var FLOAT_VEC3:Int;
	@:native("GL_FLOAT_VEC4")
	public static var FLOAT_VEC4:Int;
	@:native("GL_INT_VEC2")
	public static var INT_VEC2:Int;
	@:native("GL_INT_VEC3")
	public static var INT_VEC3:Int;
	@:native("GL_INT_VEC4")
	public static var INT_VEC4:Int;
	@:native("GL_BOOL")
	public static var BOOL:Int;
	@:native("GL_BOOL_VEC2")
	public static var BOOL_VEC2:Int;
	@:native("GL_BOOL_VEC3")
	public static var BOOL_VEC3:Int;
	@:native("GL_BOOL_VEC4")
	public static var BOOL_VEC4:Int;
	@:native("GL_FLOAT_MAT2")
	public static var FLOAT_MAT2:Int;
	@:native("GL_FLOAT_MAT3")
	public static var FLOAT_MAT3:Int;
	@:native("GL_FLOAT_MAT4")
	public static var FLOAT_MAT4:Int;
	@:native("GL_SAMPLER_1D")
	public static var SAMPLER_1D:Int;
	@:native("GL_SAMPLER_2D")
	public static var SAMPLER_2D:Int;
	@:native("GL_SAMPLER_3D")
	public static var SAMPLER_3D:Int;
	@:native("GL_SAMPLER_CUBE")
	public static var SAMPLER_CUBE:Int;
	@:native("GL_SAMPLER_1D_SHADOW")
	public static var SAMPLER_1D_SHADOW:Int;
	@:native("GL_SAMPLER_2D_SHADOW")
	public static var SAMPLER_2D_SHADOW:Int;
	@:native("GL_DELETE_STATUS")
	public static var DELETE_STATUS:Int;
	@:native("GL_COMPILE_STATUS")
	public static var COMPILE_STATUS:Int;
	@:native("GL_LINK_STATUS")
	public static var LINK_STATUS:Int;
	@:native("GL_VALIDATE_STATUS")
	public static var VALIDATE_STATUS:Int;
	@:native("GL_INFO_LOG_LENGTH")
	public static var INFO_LOG_LENGTH:Int;
	@:native("GL_ATTACHED_SHADERS")
	public static var ATTACHED_SHADERS:Int;
	@:native("GL_ACTIVE_UNIFORMS")
	public static var ACTIVE_UNIFORMS:Int;
	@:native("GL_ACTIVE_UNIFORM_MAX_LENGTH")
	public static var ACTIVE_UNIFORM_MAX_LENGTH:Int;
	@:native("GL_SHADER_SOURCE_LENGTH")
	public static var SHADER_SOURCE_LENGTH:Int;
	@:native("GL_ACTIVE_ATTRIBUTES")
	public static var ACTIVE_ATTRIBUTES:Int;
	@:native("GL_ACTIVE_ATTRIBUTE_MAX_LENGTH")
	public static var ACTIVE_ATTRIBUTE_MAX_LENGTH:Int;
	@:native("GL_FRAGMENT_SHADER_DERIVATIVE_HINT")
	public static var FRAGMENT_SHADER_DERIVATIVE_HINT:Int;
	@:native("GL_SHADING_LANGUAGE_VERSION")
	public static var SHADING_LANGUAGE_VERSION:Int;
	@:native("GL_CURRENT_PROGRAM")
	public static var CURRENT_PROGRAM:Int;
	@:native("GL_POINT_SPRITE_COORD_ORIGIN")
	public static var POINT_SPRITE_COORD_ORIGIN:Int;
	@:native("GL_LOWER_LEFT")
	public static var LOWER_LEFT:Int;
	@:native("GL_UPPER_LEFT")
	public static var UPPER_LEFT:Int;
	@:native("GL_STENCIL_BACK_REF")
	public static var STENCIL_BACK_REF:Int;
	@:native("GL_STENCIL_BACK_VALUE_MASK")
	public static var STENCIL_BACK_VALUE_MASK:Int;
	@:native("GL_STENCIL_BACK_WRITEMASK")
	public static var STENCIL_BACK_WRITEMASK:Int;
	@:native("GL_PIXEL_PACK_BUFFER")
	public static var PIXEL_PACK_BUFFER:Int;
	@:native("GL_PIXEL_UNPACK_BUFFER")
	public static var PIXEL_UNPACK_BUFFER:Int;
	@:native("GL_PIXEL_PACK_BUFFER_BINDING")
	public static var PIXEL_PACK_BUFFER_BINDING:Int;
	@:native("GL_PIXEL_UNPACK_BUFFER_BINDING")
	public static var PIXEL_UNPACK_BUFFER_BINDING:Int;
	@:native("GL_FLOAT_MAT2x3")
	public static var FLOAT_MAT2x3:Int;
	@:native("GL_FLOAT_MAT2x4")
	public static var FLOAT_MAT2x4:Int;
	@:native("GL_FLOAT_MAT3x2")
	public static var FLOAT_MAT3x2:Int;
	@:native("GL_FLOAT_MAT3x4")
	public static var FLOAT_MAT3x4:Int;
	@:native("GL_FLOAT_MAT4x2")
	public static var FLOAT_MAT4x2:Int;
	@:native("GL_FLOAT_MAT4x3")
	public static var FLOAT_MAT4x3:Int;
	@:native("GL_SRGB")
	public static var SRGB:Int;
	@:native("GL_SRGB8")
	public static var SRGB8:Int;
	@:native("GL_SRGB_ALPHA")
	public static var SRGB_ALPHA:Int;
	@:native("GL_SRGB8_ALPHA8")
	public static var SRGB8_ALPHA8:Int;
	@:native("GL_COMPRESSED_SRGB")
	public static var COMPRESSED_SRGB:Int;
	@:native("GL_COMPRESSED_SRGB_ALPHA")
	public static var COMPRESSED_SRGB_ALPHA:Int;
	@:native("GL_COMPARE_REF_TO_TEXTURE")
	public static var COMPARE_REF_TO_TEXTURE:Int;
	@:native("GL_CLIP_DISTANCE0")
	public static var CLIP_DISTANCE0:Int;
	@:native("GL_CLIP_DISTANCE1")
	public static var CLIP_DISTANCE1:Int;
	@:native("GL_CLIP_DISTANCE2")
	public static var CLIP_DISTANCE2:Int;
	@:native("GL_CLIP_DISTANCE3")
	public static var CLIP_DISTANCE3:Int;
	@:native("GL_CLIP_DISTANCE4")
	public static var CLIP_DISTANCE4:Int;
	@:native("GL_CLIP_DISTANCE5")
	public static var CLIP_DISTANCE5:Int;
	@:native("GL_CLIP_DISTANCE6")
	public static var CLIP_DISTANCE6:Int;
	@:native("GL_CLIP_DISTANCE7")
	public static var CLIP_DISTANCE7:Int;
	@:native("GL_MAX_CLIP_DISTANCES")
	public static var MAX_CLIP_DISTANCES:Int;
	@:native("GL_MAJOR_VERSION")
	public static var MAJOR_VERSION:Int;
	@:native("GL_MINOR_VERSION")
	public static var MINOR_VERSION:Int;
	@:native("GL_NUM_EXTENSIONS")
	public static var NUM_EXTENSIONS:Int;
	@:native("GL_CONTEXT_FLAGS")
	public static var CONTEXT_FLAGS:Int;
	@:native("GL_COMPRESSED_RED")
	public static var COMPRESSED_RED:Int;
	@:native("GL_COMPRESSED_RG")
	public static var COMPRESSED_RG:Int;
	@:native("GL_CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT")
	public static var CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT:Int;
	@:native("GL_RGBA32F")
	public static var RGBA32F:Int;
	@:native("GL_RGB32F")
	public static var RGB32F:Int;
	@:native("GL_RGBA16F")
	public static var RGBA16F:Int;
	@:native("GL_RGB16F")
	public static var RGB16F:Int;
	@:native("GL_VERTEX_ATTRIB_ARRAY_INTEGER")
	public static var VERTEX_ATTRIB_ARRAY_INTEGER:Int;
	@:native("GL_MAX_ARRAY_TEXTURE_LAYERS")
	public static var MAX_ARRAY_TEXTURE_LAYERS:Int;
	@:native("GL_MIN_PROGRAM_TEXEL_OFFSET")
	public static var MIN_PROGRAM_TEXEL_OFFSET:Int;
	@:native("GL_MAX_PROGRAM_TEXEL_OFFSET")
	public static var MAX_PROGRAM_TEXEL_OFFSET:Int;
	@:native("GL_CLAMP_READ_COLOR")
	public static var CLAMP_READ_COLOR:Int;
	@:native("GL_FIXED_ONLY")
	public static var FIXED_ONLY:Int;
	@:native("GL_MAX_VARYING_COMPONENTS")
	public static var MAX_VARYING_COMPONENTS:Int;
	@:native("GL_TEXTURE_1D_ARRAY")
	public static var TEXTURE_1D_ARRAY:Int;
	@:native("GL_PROXY_TEXTURE_1D_ARRAY")
	public static var PROXY_TEXTURE_1D_ARRAY:Int;
	@:native("GL_TEXTURE_2D_ARRAY")
	public static var TEXTURE_2D_ARRAY:Int;
	@:native("GL_PROXY_TEXTURE_2D_ARRAY")
	public static var PROXY_TEXTURE_2D_ARRAY:Int;
	@:native("GL_TEXTURE_BINDING_1D_ARRAY")
	public static var TEXTURE_BINDING_1D_ARRAY:Int;
	@:native("GL_TEXTURE_BINDING_2D_ARRAY")
	public static var TEXTURE_BINDING_2D_ARRAY:Int;
	@:native("GL_R11F_G11F_B10F")
	public static var R11F_G11F_B10F:Int;
	@:native("GL_UNSIGNED_INT_10F_11F_11F_REV")
	public static var UNSIGNED_INT_10F_11F_11F_REV:Int;
	@:native("GL_RGB9_E5")
	public static var RGB9_E5:Int;
	@:native("GL_UNSIGNED_INT_5_9_9_9_REV")
	public static var UNSIGNED_INT_5_9_9_9_REV:Int;
	@:native("GL_TEXTURE_SHARED_SIZE")
	public static var TEXTURE_SHARED_SIZE:Int;
	@:native("GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH")
	public static var TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH:Int;
	@:native("GL_TRANSFORM_FEEDBACK_BUFFER_MODE")
	public static var TRANSFORM_FEEDBACK_BUFFER_MODE:Int;
	@:native("GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS")
	public static var MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS:Int;
	@:native("GL_TRANSFORM_FEEDBACK_VARYINGS")
	public static var TRANSFORM_FEEDBACK_VARYINGS:Int;
	@:native("GL_TRANSFORM_FEEDBACK_BUFFER_START")
	public static var TRANSFORM_FEEDBACK_BUFFER_START:Int;
	@:native("GL_TRANSFORM_FEEDBACK_BUFFER_SIZE")
	public static var TRANSFORM_FEEDBACK_BUFFER_SIZE:Int;
	@:native("GL_PRIMITIVES_GENERATED")
	public static var PRIMITIVES_GENERATED:Int;
	@:native("GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN")
	public static var TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN:Int;
	@:native("GL_RASTERIZER_DISCARD")
	public static var RASTERIZER_DISCARD:Int;
	@:native("GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS")
	public static var MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS:Int;
	@:native("GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS")
	public static var MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS:Int;
	@:native("GL_INTERLEAVED_ATTRIBS")
	public static var INTERLEAVED_ATTRIBS:Int;
	@:native("GL_SEPARATE_ATTRIBS")
	public static var SEPARATE_ATTRIBS:Int;
	@:native("GL_TRANSFORM_FEEDBACK_BUFFER")
	public static var TRANSFORM_FEEDBACK_BUFFER:Int;
	@:native("GL_TRANSFORM_FEEDBACK_BUFFER_BINDING")
	public static var TRANSFORM_FEEDBACK_BUFFER_BINDING:Int;
	@:native("GL_RGBA32UI")
	public static var RGBA32UI:Int;
	@:native("GL_RGB32UI")
	public static var RGB32UI:Int;
	@:native("GL_RGBA16UI")
	public static var RGBA16UI:Int;
	@:native("GL_RGB16UI")
	public static var RGB16UI:Int;
	@:native("GL_RGBA8UI")
	public static var RGBA8UI:Int;
	@:native("GL_RGB8UI")
	public static var RGB8UI:Int;
	@:native("GL_RGBA32I")
	public static var RGBA32I:Int;
	@:native("GL_RGB32I")
	public static var RGB32I:Int;
	@:native("GL_RGBA16I")
	public static var RGBA16I:Int;
	@:native("GL_RGB16I")
	public static var RGB16I:Int;
	@:native("GL_RGBA8I")
	public static var RGBA8I:Int;
	@:native("GL_RGB8I")
	public static var RGB8I:Int;
	@:native("GL_RED_INTEGER")
	public static var RED_INTEGER:Int;
	@:native("GL_GREEN_INTEGER")
	public static var GREEN_INTEGER:Int;
	@:native("GL_BLUE_INTEGER")
	public static var BLUE_INTEGER:Int;
	@:native("GL_RGB_INTEGER")
	public static var RGB_INTEGER:Int;
	@:native("GL_RGBA_INTEGER")
	public static var RGBA_INTEGER:Int;
	@:native("GL_BGR_INTEGER")
	public static var BGR_INTEGER:Int;
	@:native("GL_BGRA_INTEGER")
	public static var BGRA_INTEGER:Int;
	@:native("GL_SAMPLER_1D_ARRAY")
	public static var SAMPLER_1D_ARRAY:Int;
	@:native("GL_SAMPLER_2D_ARRAY")
	public static var SAMPLER_2D_ARRAY:Int;
	@:native("GL_SAMPLER_1D_ARRAY_SHADOW")
	public static var SAMPLER_1D_ARRAY_SHADOW:Int;
	@:native("GL_SAMPLER_2D_ARRAY_SHADOW")
	public static var SAMPLER_2D_ARRAY_SHADOW:Int;
	@:native("GL_SAMPLER_CUBE_SHADOW")
	public static var SAMPLER_CUBE_SHADOW:Int;
	@:native("GL_UNSIGNED_INT_VEC2")
	public static var UNSIGNED_INT_VEC2:Int;
	@:native("GL_UNSIGNED_INT_VEC3")
	public static var UNSIGNED_INT_VEC3:Int;
	@:native("GL_UNSIGNED_INT_VEC4")
	public static var UNSIGNED_INT_VEC4:Int;
	@:native("GL_INT_SAMPLER_1D")
	public static var INT_SAMPLER_1D:Int;
	@:native("GL_INT_SAMPLER_2D")
	public static var INT_SAMPLER_2D:Int;
	@:native("GL_INT_SAMPLER_3D")
	public static var INT_SAMPLER_3D:Int;
	@:native("GL_INT_SAMPLER_CUBE")
	public static var INT_SAMPLER_CUBE:Int;
	@:native("GL_INT_SAMPLER_1D_ARRAY")
	public static var INT_SAMPLER_1D_ARRAY:Int;
	@:native("GL_INT_SAMPLER_2D_ARRAY")
	public static var INT_SAMPLER_2D_ARRAY:Int;
	@:native("GL_UNSIGNED_INT_SAMPLER_1D")
	public static var UNSIGNED_INT_SAMPLER_1D:Int;
	@:native("GL_UNSIGNED_INT_SAMPLER_2D")
	public static var UNSIGNED_INT_SAMPLER_2D:Int;
	@:native("GL_UNSIGNED_INT_SAMPLER_3D")
	public static var UNSIGNED_INT_SAMPLER_3D:Int;
	@:native("GL_UNSIGNED_INT_SAMPLER_CUBE")
	public static var UNSIGNED_INT_SAMPLER_CUBE:Int;
	@:native("GL_UNSIGNED_INT_SAMPLER_1D_ARRAY")
	public static var UNSIGNED_INT_SAMPLER_1D_ARRAY:Int;
	@:native("GL_UNSIGNED_INT_SAMPLER_2D_ARRAY")
	public static var UNSIGNED_INT_SAMPLER_2D_ARRAY:Int;
	@:native("GL_QUERY_WAIT")
	public static var QUERY_WAIT:Int;
	@:native("GL_QUERY_NO_WAIT")
	public static var QUERY_NO_WAIT:Int;
	@:native("GL_QUERY_BY_REGION_WAIT")
	public static var QUERY_BY_REGION_WAIT:Int;
	@:native("GL_QUERY_BY_REGION_NO_WAIT")
	public static var QUERY_BY_REGION_NO_WAIT:Int;
	@:native("GL_BUFFER_ACCESS_FLAGS")
	public static var BUFFER_ACCESS_FLAGS:Int;
	@:native("GL_BUFFER_MAP_LENGTH")
	public static var BUFFER_MAP_LENGTH:Int;
	@:native("GL_BUFFER_MAP_OFFSET")
	public static var BUFFER_MAP_OFFSET:Int;
	@:native("GL_DEPTH_COMPONENT32F")
	public static var DEPTH_COMPONENT32F:Int;
	@:native("GL_DEPTH32F_STENCIL8")
	public static var DEPTH32F_STENCIL8:Int;
	@:native("GL_FLOAT_32_UNSIGNED_INT_24_8_REV")
	public static var FLOAT_32_UNSIGNED_INT_24_8_REV:Int;
	@:native("GL_INVALID_FRAMEBUFFER_OPERATION")
	public static var INVALID_FRAMEBUFFER_OPERATION:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING")
	public static var FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE")
	public static var FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE")
	public static var FRAMEBUFFER_ATTACHMENT_RED_SIZE:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE")
	public static var FRAMEBUFFER_ATTACHMENT_GREEN_SIZE:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE")
	public static var FRAMEBUFFER_ATTACHMENT_BLUE_SIZE:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE")
	public static var FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE")
	public static var FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE")
	public static var FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE:Int;
	@:native("GL_FRAMEBUFFER_DEFAULT")
	public static var FRAMEBUFFER_DEFAULT:Int;
	@:native("GL_FRAMEBUFFER_UNDEFINED")
	public static var FRAMEBUFFER_UNDEFINED:Int;
	@:native("GL_DEPTH_STENCIL_ATTACHMENT")
	public static var DEPTH_STENCIL_ATTACHMENT:Int;
	@:native("GL_MAX_RENDERBUFFER_SIZE")
	public static var MAX_RENDERBUFFER_SIZE:Int;
	@:native("GL_DEPTH_STENCIL")
	public static var DEPTH_STENCIL:Int;
	@:native("GL_UNSIGNED_INT_24_8")
	public static var UNSIGNED_INT_24_8:Int;
	@:native("GL_DEPTH24_STENCIL8")
	public static var DEPTH24_STENCIL8:Int;
	@:native("GL_TEXTURE_STENCIL_SIZE")
	public static var TEXTURE_STENCIL_SIZE:Int;
	@:native("GL_TEXTURE_RED_TYPE")
	public static var TEXTURE_RED_TYPE:Int;
	@:native("GL_TEXTURE_GREEN_TYPE")
	public static var TEXTURE_GREEN_TYPE:Int;
	@:native("GL_TEXTURE_BLUE_TYPE")
	public static var TEXTURE_BLUE_TYPE:Int;
	@:native("GL_TEXTURE_ALPHA_TYPE")
	public static var TEXTURE_ALPHA_TYPE:Int;
	@:native("GL_TEXTURE_DEPTH_TYPE")
	public static var TEXTURE_DEPTH_TYPE:Int;
	@:native("GL_UNSIGNED_NORMALIZED")
	public static var UNSIGNED_NORMALIZED:Int;
	@:native("GL_FRAMEBUFFER_BINDING")
	public static var FRAMEBUFFER_BINDING:Int;
	@:native("GL_DRAW_FRAMEBUFFER_BINDING")
	public static var DRAW_FRAMEBUFFER_BINDING:Int;
	@:native("GL_RENDERBUFFER_BINDING")
	public static var RENDERBUFFER_BINDING:Int;
	@:native("GL_READ_FRAMEBUFFER")
	public static var READ_FRAMEBUFFER:Int;
	@:native("GL_DRAW_FRAMEBUFFER")
	public static var DRAW_FRAMEBUFFER:Int;
	@:native("GL_READ_FRAMEBUFFER_BINDING")
	public static var READ_FRAMEBUFFER_BINDING:Int;
	@:native("GL_RENDERBUFFER_SAMPLES")
	public static var RENDERBUFFER_SAMPLES:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE")
	public static var FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME")
	public static var FRAMEBUFFER_ATTACHMENT_OBJECT_NAME:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL")
	public static var FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE")
	public static var FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER")
	public static var FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER:Int;
	@:native("GL_FRAMEBUFFER_COMPLETE")
	public static var FRAMEBUFFER_COMPLETE:Int;
	@:native("GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT")
	public static var FRAMEBUFFER_INCOMPLETE_ATTACHMENT:Int;
	@:native("GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT")
	public static var FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT:Int;
	@:native("GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER")
	public static var FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER:Int;
	@:native("GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER")
	public static var FRAMEBUFFER_INCOMPLETE_READ_BUFFER:Int;
	@:native("GL_FRAMEBUFFER_UNSUPPORTED")
	public static var FRAMEBUFFER_UNSUPPORTED:Int;
	@:native("GL_MAX_COLOR_ATTACHMENTS")
	public static var MAX_COLOR_ATTACHMENTS:Int;
	@:native("GL_COLOR_ATTACHMENT0")
	public static var COLOR_ATTACHMENT0:Int;
	@:native("GL_COLOR_ATTACHMENT1")
	public static var COLOR_ATTACHMENT1:Int;
	@:native("GL_COLOR_ATTACHMENT2")
	public static var COLOR_ATTACHMENT2:Int;
	@:native("GL_COLOR_ATTACHMENT3")
	public static var COLOR_ATTACHMENT3:Int;
	@:native("GL_COLOR_ATTACHMENT4")
	public static var COLOR_ATTACHMENT4:Int;
	@:native("GL_COLOR_ATTACHMENT5")
	public static var COLOR_ATTACHMENT5:Int;
	@:native("GL_COLOR_ATTACHMENT6")
	public static var COLOR_ATTACHMENT6:Int;
	@:native("GL_COLOR_ATTACHMENT7")
	public static var COLOR_ATTACHMENT7:Int;
	@:native("GL_COLOR_ATTACHMENT8")
	public static var COLOR_ATTACHMENT8:Int;
	@:native("GL_COLOR_ATTACHMENT9")
	public static var COLOR_ATTACHMENT9:Int;
	@:native("GL_COLOR_ATTACHMENT10")
	public static var COLOR_ATTACHMENT10:Int;
	@:native("GL_COLOR_ATTACHMENT11")
	public static var COLOR_ATTACHMENT11:Int;
	@:native("GL_COLOR_ATTACHMENT12")
	public static var COLOR_ATTACHMENT12:Int;
	@:native("GL_COLOR_ATTACHMENT13")
	public static var COLOR_ATTACHMENT13:Int;
	@:native("GL_COLOR_ATTACHMENT14")
	public static var COLOR_ATTACHMENT14:Int;
	@:native("GL_COLOR_ATTACHMENT15")
	public static var COLOR_ATTACHMENT15:Int;
	@:native("GL_COLOR_ATTACHMENT16")
	public static var COLOR_ATTACHMENT16:Int;
	@:native("GL_COLOR_ATTACHMENT17")
	public static var COLOR_ATTACHMENT17:Int;
	@:native("GL_COLOR_ATTACHMENT18")
	public static var COLOR_ATTACHMENT18:Int;
	@:native("GL_COLOR_ATTACHMENT19")
	public static var COLOR_ATTACHMENT19:Int;
	@:native("GL_COLOR_ATTACHMENT20")
	public static var COLOR_ATTACHMENT20:Int;
	@:native("GL_COLOR_ATTACHMENT21")
	public static var COLOR_ATTACHMENT21:Int;
	@:native("GL_COLOR_ATTACHMENT22")
	public static var COLOR_ATTACHMENT22:Int;
	@:native("GL_COLOR_ATTACHMENT23")
	public static var COLOR_ATTACHMENT23:Int;
	@:native("GL_COLOR_ATTACHMENT24")
	public static var COLOR_ATTACHMENT24:Int;
	@:native("GL_COLOR_ATTACHMENT25")
	public static var COLOR_ATTACHMENT25:Int;
	@:native("GL_COLOR_ATTACHMENT26")
	public static var COLOR_ATTACHMENT26:Int;
	@:native("GL_COLOR_ATTACHMENT27")
	public static var COLOR_ATTACHMENT27:Int;
	@:native("GL_COLOR_ATTACHMENT28")
	public static var COLOR_ATTACHMENT28:Int;
	@:native("GL_COLOR_ATTACHMENT29")
	public static var COLOR_ATTACHMENT29:Int;
	@:native("GL_COLOR_ATTACHMENT30")
	public static var COLOR_ATTACHMENT30:Int;
	@:native("GL_COLOR_ATTACHMENT31")
	public static var COLOR_ATTACHMENT31:Int;
	@:native("GL_DEPTH_ATTACHMENT")
	public static var DEPTH_ATTACHMENT:Int;
	@:native("GL_STENCIL_ATTACHMENT")
	public static var STENCIL_ATTACHMENT:Int;
	@:native("GL_FRAMEBUFFER")
	public static var FRAMEBUFFER:Int;
	@:native("GL_RENDERBUFFER")
	public static var RENDERBUFFER:Int;
	@:native("GL_RENDERBUFFER_WIDTH")
	public static var RENDERBUFFER_WIDTH:Int;
	@:native("GL_RENDERBUFFER_HEIGHT")
	public static var RENDERBUFFER_HEIGHT:Int;
	@:native("GL_RENDERBUFFER_INTERNAL_FORMAT")
	public static var RENDERBUFFER_INTERNAL_FORMAT:Int;
	@:native("GL_STENCIL_INDEX1")
	public static var STENCIL_INDEX1:Int;
	@:native("GL_STENCIL_INDEX4")
	public static var STENCIL_INDEX4:Int;
	@:native("GL_STENCIL_INDEX8")
	public static var STENCIL_INDEX8:Int;
	@:native("GL_STENCIL_INDEX16")
	public static var STENCIL_INDEX16:Int;
	@:native("GL_RENDERBUFFER_RED_SIZE")
	public static var RENDERBUFFER_RED_SIZE:Int;
	@:native("GL_RENDERBUFFER_GREEN_SIZE")
	public static var RENDERBUFFER_GREEN_SIZE:Int;
	@:native("GL_RENDERBUFFER_BLUE_SIZE")
	public static var RENDERBUFFER_BLUE_SIZE:Int;
	@:native("GL_RENDERBUFFER_ALPHA_SIZE")
	public static var RENDERBUFFER_ALPHA_SIZE:Int;
	@:native("GL_RENDERBUFFER_DEPTH_SIZE")
	public static var RENDERBUFFER_DEPTH_SIZE:Int;
	@:native("GL_RENDERBUFFER_STENCIL_SIZE")
	public static var RENDERBUFFER_STENCIL_SIZE:Int;
	@:native("GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE")
	public static var FRAMEBUFFER_INCOMPLETE_MULTISAMPLE:Int;
	@:native("GL_MAX_SAMPLES")
	public static var MAX_SAMPLES:Int;
	@:native("GL_FRAMEBUFFER_SRGB")
	public static var FRAMEBUFFER_SRGB:Int;
	@:native("GL_HALF_FLOAT")
	public static var HALF_FLOAT:Int;
	@:native("GL_MAP_READ_BIT")
	public static var MAP_READ_BIT:Int;
	@:native("GL_MAP_WRITE_BIT")
	public static var MAP_WRITE_BIT:Int;
	@:native("GL_MAP_INVALIDATE_RANGE_BIT")
	public static var MAP_INVALIDATE_RANGE_BIT:Int;
	@:native("GL_MAP_INVALIDATE_BUFFER_BIT")
	public static var MAP_INVALIDATE_BUFFER_BIT:Int;
	@:native("GL_MAP_FLUSH_EXPLICIT_BIT")
	public static var MAP_FLUSH_EXPLICIT_BIT:Int;
	@:native("GL_MAP_UNSYNCHRONIZED_BIT")
	public static var MAP_UNSYNCHRONIZED_BIT:Int;
	@:native("GL_COMPRESSED_RED_RGTC1")
	public static var COMPRESSED_RED_RGTC1:Int;
	@:native("GL_COMPRESSED_SIGNED_RED_RGTC1")
	public static var COMPRESSED_SIGNED_RED_RGTC1:Int;
	@:native("GL_COMPRESSED_RG_RGTC2")
	public static var COMPRESSED_RG_RGTC2:Int;
	@:native("GL_COMPRESSED_SIGNED_RG_RGTC2")
	public static var COMPRESSED_SIGNED_RG_RGTC2:Int;
	@:native("GL_RG")
	public static var RG:Int;
	@:native("GL_RG_INTEGER")
	public static var RG_INTEGER:Int;
	@:native("GL_R8")
	public static var R8:Int;
	@:native("GL_R16")
	public static var R16:Int;
	@:native("GL_RG8")
	public static var RG8:Int;
	@:native("GL_RG16")
	public static var RG16:Int;
	@:native("GL_R16F")
	public static var R16F:Int;
	@:native("GL_R32F")
	public static var R32F:Int;
	@:native("GL_RG16F")
	public static var RG16F:Int;
	@:native("GL_RG32F")
	public static var RG32F:Int;
	@:native("GL_R8I")
	public static var R8I:Int;
	@:native("GL_R8UI")
	public static var R8UI:Int;
	@:native("GL_R16I")
	public static var R16I:Int;
	@:native("GL_R16UI")
	public static var R16UI:Int;
	@:native("GL_R32I")
	public static var R32I:Int;
	@:native("GL_R32UI")
	public static var R32UI:Int;
	@:native("GL_RG8I")
	public static var RG8I:Int;
	@:native("GL_RG8UI")
	public static var RG8UI:Int;
	@:native("GL_RG16I")
	public static var RG16I:Int;
	@:native("GL_RG16UI")
	public static var RG16UI:Int;
	@:native("GL_RG32I")
	public static var RG32I:Int;
	@:native("GL_RG32UI")
	public static var RG32UI:Int;
	@:native("GL_VERTEX_ARRAY_BINDING")
	public static var VERTEX_ARRAY_BINDING:Int;
	@:native("GL_SAMPLER_2D_RECT")
	public static var SAMPLER_2D_RECT:Int;
	@:native("GL_SAMPLER_2D_RECT_SHADOW")
	public static var SAMPLER_2D_RECT_SHADOW:Int;
	@:native("GL_SAMPLER_BUFFER")
	public static var SAMPLER_BUFFER:Int;
	@:native("GL_INT_SAMPLER_2D_RECT")
	public static var INT_SAMPLER_2D_RECT:Int;
	@:native("GL_INT_SAMPLER_BUFFER")
	public static var INT_SAMPLER_BUFFER:Int;
	@:native("GL_UNSIGNED_INT_SAMPLER_2D_RECT")
	public static var UNSIGNED_INT_SAMPLER_2D_RECT:Int;
	@:native("GL_UNSIGNED_INT_SAMPLER_BUFFER")
	public static var UNSIGNED_INT_SAMPLER_BUFFER:Int;
	@:native("GL_TEXTURE_BUFFER")
	public static var TEXTURE_BUFFER:Int;
	@:native("GL_MAX_TEXTURE_BUFFER_SIZE")
	public static var MAX_TEXTURE_BUFFER_SIZE:Int;
	@:native("GL_TEXTURE_BINDING_BUFFER")
	public static var TEXTURE_BINDING_BUFFER:Int;
	@:native("GL_TEXTURE_BUFFER_DATA_STORE_BINDING")
	public static var TEXTURE_BUFFER_DATA_STORE_BINDING:Int;
	@:native("GL_TEXTURE_RECTANGLE")
	public static var TEXTURE_RECTANGLE:Int;
	@:native("GL_TEXTURE_BINDING_RECTANGLE")
	public static var TEXTURE_BINDING_RECTANGLE:Int;
	@:native("GL_PROXY_TEXTURE_RECTANGLE")
	public static var PROXY_TEXTURE_RECTANGLE:Int;
	@:native("GL_MAX_RECTANGLE_TEXTURE_SIZE")
	public static var MAX_RECTANGLE_TEXTURE_SIZE:Int;
	@:native("GL_R8_SNORM")
	public static var R8_SNORM:Int;
	@:native("GL_RG8_SNORM")
	public static var RG8_SNORM:Int;
	@:native("GL_RGB8_SNORM")
	public static var RGB8_SNORM:Int;
	@:native("GL_RGBA8_SNORM")
	public static var RGBA8_SNORM:Int;
	@:native("GL_R16_SNORM")
	public static var R16_SNORM:Int;
	@:native("GL_RG16_SNORM")
	public static var RG16_SNORM:Int;
	@:native("GL_RGB16_SNORM")
	public static var RGB16_SNORM:Int;
	@:native("GL_RGBA16_SNORM")
	public static var RGBA16_SNORM:Int;
	@:native("GL_SIGNED_NORMALIZED")
	public static var SIGNED_NORMALIZED:Int;
	@:native("GL_PRIMITIVE_RESTART")
	public static var PRIMITIVE_RESTART:Int;
	@:native("GL_PRIMITIVE_RESTART_INDEX")
	public static var PRIMITIVE_RESTART_INDEX:Int;
	@:native("GL_COPY_READ_BUFFER")
	public static var COPY_READ_BUFFER:Int;
	@:native("GL_COPY_WRITE_BUFFER")
	public static var COPY_WRITE_BUFFER:Int;
	@:native("GL_UNIFORM_BUFFER")
	public static var UNIFORM_BUFFER:Int;
	@:native("GL_UNIFORM_BUFFER_BINDING")
	public static var UNIFORM_BUFFER_BINDING:Int;
	@:native("GL_UNIFORM_BUFFER_START")
	public static var UNIFORM_BUFFER_START:Int;
	@:native("GL_UNIFORM_BUFFER_SIZE")
	public static var UNIFORM_BUFFER_SIZE:Int;
	@:native("GL_MAX_VERTEX_UNIFORM_BLOCKS")
	public static var MAX_VERTEX_UNIFORM_BLOCKS:Int;
	@:native("GL_MAX_GEOMETRY_UNIFORM_BLOCKS")
	public static var MAX_GEOMETRY_UNIFORM_BLOCKS:Int;
	@:native("GL_MAX_FRAGMENT_UNIFORM_BLOCKS")
	public static var MAX_FRAGMENT_UNIFORM_BLOCKS:Int;
	@:native("GL_MAX_COMBINED_UNIFORM_BLOCKS")
	public static var MAX_COMBINED_UNIFORM_BLOCKS:Int;
	@:native("GL_MAX_UNIFORM_BUFFER_BINDINGS")
	public static var MAX_UNIFORM_BUFFER_BINDINGS:Int;
	@:native("GL_MAX_UNIFORM_BLOCK_SIZE")
	public static var MAX_UNIFORM_BLOCK_SIZE:Int;
	@:native("GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS")
	public static var MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS:Int;
	@:native("GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS")
	public static var MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS:Int;
	@:native("GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS")
	public static var MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS:Int;
	@:native("GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT")
	public static var UNIFORM_BUFFER_OFFSET_ALIGNMENT:Int;
	@:native("GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH")
	public static var ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH:Int;
	@:native("GL_ACTIVE_UNIFORM_BLOCKS")
	public static var ACTIVE_UNIFORM_BLOCKS:Int;
	@:native("GL_UNIFORM_TYPE")
	public static var UNIFORM_TYPE:Int;
	@:native("GL_UNIFORM_SIZE")
	public static var UNIFORM_SIZE:Int;
	@:native("GL_UNIFORM_NAME_LENGTH")
	public static var UNIFORM_NAME_LENGTH:Int;
	@:native("GL_UNIFORM_BLOCK_INDEX")
	public static var UNIFORM_BLOCK_INDEX:Int;
	@:native("GL_UNIFORM_OFFSET")
	public static var UNIFORM_OFFSET:Int;
	@:native("GL_UNIFORM_ARRAY_STRIDE")
	public static var UNIFORM_ARRAY_STRIDE:Int;
	@:native("GL_UNIFORM_MATRIX_STRIDE")
	public static var UNIFORM_MATRIX_STRIDE:Int;
	@:native("GL_UNIFORM_IS_ROW_MAJOR")
	public static var UNIFORM_IS_ROW_MAJOR:Int;
	@:native("GL_UNIFORM_BLOCK_BINDING")
	public static var UNIFORM_BLOCK_BINDING:Int;
	@:native("GL_UNIFORM_BLOCK_DATA_SIZE")
	public static var UNIFORM_BLOCK_DATA_SIZE:Int;
	@:native("GL_UNIFORM_BLOCK_NAME_LENGTH")
	public static var UNIFORM_BLOCK_NAME_LENGTH:Int;
	@:native("GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS")
	public static var UNIFORM_BLOCK_ACTIVE_UNIFORMS:Int;
	@:native("GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES")
	public static var UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES:Int;
	@:native("GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER")
	public static var UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER:Int;
	@:native("GL_UNIFORM_BLOCK_REFERENCED_BY_GEOMETRY_SHADER")
	public static var UNIFORM_BLOCK_REFERENCED_BY_GEOMETRY_SHADER:Int;
	@:native("GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER")
	public static var UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER:Int;
	@:native("GL_INVALID_INDEX")
	public static var INVALID_INDEX:Int;
	@:native("GL_CONTEXT_CORE_PROFILE_BIT")
	public static var CONTEXT_CORE_PROFILE_BIT:Int;
	@:native("GL_CONTEXT_COMPATIBILITY_PROFILE_BIT")
	public static var CONTEXT_COMPATIBILITY_PROFILE_BIT:Int;
	@:native("GL_LINES_ADJACENCY")
	public static var LINES_ADJACENCY:Int;
	@:native("GL_LINE_STRIP_ADJACENCY")
	public static var LINE_STRIP_ADJACENCY:Int;
	@:native("GL_TRIANGLES_ADJACENCY")
	public static var TRIANGLES_ADJACENCY:Int;
	@:native("GL_TRIANGLE_STRIP_ADJACENCY")
	public static var TRIANGLE_STRIP_ADJACENCY:Int;
	@:native("GL_PROGRAM_POINT_SIZE")
	public static var PROGRAM_POINT_SIZE:Int;
	@:native("GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS")
	public static var MAX_GEOMETRY_TEXTURE_IMAGE_UNITS:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_LAYERED")
	public static var FRAMEBUFFER_ATTACHMENT_LAYERED:Int;
	@:native("GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS")
	public static var FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS:Int;
	@:native("GL_GEOMETRY_SHADER")
	public static var GEOMETRY_SHADER:Int;
	@:native("GL_GEOMETRY_VERTICES_OUT")
	public static var GEOMETRY_VERTICES_OUT:Int;
	@:native("GL_GEOMETRY_INPUT_TYPE")
	public static var GEOMETRY_INPUT_TYPE:Int;
	@:native("GL_GEOMETRY_OUTPUT_TYPE")
	public static var GEOMETRY_OUTPUT_TYPE:Int;
	@:native("GL_MAX_GEOMETRY_UNIFORM_COMPONENTS")
	public static var MAX_GEOMETRY_UNIFORM_COMPONENTS:Int;
	@:native("GL_MAX_GEOMETRY_OUTPUT_VERTICES")
	public static var MAX_GEOMETRY_OUTPUT_VERTICES:Int;
	@:native("GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS")
	public static var MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS:Int;
	@:native("GL_MAX_VERTEX_OUTPUT_COMPONENTS")
	public static var MAX_VERTEX_OUTPUT_COMPONENTS:Int;
	@:native("GL_MAX_GEOMETRY_INPUT_COMPONENTS")
	public static var MAX_GEOMETRY_INPUT_COMPONENTS:Int;
	@:native("GL_MAX_GEOMETRY_OUTPUT_COMPONENTS")
	public static var MAX_GEOMETRY_OUTPUT_COMPONENTS:Int;
	@:native("GL_MAX_FRAGMENT_INPUT_COMPONENTS")
	public static var MAX_FRAGMENT_INPUT_COMPONENTS:Int;
	@:native("GL_CONTEXT_PROFILE_MASK")
	public static var CONTEXT_PROFILE_MASK:Int;
	@:native("GL_DEPTH_CLAMP")
	public static var DEPTH_CLAMP:Int;
	@:native("GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION")
	public static var QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION:Int;
	@:native("GL_FIRST_VERTEX_CONVENTION")
	public static var FIRST_VERTEX_CONVENTION:Int;
	@:native("GL_LAST_VERTEX_CONVENTION")
	public static var LAST_VERTEX_CONVENTION:Int;
	@:native("GL_PROVOKING_VERTEX")
	public static var PROVOKING_VERTEX:Int;
	@:native("GL_TEXTURE_CUBE_MAP_SEAMLESS")
	public static var TEXTURE_CUBE_MAP_SEAMLESS:Int;
	@:native("GL_MAX_SERVER_WAIT_TIMEOUT")
	public static var MAX_SERVER_WAIT_TIMEOUT:Int;
	@:native("GL_OBJECT_TYPE")
	public static var OBJECT_TYPE:Int;
	@:native("GL_SYNC_CONDITION")
	public static var SYNC_CONDITION:Int;
	@:native("GL_SYNC_STATUS")
	public static var SYNC_STATUS:Int;
	@:native("GL_SYNC_FLAGS")
	public static var SYNC_FLAGS:Int;
	@:native("GL_SYNC_FENCE")
	public static var SYNC_FENCE:Int;
	@:native("GL_SYNC_GPU_COMMANDS_COMPLETE")
	public static var SYNC_GPU_COMMANDS_COMPLETE:Int;
	@:native("GL_UNSIGNALED")
	public static var UNSIGNALED:Int;
	@:native("GL_SIGNALED")
	public static var SIGNALED:Int;
	@:native("GL_ALREADY_SIGNALED")
	public static var ALREADY_SIGNALED:Int;
	@:native("GL_TIMEOUT_EXPIRED")
	public static var TIMEOUT_EXPIRED:Int;
	@:native("GL_CONDITION_SATISFIED")
	public static var CONDITION_SATISFIED:Int;
	@:native("GL_WAIT_FAILED")
	public static var WAIT_FAILED:Int;
	@:native("GL_TIMEOUT_IGNORED")
	public static var TIMEOUT_IGNORED:Int;
	@:native("GL_SYNC_FLUSH_COMMANDS_BIT")
	public static var SYNC_FLUSH_COMMANDS_BIT:Int;
	@:native("GL_SAMPLE_POSITION")
	public static var SAMPLE_POSITION:Int;
	@:native("GL_SAMPLE_MASK")
	public static var SAMPLE_MASK:Int;
	@:native("GL_SAMPLE_MASK_VALUE")
	public static var SAMPLE_MASK_VALUE:Int;
	@:native("GL_MAX_SAMPLE_MASK_WORDS")
	public static var MAX_SAMPLE_MASK_WORDS:Int;
	@:native("GL_TEXTURE_2D_MULTISAMPLE")
	public static var TEXTURE_2D_MULTISAMPLE:Int;
	@:native("GL_PROXY_TEXTURE_2D_MULTISAMPLE")
	public static var PROXY_TEXTURE_2D_MULTISAMPLE:Int;
	@:native("GL_TEXTURE_2D_MULTISAMPLE_ARRAY")
	public static var TEXTURE_2D_MULTISAMPLE_ARRAY:Int;
	@:native("GL_PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY")
	public static var PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY:Int;
	@:native("GL_TEXTURE_BINDING_2D_MULTISAMPLE")
	public static var TEXTURE_BINDING_2D_MULTISAMPLE:Int;
	@:native("GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY")
	public static var TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY:Int;
	@:native("GL_TEXTURE_SAMPLES")
	public static var TEXTURE_SAMPLES:Int;
	@:native("GL_TEXTURE_FIXED_SAMPLE_LOCATIONS")
	public static var TEXTURE_FIXED_SAMPLE_LOCATIONS:Int;
	@:native("GL_SAMPLER_2D_MULTISAMPLE")
	public static var SAMPLER_2D_MULTISAMPLE:Int;
	@:native("GL_INT_SAMPLER_2D_MULTISAMPLE")
	public static var INT_SAMPLER_2D_MULTISAMPLE:Int;
	@:native("GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE")
	public static var UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE:Int;
	@:native("GL_SAMPLER_2D_MULTISAMPLE_ARRAY")
	public static var SAMPLER_2D_MULTISAMPLE_ARRAY:Int;
	@:native("GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY")
	public static var INT_SAMPLER_2D_MULTISAMPLE_ARRAY:Int;
	@:native("GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY")
	public static var UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY:Int;
	@:native("GL_MAX_COLOR_TEXTURE_SAMPLES")
	public static var MAX_COLOR_TEXTURE_SAMPLES:Int;
	@:native("GL_MAX_DEPTH_TEXTURE_SAMPLES")
	public static var MAX_DEPTH_TEXTURE_SAMPLES:Int;
	@:native("GL_MAX_INTEGER_SAMPLES")
	public static var MAX_INTEGER_SAMPLES:Int;
	@:native("GL_VERTEX_ATTRIB_ARRAY_DIVISOR")
	public static var VERTEX_ATTRIB_ARRAY_DIVISOR:Int;
	@:native("GL_SRC1_COLOR")
	public static var SRC1_COLOR:Int;
	@:native("GL_ONE_MINUS_SRC1_COLOR")
	public static var ONE_MINUS_SRC1_COLOR:Int;
	@:native("GL_ONE_MINUS_SRC1_ALPHA")
	public static var ONE_MINUS_SRC1_ALPHA:Int;
	@:native("GL_MAX_DUAL_SOURCE_DRAW_BUFFERS")
	public static var MAX_DUAL_SOURCE_DRAW_BUFFERS:Int;
	@:native("GL_ANY_SAMPLES_PASSED")
	public static var ANY_SAMPLES_PASSED:Int;
	@:native("GL_SAMPLER_BINDING")
	public static var SAMPLER_BINDING:Int;
	@:native("GL_RGB10_A2UI")
	public static var RGB10_A2UI:Int;
	@:native("GL_TEXTURE_SWIZZLE_R")
	public static var TEXTURE_SWIZZLE_R:Int;
	@:native("GL_TEXTURE_SWIZZLE_G")
	public static var TEXTURE_SWIZZLE_G:Int;
	@:native("GL_TEXTURE_SWIZZLE_B")
	public static var TEXTURE_SWIZZLE_B:Int;
	@:native("GL_TEXTURE_SWIZZLE_A")
	public static var TEXTURE_SWIZZLE_A:Int;
	@:native("GL_TEXTURE_SWIZZLE_RGBA")
	public static var TEXTURE_SWIZZLE_RGBA:Int;
	@:native("GL_TIME_ELAPSED")
	public static var TIME_ELAPSED:Int;
	@:native("GL_TIMESTAMP")
	public static var TIMESTAMP:Int;
	@:native("GL_INT_2_10_10_10_REV")
	public static var INT_2_10_10_10_REV:Int;
	@:native("GL_SAMPLE_SHADING")
	public static var SAMPLE_SHADING:Int;
	@:native("GL_MIN_SAMPLE_SHADING_VALUE")
	public static var MIN_SAMPLE_SHADING_VALUE:Int;
	@:native("GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET")
	public static var MIN_PROGRAM_TEXTURE_GATHER_OFFSET:Int;
	@:native("GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET")
	public static var MAX_PROGRAM_TEXTURE_GATHER_OFFSET:Int;
	@:native("GL_TEXTURE_CUBE_MAP_ARRAY")
	public static var TEXTURE_CUBE_MAP_ARRAY:Int;
	@:native("GL_TEXTURE_BINDING_CUBE_MAP_ARRAY")
	public static var TEXTURE_BINDING_CUBE_MAP_ARRAY:Int;
	@:native("GL_PROXY_TEXTURE_CUBE_MAP_ARRAY")
	public static var PROXY_TEXTURE_CUBE_MAP_ARRAY:Int;
	@:native("GL_SAMPLER_CUBE_MAP_ARRAY")
	public static var SAMPLER_CUBE_MAP_ARRAY:Int;
	@:native("GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW")
	public static var SAMPLER_CUBE_MAP_ARRAY_SHADOW:Int;
	@:native("GL_INT_SAMPLER_CUBE_MAP_ARRAY")
	public static var INT_SAMPLER_CUBE_MAP_ARRAY:Int;
	@:native("GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY")
	public static var UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY:Int;
	@:native("GL_DRAW_INDIRECT_BUFFER")
	public static var DRAW_INDIRECT_BUFFER:Int;
	@:native("GL_DRAW_INDIRECT_BUFFER_BINDING")
	public static var DRAW_INDIRECT_BUFFER_BINDING:Int;
	@:native("GL_GEOMETRY_SHADER_INVOCATIONS")
	public static var GEOMETRY_SHADER_INVOCATIONS:Int;
	@:native("GL_MAX_GEOMETRY_SHADER_INVOCATIONS")
	public static var MAX_GEOMETRY_SHADER_INVOCATIONS:Int;
	@:native("GL_MIN_FRAGMENT_INTERPOLATION_OFFSET")
	public static var MIN_FRAGMENT_INTERPOLATION_OFFSET:Int;
	@:native("GL_MAX_FRAGMENT_INTERPOLATION_OFFSET")
	public static var MAX_FRAGMENT_INTERPOLATION_OFFSET:Int;
	@:native("GL_FRAGMENT_INTERPOLATION_OFFSET_BITS")
	public static var FRAGMENT_INTERPOLATION_OFFSET_BITS:Int;
	@:native("GL_MAX_VERTEX_STREAMS")
	public static var MAX_VERTEX_STREAMS:Int;
	@:native("GL_DOUBLE_VEC2")
	public static var DOUBLE_VEC2:Int;
	@:native("GL_DOUBLE_VEC3")
	public static var DOUBLE_VEC3:Int;
	@:native("GL_DOUBLE_VEC4")
	public static var DOUBLE_VEC4:Int;
	@:native("GL_DOUBLE_MAT2")
	public static var DOUBLE_MAT2:Int;
	@:native("GL_DOUBLE_MAT3")
	public static var DOUBLE_MAT3:Int;
	@:native("GL_DOUBLE_MAT4")
	public static var DOUBLE_MAT4:Int;
	@:native("GL_DOUBLE_MAT2x3")
	public static var DOUBLE_MAT2x3:Int;
	@:native("GL_DOUBLE_MAT2x4")
	public static var DOUBLE_MAT2x4:Int;
	@:native("GL_DOUBLE_MAT3x2")
	public static var DOUBLE_MAT3x2:Int;
	@:native("GL_DOUBLE_MAT3x4")
	public static var DOUBLE_MAT3x4:Int;
	@:native("GL_DOUBLE_MAT4x2")
	public static var DOUBLE_MAT4x2:Int;
	@:native("GL_DOUBLE_MAT4x3")
	public static var DOUBLE_MAT4x3:Int;
	@:native("GL_ACTIVE_SUBROUTINES")
	public static var ACTIVE_SUBROUTINES:Int;
	@:native("GL_ACTIVE_SUBROUTINE_UNIFORMS")
	public static var ACTIVE_SUBROUTINE_UNIFORMS:Int;
	@:native("GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS")
	public static var ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS:Int;
	@:native("GL_ACTIVE_SUBROUTINE_MAX_LENGTH")
	public static var ACTIVE_SUBROUTINE_MAX_LENGTH:Int;
	@:native("GL_ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH")
	public static var ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH:Int;
	@:native("GL_MAX_SUBROUTINES")
	public static var MAX_SUBROUTINES:Int;
	@:native("GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS")
	public static var MAX_SUBROUTINE_UNIFORM_LOCATIONS:Int;
	@:native("GL_NUM_COMPATIBLE_SUBROUTINES")
	public static var NUM_COMPATIBLE_SUBROUTINES:Int;
	@:native("GL_COMPATIBLE_SUBROUTINES")
	public static var COMPATIBLE_SUBROUTINES:Int;
	@:native("GL_PATCHES")
	public static var PATCHES:Int;
	@:native("GL_PATCH_VERTICES")
	public static var PATCH_VERTICES:Int;
	@:native("GL_PATCH_DEFAULT_INNER_LEVEL")
	public static var PATCH_DEFAULT_INNER_LEVEL:Int;
	@:native("GL_PATCH_DEFAULT_OUTER_LEVEL")
	public static var PATCH_DEFAULT_OUTER_LEVEL:Int;
	@:native("GL_TESS_CONTROL_OUTPUT_VERTICES")
	public static var TESS_CONTROL_OUTPUT_VERTICES:Int;
	@:native("GL_TESS_GEN_MODE")
	public static var TESS_GEN_MODE:Int;
	@:native("GL_TESS_GEN_SPACING")
	public static var TESS_GEN_SPACING:Int;
	@:native("GL_TESS_GEN_VERTEX_ORDER")
	public static var TESS_GEN_VERTEX_ORDER:Int;
	@:native("GL_TESS_GEN_POINT_MODE")
	public static var TESS_GEN_POINT_MODE:Int;
	@:native("GL_ISOLINES")
	public static var ISOLINES:Int;
	@:native("GL_QUADS")
	public static var QUADS:Int;
	@:native("GL_FRACTIONAL_ODD")
	public static var FRACTIONAL_ODD:Int;
	@:native("GL_FRACTIONAL_EVEN")
	public static var FRACTIONAL_EVEN:Int;
	@:native("GL_MAX_PATCH_VERTICES")
	public static var MAX_PATCH_VERTICES:Int;
	@:native("GL_MAX_TESS_GEN_LEVEL")
	public static var MAX_TESS_GEN_LEVEL:Int;
	@:native("GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS")
	public static var MAX_TESS_CONTROL_UNIFORM_COMPONENTS:Int;
	@:native("GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS")
	public static var MAX_TESS_EVALUATION_UNIFORM_COMPONENTS:Int;
	@:native("GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS")
	public static var MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS:Int;
	@:native("GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS")
	public static var MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS:Int;
	@:native("GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS")
	public static var MAX_TESS_CONTROL_OUTPUT_COMPONENTS:Int;
	@:native("GL_MAX_TESS_PATCH_COMPONENTS")
	public static var MAX_TESS_PATCH_COMPONENTS:Int;
	@:native("GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS")
	public static var MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS:Int;
	@:native("GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS")
	public static var MAX_TESS_EVALUATION_OUTPUT_COMPONENTS:Int;
	@:native("GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS")
	public static var MAX_TESS_CONTROL_UNIFORM_BLOCKS:Int;
	@:native("GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS")
	public static var MAX_TESS_EVALUATION_UNIFORM_BLOCKS:Int;
	@:native("GL_MAX_TESS_CONTROL_INPUT_COMPONENTS")
	public static var MAX_TESS_CONTROL_INPUT_COMPONENTS:Int;
	@:native("GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS")
	public static var MAX_TESS_EVALUATION_INPUT_COMPONENTS:Int;
	@:native("GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS")
	public static var MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS:Int;
	@:native("GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS")
	public static var MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS:Int;
	@:native("GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_CONTROL_SHADER")
	public static var UNIFORM_BLOCK_REFERENCED_BY_TESS_CONTROL_SHADER:Int;
	@:native("GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_EVALUATION_SHADER")
	public static var UNIFORM_BLOCK_REFERENCED_BY_TESS_EVALUATION_SHADER:Int;
	@:native("GL_TESS_EVALUATION_SHADER")
	public static var TESS_EVALUATION_SHADER:Int;
	@:native("GL_TESS_CONTROL_SHADER")
	public static var TESS_CONTROL_SHADER:Int;
	@:native("GL_TRANSFORM_FEEDBACK")
	public static var TRANSFORM_FEEDBACK:Int;
	@:native("GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED")
	public static var TRANSFORM_FEEDBACK_BUFFER_PAUSED:Int;
	@:native("GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE")
	public static var TRANSFORM_FEEDBACK_BUFFER_ACTIVE:Int;
	@:native("GL_TRANSFORM_FEEDBACK_BINDING")
	public static var TRANSFORM_FEEDBACK_BINDING:Int;
	@:native("GL_MAX_TRANSFORM_FEEDBACK_BUFFERS")
	public static var MAX_TRANSFORM_FEEDBACK_BUFFERS:Int;
	@:native("GL_FIXED")
	public static var FIXED:Int;
	@:native("GL_IMPLEMENTATION_COLOR_READ_TYPE")
	public static var IMPLEMENTATION_COLOR_READ_TYPE:Int;
	@:native("GL_IMPLEMENTATION_COLOR_READ_FORMAT")
	public static var IMPLEMENTATION_COLOR_READ_FORMAT:Int;
	@:native("GL_LOW_FLOAT")
	public static var LOW_FLOAT:Int;
	@:native("GL_MEDIUM_FLOAT")
	public static var MEDIUM_FLOAT:Int;
	@:native("GL_HIGH_FLOAT")
	public static var HIGH_FLOAT:Int;
	@:native("GL_LOW_INT")
	public static var LOW_INT:Int;
	@:native("GL_MEDIUM_INT")
	public static var MEDIUM_INT:Int;
	@:native("GL_HIGH_INT")
	public static var HIGH_INT:Int;
	@:native("GL_SHADER_COMPILER")
	public static var SHADER_COMPILER:Int;
	@:native("GL_SHADER_BINARY_FORMATS")
	public static var SHADER_BINARY_FORMATS:Int;
	@:native("GL_NUM_SHADER_BINARY_FORMATS")
	public static var NUM_SHADER_BINARY_FORMATS:Int;
	@:native("GL_MAX_VERTEX_UNIFORM_VECTORS")
	public static var MAX_VERTEX_UNIFORM_VECTORS:Int;
	@:native("GL_MAX_VARYING_VECTORS")
	public static var MAX_VARYING_VECTORS:Int;
	@:native("GL_MAX_FRAGMENT_UNIFORM_VECTORS")
	public static var MAX_FRAGMENT_UNIFORM_VECTORS:Int;
	@:native("GL_RGB565")
	public static var RGB565:Int;
	@:native("GL_PROGRAM_BINARY_RETRIEVABLE_HINT")
	public static var PROGRAM_BINARY_RETRIEVABLE_HINT:Int;
	@:native("GL_PROGRAM_BINARY_LENGTH")
	public static var PROGRAM_BINARY_LENGTH:Int;
	@:native("GL_NUM_PROGRAM_BINARY_FORMATS")
	public static var NUM_PROGRAM_BINARY_FORMATS:Int;
	@:native("GL_PROGRAM_BINARY_FORMATS")
	public static var PROGRAM_BINARY_FORMATS:Int;
	@:native("GL_VERTEX_SHADER_BIT")
	public static var VERTEX_SHADER_BIT:Int;
	@:native("GL_FRAGMENT_SHADER_BIT")
	public static var FRAGMENT_SHADER_BIT:Int;
	@:native("GL_GEOMETRY_SHADER_BIT")
	public static var GEOMETRY_SHADER_BIT:Int;
	@:native("GL_TESS_CONTROL_SHADER_BIT")
	public static var TESS_CONTROL_SHADER_BIT:Int;
	@:native("GL_TESS_EVALUATION_SHADER_BIT")
	public static var TESS_EVALUATION_SHADER_BIT:Int;
	@:native("GL_ALL_SHADER_BITS")
	public static var ALL_SHADER_BITS:Int;
	@:native("GL_PROGRAM_SEPARABLE")
	public static var PROGRAM_SEPARABLE:Int;
	@:native("GL_ACTIVE_PROGRAM")
	public static var ACTIVE_PROGRAM:Int;
	@:native("GL_PROGRAM_PIPELINE_BINDING")
	public static var PROGRAM_PIPELINE_BINDING:Int;
	@:native("GL_MAX_VIEWPORTS")
	public static var MAX_VIEWPORTS:Int;
	@:native("GL_VIEWPORT_SUBPIXEL_BITS")
	public static var VIEWPORT_SUBPIXEL_BITS:Int;
	@:native("GL_VIEWPORT_BOUNDS_RANGE")
	public static var VIEWPORT_BOUNDS_RANGE:Int;
	@:native("GL_LAYER_PROVOKING_VERTEX")
	public static var LAYER_PROVOKING_VERTEX:Int;
	@:native("GL_VIEWPORT_INDEX_PROVOKING_VERTEX")
	public static var VIEWPORT_INDEX_PROVOKING_VERTEX:Int;
	@:native("GL_UNDEFINED_VERTEX")
	public static var UNDEFINED_VERTEX:Int;
	@:native("GL_COPY_READ_BUFFER_BINDING")
	public static var COPY_READ_BUFFER_BINDING:Int;
	@:native("GL_COPY_WRITE_BUFFER_BINDING")
	public static var COPY_WRITE_BUFFER_BINDING:Int;
	@:native("GL_TRANSFORM_FEEDBACK_ACTIVE")
	public static var TRANSFORM_FEEDBACK_ACTIVE:Int;
	@:native("GL_TRANSFORM_FEEDBACK_PAUSED")
	public static var TRANSFORM_FEEDBACK_PAUSED:Int;
	@:native("GL_UNPACK_COMPRESSED_BLOCK_WIDTH")
	public static var UNPACK_COMPRESSED_BLOCK_WIDTH:Int;
	@:native("GL_UNPACK_COMPRESSED_BLOCK_HEIGHT")
	public static var UNPACK_COMPRESSED_BLOCK_HEIGHT:Int;
	@:native("GL_UNPACK_COMPRESSED_BLOCK_DEPTH")
	public static var UNPACK_COMPRESSED_BLOCK_DEPTH:Int;
	@:native("GL_UNPACK_COMPRESSED_BLOCK_SIZE")
	public static var UNPACK_COMPRESSED_BLOCK_SIZE:Int;
	@:native("GL_PACK_COMPRESSED_BLOCK_WIDTH")
	public static var PACK_COMPRESSED_BLOCK_WIDTH:Int;
	@:native("GL_PACK_COMPRESSED_BLOCK_HEIGHT")
	public static var PACK_COMPRESSED_BLOCK_HEIGHT:Int;
	@:native("GL_PACK_COMPRESSED_BLOCK_DEPTH")
	public static var PACK_COMPRESSED_BLOCK_DEPTH:Int;
	@:native("GL_PACK_COMPRESSED_BLOCK_SIZE")
	public static var PACK_COMPRESSED_BLOCK_SIZE:Int;
	@:native("GL_NUM_SAMPLE_COUNTS")
	public static var NUM_SAMPLE_COUNTS:Int;
	@:native("GL_MIN_MAP_BUFFER_ALIGNMENT")
	public static var MIN_MAP_BUFFER_ALIGNMENT:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER")
	public static var ATOMIC_COUNTER_BUFFER:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_BINDING")
	public static var ATOMIC_COUNTER_BUFFER_BINDING:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_START")
	public static var ATOMIC_COUNTER_BUFFER_START:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_SIZE")
	public static var ATOMIC_COUNTER_BUFFER_SIZE:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_DATA_SIZE")
	public static var ATOMIC_COUNTER_BUFFER_DATA_SIZE:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTERS")
	public static var ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTERS:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTER_INDICES")
	public static var ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTER_INDICES:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_VERTEX_SHADER")
	public static var ATOMIC_COUNTER_BUFFER_REFERENCED_BY_VERTEX_SHADER:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_CONTROL_SHADER")
	public static var ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_CONTROL_SHADER:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_EVALUATION_SHADER")
	public static var ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_EVALUATION_SHADER:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_GEOMETRY_SHADER")
	public static var ATOMIC_COUNTER_BUFFER_REFERENCED_BY_GEOMETRY_SHADER:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_FRAGMENT_SHADER")
	public static var ATOMIC_COUNTER_BUFFER_REFERENCED_BY_FRAGMENT_SHADER:Int;
	@:native("GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS")
	public static var MAX_VERTEX_ATOMIC_COUNTER_BUFFERS:Int;
	@:native("GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS")
	public static var MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS:Int;
	@:native("GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS")
	public static var MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS:Int;
	@:native("GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS")
	public static var MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS:Int;
	@:native("GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS")
	public static var MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS:Int;
	@:native("GL_MAX_COMBINED_ATOMIC_COUNTER_BUFFERS")
	public static var MAX_COMBINED_ATOMIC_COUNTER_BUFFERS:Int;
	@:native("GL_MAX_VERTEX_ATOMIC_COUNTERS")
	public static var MAX_VERTEX_ATOMIC_COUNTERS:Int;
	@:native("GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS")
	public static var MAX_TESS_CONTROL_ATOMIC_COUNTERS:Int;
	@:native("GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS")
	public static var MAX_TESS_EVALUATION_ATOMIC_COUNTERS:Int;
	@:native("GL_MAX_GEOMETRY_ATOMIC_COUNTERS")
	public static var MAX_GEOMETRY_ATOMIC_COUNTERS:Int;
	@:native("GL_MAX_FRAGMENT_ATOMIC_COUNTERS")
	public static var MAX_FRAGMENT_ATOMIC_COUNTERS:Int;
	@:native("GL_MAX_COMBINED_ATOMIC_COUNTERS")
	public static var MAX_COMBINED_ATOMIC_COUNTERS:Int;
	@:native("GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE")
	public static var MAX_ATOMIC_COUNTER_BUFFER_SIZE:Int;
	@:native("GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS")
	public static var MAX_ATOMIC_COUNTER_BUFFER_BINDINGS:Int;
	@:native("GL_ACTIVE_ATOMIC_COUNTER_BUFFERS")
	public static var ACTIVE_ATOMIC_COUNTER_BUFFERS:Int;
	@:native("GL_UNIFORM_ATOMIC_COUNTER_BUFFER_INDEX")
	public static var UNIFORM_ATOMIC_COUNTER_BUFFER_INDEX:Int;
	@:native("GL_UNSIGNED_INT_ATOMIC_COUNTER")
	public static var UNSIGNED_INT_ATOMIC_COUNTER:Int;
	@:native("GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT")
	public static var VERTEX_ATTRIB_ARRAY_BARRIER_BIT:Int;
	@:native("GL_ELEMENT_ARRAY_BARRIER_BIT")
	public static var ELEMENT_ARRAY_BARRIER_BIT:Int;
	@:native("GL_UNIFORM_BARRIER_BIT")
	public static var UNIFORM_BARRIER_BIT:Int;
	@:native("GL_TEXTURE_FETCH_BARRIER_BIT")
	public static var TEXTURE_FETCH_BARRIER_BIT:Int;
	@:native("GL_SHADER_IMAGE_ACCESS_BARRIER_BIT")
	public static var SHADER_IMAGE_ACCESS_BARRIER_BIT:Int;
	@:native("GL_COMMAND_BARRIER_BIT")
	public static var COMMAND_BARRIER_BIT:Int;
	@:native("GL_PIXEL_BUFFER_BARRIER_BIT")
	public static var PIXEL_BUFFER_BARRIER_BIT:Int;
	@:native("GL_TEXTURE_UPDATE_BARRIER_BIT")
	public static var TEXTURE_UPDATE_BARRIER_BIT:Int;
	@:native("GL_BUFFER_UPDATE_BARRIER_BIT")
	public static var BUFFER_UPDATE_BARRIER_BIT:Int;
	@:native("GL_FRAMEBUFFER_BARRIER_BIT")
	public static var FRAMEBUFFER_BARRIER_BIT:Int;
	@:native("GL_TRANSFORM_FEEDBACK_BARRIER_BIT")
	public static var TRANSFORM_FEEDBACK_BARRIER_BIT:Int;
	@:native("GL_ATOMIC_COUNTER_BARRIER_BIT")
	public static var ATOMIC_COUNTER_BARRIER_BIT:Int;
	@:native("GL_ALL_BARRIER_BITS")
	public static var ALL_BARRIER_BITS:Int;
	@:native("GL_MAX_IMAGE_UNITS")
	public static var MAX_IMAGE_UNITS:Int;
	@:native("GL_MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS")
	public static var MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS:Int;
	@:native("GL_IMAGE_BINDING_NAME")
	public static var IMAGE_BINDING_NAME:Int;
	@:native("GL_IMAGE_BINDING_LEVEL")
	public static var IMAGE_BINDING_LEVEL:Int;
	@:native("GL_IMAGE_BINDING_LAYERED")
	public static var IMAGE_BINDING_LAYERED:Int;
	@:native("GL_IMAGE_BINDING_LAYER")
	public static var IMAGE_BINDING_LAYER:Int;
	@:native("GL_IMAGE_BINDING_ACCESS")
	public static var IMAGE_BINDING_ACCESS:Int;
	@:native("GL_IMAGE_1D")
	public static var IMAGE_1D:Int;
	@:native("GL_IMAGE_2D")
	public static var IMAGE_2D:Int;
	@:native("GL_IMAGE_3D")
	public static var IMAGE_3D:Int;
	@:native("GL_IMAGE_2D_RECT")
	public static var IMAGE_2D_RECT:Int;
	@:native("GL_IMAGE_CUBE")
	public static var IMAGE_CUBE:Int;
	@:native("GL_IMAGE_BUFFER")
	public static var IMAGE_BUFFER:Int;
	@:native("GL_IMAGE_1D_ARRAY")
	public static var IMAGE_1D_ARRAY:Int;
	@:native("GL_IMAGE_2D_ARRAY")
	public static var IMAGE_2D_ARRAY:Int;
	@:native("GL_IMAGE_CUBE_MAP_ARRAY")
	public static var IMAGE_CUBE_MAP_ARRAY:Int;
	@:native("GL_IMAGE_2D_MULTISAMPLE")
	public static var IMAGE_2D_MULTISAMPLE:Int;
	@:native("GL_IMAGE_2D_MULTISAMPLE_ARRAY")
	public static var IMAGE_2D_MULTISAMPLE_ARRAY:Int;
	@:native("GL_INT_IMAGE_1D")
	public static var INT_IMAGE_1D:Int;
	@:native("GL_INT_IMAGE_2D")
	public static var INT_IMAGE_2D:Int;
	@:native("GL_INT_IMAGE_3D")
	public static var INT_IMAGE_3D:Int;
	@:native("GL_INT_IMAGE_2D_RECT")
	public static var INT_IMAGE_2D_RECT:Int;
	@:native("GL_INT_IMAGE_CUBE")
	public static var INT_IMAGE_CUBE:Int;
	@:native("GL_INT_IMAGE_BUFFER")
	public static var INT_IMAGE_BUFFER:Int;
	@:native("GL_INT_IMAGE_1D_ARRAY")
	public static var INT_IMAGE_1D_ARRAY:Int;
	@:native("GL_INT_IMAGE_2D_ARRAY")
	public static var INT_IMAGE_2D_ARRAY:Int;
	@:native("GL_INT_IMAGE_CUBE_MAP_ARRAY")
	public static var INT_IMAGE_CUBE_MAP_ARRAY:Int;
	@:native("GL_INT_IMAGE_2D_MULTISAMPLE")
	public static var INT_IMAGE_2D_MULTISAMPLE:Int;
	@:native("GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY")
	public static var INT_IMAGE_2D_MULTISAMPLE_ARRAY:Int;
	@:native("GL_UNSIGNED_INT_IMAGE_1D")
	public static var UNSIGNED_INT_IMAGE_1D:Int;
	@:native("GL_UNSIGNED_INT_IMAGE_2D")
	public static var UNSIGNED_INT_IMAGE_2D:Int;
	@:native("GL_UNSIGNED_INT_IMAGE_3D")
	public static var UNSIGNED_INT_IMAGE_3D:Int;
	@:native("GL_UNSIGNED_INT_IMAGE_2D_RECT")
	public static var UNSIGNED_INT_IMAGE_2D_RECT:Int;
	@:native("GL_UNSIGNED_INT_IMAGE_CUBE")
	public static var UNSIGNED_INT_IMAGE_CUBE:Int;
	@:native("GL_UNSIGNED_INT_IMAGE_BUFFER")
	public static var UNSIGNED_INT_IMAGE_BUFFER:Int;
	@:native("GL_UNSIGNED_INT_IMAGE_1D_ARRAY")
	public static var UNSIGNED_INT_IMAGE_1D_ARRAY:Int;
	@:native("GL_UNSIGNED_INT_IMAGE_2D_ARRAY")
	public static var UNSIGNED_INT_IMAGE_2D_ARRAY:Int;
	@:native("GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY")
	public static var UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY:Int;
	@:native("GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE")
	public static var UNSIGNED_INT_IMAGE_2D_MULTISAMPLE:Int;
	@:native("GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY")
	public static var UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY:Int;
	@:native("GL_MAX_IMAGE_SAMPLES")
	public static var MAX_IMAGE_SAMPLES:Int;
	@:native("GL_IMAGE_BINDING_FORMAT")
	public static var IMAGE_BINDING_FORMAT:Int;
	@:native("GL_IMAGE_FORMAT_COMPATIBILITY_TYPE")
	public static var IMAGE_FORMAT_COMPATIBILITY_TYPE:Int;
	@:native("GL_IMAGE_FORMAT_COMPATIBILITY_BY_SIZE")
	public static var IMAGE_FORMAT_COMPATIBILITY_BY_SIZE:Int;
	@:native("GL_IMAGE_FORMAT_COMPATIBILITY_BY_CLASS")
	public static var IMAGE_FORMAT_COMPATIBILITY_BY_CLASS:Int;
	@:native("GL_MAX_VERTEX_IMAGE_UNIFORMS")
	public static var MAX_VERTEX_IMAGE_UNIFORMS:Int;
	@:native("GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS")
	public static var MAX_TESS_CONTROL_IMAGE_UNIFORMS:Int;
	@:native("GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS")
	public static var MAX_TESS_EVALUATION_IMAGE_UNIFORMS:Int;
	@:native("GL_MAX_GEOMETRY_IMAGE_UNIFORMS")
	public static var MAX_GEOMETRY_IMAGE_UNIFORMS:Int;
	@:native("GL_MAX_FRAGMENT_IMAGE_UNIFORMS")
	public static var MAX_FRAGMENT_IMAGE_UNIFORMS:Int;
	@:native("GL_MAX_COMBINED_IMAGE_UNIFORMS")
	public static var MAX_COMBINED_IMAGE_UNIFORMS:Int;
	@:native("GL_COMPRESSED_RGBA_BPTC_UNORM")
	public static var COMPRESSED_RGBA_BPTC_UNORM:Int;
	@:native("GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM")
	public static var COMPRESSED_SRGB_ALPHA_BPTC_UNORM:Int;
	@:native("GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT")
	public static var COMPRESSED_RGB_BPTC_SIGNED_FLOAT:Int;
	@:native("GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT")
	public static var COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT:Int;
	@:native("GL_TEXTURE_IMMUTABLE_FORMAT")
	public static var TEXTURE_IMMUTABLE_FORMAT:Int;
	@:native("GL_NUM_SHADING_LANGUAGE_VERSIONS")
	public static var NUM_SHADING_LANGUAGE_VERSIONS:Int;
	@:native("GL_VERTEX_ATTRIB_ARRAY_LONG")
	public static var VERTEX_ATTRIB_ARRAY_LONG:Int;
	@:native("GL_COMPRESSED_RGB8_ETC2")
	public static var COMPRESSED_RGB8_ETC2:Int;
	@:native("GL_COMPRESSED_SRGB8_ETC2")
	public static var COMPRESSED_SRGB8_ETC2:Int;
	@:native("GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2")
	public static var COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2:Int;
	@:native("GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2")
	public static var COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2:Int;
	@:native("GL_COMPRESSED_RGBA8_ETC2_EAC")
	public static var COMPRESSED_RGBA8_ETC2_EAC:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC")
	public static var COMPRESSED_SRGB8_ALPHA8_ETC2_EAC:Int;
	@:native("GL_COMPRESSED_R11_EAC")
	public static var COMPRESSED_R11_EAC:Int;
	@:native("GL_COMPRESSED_SIGNED_R11_EAC")
	public static var COMPRESSED_SIGNED_R11_EAC:Int;
	@:native("GL_COMPRESSED_RG11_EAC")
	public static var COMPRESSED_RG11_EAC:Int;
	@:native("GL_COMPRESSED_SIGNED_RG11_EAC")
	public static var COMPRESSED_SIGNED_RG11_EAC:Int;
	@:native("GL_PRIMITIVE_RESTART_FIXED_INDEX")
	public static var PRIMITIVE_RESTART_FIXED_INDEX:Int;
	@:native("GL_ANY_SAMPLES_PASSED_CONSERVATIVE")
	public static var ANY_SAMPLES_PASSED_CONSERVATIVE:Int;
	@:native("GL_MAX_ELEMENT_INDEX")
	public static var MAX_ELEMENT_INDEX:Int;
	@:native("GL_COMPUTE_SHADER")
	public static var COMPUTE_SHADER:Int;
	@:native("GL_MAX_COMPUTE_UNIFORM_BLOCKS")
	public static var MAX_COMPUTE_UNIFORM_BLOCKS:Int;
	@:native("GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS")
	public static var MAX_COMPUTE_TEXTURE_IMAGE_UNITS:Int;
	@:native("GL_MAX_COMPUTE_IMAGE_UNIFORMS")
	public static var MAX_COMPUTE_IMAGE_UNIFORMS:Int;
	@:native("GL_MAX_COMPUTE_SHARED_MEMORY_SIZE")
	public static var MAX_COMPUTE_SHARED_MEMORY_SIZE:Int;
	@:native("GL_MAX_COMPUTE_UNIFORM_COMPONENTS")
	public static var MAX_COMPUTE_UNIFORM_COMPONENTS:Int;
	@:native("GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS")
	public static var MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS:Int;
	@:native("GL_MAX_COMPUTE_ATOMIC_COUNTERS")
	public static var MAX_COMPUTE_ATOMIC_COUNTERS:Int;
	@:native("GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS")
	public static var MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS:Int;
	@:native("GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS")
	public static var MAX_COMPUTE_WORK_GROUP_INVOCATIONS:Int;
	@:native("GL_MAX_COMPUTE_WORK_GROUP_COUNT")
	public static var MAX_COMPUTE_WORK_GROUP_COUNT:Int;
	@:native("GL_MAX_COMPUTE_WORK_GROUP_SIZE")
	public static var MAX_COMPUTE_WORK_GROUP_SIZE:Int;
	@:native("GL_COMPUTE_WORK_GROUP_SIZE")
	public static var COMPUTE_WORK_GROUP_SIZE:Int;
	@:native("GL_UNIFORM_BLOCK_REFERENCED_BY_COMPUTE_SHADER")
	public static var UNIFORM_BLOCK_REFERENCED_BY_COMPUTE_SHADER:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_COMPUTE_SHADER")
	public static var ATOMIC_COUNTER_BUFFER_REFERENCED_BY_COMPUTE_SHADER:Int;
	@:native("GL_DISPATCH_INDIRECT_BUFFER")
	public static var DISPATCH_INDIRECT_BUFFER:Int;
	@:native("GL_DISPATCH_INDIRECT_BUFFER_BINDING")
	public static var DISPATCH_INDIRECT_BUFFER_BINDING:Int;
	@:native("GL_COMPUTE_SHADER_BIT")
	public static var COMPUTE_SHADER_BIT:Int;
	@:native("GL_DEBUG_OUTPUT_SYNCHRONOUS")
	public static var DEBUG_OUTPUT_SYNCHRONOUS:Int;
	@:native("GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH")
	public static var DEBUG_NEXT_LOGGED_MESSAGE_LENGTH:Int;
	@:native("GL_DEBUG_CALLBACK_FUNCTION")
	public static var DEBUG_CALLBACK_FUNCTION:Int;
	@:native("GL_DEBUG_CALLBACK_USER_PARAM")
	public static var DEBUG_CALLBACK_USER_PARAM:Int;
	@:native("GL_DEBUG_SOURCE_API")
	public static var DEBUG_SOURCE_API:Int;
	@:native("GL_DEBUG_SOURCE_WINDOW_SYSTEM")
	public static var DEBUG_SOURCE_WINDOW_SYSTEM:Int;
	@:native("GL_DEBUG_SOURCE_SHADER_COMPILER")
	public static var DEBUG_SOURCE_SHADER_COMPILER:Int;
	@:native("GL_DEBUG_SOURCE_THIRD_PARTY")
	public static var DEBUG_SOURCE_THIRD_PARTY:Int;
	@:native("GL_DEBUG_SOURCE_APPLICATION")
	public static var DEBUG_SOURCE_APPLICATION:Int;
	@:native("GL_DEBUG_SOURCE_OTHER")
	public static var DEBUG_SOURCE_OTHER:Int;
	@:native("GL_DEBUG_TYPE_ERROR")
	public static var DEBUG_TYPE_ERROR:Int;
	@:native("GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR")
	public static var DEBUG_TYPE_DEPRECATED_BEHAVIOR:Int;
	@:native("GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR")
	public static var DEBUG_TYPE_UNDEFINED_BEHAVIOR:Int;
	@:native("GL_DEBUG_TYPE_PORTABILITY")
	public static var DEBUG_TYPE_PORTABILITY:Int;
	@:native("GL_DEBUG_TYPE_PERFORMANCE")
	public static var DEBUG_TYPE_PERFORMANCE:Int;
	@:native("GL_DEBUG_TYPE_OTHER")
	public static var DEBUG_TYPE_OTHER:Int;
	@:native("GL_MAX_DEBUG_MESSAGE_LENGTH")
	public static var MAX_DEBUG_MESSAGE_LENGTH:Int;
	@:native("GL_MAX_DEBUG_LOGGED_MESSAGES")
	public static var MAX_DEBUG_LOGGED_MESSAGES:Int;
	@:native("GL_DEBUG_LOGGED_MESSAGES")
	public static var DEBUG_LOGGED_MESSAGES:Int;
	@:native("GL_DEBUG_SEVERITY_HIGH")
	public static var DEBUG_SEVERITY_HIGH:Int;
	@:native("GL_DEBUG_SEVERITY_MEDIUM")
	public static var DEBUG_SEVERITY_MEDIUM:Int;
	@:native("GL_DEBUG_SEVERITY_LOW")
	public static var DEBUG_SEVERITY_LOW:Int;
	@:native("GL_DEBUG_TYPE_MARKER")
	public static var DEBUG_TYPE_MARKER:Int;
	@:native("GL_DEBUG_TYPE_PUSH_GROUP")
	public static var DEBUG_TYPE_PUSH_GROUP:Int;
	@:native("GL_DEBUG_TYPE_POP_GROUP")
	public static var DEBUG_TYPE_POP_GROUP:Int;
	@:native("GL_DEBUG_SEVERITY_NOTIFICATION")
	public static var DEBUG_SEVERITY_NOTIFICATION:Int;
	@:native("GL_MAX_DEBUG_GROUP_STACK_DEPTH")
	public static var MAX_DEBUG_GROUP_STACK_DEPTH:Int;
	@:native("GL_DEBUG_GROUP_STACK_DEPTH")
	public static var DEBUG_GROUP_STACK_DEPTH:Int;
	@:native("GL_BUFFER")
	public static var BUFFER:Int;
	@:native("GL_SHADER")
	public static var SHADER:Int;
	@:native("GL_PROGRAM")
	public static var PROGRAM:Int;
	@:native("GL_VERTEX_ARRAY")
	public static var VERTEX_ARRAY:Int;
	@:native("GL_QUERY")
	public static var QUERY:Int;
	@:native("GL_PROGRAM_PIPELINE")
	public static var PROGRAM_PIPELINE:Int;
	@:native("GL_SAMPLER")
	public static var SAMPLER:Int;
	@:native("GL_MAX_LABEL_LENGTH")
	public static var MAX_LABEL_LENGTH:Int;
	@:native("GL_DEBUG_OUTPUT")
	public static var DEBUG_OUTPUT:Int;
	@:native("GL_CONTEXT_FLAG_DEBUG_BIT")
	public static var CONTEXT_FLAG_DEBUG_BIT:Int;
	@:native("GL_MAX_UNIFORM_LOCATIONS")
	public static var MAX_UNIFORM_LOCATIONS:Int;
	@:native("GL_FRAMEBUFFER_DEFAULT_WIDTH")
	public static var FRAMEBUFFER_DEFAULT_WIDTH:Int;
	@:native("GL_FRAMEBUFFER_DEFAULT_HEIGHT")
	public static var FRAMEBUFFER_DEFAULT_HEIGHT:Int;
	@:native("GL_FRAMEBUFFER_DEFAULT_LAYERS")
	public static var FRAMEBUFFER_DEFAULT_LAYERS:Int;
	@:native("GL_FRAMEBUFFER_DEFAULT_SAMPLES")
	public static var FRAMEBUFFER_DEFAULT_SAMPLES:Int;
	@:native("GL_FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS")
	public static var FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS:Int;
	@:native("GL_MAX_FRAMEBUFFER_WIDTH")
	public static var MAX_FRAMEBUFFER_WIDTH:Int;
	@:native("GL_MAX_FRAMEBUFFER_HEIGHT")
	public static var MAX_FRAMEBUFFER_HEIGHT:Int;
	@:native("GL_MAX_FRAMEBUFFER_LAYERS")
	public static var MAX_FRAMEBUFFER_LAYERS:Int;
	@:native("GL_MAX_FRAMEBUFFER_SAMPLES")
	public static var MAX_FRAMEBUFFER_SAMPLES:Int;
	@:native("GL_INTERNALFORMAT_SUPPORTED")
	public static var INTERNALFORMAT_SUPPORTED:Int;
	@:native("GL_INTERNALFORMAT_PREFERRED")
	public static var INTERNALFORMAT_PREFERRED:Int;
	@:native("GL_INTERNALFORMAT_RED_SIZE")
	public static var INTERNALFORMAT_RED_SIZE:Int;
	@:native("GL_INTERNALFORMAT_GREEN_SIZE")
	public static var INTERNALFORMAT_GREEN_SIZE:Int;
	@:native("GL_INTERNALFORMAT_BLUE_SIZE")
	public static var INTERNALFORMAT_BLUE_SIZE:Int;
	@:native("GL_INTERNALFORMAT_ALPHA_SIZE")
	public static var INTERNALFORMAT_ALPHA_SIZE:Int;
	@:native("GL_INTERNALFORMAT_DEPTH_SIZE")
	public static var INTERNALFORMAT_DEPTH_SIZE:Int;
	@:native("GL_INTERNALFORMAT_STENCIL_SIZE")
	public static var INTERNALFORMAT_STENCIL_SIZE:Int;
	@:native("GL_INTERNALFORMAT_SHARED_SIZE")
	public static var INTERNALFORMAT_SHARED_SIZE:Int;
	@:native("GL_INTERNALFORMAT_RED_TYPE")
	public static var INTERNALFORMAT_RED_TYPE:Int;
	@:native("GL_INTERNALFORMAT_GREEN_TYPE")
	public static var INTERNALFORMAT_GREEN_TYPE:Int;
	@:native("GL_INTERNALFORMAT_BLUE_TYPE")
	public static var INTERNALFORMAT_BLUE_TYPE:Int;
	@:native("GL_INTERNALFORMAT_ALPHA_TYPE")
	public static var INTERNALFORMAT_ALPHA_TYPE:Int;
	@:native("GL_INTERNALFORMAT_DEPTH_TYPE")
	public static var INTERNALFORMAT_DEPTH_TYPE:Int;
	@:native("GL_INTERNALFORMAT_STENCIL_TYPE")
	public static var INTERNALFORMAT_STENCIL_TYPE:Int;
	@:native("GL_MAX_WIDTH")
	public static var MAX_WIDTH:Int;
	@:native("GL_MAX_HEIGHT")
	public static var MAX_HEIGHT:Int;
	@:native("GL_MAX_DEPTH")
	public static var MAX_DEPTH:Int;
	@:native("GL_MAX_LAYERS")
	public static var MAX_LAYERS:Int;
	@:native("GL_MAX_COMBINED_DIMENSIONS")
	public static var MAX_COMBINED_DIMENSIONS:Int;
	@:native("GL_COLOR_COMPONENTS")
	public static var COLOR_COMPONENTS:Int;
	@:native("GL_DEPTH_COMPONENTS")
	public static var DEPTH_COMPONENTS:Int;
	@:native("GL_STENCIL_COMPONENTS")
	public static var STENCIL_COMPONENTS:Int;
	@:native("GL_COLOR_RENDERABLE")
	public static var COLOR_RENDERABLE:Int;
	@:native("GL_DEPTH_RENDERABLE")
	public static var DEPTH_RENDERABLE:Int;
	@:native("GL_STENCIL_RENDERABLE")
	public static var STENCIL_RENDERABLE:Int;
	@:native("GL_FRAMEBUFFER_RENDERABLE")
	public static var FRAMEBUFFER_RENDERABLE:Int;
	@:native("GL_FRAMEBUFFER_RENDERABLE_LAYERED")
	public static var FRAMEBUFFER_RENDERABLE_LAYERED:Int;
	@:native("GL_FRAMEBUFFER_BLEND")
	public static var FRAMEBUFFER_BLEND:Int;
	@:native("GL_READ_PIXELS")
	public static var READ_PIXELS:Int;
	@:native("GL_READ_PIXELS_FORMAT")
	public static var READ_PIXELS_FORMAT:Int;
	@:native("GL_READ_PIXELS_TYPE")
	public static var READ_PIXELS_TYPE:Int;
	@:native("GL_TEXTURE_IMAGE_FORMAT")
	public static var TEXTURE_IMAGE_FORMAT:Int;
	@:native("GL_TEXTURE_IMAGE_TYPE")
	public static var TEXTURE_IMAGE_TYPE:Int;
	@:native("GL_GET_TEXTURE_IMAGE_FORMAT")
	public static var GET_TEXTURE_IMAGE_FORMAT:Int;
	@:native("GL_GET_TEXTURE_IMAGE_TYPE")
	public static var GET_TEXTURE_IMAGE_TYPE:Int;
	@:native("GL_MIPMAP")
	public static var MIPMAP:Int;
	@:native("GL_MANUAL_GENERATE_MIPMAP")
	public static var MANUAL_GENERATE_MIPMAP:Int;
	@:native("GL_AUTO_GENERATE_MIPMAP")
	public static var AUTO_GENERATE_MIPMAP:Int;
	@:native("GL_COLOR_ENCODING")
	public static var COLOR_ENCODING:Int;
	@:native("GL_SRGB_READ")
	public static var SRGB_READ:Int;
	@:native("GL_SRGB_WRITE")
	public static var SRGB_WRITE:Int;
	@:native("GL_FILTER")
	public static var FILTER:Int;
	@:native("GL_VERTEX_TEXTURE")
	public static var VERTEX_TEXTURE:Int;
	@:native("GL_TESS_CONTROL_TEXTURE")
	public static var TESS_CONTROL_TEXTURE:Int;
	@:native("GL_TESS_EVALUATION_TEXTURE")
	public static var TESS_EVALUATION_TEXTURE:Int;
	@:native("GL_GEOMETRY_TEXTURE")
	public static var GEOMETRY_TEXTURE:Int;
	@:native("GL_FRAGMENT_TEXTURE")
	public static var FRAGMENT_TEXTURE:Int;
	@:native("GL_COMPUTE_TEXTURE")
	public static var COMPUTE_TEXTURE:Int;
	@:native("GL_TEXTURE_SHADOW")
	public static var TEXTURE_SHADOW:Int;
	@:native("GL_TEXTURE_GATHER")
	public static var TEXTURE_GATHER:Int;
	@:native("GL_TEXTURE_GATHER_SHADOW")
	public static var TEXTURE_GATHER_SHADOW:Int;
	@:native("GL_SHADER_IMAGE_LOAD")
	public static var SHADER_IMAGE_LOAD:Int;
	@:native("GL_SHADER_IMAGE_STORE")
	public static var SHADER_IMAGE_STORE:Int;
	@:native("GL_SHADER_IMAGE_ATOMIC")
	public static var SHADER_IMAGE_ATOMIC:Int;
	@:native("GL_IMAGE_TEXEL_SIZE")
	public static var IMAGE_TEXEL_SIZE:Int;
	@:native("GL_IMAGE_COMPATIBILITY_CLASS")
	public static var IMAGE_COMPATIBILITY_CLASS:Int;
	@:native("GL_IMAGE_PIXEL_FORMAT")
	public static var IMAGE_PIXEL_FORMAT:Int;
	@:native("GL_IMAGE_PIXEL_TYPE")
	public static var IMAGE_PIXEL_TYPE:Int;
	@:native("GL_SIMULTANEOUS_TEXTURE_AND_DEPTH_TEST")
	public static var SIMULTANEOUS_TEXTURE_AND_DEPTH_TEST:Int;
	@:native("GL_SIMULTANEOUS_TEXTURE_AND_STENCIL_TEST")
	public static var SIMULTANEOUS_TEXTURE_AND_STENCIL_TEST:Int;
	@:native("GL_SIMULTANEOUS_TEXTURE_AND_DEPTH_WRITE")
	public static var SIMULTANEOUS_TEXTURE_AND_DEPTH_WRITE:Int;
	@:native("GL_SIMULTANEOUS_TEXTURE_AND_STENCIL_WRITE")
	public static var SIMULTANEOUS_TEXTURE_AND_STENCIL_WRITE:Int;
	@:native("GL_TEXTURE_COMPRESSED_BLOCK_WIDTH")
	public static var TEXTURE_COMPRESSED_BLOCK_WIDTH:Int;
	@:native("GL_TEXTURE_COMPRESSED_BLOCK_HEIGHT")
	public static var TEXTURE_COMPRESSED_BLOCK_HEIGHT:Int;
	@:native("GL_TEXTURE_COMPRESSED_BLOCK_SIZE")
	public static var TEXTURE_COMPRESSED_BLOCK_SIZE:Int;
	@:native("GL_CLEAR_BUFFER")
	public static var CLEAR_BUFFER:Int;
	@:native("GL_TEXTURE_VIEW")
	public static var TEXTURE_VIEW:Int;
	@:native("GL_VIEW_COMPATIBILITY_CLASS")
	public static var VIEW_COMPATIBILITY_CLASS:Int;
	@:native("GL_FULL_SUPPORT")
	public static var FULL_SUPPORT:Int;
	@:native("GL_CAVEAT_SUPPORT")
	public static var CAVEAT_SUPPORT:Int;
	@:native("GL_IMAGE_CLASS_4_X_32")
	public static var IMAGE_CLASS_4_X_32:Int;
	@:native("GL_IMAGE_CLASS_2_X_32")
	public static var IMAGE_CLASS_2_X_32:Int;
	@:native("GL_IMAGE_CLASS_1_X_32")
	public static var IMAGE_CLASS_1_X_32:Int;
	@:native("GL_IMAGE_CLASS_4_X_16")
	public static var IMAGE_CLASS_4_X_16:Int;
	@:native("GL_IMAGE_CLASS_2_X_16")
	public static var IMAGE_CLASS_2_X_16:Int;
	@:native("GL_IMAGE_CLASS_1_X_16")
	public static var IMAGE_CLASS_1_X_16:Int;
	@:native("GL_IMAGE_CLASS_4_X_8")
	public static var IMAGE_CLASS_4_X_8:Int;
	@:native("GL_IMAGE_CLASS_2_X_8")
	public static var IMAGE_CLASS_2_X_8:Int;
	@:native("GL_IMAGE_CLASS_1_X_8")
	public static var IMAGE_CLASS_1_X_8:Int;
	@:native("GL_IMAGE_CLASS_11_11_10")
	public static var IMAGE_CLASS_11_11_10:Int;
	@:native("GL_IMAGE_CLASS_10_10_10_2")
	public static var IMAGE_CLASS_10_10_10_2:Int;
	@:native("GL_VIEW_CLASS_128_BITS")
	public static var VIEW_CLASS_128_BITS:Int;
	@:native("GL_VIEW_CLASS_96_BITS")
	public static var VIEW_CLASS_96_BITS:Int;
	@:native("GL_VIEW_CLASS_64_BITS")
	public static var VIEW_CLASS_64_BITS:Int;
	@:native("GL_VIEW_CLASS_48_BITS")
	public static var VIEW_CLASS_48_BITS:Int;
	@:native("GL_VIEW_CLASS_32_BITS")
	public static var VIEW_CLASS_32_BITS:Int;
	@:native("GL_VIEW_CLASS_24_BITS")
	public static var VIEW_CLASS_24_BITS:Int;
	@:native("GL_VIEW_CLASS_16_BITS")
	public static var VIEW_CLASS_16_BITS:Int;
	@:native("GL_VIEW_CLASS_8_BITS")
	public static var VIEW_CLASS_8_BITS:Int;
	@:native("GL_VIEW_CLASS_S3TC_DXT1_RGB")
	public static var VIEW_CLASS_S3TC_DXT1_RGB:Int;
	@:native("GL_VIEW_CLASS_S3TC_DXT1_RGBA")
	public static var VIEW_CLASS_S3TC_DXT1_RGBA:Int;
	@:native("GL_VIEW_CLASS_S3TC_DXT3_RGBA")
	public static var VIEW_CLASS_S3TC_DXT3_RGBA:Int;
	@:native("GL_VIEW_CLASS_S3TC_DXT5_RGBA")
	public static var VIEW_CLASS_S3TC_DXT5_RGBA:Int;
	@:native("GL_VIEW_CLASS_RGTC1_RED")
	public static var VIEW_CLASS_RGTC1_RED:Int;
	@:native("GL_VIEW_CLASS_RGTC2_RG")
	public static var VIEW_CLASS_RGTC2_RG:Int;
	@:native("GL_VIEW_CLASS_BPTC_UNORM")
	public static var VIEW_CLASS_BPTC_UNORM:Int;
	@:native("GL_VIEW_CLASS_BPTC_FLOAT")
	public static var VIEW_CLASS_BPTC_FLOAT:Int;
	@:native("GL_UNIFORM")
	public static var UNIFORM:Int;
	@:native("GL_UNIFORM_BLOCK")
	public static var UNIFORM_BLOCK:Int;
	@:native("GL_PROGRAM_INPUT")
	public static var PROGRAM_INPUT:Int;
	@:native("GL_PROGRAM_OUTPUT")
	public static var PROGRAM_OUTPUT:Int;
	@:native("GL_BUFFER_VARIABLE")
	public static var BUFFER_VARIABLE:Int;
	@:native("GL_SHADER_STORAGE_BLOCK")
	public static var SHADER_STORAGE_BLOCK:Int;
	@:native("GL_VERTEX_SUBROUTINE")
	public static var VERTEX_SUBROUTINE:Int;
	@:native("GL_TESS_CONTROL_SUBROUTINE")
	public static var TESS_CONTROL_SUBROUTINE:Int;
	@:native("GL_TESS_EVALUATION_SUBROUTINE")
	public static var TESS_EVALUATION_SUBROUTINE:Int;
	@:native("GL_GEOMETRY_SUBROUTINE")
	public static var GEOMETRY_SUBROUTINE:Int;
	@:native("GL_FRAGMENT_SUBROUTINE")
	public static var FRAGMENT_SUBROUTINE:Int;
	@:native("GL_COMPUTE_SUBROUTINE")
	public static var COMPUTE_SUBROUTINE:Int;
	@:native("GL_VERTEX_SUBROUTINE_UNIFORM")
	public static var VERTEX_SUBROUTINE_UNIFORM:Int;
	@:native("GL_TESS_CONTROL_SUBROUTINE_UNIFORM")
	public static var TESS_CONTROL_SUBROUTINE_UNIFORM:Int;
	@:native("GL_TESS_EVALUATION_SUBROUTINE_UNIFORM")
	public static var TESS_EVALUATION_SUBROUTINE_UNIFORM:Int;
	@:native("GL_GEOMETRY_SUBROUTINE_UNIFORM")
	public static var GEOMETRY_SUBROUTINE_UNIFORM:Int;
	@:native("GL_FRAGMENT_SUBROUTINE_UNIFORM")
	public static var FRAGMENT_SUBROUTINE_UNIFORM:Int;
	@:native("GL_COMPUTE_SUBROUTINE_UNIFORM")
	public static var COMPUTE_SUBROUTINE_UNIFORM:Int;
	@:native("GL_TRANSFORM_FEEDBACK_VARYING")
	public static var TRANSFORM_FEEDBACK_VARYING:Int;
	@:native("GL_ACTIVE_RESOURCES")
	public static var ACTIVE_RESOURCES:Int;
	@:native("GL_MAX_NAME_LENGTH")
	public static var MAX_NAME_LENGTH:Int;
	@:native("GL_MAX_NUM_ACTIVE_VARIABLES")
	public static var MAX_NUM_ACTIVE_VARIABLES:Int;
	@:native("GL_MAX_NUM_COMPATIBLE_SUBROUTINES")
	public static var MAX_NUM_COMPATIBLE_SUBROUTINES:Int;
	@:native("GL_NAME_LENGTH")
	public static var NAME_LENGTH:Int;
	@:native("GL_TYPE")
	public static var TYPE:Int;
	@:native("GL_ARRAY_SIZE")
	public static var ARRAY_SIZE:Int;
	@:native("GL_OFFSET")
	public static var OFFSET:Int;
	@:native("GL_BLOCK_INDEX")
	public static var BLOCK_INDEX:Int;
	@:native("GL_ARRAY_STRIDE")
	public static var ARRAY_STRIDE:Int;
	@:native("GL_MATRIX_STRIDE")
	public static var MATRIX_STRIDE:Int;
	@:native("GL_IS_ROW_MAJOR")
	public static var IS_ROW_MAJOR:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_INDEX")
	public static var ATOMIC_COUNTER_BUFFER_INDEX:Int;
	@:native("GL_BUFFER_BINDING")
	public static var BUFFER_BINDING:Int;
	@:native("GL_BUFFER_DATA_SIZE")
	public static var BUFFER_DATA_SIZE:Int;
	@:native("GL_NUM_ACTIVE_VARIABLES")
	public static var NUM_ACTIVE_VARIABLES:Int;
	@:native("GL_ACTIVE_VARIABLES")
	public static var ACTIVE_VARIABLES:Int;
	@:native("GL_REFERENCED_BY_VERTEX_SHADER")
	public static var REFERENCED_BY_VERTEX_SHADER:Int;
	@:native("GL_REFERENCED_BY_TESS_CONTROL_SHADER")
	public static var REFERENCED_BY_TESS_CONTROL_SHADER:Int;
	@:native("GL_REFERENCED_BY_TESS_EVALUATION_SHADER")
	public static var REFERENCED_BY_TESS_EVALUATION_SHADER:Int;
	@:native("GL_REFERENCED_BY_GEOMETRY_SHADER")
	public static var REFERENCED_BY_GEOMETRY_SHADER:Int;
	@:native("GL_REFERENCED_BY_FRAGMENT_SHADER")
	public static var REFERENCED_BY_FRAGMENT_SHADER:Int;
	@:native("GL_REFERENCED_BY_COMPUTE_SHADER")
	public static var REFERENCED_BY_COMPUTE_SHADER:Int;
	@:native("GL_TOP_LEVEL_ARRAY_SIZE")
	public static var TOP_LEVEL_ARRAY_SIZE:Int;
	@:native("GL_TOP_LEVEL_ARRAY_STRIDE")
	public static var TOP_LEVEL_ARRAY_STRIDE:Int;
	@:native("GL_LOCATION")
	public static var LOCATION:Int;
	@:native("GL_LOCATION_INDEX")
	public static var LOCATION_INDEX:Int;
	@:native("GL_IS_PER_PATCH")
	public static var IS_PER_PATCH:Int;
	@:native("GL_SHADER_STORAGE_BUFFER")
	public static var SHADER_STORAGE_BUFFER:Int;
	@:native("GL_SHADER_STORAGE_BUFFER_BINDING")
	public static var SHADER_STORAGE_BUFFER_BINDING:Int;
	@:native("GL_SHADER_STORAGE_BUFFER_START")
	public static var SHADER_STORAGE_BUFFER_START:Int;
	@:native("GL_SHADER_STORAGE_BUFFER_SIZE")
	public static var SHADER_STORAGE_BUFFER_SIZE:Int;
	@:native("GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS")
	public static var MAX_VERTEX_SHADER_STORAGE_BLOCKS:Int;
	@:native("GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS")
	public static var MAX_GEOMETRY_SHADER_STORAGE_BLOCKS:Int;
	@:native("GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS")
	public static var MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS:Int;
	@:native("GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS")
	public static var MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS:Int;
	@:native("GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS")
	public static var MAX_FRAGMENT_SHADER_STORAGE_BLOCKS:Int;
	@:native("GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS")
	public static var MAX_COMPUTE_SHADER_STORAGE_BLOCKS:Int;
	@:native("GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS")
	public static var MAX_COMBINED_SHADER_STORAGE_BLOCKS:Int;
	@:native("GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS")
	public static var MAX_SHADER_STORAGE_BUFFER_BINDINGS:Int;
	@:native("GL_MAX_SHADER_STORAGE_BLOCK_SIZE")
	public static var MAX_SHADER_STORAGE_BLOCK_SIZE:Int;
	@:native("GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT")
	public static var SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT:Int;
	@:native("GL_SHADER_STORAGE_BARRIER_BIT")
	public static var SHADER_STORAGE_BARRIER_BIT:Int;
	@:native("GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES")
	public static var MAX_COMBINED_SHADER_OUTPUT_RESOURCES:Int;
	@:native("GL_DEPTH_STENCIL_TEXTURE_MODE")
	public static var DEPTH_STENCIL_TEXTURE_MODE:Int;
	@:native("GL_TEXTURE_BUFFER_OFFSET")
	public static var TEXTURE_BUFFER_OFFSET:Int;
	@:native("GL_TEXTURE_BUFFER_SIZE")
	public static var TEXTURE_BUFFER_SIZE:Int;
	@:native("GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT")
	public static var TEXTURE_BUFFER_OFFSET_ALIGNMENT:Int;
	@:native("GL_TEXTURE_VIEW_MIN_LEVEL")
	public static var TEXTURE_VIEW_MIN_LEVEL:Int;
	@:native("GL_TEXTURE_VIEW_NUM_LEVELS")
	public static var TEXTURE_VIEW_NUM_LEVELS:Int;
	@:native("GL_TEXTURE_VIEW_MIN_LAYER")
	public static var TEXTURE_VIEW_MIN_LAYER:Int;
	@:native("GL_TEXTURE_VIEW_NUM_LAYERS")
	public static var TEXTURE_VIEW_NUM_LAYERS:Int;
	@:native("GL_TEXTURE_IMMUTABLE_LEVELS")
	public static var TEXTURE_IMMUTABLE_LEVELS:Int;
	@:native("GL_VERTEX_ATTRIB_BINDING")
	public static var VERTEX_ATTRIB_BINDING:Int;
	@:native("GL_VERTEX_ATTRIB_RELATIVE_OFFSET")
	public static var VERTEX_ATTRIB_RELATIVE_OFFSET:Int;
	@:native("GL_VERTEX_BINDING_DIVISOR")
	public static var VERTEX_BINDING_DIVISOR:Int;
	@:native("GL_VERTEX_BINDING_OFFSET")
	public static var VERTEX_BINDING_OFFSET:Int;
	@:native("GL_VERTEX_BINDING_STRIDE")
	public static var VERTEX_BINDING_STRIDE:Int;
	@:native("GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET")
	public static var MAX_VERTEX_ATTRIB_RELATIVE_OFFSET:Int;
	@:native("GL_MAX_VERTEX_ATTRIB_BINDINGS")
	public static var MAX_VERTEX_ATTRIB_BINDINGS:Int;
	@:native("GL_VERTEX_BINDING_BUFFER")
	public static var VERTEX_BINDING_BUFFER:Int;
	@:native("GL_DISPLAY_LIST")
	public static var DISPLAY_LIST:Int;
	@:native("GL_STACK_UNDERFLOW")
	public static var STACK_UNDERFLOW:Int;
	@:native("GL_STACK_OVERFLOW")
	public static var STACK_OVERFLOW:Int;
	@:native("GL_MAX_VERTEX_ATTRIB_STRIDE")
	public static var MAX_VERTEX_ATTRIB_STRIDE:Int;
	@:native("GL_PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED")
	public static var PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED:Int;
	@:native("GL_TEXTURE_BUFFER_BINDING")
	public static var TEXTURE_BUFFER_BINDING:Int;
	@:native("GL_MAP_PERSISTENT_BIT")
	public static var MAP_PERSISTENT_BIT:Int;
	@:native("GL_MAP_COHERENT_BIT")
	public static var MAP_COHERENT_BIT:Int;
	@:native("GL_DYNAMIC_STORAGE_BIT")
	public static var DYNAMIC_STORAGE_BIT:Int;
	@:native("GL_CLIENT_STORAGE_BIT")
	public static var CLIENT_STORAGE_BIT:Int;
	@:native("GL_CLIENT_MAPPED_BUFFER_BARRIER_BIT")
	public static var CLIENT_MAPPED_BUFFER_BARRIER_BIT:Int;
	@:native("GL_BUFFER_IMMUTABLE_STORAGE")
	public static var BUFFER_IMMUTABLE_STORAGE:Int;
	@:native("GL_BUFFER_STORAGE_FLAGS")
	public static var BUFFER_STORAGE_FLAGS:Int;
	@:native("GL_CLEAR_TEXTURE")
	public static var CLEAR_TEXTURE:Int;
	@:native("GL_LOCATION_COMPONENT")
	public static var LOCATION_COMPONENT:Int;
	@:native("GL_TRANSFORM_FEEDBACK_BUFFER_INDEX")
	public static var TRANSFORM_FEEDBACK_BUFFER_INDEX:Int;
	@:native("GL_TRANSFORM_FEEDBACK_BUFFER_STRIDE")
	public static var TRANSFORM_FEEDBACK_BUFFER_STRIDE:Int;
	@:native("GL_QUERY_BUFFER")
	public static var QUERY_BUFFER:Int;
	@:native("GL_QUERY_BUFFER_BARRIER_BIT")
	public static var QUERY_BUFFER_BARRIER_BIT:Int;
	@:native("GL_QUERY_BUFFER_BINDING")
	public static var QUERY_BUFFER_BINDING:Int;
	@:native("GL_QUERY_RESULT_NO_WAIT")
	public static var QUERY_RESULT_NO_WAIT:Int;
	@:native("GL_MIRROR_CLAMP_TO_EDGE")
	public static var MIRROR_CLAMP_TO_EDGE:Int;
	@:native("GL_CONTEXT_LOST")
	public static var CONTEXT_LOST:Int;
	@:native("GL_NEGATIVE_ONE_TO_ONE")
	public static var NEGATIVE_ONE_TO_ONE:Int;
	@:native("GL_ZERO_TO_ONE")
	public static var ZERO_TO_ONE:Int;
	@:native("GL_CLIP_ORIGIN")
	public static var CLIP_ORIGIN:Int;
	@:native("GL_CLIP_DEPTH_MODE")
	public static var CLIP_DEPTH_MODE:Int;
	@:native("GL_QUERY_WAIT_INVERTED")
	public static var QUERY_WAIT_INVERTED:Int;
	@:native("GL_QUERY_NO_WAIT_INVERTED")
	public static var QUERY_NO_WAIT_INVERTED:Int;
	@:native("GL_QUERY_BY_REGION_WAIT_INVERTED")
	public static var QUERY_BY_REGION_WAIT_INVERTED:Int;
	@:native("GL_QUERY_BY_REGION_NO_WAIT_INVERTED")
	public static var QUERY_BY_REGION_NO_WAIT_INVERTED:Int;
	@:native("GL_MAX_CULL_DISTANCES")
	public static var MAX_CULL_DISTANCES:Int;
	@:native("GL_MAX_COMBINED_CLIP_AND_CULL_DISTANCES")
	public static var MAX_COMBINED_CLIP_AND_CULL_DISTANCES:Int;
	@:native("GL_TEXTURE_TARGET")
	public static var TEXTURE_TARGET:Int;
	@:native("GL_QUERY_TARGET")
	public static var QUERY_TARGET:Int;
	@:native("GL_GUILTY_CONTEXT_RESET")
	public static var GUILTY_CONTEXT_RESET:Int;
	@:native("GL_INNOCENT_CONTEXT_RESET")
	public static var INNOCENT_CONTEXT_RESET:Int;
	@:native("GL_UNKNOWN_CONTEXT_RESET")
	public static var UNKNOWN_CONTEXT_RESET:Int;
	@:native("GL_RESET_NOTIFICATION_STRATEGY")
	public static var RESET_NOTIFICATION_STRATEGY:Int;
	@:native("GL_LOSE_CONTEXT_ON_RESET")
	public static var LOSE_CONTEXT_ON_RESET:Int;
	@:native("GL_NO_RESET_NOTIFICATION")
	public static var NO_RESET_NOTIFICATION:Int;
	@:native("GL_CONTEXT_FLAG_ROBUST_ACCESS_BIT")
	public static var CONTEXT_FLAG_ROBUST_ACCESS_BIT:Int;
	@:native("GL_COLOR_TABLE")
	public static var COLOR_TABLE:Int;
	@:native("GL_POST_CONVOLUTION_COLOR_TABLE")
	public static var POST_CONVOLUTION_COLOR_TABLE:Int;
	@:native("GL_POST_COLOR_MATRIX_COLOR_TABLE")
	public static var POST_COLOR_MATRIX_COLOR_TABLE:Int;
	@:native("GL_PROXY_COLOR_TABLE")
	public static var PROXY_COLOR_TABLE:Int;
	@:native("GL_PROXY_POST_CONVOLUTION_COLOR_TABLE")
	public static var PROXY_POST_CONVOLUTION_COLOR_TABLE:Int;
	@:native("GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE")
	public static var PROXY_POST_COLOR_MATRIX_COLOR_TABLE:Int;
	@:native("GL_CONVOLUTION_1D")
	public static var CONVOLUTION_1D:Int;
	@:native("GL_CONVOLUTION_2D")
	public static var CONVOLUTION_2D:Int;
	@:native("GL_SEPARABLE_2D")
	public static var SEPARABLE_2D:Int;
	@:native("GL_HISTOGRAM")
	public static var HISTOGRAM:Int;
	@:native("GL_PROXY_HISTOGRAM")
	public static var PROXY_HISTOGRAM:Int;
	@:native("GL_MINMAX")
	public static var MINMAX:Int;
	@:native("GL_CONTEXT_RELEASE_BEHAVIOR")
	public static var CONTEXT_RELEASE_BEHAVIOR:Int;
	@:native("GL_CONTEXT_RELEASE_BEHAVIOR_FLUSH")
	public static var CONTEXT_RELEASE_BEHAVIOR_FLUSH:Int;
	@:native("GL_SHADER_BINARY_FORMAT_SPIR_V")
	public static var SHADER_BINARY_FORMAT_SPIR_V:Int;
	@:native("GL_SPIR_V_BINARY")
	public static var SPIR_V_BINARY:Int;
	@:native("GL_PARAMETER_BUFFER")
	public static var PARAMETER_BUFFER:Int;
	@:native("GL_PARAMETER_BUFFER_BINDING")
	public static var PARAMETER_BUFFER_BINDING:Int;
	@:native("GL_CONTEXT_FLAG_NO_ERROR_BIT")
	public static var CONTEXT_FLAG_NO_ERROR_BIT:Int;
	@:native("GL_VERTICES_SUBMITTED")
	public static var VERTICES_SUBMITTED:Int;
	@:native("GL_PRIMITIVES_SUBMITTED")
	public static var PRIMITIVES_SUBMITTED:Int;
	@:native("GL_VERTEX_SHADER_INVOCATIONS")
	public static var VERTEX_SHADER_INVOCATIONS:Int;
	@:native("GL_TESS_CONTROL_SHADER_PATCHES")
	public static var TESS_CONTROL_SHADER_PATCHES:Int;
	@:native("GL_TESS_EVALUATION_SHADER_INVOCATIONS")
	public static var TESS_EVALUATION_SHADER_INVOCATIONS:Int;
	@:native("GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED")
	public static var GEOMETRY_SHADER_PRIMITIVES_EMITTED:Int;
	@:native("GL_FRAGMENT_SHADER_INVOCATIONS")
	public static var FRAGMENT_SHADER_INVOCATIONS:Int;
	@:native("GL_COMPUTE_SHADER_INVOCATIONS")
	public static var COMPUTE_SHADER_INVOCATIONS:Int;
	@:native("GL_CLIPPING_INPUT_PRIMITIVES")
	public static var CLIPPING_INPUT_PRIMITIVES:Int;
	@:native("GL_CLIPPING_OUTPUT_PRIMITIVES")
	public static var CLIPPING_OUTPUT_PRIMITIVES:Int;
	@:native("GL_POLYGON_OFFSET_CLAMP")
	public static var POLYGON_OFFSET_CLAMP:Int;
	@:native("GL_SPIR_V_EXTENSIONS")
	public static var SPIR_V_EXTENSIONS:Int;
	@:native("GL_NUM_SPIR_V_EXTENSIONS")
	public static var NUM_SPIR_V_EXTENSIONS:Int;
	@:native("GL_TEXTURE_MAX_ANISOTROPY")
	public static var TEXTURE_MAX_ANISOTROPY:Int;
	@:native("GL_MAX_TEXTURE_MAX_ANISOTROPY")
	public static var MAX_TEXTURE_MAX_ANISOTROPY:Int;
	@:native("GL_TRANSFORM_FEEDBACK_OVERFLOW")
	public static var TRANSFORM_FEEDBACK_OVERFLOW:Int;
	@:native("GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW")
	public static var TRANSFORM_FEEDBACK_STREAM_OVERFLOW:Int;
	@:native("GL_VERSION_ES_CL_1_0")
	public static var VERSION_ES_CL_1_0:Int;
	@:native("GL_VERSION_ES_CM_1_1")
	public static var VERSION_ES_CM_1_1:Int;
	@:native("GL_VERSION_ES_CL_1_1")
	public static var VERSION_ES_CL_1_1:Int;
	@:native("GL_CLIP_PLANE0")
	public static var CLIP_PLANE0:Int;
	@:native("GL_CLIP_PLANE1")
	public static var CLIP_PLANE1:Int;
	@:native("GL_CLIP_PLANE2")
	public static var CLIP_PLANE2:Int;
	@:native("GL_CLIP_PLANE3")
	public static var CLIP_PLANE3:Int;
	@:native("GL_CLIP_PLANE4")
	public static var CLIP_PLANE4:Int;
	@:native("GL_CLIP_PLANE5")
	public static var CLIP_PLANE5:Int;
	@:native("GL_FOG")
	public static var FOG:Int;
	@:native("GL_LIGHTING")
	public static var LIGHTING:Int;
	@:native("GL_ALPHA_TEST")
	public static var ALPHA_TEST:Int;
	@:native("GL_POINT_SMOOTH")
	public static var POINT_SMOOTH:Int;
	@:native("GL_COLOR_MATERIAL")
	public static var COLOR_MATERIAL:Int;
	@:native("GL_NORMALIZE")
	public static var NORMALIZE:Int;
	@:native("GL_RESCALE_NORMAL")
	public static var RESCALE_NORMAL:Int;
	@:native("GL_NORMAL_ARRAY")
	public static var NORMAL_ARRAY:Int;
	@:native("GL_COLOR_ARRAY")
	public static var COLOR_ARRAY:Int;
	@:native("GL_TEXTURE_COORD_ARRAY")
	public static var TEXTURE_COORD_ARRAY:Int;
	@:native("GL_EXP")
	public static var EXP:Int;
	@:native("GL_EXP2")
	public static var EXP2:Int;
	@:native("GL_FOG_DENSITY")
	public static var FOG_DENSITY:Int;
	@:native("GL_FOG_START")
	public static var FOG_START:Int;
	@:native("GL_FOG_END")
	public static var FOG_END:Int;
	@:native("GL_FOG_MODE")
	public static var FOG_MODE:Int;
	@:native("GL_FOG_COLOR")
	public static var FOG_COLOR:Int;
	@:native("GL_CURRENT_COLOR")
	public static var CURRENT_COLOR:Int;
	@:native("GL_CURRENT_NORMAL")
	public static var CURRENT_NORMAL:Int;
	@:native("GL_CURRENT_TEXTURE_COORDS")
	public static var CURRENT_TEXTURE_COORDS:Int;
	@:native("GL_POINT_SIZE_MIN")
	public static var POINT_SIZE_MIN:Int;
	@:native("GL_POINT_SIZE_MAX")
	public static var POINT_SIZE_MAX:Int;
	@:native("GL_POINT_DISTANCE_ATTENUATION")
	public static var POINT_DISTANCE_ATTENUATION:Int;
	@:native("GL_ALIASED_POINT_SIZE_RANGE")
	public static var ALIASED_POINT_SIZE_RANGE:Int;
	@:native("GL_SHADE_MODEL")
	public static var SHADE_MODEL:Int;
	@:native("GL_MATRIX_MODE")
	public static var MATRIX_MODE:Int;
	@:native("GL_MODELVIEW_STACK_DEPTH")
	public static var MODELVIEW_STACK_DEPTH:Int;
	@:native("GL_PROJECTION_STACK_DEPTH")
	public static var PROJECTION_STACK_DEPTH:Int;
	@:native("GL_TEXTURE_STACK_DEPTH")
	public static var TEXTURE_STACK_DEPTH:Int;
	@:native("GL_MODELVIEW_MATRIX")
	public static var MODELVIEW_MATRIX:Int;
	@:native("GL_PROJECTION_MATRIX")
	public static var PROJECTION_MATRIX:Int;
	@:native("GL_TEXTURE_MATRIX")
	public static var TEXTURE_MATRIX:Int;
	@:native("GL_ALPHA_TEST_FUNC")
	public static var ALPHA_TEST_FUNC:Int;
	@:native("GL_ALPHA_TEST_REF")
	public static var ALPHA_TEST_REF:Int;
	@:native("GL_MAX_LIGHTS")
	public static var MAX_LIGHTS:Int;
	@:native("GL_MAX_CLIP_PLANES")
	public static var MAX_CLIP_PLANES:Int;
	@:native("GL_MAX_MODELVIEW_STACK_DEPTH")
	public static var MAX_MODELVIEW_STACK_DEPTH:Int;
	@:native("GL_MAX_PROJECTION_STACK_DEPTH")
	public static var MAX_PROJECTION_STACK_DEPTH:Int;
	@:native("GL_MAX_TEXTURE_STACK_DEPTH")
	public static var MAX_TEXTURE_STACK_DEPTH:Int;
	@:native("GL_MAX_TEXTURE_UNITS")
	public static var MAX_TEXTURE_UNITS:Int;
	@:native("GL_RED_BITS")
	public static var RED_BITS:Int;
	@:native("GL_GREEN_BITS")
	public static var GREEN_BITS:Int;
	@:native("GL_BLUE_BITS")
	public static var BLUE_BITS:Int;
	@:native("GL_ALPHA_BITS")
	public static var ALPHA_BITS:Int;
	@:native("GL_DEPTH_BITS")
	public static var DEPTH_BITS:Int;
	@:native("GL_STENCIL_BITS")
	public static var STENCIL_BITS:Int;
	@:native("GL_VERTEX_ARRAY_SIZE")
	public static var VERTEX_ARRAY_SIZE:Int;
	@:native("GL_VERTEX_ARRAY_TYPE")
	public static var VERTEX_ARRAY_TYPE:Int;
	@:native("GL_VERTEX_ARRAY_STRIDE")
	public static var VERTEX_ARRAY_STRIDE:Int;
	@:native("GL_NORMAL_ARRAY_TYPE")
	public static var NORMAL_ARRAY_TYPE:Int;
	@:native("GL_NORMAL_ARRAY_STRIDE")
	public static var NORMAL_ARRAY_STRIDE:Int;
	@:native("GL_COLOR_ARRAY_SIZE")
	public static var COLOR_ARRAY_SIZE:Int;
	@:native("GL_COLOR_ARRAY_TYPE")
	public static var COLOR_ARRAY_TYPE:Int;
	@:native("GL_COLOR_ARRAY_STRIDE")
	public static var COLOR_ARRAY_STRIDE:Int;
	@:native("GL_TEXTURE_COORD_ARRAY_SIZE")
	public static var TEXTURE_COORD_ARRAY_SIZE:Int;
	@:native("GL_TEXTURE_COORD_ARRAY_TYPE")
	public static var TEXTURE_COORD_ARRAY_TYPE:Int;
	@:native("GL_TEXTURE_COORD_ARRAY_STRIDE")
	public static var TEXTURE_COORD_ARRAY_STRIDE:Int;
	@:native("GL_VERTEX_ARRAY_POINTER")
	public static var VERTEX_ARRAY_POINTER:Int;
	@:native("GL_NORMAL_ARRAY_POINTER")
	public static var NORMAL_ARRAY_POINTER:Int;
	@:native("GL_COLOR_ARRAY_POINTER")
	public static var COLOR_ARRAY_POINTER:Int;
	@:native("GL_TEXTURE_COORD_ARRAY_POINTER")
	public static var TEXTURE_COORD_ARRAY_POINTER:Int;
	@:native("GL_PERSPECTIVE_CORRECTION_HINT")
	public static var PERSPECTIVE_CORRECTION_HINT:Int;
	@:native("GL_POINT_SMOOTH_HINT")
	public static var POINT_SMOOTH_HINT:Int;
	@:native("GL_FOG_HINT")
	public static var FOG_HINT:Int;
	@:native("GL_GENERATE_MIPMAP_HINT")
	public static var GENERATE_MIPMAP_HINT:Int;
	@:native("GL_LIGHT_MODEL_AMBIENT")
	public static var LIGHT_MODEL_AMBIENT:Int;
	@:native("GL_LIGHT_MODEL_TWO_SIDE")
	public static var LIGHT_MODEL_TWO_SIDE:Int;
	@:native("GL_AMBIENT")
	public static var AMBIENT:Int;
	@:native("GL_DIFFUSE")
	public static var DIFFUSE:Int;
	@:native("GL_SPECULAR")
	public static var SPECULAR:Int;
	@:native("GL_POSITION")
	public static var POSITION:Int;
	@:native("GL_SPOT_DIRECTION")
	public static var SPOT_DIRECTION:Int;
	@:native("GL_SPOT_EXPONENT")
	public static var SPOT_EXPONENT:Int;
	@:native("GL_SPOT_CUTOFF")
	public static var SPOT_CUTOFF:Int;
	@:native("GL_CONSTANT_ATTENUATION")
	public static var CONSTANT_ATTENUATION:Int;
	@:native("GL_LINEAR_ATTENUATION")
	public static var LINEAR_ATTENUATION:Int;
	@:native("GL_QUADRATIC_ATTENUATION")
	public static var QUADRATIC_ATTENUATION:Int;
	@:native("GL_EMISSION")
	public static var EMISSION:Int;
	@:native("GL_SHININESS")
	public static var SHININESS:Int;
	@:native("GL_AMBIENT_AND_DIFFUSE")
	public static var AMBIENT_AND_DIFFUSE:Int;
	@:native("GL_MODELVIEW")
	public static var MODELVIEW:Int;
	@:native("GL_PROJECTION")
	public static var PROJECTION:Int;
	@:native("GL_LUMINANCE")
	public static var LUMINANCE:Int;
	@:native("GL_LUMINANCE_ALPHA")
	public static var LUMINANCE_ALPHA:Int;
	@:native("GL_FLAT")
	public static var FLAT:Int;
	@:native("GL_SMOOTH")
	public static var SMOOTH:Int;
	@:native("GL_MODULATE")
	public static var MODULATE:Int;
	@:native("GL_DECAL")
	public static var DECAL:Int;
	@:native("GL_ADD")
	public static var ADD:Int;
	@:native("GL_TEXTURE_ENV_MODE")
	public static var TEXTURE_ENV_MODE:Int;
	@:native("GL_TEXTURE_ENV_COLOR")
	public static var TEXTURE_ENV_COLOR:Int;
	@:native("GL_TEXTURE_ENV")
	public static var TEXTURE_ENV:Int;
	@:native("GL_GENERATE_MIPMAP")
	public static var GENERATE_MIPMAP:Int;
	@:native("GL_CLIENT_ACTIVE_TEXTURE")
	public static var CLIENT_ACTIVE_TEXTURE:Int;
	@:native("GL_LIGHT0")
	public static var LIGHT0:Int;
	@:native("GL_LIGHT1")
	public static var LIGHT1:Int;
	@:native("GL_LIGHT2")
	public static var LIGHT2:Int;
	@:native("GL_LIGHT3")
	public static var LIGHT3:Int;
	@:native("GL_LIGHT4")
	public static var LIGHT4:Int;
	@:native("GL_LIGHT5")
	public static var LIGHT5:Int;
	@:native("GL_LIGHT6")
	public static var LIGHT6:Int;
	@:native("GL_LIGHT7")
	public static var LIGHT7:Int;
	@:native("GL_VERTEX_ARRAY_BUFFER_BINDING")
	public static var VERTEX_ARRAY_BUFFER_BINDING:Int;
	@:native("GL_NORMAL_ARRAY_BUFFER_BINDING")
	public static var NORMAL_ARRAY_BUFFER_BINDING:Int;
	@:native("GL_COLOR_ARRAY_BUFFER_BINDING")
	public static var COLOR_ARRAY_BUFFER_BINDING:Int;
	@:native("GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING")
	public static var TEXTURE_COORD_ARRAY_BUFFER_BINDING:Int;
	@:native("GL_SUBTRACT")
	public static var SUBTRACT:Int;
	@:native("GL_COMBINE")
	public static var COMBINE:Int;
	@:native("GL_COMBINE_RGB")
	public static var COMBINE_RGB:Int;
	@:native("GL_COMBINE_ALPHA")
	public static var COMBINE_ALPHA:Int;
	@:native("GL_RGB_SCALE")
	public static var RGB_SCALE:Int;
	@:native("GL_ADD_SIGNED")
	public static var ADD_SIGNED:Int;
	@:native("GL_INTERPOLATE")
	public static var INTERPOLATE:Int;
	@:native("GL_CONSTANT")
	public static var CONSTANT:Int;
	@:native("GL_PRIMARY_COLOR")
	public static var PRIMARY_COLOR:Int;
	@:native("GL_PREVIOUS")
	public static var PREVIOUS:Int;
	@:native("GL_OPERAND0_RGB")
	public static var OPERAND0_RGB:Int;
	@:native("GL_OPERAND1_RGB")
	public static var OPERAND1_RGB:Int;
	@:native("GL_OPERAND2_RGB")
	public static var OPERAND2_RGB:Int;
	@:native("GL_OPERAND0_ALPHA")
	public static var OPERAND0_ALPHA:Int;
	@:native("GL_OPERAND1_ALPHA")
	public static var OPERAND1_ALPHA:Int;
	@:native("GL_OPERAND2_ALPHA")
	public static var OPERAND2_ALPHA:Int;
	@:native("GL_ALPHA_SCALE")
	public static var ALPHA_SCALE:Int;
	@:native("GL_SRC0_RGB")
	public static var SRC0_RGB:Int;
	@:native("GL_SRC1_RGB")
	public static var SRC1_RGB:Int;
	@:native("GL_SRC2_RGB")
	public static var SRC2_RGB:Int;
	@:native("GL_SRC0_ALPHA")
	public static var SRC0_ALPHA:Int;
	@:native("GL_SRC2_ALPHA")
	public static var SRC2_ALPHA:Int;
	@:native("GL_DOT3_RGB")
	public static var DOT3_RGB:Int;
	@:native("GL_DOT3_RGBA")
	public static var DOT3_RGBA:Int;
	@:native("GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS")
	public static var FRAMEBUFFER_INCOMPLETE_DIMENSIONS:Int;
	@:native("GL_MULTISAMPLE_LINE_WIDTH_RANGE")
	public static var MULTISAMPLE_LINE_WIDTH_RANGE:Int;
	@:native("GL_MULTISAMPLE_LINE_WIDTH_GRANULARITY")
	public static var MULTISAMPLE_LINE_WIDTH_GRANULARITY:Int;
	@:native("GL_MULTIPLY")
	public static var MULTIPLY:Int;
	@:native("GL_SCREEN")
	public static var SCREEN:Int;
	@:native("GL_OVERLAY")
	public static var OVERLAY:Int;
	@:native("GL_DARKEN")
	public static var DARKEN:Int;
	@:native("GL_LIGHTEN")
	public static var LIGHTEN:Int;
	@:native("GL_COLORDODGE")
	public static var COLORDODGE:Int;
	@:native("GL_COLORBURN")
	public static var COLORBURN:Int;
	@:native("GL_HARDLIGHT")
	public static var HARDLIGHT:Int;
	@:native("GL_SOFTLIGHT")
	public static var SOFTLIGHT:Int;
	@:native("GL_DIFFERENCE")
	public static var DIFFERENCE:Int;
	@:native("GL_EXCLUSION")
	public static var EXCLUSION:Int;
	@:native("GL_HSL_HUE")
	public static var HSL_HUE:Int;
	@:native("GL_HSL_SATURATION")
	public static var HSL_SATURATION:Int;
	@:native("GL_HSL_COLOR")
	public static var HSL_COLOR:Int;
	@:native("GL_HSL_LUMINOSITY")
	public static var HSL_LUMINOSITY:Int;
	@:native("GL_PRIMITIVE_BOUNDING_BOX")
	public static var PRIMITIVE_BOUNDING_BOX:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_4x4")
	public static var COMPRESSED_RGBA_ASTC_4x4:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_5x4")
	public static var COMPRESSED_RGBA_ASTC_5x4:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_5x5")
	public static var COMPRESSED_RGBA_ASTC_5x5:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_6x5")
	public static var COMPRESSED_RGBA_ASTC_6x5:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_6x6")
	public static var COMPRESSED_RGBA_ASTC_6x6:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_8x5")
	public static var COMPRESSED_RGBA_ASTC_8x5:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_8x6")
	public static var COMPRESSED_RGBA_ASTC_8x6:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_8x8")
	public static var COMPRESSED_RGBA_ASTC_8x8:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_10x5")
	public static var COMPRESSED_RGBA_ASTC_10x5:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_10x6")
	public static var COMPRESSED_RGBA_ASTC_10x6:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_10x8")
	public static var COMPRESSED_RGBA_ASTC_10x8:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_10x10")
	public static var COMPRESSED_RGBA_ASTC_10x10:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_12x10")
	public static var COMPRESSED_RGBA_ASTC_12x10:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_12x12")
	public static var COMPRESSED_RGBA_ASTC_12x12:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x4")
	public static var COMPRESSED_SRGB8_ALPHA8_ASTC_4x4:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x4")
	public static var COMPRESSED_SRGB8_ALPHA8_ASTC_5x4:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x5")
	public static var COMPRESSED_SRGB8_ALPHA8_ASTC_5x5:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x5")
	public static var COMPRESSED_SRGB8_ALPHA8_ASTC_6x5:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x6")
	public static var COMPRESSED_SRGB8_ALPHA8_ASTC_6x6:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x5")
	public static var COMPRESSED_SRGB8_ALPHA8_ASTC_8x5:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x6")
	public static var COMPRESSED_SRGB8_ALPHA8_ASTC_8x6:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x8")
	public static var COMPRESSED_SRGB8_ALPHA8_ASTC_8x8:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x5")
	public static var COMPRESSED_SRGB8_ALPHA8_ASTC_10x5:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x6")
	public static var COMPRESSED_SRGB8_ALPHA8_ASTC_10x6:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x8")
	public static var COMPRESSED_SRGB8_ALPHA8_ASTC_10x8:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x10")
	public static var COMPRESSED_SRGB8_ALPHA8_ASTC_10x10:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x10")
	public static var COMPRESSED_SRGB8_ALPHA8_ASTC_12x10:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x12")
	public static var COMPRESSED_SRGB8_ALPHA8_ASTC_12x12:Int;
	@:native("GL_CONTEXT_ROBUST_ACCESS")
	public static var CONTEXT_ROBUST_ACCESS:Int;
    
    @:native("glCullFace")
	public static function cullFace(mode:GlEnum):Void;

	@:native("glFrontFace")
	public static function frontFace(mode:GlEnum):Void;

	@:native("glHint")
	public static function hint(target:GlEnum, mode:GlEnum):Void;

	@:native("glLineWidth")
	public static function lineWidth(width:GlFloat):Void;

	@:native("glPointSize")
	public static function pointSize(size:GlFloat):Void;

	@:native("glPolygonMode")
	public static function polygonMode(face:GlEnum, mode:GlEnum):Void;

	@:native("glScissor")
	public static function scissor(x:GlInt, y:GlInt, width:GlSizeI, height:GlSizeI):Void;

	@:native("glTexParameterf")
	public static function texParameterf(target:GlEnum, pname:GlEnum, param:GlFloat):Void;

	@:native("glTexParameterfv")
	public static function texParameterfv(target:GlEnum, pname:GlEnum, params:ConstStar<GlFloat>):Void;

	@:native("glTexParameteri")
	public static function texParameteri(target:GlEnum, pname:GlEnum, param:GlInt):Void;

	@:native("glTexParameteriv")
	public static function texParameteriv(target:GlEnum, pname:GlEnum, params:ConstStar<GlInt>):Void;

	@:native("glTexImage1D")
	public static function texImage1D(target:GlEnum, level:GlInt, internalformat:GlInt, width:GlSizeI, border:GlInt, format:GlEnum, type:GlEnum, pixels:ConstStar<cpp.Void>):Void;

	@:native("glTexImage2D")
	public static function texImage2D(target:GlEnum, level:GlInt, internalformat:GlInt, width:GlSizeI, height:GlSizeI, border:GlInt, format:GlEnum, type:GlEnum, pixels:ConstStar<cpp.Void>):Void;

	@:native("glDrawBuffer")
	public static function drawBuffer(buf:GlEnum):Void;

	@:native("glClear")
	public static function clear(mask:GlBitField):Void;

	@:native("glClearColor")
	public static function clearColor(red:GlFloat, green:GlFloat, blue:GlFloat, alpha:GlFloat):Void;

	@:native("glClearStencil")
	public static function clearStencil(s:GlInt):Void;

	@:native("glClearDepth")
	public static function clearDepth(depth:GlDouble):Void;

	@:native("glStencilMask")
	public static function stencilMask(mask:GlUInt):Void;

	@:native("glColorMask")
	public static function colorMask(red:GlBool, green:GlBool, blue:GlBool, alpha:GlBool):Void;

	@:native("glDepthMask")
	public static function depthMask(flag:GlBool):Void;

	@:native("glDisable")
	public static function disable(cap:GlEnum):Void;

	@:native("glEnable")
	public static function enable(cap:GlEnum):Void;

	@:native("glFinish")
	public static function finish():Void;

	@:native("glFlush")
	public static function flush():Void;

	@:native("glBlendFunc")
	public static function blendFunc(sfactor:GlEnum, dfactor:GlEnum):Void;

	@:native("glLogicOp")
	public static function logicOp(opcode:GlEnum):Void;

	@:native("glStencilFunc")
	public static function stencilFunc(func:GlEnum, ref:GlInt, mask:GlUInt):Void;

	@:native("glStencilOp")
	public static function stencilOp(fail:GlEnum, zfail:GlEnum, zpass:GlEnum):Void;

	@:native("glDepthFunc")
	public static function depthFunc(func:GlEnum):Void;

	@:native("glPixelStoref")
	public static function pixelStoref(pname:GlEnum, param:GlFloat):Void;

	@:native("glPixelStorei")
	public static function pixelStorei(pname:GlEnum, param:GlInt):Void;

	@:native("glReadBuffer")
	public static function readBuffer(src:GlEnum):Void;

	@:native("glReadPixels")
	public static function readPixels(x:GlInt, y:GlInt, width:GlSizeI, height:GlSizeI, format:GlEnum, type:GlEnum, pixels:Pointer<cpp.Void>):Void;

	@:native("glGetBooleanv")
	public static function getBooleanv(pname:GlEnum, data:Pointer<GlBool>):Void;

	@:native("glGetDoublev")
	public static function getDoublev(pname:GlEnum, data:Pointer<GlDouble>):Void;

	@:native("glGetError")
	public static function getError():GlEnum;

	@:native("glGetFloatv")
	public static function getFloatv(pname:GlEnum, data:Pointer<GlFloat>):Void;

	@:native("glGetIntegerv")
	public static function getIntegerv(pname:GlEnum, data:Pointer<GlInt>):Void;

	@:native("glGetString")
	public static function getString(name:GlEnum):ConstStar<GlUByte>;

	@:native("glGetTexImage")
	public static function getTexImage(target:GlEnum, level:GlInt, format:GlEnum, type:GlEnum, pixels:Pointer<cpp.Void>):Void;

	@:native("glGetTexParameterfv")
	public static function getTexParameterfv(target:GlEnum, pname:GlEnum, params:Pointer<GlFloat>):Void;

	@:native("glGetTexParameteriv")
	public static function getTexParameteriv(target:GlEnum, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glGetTexLevelParameterfv")
	public static function getTexLevelParameterfv(target:GlEnum, level:GlInt, pname:GlEnum, params:Pointer<GlFloat>):Void;

	@:native("glGetTexLevelParameteriv")
	public static function getTexLevelParameteriv(target:GlEnum, level:GlInt, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glIsEnabled")
	public static function isEnabled(cap:GlEnum):GlBool;

	@:native("glDepthRange")
	public static function depthRange(n:GlDouble, f:GlDouble):Void;

	@:native("glViewport")
	public static function viewport(x:GlInt, y:GlInt, width:GlSizeI, height:GlSizeI):Void;

	@:native("glDrawArrays")
	public static function drawArrays(mode:GlEnum, first:GlInt, count:GlSizeI):Void;

	@:native("glDrawElements")
	public static function drawElements(mode:GlEnum, count:GlSizeI, type:GlEnum, indices:ConstStar<cpp.Void>):Void;

	@:native("glPolygonOffset")
	public static function polygonOffset(factor:GlFloat, units:GlFloat):Void;

	@:native("glCopyTexImage1D")
	public static function copyTexImage1D(target:GlEnum, level:GlInt, internalformat:GlEnum, x:GlInt, y:GlInt, width:GlSizeI, border:GlInt):Void;

	@:native("glCopyTexImage2D")
	public static function copyTexImage2D(target:GlEnum, level:GlInt, internalformat:GlEnum, x:GlInt, y:GlInt, width:GlSizeI, height:GlSizeI, border:GlInt):Void;

	@:native("glCopyTexSubImage1D")
	public static function copyTexSubImage1D(target:GlEnum, level:GlInt, xoffset:GlInt, x:GlInt, y:GlInt, width:GlSizeI):Void;

	@:native("glCopyTexSubImage2D")
	public static function copyTexSubImage2D(target:GlEnum, level:GlInt, xoffset:GlInt, yoffset:GlInt, x:GlInt, y:GlInt, width:GlSizeI, height:GlSizeI):Void;

	@:native("glTexSubImage1D")
	public static function texSubImage1D(target:GlEnum, level:GlInt, xoffset:GlInt, width:GlSizeI, format:GlEnum, type:GlEnum, pixels:ConstStar<cpp.Void>):Void;

	@:native("glTexSubImage2D")
	public static function texSubImage2D(target:GlEnum, level:GlInt, xoffset:GlInt, yoffset:GlInt, width:GlSizeI, height:GlSizeI, format:GlEnum, type:GlEnum, pixels:ConstStar<cpp.Void>):Void;

	@:native("glBindTexture")
	public static function bindTexture(target:GlEnum, texture:GlUInt):Void;

	@:native("glDeleteTextures")
	public static function deleteTextures(n:GlSizeI, textures:ConstPointer<GlUInt>):Void;

	@:native("glGenTextures")
	public static function genTextures(n:GlSizeI, textures:Pointer<GlUInt>):Void;

	@:native("glIsTexture")
	public static function isTexture(texture:GlUInt):GlBool;

	@:native("glDrawRangeElements")
	public static function drawRangeElements(mode:GlEnum, start:GlUInt, end:GlUInt, count:GlSizeI, type:GlEnum, indices:ConstStar<cpp.Void>):Void;

	@:native("glTexImage3D")
	public static function texImage3D(target:GlEnum, level:GlInt, internalformat:GlInt, width:GlSizeI, height:GlSizeI, depth:GlSizeI, border:GlInt, format:GlEnum, type:GlEnum, pixels:ConstStar<cpp.Void>):Void;

	@:native("glTexSubImage3D")
	public static function texSubImage3D(target:GlEnum, level:GlInt, xoffset:GlInt, yoffset:GlInt, zoffset:GlInt, width:GlSizeI, height:GlSizeI, depth:GlSizeI, format:GlEnum, type:GlEnum, pixels:ConstStar<cpp.Void>):Void;

	@:native("glCopyTexSubImage3D")
	public static function copyTexSubImage3D(target:GlEnum, level:GlInt, xoffset:GlInt, yoffset:GlInt, zoffset:GlInt, x:GlInt, y:GlInt, width:GlSizeI, height:GlSizeI):Void;

	@:native("glActiveTexture")
	public static function activeTexture(texture:GlEnum):Void;

	@:native("glSampleCoverage")
	public static function sampleCoverage(value:GlFloat, invert:GlBool):Void;

	@:native("glCompressedTexImage3D")
	public static function compressedTexImage3D(target:GlEnum, level:GlInt, internalformat:GlEnum, width:GlSizeI, height:GlSizeI, depth:GlSizeI, border:GlInt, imageSize:GlSizeI, data:ConstStar<cpp.Void>):Void;

	@:native("glCompressedTexImage2D")
	public static function compressedTexImage2D(target:GlEnum, level:GlInt, internalformat:GlEnum, width:GlSizeI, height:GlSizeI, border:GlInt, imageSize:GlSizeI, data:ConstStar<cpp.Void>):Void;

	@:native("glCompressedTexImage1D")
	public static function compressedTexImage1D(target:GlEnum, level:GlInt, internalformat:GlEnum, width:GlSizeI, border:GlInt, imageSize:GlSizeI, data:ConstStar<cpp.Void>):Void;

	@:native("glCompressedTexSubImage3D")
	public static function compressedTexSubImage3D(target:GlEnum, level:GlInt, xoffset:GlInt, yoffset:GlInt, zoffset:GlInt, width:GlSizeI, height:GlSizeI, depth:GlSizeI, format:GlEnum, imageSize:GlSizeI, data:ConstStar<cpp.Void>):Void;

	@:native("glCompressedTexSubImage2D")
	public static function compressedTexSubImage2D(target:GlEnum, level:GlInt, xoffset:GlInt, yoffset:GlInt, width:GlSizeI, height:GlSizeI, format:GlEnum, imageSize:GlSizeI, data:ConstStar<cpp.Void>):Void;

	@:native("glCompressedTexSubImage1D")
	public static function compressedTexSubImage1D(target:GlEnum, level:GlInt, xoffset:GlInt, width:GlSizeI, format:GlEnum, imageSize:GlSizeI, data:ConstStar<cpp.Void>):Void;

	@:native("glGetCompressedTexImage")
	public static function getCompressedTexImage(target:GlEnum, level:GlInt, img:Pointer<cpp.Void>):Void;

	@:native("glBlendFuncSeparate")
	public static function blendFuncSeparate(sfactorRGB:GlEnum, dfactorRGB:GlEnum, sfactorAlpha:GlEnum, dfactorAlpha:GlEnum):Void;

	@:native("glMultiDrawArrays")
	public static function multiDrawArrays(mode:GlEnum, first:ConstStar<GlInt>, count:ConstStar<GlSizeI>, drawcount:GlSizeI):Void;

	// @:native("glMultiDrawElements") TODO: kill whoever the fuck decided to make a "const void* const*" as a var type.
	// public static function multiDrawElements(mode:GlEnum, count:ConstStar<GlSizeI>, type:GlEnum, const*indices:ConstStar<cpp.Void>, drawcount:GlSizeI):Void;

	@:native("glPointParameterf")
	public static function pointParameterf(pname:GlEnum, param:GlFloat):Void;

	@:native("glPointParameterfv")
	public static function pointParameterfv(pname:GlEnum, params:ConstStar<GlFloat>):Void;

	@:native("glPointParameteri")
	public static function pointParameteri(pname:GlEnum, param:GlInt):Void;

	@:native("glPointParameteriv")
	public static function pointParameteriv(pname:GlEnum, params:ConstStar<GlInt>):Void;

	@:native("glBlendColor")
	public static function blendColor(red:GlFloat, green:GlFloat, blue:GlFloat, alpha:GlFloat):Void;

	@:native("glBlendEquation")
	public static function blendEquation(mode:GlEnum):Void;

	@:native("glGenQueries")
	public static function genQueries(n:GlSizeI, ids:Pointer<GlUInt>):Void;

	@:native("glDeleteQueries")
	public static function deleteQueries(n:GlSizeI, ids:ConstPointer<GlUInt>):Void;

	@:native("glIsQuery")
	public static function isQuery(id:GlUInt):GlBool;

	@:native("glBeginQuery")
	public static function beginQuery(target:GlEnum, id:GlUInt):Void;

	@:native("glEndQuery")
	public static function endQuery(target:GlEnum):Void;

	@:native("glGetQueryiv")
	public static function getQueryiv(target:GlEnum, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glGetQueryObjectiv")
	public static function getQueryObjectiv(id:GlUInt, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glGetQueryObjectuiv")
	public static function getQueryObjectuiv(id:GlUInt, pname:GlEnum, params:Pointer<GlUInt>):Void;

	@:native("glBindBuffer")
	public static function bindBuffer(target:GlEnum, buffer:GlUInt):Void;

	@:native("glDeleteBuffers")
	public static function deleteBuffers(n:GlSizeI, buffers:ConstPointer<GlUInt>):Void;

	@:native("glGenBuffers")
	public static function genBuffers(n:GlSizeI, buffers:Pointer<GlUInt>):Void;

	@:native("glIsBuffer")
	public static function isBuffer(buffer:GlUInt):GlBool;

	@:native("glBufferData")
	public static function bufferData(target:GlEnum, size:GlSizeIPointer, data:ConstStar<cpp.Void>, usage:GlEnum):Void;

	@:native("glBufferSubData")
	public static function bufferSubData(target:GlEnum, offset:GlIntPointer, size:GlSizeIPointer, data:ConstStar<cpp.Void>):Void;

	@:native("glGetBufferSubData")
	public static function getBufferSubData(target:GlEnum, offset:GlIntPointer, size:GlSizeIPointer, data:Pointer<cpp.Void>):Void;

	@:native("glMapBuffer")
	public static function mapBuffer(target:GlEnum, access:GlEnum):Star<cpp.Void>;

	@:native("glUnmapBuffer")
	public static function unmapBuffer(target:GlEnum):GlBool;

	@:native("glGetBufferParameteriv")
	public static function getBufferParameteriv(target:GlEnum, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glGetBufferPointerv")
	public static function getBufferPointerv(target:GlEnum, pname:GlEnum, params:Pointer<Star<cpp.Void>>):Void;

	@:native("glBlendEquationSeparate")
	public static function blendEquationSeparate(modeRGB:GlEnum, modeAlpha:GlEnum):Void;

	@:native("glDrawBuffers")
	public static function drawBuffers(n:GlSizeI, bufs:ConstStar<GlEnum>):Void;

	@:native("glStencilOpSeparate")
	public static function stencilOpSeparate(face:GlEnum, sfail:GlEnum, dpfail:GlEnum, dppass:GlEnum):Void;

	@:native("glStencilFuncSeparate")
	public static function stencilFuncSeparate(face:GlEnum, func:GlEnum, ref:GlInt, mask:GlUInt):Void;

	@:native("glStencilMaskSeparate")
	public static function stencilMaskSeparate(face:GlEnum, mask:GlUInt):Void;

	@:native("glAttachShader")
	public static function attachShader(program:GlUInt, shader:GlUInt):Void;

	@:native("glBindAttribLocation")
	public static function bindAttribLocation(program:GlUInt, index:GlUInt, name:ConstCharStar):Void;

	@:native("glCompileShader")
	public static function compileShader(shader:GlUInt):Void;

	@:native("glCreateProgram")
	public static function createProgram():GlUInt;

	@:native("glCreateShader")
	public static function createShader(type:GlEnum):GlUInt;

	@:native("glDeleteProgram")
	public static function deleteProgram(program:GlUInt):Void;

	@:native("glDeleteShader")
	public static function deleteShader(shader:GlUInt):Void;

	@:native("glDetachShader")
	public static function detachShader(program:GlUInt, shader:GlUInt):Void;

	@:native("glDisableVertexAttribArray")
	public static function disableVertexAttribArray(index:GlUInt):Void;

	@:native("glEnableVertexAttribArray")
	public static function enableVertexAttribArray(index:GlUInt):Void;

	@:native("glGetActiveAttrib")
	public static function getActiveAttrib(program:GlUInt, index:GlUInt, bufSize:GlSizeI, length:Pointer<GlSizeI>, size:Pointer<GlInt>, type:Pointer<GlEnum>, name:Pointer<GlChar>):Void;

	@:native("glGetActiveUniform")
	public static function getActiveUniform(program:GlUInt, index:GlUInt, bufSize:GlSizeI, length:Pointer<GlSizeI>, size:Pointer<GlInt>, type:Pointer<GlEnum>, name:Pointer<GlChar>):Void;

	@:native("glGetAttachedShaders")
	public static function getAttachedShaders(program:GlUInt, maxCount:GlSizeI, count:Pointer<GlSizeI>, shaders:Pointer<GlUInt>):Void;

	@:native("glGetAttribLocation")
	public static function getAttribLocation(program:GlUInt, name:ConstCharStar):GlInt;

	@:native("glGetProgramiv")
	public static function getProgramiv(program:GlUInt, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glGetProgramInfoLog")
	public static function getProgramInfoLog(program:GlUInt, bufSize:GlSizeI, length:Star<GlSizeI>, infoLog:Pointer<GlChar>):Void;

	@:native("glGetShaderiv")
	public static function getShaderiv(shader:GlUInt, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glGetShaderInfoLog")
	public static function getShaderInfoLog(shader:GlUInt, bufSize:GlSizeI, length:Star<GlSizeI>, infoLog:Pointer<GlChar>):Void;

	@:native("glGetShaderSource")
	public static function getShaderSource(shader:GlUInt, bufSize:GlSizeI, length:Star<GlSizeI>, source:Star<GlChar>):Void;

	@:native("glGetUniformLocation")
	public static function getUniformLocation(program:GlUInt, name:ConstCharStar):GlInt;

	@:native("glGetUniformfv")
	public static function getUniformfv(program:GlUInt, location:GlInt, params:Pointer<GlFloat>):Void;

	@:native("glGetUniformiv")
	public static function getUniformiv(program:GlUInt, location:GlInt, params:Pointer<GlInt>):Void;

	@:native("glGetVertexAttribdv")
	public static function getVertexAttribdv(index:GlUInt, pname:GlEnum, params:Pointer<GlDouble>):Void;

	@:native("glGetVertexAttribfv")
	public static function getVertexAttribfv(index:GlUInt, pname:GlEnum, params:Pointer<GlFloat>):Void;

	@:native("glGetVertexAttribiv")
	public static function getVertexAttribiv(index:GlUInt, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glGetVertexAttribPointerv")
	public static function getVertexAttribPointerv(index:GlUInt, pname:GlEnum, pointer:Pointer<Star<cpp.Void>>):Void;

	@:native("glIsProgram")
	public static function isProgram(program:GlUInt):GlBool;

	@:native("glIsShader")
	public static function isShader(shader:GlUInt):GlBool;

	@:native("glLinkProgram")
	public static function linkProgram(program:GlUInt):Void;

	@:native("glShaderSource")
	public static function shaderSource(shader:GlUInt, count:GlSizeI, string:Star<ConstCharStar>, length:ConstPointer<GlInt>):Void;

	@:native("glUseProgram")
	public static function useProgram(program:GlUInt):Void;

	@:native("glUniform1f")
	public static function uniform1f(location:GlInt, v0:GlFloat):Void;

	@:native("glUniform2f")
	public static function uniform2f(location:GlInt, v0:GlFloat, v1:GlFloat):Void;

	@:native("glUniform3f")
	public static function uniform3f(location:GlInt, v0:GlFloat, v1:GlFloat, v2:GlFloat):Void;

	@:native("glUniform4f")
	public static function uniform4f(location:GlInt, v0:GlFloat, v1:GlFloat, v2:GlFloat, v3:GlFloat):Void;

	@:native("glUniform1i")
	public static function uniform1i(location:GlInt, v0:GlInt):Void;

	@:native("glUniform2i")
	public static function uniform2i(location:GlInt, v0:GlInt, v1:GlInt):Void;

	@:native("glUniform3i")
	public static function uniform3i(location:GlInt, v0:GlInt, v1:GlInt, v2:GlInt):Void;

	@:native("glUniform4i")
	public static function uniform4i(location:GlInt, v0:GlInt, v1:GlInt, v2:GlInt, v3:GlInt):Void;

	@:native("glUniform1fv")
	public static function uniform1fv(location:GlInt, count:GlSizeI, value:ConstStar<GlFloat>):Void;

	@:native("glUniform2fv")
	public static function uniform2fv(location:GlInt, count:GlSizeI, value:ConstStar<GlFloat>):Void;

	@:native("glUniform3fv")
	public static function uniform3fv(location:GlInt, count:GlSizeI, value:ConstStar<GlFloat>):Void;

	@:native("glUniform4fv")
	public static function uniform4fv(location:GlInt, count:GlSizeI, value:ConstStar<GlFloat>):Void;

	@:native("glUniform1iv")
	public static function uniform1iv(location:GlInt, count:GlSizeI, value:ConstStar<GlInt>):Void;

	@:native("glUniform2iv")
	public static function uniform2iv(location:GlInt, count:GlSizeI, value:ConstStar<GlInt>):Void;

	@:native("glUniform3iv")
	public static function uniform3iv(location:GlInt, count:GlSizeI, value:ConstStar<GlInt>):Void;

	@:native("glUniform4iv")
	public static function uniform4iv(location:GlInt, count:GlSizeI, value:ConstStar<GlInt>):Void;

	@:native("glUniformMatrix2fv")
	public static function uniformMatrix2fv(location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlFloat>):Void;

	@:native("glUniformMatrix3fv")
	public static function uniformMatrix3fv(location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlFloat>):Void;

	@:native("glUniformMatrix4fv")
	public static function uniformMatrix4fv(location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlFloat>):Void;

	@:native("glValidateProgram")
	public static function validateProgram(program:GlUInt):Void;

	@:native("glVertexAttrib1d")
	public static function vertexAttrib1d(index:GlUInt, x:GlDouble):Void;

	@:native("glVertexAttrib1dv")
	public static function vertexAttrib1dv(index:GlUInt, v:ConstStar<GlDouble>):Void;

	@:native("glVertexAttrib1f")
	public static function vertexAttrib1f(index:GlUInt, x:GlFloat):Void;

	@:native("glVertexAttrib1fv")
	public static function vertexAttrib1fv(index:GlUInt, v:ConstStar<GlFloat>):Void;

	@:native("glVertexAttrib1s")
	public static function vertexAttrib1s(index:GlUInt, x:GlShort):Void;

	@:native("glVertexAttrib1sv")
	public static function vertexAttrib1sv(index:GlUInt, v:ConstStar<GlShort>):Void;

	@:native("glVertexAttrib2d")
	public static function vertexAttrib2d(index:GlUInt, x:GlDouble, y:GlDouble):Void;

	@:native("glVertexAttrib2dv")
	public static function vertexAttrib2dv(index:GlUInt, v:ConstStar<GlDouble>):Void;

	@:native("glVertexAttrib2f")
	public static function vertexAttrib2f(index:GlUInt, x:GlFloat, y:GlFloat):Void;

	@:native("glVertexAttrib2fv")
	public static function vertexAttrib2fv(index:GlUInt, v:ConstStar<GlFloat>):Void;

	@:native("glVertexAttrib2s")
	public static function vertexAttrib2s(index:GlUInt, x:GlShort, y:GlShort):Void;

	@:native("glVertexAttrib2sv")
	public static function vertexAttrib2sv(index:GlUInt, v:ConstStar<GlShort>):Void;

	@:native("glVertexAttrib3d")
	public static function vertexAttrib3d(index:GlUInt, x:GlDouble, y:GlDouble, z:GlDouble):Void;

	@:native("glVertexAttrib3dv")
	public static function vertexAttrib3dv(index:GlUInt, v:ConstStar<GlDouble>):Void;

	@:native("glVertexAttrib3f")
	public static function vertexAttrib3f(index:GlUInt, x:GlFloat, y:GlFloat, z:GlFloat):Void;

	@:native("glVertexAttrib3fv")
	public static function vertexAttrib3fv(index:GlUInt, v:ConstStar<GlFloat>):Void;

	@:native("glVertexAttrib3s")
	public static function vertexAttrib3s(index:GlUInt, x:GlShort, y:GlShort, z:GlShort):Void;

	@:native("glVertexAttrib3sv")
	public static function vertexAttrib3sv(index:GlUInt, v:ConstStar<GlShort>):Void;

	@:native("glVertexAttrib4Nbv")
	public static function vertexAttrib4Nbv(index:GlUInt, v:ConstStar<GlByte>):Void;

	@:native("glVertexAttrib4Niv")
	public static function vertexAttrib4Niv(index:GlUInt, v:ConstStar<GlInt>):Void;

	@:native("glVertexAttrib4Nsv")
	public static function vertexAttrib4Nsv(index:GlUInt, v:ConstStar<GlShort>):Void;

	@:native("glVertexAttrib4Nub")
	public static function vertexAttrib4Nub(index:GlUInt, x:GlUByte, y:GlUByte, z:GlUByte, w:GlUByte):Void;

	@:native("glVertexAttrib4Nubv")
	public static function vertexAttrib4Nubv(index:GlUInt, v:ConstStar<GlUByte>):Void;

	@:native("glVertexAttrib4Nuiv")
	public static function vertexAttrib4Nuiv(index:GlUInt, v:ConstStar<GlUInt>):Void;

	@:native("glVertexAttrib4Nusv")
	public static function vertexAttrib4Nusv(index:GlUInt, v:ConstStar<GlUShort>):Void;

	@:native("glVertexAttrib4bv")
	public static function vertexAttrib4bv(index:GlUInt, v:ConstStar<GlByte>):Void;

	@:native("glVertexAttrib4d")
	public static function vertexAttrib4d(index:GlUInt, x:GlDouble, y:GlDouble, z:GlDouble, w:GlDouble):Void;

	@:native("glVertexAttrib4dv")
	public static function vertexAttrib4dv(index:GlUInt, v:ConstStar<GlDouble>):Void;

	@:native("glVertexAttrib4f")
	public static function vertexAttrib4f(index:GlUInt, x:GlFloat, y:GlFloat, z:GlFloat, w:GlFloat):Void;

	@:native("glVertexAttrib4fv")
	public static function vertexAttrib4fv(index:GlUInt, v:ConstStar<GlFloat>):Void;

	@:native("glVertexAttrib4iv")
	public static function vertexAttrib4iv(index:GlUInt, v:ConstStar<GlInt>):Void;

	@:native("glVertexAttrib4s")
	public static function vertexAttrib4s(index:GlUInt, x:GlShort, y:GlShort, z:GlShort, w:GlShort):Void;

	@:native("glVertexAttrib4sv")
	public static function vertexAttrib4sv(index:GlUInt, v:ConstStar<GlShort>):Void;

	@:native("glVertexAttrib4ubv")
	public static function vertexAttrib4ubv(index:GlUInt, v:ConstStar<GlUByte>):Void;

	@:native("glVertexAttrib4uiv")
	public static function vertexAttrib4uiv(index:GlUInt, v:ConstStar<GlUInt>):Void;

	@:native("glVertexAttrib4usv")
	public static function vertexAttrib4usv(index:GlUInt, v:ConstStar<GlUShort>):Void;

	@:native("glVertexAttribPointer")
	public static function vertexAttribPointer(index:GlUInt, size:GlInt, type:GlEnum, normalized:GlBool, stride:GlSizeI, pointer:ConstStar<cpp.Void>):Void;

	@:native("glUniformMatrix2x3fv")
	public static function uniformMatrix2x3fv(location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlFloat>):Void;

	@:native("glUniformMatrix3x2fv")
	public static function uniformMatrix3x2fv(location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlFloat>):Void;

	@:native("glUniformMatrix2x4fv")
	public static function uniformMatrix2x4fv(location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlFloat>):Void;

	@:native("glUniformMatrix4x2fv")
	public static function uniformMatrix4x2fv(location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlFloat>):Void;

	@:native("glUniformMatrix3x4fv")
	public static function uniformMatrix3x4fv(location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlFloat>):Void;

	@:native("glUniformMatrix4x3fv")
	public static function uniformMatrix4x3fv(location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlFloat>):Void;

	@:native("glColorMaski")
	public static function colorMaski(index:GlUInt, r:GlBool, g:GlBool, b:GlBool, a:GlBool):Void;

	@:native("glGetBooleani_v")
	public static function getBooleani_v(target:GlEnum, index:GlUInt, data:Pointer<GlBool>):Void;

	@:native("glGetIntegeri_v")
	public static function getIntegeri_v(target:GlEnum, index:GlUInt, data:Pointer<GlInt>):Void;

	@:native("glEnablei")
	public static function enablei(target:GlEnum, index:GlUInt):Void;

	@:native("glDisablei")
	public static function disablei(target:GlEnum, index:GlUInt):Void;

	@:native("glIsEnabledi")
	public static function isEnabledi(target:GlEnum, index:GlUInt):GlBool;

	@:native("glBeginTransformFeedback")
	public static function beginTransformFeedback(primitiveMode:GlEnum):Void;

	@:native("glEndTransformFeedback")
	public static function endTransformFeedback():Void;

	@:native("glBindBufferRange")
	public static function bindBufferRange(target:GlEnum, index:GlUInt, buffer:GlUInt, offset:GlIntPointer, size:GlSizeIPointer):Void;

	@:native("glBindBufferBase")
	public static function bindBufferBase(target:GlEnum, index:GlUInt, buffer:GlUInt):Void;

	@:native("glTransformFeedbackVaryings")
	public static function transformFeedbackVaryings(program:GlUInt, count:GlSizeI, varyings:Star<ConstCharStar>, bufferMode:GlEnum):Void;

	@:native("glGetTransformFeedbackVarying")
	public static function getTransformFeedbackVarying(program:GlUInt, index:GlUInt, bufSize:GlSizeI, length:Pointer<GlSizeI>, size:Pointer<GlSizeI>, type:Pointer<GlEnum>, name:Pointer<GlChar>):Void;

	@:native("glClampColor")
	public static function clampColor(target:GlEnum, clamp:GlEnum):Void;

	@:native("glBeginConditionalRender")
	public static function beginConditionalRender(id:GlUInt, mode:GlEnum):Void;

	@:native("glEndConditionalRender")
	public static function endConditionalRender():Void;

	@:native("glVertexAttribIPointer")
	public static function vertexAttribIPointer(index:GlUInt, size:GlInt, type:GlEnum, stride:GlSizeI, pointer:ConstStar<cpp.Void>):Void;

	@:native("glGetVertexAttribIiv")
	public static function getVertexAttribIiv(index:GlUInt, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glGetVertexAttribIuiv")
	public static function getVertexAttribIuiv(index:GlUInt, pname:GlEnum, params:Pointer<GlUInt>):Void;

	@:native("glVertexAttribI1i")
	public static function vertexAttribI1i(index:GlUInt, x:GlInt):Void;

	@:native("glVertexAttribI2i")
	public static function vertexAttribI2i(index:GlUInt, x:GlInt, y:GlInt):Void;

	@:native("glVertexAttribI3i")
	public static function vertexAttribI3i(index:GlUInt, x:GlInt, y:GlInt, z:GlInt):Void;

	@:native("glVertexAttribI4i")
	public static function vertexAttribI4i(index:GlUInt, x:GlInt, y:GlInt, z:GlInt, w:GlInt):Void;

	@:native("glVertexAttribI1ui")
	public static function vertexAttribI1ui(index:GlUInt, x:GlUInt):Void;

	@:native("glVertexAttribI2ui")
	public static function vertexAttribI2ui(index:GlUInt, x:GlUInt, y:GlUInt):Void;

	@:native("glVertexAttribI3ui")
	public static function vertexAttribI3ui(index:GlUInt, x:GlUInt, y:GlUInt, z:GlUInt):Void;

	@:native("glVertexAttribI4ui")
	public static function vertexAttribI4ui(index:GlUInt, x:GlUInt, y:GlUInt, z:GlUInt, w:GlUInt):Void;

	@:native("glVertexAttribI1iv")
	public static function vertexAttribI1iv(index:GlUInt, v:ConstStar<GlInt>):Void;

	@:native("glVertexAttribI2iv")
	public static function vertexAttribI2iv(index:GlUInt, v:ConstStar<GlInt>):Void;

	@:native("glVertexAttribI3iv")
	public static function vertexAttribI3iv(index:GlUInt, v:ConstStar<GlInt>):Void;

	@:native("glVertexAttribI4iv")
	public static function vertexAttribI4iv(index:GlUInt, v:ConstStar<GlInt>):Void;

	@:native("glVertexAttribI1uiv")
	public static function vertexAttribI1uiv(index:GlUInt, v:ConstStar<GlUInt>):Void;

	@:native("glVertexAttribI2uiv")
	public static function vertexAttribI2uiv(index:GlUInt, v:ConstStar<GlUInt>):Void;

	@:native("glVertexAttribI3uiv")
	public static function vertexAttribI3uiv(index:GlUInt, v:ConstStar<GlUInt>):Void;

	@:native("glVertexAttribI4uiv")
	public static function vertexAttribI4uiv(index:GlUInt, v:ConstStar<GlUInt>):Void;

	@:native("glVertexAttribI4bv")
	public static function vertexAttribI4bv(index:GlUInt, v:ConstStar<GlByte>):Void;

	@:native("glVertexAttribI4sv")
	public static function vertexAttribI4sv(index:GlUInt, v:ConstStar<GlShort>):Void;

	@:native("glVertexAttribI4ubv")
	public static function vertexAttribI4ubv(index:GlUInt, v:ConstStar<GlUByte>):Void;

	@:native("glVertexAttribI4usv")
	public static function vertexAttribI4usv(index:GlUInt, v:ConstStar<GlUShort>):Void;

	@:native("glGetUniformuiv")
	public static function getUniformuiv(program:GlUInt, location:GlInt, params:Pointer<GlUInt>):Void;

	@:native("glBindFragDataLocation")
	public static function bindFragDataLocation(program:GlUInt, color:GlUInt, name:ConstCharStar):Void;

	@:native("glGetFragDataLocation")
	public static function getFragDataLocation(program:GlUInt, name:ConstCharStar):GlInt;

	@:native("glUniform1ui")
	public static function uniform1ui(location:GlInt, v0:GlUInt):Void;

	@:native("glUniform2ui")
	public static function uniform2ui(location:GlInt, v0:GlUInt, v1:GlUInt):Void;

	@:native("glUniform3ui")
	public static function uniform3ui(location:GlInt, v0:GlUInt, v1:GlUInt, v2:GlUInt):Void;

	@:native("glUniform4ui")
	public static function uniform4ui(location:GlInt, v0:GlUInt, v1:GlUInt, v2:GlUInt, v3:GlUInt):Void;

	@:native("glUniform1uiv")
	public static function uniform1uiv(location:GlInt, count:GlSizeI, value:ConstStar<GlUInt>):Void;

	@:native("glUniform2uiv")
	public static function uniform2uiv(location:GlInt, count:GlSizeI, value:ConstStar<GlUInt>):Void;

	@:native("glUniform3uiv")
	public static function uniform3uiv(location:GlInt, count:GlSizeI, value:ConstStar<GlUInt>):Void;

	@:native("glUniform4uiv")
	public static function uniform4uiv(location:GlInt, count:GlSizeI, value:ConstStar<GlUInt>):Void;

	@:native("glTexParameterIiv")
	public static function texParameterIiv(target:GlEnum, pname:GlEnum, params:ConstStar<GlInt>):Void;

	@:native("glTexParameterIuiv")
	public static function texParameterIuiv(target:GlEnum, pname:GlEnum, params:ConstStar<GlUInt>):Void;

	@:native("glGetTexParameterIiv")
	public static function getTexParameterIiv(target:GlEnum, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glGetTexParameterIuiv")
	public static function getTexParameterIuiv(target:GlEnum, pname:GlEnum, params:Pointer<GlUInt>):Void;

	@:native("glClearBufferiv")
	public static function clearBufferiv(buffer:GlEnum, drawbuffer:GlInt, value:ConstStar<GlInt>):Void;

	@:native("glClearBufferuiv")
	public static function clearBufferuiv(buffer:GlEnum, drawbuffer:GlInt, value:ConstStar<GlUInt>):Void;

	@:native("glClearBufferfv")
	public static function clearBufferfv(buffer:GlEnum, drawbuffer:GlInt, value:ConstStar<GlFloat>):Void;

	@:native("glClearBufferfi")
	public static function clearBufferfi(buffer:GlEnum, drawbuffer:GlInt, depth:GlFloat, stencil:GlInt):Void;

	@:native("glGetStringi")
	public static function getStringi(name:GlEnum, index:GlUInt):ConstStar<GlUByte>;

	@:native("glIsRenderbuffer")
	public static function isRenderbuffer(renderbuffer:GlUInt):GlBool;

	@:native("glBindRenderbuffer")
	public static function bindRenderbuffer(target:GlEnum, renderbuffer:GlUInt):Void;

	@:native("glDeleteRenderbuffers")
	public static function deleteRenderbuffers(n:GlSizeI, renderbuffers:ConstPointer<GlUInt>):Void;

	@:native("glGenRenderbuffers")
	public static function genRenderbuffers(n:GlSizeI, renderbuffers:Pointer<GlUInt>):Void;

	@:native("glRenderbufferStorage")
	public static function renderbufferStorage(target:GlEnum, internalformat:GlEnum, width:GlSizeI, height:GlSizeI):Void;

	@:native("glGetRenderbufferParameteriv")
	public static function getRenderbufferParameteriv(target:GlEnum, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glIsFramebuffer")
	public static function isFramebuffer(framebuffer:GlUInt):GlBool;

	@:native("glBindFramebuffer")
	public static function bindFramebuffer(target:GlEnum, framebuffer:GlUInt):Void;

	@:native("glDeleteFramebuffers")
	public static function deleteFramebuffers(n:GlSizeI, framebuffers:ConstPointer<GlUInt>):Void;

	@:native("glGenFramebuffers")
	public static function genFramebuffers(n:GlSizeI, framebuffers:Pointer<GlUInt>):Void;

	@:native("glCheckFramebufferStatus")
	public static function checkFramebufferStatus(target:GlEnum):GlEnum;

	@:native("glFramebufferTexture1D")
	public static function framebufferTexture1D(target:GlEnum, attachment:GlEnum, textarget:GlEnum, texture:GlUInt, level:GlInt):Void;

	@:native("glFramebufferTexture2D")
	public static function framebufferTexture2D(target:GlEnum, attachment:GlEnum, textarget:GlEnum, texture:GlUInt, level:GlInt):Void;

	@:native("glFramebufferTexture3D")
	public static function framebufferTexture3D(target:GlEnum, attachment:GlEnum, textarget:GlEnum, texture:GlUInt, level:GlInt, zoffset:GlInt):Void;

	@:native("glFramebufferRenderbuffer")
	public static function framebufferRenderbuffer(target:GlEnum, attachment:GlEnum, renderbuffertarget:GlEnum, renderbuffer:GlUInt):Void;

	@:native("glGetFramebufferAttachmentParameteriv")
	public static function getFramebufferAttachmentParameteriv(target:GlEnum, attachment:GlEnum, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glGenerateMipmap")
	public static function generateMipmap(target:GlEnum):Void;

	@:native("glBlitFramebuffer")
	public static function blitFramebuffer(srcX0:GlInt, srcY0:GlInt, srcX1:GlInt, srcY1:GlInt, dstX0:GlInt, dstY0:GlInt, dstX1:GlInt, dstY1:GlInt, mask:GlBitField, filter:GlEnum):Void;

	@:native("glRenderbufferStorageMultisample")
	public static function renderbufferStorageMultisample(target:GlEnum, samples:GlSizeI, internalformat:GlEnum, width:GlSizeI, height:GlSizeI):Void;

	@:native("glFramebufferTextureLayer")
	public static function framebufferTextureLayer(target:GlEnum, attachment:GlEnum, texture:GlUInt, level:GlInt, layer:GlInt):Void;

	@:native("glMapBufferRange")
	public static function mapBufferRange(target:GlEnum, offset:GlIntPointer, length:GlSizeIPointer, access:GlBitField):Star<cpp.Void>;

	@:native("glFlushMappedBufferRange")
	public static function flushMappedBufferRange(target:GlEnum, offset:GlIntPointer, length:GlSizeIPointer):Void;

	@:native("glBindVertexArray")
	public static function bindVertexArray(array:GlUInt):Void;

	@:native("glDeleteVertexArrays")
	public static function deleteVertexArrays(n:GlSizeI, arrays:ConstPointer<GlUInt>):Void;

	@:native("glGenVertexArrays")
	public static function genVertexArrays(n:GlSizeI, arrays:Pointer<GlUInt>):Void;

	@:native("glIsVertexArray")
	public static function isVertexArray(array:GlUInt):GlBool;

	@:native("glDrawArraysInstanced")
	public static function drawArraysInstanced(mode:GlEnum, first:GlInt, count:GlSizeI, instancecount:GlSizeI):Void;

	@:native("glDrawElementsInstanced")
	public static function drawElementsInstanced(mode:GlEnum, count:GlSizeI, type:GlEnum, indices:ConstStar<cpp.Void>, instancecount:GlSizeI):Void;

	@:native("glTexBuffer")
	public static function texBuffer(target:GlEnum, internalformat:GlEnum, buffer:GlUInt):Void;

	@:native("glPrimitiveRestartIndex")
	public static function primitiveRestartIndex(index:GlUInt):Void;

	@:native("glCopyBufferSubData")
	public static function copyBufferSubData(readTarget:GlEnum, writeTarget:GlEnum, readOffset:GlIntPointer, writeOffset:GlIntPointer, size:GlSizeIPointer):Void;

	@:native("glGetUniformIndices")
	public static function getUniformIndices(program:GlUInt, uniformCount:GlSizeI, uniformNames:Pointer<ConstCharStar>, uniformIndices:Pointer<GlUInt>):Void;

	@:native("glGetActiveUniformsiv")
	public static function getActiveUniformsiv(program:GlUInt, uniformCount:GlSizeI, uniformIndices:ConstPointer<GlUInt>, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glGetActiveUniformName")
	public static function getActiveUniformName(program:GlUInt, uniformIndex:GlUInt, bufSize:GlSizeI, length:Pointer<GlSizeI>, uniformName:Pointer<GlChar>):Void;

	@:native("glGetUniformBlockIndex")
	public static function getUniformBlockIndex(program:GlUInt, uniformBlockName:ConstCharStar):GlUInt;

	@:native("glGetActiveUniformBlockiv")
	public static function getActiveUniformBlockiv(program:GlUInt, uniformBlockIndex:GlUInt, pname:GlEnum, params:Star<GlInt>):Void;

	@:native("glGetActiveUniformBlockName")
	public static function getActiveUniformBlockName(program:GlUInt, uniformBlockIndex:GlUInt, bufSize:GlSizeI, length:Star<GlSizeI>, uniformBlockName:Star<GlChar>):Void;

	@:native("glUniformBlockBinding")
	public static function uniformBlockBinding(program:GlUInt, uniformBlockIndex:GlUInt, uniformBlockBinding:GlUInt):Void;

	@:native("glDrawElementsBaseVertex")
	public static function drawElementsBaseVertex(mode:GlEnum, count:GlSizeI, type:GlEnum, indices:ConstStar<cpp.Void>, basevertex:GlInt):Void;

	@:native("glDrawRangeElementsBaseVertex")
	public static function drawRangeElementsBaseVertex(mode:GlEnum, start:GlUInt, end:GlUInt, count:GlSizeI, type:GlEnum, indices:ConstStar<cpp.Void>, basevertex:GlInt):Void;

	@:native("glDrawElementsInstancedBaseVertex")
	public static function drawElementsInstancedBaseVertex(mode:GlEnum, count:GlSizeI, type:GlEnum, indices:ConstStar<cpp.Void>, instancecount:GlSizeI, basevertex:GlInt):Void;

	// @:native("glMultiDrawElementsBaseVertex") same reason as line 1855.
	// public static function multiDrawElementsBaseVertex(mode:GlEnum, count:ConstStar<GlSizeI>, type:GlEnum, const*indices:ConstStar<cpp.Void>, drawcount:GlSizeI, basevertex:ConstStar<GlInt>):Void;

	@:native("glProvokingVertex")
	public static function provokingVertex(mode:GlEnum):Void;

	@:native("glFenceSync")
	public static function fenceSync(condition:GlEnum, flags:GlBitField):GlSync;

	@:native("glIsSync")
	public static function isSync(sync:GlSync):GlBool;

	@:native("glDeleteSync")
	public static function deleteSync(sync:GlSync):Void;

	@:native("glClientWaitSync")
	public static function clientWaitSync(sync:GlSync, flags:GlBitField, timeout:GlUInt64):GlEnum;

	@:native("glWaitSync")
	public static function waitSync(sync:GlSync, flags:GlBitField, timeout:GlUInt64):Void;

	@:native("glGetInteger64v")
	public static function getInteger64v(pname:GlEnum, data:Pointer<cpp.Int64>):Void;

	@:native("glGetSynciv")
	public static function getSynciv(sync:GlSync, pname:GlEnum, count:GlSizeI, length:Pointer<GlSizeI>, values:Pointer<GlInt>):Void;

	@:native("glGetInteger64i_v")
	public static function getInteger64i_v(target:GlEnum, index:GlUInt, data:Pointer<cpp.Int64>):Void;

	@:native("glGetBufferParameteri64v")
	public static function getBufferParameteri64v(target:GlEnum, pname:GlEnum, params:Pointer<cpp.Int64>):Void;

	@:native("glFramebufferTexture")
	public static function framebufferTexture(target:GlEnum, attachment:GlEnum, texture:GlUInt, level:GlInt):Void;

	@:native("glTexImage2DMultisample")
	public static function texImage2DMultisample(target:GlEnum, samples:GlSizeI, internalformat:GlEnum, width:GlSizeI, height:GlSizeI, fixedsamplelocations:GlBool):Void;

	@:native("glTexImage3DMultisample")
	public static function texImage3DMultisample(target:GlEnum, samples:GlSizeI, internalformat:GlEnum, width:GlSizeI, height:GlSizeI, depth:GlSizeI, fixedsamplelocations:GlBool):Void;

	@:native("glGetMultisamplefv")
	public static function getMultisamplefv(pname:GlEnum, index:GlUInt, val:Pointer<GlFloat>):Void;

	@:native("glSampleMaski")
	public static function sampleMaski(maskNumber:GlUInt, mask:GlBitField):Void;

	@:native("glBindFragDataLocationIndexed")
	public static function bindFragDataLocationIndexed(program:GlUInt, colorNumber:GlUInt, index:GlUInt, name:ConstCharStar):Void;

	@:native("glGetFragDataIndex")
	public static function getFragDataIndex(program:GlUInt, name:ConstCharStar):GlInt;

	@:native("glGenSamplers")
	public static function genSamplers(count:GlSizeI, samplers:Pointer<GlUInt>):Void;

	@:native("glDeleteSamplers")
	public static function deleteSamplers(count:GlSizeI, samplers:ConstPointer<GlUInt>):Void;

	@:native("glIsSampler")
	public static function isSampler(sampler:GlUInt):GlBool;

	@:native("glBindSampler")
	public static function bindSampler(unit:GlUInt, sampler:GlUInt):Void;

	@:native("glSamplerParameteri")
	public static function samplerParameteri(sampler:GlUInt, pname:GlEnum, param:GlInt):Void;

	@:native("glSamplerParameteriv")
	public static function samplerParameteriv(sampler:GlUInt, pname:GlEnum, param:ConstStar<GlInt>):Void;

	@:native("glSamplerParameterf")
	public static function samplerParameterf(sampler:GlUInt, pname:GlEnum, param:GlFloat):Void;

	@:native("glSamplerParameterfv")
	public static function samplerParameterfv(sampler:GlUInt, pname:GlEnum, param:ConstStar<GlFloat>):Void;

	@:native("glSamplerParameterIiv")
	public static function samplerParameterIiv(sampler:GlUInt, pname:GlEnum, param:ConstStar<GlInt>):Void;

	@:native("glSamplerParameterIuiv")
	public static function samplerParameterIuiv(sampler:GlUInt, pname:GlEnum, param:ConstStar<GlUInt>):Void;

	@:native("glGetSamplerParameteriv")
	public static function getSamplerParameteriv(sampler:GlUInt, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glGetSamplerParameterIiv")
	public static function getSamplerParameterIiv(sampler:GlUInt, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glGetSamplerParameterfv")
	public static function getSamplerParameterfv(sampler:GlUInt, pname:GlEnum, params:Pointer<GlFloat>):Void;

	@:native("glGetSamplerParameterIuiv")
	public static function getSamplerParameterIuiv(sampler:GlUInt, pname:GlEnum, params:Pointer<GlUInt>):Void;

	@:native("glQueryCounter")
	public static function queryCounter(id:GlUInt, target:GlEnum):Void;

	@:native("glGetQueryObjecti64v")
	public static function getQueryObjecti64v(id:GlUInt, pname:GlEnum, params:Pointer<cpp.Int64>):Void;

	@:native("glGetQueryObjectui64v")
	public static function getQueryObjectui64v(id:GlUInt, pname:GlEnum, params:Pointer<cpp.UInt64>):Void;

	@:native("glVertexAttribDivisor")
	public static function vertexAttribDivisor(index:GlUInt, divisor:GlUInt):Void;

	@:native("glVertexAttribP1ui")
	public static function vertexAttribP1ui(index:GlUInt, type:GlEnum, normalized:GlBool, value:GlUInt):Void;

	@:native("glVertexAttribP1uiv")
	public static function vertexAttribP1uiv(index:GlUInt, type:GlEnum, normalized:GlBool, value:ConstStar<GlUInt>):Void;

	@:native("glVertexAttribP2ui")
	public static function vertexAttribP2ui(index:GlUInt, type:GlEnum, normalized:GlBool, value:GlUInt):Void;

	@:native("glVertexAttribP2uiv")
	public static function vertexAttribP2uiv(index:GlUInt, type:GlEnum, normalized:GlBool, value:ConstStar<GlUInt>):Void;

	@:native("glVertexAttribP3ui")
	public static function vertexAttribP3ui(index:GlUInt, type:GlEnum, normalized:GlBool, value:GlUInt):Void;

	@:native("glVertexAttribP3uiv")
	public static function vertexAttribP3uiv(index:GlUInt, type:GlEnum, normalized:GlBool, value:ConstStar<GlUInt>):Void;

	@:native("glVertexAttribP4ui")
	public static function vertexAttribP4ui(index:GlUInt, type:GlEnum, normalized:GlBool, value:GlUInt):Void;

	@:native("glVertexAttribP4uiv")
	public static function vertexAttribP4uiv(index:GlUInt, type:GlEnum, normalized:GlBool, value:ConstStar<GlUInt>):Void;

	@:native("glVertexP2ui")
	public static function vertexP2ui(type:GlEnum, value:GlUInt):Void;

	@:native("glVertexP2uiv")
	public static function vertexP2uiv(type:GlEnum, value:ConstStar<GlUInt>):Void;

	@:native("glVertexP3ui")
	public static function vertexP3ui(type:GlEnum, value:GlUInt):Void;

	@:native("glVertexP3uiv")
	public static function vertexP3uiv(type:GlEnum, value:ConstStar<GlUInt>):Void;

	@:native("glVertexP4ui")
	public static function vertexP4ui(type:GlEnum, value:GlUInt):Void;

	@:native("glVertexP4uiv")
	public static function vertexP4uiv(type:GlEnum, value:ConstStar<GlUInt>):Void;

	@:native("glTexCoordP1ui")
	public static function texCoordP1ui(type:GlEnum, coords:GlUInt):Void;

	@:native("glTexCoordP1uiv")
	public static function texCoordP1uiv(type:GlEnum, coords:ConstStar<GlUInt>):Void;

	@:native("glTexCoordP2ui")
	public static function texCoordP2ui(type:GlEnum, coords:GlUInt):Void;

	@:native("glTexCoordP2uiv")
	public static function texCoordP2uiv(type:GlEnum, coords:ConstStar<GlUInt>):Void;

	@:native("glTexCoordP3ui")
	public static function texCoordP3ui(type:GlEnum, coords:GlUInt):Void;

	@:native("glTexCoordP3uiv")
	public static function texCoordP3uiv(type:GlEnum, coords:ConstStar<GlUInt>):Void;

	@:native("glTexCoordP4ui")
	public static function texCoordP4ui(type:GlEnum, coords:GlUInt):Void;

	@:native("glTexCoordP4uiv")
	public static function texCoordP4uiv(type:GlEnum, coords:ConstStar<GlUInt>):Void;

	@:native("glMultiTexCoordP1ui")
	public static function multiTexCoordP1ui(texture:GlEnum, type:GlEnum, coords:GlUInt):Void;

	@:native("glMultiTexCoordP1uiv")
	public static function multiTexCoordP1uiv(texture:GlEnum, type:GlEnum, coords:ConstStar<GlUInt>):Void;

	@:native("glMultiTexCoordP2ui")
	public static function multiTexCoordP2ui(texture:GlEnum, type:GlEnum, coords:GlUInt):Void;

	@:native("glMultiTexCoordP2uiv")
	public static function multiTexCoordP2uiv(texture:GlEnum, type:GlEnum, coords:ConstStar<GlUInt>):Void;

	@:native("glMultiTexCoordP3ui")
	public static function multiTexCoordP3ui(texture:GlEnum, type:GlEnum, coords:GlUInt):Void;

	@:native("glMultiTexCoordP3uiv")
	public static function multiTexCoordP3uiv(texture:GlEnum, type:GlEnum, coords:ConstStar<GlUInt>):Void;

	@:native("glMultiTexCoordP4ui")
	public static function multiTexCoordP4ui(texture:GlEnum, type:GlEnum, coords:GlUInt):Void;

	@:native("glMultiTexCoordP4uiv")
	public static function multiTexCoordP4uiv(texture:GlEnum, type:GlEnum, coords:ConstStar<GlUInt>):Void;

	@:native("glNormalP3ui")
	public static function normalP3ui(type:GlEnum, coords:GlUInt):Void;

	@:native("glNormalP3uiv")
	public static function normalP3uiv(type:GlEnum, coords:ConstStar<GlUInt>):Void;

	@:native("glColorP3ui")
	public static function colorP3ui(type:GlEnum, color:GlUInt):Void;

	@:native("glColorP3uiv")
	public static function colorP3uiv(type:GlEnum, color:ConstStar<GlUInt>):Void;

	@:native("glColorP4ui")
	public static function colorP4ui(type:GlEnum, color:GlUInt):Void;

	@:native("glColorP4uiv")
	public static function colorP4uiv(type:GlEnum, color:ConstStar<GlUInt>):Void;

	@:native("glSecondaryColorP3ui")
	public static function secondaryColorP3ui(type:GlEnum, color:GlUInt):Void;

	@:native("glSecondaryColorP3uiv")
	public static function secondaryColorP3uiv(type:GlEnum, color:ConstStar<GlUInt>):Void;

	@:native("glMinSampleShading")
	public static function minSampleShading(value:GlFloat):Void;

	@:native("glBlendEquationi")
	public static function blendEquationi(buf:GlUInt, mode:GlEnum):Void;

	@:native("glBlendEquationSeparatei")
	public static function blendEquationSeparatei(buf:GlUInt, modeRGB:GlEnum, modeAlpha:GlEnum):Void;

	@:native("glBlendFunci")
	public static function blendFunci(buf:GlUInt, src:GlEnum, dst:GlEnum):Void;

	@:native("glBlendFuncSeparatei")
	public static function blendFuncSeparatei(buf:GlUInt, srcRGB:GlEnum, dstRGB:GlEnum, srcAlpha:GlEnum, dstAlpha:GlEnum):Void;

	@:native("glDrawArraysIndirect")
	public static function drawArraysIndirect(mode:GlEnum, indirect:ConstStar<cpp.Void>):Void;

	@:native("glDrawElementsIndirect")
	public static function drawElementsIndirect(mode:GlEnum, type:GlEnum, indirect:ConstStar<cpp.Void>):Void;

	@:native("glUniform1d")
	public static function uniform1d(location:GlInt, x:GlDouble):Void;

	@:native("glUniform2d")
	public static function uniform2d(location:GlInt, x:GlDouble, y:GlDouble):Void;

	@:native("glUniform3d")
	public static function uniform3d(location:GlInt, x:GlDouble, y:GlDouble, z:GlDouble):Void;

	@:native("glUniform4d")
	public static function uniform4d(location:GlInt, x:GlDouble, y:GlDouble, z:GlDouble, w:GlDouble):Void;

	@:native("glUniform1dv")
	public static function uniform1dv(location:GlInt, count:GlSizeI, value:ConstStar<GlDouble>):Void;

	@:native("glUniform2dv")
	public static function uniform2dv(location:GlInt, count:GlSizeI, value:ConstStar<GlDouble>):Void;

	@:native("glUniform3dv")
	public static function uniform3dv(location:GlInt, count:GlSizeI, value:ConstStar<GlDouble>):Void;

	@:native("glUniform4dv")
	public static function uniform4dv(location:GlInt, count:GlSizeI, value:ConstStar<GlDouble>):Void;

	@:native("glUniformMatrix2dv")
	public static function uniformMatrix2dv(location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlDouble>):Void;

	@:native("glUniformMatrix3dv")
	public static function uniformMatrix3dv(location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlDouble>):Void;

	@:native("glUniformMatrix4dv")
	public static function uniformMatrix4dv(location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlDouble>):Void;

	@:native("glUniformMatrix2x3dv")
	public static function uniformMatrix2x3dv(location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlDouble>):Void;

	@:native("glUniformMatrix2x4dv")
	public static function uniformMatrix2x4dv(location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlDouble>):Void;

	@:native("glUniformMatrix3x2dv")
	public static function uniformMatrix3x2dv(location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlDouble>):Void;

	@:native("glUniformMatrix3x4dv")
	public static function uniformMatrix3x4dv(location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlDouble>):Void;

	@:native("glUniformMatrix4x2dv")
	public static function uniformMatrix4x2dv(location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlDouble>):Void;

	@:native("glUniformMatrix4x3dv")
	public static function uniformMatrix4x3dv(location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlDouble>):Void;

	@:native("glGetUniformdv")
	public static function getUniformdv(program:GlUInt, location:GlInt, params:Pointer<GlDouble>):Void;

	@:native("glGetSubroutineUniformLocation")
	public static function getSubroutineUniformLocation(program:GlUInt, shadertype:GlEnum, name:ConstCharStar):GlInt;

	@:native("glGetSubroutineIndex")
	public static function getSubroutineIndex(program:GlUInt, shadertype:GlEnum, name:ConstCharStar):GlUInt;

	@:native("glGetActiveSubroutineUniformiv")
	public static function getActiveSubroutineUniformiv(program:GlUInt, shadertype:GlEnum, index:GlUInt, pname:GlEnum, values:Pointer<GlInt>):Void;

	@:native("glGetActiveSubroutineUniformName")
	public static function getActiveSubroutineUniformName(program:GlUInt, shadertype:GlEnum, index:GlUInt, bufSize:GlSizeI, length:Pointer<GlSizeI>, name:Pointer<GlChar>):Void;

	@:native("glGetActiveSubroutineName")
	public static function getActiveSubroutineName(program:GlUInt, shadertype:GlEnum, index:GlUInt, bufSize:GlSizeI, length:Pointer<GlSizeI>, name:Pointer<GlChar>):Void;

	@:native("glUniformSubroutinesuiv")
	public static function uniformSubroutinesuiv(shadertype:GlEnum, count:GlSizeI, indices:ConstStar<GlUInt>):Void;

	@:native("glGetUniformSubroutineuiv")
	public static function getUniformSubroutineuiv(shadertype:GlEnum, location:GlInt, params:Pointer<GlUInt>):Void;

	@:native("glGetProgramStageiv")
	public static function getProgramStageiv(program:GlUInt, shadertype:GlEnum, pname:GlEnum, values:Pointer<GlInt>):Void;

	@:native("glPatchParameteri")
	public static function patchParameteri(pname:GlEnum, value:GlInt):Void;

	@:native("glPatchParameterfv")
	public static function patchParameterfv(pname:GlEnum, values:ConstStar<GlFloat>):Void;

	@:native("glBindTransformFeedback")
	public static function bindTransformFeedback(target:GlEnum, id:GlUInt):Void;

	@:native("glDeleteTransformFeedbacks")
	public static function deleteTransformFeedbacks(n:GlSizeI, ids:ConstPointer<GlUInt>):Void;

	@:native("glGenTransformFeedbacks")
	public static function genTransformFeedbacks(n:GlSizeI, ids:Pointer<GlUInt>):Void;

	@:native("glIsTransformFeedback")
	public static function isTransformFeedback(id:GlUInt):GlBool;

	@:native("glPauseTransformFeedback")
	public static function pauseTransformFeedback():Void;

	@:native("glResumeTransformFeedback")
	public static function resumeTransformFeedback():Void;

	@:native("glDrawTransformFeedback")
	public static function drawTransformFeedback(mode:GlEnum, id:GlUInt):Void;

	@:native("glDrawTransformFeedbackStream")
	public static function drawTransformFeedbackStream(mode:GlEnum, id:GlUInt, stream:GlUInt):Void;

	@:native("glBeginQueryIndexed")
	public static function beginQueryIndexed(target:GlEnum, index:GlUInt, id:GlUInt):Void;

	@:native("glEndQueryIndexed")
	public static function endQueryIndexed(target:GlEnum, index:GlUInt):Void;

	@:native("glGetQueryIndexediv")
	public static function getQueryIndexediv(target:GlEnum, index:GlUInt, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glReleaseShaderCompiler")
	public static function releaseShaderCompiler():Void;

	@:native("glShaderBinary")
	public static function shaderBinary(count:GlSizeI, shaders:ConstStar<GlUInt>, binaryFormat:GlEnum, binary:ConstStar<cpp.Void>, length:GlSizeI):Void;

	@:native("glGetShaderPrecisionFormat")
	public static function getShaderPrecisionFormat(shadertype:GlEnum, precisiontype:GlEnum, range:Pointer<GlInt>, precision:Pointer<GlInt>):Void;

	@:native("glDepthRangef")
	public static function depthRangef(n:GlFloat, f:GlFloat):Void;

	@:native("glClearDepthf")
	public static function clearDepthf(d:GlFloat):Void;

	@:native("glGetProgramBinary")
	public static function getProgramBinary(program:GlUInt, bufSize:GlSizeI, length:Pointer<GlSizeI>, binaryFormat:Pointer<GlEnum>, binary:Pointer<cpp.Void>):Void;

	@:native("glProgramBinary")
	public static function programBinary(program:GlUInt, binaryFormat:GlEnum, binary:ConstStar<cpp.Void>, length:GlSizeI):Void;

	@:native("glProgramParameteri")
	public static function programParameteri(program:GlUInt, pname:GlEnum, value:GlInt):Void;

	@:native("glUseProgramStages")
	public static function useProgramStages(pipeline:GlUInt, stages:GlBitField, program:GlUInt):Void;

	@:native("glActiveShaderProgram")
	public static function activeShaderProgram(pipeline:GlUInt, program:GlUInt):Void;

	@:native("glCreateShaderProgramv")
	public static function createShaderProgramv(type:GlEnum, count:GlSizeI, strings:Star<ConstCharStar>):GlUInt;

	@:native("glBindProgramPipeline")
	public static function bindProgramPipeline(pipeline:GlUInt):Void;

	@:native("glDeleteProgramPipelines")
	public static function deleteProgramPipelines(n:GlSizeI, pipelines:ConstPointer<GlUInt>):Void;

	@:native("glGenProgramPipelines")
	public static function genProgramPipelines(n:GlSizeI, pipelines:Pointer<GlUInt>):Void;

	@:native("glIsProgramPipeline")
	public static function isProgramPipeline(pipeline:GlUInt):GlBool;

	@:native("glGetProgramPipelineiv")
	public static function getProgramPipelineiv(pipeline:GlUInt, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glProgramUniform1i")
	public static function programUniform1i(program:GlUInt, location:GlInt, v0:GlInt):Void;

	@:native("glProgramUniform1iv")
	public static function programUniform1iv(program:GlUInt, location:GlInt, count:GlSizeI, value:ConstStar<GlInt>):Void;

	@:native("glProgramUniform1f")
	public static function programUniform1f(program:GlUInt, location:GlInt, v0:GlFloat):Void;

	@:native("glProgramUniform1fv")
	public static function programUniform1fv(program:GlUInt, location:GlInt, count:GlSizeI, value:ConstStar<GlFloat>):Void;

	@:native("glProgramUniform1d")
	public static function programUniform1d(program:GlUInt, location:GlInt, v0:GlDouble):Void;

	@:native("glProgramUniform1dv")
	public static function programUniform1dv(program:GlUInt, location:GlInt, count:GlSizeI, value:ConstStar<GlDouble>):Void;

	@:native("glProgramUniform1ui")
	public static function programUniform1ui(program:GlUInt, location:GlInt, v0:GlUInt):Void;

	@:native("glProgramUniform1uiv")
	public static function programUniform1uiv(program:GlUInt, location:GlInt, count:GlSizeI, value:ConstStar<GlUInt>):Void;

	@:native("glProgramUniform2i")
	public static function programUniform2i(program:GlUInt, location:GlInt, v0:GlInt, v1:GlInt):Void;

	@:native("glProgramUniform2iv")
	public static function programUniform2iv(program:GlUInt, location:GlInt, count:GlSizeI, value:ConstStar<GlInt>):Void;

	@:native("glProgramUniform2f")
	public static function programUniform2f(program:GlUInt, location:GlInt, v0:GlFloat, v1:GlFloat):Void;

	@:native("glProgramUniform2fv")
	public static function programUniform2fv(program:GlUInt, location:GlInt, count:GlSizeI, value:ConstStar<GlFloat>):Void;

	@:native("glProgramUniform2d")
	public static function programUniform2d(program:GlUInt, location:GlInt, v0:GlDouble, v1:GlDouble):Void;

	@:native("glProgramUniform2dv")
	public static function programUniform2dv(program:GlUInt, location:GlInt, count:GlSizeI, value:ConstStar<GlDouble>):Void;

	@:native("glProgramUniform2ui")
	public static function programUniform2ui(program:GlUInt, location:GlInt, v0:GlUInt, v1:GlUInt):Void;

	@:native("glProgramUniform2uiv")
	public static function programUniform2uiv(program:GlUInt, location:GlInt, count:GlSizeI, value:ConstStar<GlUInt>):Void;

	@:native("glProgramUniform3i")
	public static function programUniform3i(program:GlUInt, location:GlInt, v0:GlInt, v1:GlInt, v2:GlInt):Void;

	@:native("glProgramUniform3iv")
	public static function programUniform3iv(program:GlUInt, location:GlInt, count:GlSizeI, value:ConstStar<GlInt>):Void;

	@:native("glProgramUniform3f")
	public static function programUniform3f(program:GlUInt, location:GlInt, v0:GlFloat, v1:GlFloat, v2:GlFloat):Void;

	@:native("glProgramUniform3fv")
	public static function programUniform3fv(program:GlUInt, location:GlInt, count:GlSizeI, value:ConstStar<GlFloat>):Void;

	@:native("glProgramUniform3d")
	public static function programUniform3d(program:GlUInt, location:GlInt, v0:GlDouble, v1:GlDouble, v2:GlDouble):Void;

	@:native("glProgramUniform3dv")
	public static function programUniform3dv(program:GlUInt, location:GlInt, count:GlSizeI, value:ConstStar<GlDouble>):Void;

	@:native("glProgramUniform3ui")
	public static function programUniform3ui(program:GlUInt, location:GlInt, v0:GlUInt, v1:GlUInt, v2:GlUInt):Void;

	@:native("glProgramUniform3uiv")
	public static function programUniform3uiv(program:GlUInt, location:GlInt, count:GlSizeI, value:ConstStar<GlUInt>):Void;

	@:native("glProgramUniform4i")
	public static function programUniform4i(program:GlUInt, location:GlInt, v0:GlInt, v1:GlInt, v2:GlInt, v3:GlInt):Void;

	@:native("glProgramUniform4iv")
	public static function programUniform4iv(program:GlUInt, location:GlInt, count:GlSizeI, value:ConstStar<GlInt>):Void;

	@:native("glProgramUniform4f")
	public static function programUniform4f(program:GlUInt, location:GlInt, v0:GlFloat, v1:GlFloat, v2:GlFloat, v3:GlFloat):Void;

	@:native("glProgramUniform4fv")
	public static function programUniform4fv(program:GlUInt, location:GlInt, count:GlSizeI, value:ConstStar<GlFloat>):Void;

	@:native("glProgramUniform4d")
	public static function programUniform4d(program:GlUInt, location:GlInt, v0:GlDouble, v1:GlDouble, v2:GlDouble, v3:GlDouble):Void;

	@:native("glProgramUniform4dv")
	public static function programUniform4dv(program:GlUInt, location:GlInt, count:GlSizeI, value:ConstStar<GlDouble>):Void;

	@:native("glProgramUniform4ui")
	public static function programUniform4ui(program:GlUInt, location:GlInt, v0:GlUInt, v1:GlUInt, v2:GlUInt, v3:GlUInt):Void;

	@:native("glProgramUniform4uiv")
	public static function programUniform4uiv(program:GlUInt, location:GlInt, count:GlSizeI, value:ConstStar<GlUInt>):Void;

	@:native("glProgramUniformMatrix2fv")
	public static function programUniformMatrix2fv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlFloat>):Void;

	@:native("glProgramUniformMatrix3fv")
	public static function programUniformMatrix3fv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlFloat>):Void;

	@:native("glProgramUniformMatrix4fv")
	public static function programUniformMatrix4fv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlFloat>):Void;

	@:native("glProgramUniformMatrix2dv")
	public static function programUniformMatrix2dv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlDouble>):Void;

	@:native("glProgramUniformMatrix3dv")
	public static function programUniformMatrix3dv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlDouble>):Void;

	@:native("glProgramUniformMatrix4dv")
	public static function programUniformMatrix4dv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlDouble>):Void;

	@:native("glProgramUniformMatrix2x3fv")
	public static function programUniformMatrix2x3fv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlFloat>):Void;

	@:native("glProgramUniformMatrix3x2fv")
	public static function programUniformMatrix3x2fv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlFloat>):Void;

	@:native("glProgramUniformMatrix2x4fv")
	public static function programUniformMatrix2x4fv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlFloat>):Void;

	@:native("glProgramUniformMatrix4x2fv")
	public static function programUniformMatrix4x2fv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlFloat>):Void;

	@:native("glProgramUniformMatrix3x4fv")
	public static function programUniformMatrix3x4fv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlFloat>):Void;

	@:native("glProgramUniformMatrix4x3fv")
	public static function programUniformMatrix4x3fv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlFloat>):Void;

	@:native("glProgramUniformMatrix2x3dv")
	public static function programUniformMatrix2x3dv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlDouble>):Void;

	@:native("glProgramUniformMatrix3x2dv")
	public static function programUniformMatrix3x2dv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlDouble>):Void;

	@:native("glProgramUniformMatrix2x4dv")
	public static function programUniformMatrix2x4dv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlDouble>):Void;

	@:native("glProgramUniformMatrix4x2dv")
	public static function programUniformMatrix4x2dv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlDouble>):Void;

	@:native("glProgramUniformMatrix3x4dv")
	public static function programUniformMatrix3x4dv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlDouble>):Void;

	@:native("glProgramUniformMatrix4x3dv")
	public static function programUniformMatrix4x3dv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:ConstStar<GlDouble>):Void;

	@:native("glValidateProgramPipeline")
	public static function validateProgramPipeline(pipeline:GlUInt):Void;

	@:native("glGetProgramPipelineInfoLog")
	public static function getProgramPipelineInfoLog(pipeline:GlUInt, bufSize:GlSizeI, length:Pointer<GlSizeI>, infoLog:Star<GlChar>):Void;

	@:native("glVertexAttribL1d")
	public static function vertexAttribL1d(index:GlUInt, x:GlDouble):Void;

	@:native("glVertexAttribL2d")
	public static function vertexAttribL2d(index:GlUInt, x:GlDouble, y:GlDouble):Void;

	@:native("glVertexAttribL3d")
	public static function vertexAttribL3d(index:GlUInt, x:GlDouble, y:GlDouble, z:GlDouble):Void;

	@:native("glVertexAttribL4d")
	public static function vertexAttribL4d(index:GlUInt, x:GlDouble, y:GlDouble, z:GlDouble, w:GlDouble):Void;

	@:native("glVertexAttribL1dv")
	public static function vertexAttribL1dv(index:GlUInt, v:ConstStar<GlDouble>):Void;

	@:native("glVertexAttribL2dv")
	public static function vertexAttribL2dv(index:GlUInt, v:ConstStar<GlDouble>):Void;

	@:native("glVertexAttribL3dv")
	public static function vertexAttribL3dv(index:GlUInt, v:ConstStar<GlDouble>):Void;

	@:native("glVertexAttribL4dv")
	public static function vertexAttribL4dv(index:GlUInt, v:ConstStar<GlDouble>):Void;

	@:native("glVertexAttribLPointer")
	public static function vertexAttribLPointer(index:GlUInt, size:GlInt, type:GlEnum, stride:GlSizeI, pointer:ConstStar<cpp.Void>):Void;

	@:native("glGetVertexAttribLdv")
	public static function getVertexAttribLdv(index:GlUInt, pname:GlEnum, params:Pointer<GlDouble>):Void;

	@:native("glViewportArrayv")
	public static function viewportArrayv(first:GlUInt, count:GlSizeI, v:ConstStar<GlFloat>):Void;

	@:native("glViewportIndexedf")
	public static function viewportIndexedf(index:GlUInt, x:GlFloat, y:GlFloat, w:GlFloat, h:GlFloat):Void;

	@:native("glViewportIndexedfv")
	public static function viewportIndexedfv(index:GlUInt, v:ConstStar<GlFloat>):Void;

	@:native("glScissorArrayv")
	public static function scissorArrayv(first:GlUInt, count:GlSizeI, v:ConstStar<GlInt>):Void;

	@:native("glScissorIndexed")
	public static function scissorIndexed(index:GlUInt, left:GlInt, bottom:GlInt, width:GlSizeI, height:GlSizeI):Void;

	@:native("glScissorIndexedv")
	public static function scissorIndexedv(index:GlUInt, v:ConstStar<GlInt>):Void;

	@:native("glDepthRangeArrayv")
	public static function depthRangeArrayv(first:GlUInt, count:GlSizeI, v:ConstStar<GlDouble>):Void;

	@:native("glDepthRangeIndexed")
	public static function depthRangeIndexed(index:GlUInt, n:GlDouble, f:GlDouble):Void;

	@:native("glGetFloati_v")
	public static function getFloati_v(target:GlEnum, index:GlUInt, data:Pointer<GlFloat>):Void;

	@:native("glGetDoublei_v")
	public static function getDoublei_v(target:GlEnum, index:GlUInt, data:Pointer<GlDouble>):Void;

	@:native("glDrawArraysInstancedBaseInstance")
	public static function drawArraysInstancedBaseInstance(mode:GlEnum, first:GlInt, count:GlSizeI, instancecount:GlSizeI, baseinstance:GlUInt):Void;

	@:native("glDrawElementsInstancedBaseInstance")
	public static function drawElementsInstancedBaseInstance(mode:GlEnum, count:GlSizeI, type:GlEnum, indices:ConstStar<cpp.Void>, instancecount:GlSizeI, baseinstance:GlUInt):Void;

	@:native("glDrawElementsInstancedBaseVertexBaseInstance")
	public static function drawElementsInstancedBaseVertexBaseInstance(mode:GlEnum, count:GlSizeI, type:GlEnum, indices:ConstStar<cpp.Void>, instancecount:GlSizeI, basevertex:GlInt, baseinstance:GlUInt):Void;

	@:native("glGetInternalformativ")
	public static function getInternalformativ(target:GlEnum, internalformat:GlEnum, pname:GlEnum, count:GlSizeI, params:Pointer<GlInt>):Void;

	@:native("glGetActiveAtomicCounterBufferiv")
	public static function getActiveAtomicCounterBufferiv(program:GlUInt, bufferIndex:GlUInt, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glBindImageTexture")
	public static function bindImageTexture(unit:GlUInt, texture:GlUInt, level:GlInt, layered:GlBool, layer:GlInt, access:GlEnum, format:GlEnum):Void;

	@:native("glMemoryBarrier")
	public static function memoryBarrier(barriers:GlBitField):Void;

	@:native("glTexStorage1D")
	public static function texStorage1D(target:GlEnum, levels:GlSizeI, internalformat:GlEnum, width:GlSizeI):Void;

	@:native("glTexStorage2D")
	public static function texStorage2D(target:GlEnum, levels:GlSizeI, internalformat:GlEnum, width:GlSizeI, height:GlSizeI):Void;

	@:native("glTexStorage3D")
	public static function texStorage3D(target:GlEnum, levels:GlSizeI, internalformat:GlEnum, width:GlSizeI, height:GlSizeI, depth:GlSizeI):Void;

	@:native("glDrawTransformFeedbackInstanced")
	public static function drawTransformFeedbackInstanced(mode:GlEnum, id:GlUInt, instancecount:GlSizeI):Void;

	@:native("glDrawTransformFeedbackStreamInstanced")
	public static function drawTransformFeedbackStreamInstanced(mode:GlEnum, id:GlUInt, stream:GlUInt, instancecount:GlSizeI):Void;

	@:native("glClearBufferData")
	public static function clearBufferData(target:GlEnum, internalformat:GlEnum, format:GlEnum, type:GlEnum, data:ConstStar<cpp.Void>):Void;

	@:native("glClearBufferSubData")
	public static function clearBufferSubData(target:GlEnum, internalformat:GlEnum, offset:GlIntPointer, size:GlSizeIPointer, format:GlEnum, type:GlEnum, data:ConstStar<cpp.Void>):Void;

	@:native("glDispatchCompute")
	public static function dispatchCompute(num_groups_x:GlUInt, num_groups_y:GlUInt, num_groups_z:GlUInt):Void;

	@:native("glDispatchComputeIndirect")
	public static function dispatchComputeIndirect(indirect:GlIntPointer):Void;

	@:native("glCopyImageSubData")
	public static function copyImageSubData(srcName:GlUInt, srcTarget:GlEnum, srcLevel:GlInt, srcX:GlInt, srcY:GlInt, srcZ:GlInt, dstName:GlUInt, dstTarget:GlEnum, dstLevel:GlInt, dstX:GlInt, dstY:GlInt, dstZ:GlInt, srcWidth:GlSizeI, srcHeight:GlSizeI, srcDepth:GlSizeI):Void;

	@:native("glFramebufferParameteri")
	public static function framebufferParameteri(target:GlEnum, pname:GlEnum, param:GlInt):Void;

	@:native("glGetFramebufferParameteriv")
	public static function getFramebufferParameteriv(target:GlEnum, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glGetInternalformati64v")
	public static function getInternalformati64v(target:GlEnum, internalformat:GlEnum, pname:GlEnum, count:GlSizeI, params:Pointer<cpp.Int64>):Void;

	@:native("glInvalidateTexSubImage")
	public static function invalidateTexSubImage(texture:GlUInt, level:GlInt, xoffset:GlInt, yoffset:GlInt, zoffset:GlInt, width:GlSizeI, height:GlSizeI, depth:GlSizeI):Void;

	@:native("glInvalidateTexImage")
	public static function invalidateTexImage(texture:GlUInt, level:GlInt):Void;

	@:native("glInvalidateBufferSubData")
	public static function invalidateBufferSubData(buffer:GlUInt, offset:GlIntPointer, length:GlSizeIPointer):Void;

	@:native("glInvalidateBufferData")
	public static function invalidateBufferData(buffer:GlUInt):Void;

	@:native("glInvalidateFramebuffer")
	public static function invalidateFramebuffer(target:GlEnum, numAttachments:GlSizeI, attachments:ConstStar<GlEnum>):Void;

	@:native("glInvalidateSubFramebuffer")
	public static function invalidateSubFramebuffer(target:GlEnum, numAttachments:GlSizeI, attachments:ConstStar<GlEnum>, x:GlInt, y:GlInt, width:GlSizeI, height:GlSizeI):Void;

	@:native("glMultiDrawArraysIndirect")
	public static function multiDrawArraysIndirect(mode:GlEnum, indirect:ConstStar<cpp.Void>, drawcount:GlSizeI, stride:GlSizeI):Void;

	@:native("glMultiDrawElementsIndirect")
	public static function multiDrawElementsIndirect(mode:GlEnum, type:GlEnum, indirect:ConstStar<cpp.Void>, drawcount:GlSizeI, stride:GlSizeI):Void;

	@:native("glGetProgramInterfaceiv")
	public static function getProgramInterfaceiv(program:GlUInt, programInterface:GlEnum, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glGetProgramResourceIndex")
	public static function getProgramResourceIndex(program:GlUInt, programInterface:GlEnum, name:ConstCharStar):GlUInt;

	@:native("glGetProgramResourceName")
	public static function getProgramResourceName(program:GlUInt, programInterface:GlEnum, index:GlUInt, bufSize:GlSizeI, length:Pointer<GlSizeI>, name:Pointer<GlChar>):Void;

	@:native("glGetProgramResourceiv")
	public static function getProgramResourceiv(program:GlUInt, programInterface:GlEnum, index:GlUInt, propCount:GlSizeI, props:ConstPointer<GlEnum>, count:GlSizeI, length:Pointer<GlSizeI>, params:Pointer<GlInt>):Void;

	@:native("glGetProgramResourceLocation")
	public static function getProgramResourceLocation(program:GlUInt, programInterface:GlEnum, name:ConstCharStar):GlInt;

	@:native("glGetProgramResourceLocationIndex")
	public static function getProgramResourceLocationIndex(program:GlUInt, programInterface:GlEnum, name:ConstCharStar):GlInt;

	@:native("glShaderStorageBlockBinding")
	public static function shaderStorageBlockBinding(program:GlUInt, storageBlockIndex:GlUInt, storageBlockBinding:GlUInt):Void;

	@:native("glTexBufferRange")
	public static function texBufferRange(target:GlEnum, internalformat:GlEnum, buffer:GlUInt, offset:GlIntPointer, size:GlSizeIPointer):Void;

	@:native("glTexStorage2DMultisample")
	public static function texStorage2DMultisample(target:GlEnum, samples:GlSizeI, internalformat:GlEnum, width:GlSizeI, height:GlSizeI, fixedsamplelocations:GlBool):Void;

	@:native("glTexStorage3DMultisample")
	public static function texStorage3DMultisample(target:GlEnum, samples:GlSizeI, internalformat:GlEnum, width:GlSizeI, height:GlSizeI, depth:GlSizeI, fixedsamplelocations:GlBool):Void;

	@:native("glTextureView")
	public static function textureView(texture:GlUInt, target:GlEnum, origtexture:GlUInt, internalformat:GlEnum, minlevel:GlUInt, numlevels:GlUInt, minlayer:GlUInt, numlayers:GlUInt):Void;

	@:native("glBindVertexBuffer")
	public static function bindVertexBuffer(bindingindex:GlUInt, buffer:GlUInt, offset:GlIntPointer, stride:GlSizeI):Void;

	@:native("glVertexAttribFormat")
	public static function vertexAttribFormat(attribindex:GlUInt, size:GlInt, type:GlEnum, normalized:GlBool, relativeoffset:GlUInt):Void;

	@:native("glVertexAttribIFormat")
	public static function vertexAttribIFormat(attribindex:GlUInt, size:GlInt, type:GlEnum, relativeoffset:GlUInt):Void;

	@:native("glVertexAttribLFormat")
	public static function vertexAttribLFormat(attribindex:GlUInt, size:GlInt, type:GlEnum, relativeoffset:GlUInt):Void;

	@:native("glVertexAttribBinding")
	public static function vertexAttribBinding(attribindex:GlUInt, bindingindex:GlUInt):Void;

	@:native("glVertexBindingDivisor")
	public static function vertexBindingDivisor(bindingindex:GlUInt, divisor:GlUInt):Void;

	@:native("glDebugMessageControl")
	public static function debugMessageControl(source:GlEnum, type:GlEnum, severity:GlEnum, count:GlSizeI, ids:ConstStar<GlUInt>, enabled:GlBool):Void;

	@:native("glDebugMessageInsert")
	public static function debugMessageInsert(source:GlEnum, type:GlEnum, id:GlUInt, severity:GlEnum, length:GlSizeI, buf:ConstCharStar):Void;

	@:native("glDebugMessageCallback")
	public static function debugMessageCallback(callback:GlDebugProc, userParam:ConstStar<cpp.Void>):Void;

	@:native("glGetDebugMessageLog")
	public static function getDebugMessageLog(count:GlUInt, bufSize:GlSizeI, sources:Pointer<GlEnum>, types:Pointer<GlEnum>, ids:Pointer<GlUInt>, severities:Pointer<GlEnum>, lengths:Pointer<GlSizeI>, messageLog:Pointer<GlChar>):GlUInt;

	@:native("glPushDebugGroup")
	public static function pushDebugGroup(source:GlEnum, id:GlUInt, length:GlSizeI, message:ConstCharStar):Void;

	@:native("glPopDebugGroup")
	public static function popDebugGroup():Void;

	@:native("glObjectLabel")
	public static function objectLabel(identifier:GlEnum, name:GlUInt, length:GlSizeI, label:ConstCharStar):Void;

	@:native("glGetObjectLabel")
	public static function getObjectLabel(identifier:GlEnum, name:GlUInt, bufSize:GlSizeI, length:Pointer<GlSizeI>, label:Pointer<GlChar>):Void;

	@:native("glObjectPtrLabel")
	public static function objectPtrLabel(ptr:ConstStar<cpp.Void>, length:GlSizeI, label:ConstCharStar):Void;

	@:native("glGetObjectPtrLabel")
	public static function getObjectPtrLabel(ptr:ConstStar<cpp.Void>, bufSize:GlSizeI, length:Pointer<GlSizeI>, label:Pointer<GlChar>):Void;

	@:native("glGetPointerv")
	public static function getPointerv(pname:GlEnum, params:Pointer<Pointer<cpp.Void>>):Void;

	@:native("glBufferStorage")
	public static function bufferStorage(target:GlEnum, size:GlSizeIPointer, data:ConstStar<cpp.Void>, flags:GlBitField):Void;

	@:native("glClearTexImage")
	public static function clearTexImage(texture:GlUInt, level:GlInt, format:GlEnum, type:GlEnum, data:ConstStar<cpp.Void>):Void;

	@:native("glClearTexSubImage")
	public static function clearTexSubImage(texture:GlUInt, level:GlInt, xoffset:GlInt, yoffset:GlInt, zoffset:GlInt, width:GlSizeI, height:GlSizeI, depth:GlSizeI, format:GlEnum, type:GlEnum, data:ConstStar<cpp.Void>):Void;

	@:native("glBindBuffersBase")
	public static function bindBuffersBase(target:GlEnum, first:GlUInt, count:GlSizeI, buffers:ConstStar<GlUInt>):Void;

	@:native("glBindBuffersRange")
	public static function bindBuffersRange(target:GlEnum, first:GlUInt, count:GlSizeI, buffers:ConstStar<GlUInt>, offsets:ConstStar<GlIntPointer>, sizes:ConstStar<GlSizeIPointer>):Void;

	@:native("glBindTextures")
	public static function bindTextures(first:GlUInt, count:GlSizeI, textures:ConstStar<GlUInt>):Void;

	@:native("glBindSamplers")
	public static function bindSamplers(first:GlUInt, count:GlSizeI, samplers:ConstStar<GlUInt>):Void;

	@:native("glBindImageTextures")
	public static function bindImageTextures(first:GlUInt, count:GlSizeI, textures:ConstStar<GlUInt>):Void;

	@:native("glBindVertexBuffers")
	public static function bindVertexBuffers(first:GlUInt, count:GlSizeI, buffers:ConstStar<GlUInt>, offsets:ConstStar<GlIntPointer>, strides:ConstStar<GlSizeI>):Void;

	@:native("glClipControl")
	public static function clipControl(origin:GlEnum, depth:GlEnum):Void;

	@:native("glCreateTransformFeedbacks")
	public static function createTransformFeedbacks(n:GlSizeI, ids:Star<GlUInt>):Void;

	@:native("glTransformFeedbackBufferBase")
	public static function transformFeedbackBufferBase(xfb:GlUInt, index:GlUInt, buffer:GlUInt):Void;

	@:native("glTransformFeedbackBufferRange")
	public static function transformFeedbackBufferRange(xfb:GlUInt, index:GlUInt, buffer:GlUInt, offset:GlIntPointer, size:GlSizeIPointer):Void;

	@:native("glGetTransformFeedbackiv")
	public static function getTransformFeedbackiv(xfb:GlUInt, pname:GlEnum, param:Pointer<GlInt>):Void;

	@:native("glGetTransformFeedbacki_v")
	public static function getTransformFeedbacki_v(xfb:GlUInt, pname:GlEnum, index:GlUInt, param:Pointer<GlInt>):Void;

	@:native("glGetTransformFeedbacki64_v")
	public static function getTransformFeedbacki64_v(xfb:GlUInt, pname:GlEnum, index:GlUInt, param:Pointer<cpp.Int64>):Void;

	@:native("glCreateBuffers")
	public static function createBuffers(n:GlSizeI, buffers:Star<GlUInt>):Void;

	@:native("glNamedBufferStorage")
	public static function namedBufferStorage(buffer:GlUInt, size:GlSizeIPointer, data:ConstStar<cpp.Void>, flags:GlBitField):Void;

	@:native("glNamedBufferData")
	public static function namedBufferData(buffer:GlUInt, size:GlSizeIPointer, data:ConstStar<cpp.Void>, usage:GlEnum):Void;

	@:native("glNamedBufferSubData")
	public static function namedBufferSubData(buffer:GlUInt, offset:GlIntPointer, size:GlSizeIPointer, data:ConstStar<cpp.Void>):Void;

	@:native("glCopyNamedBufferSubData")
	public static function copyNamedBufferSubData(readBuffer:GlUInt, writeBuffer:GlUInt, readOffset:GlIntPointer, writeOffset:GlIntPointer, size:GlSizeIPointer):Void;

	@:native("glClearNamedBufferData")
	public static function clearNamedBufferData(buffer:GlUInt, internalformat:GlEnum, format:GlEnum, type:GlEnum, data:ConstStar<cpp.Void>):Void;

	@:native("glClearNamedBufferSubData")
	public static function clearNamedBufferSubData(buffer:GlUInt, internalformat:GlEnum, offset:GlIntPointer, size:GlSizeIPointer, format:GlEnum, type:GlEnum, data:ConstStar<cpp.Void>):Void;

	@:native("glMapNamedBuffer")
	public static function mapNamedBuffer(buffer:GlUInt, access:GlEnum):Star<cpp.Void>;

	@:native("glMapNamedBufferRange")
	public static function mapNamedBufferRange(buffer:GlUInt, offset:GlIntPointer, length:GlSizeIPointer, access:GlBitField):Star<cpp.Void>;

	@:native("glUnmapNamedBuffer")
	public static function unmapNamedBuffer(buffer:GlUInt):GlBool;

	@:native("glFlushMappedNamedBufferRange")
	public static function flushMappedNamedBufferRange(buffer:GlUInt, offset:GlIntPointer, length:GlSizeIPointer):Void;

	@:native("glGetNamedBufferParameteriv")
	public static function getNamedBufferParameteriv(buffer:GlUInt, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glGetNamedBufferParameteri64v")
	public static function getNamedBufferParameteri64v(buffer:GlUInt, pname:GlEnum, params:Pointer<cpp.Int64>):Void;

	@:native("glGetNamedBufferPointerv")
	public static function getNamedBufferPointerv(buffer:GlUInt, pname:GlEnum, params:Pointer<Pointer<cpp.Void>>):Void;

	@:native("glGetNamedBufferSubData")
	public static function getNamedBufferSubData(buffer:GlUInt, offset:GlIntPointer, size:GlSizeIPointer, data:Pointer<cpp.Void>):Void;

	@:native("glCreateFramebuffers")
	public static function createFramebuffers(n:GlSizeI, framebuffers:Star<GlUInt>):Void;

	@:native("glNamedFramebufferRenderbuffer")
	public static function namedFramebufferRenderbuffer(framebuffer:GlUInt, attachment:GlEnum, renderbuffertarget:GlEnum, renderbuffer:GlUInt):Void;

	@:native("glNamedFramebufferParameteri")
	public static function namedFramebufferParameteri(framebuffer:GlUInt, pname:GlEnum, param:GlInt):Void;

	@:native("glNamedFramebufferTexture")
	public static function namedFramebufferTexture(framebuffer:GlUInt, attachment:GlEnum, texture:GlUInt, level:GlInt):Void;

	@:native("glNamedFramebufferTextureLayer")
	public static function namedFramebufferTextureLayer(framebuffer:GlUInt, attachment:GlEnum, texture:GlUInt, level:GlInt, layer:GlInt):Void;

	@:native("glNamedFramebufferDrawBuffer")
	public static function namedFramebufferDrawBuffer(framebuffer:GlUInt, buf:GlEnum):Void;

	@:native("glNamedFramebufferDrawBuffers")
	public static function namedFramebufferDrawBuffers(framebuffer:GlUInt, n:GlSizeI, bufs:ConstStar<GlEnum>):Void;

	@:native("glNamedFramebufferReadBuffer")
	public static function namedFramebufferReadBuffer(framebuffer:GlUInt, src:GlEnum):Void;

	@:native("glInvalidateNamedFramebufferData")
	public static function invalidateNamedFramebufferData(framebuffer:GlUInt, numAttachments:GlSizeI, attachments:ConstStar<GlEnum>):Void;

	@:native("glInvalidateNamedFramebufferSubData")
	public static function invalidateNamedFramebufferSubData(framebuffer:GlUInt, numAttachments:GlSizeI, attachments:ConstStar<GlEnum>, x:GlInt, y:GlInt, width:GlSizeI, height:GlSizeI):Void;

	@:native("glClearNamedFramebufferiv")
	public static function clearNamedFramebufferiv(framebuffer:GlUInt, buffer:GlEnum, drawbuffer:GlInt, value:ConstStar<GlInt>):Void;

	@:native("glClearNamedFramebufferuiv")
	public static function clearNamedFramebufferuiv(framebuffer:GlUInt, buffer:GlEnum, drawbuffer:GlInt, value:ConstStar<GlUInt>):Void;

	@:native("glClearNamedFramebufferfv")
	public static function clearNamedFramebufferfv(framebuffer:GlUInt, buffer:GlEnum, drawbuffer:GlInt, value:ConstStar<GlFloat>):Void;

	@:native("glClearNamedFramebufferfi")
	public static function clearNamedFramebufferfi(framebuffer:GlUInt, buffer:GlEnum, drawbuffer:GlInt, depth:GlFloat, stencil:GlInt):Void;

	@:native("glBlitNamedFramebuffer")
	public static function blitNamedFramebuffer(readFramebuffer:GlUInt, drawFramebuffer:GlUInt, srcX0:GlInt, srcY0:GlInt, srcX1:GlInt, srcY1:GlInt, dstX0:GlInt, dstY0:GlInt, dstX1:GlInt, dstY1:GlInt, mask:GlBitField, filter:GlEnum):Void;

	@:native("glCheckNamedFramebufferStatus")
	public static function checkNamedFramebufferStatus(framebuffer:GlUInt, target:GlEnum):GlEnum;

	@:native("glGetNamedFramebufferParameteriv")
	public static function getNamedFramebufferParameteriv(framebuffer:GlUInt, pname:GlEnum, param:Pointer<GlInt>):Void;

	@:native("glGetNamedFramebufferAttachmentParameteriv")
	public static function getNamedFramebufferAttachmentParameteriv(framebuffer:GlUInt, attachment:GlEnum, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glCreateRenderbuffers")
	public static function createRenderbuffers(n:GlSizeI, renderbuffers:Star<GlUInt>):Void;

	@:native("glNamedRenderbufferStorage")
	public static function namedRenderbufferStorage(renderbuffer:GlUInt, internalformat:GlEnum, width:GlSizeI, height:GlSizeI):Void;

	@:native("glNamedRenderbufferStorageMultisample")
	public static function namedRenderbufferStorageMultisample(renderbuffer:GlUInt, samples:GlSizeI, internalformat:GlEnum, width:GlSizeI, height:GlSizeI):Void;

	@:native("glGetNamedRenderbufferParameteriv")
	public static function getNamedRenderbufferParameteriv(renderbuffer:GlUInt, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glCreateTextures")
	public static function createTextures(target:GlEnum, n:GlSizeI, textures:Star<GlUInt>):Void;

	@:native("glTextureBuffer")
	public static function textureBuffer(texture:GlUInt, internalformat:GlEnum, buffer:GlUInt):Void;

	@:native("glTextureBufferRange")
	public static function textureBufferRange(texture:GlUInt, internalformat:GlEnum, buffer:GlUInt, offset:GlIntPointer, size:GlSizeIPointer):Void;

	@:native("glTextureStorage1D")
	public static function textureStorage1D(texture:GlUInt, levels:GlSizeI, internalformat:GlEnum, width:GlSizeI):Void;

	@:native("glTextureStorage2D")
	public static function textureStorage2D(texture:GlUInt, levels:GlSizeI, internalformat:GlEnum, width:GlSizeI, height:GlSizeI):Void;

	@:native("glTextureStorage3D")
	public static function textureStorage3D(texture:GlUInt, levels:GlSizeI, internalformat:GlEnum, width:GlSizeI, height:GlSizeI, depth:GlSizeI):Void;

	@:native("glTextureStorage2DMultisample")
	public static function textureStorage2DMultisample(texture:GlUInt, samples:GlSizeI, internalformat:GlEnum, width:GlSizeI, height:GlSizeI, fixedsamplelocations:GlBool):Void;

	@:native("glTextureStorage3DMultisample")
	public static function textureStorage3DMultisample(texture:GlUInt, samples:GlSizeI, internalformat:GlEnum, width:GlSizeI, height:GlSizeI, depth:GlSizeI, fixedsamplelocations:GlBool):Void;

	@:native("glTextureSubImage1D")
	public static function textureSubImage1D(texture:GlUInt, level:GlInt, xoffset:GlInt, width:GlSizeI, format:GlEnum, type:GlEnum, pixels:ConstStar<cpp.Void>):Void;

	@:native("glTextureSubImage2D")
	public static function textureSubImage2D(texture:GlUInt, level:GlInt, xoffset:GlInt, yoffset:GlInt, width:GlSizeI, height:GlSizeI, format:GlEnum, type:GlEnum, pixels:ConstStar<cpp.Void>):Void;

	@:native("glTextureSubImage3D")
	public static function textureSubImage3D(texture:GlUInt, level:GlInt, xoffset:GlInt, yoffset:GlInt, zoffset:GlInt, width:GlSizeI, height:GlSizeI, depth:GlSizeI, format:GlEnum, type:GlEnum, pixels:ConstStar<cpp.Void>):Void;

	@:native("glCompressedTextureSubImage1D")
	public static function compressedTextureSubImage1D(texture:GlUInt, level:GlInt, xoffset:GlInt, width:GlSizeI, format:GlEnum, imageSize:GlSizeI, data:ConstStar<cpp.Void>):Void;

	@:native("glCompressedTextureSubImage2D")
	public static function compressedTextureSubImage2D(texture:GlUInt, level:GlInt, xoffset:GlInt, yoffset:GlInt, width:GlSizeI, height:GlSizeI, format:GlEnum, imageSize:GlSizeI, data:ConstStar<cpp.Void>):Void;

	@:native("glCompressedTextureSubImage3D")
	public static function compressedTextureSubImage3D(texture:GlUInt, level:GlInt, xoffset:GlInt, yoffset:GlInt, zoffset:GlInt, width:GlSizeI, height:GlSizeI, depth:GlSizeI, format:GlEnum, imageSize:GlSizeI, data:ConstStar<cpp.Void>):Void;

	@:native("glCopyTextureSubImage1D")
	public static function copyTextureSubImage1D(texture:GlUInt, level:GlInt, xoffset:GlInt, x:GlInt, y:GlInt, width:GlSizeI):Void;

	@:native("glCopyTextureSubImage2D")
	public static function copyTextureSubImage2D(texture:GlUInt, level:GlInt, xoffset:GlInt, yoffset:GlInt, x:GlInt, y:GlInt, width:GlSizeI, height:GlSizeI):Void;

	@:native("glCopyTextureSubImage3D")
	public static function copyTextureSubImage3D(texture:GlUInt, level:GlInt, xoffset:GlInt, yoffset:GlInt, zoffset:GlInt, x:GlInt, y:GlInt, width:GlSizeI, height:GlSizeI):Void;

	@:native("glTextureParameterf")
	public static function textureParameterf(texture:GlUInt, pname:GlEnum, param:GlFloat):Void;

	@:native("glTextureParameterfv")
	public static function textureParameterfv(texture:GlUInt, pname:GlEnum, param:ConstStar<GlFloat>):Void;

	@:native("glTextureParameteri")
	public static function textureParameteri(texture:GlUInt, pname:GlEnum, param:GlInt):Void;

	@:native("glTextureParameterIiv")
	public static function textureParameterIiv(texture:GlUInt, pname:GlEnum, params:ConstStar<GlInt>):Void;

	@:native("glTextureParameterIuiv")
	public static function textureParameterIuiv(texture:GlUInt, pname:GlEnum, params:ConstStar<GlUInt>):Void;

	@:native("glTextureParameteriv")
	public static function textureParameteriv(texture:GlUInt, pname:GlEnum, param:ConstStar<GlInt>):Void;

	@:native("glGenerateTextureMipmap")
	public static function generateTextureMipmap(texture:GlUInt):Void;

	@:native("glBindTextureUnit")
	public static function bindTextureUnit(unit:GlUInt, texture:GlUInt):Void;

	@:native("glGetTextureImage")
	public static function getTextureImage(texture:GlUInt, level:GlInt, format:GlEnum, type:GlEnum, bufSize:GlSizeI, pixels:Pointer<cpp.Void>):Void;

	@:native("glGetCompressedTextureImage")
	public static function getCompressedTextureImage(texture:GlUInt, level:GlInt, bufSize:GlSizeI, pixels:Pointer<cpp.Void>):Void;

	@:native("glGetTextureLevelParameterfv")
	public static function getTextureLevelParameterfv(texture:GlUInt, level:GlInt, pname:GlEnum, params:Pointer<GlFloat>):Void;

	@:native("glGetTextureLevelParameteriv")
	public static function getTextureLevelParameteriv(texture:GlUInt, level:GlInt, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glGetTextureParameterfv")
	public static function getTextureParameterfv(texture:GlUInt, pname:GlEnum, params:Pointer<GlFloat>):Void;

	@:native("glGetTextureParameterIiv")
	public static function getTextureParameterIiv(texture:GlUInt, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glGetTextureParameterIuiv")
	public static function getTextureParameterIuiv(texture:GlUInt, pname:GlEnum, params:Pointer<GlUInt>):Void;

	@:native("glGetTextureParameteriv")
	public static function getTextureParameteriv(texture:GlUInt, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glCreateVertexArrays")
	public static function createVertexArrays(n:GlSizeI, arrays:Star<GlUInt>):Void;

	@:native("glDisableVertexArrayAttrib")
	public static function disableVertexArrayAttrib(vaobj:GlUInt, index:GlUInt):Void;

	@:native("glEnableVertexArrayAttrib")
	public static function enableVertexArrayAttrib(vaobj:GlUInt, index:GlUInt):Void;

	@:native("glVertexArrayElementBuffer")
	public static function vertexArrayElementBuffer(vaobj:GlUInt, buffer:GlUInt):Void;

	@:native("glVertexArrayVertexBuffer")
	public static function vertexArrayVertexBuffer(vaobj:GlUInt, bindingindex:GlUInt, buffer:GlUInt, offset:GlIntPointer, stride:GlSizeI):Void;

	@:native("glVertexArrayVertexBuffers")
	public static function vertexArrayVertexBuffers(vaobj:GlUInt, first:GlUInt, count:GlSizeI, buffers:ConstStar<GlUInt>, offsets:ConstStar<GlIntPointer>, strides:ConstStar<GlSizeI>):Void;

	@:native("glVertexArrayAttribBinding")
	public static function vertexArrayAttribBinding(vaobj:GlUInt, attribindex:GlUInt, bindingindex:GlUInt):Void;

	@:native("glVertexArrayAttribFormat")
	public static function vertexArrayAttribFormat(vaobj:GlUInt, attribindex:GlUInt, size:GlInt, type:GlEnum, normalized:GlBool, relativeoffset:GlUInt):Void;

	@:native("glVertexArrayAttribIFormat")
	public static function vertexArrayAttribIFormat(vaobj:GlUInt, attribindex:GlUInt, size:GlInt, type:GlEnum, relativeoffset:GlUInt):Void;

	@:native("glVertexArrayAttribLFormat")
	public static function vertexArrayAttribLFormat(vaobj:GlUInt, attribindex:GlUInt, size:GlInt, type:GlEnum, relativeoffset:GlUInt):Void;

	@:native("glVertexArrayBindingDivisor")
	public static function vertexArrayBindingDivisor(vaobj:GlUInt, bindingindex:GlUInt, divisor:GlUInt):Void;

	@:native("glGetVertexArrayiv")
	public static function getVertexArrayiv(vaobj:GlUInt, pname:GlEnum, param:Pointer<GlInt>):Void;

	@:native("glGetVertexArrayIndexediv")
	public static function getVertexArrayIndexediv(vaobj:GlUInt, index:GlUInt, pname:GlEnum, param:Pointer<GlInt>):Void;

	@:native("glGetVertexArrayIndexed64iv")
	public static function getVertexArrayIndexed64iv(vaobj:GlUInt, index:GlUInt, pname:GlEnum, param:Pointer<cpp.Int64>):Void;

	@:native("glCreateSamplers")
	public static function createSamplers(n:GlSizeI, samplers:Star<GlUInt>):Void;

	@:native("glCreateProgramPipelines")
	public static function createProgramPipelines(n:GlSizeI, pipelines:Star<GlUInt>):Void;

	@:native("glCreateQueries")
	public static function createQueries(target:GlEnum, n:GlSizeI, ids:Star<GlUInt>):Void;

	@:native("glGetQueryBufferObjecti64v")
	public static function getQueryBufferObjecti64v(id:GlUInt, buffer:GlUInt, pname:GlEnum, offset:GlIntPointer):Void;

	@:native("glGetQueryBufferObjectiv")
	public static function getQueryBufferObjectiv(id:GlUInt, buffer:GlUInt, pname:GlEnum, offset:GlIntPointer):Void;

	@:native("glGetQueryBufferObjectui64v")
	public static function getQueryBufferObjectui64v(id:GlUInt, buffer:GlUInt, pname:GlEnum, offset:GlIntPointer):Void;

	@:native("glGetQueryBufferObjectuiv")
	public static function getQueryBufferObjectuiv(id:GlUInt, buffer:GlUInt, pname:GlEnum, offset:GlIntPointer):Void;

	@:native("glMemoryBarrierByRegion")
	public static function memoryBarrierByRegion(barriers:GlBitField):Void;

	@:native("glGetTextureSubImage")
	public static function getTextureSubImage(texture:GlUInt, level:GlInt, xoffset:GlInt, yoffset:GlInt, zoffset:GlInt, width:GlSizeI, height:GlSizeI, depth:GlSizeI, format:GlEnum, type:GlEnum, bufSize:GlSizeI, pixels:Pointer<cpp.Void>):Void;

	@:native("glGetCompressedTextureSubImage")
	public static function getCompressedTextureSubImage(texture:GlUInt, level:GlInt, xoffset:GlInt, yoffset:GlInt, zoffset:GlInt, width:GlSizeI, height:GlSizeI, depth:GlSizeI, bufSize:GlSizeI, pixels:Pointer<cpp.Void>):Void;

	@:native("glGetGraphicsResetStatus")
	public static function getGraphicsResetStatus():GlEnum;

	@:native("glGetnCompressedTexImage")
	public static function getnCompressedTexImage(target:GlEnum, lod:GlInt, bufSize:GlSizeI, pixels:Pointer<cpp.Void>):Void;

	@:native("glGetnTexImage")
	public static function getnTexImage(target:GlEnum, level:GlInt, format:GlEnum, type:GlEnum, bufSize:GlSizeI, pixels:Pointer<cpp.Void>):Void;

	@:native("glGetnUniformdv")
	public static function getnUniformdv(program:GlUInt, location:GlInt, bufSize:GlSizeI, params:Pointer<GlDouble>):Void;

	@:native("glGetnUniformfv")
	public static function getnUniformfv(program:GlUInt, location:GlInt, bufSize:GlSizeI, params:Pointer<GlFloat>):Void;

	@:native("glGetnUniformiv")
	public static function getnUniformiv(program:GlUInt, location:GlInt, bufSize:GlSizeI, params:Pointer<GlInt>):Void;

	@:native("glGetnUniformuiv")
	public static function getnUniformuiv(program:GlUInt, location:GlInt, bufSize:GlSizeI, params:Pointer<GlUInt>):Void;

	@:native("glReadnPixels")
	public static function readnPixels(x:GlInt, y:GlInt, width:GlSizeI, height:GlSizeI, format:GlEnum, type:GlEnum, bufSize:GlSizeI, data:Star<cpp.Void>):Void;

	@:native("glGetnMapdv")
	public static function getnMapdv(target:GlEnum, query:GlEnum, bufSize:GlSizeI, v:Pointer<GlDouble>):Void;

	@:native("glGetnMapfv")
	public static function getnMapfv(target:GlEnum, query:GlEnum, bufSize:GlSizeI, v:Pointer<GlFloat>):Void;

	@:native("glGetnMapiv")
	public static function getnMapiv(target:GlEnum, query:GlEnum, bufSize:GlSizeI, v:Pointer<GlInt>):Void;

	@:native("glGetnPixelMapfv")
	public static function getnPixelMapfv(map:GlEnum, bufSize:GlSizeI, values:Pointer<GlFloat>):Void;

	@:native("glGetnPixelMapuiv")
	public static function getnPixelMapuiv(map:GlEnum, bufSize:GlSizeI, values:Pointer<GlUInt>):Void;

	@:native("glGetnPixelMapusv")
	public static function getnPixelMapusv(map:GlEnum, bufSize:GlSizeI, values:Pointer<GlUShort>):Void;

	@:native("glGetnPolygonStipple")
	public static function getnPolygonStipple(bufSize:GlSizeI, pattern:Pointer<GlUByte>):Void;

	@:native("glGetnColorTable")
	public static function getnColorTable(target:GlEnum, format:GlEnum, type:GlEnum, bufSize:GlSizeI, table:Pointer<cpp.Void>):Void;

	@:native("glGetnConvolutionFilter")
	public static function getnConvolutionFilter(target:GlEnum, format:GlEnum, type:GlEnum, bufSize:GlSizeI, image:Pointer<cpp.Void>):Void;

	@:native("glGetnSeparableFilter")
	public static function getnSeparableFilter(target:GlEnum, format:GlEnum, type:GlEnum, rowBufSize:GlSizeI, row:Pointer<cpp.Void>, columnBufSize:GlSizeI, column:Pointer<cpp.Void>, span:Pointer<cpp.Void>):Void;

	@:native("glGetnHistogram")
	public static function getnHistogram(target:GlEnum, reset:GlBool, format:GlEnum, type:GlEnum, bufSize:GlSizeI, values:Pointer<cpp.Void>):Void;

	@:native("glGetnMinmax")
	public static function getnMinmax(target:GlEnum, reset:GlBool, format:GlEnum, type:GlEnum, bufSize:GlSizeI, values:Pointer<cpp.Void>):Void;

	@:native("glTextureBarrier")
	public static function textureBarrier():Void;

	@:native("glSpecializeShader")
	public static function specializeShader(shader:GlUInt, pEntryPoint:ConstCharStar, numSpecializationConstants:GlUInt, pConstantIndex:ConstStar<GlUInt>, pConstantValue:ConstStar<GlUInt>):Void;

	@:native("glMultiDrawArraysIndirectCount")
	public static function multiDrawArraysIndirectCount(mode:GlEnum, indirect:ConstStar<cpp.Void>, drawcount:GlIntPointer, maxdrawcount:GlSizeI, stride:GlSizeI):Void;

	@:native("glMultiDrawElementsIndirectCount")
	public static function multiDrawElementsIndirectCount(mode:GlEnum, type:GlEnum, indirect:ConstStar<cpp.Void>, drawcount:GlIntPointer, maxdrawcount:GlSizeI, stride:GlSizeI):Void;

	@:native("glPolygonOffsetClamp")
	public static function polygonOffsetClamp(factor:GlFloat, units:GlFloat, clamp:GlFloat):Void;

	@:native("glAlphaFunc")
	public static function alphaFunc(func:GlEnum, ref:GlFloat):Void;

	@:native("glClipPlanef")
	public static function clipPlanef(p:GlEnum, eqn:ConstStar<GlFloat>):Void;

	@:native("glColor4f")
	public static function color4f(red:GlFloat, green:GlFloat, blue:GlFloat, alpha:GlFloat):Void;

	@:native("glFogf")
	public static function fogf(pname:GlEnum, param:GlFloat):Void;

	@:native("glFogfv")
	public static function fogfv(pname:GlEnum, params:ConstStar<GlFloat>):Void;

	@:native("glFrustumf")
	public static function frustumf(l:GlFloat, r:GlFloat, b:GlFloat, t:GlFloat, n:GlFloat, f:GlFloat):Void;

	@:native("glGetClipPlanef")
	public static function getClipPlanef(plane:GlEnum, equation:Pointer<GlFloat>):Void;

	@:native("glGetLightfv")
	public static function getLightfv(light:GlEnum, pname:GlEnum, params:Pointer<GlFloat>):Void;

	@:native("glGetMaterialfv")
	public static function getMaterialfv(face:GlEnum, pname:GlEnum, params:Pointer<GlFloat>):Void;

	@:native("glGetTexEnvfv")
	public static function getTexEnvfv(target:GlEnum, pname:GlEnum, params:Pointer<GlFloat>):Void;

	@:native("glLightModelf")
	public static function lightModelf(pname:GlEnum, param:GlFloat):Void;

	@:native("glLightModelfv")
	public static function lightModelfv(pname:GlEnum, params:ConstStar<GlFloat>):Void;

	@:native("glLightf")
	public static function lightf(light:GlEnum, pname:GlEnum, param:GlFloat):Void;

	@:native("glLightfv")
	public static function lightfv(light:GlEnum, pname:GlEnum, params:ConstStar<GlFloat>):Void;

	@:native("glLoadMatrixf")
	public static function loadMatrixf(m:ConstStar<GlFloat>):Void;

	@:native("glMaterialf")
	public static function materialf(face:GlEnum, pname:GlEnum, param:GlFloat):Void;

	@:native("glMaterialfv")
	public static function materialfv(face:GlEnum, pname:GlEnum, params:ConstStar<GlFloat>):Void;

	@:native("glMultMatrixf")
	public static function multMatrixf(m:ConstStar<GlFloat>):Void;

	@:native("glMultiTexCoord4f")
	public static function multiTexCoord4f(target:GlEnum, s:GlFloat, t:GlFloat, r:GlFloat, q:GlFloat):Void;

	@:native("glNormal3f")
	public static function normal3f(nx:GlFloat, ny:GlFloat, nz:GlFloat):Void;

	@:native("glOrthof")
	public static function orthof(l:GlFloat, r:GlFloat, b:GlFloat, t:GlFloat, n:GlFloat, f:GlFloat):Void;

	@:native("glRotatef")
	public static function rotatef(angle:GlFloat, x:GlFloat, y:GlFloat, z:GlFloat):Void;

	@:native("glScalef")
	public static function scalef(x:GlFloat, y:GlFloat, z:GlFloat):Void;

	@:native("glTexEnvf")
	public static function texEnvf(target:GlEnum, pname:GlEnum, param:GlFloat):Void;

	@:native("glTexEnvfv")
	public static function texEnvfv(target:GlEnum, pname:GlEnum, params:ConstStar<GlFloat>):Void;

	@:native("glTranslatef")
	public static function translatef(x:GlFloat, y:GlFloat, z:GlFloat):Void;

	@:native("glAlphaFuncx")
	public static function alphaFuncx(func:GlEnum, ref:GlFixed):Void;

	@:native("glClearColorx")
	public static function clearColorx(red:GlFixed, green:GlFixed, blue:GlFixed, alpha:GlFixed):Void;

	@:native("glClearDepthx")
	public static function clearDepthx(depth:GlFixed):Void;

	@:native("glClientActiveTexture")
	public static function clientActiveTexture(texture:GlEnum):Void;

	@:native("glClipPlanex")
	public static function clipPlanex(plane:GlEnum, equation:ConstStar<GlFixed>):Void;

	@:native("glColor4ub")
	public static function color4ub(red:GlUByte, green:GlUByte, blue:GlUByte, alpha:GlUByte):Void;

	@:native("glColor4x")
	public static function color4x(red:GlFixed, green:GlFixed, blue:GlFixed, alpha:GlFixed):Void;

	@:native("glColorPointer")
	public static function colorPointer(size:GlInt, type:GlEnum, stride:GlSizeI, pointer:ConstStar<cpp.Void>):Void;

	@:native("glDepthRangex")
	public static function depthRangex(n:GlFixed, f:GlFixed):Void;

	@:native("glDisableClientState")
	public static function disableClientState(array:GlEnum):Void;

	@:native("glEnableClientState")
	public static function enableClientState(array:GlEnum):Void;

	@:native("glFogx")
	public static function fogx(pname:GlEnum, param:GlFixed):Void;

	@:native("glFogxv")
	public static function fogxv(pname:GlEnum, param:ConstStar<GlFixed>):Void;

	@:native("glFrustumx")
	public static function frustumx(l:GlFixed, r:GlFixed, b:GlFixed, t:GlFixed, n:GlFixed, f:GlFixed):Void;

	@:native("glGetClipPlanex")
	public static function getClipPlanex(plane:GlEnum, equation:Pointer<GlFixed>):Void;

	@:native("glGetFixedv")
	public static function getFixedv(pname:GlEnum, params:Pointer<GlFixed>):Void;

	@:native("glGetLightxv")
	public static function getLightxv(light:GlEnum, pname:GlEnum, params:Pointer<GlFixed>):Void;

	@:native("glGetMaterialxv")
	public static function getMaterialxv(face:GlEnum, pname:GlEnum, params:Pointer<GlFixed>):Void;

	@:native("glGetTexEnviv")
	public static function getTexEnviv(target:GlEnum, pname:GlEnum, params:Pointer<GlInt>):Void;

	@:native("glGetTexEnvxv")
	public static function getTexEnvxv(target:GlEnum, pname:GlEnum, params:Pointer<GlFixed>):Void;

	@:native("glGetTexParameterxv")
	public static function getTexParameterxv(target:GlEnum, pname:GlEnum, params:Pointer<GlFixed>):Void;

	@:native("glLightModelx")
	public static function lightModelx(pname:GlEnum, param:GlFixed):Void;

	@:native("glLightModelxv")
	public static function lightModelxv(pname:GlEnum, param:ConstStar<GlFixed>):Void;

	@:native("glLightx")
	public static function lightx(light:GlEnum, pname:GlEnum, param:GlFixed):Void;

	@:native("glLightxv")
	public static function lightxv(light:GlEnum, pname:GlEnum, params:ConstStar<GlFixed>):Void;

	@:native("glLineWidthx")
	public static function lineWidthx(width:GlFixed):Void;

	@:native("glLoadIdentity")
	public static function loadIdentity():Void;

	@:native("glLoadMatrixx")
	public static function loadMatrixx(m:ConstStar<GlFixed>):Void;

	@:native("glMaterialx")
	public static function materialx(face:GlEnum, pname:GlEnum, param:GlFixed):Void;

	@:native("glMaterialxv")
	public static function materialxv(face:GlEnum, pname:GlEnum, param:ConstStar<GlFixed>):Void;

	@:native("glMatrixMode")
	public static function matrixMode(mode:GlEnum):Void;

	@:native("glMultMatrixx")
	public static function multMatrixx(m:ConstStar<GlFixed>):Void;

	@:native("glMultiTexCoord4x")
	public static function multiTexCoord4x(texture:GlEnum, s:GlFixed, t:GlFixed, r:GlFixed, q:GlFixed):Void;

	@:native("glNormal3x")
	public static function normal3x(nx:GlFixed, ny:GlFixed, nz:GlFixed):Void;

	@:native("glNormalPointer")
	public static function normalPointer(type:GlEnum, stride:GlSizeI, pointer:ConstStar<cpp.Void>):Void;

	@:native("glOrthox")
	public static function orthox(l:GlFixed, r:GlFixed, b:GlFixed, t:GlFixed, n:GlFixed, f:GlFixed):Void;

	@:native("glPointParameterx")
	public static function pointParameterx(pname:GlEnum, param:GlFixed):Void;

	@:native("glPointParameterxv")
	public static function pointParameterxv(pname:GlEnum, params:ConstStar<GlFixed>):Void;

	@:native("glPointSizex")
	public static function pointSizex(size:GlFixed):Void;

	@:native("glPolygonOffsetx")
	public static function polygonOffsetx(factor:GlFixed, units:GlFixed):Void;

	@:native("glPopMatrix")
	public static function popMatrix():Void;

	@:native("glPushMatrix")
	public static function pushMatrix():Void;

	@:native("glRotatex")
	public static function rotatex(angle:GlFixed, x:GlFixed, y:GlFixed, z:GlFixed):Void;

	@:native("glSampleCoveragex")
	public static function sampleCoveragex(value:GlClampX, invert:GlBool):Void;

	@:native("glScalex")
	public static function scalex(x:GlFixed, y:GlFixed, z:GlFixed):Void;

	@:native("glShadeModel")
	public static function shadeModel(mode:GlEnum):Void;

	@:native("glTexCoordPointer")
	public static function texCoordPointer(size:GlInt, type:GlEnum, stride:GlSizeI, pointer:ConstStar<cpp.Void>):Void;

	@:native("glTexEnvi")
	public static function texEnvi(target:GlEnum, pname:GlEnum, param:GlInt):Void;

	@:native("glTexEnvx")
	public static function texEnvx(target:GlEnum, pname:GlEnum, param:GlFixed):Void;

	@:native("glTexEnviv")
	public static function texEnviv(target:GlEnum, pname:GlEnum, params:ConstStar<GlInt>):Void;

	@:native("glTexEnvxv")
	public static function texEnvxv(target:GlEnum, pname:GlEnum, params:ConstStar<GlFixed>):Void;

	@:native("glTexParameterx")
	public static function texParameterx(target:GlEnum, pname:GlEnum, param:GlFixed):Void;

	@:native("glTexParameterxv")
	public static function texParameterxv(target:GlEnum, pname:GlEnum, params:ConstStar<GlFixed>):Void;

	@:native("glTranslatex")
	public static function translatex(x:GlFixed, y:GlFixed, z:GlFixed):Void;

	@:native("glVertexPointer")
	public static function vertexPointer(size:GlInt, type:GlEnum, stride:GlSizeI, pointer:ConstStar<cpp.Void>):Void;

	@:native("glBlendBarrier")
	public static function blendBarrier():Void;

	@:native("glPrimitiveBoundingBox")
	public static function primitiveBoundingBox(minX:GlFloat, minY:GlFloat, minZ:GlFloat, minW:GlFloat, maxX:GlFloat, maxY:GlFloat, maxZ:GlFloat, maxW:GlFloat):Void;
}
#end