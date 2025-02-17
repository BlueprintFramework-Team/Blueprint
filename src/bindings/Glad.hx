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
import cpp.RawPointer;

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
typedef GlIntPointer = RawPointer<Int>;
// typedef khronos_intptr_t GLintptrARB;
typedef GlSizeIPointer = RawPointer<cpp.Int64>;
// typedef khronos_ssize_t GLsizeiptrARB;
typedef GlInt64 = cpp.Int64;
// typedef khronos_int64_t GLint64EXT;
typedef GlUInt64 = cpp.UInt64;
// typedef khronos_uint64_t GLuint64EXT;

@:include("includeWorkaround.h")
@:native("GLsync")
@:structAccess
extern class GlSyncStruct {}
typedef GlSync = RawPointer<GlSyncStruct>;
// struct _cl_context;
// struct _cl_event;

typedef GlDebugProc = Callable<(source:GlEnum, type:GlEnum, severity:GlEnum, length:GlSizeI, message:ConstCharStar, userParam:RawPointer<cpp.Void>) -> Void>;
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
	static inline function loadHelper(loadProc:GladLoadProc):Int {
		return untyped __cpp__("gladLoadGLLoader((GLADloadproc){0})", loadProc);
	}

	/**
	 * NOTE: INSERT A NON-VARIABLE INTERGER FOR `arrayLength`!
	 */
	static inline function bufferFloatArray(target:GlEnum, array:Array<cpp.Float32>, usage:GlEnum, arrayLength:Int):Void {
		return untyped __cpp__(
			"float* _cArray = ((float*)(cpp::Pointer_obj::ofArray({0}).value));
			glBufferData({1}, sizeof(float) * {3}, _cArray, {2})",
		array, target, usage, arrayLength);
	}

	static inline function bufferSubFloatArray(target:GlEnum, offset:GlInt, array:Array<cpp.Float32>, arrayLength:Int):Void {
		return untyped __cpp__(
			"float* _cArray = ((float*)(cpp::Pointer_obj::ofArray({0}).value));
			glBufferSubData({1}, {2}, sizeof(float) * {3}, _cArray)",
		array, target, offset, arrayLength);
	}

	static inline function bufferIntArray(target:GlEnum, array:Array<cpp.UInt32>, usage:GlEnum, arrayLength:Int):Void {
		return untyped __cpp__(
			"unsigned int* _cArray = ((unsigned int*)(cpp::Pointer_obj::ofArray({0}).value));
			glBufferData({1}, sizeof(unsigned int) * {3}, _cArray, {2})",
		array, target, usage, arrayLength);
	}

	static inline function bufferSubIntArray(target:GlEnum, offset:GlInt, array:Array<cpp.UInt32>, arrayLength:Int):Void {
		return untyped __cpp__(
			"unsigned int* _cArray = ((unsigned int*)(cpp::Pointer_obj::ofArray({0}).value));
			glBufferSubData({1}, {2}, sizeof(unsigned int) * {3}, _cArray)",
		array, target, offset, arrayLength);
	}

	static inline function vertexFloatAttrib(varIndex:cpp.UInt32, size:Int, normalized:GlBool, stride:Int, offset:Int):Void {
		return untyped __cpp__("glVertexAttribPointer({0}, {1}, GL_FLOAT, {2}, {3} * sizeof(float), (void*)({4} * sizeof(float)))", varIndex, size, normalized, stride, offset);
	}

    @:native("GLVersion")
    static var version:VersionStruct;

    @:native("gladLoadGL")
    static function loadGL():Int;

    @:native("gladLoadGLLoader")
    static function loadGLLoader(loadProc:GladLoadProc):Int;

    @:native("gladLoadGLES1Loader")
    static function loadGLES1Loader(loadProc:GladLoadProc):Int;

    @:native("gladLoadGLES2Loader")
    static function loadGLES2Loader(loadProc:GladLoadProc):Int;

    @:native("gladLoadGLSC2Loader")
    static function loadGLSC2Loader(loadProc:GladLoadProc):Int;

	@:native("GL_DEPTH_BUFFER_BIT")
	static var DEPTH_BUFFER_BIT:Int;
	@:native("GL_STENCIL_BUFFER_BIT")
	static var STENCIL_BUFFER_BIT:Int;
	@:native("GL_COLOR_BUFFER_BIT")
	static var COLOR_BUFFER_BIT:Int;
	@:native("GL_FALSE")
	static var FALSE:Int;
	@:native("GL_TRUE")
	static var TRUE:Int;
	@:native("GL_POINTS")
	static var POINTS:Int;
	@:native("GL_LINES")
	static var LINES:Int;
	@:native("GL_LINE_LOOP")
	static var LINE_LOOP:Int;
	@:native("GL_LINE_STRIP")
	static var LINE_STRIP:Int;
	@:native("GL_TRIANGLES")
	static var TRIANGLES:Int;
	@:native("GL_TRIANGLE_STRIP")
	static var TRIANGLE_STRIP:Int;
	@:native("GL_TRIANGLE_FAN")
	static var TRIANGLE_FAN:Int;
	@:native("GL_NEVER")
	static var NEVER:Int;
	@:native("GL_LESS")
	static var LESS:Int;
	@:native("GL_EQUAL")
	static var EQUAL:Int;
	@:native("GL_LEQUAL")
	static var LEQUAL:Int;
	@:native("GL_GREATER")
	static var GREATER:Int;
	@:native("GL_NOTEQUAL")
	static var NOTEQUAL:Int;
	@:native("GL_GEQUAL")
	static var GEQUAL:Int;
	@:native("GL_ALWAYS")
	static var ALWAYS:Int;
	@:native("GL_ZERO")
	static var ZERO:Int;
	@:native("GL_ONE")
	static var ONE:Int;
	@:native("GL_SRC_COLOR")
	static var SRC_COLOR:Int;
	@:native("GL_ONE_MINUS_SRC_COLOR")
	static var ONE_MINUS_SRC_COLOR:Int;
	@:native("GL_SRC_ALPHA")
	static var SRC_ALPHA:Int;
	@:native("GL_ONE_MINUS_SRC_ALPHA")
	static var ONE_MINUS_SRC_ALPHA:Int;
	@:native("GL_DST_ALPHA")
	static var DST_ALPHA:Int;
	@:native("GL_ONE_MINUS_DST_ALPHA")
	static var ONE_MINUS_DST_ALPHA:Int;
	@:native("GL_DST_COLOR")
	static var DST_COLOR:Int;
	@:native("GL_ONE_MINUS_DST_COLOR")
	static var ONE_MINUS_DST_COLOR:Int;
	@:native("GL_SRC_ALPHA_SATURATE")
	static var SRC_ALPHA_SATURATE:Int;
	@:native("GL_NONE")
	static var NONE:Int;
	@:native("GL_FRONT_LEFT")
	static var FRONT_LEFT:Int;
	@:native("GL_FRONT_RIGHT")
	static var FRONT_RIGHT:Int;
	@:native("GL_BACK_LEFT")
	static var BACK_LEFT:Int;
	@:native("GL_BACK_RIGHT")
	static var BACK_RIGHT:Int;
	@:native("GL_FRONT")
	static var FRONT:Int;
	@:native("GL_BACK")
	static var BACK:Int;
	@:native("GL_LEFT")
	static var LEFT:Int;
	@:native("GL_RIGHT")
	static var RIGHT:Int;
	@:native("GL_FRONT_AND_BACK")
	static var FRONT_AND_BACK:Int;
	@:native("GL_NO_ERROR")
	static var NO_ERROR:Int;
	@:native("GL_INVALID_ENUM")
	static var INVALID_ENUM:Int;
	@:native("GL_INVALID_VALUE")
	static var INVALID_VALUE:Int;
	@:native("GL_INVALID_OPERATION")
	static var INVALID_OPERATION:Int;
	@:native("GL_OUT_OF_MEMORY")
	static var OUT_OF_MEMORY:Int;
	@:native("GL_CW")
	static var CW:Int;
	@:native("GL_CCW")
	static var CCW:Int;
	@:native("GL_POINT_SIZE")
	static var POINT_SIZE:Int;
	@:native("GL_POINT_SIZE_RANGE")
	static var POINT_SIZE_RANGE:Int;
	@:native("GL_POINT_SIZE_GRANULARITY")
	static var POINT_SIZE_GRANULARITY:Int;
	@:native("GL_LINE_SMOOTH")
	static var LINE_SMOOTH:Int;
	@:native("GL_LINE_WIDTH")
	static var LINE_WIDTH:Int;
	@:native("GL_LINE_WIDTH_RANGE")
	static var LINE_WIDTH_RANGE:Int;
	@:native("GL_LINE_WIDTH_GRANULARITY")
	static var LINE_WIDTH_GRANULARITY:Int;
	@:native("GL_POLYGON_MODE")
	static var POLYGON_MODE:Int;
	@:native("GL_POLYGON_SMOOTH")
	static var POLYGON_SMOOTH:Int;
	@:native("GL_CULL_FACE")
	static var CULL_FACE:Int;
	@:native("GL_CULL_FACE_MODE")
	static var CULL_FACE_MODE:Int;
	@:native("GL_FRONT_FACE")
	static var FRONT_FACE:Int;
	@:native("GL_DEPTH_RANGE")
	static var DEPTH_RANGE:Int;
	@:native("GL_DEPTH_TEST")
	static var DEPTH_TEST:Int;
	@:native("GL_DEPTH_WRITEMASK")
	static var DEPTH_WRITEMASK:Int;
	@:native("GL_DEPTH_CLEAR_VALUE")
	static var DEPTH_CLEAR_VALUE:Int;
	@:native("GL_DEPTH_FUNC")
	static var DEPTH_FUNC:Int;
	@:native("GL_STENCIL_TEST")
	static var STENCIL_TEST:Int;
	@:native("GL_STENCIL_CLEAR_VALUE")
	static var STENCIL_CLEAR_VALUE:Int;
	@:native("GL_STENCIL_FUNC")
	static var STENCIL_FUNC:Int;
	@:native("GL_STENCIL_VALUE_MASK")
	static var STENCIL_VALUE_MASK:Int;
	@:native("GL_STENCIL_FAIL")
	static var STENCIL_FAIL:Int;
	@:native("GL_STENCIL_PASS_DEPTH_FAIL")
	static var STENCIL_PASS_DEPTH_FAIL:Int;
	@:native("GL_STENCIL_PASS_DEPTH_PASS")
	static var STENCIL_PASS_DEPTH_PASS:Int;
	@:native("GL_STENCIL_REF")
	static var STENCIL_REF:Int;
	@:native("GL_STENCIL_WRITEMASK")
	static var STENCIL_WRITEMASK:Int;
	@:native("GL_VIEWPORT")
	static var VIEWPORT:Int;
	@:native("GL_DITHER")
	static var DITHER:Int;
	@:native("GL_BLEND_DST")
	static var BLEND_DST:Int;
	@:native("GL_BLEND_SRC")
	static var BLEND_SRC:Int;
	@:native("GL_BLEND")
	static var BLEND:Int;
	@:native("GL_LOGIC_OP_MODE")
	static var LOGIC_OP_MODE:Int;
	@:native("GL_DRAW_BUFFER")
	static var DRAW_BUFFER:Int;
	@:native("GL_READ_BUFFER")
	static var READ_BUFFER:Int;
	@:native("GL_SCISSOR_BOX")
	static var SCISSOR_BOX:Int;
	@:native("GL_SCISSOR_TEST")
	static var SCISSOR_TEST:Int;
	@:native("GL_COLOR_CLEAR_VALUE")
	static var COLOR_CLEAR_VALUE:Int;
	@:native("GL_COLOR_WRITEMASK")
	static var COLOR_WRITEMASK:Int;
	@:native("GL_DOUBLEBUFFER")
	static var DOUBLEBUFFER:Int;
	@:native("GL_STEREO")
	static var STEREO:Int;
	@:native("GL_LINE_SMOOTH_HINT")
	static var LINE_SMOOTH_HINT:Int;
	@:native("GL_POLYGON_SMOOTH_HINT")
	static var POLYGON_SMOOTH_HINT:Int;
	@:native("GL_UNPACK_SWAP_BYTES")
	static var UNPACK_SWAP_BYTES:Int;
	@:native("GL_UNPACK_LSB_FIRST")
	static var UNPACK_LSB_FIRST:Int;
	@:native("GL_UNPACK_ROW_LENGTH")
	static var UNPACK_ROW_LENGTH:Int;
	@:native("GL_UNPACK_SKIP_ROWS")
	static var UNPACK_SKIP_ROWS:Int;
	@:native("GL_UNPACK_SKIP_PIXELS")
	static var UNPACK_SKIP_PIXELS:Int;
	@:native("GL_UNPACK_ALIGNMENT")
	static var UNPACK_ALIGNMENT:Int;
	@:native("GL_PACK_SWAP_BYTES")
	static var PACK_SWAP_BYTES:Int;
	@:native("GL_PACK_LSB_FIRST")
	static var PACK_LSB_FIRST:Int;
	@:native("GL_PACK_ROW_LENGTH")
	static var PACK_ROW_LENGTH:Int;
	@:native("GL_PACK_SKIP_ROWS")
	static var PACK_SKIP_ROWS:Int;
	@:native("GL_PACK_SKIP_PIXELS")
	static var PACK_SKIP_PIXELS:Int;
	@:native("GL_PACK_ALIGNMENT")
	static var PACK_ALIGNMENT:Int;
	@:native("GL_MAX_TEXTURE_SIZE")
	static var MAX_TEXTURE_SIZE:Int;
	@:native("GL_MAX_VIEWPORT_DIMS")
	static var MAX_VIEWPORT_DIMS:Int;
	@:native("GL_SUBPIXEL_BITS")
	static var SUBPIXEL_BITS:Int;
	@:native("GL_TEXTURE_1D")
	static var TEXTURE_1D:Int;
	@:native("GL_TEXTURE_2D")
	static var TEXTURE_2D:Int;
	@:native("GL_TEXTURE_WIDTH")
	static var TEXTURE_WIDTH:Int;
	@:native("GL_TEXTURE_HEIGHT")
	static var TEXTURE_HEIGHT:Int;
	@:native("GL_TEXTURE_BORDER_COLOR")
	static var TEXTURE_BORDER_COLOR:Int;
	@:native("GL_DONT_CARE")
	static var DONT_CARE:Int;
	@:native("GL_FASTEST")
	static var FASTEST:Int;
	@:native("GL_NICEST")
	static var NICEST:Int;
	@:native("GL_BYTE")
	static var BYTE:Int;
	@:native("GL_UNSIGNED_BYTE")
	static var UNSIGNED_BYTE:Int;
	@:native("GL_SHORT")
	static var SHORT:Int;
	@:native("GL_UNSIGNED_SHORT")
	static var UNSIGNED_SHORT:Int;
	@:native("GL_INT")
	static var INT:Int;
	@:native("GL_UNSIGNED_INT")
	static var UNSIGNED_INT:Int;
	@:native("GL_FLOAT")
	static var FLOAT:Int;
	@:native("GL_CLEAR")
	static var CLEAR:Int;
	@:native("GL_AND")
	static var AND:Int;
	@:native("GL_AND_REVERSE")
	static var AND_REVERSE:Int;
	@:native("GL_COPY")
	static var COPY:Int;
	@:native("GL_AND_INVERTED")
	static var AND_INVERTED:Int;
	@:native("GL_NOOP")
	static var NOOP:Int;
	@:native("GL_XOR")
	static var XOR:Int;
	@:native("GL_OR")
	static var OR:Int;
	@:native("GL_NOR")
	static var NOR:Int;
	@:native("GL_EQUIV")
	static var EQUIV:Int;
	@:native("GL_INVERT")
	static var INVERT:Int;
	@:native("GL_OR_REVERSE")
	static var OR_REVERSE:Int;
	@:native("GL_COPY_INVERTED")
	static var COPY_INVERTED:Int;
	@:native("GL_OR_INVERTED")
	static var OR_INVERTED:Int;
	@:native("GL_NAND")
	static var NAND:Int;
	@:native("GL_SET")
	static var SET:Int;
	@:native("GL_TEXTURE")
	static var TEXTURE:Int;
	@:native("GL_COLOR")
	static var COLOR:Int;
	@:native("GL_DEPTH")
	static var DEPTH:Int;
	@:native("GL_STENCIL")
	static var STENCIL:Int;
	@:native("GL_STENCIL_INDEX")
	static var STENCIL_INDEX:Int;
	@:native("GL_DEPTH_COMPONENT")
	static var DEPTH_COMPONENT:Int;
	@:native("GL_RED")
	static var RED:Int;
	@:native("GL_GREEN")
	static var GREEN:Int;
	@:native("GL_BLUE")
	static var BLUE:Int;
	@:native("GL_ALPHA")
	static var ALPHA:Int;
	@:native("GL_RGB")
	static var RGB:Int;
	@:native("GL_RGBA")
	static var RGBA:Int;
	@:native("GL_POINT")
	static var POINT:Int;
	@:native("GL_LINE")
	static var LINE:Int;
	@:native("GL_FILL")
	static var FILL:Int;
	@:native("GL_KEEP")
	static var KEEP:Int;
	@:native("GL_REPLACE")
	static var REPLACE:Int;
	@:native("GL_INCR")
	static var INCR:Int;
	@:native("GL_DECR")
	static var DECR:Int;
	@:native("GL_VENDOR")
	static var VENDOR:Int;
	@:native("GL_RENDERER")
	static var RENDERER:Int;
	@:native("GL_VERSION")
	static var VERSION:Int;
	@:native("GL_EXTENSIONS")
	static var EXTENSIONS:Int;
	@:native("GL_NEAREST")
	static var NEAREST:Int;
	@:native("GL_LINEAR")
	static var LINEAR:Int;
	@:native("GL_NEAREST_MIPMAP_NEAREST")
	static var NEAREST_MIPMAP_NEAREST:Int;
	@:native("GL_LINEAR_MIPMAP_NEAREST")
	static var LINEAR_MIPMAP_NEAREST:Int;
	@:native("GL_NEAREST_MIPMAP_LINEAR")
	static var NEAREST_MIPMAP_LINEAR:Int;
	@:native("GL_LINEAR_MIPMAP_LINEAR")
	static var LINEAR_MIPMAP_LINEAR:Int;
	@:native("GL_TEXTURE_MAG_FILTER")
	static var TEXTURE_MAG_FILTER:Int;
	@:native("GL_TEXTURE_MIN_FILTER")
	static var TEXTURE_MIN_FILTER:Int;
	@:native("GL_TEXTURE_WRAP_S")
	static var TEXTURE_WRAP_S:Int;
	@:native("GL_TEXTURE_WRAP_T")
	static var TEXTURE_WRAP_T:Int;
	@:native("GL_REPEAT")
	static var REPEAT:Int;
	@:native("GL_COLOR_LOGIC_OP")
	static var COLOR_LOGIC_OP:Int;
	@:native("GL_POLYGON_OFFSET_UNITS")
	static var POLYGON_OFFSET_UNITS:Int;
	@:native("GL_POLYGON_OFFSET_POINT")
	static var POLYGON_OFFSET_POINT:Int;
	@:native("GL_POLYGON_OFFSET_LINE")
	static var POLYGON_OFFSET_LINE:Int;
	@:native("GL_POLYGON_OFFSET_FILL")
	static var POLYGON_OFFSET_FILL:Int;
	@:native("GL_POLYGON_OFFSET_FACTOR")
	static var POLYGON_OFFSET_FACTOR:Int;
	@:native("GL_TEXTURE_BINDING_1D")
	static var TEXTURE_BINDING_1D:Int;
	@:native("GL_TEXTURE_BINDING_2D")
	static var TEXTURE_BINDING_2D:Int;
	@:native("GL_TEXTURE_INTERNAL_FORMAT")
	static var TEXTURE_INTERNAL_FORMAT:Int;
	@:native("GL_TEXTURE_RED_SIZE")
	static var TEXTURE_RED_SIZE:Int;
	@:native("GL_TEXTURE_GREEN_SIZE")
	static var TEXTURE_GREEN_SIZE:Int;
	@:native("GL_TEXTURE_BLUE_SIZE")
	static var TEXTURE_BLUE_SIZE:Int;
	@:native("GL_TEXTURE_ALPHA_SIZE")
	static var TEXTURE_ALPHA_SIZE:Int;
	@:native("GL_DOUBLE")
	static var DOUBLE:Int;
	@:native("GL_PROXY_TEXTURE_1D")
	static var PROXY_TEXTURE_1D:Int;
	@:native("GL_PROXY_TEXTURE_2D")
	static var PROXY_TEXTURE_2D:Int;
	@:native("GL_R3_G3_B2")
	static var R3_G3_B2:Int;
	@:native("GL_RGB4")
	static var RGB4:Int;
	@:native("GL_RGB5")
	static var RGB5:Int;
	@:native("GL_RGB8")
	static var RGB8:Int;
	@:native("GL_RGB10")
	static var RGB10:Int;
	@:native("GL_RGB12")
	static var RGB12:Int;
	@:native("GL_RGB16")
	static var RGB16:Int;
	@:native("GL_RGBA2")
	static var RGBA2:Int;
	@:native("GL_RGBA4")
	static var RGBA4:Int;
	@:native("GL_RGB5_A1")
	static var RGB5_A1:Int;
	@:native("GL_RGBA8")
	static var RGBA8:Int;
	@:native("GL_RGB10_A2")
	static var RGB10_A2:Int;
	@:native("GL_RGBA12")
	static var RGBA12:Int;
	@:native("GL_RGBA16")
	static var RGBA16:Int;
	@:native("GL_UNSIGNED_BYTE_3_3_2")
	static var UNSIGNED_BYTE_3_3_2:Int;
	@:native("GL_UNSIGNED_SHORT_4_4_4_4")
	static var UNSIGNED_SHORT_4_4_4_4:Int;
	@:native("GL_UNSIGNED_SHORT_5_5_5_1")
	static var UNSIGNED_SHORT_5_5_5_1:Int;
	@:native("GL_UNSIGNED_INT_8_8_8_8")
	static var UNSIGNED_INT_8_8_8_8:Int;
	@:native("GL_UNSIGNED_INT_10_10_10_2")
	static var UNSIGNED_INT_10_10_10_2:Int;
	@:native("GL_TEXTURE_BINDING_3D")
	static var TEXTURE_BINDING_3D:Int;
	@:native("GL_PACK_SKIP_IMAGES")
	static var PACK_SKIP_IMAGES:Int;
	@:native("GL_PACK_IMAGE_HEIGHT")
	static var PACK_IMAGE_HEIGHT:Int;
	@:native("GL_UNPACK_SKIP_IMAGES")
	static var UNPACK_SKIP_IMAGES:Int;
	@:native("GL_UNPACK_IMAGE_HEIGHT")
	static var UNPACK_IMAGE_HEIGHT:Int;
	@:native("GL_TEXTURE_3D")
	static var TEXTURE_3D:Int;
	@:native("GL_PROXY_TEXTURE_3D")
	static var PROXY_TEXTURE_3D:Int;
	@:native("GL_TEXTURE_DEPTH")
	static var TEXTURE_DEPTH:Int;
	@:native("GL_TEXTURE_WRAP_R")
	static var TEXTURE_WRAP_R:Int;
	@:native("GL_MAX_3D_TEXTURE_SIZE")
	static var MAX_3D_TEXTURE_SIZE:Int;
	@:native("GL_UNSIGNED_BYTE_2_3_3_REV")
	static var UNSIGNED_BYTE_2_3_3_REV:Int;
	@:native("GL_UNSIGNED_SHORT_5_6_5")
	static var UNSIGNED_SHORT_5_6_5:Int;
	@:native("GL_UNSIGNED_SHORT_5_6_5_REV")
	static var UNSIGNED_SHORT_5_6_5_REV:Int;
	@:native("GL_UNSIGNED_SHORT_4_4_4_4_REV")
	static var UNSIGNED_SHORT_4_4_4_4_REV:Int;
	@:native("GL_UNSIGNED_SHORT_1_5_5_5_REV")
	static var UNSIGNED_SHORT_1_5_5_5_REV:Int;
	@:native("GL_UNSIGNED_INT_8_8_8_8_REV")
	static var UNSIGNED_INT_8_8_8_8_REV:Int;
	@:native("GL_UNSIGNED_INT_2_10_10_10_REV")
	static var UNSIGNED_INT_2_10_10_10_REV:Int;
	@:native("GL_BGR")
	static var BGR:Int;
	@:native("GL_BGRA")
	static var BGRA:Int;
	@:native("GL_MAX_ELEMENTS_VERTICES")
	static var MAX_ELEMENTS_VERTICES:Int;
	@:native("GL_MAX_ELEMENTS_INDICES")
	static var MAX_ELEMENTS_INDICES:Int;
	@:native("GL_CLAMP_TO_EDGE")
	static var CLAMP_TO_EDGE:Int;
	@:native("GL_TEXTURE_MIN_LOD")
	static var TEXTURE_MIN_LOD:Int;
	@:native("GL_TEXTURE_MAX_LOD")
	static var TEXTURE_MAX_LOD:Int;
	@:native("GL_TEXTURE_BASE_LEVEL")
	static var TEXTURE_BASE_LEVEL:Int;
	@:native("GL_TEXTURE_MAX_LEVEL")
	static var TEXTURE_MAX_LEVEL:Int;
	@:native("GL_SMOOTH_POINT_SIZE_RANGE")
	static var SMOOTH_POINT_SIZE_RANGE:Int;
	@:native("GL_SMOOTH_POINT_SIZE_GRANULARITY")
	static var SMOOTH_POINT_SIZE_GRANULARITY:Int;
	@:native("GL_SMOOTH_LINE_WIDTH_RANGE")
	static var SMOOTH_LINE_WIDTH_RANGE:Int;
	@:native("GL_SMOOTH_LINE_WIDTH_GRANULARITY")
	static var SMOOTH_LINE_WIDTH_GRANULARITY:Int;
	@:native("GL_ALIASED_LINE_WIDTH_RANGE")
	static var ALIASED_LINE_WIDTH_RANGE:Int;
	@:native("GL_TEXTURE0")
	static var TEXTURE0:Int;
	@:native("GL_TEXTURE1")
	static var TEXTURE1:Int;
	@:native("GL_TEXTURE2")
	static var TEXTURE2:Int;
	@:native("GL_TEXTURE3")
	static var TEXTURE3:Int;
	@:native("GL_TEXTURE4")
	static var TEXTURE4:Int;
	@:native("GL_TEXTURE5")
	static var TEXTURE5:Int;
	@:native("GL_TEXTURE6")
	static var TEXTURE6:Int;
	@:native("GL_TEXTURE7")
	static var TEXTURE7:Int;
	@:native("GL_TEXTURE8")
	static var TEXTURE8:Int;
	@:native("GL_TEXTURE9")
	static var TEXTURE9:Int;
	@:native("GL_TEXTURE10")
	static var TEXTURE10:Int;
	@:native("GL_TEXTURE11")
	static var TEXTURE11:Int;
	@:native("GL_TEXTURE12")
	static var TEXTURE12:Int;
	@:native("GL_TEXTURE13")
	static var TEXTURE13:Int;
	@:native("GL_TEXTURE14")
	static var TEXTURE14:Int;
	@:native("GL_TEXTURE15")
	static var TEXTURE15:Int;
	@:native("GL_TEXTURE16")
	static var TEXTURE16:Int;
	@:native("GL_TEXTURE17")
	static var TEXTURE17:Int;
	@:native("GL_TEXTURE18")
	static var TEXTURE18:Int;
	@:native("GL_TEXTURE19")
	static var TEXTURE19:Int;
	@:native("GL_TEXTURE20")
	static var TEXTURE20:Int;
	@:native("GL_TEXTURE21")
	static var TEXTURE21:Int;
	@:native("GL_TEXTURE22")
	static var TEXTURE22:Int;
	@:native("GL_TEXTURE23")
	static var TEXTURE23:Int;
	@:native("GL_TEXTURE24")
	static var TEXTURE24:Int;
	@:native("GL_TEXTURE25")
	static var TEXTURE25:Int;
	@:native("GL_TEXTURE26")
	static var TEXTURE26:Int;
	@:native("GL_TEXTURE27")
	static var TEXTURE27:Int;
	@:native("GL_TEXTURE28")
	static var TEXTURE28:Int;
	@:native("GL_TEXTURE29")
	static var TEXTURE29:Int;
	@:native("GL_TEXTURE30")
	static var TEXTURE30:Int;
	@:native("GL_TEXTURE31")
	static var TEXTURE31:Int;
	@:native("GL_ACTIVE_TEXTURE")
	static var ACTIVE_TEXTURE:Int;
	@:native("GL_MULTISAMPLE")
	static var MULTISAMPLE:Int;
	@:native("GL_SAMPLE_ALPHA_TO_COVERAGE")
	static var SAMPLE_ALPHA_TO_COVERAGE:Int;
	@:native("GL_SAMPLE_ALPHA_TO_ONE")
	static var SAMPLE_ALPHA_TO_ONE:Int;
	@:native("GL_SAMPLE_COVERAGE")
	static var SAMPLE_COVERAGE:Int;
	@:native("GL_SAMPLE_BUFFERS")
	static var SAMPLE_BUFFERS:Int;
	@:native("GL_SAMPLES")
	static var SAMPLES:Int;
	@:native("GL_SAMPLE_COVERAGE_VALUE")
	static var SAMPLE_COVERAGE_VALUE:Int;
	@:native("GL_SAMPLE_COVERAGE_INVERT")
	static var SAMPLE_COVERAGE_INVERT:Int;
	@:native("GL_TEXTURE_CUBE_MAP")
	static var TEXTURE_CUBE_MAP:Int;
	@:native("GL_TEXTURE_BINDING_CUBE_MAP")
	static var TEXTURE_BINDING_CUBE_MAP:Int;
	@:native("GL_TEXTURE_CUBE_MAP_POSITIVE_X")
	static var TEXTURE_CUBE_MAP_POSITIVE_X:Int;
	@:native("GL_TEXTURE_CUBE_MAP_NEGATIVE_X")
	static var TEXTURE_CUBE_MAP_NEGATIVE_X:Int;
	@:native("GL_TEXTURE_CUBE_MAP_POSITIVE_Y")
	static var TEXTURE_CUBE_MAP_POSITIVE_Y:Int;
	@:native("GL_TEXTURE_CUBE_MAP_NEGATIVE_Y")
	static var TEXTURE_CUBE_MAP_NEGATIVE_Y:Int;
	@:native("GL_TEXTURE_CUBE_MAP_POSITIVE_Z")
	static var TEXTURE_CUBE_MAP_POSITIVE_Z:Int;
	@:native("GL_TEXTURE_CUBE_MAP_NEGATIVE_Z")
	static var TEXTURE_CUBE_MAP_NEGATIVE_Z:Int;
	@:native("GL_PROXY_TEXTURE_CUBE_MAP")
	static var PROXY_TEXTURE_CUBE_MAP:Int;
	@:native("GL_MAX_CUBE_MAP_TEXTURE_SIZE")
	static var MAX_CUBE_MAP_TEXTURE_SIZE:Int;
	@:native("GL_COMPRESSED_RGB")
	static var COMPRESSED_RGB:Int;
	@:native("GL_COMPRESSED_RGBA")
	static var COMPRESSED_RGBA:Int;
	@:native("GL_TEXTURE_COMPRESSION_HINT")
	static var TEXTURE_COMPRESSION_HINT:Int;
	@:native("GL_TEXTURE_COMPRESSED_IMAGE_SIZE")
	static var TEXTURE_COMPRESSED_IMAGE_SIZE:Int;
	@:native("GL_TEXTURE_COMPRESSED")
	static var TEXTURE_COMPRESSED:Int;
	@:native("GL_NUM_COMPRESSED_TEXTURE_FORMATS")
	static var NUM_COMPRESSED_TEXTURE_FORMATS:Int;
	@:native("GL_COMPRESSED_TEXTURE_FORMATS")
	static var COMPRESSED_TEXTURE_FORMATS:Int;
	@:native("GL_CLAMP_TO_BORDER")
	static var CLAMP_TO_BORDER:Int;
	@:native("GL_BLEND_DST_RGB")
	static var BLEND_DST_RGB:Int;
	@:native("GL_BLEND_SRC_RGB")
	static var BLEND_SRC_RGB:Int;
	@:native("GL_BLEND_DST_ALPHA")
	static var BLEND_DST_ALPHA:Int;
	@:native("GL_BLEND_SRC_ALPHA")
	static var BLEND_SRC_ALPHA:Int;
	@:native("GL_POINT_FADE_THRESHOLD_SIZE")
	static var POINT_FADE_THRESHOLD_SIZE:Int;
	@:native("GL_DEPTH_COMPONENT16")
	static var DEPTH_COMPONENT16:Int;
	@:native("GL_DEPTH_COMPONENT24")
	static var DEPTH_COMPONENT24:Int;
	@:native("GL_DEPTH_COMPONENT32")
	static var DEPTH_COMPONENT32:Int;
	@:native("GL_MIRRORED_REPEAT")
	static var MIRRORED_REPEAT:Int;
	@:native("GL_MAX_TEXTURE_LOD_BIAS")
	static var MAX_TEXTURE_LOD_BIAS:Int;
	@:native("GL_TEXTURE_LOD_BIAS")
	static var TEXTURE_LOD_BIAS:Int;
	@:native("GL_INCR_WRAP")
	static var INCR_WRAP:Int;
	@:native("GL_DECR_WRAP")
	static var DECR_WRAP:Int;
	@:native("GL_TEXTURE_DEPTH_SIZE")
	static var TEXTURE_DEPTH_SIZE:Int;
	@:native("GL_TEXTURE_COMPARE_MODE")
	static var TEXTURE_COMPARE_MODE:Int;
	@:native("GL_TEXTURE_COMPARE_FUNC")
	static var TEXTURE_COMPARE_FUNC:Int;
	@:native("GL_BLEND_COLOR")
	static var BLEND_COLOR:Int;
	@:native("GL_BLEND_EQUATION")
	static var BLEND_EQUATION:Int;
	@:native("GL_CONSTANT_COLOR")
	static var CONSTANT_COLOR:Int;
	@:native("GL_ONE_MINUS_CONSTANT_COLOR")
	static var ONE_MINUS_CONSTANT_COLOR:Int;
	@:native("GL_CONSTANT_ALPHA")
	static var CONSTANT_ALPHA:Int;
	@:native("GL_ONE_MINUS_CONSTANT_ALPHA")
	static var ONE_MINUS_CONSTANT_ALPHA:Int;
	@:native("GL_FUNC_ADD")
	static var FUNC_ADD:Int;
	@:native("GL_FUNC_REVERSE_SUBTRACT")
	static var FUNC_REVERSE_SUBTRACT:Int;
	@:native("GL_FUNC_SUBTRACT")
	static var FUNC_SUBTRACT:Int;
	@:native("GL_MIN")
	static var MIN:Int;
	@:native("GL_MAX")
	static var MAX:Int;
	@:native("GL_BUFFER_SIZE")
	static var BUFFER_SIZE:Int;
	@:native("GL_BUFFER_USAGE")
	static var BUFFER_USAGE:Int;
	@:native("GL_QUERY_COUNTER_BITS")
	static var QUERY_COUNTER_BITS:Int;
	@:native("GL_CURRENT_QUERY")
	static var CURRENT_QUERY:Int;
	@:native("GL_QUERY_RESULT")
	static var QUERY_RESULT:Int;
	@:native("GL_QUERY_RESULT_AVAILABLE")
	static var QUERY_RESULT_AVAILABLE:Int;
	@:native("GL_ARRAY_BUFFER")
	static var ARRAY_BUFFER:Int;
	@:native("GL_ELEMENT_ARRAY_BUFFER")
	static var ELEMENT_ARRAY_BUFFER:Int;
	@:native("GL_ARRAY_BUFFER_BINDING")
	static var ARRAY_BUFFER_BINDING:Int;
	@:native("GL_ELEMENT_ARRAY_BUFFER_BINDING")
	static var ELEMENT_ARRAY_BUFFER_BINDING:Int;
	@:native("GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING")
	static var VERTEX_ATTRIB_ARRAY_BUFFER_BINDING:Int;
	@:native("GL_READ_ONLY")
	static var READ_ONLY:Int;
	@:native("GL_WRITE_ONLY")
	static var WRITE_ONLY:Int;
	@:native("GL_READ_WRITE")
	static var READ_WRITE:Int;
	@:native("GL_BUFFER_ACCESS")
	static var BUFFER_ACCESS:Int;
	@:native("GL_BUFFER_MAPPED")
	static var BUFFER_MAPPED:Int;
	@:native("GL_BUFFER_MAP_POINTER")
	static var BUFFER_MAP_POINTER:Int;
	@:native("GL_STREAM_DRAW")
	static var STREAM_DRAW:Int;
	@:native("GL_STREAM_READ")
	static var STREAM_READ:Int;
	@:native("GL_STREAM_COPY")
	static var STREAM_COPY:Int;
	@:native("GL_STATIC_DRAW")
	static var STATIC_DRAW:Int;
	@:native("GL_STATIC_READ")
	static var STATIC_READ:Int;
	@:native("GL_STATIC_COPY")
	static var STATIC_COPY:Int;
	@:native("GL_DYNAMIC_DRAW")
	static var DYNAMIC_DRAW:Int;
	@:native("GL_DYNAMIC_READ")
	static var DYNAMIC_READ:Int;
	@:native("GL_DYNAMIC_COPY")
	static var DYNAMIC_COPY:Int;
	@:native("GL_SAMPLES_PASSED")
	static var SAMPLES_PASSED:Int;
	@:native("GL_SRC1_ALPHA")
	static var SRC1_ALPHA:Int;
	@:native("GL_BLEND_EQUATION_RGB")
	static var BLEND_EQUATION_RGB:Int;
	@:native("GL_VERTEX_ATTRIB_ARRAY_ENABLED")
	static var VERTEX_ATTRIB_ARRAY_ENABLED:Int;
	@:native("GL_VERTEX_ATTRIB_ARRAY_SIZE")
	static var VERTEX_ATTRIB_ARRAY_SIZE:Int;
	@:native("GL_VERTEX_ATTRIB_ARRAY_STRIDE")
	static var VERTEX_ATTRIB_ARRAY_STRIDE:Int;
	@:native("GL_VERTEX_ATTRIB_ARRAY_TYPE")
	static var VERTEX_ATTRIB_ARRAY_TYPE:Int;
	@:native("GL_CURRENT_VERTEX_ATTRIB")
	static var CURRENT_VERTEX_ATTRIB:Int;
	@:native("GL_VERTEX_PROGRAM_POINT_SIZE")
	static var VERTEX_PROGRAM_POINT_SIZE:Int;
	@:native("GL_VERTEX_ATTRIB_ARRAY_POINTER")
	static var VERTEX_ATTRIB_ARRAY_POINTER:Int;
	@:native("GL_STENCIL_BACK_FUNC")
	static var STENCIL_BACK_FUNC:Int;
	@:native("GL_STENCIL_BACK_FAIL")
	static var STENCIL_BACK_FAIL:Int;
	@:native("GL_STENCIL_BACK_PASS_DEPTH_FAIL")
	static var STENCIL_BACK_PASS_DEPTH_FAIL:Int;
	@:native("GL_STENCIL_BACK_PASS_DEPTH_PASS")
	static var STENCIL_BACK_PASS_DEPTH_PASS:Int;
	@:native("GL_MAX_DRAW_BUFFERS")
	static var MAX_DRAW_BUFFERS:Int;
	@:native("GL_DRAW_BUFFER0")
	static var DRAW_BUFFER0:Int;
	@:native("GL_DRAW_BUFFER1")
	static var DRAW_BUFFER1:Int;
	@:native("GL_DRAW_BUFFER2")
	static var DRAW_BUFFER2:Int;
	@:native("GL_DRAW_BUFFER3")
	static var DRAW_BUFFER3:Int;
	@:native("GL_DRAW_BUFFER4")
	static var DRAW_BUFFER4:Int;
	@:native("GL_DRAW_BUFFER5")
	static var DRAW_BUFFER5:Int;
	@:native("GL_DRAW_BUFFER6")
	static var DRAW_BUFFER6:Int;
	@:native("GL_DRAW_BUFFER7")
	static var DRAW_BUFFER7:Int;
	@:native("GL_DRAW_BUFFER8")
	static var DRAW_BUFFER8:Int;
	@:native("GL_DRAW_BUFFER9")
	static var DRAW_BUFFER9:Int;
	@:native("GL_DRAW_BUFFER10")
	static var DRAW_BUFFER10:Int;
	@:native("GL_DRAW_BUFFER11")
	static var DRAW_BUFFER11:Int;
	@:native("GL_DRAW_BUFFER12")
	static var DRAW_BUFFER12:Int;
	@:native("GL_DRAW_BUFFER13")
	static var DRAW_BUFFER13:Int;
	@:native("GL_DRAW_BUFFER14")
	static var DRAW_BUFFER14:Int;
	@:native("GL_DRAW_BUFFER15")
	static var DRAW_BUFFER15:Int;
	@:native("GL_BLEND_EQUATION_ALPHA")
	static var BLEND_EQUATION_ALPHA:Int;
	@:native("GL_MAX_VERTEX_ATTRIBS")
	static var MAX_VERTEX_ATTRIBS:Int;
	@:native("GL_VERTEX_ATTRIB_ARRAY_NORMALIZED")
	static var VERTEX_ATTRIB_ARRAY_NORMALIZED:Int;
	@:native("GL_MAX_TEXTURE_IMAGE_UNITS")
	static var MAX_TEXTURE_IMAGE_UNITS:Int;
	@:native("GL_FRAGMENT_SHADER")
	static var FRAGMENT_SHADER:Int;
	@:native("GL_VERTEX_SHADER")
	static var VERTEX_SHADER:Int;
	@:native("GL_MAX_FRAGMENT_UNIFORM_COMPONENTS")
	static var MAX_FRAGMENT_UNIFORM_COMPONENTS:Int;
	@:native("GL_MAX_VERTEX_UNIFORM_COMPONENTS")
	static var MAX_VERTEX_UNIFORM_COMPONENTS:Int;
	@:native("GL_MAX_VARYING_FLOATS")
	static var MAX_VARYING_FLOATS:Int;
	@:native("GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS")
	static var MAX_VERTEX_TEXTURE_IMAGE_UNITS:Int;
	@:native("GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS")
	static var MAX_COMBINED_TEXTURE_IMAGE_UNITS:Int;
	@:native("GL_SHADER_TYPE")
	static var SHADER_TYPE:Int;
	@:native("GL_FLOAT_VEC2")
	static var FLOAT_VEC2:Int;
	@:native("GL_FLOAT_VEC3")
	static var FLOAT_VEC3:Int;
	@:native("GL_FLOAT_VEC4")
	static var FLOAT_VEC4:Int;
	@:native("GL_INT_VEC2")
	static var INT_VEC2:Int;
	@:native("GL_INT_VEC3")
	static var INT_VEC3:Int;
	@:native("GL_INT_VEC4")
	static var INT_VEC4:Int;
	@:native("GL_BOOL")
	static var BOOL:Int;
	@:native("GL_BOOL_VEC2")
	static var BOOL_VEC2:Int;
	@:native("GL_BOOL_VEC3")
	static var BOOL_VEC3:Int;
	@:native("GL_BOOL_VEC4")
	static var BOOL_VEC4:Int;
	@:native("GL_FLOAT_MAT2")
	static var FLOAT_MAT2:Int;
	@:native("GL_FLOAT_MAT3")
	static var FLOAT_MAT3:Int;
	@:native("GL_FLOAT_MAT4")
	static var FLOAT_MAT4:Int;
	@:native("GL_SAMPLER_1D")
	static var SAMPLER_1D:Int;
	@:native("GL_SAMPLER_2D")
	static var SAMPLER_2D:Int;
	@:native("GL_SAMPLER_3D")
	static var SAMPLER_3D:Int;
	@:native("GL_SAMPLER_CUBE")
	static var SAMPLER_CUBE:Int;
	@:native("GL_SAMPLER_1D_SHADOW")
	static var SAMPLER_1D_SHADOW:Int;
	@:native("GL_SAMPLER_2D_SHADOW")
	static var SAMPLER_2D_SHADOW:Int;
	@:native("GL_DELETE_STATUS")
	static var DELETE_STATUS:Int;
	@:native("GL_COMPILE_STATUS")
	static var COMPILE_STATUS:Int;
	@:native("GL_LINK_STATUS")
	static var LINK_STATUS:Int;
	@:native("GL_VALIDATE_STATUS")
	static var VALIDATE_STATUS:Int;
	@:native("GL_INFO_LOG_LENGTH")
	static var INFO_LOG_LENGTH:Int;
	@:native("GL_ATTACHED_SHADERS")
	static var ATTACHED_SHADERS:Int;
	@:native("GL_ACTIVE_UNIFORMS")
	static var ACTIVE_UNIFORMS:Int;
	@:native("GL_ACTIVE_UNIFORM_MAX_LENGTH")
	static var ACTIVE_UNIFORM_MAX_LENGTH:Int;
	@:native("GL_SHADER_SOURCE_LENGTH")
	static var SHADER_SOURCE_LENGTH:Int;
	@:native("GL_ACTIVE_ATTRIBUTES")
	static var ACTIVE_ATTRIBUTES:Int;
	@:native("GL_ACTIVE_ATTRIBUTE_MAX_LENGTH")
	static var ACTIVE_ATTRIBUTE_MAX_LENGTH:Int;
	@:native("GL_FRAGMENT_SHADER_DERIVATIVE_HINT")
	static var FRAGMENT_SHADER_DERIVATIVE_HINT:Int;
	@:native("GL_SHADING_LANGUAGE_VERSION")
	static var SHADING_LANGUAGE_VERSION:Int;
	@:native("GL_CURRENT_PROGRAM")
	static var CURRENT_PROGRAM:Int;
	@:native("GL_POINT_SPRITE_COORD_ORIGIN")
	static var POINT_SPRITE_COORD_ORIGIN:Int;
	@:native("GL_LOWER_LEFT")
	static var LOWER_LEFT:Int;
	@:native("GL_UPPER_LEFT")
	static var UPPER_LEFT:Int;
	@:native("GL_STENCIL_BACK_REF")
	static var STENCIL_BACK_REF:Int;
	@:native("GL_STENCIL_BACK_VALUE_MASK")
	static var STENCIL_BACK_VALUE_MASK:Int;
	@:native("GL_STENCIL_BACK_WRITEMASK")
	static var STENCIL_BACK_WRITEMASK:Int;
	@:native("GL_PIXEL_PACK_BUFFER")
	static var PIXEL_PACK_BUFFER:Int;
	@:native("GL_PIXEL_UNPACK_BUFFER")
	static var PIXEL_UNPACK_BUFFER:Int;
	@:native("GL_PIXEL_PACK_BUFFER_BINDING")
	static var PIXEL_PACK_BUFFER_BINDING:Int;
	@:native("GL_PIXEL_UNPACK_BUFFER_BINDING")
	static var PIXEL_UNPACK_BUFFER_BINDING:Int;
	@:native("GL_FLOAT_MAT2x3")
	static var FLOAT_MAT2x3:Int;
	@:native("GL_FLOAT_MAT2x4")
	static var FLOAT_MAT2x4:Int;
	@:native("GL_FLOAT_MAT3x2")
	static var FLOAT_MAT3x2:Int;
	@:native("GL_FLOAT_MAT3x4")
	static var FLOAT_MAT3x4:Int;
	@:native("GL_FLOAT_MAT4x2")
	static var FLOAT_MAT4x2:Int;
	@:native("GL_FLOAT_MAT4x3")
	static var FLOAT_MAT4x3:Int;
	@:native("GL_SRGB")
	static var SRGB:Int;
	@:native("GL_SRGB8")
	static var SRGB8:Int;
	@:native("GL_SRGB_ALPHA")
	static var SRGB_ALPHA:Int;
	@:native("GL_SRGB8_ALPHA8")
	static var SRGB8_ALPHA8:Int;
	@:native("GL_COMPRESSED_SRGB")
	static var COMPRESSED_SRGB:Int;
	@:native("GL_COMPRESSED_SRGB_ALPHA")
	static var COMPRESSED_SRGB_ALPHA:Int;
	@:native("GL_COMPARE_REF_TO_TEXTURE")
	static var COMPARE_REF_TO_TEXTURE:Int;
	@:native("GL_CLIP_DISTANCE0")
	static var CLIP_DISTANCE0:Int;
	@:native("GL_CLIP_DISTANCE1")
	static var CLIP_DISTANCE1:Int;
	@:native("GL_CLIP_DISTANCE2")
	static var CLIP_DISTANCE2:Int;
	@:native("GL_CLIP_DISTANCE3")
	static var CLIP_DISTANCE3:Int;
	@:native("GL_CLIP_DISTANCE4")
	static var CLIP_DISTANCE4:Int;
	@:native("GL_CLIP_DISTANCE5")
	static var CLIP_DISTANCE5:Int;
	@:native("GL_CLIP_DISTANCE6")
	static var CLIP_DISTANCE6:Int;
	@:native("GL_CLIP_DISTANCE7")
	static var CLIP_DISTANCE7:Int;
	@:native("GL_MAX_CLIP_DISTANCES")
	static var MAX_CLIP_DISTANCES:Int;
	@:native("GL_MAJOR_VERSION")
	static var MAJOR_VERSION:Int;
	@:native("GL_MINOR_VERSION")
	static var MINOR_VERSION:Int;
	@:native("GL_NUM_EXTENSIONS")
	static var NUM_EXTENSIONS:Int;
	@:native("GL_CONTEXT_FLAGS")
	static var CONTEXT_FLAGS:Int;
	@:native("GL_COMPRESSED_RED")
	static var COMPRESSED_RED:Int;
	@:native("GL_COMPRESSED_RG")
	static var COMPRESSED_RG:Int;
	@:native("GL_CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT")
	static var CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT:Int;
	@:native("GL_RGBA32F")
	static var RGBA32F:Int;
	@:native("GL_RGB32F")
	static var RGB32F:Int;
	@:native("GL_RGBA16F")
	static var RGBA16F:Int;
	@:native("GL_RGB16F")
	static var RGB16F:Int;
	@:native("GL_VERTEX_ATTRIB_ARRAY_INTEGER")
	static var VERTEX_ATTRIB_ARRAY_INTEGER:Int;
	@:native("GL_MAX_ARRAY_TEXTURE_LAYERS")
	static var MAX_ARRAY_TEXTURE_LAYERS:Int;
	@:native("GL_MIN_PROGRAM_TEXEL_OFFSET")
	static var MIN_PROGRAM_TEXEL_OFFSET:Int;
	@:native("GL_MAX_PROGRAM_TEXEL_OFFSET")
	static var MAX_PROGRAM_TEXEL_OFFSET:Int;
	@:native("GL_CLAMP_READ_COLOR")
	static var CLAMP_READ_COLOR:Int;
	@:native("GL_FIXED_ONLY")
	static var FIXED_ONLY:Int;
	@:native("GL_MAX_VARYING_COMPONENTS")
	static var MAX_VARYING_COMPONENTS:Int;
	@:native("GL_TEXTURE_1D_ARRAY")
	static var TEXTURE_1D_ARRAY:Int;
	@:native("GL_PROXY_TEXTURE_1D_ARRAY")
	static var PROXY_TEXTURE_1D_ARRAY:Int;
	@:native("GL_TEXTURE_2D_ARRAY")
	static var TEXTURE_2D_ARRAY:Int;
	@:native("GL_PROXY_TEXTURE_2D_ARRAY")
	static var PROXY_TEXTURE_2D_ARRAY:Int;
	@:native("GL_TEXTURE_BINDING_1D_ARRAY")
	static var TEXTURE_BINDING_1D_ARRAY:Int;
	@:native("GL_TEXTURE_BINDING_2D_ARRAY")
	static var TEXTURE_BINDING_2D_ARRAY:Int;
	@:native("GL_R11F_G11F_B10F")
	static var R11F_G11F_B10F:Int;
	@:native("GL_UNSIGNED_INT_10F_11F_11F_REV")
	static var UNSIGNED_INT_10F_11F_11F_REV:Int;
	@:native("GL_RGB9_E5")
	static var RGB9_E5:Int;
	@:native("GL_UNSIGNED_INT_5_9_9_9_REV")
	static var UNSIGNED_INT_5_9_9_9_REV:Int;
	@:native("GL_TEXTURE_SHARED_SIZE")
	static var TEXTURE_SHARED_SIZE:Int;
	@:native("GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH")
	static var TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH:Int;
	@:native("GL_TRANSFORM_FEEDBACK_BUFFER_MODE")
	static var TRANSFORM_FEEDBACK_BUFFER_MODE:Int;
	@:native("GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS")
	static var MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS:Int;
	@:native("GL_TRANSFORM_FEEDBACK_VARYINGS")
	static var TRANSFORM_FEEDBACK_VARYINGS:Int;
	@:native("GL_TRANSFORM_FEEDBACK_BUFFER_START")
	static var TRANSFORM_FEEDBACK_BUFFER_START:Int;
	@:native("GL_TRANSFORM_FEEDBACK_BUFFER_SIZE")
	static var TRANSFORM_FEEDBACK_BUFFER_SIZE:Int;
	@:native("GL_PRIMITIVES_GENERATED")
	static var PRIMITIVES_GENERATED:Int;
	@:native("GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN")
	static var TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN:Int;
	@:native("GL_RASTERIZER_DISCARD")
	static var RASTERIZER_DISCARD:Int;
	@:native("GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS")
	static var MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS:Int;
	@:native("GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS")
	static var MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS:Int;
	@:native("GL_INTERLEAVED_ATTRIBS")
	static var INTERLEAVED_ATTRIBS:Int;
	@:native("GL_SEPARATE_ATTRIBS")
	static var SEPARATE_ATTRIBS:Int;
	@:native("GL_TRANSFORM_FEEDBACK_BUFFER")
	static var TRANSFORM_FEEDBACK_BUFFER:Int;
	@:native("GL_TRANSFORM_FEEDBACK_BUFFER_BINDING")
	static var TRANSFORM_FEEDBACK_BUFFER_BINDING:Int;
	@:native("GL_RGBA32UI")
	static var RGBA32UI:Int;
	@:native("GL_RGB32UI")
	static var RGB32UI:Int;
	@:native("GL_RGBA16UI")
	static var RGBA16UI:Int;
	@:native("GL_RGB16UI")
	static var RGB16UI:Int;
	@:native("GL_RGBA8UI")
	static var RGBA8UI:Int;
	@:native("GL_RGB8UI")
	static var RGB8UI:Int;
	@:native("GL_RGBA32I")
	static var RGBA32I:Int;
	@:native("GL_RGB32I")
	static var RGB32I:Int;
	@:native("GL_RGBA16I")
	static var RGBA16I:Int;
	@:native("GL_RGB16I")
	static var RGB16I:Int;
	@:native("GL_RGBA8I")
	static var RGBA8I:Int;
	@:native("GL_RGB8I")
	static var RGB8I:Int;
	@:native("GL_RED_INTEGER")
	static var RED_INTEGER:Int;
	@:native("GL_GREEN_INTEGER")
	static var GREEN_INTEGER:Int;
	@:native("GL_BLUE_INTEGER")
	static var BLUE_INTEGER:Int;
	@:native("GL_RGB_INTEGER")
	static var RGB_INTEGER:Int;
	@:native("GL_RGBA_INTEGER")
	static var RGBA_INTEGER:Int;
	@:native("GL_BGR_INTEGER")
	static var BGR_INTEGER:Int;
	@:native("GL_BGRA_INTEGER")
	static var BGRA_INTEGER:Int;
	@:native("GL_SAMPLER_1D_ARRAY")
	static var SAMPLER_1D_ARRAY:Int;
	@:native("GL_SAMPLER_2D_ARRAY")
	static var SAMPLER_2D_ARRAY:Int;
	@:native("GL_SAMPLER_1D_ARRAY_SHADOW")
	static var SAMPLER_1D_ARRAY_SHADOW:Int;
	@:native("GL_SAMPLER_2D_ARRAY_SHADOW")
	static var SAMPLER_2D_ARRAY_SHADOW:Int;
	@:native("GL_SAMPLER_CUBE_SHADOW")
	static var SAMPLER_CUBE_SHADOW:Int;
	@:native("GL_UNSIGNED_INT_VEC2")
	static var UNSIGNED_INT_VEC2:Int;
	@:native("GL_UNSIGNED_INT_VEC3")
	static var UNSIGNED_INT_VEC3:Int;
	@:native("GL_UNSIGNED_INT_VEC4")
	static var UNSIGNED_INT_VEC4:Int;
	@:native("GL_INT_SAMPLER_1D")
	static var INT_SAMPLER_1D:Int;
	@:native("GL_INT_SAMPLER_2D")
	static var INT_SAMPLER_2D:Int;
	@:native("GL_INT_SAMPLER_3D")
	static var INT_SAMPLER_3D:Int;
	@:native("GL_INT_SAMPLER_CUBE")
	static var INT_SAMPLER_CUBE:Int;
	@:native("GL_INT_SAMPLER_1D_ARRAY")
	static var INT_SAMPLER_1D_ARRAY:Int;
	@:native("GL_INT_SAMPLER_2D_ARRAY")
	static var INT_SAMPLER_2D_ARRAY:Int;
	@:native("GL_UNSIGNED_INT_SAMPLER_1D")
	static var UNSIGNED_INT_SAMPLER_1D:Int;
	@:native("GL_UNSIGNED_INT_SAMPLER_2D")
	static var UNSIGNED_INT_SAMPLER_2D:Int;
	@:native("GL_UNSIGNED_INT_SAMPLER_3D")
	static var UNSIGNED_INT_SAMPLER_3D:Int;
	@:native("GL_UNSIGNED_INT_SAMPLER_CUBE")
	static var UNSIGNED_INT_SAMPLER_CUBE:Int;
	@:native("GL_UNSIGNED_INT_SAMPLER_1D_ARRAY")
	static var UNSIGNED_INT_SAMPLER_1D_ARRAY:Int;
	@:native("GL_UNSIGNED_INT_SAMPLER_2D_ARRAY")
	static var UNSIGNED_INT_SAMPLER_2D_ARRAY:Int;
	@:native("GL_QUERY_WAIT")
	static var QUERY_WAIT:Int;
	@:native("GL_QUERY_NO_WAIT")
	static var QUERY_NO_WAIT:Int;
	@:native("GL_QUERY_BY_REGION_WAIT")
	static var QUERY_BY_REGION_WAIT:Int;
	@:native("GL_QUERY_BY_REGION_NO_WAIT")
	static var QUERY_BY_REGION_NO_WAIT:Int;
	@:native("GL_BUFFER_ACCESS_FLAGS")
	static var BUFFER_ACCESS_FLAGS:Int;
	@:native("GL_BUFFER_MAP_LENGTH")
	static var BUFFER_MAP_LENGTH:Int;
	@:native("GL_BUFFER_MAP_OFFSET")
	static var BUFFER_MAP_OFFSET:Int;
	@:native("GL_DEPTH_COMPONENT32F")
	static var DEPTH_COMPONENT32F:Int;
	@:native("GL_DEPTH32F_STENCIL8")
	static var DEPTH32F_STENCIL8:Int;
	@:native("GL_FLOAT_32_UNSIGNED_INT_24_8_REV")
	static var FLOAT_32_UNSIGNED_INT_24_8_REV:Int;
	@:native("GL_INVALID_FRAMEBUFFER_OPERATION")
	static var INVALID_FRAMEBUFFER_OPERATION:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING")
	static var FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE")
	static var FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE")
	static var FRAMEBUFFER_ATTACHMENT_RED_SIZE:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE")
	static var FRAMEBUFFER_ATTACHMENT_GREEN_SIZE:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE")
	static var FRAMEBUFFER_ATTACHMENT_BLUE_SIZE:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE")
	static var FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE")
	static var FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE")
	static var FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE:Int;
	@:native("GL_FRAMEBUFFER_DEFAULT")
	static var FRAMEBUFFER_DEFAULT:Int;
	@:native("GL_FRAMEBUFFER_UNDEFINED")
	static var FRAMEBUFFER_UNDEFINED:Int;
	@:native("GL_DEPTH_STENCIL_ATTACHMENT")
	static var DEPTH_STENCIL_ATTACHMENT:Int;
	@:native("GL_MAX_RENDERBUFFER_SIZE")
	static var MAX_RENDERBUFFER_SIZE:Int;
	@:native("GL_DEPTH_STENCIL")
	static var DEPTH_STENCIL:Int;
	@:native("GL_UNSIGNED_INT_24_8")
	static var UNSIGNED_INT_24_8:Int;
	@:native("GL_DEPTH24_STENCIL8")
	static var DEPTH24_STENCIL8:Int;
	@:native("GL_TEXTURE_STENCIL_SIZE")
	static var TEXTURE_STENCIL_SIZE:Int;
	@:native("GL_TEXTURE_RED_TYPE")
	static var TEXTURE_RED_TYPE:Int;
	@:native("GL_TEXTURE_GREEN_TYPE")
	static var TEXTURE_GREEN_TYPE:Int;
	@:native("GL_TEXTURE_BLUE_TYPE")
	static var TEXTURE_BLUE_TYPE:Int;
	@:native("GL_TEXTURE_ALPHA_TYPE")
	static var TEXTURE_ALPHA_TYPE:Int;
	@:native("GL_TEXTURE_DEPTH_TYPE")
	static var TEXTURE_DEPTH_TYPE:Int;
	@:native("GL_UNSIGNED_NORMALIZED")
	static var UNSIGNED_NORMALIZED:Int;
	@:native("GL_FRAMEBUFFER_BINDING")
	static var FRAMEBUFFER_BINDING:Int;
	@:native("GL_DRAW_FRAMEBUFFER_BINDING")
	static var DRAW_FRAMEBUFFER_BINDING:Int;
	@:native("GL_RENDERBUFFER_BINDING")
	static var RENDERBUFFER_BINDING:Int;
	@:native("GL_READ_FRAMEBUFFER")
	static var READ_FRAMEBUFFER:Int;
	@:native("GL_DRAW_FRAMEBUFFER")
	static var DRAW_FRAMEBUFFER:Int;
	@:native("GL_READ_FRAMEBUFFER_BINDING")
	static var READ_FRAMEBUFFER_BINDING:Int;
	@:native("GL_RENDERBUFFER_SAMPLES")
	static var RENDERBUFFER_SAMPLES:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE")
	static var FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME")
	static var FRAMEBUFFER_ATTACHMENT_OBJECT_NAME:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL")
	static var FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE")
	static var FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER")
	static var FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER:Int;
	@:native("GL_FRAMEBUFFER_COMPLETE")
	static var FRAMEBUFFER_COMPLETE:Int;
	@:native("GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT")
	static var FRAMEBUFFER_INCOMPLETE_ATTACHMENT:Int;
	@:native("GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT")
	static var FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT:Int;
	@:native("GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER")
	static var FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER:Int;
	@:native("GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER")
	static var FRAMEBUFFER_INCOMPLETE_READ_BUFFER:Int;
	@:native("GL_FRAMEBUFFER_UNSUPPORTED")
	static var FRAMEBUFFER_UNSUPPORTED:Int;
	@:native("GL_MAX_COLOR_ATTACHMENTS")
	static var MAX_COLOR_ATTACHMENTS:Int;
	@:native("GL_COLOR_ATTACHMENT0")
	static var COLOR_ATTACHMENT0:Int;
	@:native("GL_COLOR_ATTACHMENT1")
	static var COLOR_ATTACHMENT1:Int;
	@:native("GL_COLOR_ATTACHMENT2")
	static var COLOR_ATTACHMENT2:Int;
	@:native("GL_COLOR_ATTACHMENT3")
	static var COLOR_ATTACHMENT3:Int;
	@:native("GL_COLOR_ATTACHMENT4")
	static var COLOR_ATTACHMENT4:Int;
	@:native("GL_COLOR_ATTACHMENT5")
	static var COLOR_ATTACHMENT5:Int;
	@:native("GL_COLOR_ATTACHMENT6")
	static var COLOR_ATTACHMENT6:Int;
	@:native("GL_COLOR_ATTACHMENT7")
	static var COLOR_ATTACHMENT7:Int;
	@:native("GL_COLOR_ATTACHMENT8")
	static var COLOR_ATTACHMENT8:Int;
	@:native("GL_COLOR_ATTACHMENT9")
	static var COLOR_ATTACHMENT9:Int;
	@:native("GL_COLOR_ATTACHMENT10")
	static var COLOR_ATTACHMENT10:Int;
	@:native("GL_COLOR_ATTACHMENT11")
	static var COLOR_ATTACHMENT11:Int;
	@:native("GL_COLOR_ATTACHMENT12")
	static var COLOR_ATTACHMENT12:Int;
	@:native("GL_COLOR_ATTACHMENT13")
	static var COLOR_ATTACHMENT13:Int;
	@:native("GL_COLOR_ATTACHMENT14")
	static var COLOR_ATTACHMENT14:Int;
	@:native("GL_COLOR_ATTACHMENT15")
	static var COLOR_ATTACHMENT15:Int;
	@:native("GL_COLOR_ATTACHMENT16")
	static var COLOR_ATTACHMENT16:Int;
	@:native("GL_COLOR_ATTACHMENT17")
	static var COLOR_ATTACHMENT17:Int;
	@:native("GL_COLOR_ATTACHMENT18")
	static var COLOR_ATTACHMENT18:Int;
	@:native("GL_COLOR_ATTACHMENT19")
	static var COLOR_ATTACHMENT19:Int;
	@:native("GL_COLOR_ATTACHMENT20")
	static var COLOR_ATTACHMENT20:Int;
	@:native("GL_COLOR_ATTACHMENT21")
	static var COLOR_ATTACHMENT21:Int;
	@:native("GL_COLOR_ATTACHMENT22")
	static var COLOR_ATTACHMENT22:Int;
	@:native("GL_COLOR_ATTACHMENT23")
	static var COLOR_ATTACHMENT23:Int;
	@:native("GL_COLOR_ATTACHMENT24")
	static var COLOR_ATTACHMENT24:Int;
	@:native("GL_COLOR_ATTACHMENT25")
	static var COLOR_ATTACHMENT25:Int;
	@:native("GL_COLOR_ATTACHMENT26")
	static var COLOR_ATTACHMENT26:Int;
	@:native("GL_COLOR_ATTACHMENT27")
	static var COLOR_ATTACHMENT27:Int;
	@:native("GL_COLOR_ATTACHMENT28")
	static var COLOR_ATTACHMENT28:Int;
	@:native("GL_COLOR_ATTACHMENT29")
	static var COLOR_ATTACHMENT29:Int;
	@:native("GL_COLOR_ATTACHMENT30")
	static var COLOR_ATTACHMENT30:Int;
	@:native("GL_COLOR_ATTACHMENT31")
	static var COLOR_ATTACHMENT31:Int;
	@:native("GL_DEPTH_ATTACHMENT")
	static var DEPTH_ATTACHMENT:Int;
	@:native("GL_STENCIL_ATTACHMENT")
	static var STENCIL_ATTACHMENT:Int;
	@:native("GL_FRAMEBUFFER")
	static var FRAMEBUFFER:Int;
	@:native("GL_RENDERBUFFER")
	static var RENDERBUFFER:Int;
	@:native("GL_RENDERBUFFER_WIDTH")
	static var RENDERBUFFER_WIDTH:Int;
	@:native("GL_RENDERBUFFER_HEIGHT")
	static var RENDERBUFFER_HEIGHT:Int;
	@:native("GL_RENDERBUFFER_INTERNAL_FORMAT")
	static var RENDERBUFFER_INTERNAL_FORMAT:Int;
	@:native("GL_STENCIL_INDEX1")
	static var STENCIL_INDEX1:Int;
	@:native("GL_STENCIL_INDEX4")
	static var STENCIL_INDEX4:Int;
	@:native("GL_STENCIL_INDEX8")
	static var STENCIL_INDEX8:Int;
	@:native("GL_STENCIL_INDEX16")
	static var STENCIL_INDEX16:Int;
	@:native("GL_RENDERBUFFER_RED_SIZE")
	static var RENDERBUFFER_RED_SIZE:Int;
	@:native("GL_RENDERBUFFER_GREEN_SIZE")
	static var RENDERBUFFER_GREEN_SIZE:Int;
	@:native("GL_RENDERBUFFER_BLUE_SIZE")
	static var RENDERBUFFER_BLUE_SIZE:Int;
	@:native("GL_RENDERBUFFER_ALPHA_SIZE")
	static var RENDERBUFFER_ALPHA_SIZE:Int;
	@:native("GL_RENDERBUFFER_DEPTH_SIZE")
	static var RENDERBUFFER_DEPTH_SIZE:Int;
	@:native("GL_RENDERBUFFER_STENCIL_SIZE")
	static var RENDERBUFFER_STENCIL_SIZE:Int;
	@:native("GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE")
	static var FRAMEBUFFER_INCOMPLETE_MULTISAMPLE:Int;
	@:native("GL_MAX_SAMPLES")
	static var MAX_SAMPLES:Int;
	@:native("GL_FRAMEBUFFER_SRGB")
	static var FRAMEBUFFER_SRGB:Int;
	@:native("GL_HALF_FLOAT")
	static var HALF_FLOAT:Int;
	@:native("GL_MAP_READ_BIT")
	static var MAP_READ_BIT:Int;
	@:native("GL_MAP_WRITE_BIT")
	static var MAP_WRITE_BIT:Int;
	@:native("GL_MAP_INVALIDATE_RANGE_BIT")
	static var MAP_INVALIDATE_RANGE_BIT:Int;
	@:native("GL_MAP_INVALIDATE_BUFFER_BIT")
	static var MAP_INVALIDATE_BUFFER_BIT:Int;
	@:native("GL_MAP_FLUSH_EXPLICIT_BIT")
	static var MAP_FLUSH_EXPLICIT_BIT:Int;
	@:native("GL_MAP_UNSYNCHRONIZED_BIT")
	static var MAP_UNSYNCHRONIZED_BIT:Int;
	@:native("GL_COMPRESSED_RED_RGTC1")
	static var COMPRESSED_RED_RGTC1:Int;
	@:native("GL_COMPRESSED_SIGNED_RED_RGTC1")
	static var COMPRESSED_SIGNED_RED_RGTC1:Int;
	@:native("GL_COMPRESSED_RG_RGTC2")
	static var COMPRESSED_RG_RGTC2:Int;
	@:native("GL_COMPRESSED_SIGNED_RG_RGTC2")
	static var COMPRESSED_SIGNED_RG_RGTC2:Int;
	@:native("GL_RG")
	static var RG:Int;
	@:native("GL_RG_INTEGER")
	static var RG_INTEGER:Int;
	@:native("GL_R8")
	static var R8:Int;
	@:native("GL_R16")
	static var R16:Int;
	@:native("GL_RG8")
	static var RG8:Int;
	@:native("GL_RG16")
	static var RG16:Int;
	@:native("GL_R16F")
	static var R16F:Int;
	@:native("GL_R32F")
	static var R32F:Int;
	@:native("GL_RG16F")
	static var RG16F:Int;
	@:native("GL_RG32F")
	static var RG32F:Int;
	@:native("GL_R8I")
	static var R8I:Int;
	@:native("GL_R8UI")
	static var R8UI:Int;
	@:native("GL_R16I")
	static var R16I:Int;
	@:native("GL_R16UI")
	static var R16UI:Int;
	@:native("GL_R32I")
	static var R32I:Int;
	@:native("GL_R32UI")
	static var R32UI:Int;
	@:native("GL_RG8I")
	static var RG8I:Int;
	@:native("GL_RG8UI")
	static var RG8UI:Int;
	@:native("GL_RG16I")
	static var RG16I:Int;
	@:native("GL_RG16UI")
	static var RG16UI:Int;
	@:native("GL_RG32I")
	static var RG32I:Int;
	@:native("GL_RG32UI")
	static var RG32UI:Int;
	@:native("GL_VERTEX_ARRAY_BINDING")
	static var VERTEX_ARRAY_BINDING:Int;
	@:native("GL_SAMPLER_2D_RECT")
	static var SAMPLER_2D_RECT:Int;
	@:native("GL_SAMPLER_2D_RECT_SHADOW")
	static var SAMPLER_2D_RECT_SHADOW:Int;
	@:native("GL_SAMPLER_BUFFER")
	static var SAMPLER_BUFFER:Int;
	@:native("GL_INT_SAMPLER_2D_RECT")
	static var INT_SAMPLER_2D_RECT:Int;
	@:native("GL_INT_SAMPLER_BUFFER")
	static var INT_SAMPLER_BUFFER:Int;
	@:native("GL_UNSIGNED_INT_SAMPLER_2D_RECT")
	static var UNSIGNED_INT_SAMPLER_2D_RECT:Int;
	@:native("GL_UNSIGNED_INT_SAMPLER_BUFFER")
	static var UNSIGNED_INT_SAMPLER_BUFFER:Int;
	@:native("GL_TEXTURE_BUFFER")
	static var TEXTURE_BUFFER:Int;
	@:native("GL_MAX_TEXTURE_BUFFER_SIZE")
	static var MAX_TEXTURE_BUFFER_SIZE:Int;
	@:native("GL_TEXTURE_BINDING_BUFFER")
	static var TEXTURE_BINDING_BUFFER:Int;
	@:native("GL_TEXTURE_BUFFER_DATA_STORE_BINDING")
	static var TEXTURE_BUFFER_DATA_STORE_BINDING:Int;
	@:native("GL_TEXTURE_RECTANGLE")
	static var TEXTURE_RECTANGLE:Int;
	@:native("GL_TEXTURE_BINDING_RECTANGLE")
	static var TEXTURE_BINDING_RECTANGLE:Int;
	@:native("GL_PROXY_TEXTURE_RECTANGLE")
	static var PROXY_TEXTURE_RECTANGLE:Int;
	@:native("GL_MAX_RECTANGLE_TEXTURE_SIZE")
	static var MAX_RECTANGLE_TEXTURE_SIZE:Int;
	@:native("GL_R8_SNORM")
	static var R8_SNORM:Int;
	@:native("GL_RG8_SNORM")
	static var RG8_SNORM:Int;
	@:native("GL_RGB8_SNORM")
	static var RGB8_SNORM:Int;
	@:native("GL_RGBA8_SNORM")
	static var RGBA8_SNORM:Int;
	@:native("GL_R16_SNORM")
	static var R16_SNORM:Int;
	@:native("GL_RG16_SNORM")
	static var RG16_SNORM:Int;
	@:native("GL_RGB16_SNORM")
	static var RGB16_SNORM:Int;
	@:native("GL_RGBA16_SNORM")
	static var RGBA16_SNORM:Int;
	@:native("GL_SIGNED_NORMALIZED")
	static var SIGNED_NORMALIZED:Int;
	@:native("GL_PRIMITIVE_RESTART")
	static var PRIMITIVE_RESTART:Int;
	@:native("GL_PRIMITIVE_RESTART_INDEX")
	static var PRIMITIVE_RESTART_INDEX:Int;
	@:native("GL_COPY_READ_BUFFER")
	static var COPY_READ_BUFFER:Int;
	@:native("GL_COPY_WRITE_BUFFER")
	static var COPY_WRITE_BUFFER:Int;
	@:native("GL_UNIFORM_BUFFER")
	static var UNIFORM_BUFFER:Int;
	@:native("GL_UNIFORM_BUFFER_BINDING")
	static var UNIFORM_BUFFER_BINDING:Int;
	@:native("GL_UNIFORM_BUFFER_START")
	static var UNIFORM_BUFFER_START:Int;
	@:native("GL_UNIFORM_BUFFER_SIZE")
	static var UNIFORM_BUFFER_SIZE:Int;
	@:native("GL_MAX_VERTEX_UNIFORM_BLOCKS")
	static var MAX_VERTEX_UNIFORM_BLOCKS:Int;
	@:native("GL_MAX_GEOMETRY_UNIFORM_BLOCKS")
	static var MAX_GEOMETRY_UNIFORM_BLOCKS:Int;
	@:native("GL_MAX_FRAGMENT_UNIFORM_BLOCKS")
	static var MAX_FRAGMENT_UNIFORM_BLOCKS:Int;
	@:native("GL_MAX_COMBINED_UNIFORM_BLOCKS")
	static var MAX_COMBINED_UNIFORM_BLOCKS:Int;
	@:native("GL_MAX_UNIFORM_BUFFER_BINDINGS")
	static var MAX_UNIFORM_BUFFER_BINDINGS:Int;
	@:native("GL_MAX_UNIFORM_BLOCK_SIZE")
	static var MAX_UNIFORM_BLOCK_SIZE:Int;
	@:native("GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS")
	static var MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS:Int;
	@:native("GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS")
	static var MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS:Int;
	@:native("GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS")
	static var MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS:Int;
	@:native("GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT")
	static var UNIFORM_BUFFER_OFFSET_ALIGNMENT:Int;
	@:native("GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH")
	static var ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH:Int;
	@:native("GL_ACTIVE_UNIFORM_BLOCKS")
	static var ACTIVE_UNIFORM_BLOCKS:Int;
	@:native("GL_UNIFORM_TYPE")
	static var UNIFORM_TYPE:Int;
	@:native("GL_UNIFORM_SIZE")
	static var UNIFORM_SIZE:Int;
	@:native("GL_UNIFORM_NAME_LENGTH")
	static var UNIFORM_NAME_LENGTH:Int;
	@:native("GL_UNIFORM_BLOCK_INDEX")
	static var UNIFORM_BLOCK_INDEX:Int;
	@:native("GL_UNIFORM_OFFSET")
	static var UNIFORM_OFFSET:Int;
	@:native("GL_UNIFORM_ARRAY_STRIDE")
	static var UNIFORM_ARRAY_STRIDE:Int;
	@:native("GL_UNIFORM_MATRIX_STRIDE")
	static var UNIFORM_MATRIX_STRIDE:Int;
	@:native("GL_UNIFORM_IS_ROW_MAJOR")
	static var UNIFORM_IS_ROW_MAJOR:Int;
	@:native("GL_UNIFORM_BLOCK_BINDING")
	static var UNIFORM_BLOCK_BINDING:Int;
	@:native("GL_UNIFORM_BLOCK_DATA_SIZE")
	static var UNIFORM_BLOCK_DATA_SIZE:Int;
	@:native("GL_UNIFORM_BLOCK_NAME_LENGTH")
	static var UNIFORM_BLOCK_NAME_LENGTH:Int;
	@:native("GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS")
	static var UNIFORM_BLOCK_ACTIVE_UNIFORMS:Int;
	@:native("GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES")
	static var UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES:Int;
	@:native("GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER")
	static var UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER:Int;
	@:native("GL_UNIFORM_BLOCK_REFERENCED_BY_GEOMETRY_SHADER")
	static var UNIFORM_BLOCK_REFERENCED_BY_GEOMETRY_SHADER:Int;
	@:native("GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER")
	static var UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER:Int;
	@:native("GL_INVALID_INDEX")
	static var INVALID_INDEX:Int;
	@:native("GL_CONTEXT_CORE_PROFILE_BIT")
	static var CONTEXT_CORE_PROFILE_BIT:Int;
	@:native("GL_CONTEXT_COMPATIBILITY_PROFILE_BIT")
	static var CONTEXT_COMPATIBILITY_PROFILE_BIT:Int;
	@:native("GL_LINES_ADJACENCY")
	static var LINES_ADJACENCY:Int;
	@:native("GL_LINE_STRIP_ADJACENCY")
	static var LINE_STRIP_ADJACENCY:Int;
	@:native("GL_TRIANGLES_ADJACENCY")
	static var TRIANGLES_ADJACENCY:Int;
	@:native("GL_TRIANGLE_STRIP_ADJACENCY")
	static var TRIANGLE_STRIP_ADJACENCY:Int;
	@:native("GL_PROGRAM_POINT_SIZE")
	static var PROGRAM_POINT_SIZE:Int;
	@:native("GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS")
	static var MAX_GEOMETRY_TEXTURE_IMAGE_UNITS:Int;
	@:native("GL_FRAMEBUFFER_ATTACHMENT_LAYERED")
	static var FRAMEBUFFER_ATTACHMENT_LAYERED:Int;
	@:native("GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS")
	static var FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS:Int;
	@:native("GL_GEOMETRY_SHADER")
	static var GEOMETRY_SHADER:Int;
	@:native("GL_GEOMETRY_VERTICES_OUT")
	static var GEOMETRY_VERTICES_OUT:Int;
	@:native("GL_GEOMETRY_INPUT_TYPE")
	static var GEOMETRY_INPUT_TYPE:Int;
	@:native("GL_GEOMETRY_OUTPUT_TYPE")
	static var GEOMETRY_OUTPUT_TYPE:Int;
	@:native("GL_MAX_GEOMETRY_UNIFORM_COMPONENTS")
	static var MAX_GEOMETRY_UNIFORM_COMPONENTS:Int;
	@:native("GL_MAX_GEOMETRY_OUTPUT_VERTICES")
	static var MAX_GEOMETRY_OUTPUT_VERTICES:Int;
	@:native("GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS")
	static var MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS:Int;
	@:native("GL_MAX_VERTEX_OUTPUT_COMPONENTS")
	static var MAX_VERTEX_OUTPUT_COMPONENTS:Int;
	@:native("GL_MAX_GEOMETRY_INPUT_COMPONENTS")
	static var MAX_GEOMETRY_INPUT_COMPONENTS:Int;
	@:native("GL_MAX_GEOMETRY_OUTPUT_COMPONENTS")
	static var MAX_GEOMETRY_OUTPUT_COMPONENTS:Int;
	@:native("GL_MAX_FRAGMENT_INPUT_COMPONENTS")
	static var MAX_FRAGMENT_INPUT_COMPONENTS:Int;
	@:native("GL_CONTEXT_PROFILE_MASK")
	static var CONTEXT_PROFILE_MASK:Int;
	@:native("GL_DEPTH_CLAMP")
	static var DEPTH_CLAMP:Int;
	@:native("GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION")
	static var QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION:Int;
	@:native("GL_FIRST_VERTEX_CONVENTION")
	static var FIRST_VERTEX_CONVENTION:Int;
	@:native("GL_LAST_VERTEX_CONVENTION")
	static var LAST_VERTEX_CONVENTION:Int;
	@:native("GL_PROVOKING_VERTEX")
	static var PROVOKING_VERTEX:Int;
	@:native("GL_TEXTURE_CUBE_MAP_SEAMLESS")
	static var TEXTURE_CUBE_MAP_SEAMLESS:Int;
	@:native("GL_MAX_SERVER_WAIT_TIMEOUT")
	static var MAX_SERVER_WAIT_TIMEOUT:Int;
	@:native("GL_OBJECT_TYPE")
	static var OBJECT_TYPE:Int;
	@:native("GL_SYNC_CONDITION")
	static var SYNC_CONDITION:Int;
	@:native("GL_SYNC_STATUS")
	static var SYNC_STATUS:Int;
	@:native("GL_SYNC_FLAGS")
	static var SYNC_FLAGS:Int;
	@:native("GL_SYNC_FENCE")
	static var SYNC_FENCE:Int;
	@:native("GL_SYNC_GPU_COMMANDS_COMPLETE")
	static var SYNC_GPU_COMMANDS_COMPLETE:Int;
	@:native("GL_UNSIGNALED")
	static var UNSIGNALED:Int;
	@:native("GL_SIGNALED")
	static var SIGNALED:Int;
	@:native("GL_ALREADY_SIGNALED")
	static var ALREADY_SIGNALED:Int;
	@:native("GL_TIMEOUT_EXPIRED")
	static var TIMEOUT_EXPIRED:Int;
	@:native("GL_CONDITION_SATISFIED")
	static var CONDITION_SATISFIED:Int;
	@:native("GL_WAIT_FAILED")
	static var WAIT_FAILED:Int;
	@:native("GL_TIMEOUT_IGNORED")
	static var TIMEOUT_IGNORED:Int;
	@:native("GL_SYNC_FLUSH_COMMANDS_BIT")
	static var SYNC_FLUSH_COMMANDS_BIT:Int;
	@:native("GL_SAMPLE_POSITION")
	static var SAMPLE_POSITION:Int;
	@:native("GL_SAMPLE_MASK")
	static var SAMPLE_MASK:Int;
	@:native("GL_SAMPLE_MASK_VALUE")
	static var SAMPLE_MASK_VALUE:Int;
	@:native("GL_MAX_SAMPLE_MASK_WORDS")
	static var MAX_SAMPLE_MASK_WORDS:Int;
	@:native("GL_TEXTURE_2D_MULTISAMPLE")
	static var TEXTURE_2D_MULTISAMPLE:Int;
	@:native("GL_PROXY_TEXTURE_2D_MULTISAMPLE")
	static var PROXY_TEXTURE_2D_MULTISAMPLE:Int;
	@:native("GL_TEXTURE_2D_MULTISAMPLE_ARRAY")
	static var TEXTURE_2D_MULTISAMPLE_ARRAY:Int;
	@:native("GL_PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY")
	static var PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY:Int;
	@:native("GL_TEXTURE_BINDING_2D_MULTISAMPLE")
	static var TEXTURE_BINDING_2D_MULTISAMPLE:Int;
	@:native("GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY")
	static var TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY:Int;
	@:native("GL_TEXTURE_SAMPLES")
	static var TEXTURE_SAMPLES:Int;
	@:native("GL_TEXTURE_FIXED_SAMPLE_LOCATIONS")
	static var TEXTURE_FIXED_SAMPLE_LOCATIONS:Int;
	@:native("GL_SAMPLER_2D_MULTISAMPLE")
	static var SAMPLER_2D_MULTISAMPLE:Int;
	@:native("GL_INT_SAMPLER_2D_MULTISAMPLE")
	static var INT_SAMPLER_2D_MULTISAMPLE:Int;
	@:native("GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE")
	static var UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE:Int;
	@:native("GL_SAMPLER_2D_MULTISAMPLE_ARRAY")
	static var SAMPLER_2D_MULTISAMPLE_ARRAY:Int;
	@:native("GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY")
	static var INT_SAMPLER_2D_MULTISAMPLE_ARRAY:Int;
	@:native("GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY")
	static var UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY:Int;
	@:native("GL_MAX_COLOR_TEXTURE_SAMPLES")
	static var MAX_COLOR_TEXTURE_SAMPLES:Int;
	@:native("GL_MAX_DEPTH_TEXTURE_SAMPLES")
	static var MAX_DEPTH_TEXTURE_SAMPLES:Int;
	@:native("GL_MAX_INTEGER_SAMPLES")
	static var MAX_INTEGER_SAMPLES:Int;
	@:native("GL_VERTEX_ATTRIB_ARRAY_DIVISOR")
	static var VERTEX_ATTRIB_ARRAY_DIVISOR:Int;
	@:native("GL_SRC1_COLOR")
	static var SRC1_COLOR:Int;
	@:native("GL_ONE_MINUS_SRC1_COLOR")
	static var ONE_MINUS_SRC1_COLOR:Int;
	@:native("GL_ONE_MINUS_SRC1_ALPHA")
	static var ONE_MINUS_SRC1_ALPHA:Int;
	@:native("GL_MAX_DUAL_SOURCE_DRAW_BUFFERS")
	static var MAX_DUAL_SOURCE_DRAW_BUFFERS:Int;
	@:native("GL_ANY_SAMPLES_PASSED")
	static var ANY_SAMPLES_PASSED:Int;
	@:native("GL_SAMPLER_BINDING")
	static var SAMPLER_BINDING:Int;
	@:native("GL_RGB10_A2UI")
	static var RGB10_A2UI:Int;
	@:native("GL_TEXTURE_SWIZZLE_R")
	static var TEXTURE_SWIZZLE_R:Int;
	@:native("GL_TEXTURE_SWIZZLE_G")
	static var TEXTURE_SWIZZLE_G:Int;
	@:native("GL_TEXTURE_SWIZZLE_B")
	static var TEXTURE_SWIZZLE_B:Int;
	@:native("GL_TEXTURE_SWIZZLE_A")
	static var TEXTURE_SWIZZLE_A:Int;
	@:native("GL_TEXTURE_SWIZZLE_RGBA")
	static var TEXTURE_SWIZZLE_RGBA:Int;
	@:native("GL_TIME_ELAPSED")
	static var TIME_ELAPSED:Int;
	@:native("GL_TIMESTAMP")
	static var TIMESTAMP:Int;
	@:native("GL_INT_2_10_10_10_REV")
	static var INT_2_10_10_10_REV:Int;
	@:native("GL_SAMPLE_SHADING")
	static var SAMPLE_SHADING:Int;
	@:native("GL_MIN_SAMPLE_SHADING_VALUE")
	static var MIN_SAMPLE_SHADING_VALUE:Int;
	@:native("GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET")
	static var MIN_PROGRAM_TEXTURE_GATHER_OFFSET:Int;
	@:native("GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET")
	static var MAX_PROGRAM_TEXTURE_GATHER_OFFSET:Int;
	@:native("GL_TEXTURE_CUBE_MAP_ARRAY")
	static var TEXTURE_CUBE_MAP_ARRAY:Int;
	@:native("GL_TEXTURE_BINDING_CUBE_MAP_ARRAY")
	static var TEXTURE_BINDING_CUBE_MAP_ARRAY:Int;
	@:native("GL_PROXY_TEXTURE_CUBE_MAP_ARRAY")
	static var PROXY_TEXTURE_CUBE_MAP_ARRAY:Int;
	@:native("GL_SAMPLER_CUBE_MAP_ARRAY")
	static var SAMPLER_CUBE_MAP_ARRAY:Int;
	@:native("GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW")
	static var SAMPLER_CUBE_MAP_ARRAY_SHADOW:Int;
	@:native("GL_INT_SAMPLER_CUBE_MAP_ARRAY")
	static var INT_SAMPLER_CUBE_MAP_ARRAY:Int;
	@:native("GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY")
	static var UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY:Int;
	@:native("GL_DRAW_INDIRECT_BUFFER")
	static var DRAW_INDIRECT_BUFFER:Int;
	@:native("GL_DRAW_INDIRECT_BUFFER_BINDING")
	static var DRAW_INDIRECT_BUFFER_BINDING:Int;
	@:native("GL_GEOMETRY_SHADER_INVOCATIONS")
	static var GEOMETRY_SHADER_INVOCATIONS:Int;
	@:native("GL_MAX_GEOMETRY_SHADER_INVOCATIONS")
	static var MAX_GEOMETRY_SHADER_INVOCATIONS:Int;
	@:native("GL_MIN_FRAGMENT_INTERPOLATION_OFFSET")
	static var MIN_FRAGMENT_INTERPOLATION_OFFSET:Int;
	@:native("GL_MAX_FRAGMENT_INTERPOLATION_OFFSET")
	static var MAX_FRAGMENT_INTERPOLATION_OFFSET:Int;
	@:native("GL_FRAGMENT_INTERPOLATION_OFFSET_BITS")
	static var FRAGMENT_INTERPOLATION_OFFSET_BITS:Int;
	@:native("GL_MAX_VERTEX_STREAMS")
	static var MAX_VERTEX_STREAMS:Int;
	@:native("GL_DOUBLE_VEC2")
	static var DOUBLE_VEC2:Int;
	@:native("GL_DOUBLE_VEC3")
	static var DOUBLE_VEC3:Int;
	@:native("GL_DOUBLE_VEC4")
	static var DOUBLE_VEC4:Int;
	@:native("GL_DOUBLE_MAT2")
	static var DOUBLE_MAT2:Int;
	@:native("GL_DOUBLE_MAT3")
	static var DOUBLE_MAT3:Int;
	@:native("GL_DOUBLE_MAT4")
	static var DOUBLE_MAT4:Int;
	@:native("GL_DOUBLE_MAT2x3")
	static var DOUBLE_MAT2x3:Int;
	@:native("GL_DOUBLE_MAT2x4")
	static var DOUBLE_MAT2x4:Int;
	@:native("GL_DOUBLE_MAT3x2")
	static var DOUBLE_MAT3x2:Int;
	@:native("GL_DOUBLE_MAT3x4")
	static var DOUBLE_MAT3x4:Int;
	@:native("GL_DOUBLE_MAT4x2")
	static var DOUBLE_MAT4x2:Int;
	@:native("GL_DOUBLE_MAT4x3")
	static var DOUBLE_MAT4x3:Int;
	@:native("GL_ACTIVE_SUBROUTINES")
	static var ACTIVE_SUBROUTINES:Int;
	@:native("GL_ACTIVE_SUBROUTINE_UNIFORMS")
	static var ACTIVE_SUBROUTINE_UNIFORMS:Int;
	@:native("GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS")
	static var ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS:Int;
	@:native("GL_ACTIVE_SUBROUTINE_MAX_LENGTH")
	static var ACTIVE_SUBROUTINE_MAX_LENGTH:Int;
	@:native("GL_ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH")
	static var ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH:Int;
	@:native("GL_MAX_SUBROUTINES")
	static var MAX_SUBROUTINES:Int;
	@:native("GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS")
	static var MAX_SUBROUTINE_UNIFORM_LOCATIONS:Int;
	@:native("GL_NUM_COMPATIBLE_SUBROUTINES")
	static var NUM_COMPATIBLE_SUBROUTINES:Int;
	@:native("GL_COMPATIBLE_SUBROUTINES")
	static var COMPATIBLE_SUBROUTINES:Int;
	@:native("GL_PATCHES")
	static var PATCHES:Int;
	@:native("GL_PATCH_VERTICES")
	static var PATCH_VERTICES:Int;
	@:native("GL_PATCH_DEFAULT_INNER_LEVEL")
	static var PATCH_DEFAULT_INNER_LEVEL:Int;
	@:native("GL_PATCH_DEFAULT_OUTER_LEVEL")
	static var PATCH_DEFAULT_OUTER_LEVEL:Int;
	@:native("GL_TESS_CONTROL_OUTPUT_VERTICES")
	static var TESS_CONTROL_OUTPUT_VERTICES:Int;
	@:native("GL_TESS_GEN_MODE")
	static var TESS_GEN_MODE:Int;
	@:native("GL_TESS_GEN_SPACING")
	static var TESS_GEN_SPACING:Int;
	@:native("GL_TESS_GEN_VERTEX_ORDER")
	static var TESS_GEN_VERTEX_ORDER:Int;
	@:native("GL_TESS_GEN_POINT_MODE")
	static var TESS_GEN_POINT_MODE:Int;
	@:native("GL_ISOLINES")
	static var ISOLINES:Int;
	@:native("GL_QUADS")
	static var QUADS:Int;
	@:native("GL_FRACTIONAL_ODD")
	static var FRACTIONAL_ODD:Int;
	@:native("GL_FRACTIONAL_EVEN")
	static var FRACTIONAL_EVEN:Int;
	@:native("GL_MAX_PATCH_VERTICES")
	static var MAX_PATCH_VERTICES:Int;
	@:native("GL_MAX_TESS_GEN_LEVEL")
	static var MAX_TESS_GEN_LEVEL:Int;
	@:native("GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS")
	static var MAX_TESS_CONTROL_UNIFORM_COMPONENTS:Int;
	@:native("GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS")
	static var MAX_TESS_EVALUATION_UNIFORM_COMPONENTS:Int;
	@:native("GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS")
	static var MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS:Int;
	@:native("GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS")
	static var MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS:Int;
	@:native("GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS")
	static var MAX_TESS_CONTROL_OUTPUT_COMPONENTS:Int;
	@:native("GL_MAX_TESS_PATCH_COMPONENTS")
	static var MAX_TESS_PATCH_COMPONENTS:Int;
	@:native("GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS")
	static var MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS:Int;
	@:native("GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS")
	static var MAX_TESS_EVALUATION_OUTPUT_COMPONENTS:Int;
	@:native("GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS")
	static var MAX_TESS_CONTROL_UNIFORM_BLOCKS:Int;
	@:native("GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS")
	static var MAX_TESS_EVALUATION_UNIFORM_BLOCKS:Int;
	@:native("GL_MAX_TESS_CONTROL_INPUT_COMPONENTS")
	static var MAX_TESS_CONTROL_INPUT_COMPONENTS:Int;
	@:native("GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS")
	static var MAX_TESS_EVALUATION_INPUT_COMPONENTS:Int;
	@:native("GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS")
	static var MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS:Int;
	@:native("GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS")
	static var MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS:Int;
	@:native("GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_CONTROL_SHADER")
	static var UNIFORM_BLOCK_REFERENCED_BY_TESS_CONTROL_SHADER:Int;
	@:native("GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_EVALUATION_SHADER")
	static var UNIFORM_BLOCK_REFERENCED_BY_TESS_EVALUATION_SHADER:Int;
	@:native("GL_TESS_EVALUATION_SHADER")
	static var TESS_EVALUATION_SHADER:Int;
	@:native("GL_TESS_CONTROL_SHADER")
	static var TESS_CONTROL_SHADER:Int;
	@:native("GL_TRANSFORM_FEEDBACK")
	static var TRANSFORM_FEEDBACK:Int;
	@:native("GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED")
	static var TRANSFORM_FEEDBACK_BUFFER_PAUSED:Int;
	@:native("GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE")
	static var TRANSFORM_FEEDBACK_BUFFER_ACTIVE:Int;
	@:native("GL_TRANSFORM_FEEDBACK_BINDING")
	static var TRANSFORM_FEEDBACK_BINDING:Int;
	@:native("GL_MAX_TRANSFORM_FEEDBACK_BUFFERS")
	static var MAX_TRANSFORM_FEEDBACK_BUFFERS:Int;
	@:native("GL_FIXED")
	static var FIXED:Int;
	@:native("GL_IMPLEMENTATION_COLOR_READ_TYPE")
	static var IMPLEMENTATION_COLOR_READ_TYPE:Int;
	@:native("GL_IMPLEMENTATION_COLOR_READ_FORMAT")
	static var IMPLEMENTATION_COLOR_READ_FORMAT:Int;
	@:native("GL_LOW_FLOAT")
	static var LOW_FLOAT:Int;
	@:native("GL_MEDIUM_FLOAT")
	static var MEDIUM_FLOAT:Int;
	@:native("GL_HIGH_FLOAT")
	static var HIGH_FLOAT:Int;
	@:native("GL_LOW_INT")
	static var LOW_INT:Int;
	@:native("GL_MEDIUM_INT")
	static var MEDIUM_INT:Int;
	@:native("GL_HIGH_INT")
	static var HIGH_INT:Int;
	@:native("GL_SHADER_COMPILER")
	static var SHADER_COMPILER:Int;
	@:native("GL_SHADER_BINARY_FORMATS")
	static var SHADER_BINARY_FORMATS:Int;
	@:native("GL_NUM_SHADER_BINARY_FORMATS")
	static var NUM_SHADER_BINARY_FORMATS:Int;
	@:native("GL_MAX_VERTEX_UNIFORM_VECTORS")
	static var MAX_VERTEX_UNIFORM_VECTORS:Int;
	@:native("GL_MAX_VARYING_VECTORS")
	static var MAX_VARYING_VECTORS:Int;
	@:native("GL_MAX_FRAGMENT_UNIFORM_VECTORS")
	static var MAX_FRAGMENT_UNIFORM_VECTORS:Int;
	@:native("GL_RGB565")
	static var RGB565:Int;
	@:native("GL_PROGRAM_BINARY_RETRIEVABLE_HINT")
	static var PROGRAM_BINARY_RETRIEVABLE_HINT:Int;
	@:native("GL_PROGRAM_BINARY_LENGTH")
	static var PROGRAM_BINARY_LENGTH:Int;
	@:native("GL_NUM_PROGRAM_BINARY_FORMATS")
	static var NUM_PROGRAM_BINARY_FORMATS:Int;
	@:native("GL_PROGRAM_BINARY_FORMATS")
	static var PROGRAM_BINARY_FORMATS:Int;
	@:native("GL_VERTEX_SHADER_BIT")
	static var VERTEX_SHADER_BIT:Int;
	@:native("GL_FRAGMENT_SHADER_BIT")
	static var FRAGMENT_SHADER_BIT:Int;
	@:native("GL_GEOMETRY_SHADER_BIT")
	static var GEOMETRY_SHADER_BIT:Int;
	@:native("GL_TESS_CONTROL_SHADER_BIT")
	static var TESS_CONTROL_SHADER_BIT:Int;
	@:native("GL_TESS_EVALUATION_SHADER_BIT")
	static var TESS_EVALUATION_SHADER_BIT:Int;
	@:native("GL_ALL_SHADER_BITS")
	static var ALL_SHADER_BITS:Int;
	@:native("GL_PROGRAM_SEPARABLE")
	static var PROGRAM_SEPARABLE:Int;
	@:native("GL_ACTIVE_PROGRAM")
	static var ACTIVE_PROGRAM:Int;
	@:native("GL_PROGRAM_PIPELINE_BINDING")
	static var PROGRAM_PIPELINE_BINDING:Int;
	@:native("GL_MAX_VIEWPORTS")
	static var MAX_VIEWPORTS:Int;
	@:native("GL_VIEWPORT_SUBPIXEL_BITS")
	static var VIEWPORT_SUBPIXEL_BITS:Int;
	@:native("GL_VIEWPORT_BOUNDS_RANGE")
	static var VIEWPORT_BOUNDS_RANGE:Int;
	@:native("GL_LAYER_PROVOKING_VERTEX")
	static var LAYER_PROVOKING_VERTEX:Int;
	@:native("GL_VIEWPORT_INDEX_PROVOKING_VERTEX")
	static var VIEWPORT_INDEX_PROVOKING_VERTEX:Int;
	@:native("GL_UNDEFINED_VERTEX")
	static var UNDEFINED_VERTEX:Int;
	@:native("GL_COPY_READ_BUFFER_BINDING")
	static var COPY_READ_BUFFER_BINDING:Int;
	@:native("GL_COPY_WRITE_BUFFER_BINDING")
	static var COPY_WRITE_BUFFER_BINDING:Int;
	@:native("GL_TRANSFORM_FEEDBACK_ACTIVE")
	static var TRANSFORM_FEEDBACK_ACTIVE:Int;
	@:native("GL_TRANSFORM_FEEDBACK_PAUSED")
	static var TRANSFORM_FEEDBACK_PAUSED:Int;
	@:native("GL_UNPACK_COMPRESSED_BLOCK_WIDTH")
	static var UNPACK_COMPRESSED_BLOCK_WIDTH:Int;
	@:native("GL_UNPACK_COMPRESSED_BLOCK_HEIGHT")
	static var UNPACK_COMPRESSED_BLOCK_HEIGHT:Int;
	@:native("GL_UNPACK_COMPRESSED_BLOCK_DEPTH")
	static var UNPACK_COMPRESSED_BLOCK_DEPTH:Int;
	@:native("GL_UNPACK_COMPRESSED_BLOCK_SIZE")
	static var UNPACK_COMPRESSED_BLOCK_SIZE:Int;
	@:native("GL_PACK_COMPRESSED_BLOCK_WIDTH")
	static var PACK_COMPRESSED_BLOCK_WIDTH:Int;
	@:native("GL_PACK_COMPRESSED_BLOCK_HEIGHT")
	static var PACK_COMPRESSED_BLOCK_HEIGHT:Int;
	@:native("GL_PACK_COMPRESSED_BLOCK_DEPTH")
	static var PACK_COMPRESSED_BLOCK_DEPTH:Int;
	@:native("GL_PACK_COMPRESSED_BLOCK_SIZE")
	static var PACK_COMPRESSED_BLOCK_SIZE:Int;
	@:native("GL_NUM_SAMPLE_COUNTS")
	static var NUM_SAMPLE_COUNTS:Int;
	@:native("GL_MIN_MAP_BUFFER_ALIGNMENT")
	static var MIN_MAP_BUFFER_ALIGNMENT:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER")
	static var ATOMIC_COUNTER_BUFFER:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_BINDING")
	static var ATOMIC_COUNTER_BUFFER_BINDING:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_START")
	static var ATOMIC_COUNTER_BUFFER_START:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_SIZE")
	static var ATOMIC_COUNTER_BUFFER_SIZE:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_DATA_SIZE")
	static var ATOMIC_COUNTER_BUFFER_DATA_SIZE:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTERS")
	static var ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTERS:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTER_INDICES")
	static var ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTER_INDICES:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_VERTEX_SHADER")
	static var ATOMIC_COUNTER_BUFFER_REFERENCED_BY_VERTEX_SHADER:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_CONTROL_SHADER")
	static var ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_CONTROL_SHADER:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_EVALUATION_SHADER")
	static var ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_EVALUATION_SHADER:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_GEOMETRY_SHADER")
	static var ATOMIC_COUNTER_BUFFER_REFERENCED_BY_GEOMETRY_SHADER:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_FRAGMENT_SHADER")
	static var ATOMIC_COUNTER_BUFFER_REFERENCED_BY_FRAGMENT_SHADER:Int;
	@:native("GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS")
	static var MAX_VERTEX_ATOMIC_COUNTER_BUFFERS:Int;
	@:native("GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS")
	static var MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS:Int;
	@:native("GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS")
	static var MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS:Int;
	@:native("GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS")
	static var MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS:Int;
	@:native("GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS")
	static var MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS:Int;
	@:native("GL_MAX_COMBINED_ATOMIC_COUNTER_BUFFERS")
	static var MAX_COMBINED_ATOMIC_COUNTER_BUFFERS:Int;
	@:native("GL_MAX_VERTEX_ATOMIC_COUNTERS")
	static var MAX_VERTEX_ATOMIC_COUNTERS:Int;
	@:native("GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS")
	static var MAX_TESS_CONTROL_ATOMIC_COUNTERS:Int;
	@:native("GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS")
	static var MAX_TESS_EVALUATION_ATOMIC_COUNTERS:Int;
	@:native("GL_MAX_GEOMETRY_ATOMIC_COUNTERS")
	static var MAX_GEOMETRY_ATOMIC_COUNTERS:Int;
	@:native("GL_MAX_FRAGMENT_ATOMIC_COUNTERS")
	static var MAX_FRAGMENT_ATOMIC_COUNTERS:Int;
	@:native("GL_MAX_COMBINED_ATOMIC_COUNTERS")
	static var MAX_COMBINED_ATOMIC_COUNTERS:Int;
	@:native("GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE")
	static var MAX_ATOMIC_COUNTER_BUFFER_SIZE:Int;
	@:native("GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS")
	static var MAX_ATOMIC_COUNTER_BUFFER_BINDINGS:Int;
	@:native("GL_ACTIVE_ATOMIC_COUNTER_BUFFERS")
	static var ACTIVE_ATOMIC_COUNTER_BUFFERS:Int;
	@:native("GL_UNIFORM_ATOMIC_COUNTER_BUFFER_INDEX")
	static var UNIFORM_ATOMIC_COUNTER_BUFFER_INDEX:Int;
	@:native("GL_UNSIGNED_INT_ATOMIC_COUNTER")
	static var UNSIGNED_INT_ATOMIC_COUNTER:Int;
	@:native("GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT")
	static var VERTEX_ATTRIB_ARRAY_BARRIER_BIT:Int;
	@:native("GL_ELEMENT_ARRAY_BARRIER_BIT")
	static var ELEMENT_ARRAY_BARRIER_BIT:Int;
	@:native("GL_UNIFORM_BARRIER_BIT")
	static var UNIFORM_BARRIER_BIT:Int;
	@:native("GL_TEXTURE_FETCH_BARRIER_BIT")
	static var TEXTURE_FETCH_BARRIER_BIT:Int;
	@:native("GL_SHADER_IMAGE_ACCESS_BARRIER_BIT")
	static var SHADER_IMAGE_ACCESS_BARRIER_BIT:Int;
	@:native("GL_COMMAND_BARRIER_BIT")
	static var COMMAND_BARRIER_BIT:Int;
	@:native("GL_PIXEL_BUFFER_BARRIER_BIT")
	static var PIXEL_BUFFER_BARRIER_BIT:Int;
	@:native("GL_TEXTURE_UPDATE_BARRIER_BIT")
	static var TEXTURE_UPDATE_BARRIER_BIT:Int;
	@:native("GL_BUFFER_UPDATE_BARRIER_BIT")
	static var BUFFER_UPDATE_BARRIER_BIT:Int;
	@:native("GL_FRAMEBUFFER_BARRIER_BIT")
	static var FRAMEBUFFER_BARRIER_BIT:Int;
	@:native("GL_TRANSFORM_FEEDBACK_BARRIER_BIT")
	static var TRANSFORM_FEEDBACK_BARRIER_BIT:Int;
	@:native("GL_ATOMIC_COUNTER_BARRIER_BIT")
	static var ATOMIC_COUNTER_BARRIER_BIT:Int;
	@:native("GL_ALL_BARRIER_BITS")
	static var ALL_BARRIER_BITS:Int;
	@:native("GL_MAX_IMAGE_UNITS")
	static var MAX_IMAGE_UNITS:Int;
	@:native("GL_MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS")
	static var MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS:Int;
	@:native("GL_IMAGE_BINDING_NAME")
	static var IMAGE_BINDING_NAME:Int;
	@:native("GL_IMAGE_BINDING_LEVEL")
	static var IMAGE_BINDING_LEVEL:Int;
	@:native("GL_IMAGE_BINDING_LAYERED")
	static var IMAGE_BINDING_LAYERED:Int;
	@:native("GL_IMAGE_BINDING_LAYER")
	static var IMAGE_BINDING_LAYER:Int;
	@:native("GL_IMAGE_BINDING_ACCESS")
	static var IMAGE_BINDING_ACCESS:Int;
	@:native("GL_IMAGE_1D")
	static var IMAGE_1D:Int;
	@:native("GL_IMAGE_2D")
	static var IMAGE_2D:Int;
	@:native("GL_IMAGE_3D")
	static var IMAGE_3D:Int;
	@:native("GL_IMAGE_2D_RECT")
	static var IMAGE_2D_RECT:Int;
	@:native("GL_IMAGE_CUBE")
	static var IMAGE_CUBE:Int;
	@:native("GL_IMAGE_BUFFER")
	static var IMAGE_BUFFER:Int;
	@:native("GL_IMAGE_1D_ARRAY")
	static var IMAGE_1D_ARRAY:Int;
	@:native("GL_IMAGE_2D_ARRAY")
	static var IMAGE_2D_ARRAY:Int;
	@:native("GL_IMAGE_CUBE_MAP_ARRAY")
	static var IMAGE_CUBE_MAP_ARRAY:Int;
	@:native("GL_IMAGE_2D_MULTISAMPLE")
	static var IMAGE_2D_MULTISAMPLE:Int;
	@:native("GL_IMAGE_2D_MULTISAMPLE_ARRAY")
	static var IMAGE_2D_MULTISAMPLE_ARRAY:Int;
	@:native("GL_INT_IMAGE_1D")
	static var INT_IMAGE_1D:Int;
	@:native("GL_INT_IMAGE_2D")
	static var INT_IMAGE_2D:Int;
	@:native("GL_INT_IMAGE_3D")
	static var INT_IMAGE_3D:Int;
	@:native("GL_INT_IMAGE_2D_RECT")
	static var INT_IMAGE_2D_RECT:Int;
	@:native("GL_INT_IMAGE_CUBE")
	static var INT_IMAGE_CUBE:Int;
	@:native("GL_INT_IMAGE_BUFFER")
	static var INT_IMAGE_BUFFER:Int;
	@:native("GL_INT_IMAGE_1D_ARRAY")
	static var INT_IMAGE_1D_ARRAY:Int;
	@:native("GL_INT_IMAGE_2D_ARRAY")
	static var INT_IMAGE_2D_ARRAY:Int;
	@:native("GL_INT_IMAGE_CUBE_MAP_ARRAY")
	static var INT_IMAGE_CUBE_MAP_ARRAY:Int;
	@:native("GL_INT_IMAGE_2D_MULTISAMPLE")
	static var INT_IMAGE_2D_MULTISAMPLE:Int;
	@:native("GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY")
	static var INT_IMAGE_2D_MULTISAMPLE_ARRAY:Int;
	@:native("GL_UNSIGNED_INT_IMAGE_1D")
	static var UNSIGNED_INT_IMAGE_1D:Int;
	@:native("GL_UNSIGNED_INT_IMAGE_2D")
	static var UNSIGNED_INT_IMAGE_2D:Int;
	@:native("GL_UNSIGNED_INT_IMAGE_3D")
	static var UNSIGNED_INT_IMAGE_3D:Int;
	@:native("GL_UNSIGNED_INT_IMAGE_2D_RECT")
	static var UNSIGNED_INT_IMAGE_2D_RECT:Int;
	@:native("GL_UNSIGNED_INT_IMAGE_CUBE")
	static var UNSIGNED_INT_IMAGE_CUBE:Int;
	@:native("GL_UNSIGNED_INT_IMAGE_BUFFER")
	static var UNSIGNED_INT_IMAGE_BUFFER:Int;
	@:native("GL_UNSIGNED_INT_IMAGE_1D_ARRAY")
	static var UNSIGNED_INT_IMAGE_1D_ARRAY:Int;
	@:native("GL_UNSIGNED_INT_IMAGE_2D_ARRAY")
	static var UNSIGNED_INT_IMAGE_2D_ARRAY:Int;
	@:native("GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY")
	static var UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY:Int;
	@:native("GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE")
	static var UNSIGNED_INT_IMAGE_2D_MULTISAMPLE:Int;
	@:native("GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY")
	static var UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY:Int;
	@:native("GL_MAX_IMAGE_SAMPLES")
	static var MAX_IMAGE_SAMPLES:Int;
	@:native("GL_IMAGE_BINDING_FORMAT")
	static var IMAGE_BINDING_FORMAT:Int;
	@:native("GL_IMAGE_FORMAT_COMPATIBILITY_TYPE")
	static var IMAGE_FORMAT_COMPATIBILITY_TYPE:Int;
	@:native("GL_IMAGE_FORMAT_COMPATIBILITY_BY_SIZE")
	static var IMAGE_FORMAT_COMPATIBILITY_BY_SIZE:Int;
	@:native("GL_IMAGE_FORMAT_COMPATIBILITY_BY_CLASS")
	static var IMAGE_FORMAT_COMPATIBILITY_BY_CLASS:Int;
	@:native("GL_MAX_VERTEX_IMAGE_UNIFORMS")
	static var MAX_VERTEX_IMAGE_UNIFORMS:Int;
	@:native("GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS")
	static var MAX_TESS_CONTROL_IMAGE_UNIFORMS:Int;
	@:native("GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS")
	static var MAX_TESS_EVALUATION_IMAGE_UNIFORMS:Int;
	@:native("GL_MAX_GEOMETRY_IMAGE_UNIFORMS")
	static var MAX_GEOMETRY_IMAGE_UNIFORMS:Int;
	@:native("GL_MAX_FRAGMENT_IMAGE_UNIFORMS")
	static var MAX_FRAGMENT_IMAGE_UNIFORMS:Int;
	@:native("GL_MAX_COMBINED_IMAGE_UNIFORMS")
	static var MAX_COMBINED_IMAGE_UNIFORMS:Int;
	@:native("GL_COMPRESSED_RGBA_BPTC_UNORM")
	static var COMPRESSED_RGBA_BPTC_UNORM:Int;
	@:native("GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM")
	static var COMPRESSED_SRGB_ALPHA_BPTC_UNORM:Int;
	@:native("GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT")
	static var COMPRESSED_RGB_BPTC_SIGNED_FLOAT:Int;
	@:native("GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT")
	static var COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT:Int;
	@:native("GL_TEXTURE_IMMUTABLE_FORMAT")
	static var TEXTURE_IMMUTABLE_FORMAT:Int;
	@:native("GL_NUM_SHADING_LANGUAGE_VERSIONS")
	static var NUM_SHADING_LANGUAGE_VERSIONS:Int;
	@:native("GL_VERTEX_ATTRIB_ARRAY_LONG")
	static var VERTEX_ATTRIB_ARRAY_LONG:Int;
	@:native("GL_COMPRESSED_RGB8_ETC2")
	static var COMPRESSED_RGB8_ETC2:Int;
	@:native("GL_COMPRESSED_SRGB8_ETC2")
	static var COMPRESSED_SRGB8_ETC2:Int;
	@:native("GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2")
	static var COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2:Int;
	@:native("GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2")
	static var COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2:Int;
	@:native("GL_COMPRESSED_RGBA8_ETC2_EAC")
	static var COMPRESSED_RGBA8_ETC2_EAC:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC")
	static var COMPRESSED_SRGB8_ALPHA8_ETC2_EAC:Int;
	@:native("GL_COMPRESSED_R11_EAC")
	static var COMPRESSED_R11_EAC:Int;
	@:native("GL_COMPRESSED_SIGNED_R11_EAC")
	static var COMPRESSED_SIGNED_R11_EAC:Int;
	@:native("GL_COMPRESSED_RG11_EAC")
	static var COMPRESSED_RG11_EAC:Int;
	@:native("GL_COMPRESSED_SIGNED_RG11_EAC")
	static var COMPRESSED_SIGNED_RG11_EAC:Int;
	@:native("GL_PRIMITIVE_RESTART_FIXED_INDEX")
	static var PRIMITIVE_RESTART_FIXED_INDEX:Int;
	@:native("GL_ANY_SAMPLES_PASSED_CONSERVATIVE")
	static var ANY_SAMPLES_PASSED_CONSERVATIVE:Int;
	@:native("GL_MAX_ELEMENT_INDEX")
	static var MAX_ELEMENT_INDEX:Int;
	@:native("GL_COMPUTE_SHADER")
	static var COMPUTE_SHADER:Int;
	@:native("GL_MAX_COMPUTE_UNIFORM_BLOCKS")
	static var MAX_COMPUTE_UNIFORM_BLOCKS:Int;
	@:native("GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS")
	static var MAX_COMPUTE_TEXTURE_IMAGE_UNITS:Int;
	@:native("GL_MAX_COMPUTE_IMAGE_UNIFORMS")
	static var MAX_COMPUTE_IMAGE_UNIFORMS:Int;
	@:native("GL_MAX_COMPUTE_SHARED_MEMORY_SIZE")
	static var MAX_COMPUTE_SHARED_MEMORY_SIZE:Int;
	@:native("GL_MAX_COMPUTE_UNIFORM_COMPONENTS")
	static var MAX_COMPUTE_UNIFORM_COMPONENTS:Int;
	@:native("GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS")
	static var MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS:Int;
	@:native("GL_MAX_COMPUTE_ATOMIC_COUNTERS")
	static var MAX_COMPUTE_ATOMIC_COUNTERS:Int;
	@:native("GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS")
	static var MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS:Int;
	@:native("GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS")
	static var MAX_COMPUTE_WORK_GROUP_INVOCATIONS:Int;
	@:native("GL_MAX_COMPUTE_WORK_GROUP_COUNT")
	static var MAX_COMPUTE_WORK_GROUP_COUNT:Int;
	@:native("GL_MAX_COMPUTE_WORK_GROUP_SIZE")
	static var MAX_COMPUTE_WORK_GROUP_SIZE:Int;
	@:native("GL_COMPUTE_WORK_GROUP_SIZE")
	static var COMPUTE_WORK_GROUP_SIZE:Int;
	@:native("GL_UNIFORM_BLOCK_REFERENCED_BY_COMPUTE_SHADER")
	static var UNIFORM_BLOCK_REFERENCED_BY_COMPUTE_SHADER:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_COMPUTE_SHADER")
	static var ATOMIC_COUNTER_BUFFER_REFERENCED_BY_COMPUTE_SHADER:Int;
	@:native("GL_DISPATCH_INDIRECT_BUFFER")
	static var DISPATCH_INDIRECT_BUFFER:Int;
	@:native("GL_DISPATCH_INDIRECT_BUFFER_BINDING")
	static var DISPATCH_INDIRECT_BUFFER_BINDING:Int;
	@:native("GL_COMPUTE_SHADER_BIT")
	static var COMPUTE_SHADER_BIT:Int;
	@:native("GL_DEBUG_OUTPUT_SYNCHRONOUS")
	static var DEBUG_OUTPUT_SYNCHRONOUS:Int;
	@:native("GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH")
	static var DEBUG_NEXT_LOGGED_MESSAGE_LENGTH:Int;
	@:native("GL_DEBUG_CALLBACK_FUNCTION")
	static var DEBUG_CALLBACK_FUNCTION:Int;
	@:native("GL_DEBUG_CALLBACK_USER_PARAM")
	static var DEBUG_CALLBACK_USER_PARAM:Int;
	@:native("GL_DEBUG_SOURCE_API")
	static var DEBUG_SOURCE_API:Int;
	@:native("GL_DEBUG_SOURCE_WINDOW_SYSTEM")
	static var DEBUG_SOURCE_WINDOW_SYSTEM:Int;
	@:native("GL_DEBUG_SOURCE_SHADER_COMPILER")
	static var DEBUG_SOURCE_SHADER_COMPILER:Int;
	@:native("GL_DEBUG_SOURCE_THIRD_PARTY")
	static var DEBUG_SOURCE_THIRD_PARTY:Int;
	@:native("GL_DEBUG_SOURCE_APPLICATION")
	static var DEBUG_SOURCE_APPLICATION:Int;
	@:native("GL_DEBUG_SOURCE_OTHER")
	static var DEBUG_SOURCE_OTHER:Int;
	@:native("GL_DEBUG_TYPE_ERROR")
	static var DEBUG_TYPE_ERROR:Int;
	@:native("GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR")
	static var DEBUG_TYPE_DEPRECATED_BEHAVIOR:Int;
	@:native("GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR")
	static var DEBUG_TYPE_UNDEFINED_BEHAVIOR:Int;
	@:native("GL_DEBUG_TYPE_PORTABILITY")
	static var DEBUG_TYPE_PORTABILITY:Int;
	@:native("GL_DEBUG_TYPE_PERFORMANCE")
	static var DEBUG_TYPE_PERFORMANCE:Int;
	@:native("GL_DEBUG_TYPE_OTHER")
	static var DEBUG_TYPE_OTHER:Int;
	@:native("GL_MAX_DEBUG_MESSAGE_LENGTH")
	static var MAX_DEBUG_MESSAGE_LENGTH:Int;
	@:native("GL_MAX_DEBUG_LOGGED_MESSAGES")
	static var MAX_DEBUG_LOGGED_MESSAGES:Int;
	@:native("GL_DEBUG_LOGGED_MESSAGES")
	static var DEBUG_LOGGED_MESSAGES:Int;
	@:native("GL_DEBUG_SEVERITY_HIGH")
	static var DEBUG_SEVERITY_HIGH:Int;
	@:native("GL_DEBUG_SEVERITY_MEDIUM")
	static var DEBUG_SEVERITY_MEDIUM:Int;
	@:native("GL_DEBUG_SEVERITY_LOW")
	static var DEBUG_SEVERITY_LOW:Int;
	@:native("GL_DEBUG_TYPE_MARKER")
	static var DEBUG_TYPE_MARKER:Int;
	@:native("GL_DEBUG_TYPE_PUSH_GROUP")
	static var DEBUG_TYPE_PUSH_GROUP:Int;
	@:native("GL_DEBUG_TYPE_POP_GROUP")
	static var DEBUG_TYPE_POP_GROUP:Int;
	@:native("GL_DEBUG_SEVERITY_NOTIFICATION")
	static var DEBUG_SEVERITY_NOTIFICATION:Int;
	@:native("GL_MAX_DEBUG_GROUP_STACK_DEPTH")
	static var MAX_DEBUG_GROUP_STACK_DEPTH:Int;
	@:native("GL_DEBUG_GROUP_STACK_DEPTH")
	static var DEBUG_GROUP_STACK_DEPTH:Int;
	@:native("GL_BUFFER")
	static var BUFFER:Int;
	@:native("GL_SHADER")
	static var SHADER:Int;
	@:native("GL_PROGRAM")
	static var PROGRAM:Int;
	@:native("GL_VERTEX_ARRAY")
	static var VERTEX_ARRAY:Int;
	@:native("GL_QUERY")
	static var QUERY:Int;
	@:native("GL_PROGRAM_PIPELINE")
	static var PROGRAM_PIPELINE:Int;
	@:native("GL_SAMPLER")
	static var SAMPLER:Int;
	@:native("GL_MAX_LABEL_LENGTH")
	static var MAX_LABEL_LENGTH:Int;
	@:native("GL_DEBUG_OUTPUT")
	static var DEBUG_OUTPUT:Int;
	@:native("GL_CONTEXT_FLAG_DEBUG_BIT")
	static var CONTEXT_FLAG_DEBUG_BIT:Int;
	@:native("GL_MAX_UNIFORM_LOCATIONS")
	static var MAX_UNIFORM_LOCATIONS:Int;
	@:native("GL_FRAMEBUFFER_DEFAULT_WIDTH")
	static var FRAMEBUFFER_DEFAULT_WIDTH:Int;
	@:native("GL_FRAMEBUFFER_DEFAULT_HEIGHT")
	static var FRAMEBUFFER_DEFAULT_HEIGHT:Int;
	@:native("GL_FRAMEBUFFER_DEFAULT_LAYERS")
	static var FRAMEBUFFER_DEFAULT_LAYERS:Int;
	@:native("GL_FRAMEBUFFER_DEFAULT_SAMPLES")
	static var FRAMEBUFFER_DEFAULT_SAMPLES:Int;
	@:native("GL_FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS")
	static var FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS:Int;
	@:native("GL_MAX_FRAMEBUFFER_WIDTH")
	static var MAX_FRAMEBUFFER_WIDTH:Int;
	@:native("GL_MAX_FRAMEBUFFER_HEIGHT")
	static var MAX_FRAMEBUFFER_HEIGHT:Int;
	@:native("GL_MAX_FRAMEBUFFER_LAYERS")
	static var MAX_FRAMEBUFFER_LAYERS:Int;
	@:native("GL_MAX_FRAMEBUFFER_SAMPLES")
	static var MAX_FRAMEBUFFER_SAMPLES:Int;
	@:native("GL_INTERNALFORMAT_SUPPORTED")
	static var INTERNALFORMAT_SUPPORTED:Int;
	@:native("GL_INTERNALFORMAT_PREFERRED")
	static var INTERNALFORMAT_PREFERRED:Int;
	@:native("GL_INTERNALFORMAT_RED_SIZE")
	static var INTERNALFORMAT_RED_SIZE:Int;
	@:native("GL_INTERNALFORMAT_GREEN_SIZE")
	static var INTERNALFORMAT_GREEN_SIZE:Int;
	@:native("GL_INTERNALFORMAT_BLUE_SIZE")
	static var INTERNALFORMAT_BLUE_SIZE:Int;
	@:native("GL_INTERNALFORMAT_ALPHA_SIZE")
	static var INTERNALFORMAT_ALPHA_SIZE:Int;
	@:native("GL_INTERNALFORMAT_DEPTH_SIZE")
	static var INTERNALFORMAT_DEPTH_SIZE:Int;
	@:native("GL_INTERNALFORMAT_STENCIL_SIZE")
	static var INTERNALFORMAT_STENCIL_SIZE:Int;
	@:native("GL_INTERNALFORMAT_SHARED_SIZE")
	static var INTERNALFORMAT_SHARED_SIZE:Int;
	@:native("GL_INTERNALFORMAT_RED_TYPE")
	static var INTERNALFORMAT_RED_TYPE:Int;
	@:native("GL_INTERNALFORMAT_GREEN_TYPE")
	static var INTERNALFORMAT_GREEN_TYPE:Int;
	@:native("GL_INTERNALFORMAT_BLUE_TYPE")
	static var INTERNALFORMAT_BLUE_TYPE:Int;
	@:native("GL_INTERNALFORMAT_ALPHA_TYPE")
	static var INTERNALFORMAT_ALPHA_TYPE:Int;
	@:native("GL_INTERNALFORMAT_DEPTH_TYPE")
	static var INTERNALFORMAT_DEPTH_TYPE:Int;
	@:native("GL_INTERNALFORMAT_STENCIL_TYPE")
	static var INTERNALFORMAT_STENCIL_TYPE:Int;
	@:native("GL_MAX_WIDTH")
	static var MAX_WIDTH:Int;
	@:native("GL_MAX_HEIGHT")
	static var MAX_HEIGHT:Int;
	@:native("GL_MAX_DEPTH")
	static var MAX_DEPTH:Int;
	@:native("GL_MAX_LAYERS")
	static var MAX_LAYERS:Int;
	@:native("GL_MAX_COMBINED_DIMENSIONS")
	static var MAX_COMBINED_DIMENSIONS:Int;
	@:native("GL_COLOR_COMPONENTS")
	static var COLOR_COMPONENTS:Int;
	@:native("GL_DEPTH_COMPONENTS")
	static var DEPTH_COMPONENTS:Int;
	@:native("GL_STENCIL_COMPONENTS")
	static var STENCIL_COMPONENTS:Int;
	@:native("GL_COLOR_RENDERABLE")
	static var COLOR_RENDERABLE:Int;
	@:native("GL_DEPTH_RENDERABLE")
	static var DEPTH_RENDERABLE:Int;
	@:native("GL_STENCIL_RENDERABLE")
	static var STENCIL_RENDERABLE:Int;
	@:native("GL_FRAMEBUFFER_RENDERABLE")
	static var FRAMEBUFFER_RENDERABLE:Int;
	@:native("GL_FRAMEBUFFER_RENDERABLE_LAYERED")
	static var FRAMEBUFFER_RENDERABLE_LAYERED:Int;
	@:native("GL_FRAMEBUFFER_BLEND")
	static var FRAMEBUFFER_BLEND:Int;
	@:native("GL_READ_PIXELS")
	static var READ_PIXELS:Int;
	@:native("GL_READ_PIXELS_FORMAT")
	static var READ_PIXELS_FORMAT:Int;
	@:native("GL_READ_PIXELS_TYPE")
	static var READ_PIXELS_TYPE:Int;
	@:native("GL_TEXTURE_IMAGE_FORMAT")
	static var TEXTURE_IMAGE_FORMAT:Int;
	@:native("GL_TEXTURE_IMAGE_TYPE")
	static var TEXTURE_IMAGE_TYPE:Int;
	@:native("GL_GET_TEXTURE_IMAGE_FORMAT")
	static var GET_TEXTURE_IMAGE_FORMAT:Int;
	@:native("GL_GET_TEXTURE_IMAGE_TYPE")
	static var GET_TEXTURE_IMAGE_TYPE:Int;
	@:native("GL_MIPMAP")
	static var MIPMAP:Int;
	@:native("GL_MANUAL_GENERATE_MIPMAP")
	static var MANUAL_GENERATE_MIPMAP:Int;
	@:native("GL_AUTO_GENERATE_MIPMAP")
	static var AUTO_GENERATE_MIPMAP:Int;
	@:native("GL_COLOR_ENCODING")
	static var COLOR_ENCODING:Int;
	@:native("GL_SRGB_READ")
	static var SRGB_READ:Int;
	@:native("GL_SRGB_WRITE")
	static var SRGB_WRITE:Int;
	@:native("GL_FILTER")
	static var FILTER:Int;
	@:native("GL_VERTEX_TEXTURE")
	static var VERTEX_TEXTURE:Int;
	@:native("GL_TESS_CONTROL_TEXTURE")
	static var TESS_CONTROL_TEXTURE:Int;
	@:native("GL_TESS_EVALUATION_TEXTURE")
	static var TESS_EVALUATION_TEXTURE:Int;
	@:native("GL_GEOMETRY_TEXTURE")
	static var GEOMETRY_TEXTURE:Int;
	@:native("GL_FRAGMENT_TEXTURE")
	static var FRAGMENT_TEXTURE:Int;
	@:native("GL_COMPUTE_TEXTURE")
	static var COMPUTE_TEXTURE:Int;
	@:native("GL_TEXTURE_SHADOW")
	static var TEXTURE_SHADOW:Int;
	@:native("GL_TEXTURE_GATHER")
	static var TEXTURE_GATHER:Int;
	@:native("GL_TEXTURE_GATHER_SHADOW")
	static var TEXTURE_GATHER_SHADOW:Int;
	@:native("GL_SHADER_IMAGE_LOAD")
	static var SHADER_IMAGE_LOAD:Int;
	@:native("GL_SHADER_IMAGE_STORE")
	static var SHADER_IMAGE_STORE:Int;
	@:native("GL_SHADER_IMAGE_ATOMIC")
	static var SHADER_IMAGE_ATOMIC:Int;
	@:native("GL_IMAGE_TEXEL_SIZE")
	static var IMAGE_TEXEL_SIZE:Int;
	@:native("GL_IMAGE_COMPATIBILITY_CLASS")
	static var IMAGE_COMPATIBILITY_CLASS:Int;
	@:native("GL_IMAGE_PIXEL_FORMAT")
	static var IMAGE_PIXEL_FORMAT:Int;
	@:native("GL_IMAGE_PIXEL_TYPE")
	static var IMAGE_PIXEL_TYPE:Int;
	@:native("GL_SIMULTANEOUS_TEXTURE_AND_DEPTH_TEST")
	static var SIMULTANEOUS_TEXTURE_AND_DEPTH_TEST:Int;
	@:native("GL_SIMULTANEOUS_TEXTURE_AND_STENCIL_TEST")
	static var SIMULTANEOUS_TEXTURE_AND_STENCIL_TEST:Int;
	@:native("GL_SIMULTANEOUS_TEXTURE_AND_DEPTH_WRITE")
	static var SIMULTANEOUS_TEXTURE_AND_DEPTH_WRITE:Int;
	@:native("GL_SIMULTANEOUS_TEXTURE_AND_STENCIL_WRITE")
	static var SIMULTANEOUS_TEXTURE_AND_STENCIL_WRITE:Int;
	@:native("GL_TEXTURE_COMPRESSED_BLOCK_WIDTH")
	static var TEXTURE_COMPRESSED_BLOCK_WIDTH:Int;
	@:native("GL_TEXTURE_COMPRESSED_BLOCK_HEIGHT")
	static var TEXTURE_COMPRESSED_BLOCK_HEIGHT:Int;
	@:native("GL_TEXTURE_COMPRESSED_BLOCK_SIZE")
	static var TEXTURE_COMPRESSED_BLOCK_SIZE:Int;
	@:native("GL_CLEAR_BUFFER")
	static var CLEAR_BUFFER:Int;
	@:native("GL_TEXTURE_VIEW")
	static var TEXTURE_VIEW:Int;
	@:native("GL_VIEW_COMPATIBILITY_CLASS")
	static var VIEW_COMPATIBILITY_CLASS:Int;
	@:native("GL_FULL_SUPPORT")
	static var FULL_SUPPORT:Int;
	@:native("GL_CAVEAT_SUPPORT")
	static var CAVEAT_SUPPORT:Int;
	@:native("GL_IMAGE_CLASS_4_X_32")
	static var IMAGE_CLASS_4_X_32:Int;
	@:native("GL_IMAGE_CLASS_2_X_32")
	static var IMAGE_CLASS_2_X_32:Int;
	@:native("GL_IMAGE_CLASS_1_X_32")
	static var IMAGE_CLASS_1_X_32:Int;
	@:native("GL_IMAGE_CLASS_4_X_16")
	static var IMAGE_CLASS_4_X_16:Int;
	@:native("GL_IMAGE_CLASS_2_X_16")
	static var IMAGE_CLASS_2_X_16:Int;
	@:native("GL_IMAGE_CLASS_1_X_16")
	static var IMAGE_CLASS_1_X_16:Int;
	@:native("GL_IMAGE_CLASS_4_X_8")
	static var IMAGE_CLASS_4_X_8:Int;
	@:native("GL_IMAGE_CLASS_2_X_8")
	static var IMAGE_CLASS_2_X_8:Int;
	@:native("GL_IMAGE_CLASS_1_X_8")
	static var IMAGE_CLASS_1_X_8:Int;
	@:native("GL_IMAGE_CLASS_11_11_10")
	static var IMAGE_CLASS_11_11_10:Int;
	@:native("GL_IMAGE_CLASS_10_10_10_2")
	static var IMAGE_CLASS_10_10_10_2:Int;
	@:native("GL_VIEW_CLASS_128_BITS")
	static var VIEW_CLASS_128_BITS:Int;
	@:native("GL_VIEW_CLASS_96_BITS")
	static var VIEW_CLASS_96_BITS:Int;
	@:native("GL_VIEW_CLASS_64_BITS")
	static var VIEW_CLASS_64_BITS:Int;
	@:native("GL_VIEW_CLASS_48_BITS")
	static var VIEW_CLASS_48_BITS:Int;
	@:native("GL_VIEW_CLASS_32_BITS")
	static var VIEW_CLASS_32_BITS:Int;
	@:native("GL_VIEW_CLASS_24_BITS")
	static var VIEW_CLASS_24_BITS:Int;
	@:native("GL_VIEW_CLASS_16_BITS")
	static var VIEW_CLASS_16_BITS:Int;
	@:native("GL_VIEW_CLASS_8_BITS")
	static var VIEW_CLASS_8_BITS:Int;
	@:native("GL_VIEW_CLASS_S3TC_DXT1_RGB")
	static var VIEW_CLASS_S3TC_DXT1_RGB:Int;
	@:native("GL_VIEW_CLASS_S3TC_DXT1_RGBA")
	static var VIEW_CLASS_S3TC_DXT1_RGBA:Int;
	@:native("GL_VIEW_CLASS_S3TC_DXT3_RGBA")
	static var VIEW_CLASS_S3TC_DXT3_RGBA:Int;
	@:native("GL_VIEW_CLASS_S3TC_DXT5_RGBA")
	static var VIEW_CLASS_S3TC_DXT5_RGBA:Int;
	@:native("GL_VIEW_CLASS_RGTC1_RED")
	static var VIEW_CLASS_RGTC1_RED:Int;
	@:native("GL_VIEW_CLASS_RGTC2_RG")
	static var VIEW_CLASS_RGTC2_RG:Int;
	@:native("GL_VIEW_CLASS_BPTC_UNORM")
	static var VIEW_CLASS_BPTC_UNORM:Int;
	@:native("GL_VIEW_CLASS_BPTC_FLOAT")
	static var VIEW_CLASS_BPTC_FLOAT:Int;
	@:native("GL_UNIFORM")
	static var UNIFORM:Int;
	@:native("GL_UNIFORM_BLOCK")
	static var UNIFORM_BLOCK:Int;
	@:native("GL_PROGRAM_INPUT")
	static var PROGRAM_INPUT:Int;
	@:native("GL_PROGRAM_OUTPUT")
	static var PROGRAM_OUTPUT:Int;
	@:native("GL_BUFFER_VARIABLE")
	static var BUFFER_VARIABLE:Int;
	@:native("GL_SHADER_STORAGE_BLOCK")
	static var SHADER_STORAGE_BLOCK:Int;
	@:native("GL_VERTEX_SUBROUTINE")
	static var VERTEX_SUBROUTINE:Int;
	@:native("GL_TESS_CONTROL_SUBROUTINE")
	static var TESS_CONTROL_SUBROUTINE:Int;
	@:native("GL_TESS_EVALUATION_SUBROUTINE")
	static var TESS_EVALUATION_SUBROUTINE:Int;
	@:native("GL_GEOMETRY_SUBROUTINE")
	static var GEOMETRY_SUBROUTINE:Int;
	@:native("GL_FRAGMENT_SUBROUTINE")
	static var FRAGMENT_SUBROUTINE:Int;
	@:native("GL_COMPUTE_SUBROUTINE")
	static var COMPUTE_SUBROUTINE:Int;
	@:native("GL_VERTEX_SUBROUTINE_UNIFORM")
	static var VERTEX_SUBROUTINE_UNIFORM:Int;
	@:native("GL_TESS_CONTROL_SUBROUTINE_UNIFORM")
	static var TESS_CONTROL_SUBROUTINE_UNIFORM:Int;
	@:native("GL_TESS_EVALUATION_SUBROUTINE_UNIFORM")
	static var TESS_EVALUATION_SUBROUTINE_UNIFORM:Int;
	@:native("GL_GEOMETRY_SUBROUTINE_UNIFORM")
	static var GEOMETRY_SUBROUTINE_UNIFORM:Int;
	@:native("GL_FRAGMENT_SUBROUTINE_UNIFORM")
	static var FRAGMENT_SUBROUTINE_UNIFORM:Int;
	@:native("GL_COMPUTE_SUBROUTINE_UNIFORM")
	static var COMPUTE_SUBROUTINE_UNIFORM:Int;
	@:native("GL_TRANSFORM_FEEDBACK_VARYING")
	static var TRANSFORM_FEEDBACK_VARYING:Int;
	@:native("GL_ACTIVE_RESOURCES")
	static var ACTIVE_RESOURCES:Int;
	@:native("GL_MAX_NAME_LENGTH")
	static var MAX_NAME_LENGTH:Int;
	@:native("GL_MAX_NUM_ACTIVE_VARIABLES")
	static var MAX_NUM_ACTIVE_VARIABLES:Int;
	@:native("GL_MAX_NUM_COMPATIBLE_SUBROUTINES")
	static var MAX_NUM_COMPATIBLE_SUBROUTINES:Int;
	@:native("GL_NAME_LENGTH")
	static var NAME_LENGTH:Int;
	@:native("GL_TYPE")
	static var TYPE:Int;
	@:native("GL_ARRAY_SIZE")
	static var ARRAY_SIZE:Int;
	@:native("GL_OFFSET")
	static var OFFSET:Int;
	@:native("GL_BLOCK_INDEX")
	static var BLOCK_INDEX:Int;
	@:native("GL_ARRAY_STRIDE")
	static var ARRAY_STRIDE:Int;
	@:native("GL_MATRIX_STRIDE")
	static var MATRIX_STRIDE:Int;
	@:native("GL_IS_ROW_MAJOR")
	static var IS_ROW_MAJOR:Int;
	@:native("GL_ATOMIC_COUNTER_BUFFER_INDEX")
	static var ATOMIC_COUNTER_BUFFER_INDEX:Int;
	@:native("GL_BUFFER_BINDING")
	static var BUFFER_BINDING:Int;
	@:native("GL_BUFFER_DATA_SIZE")
	static var BUFFER_DATA_SIZE:Int;
	@:native("GL_NUM_ACTIVE_VARIABLES")
	static var NUM_ACTIVE_VARIABLES:Int;
	@:native("GL_ACTIVE_VARIABLES")
	static var ACTIVE_VARIABLES:Int;
	@:native("GL_REFERENCED_BY_VERTEX_SHADER")
	static var REFERENCED_BY_VERTEX_SHADER:Int;
	@:native("GL_REFERENCED_BY_TESS_CONTROL_SHADER")
	static var REFERENCED_BY_TESS_CONTROL_SHADER:Int;
	@:native("GL_REFERENCED_BY_TESS_EVALUATION_SHADER")
	static var REFERENCED_BY_TESS_EVALUATION_SHADER:Int;
	@:native("GL_REFERENCED_BY_GEOMETRY_SHADER")
	static var REFERENCED_BY_GEOMETRY_SHADER:Int;
	@:native("GL_REFERENCED_BY_FRAGMENT_SHADER")
	static var REFERENCED_BY_FRAGMENT_SHADER:Int;
	@:native("GL_REFERENCED_BY_COMPUTE_SHADER")
	static var REFERENCED_BY_COMPUTE_SHADER:Int;
	@:native("GL_TOP_LEVEL_ARRAY_SIZE")
	static var TOP_LEVEL_ARRAY_SIZE:Int;
	@:native("GL_TOP_LEVEL_ARRAY_STRIDE")
	static var TOP_LEVEL_ARRAY_STRIDE:Int;
	@:native("GL_LOCATION")
	static var LOCATION:Int;
	@:native("GL_LOCATION_INDEX")
	static var LOCATION_INDEX:Int;
	@:native("GL_IS_PER_PATCH")
	static var IS_PER_PATCH:Int;
	@:native("GL_SHADER_STORAGE_BUFFER")
	static var SHADER_STORAGE_BUFFER:Int;
	@:native("GL_SHADER_STORAGE_BUFFER_BINDING")
	static var SHADER_STORAGE_BUFFER_BINDING:Int;
	@:native("GL_SHADER_STORAGE_BUFFER_START")
	static var SHADER_STORAGE_BUFFER_START:Int;
	@:native("GL_SHADER_STORAGE_BUFFER_SIZE")
	static var SHADER_STORAGE_BUFFER_SIZE:Int;
	@:native("GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS")
	static var MAX_VERTEX_SHADER_STORAGE_BLOCKS:Int;
	@:native("GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS")
	static var MAX_GEOMETRY_SHADER_STORAGE_BLOCKS:Int;
	@:native("GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS")
	static var MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS:Int;
	@:native("GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS")
	static var MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS:Int;
	@:native("GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS")
	static var MAX_FRAGMENT_SHADER_STORAGE_BLOCKS:Int;
	@:native("GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS")
	static var MAX_COMPUTE_SHADER_STORAGE_BLOCKS:Int;
	@:native("GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS")
	static var MAX_COMBINED_SHADER_STORAGE_BLOCKS:Int;
	@:native("GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS")
	static var MAX_SHADER_STORAGE_BUFFER_BINDINGS:Int;
	@:native("GL_MAX_SHADER_STORAGE_BLOCK_SIZE")
	static var MAX_SHADER_STORAGE_BLOCK_SIZE:Int;
	@:native("GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT")
	static var SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT:Int;
	@:native("GL_SHADER_STORAGE_BARRIER_BIT")
	static var SHADER_STORAGE_BARRIER_BIT:Int;
	@:native("GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES")
	static var MAX_COMBINED_SHADER_OUTPUT_RESOURCES:Int;
	@:native("GL_DEPTH_STENCIL_TEXTURE_MODE")
	static var DEPTH_STENCIL_TEXTURE_MODE:Int;
	@:native("GL_TEXTURE_BUFFER_OFFSET")
	static var TEXTURE_BUFFER_OFFSET:Int;
	@:native("GL_TEXTURE_BUFFER_SIZE")
	static var TEXTURE_BUFFER_SIZE:Int;
	@:native("GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT")
	static var TEXTURE_BUFFER_OFFSET_ALIGNMENT:Int;
	@:native("GL_TEXTURE_VIEW_MIN_LEVEL")
	static var TEXTURE_VIEW_MIN_LEVEL:Int;
	@:native("GL_TEXTURE_VIEW_NUM_LEVELS")
	static var TEXTURE_VIEW_NUM_LEVELS:Int;
	@:native("GL_TEXTURE_VIEW_MIN_LAYER")
	static var TEXTURE_VIEW_MIN_LAYER:Int;
	@:native("GL_TEXTURE_VIEW_NUM_LAYERS")
	static var TEXTURE_VIEW_NUM_LAYERS:Int;
	@:native("GL_TEXTURE_IMMUTABLE_LEVELS")
	static var TEXTURE_IMMUTABLE_LEVELS:Int;
	@:native("GL_VERTEX_ATTRIB_BINDING")
	static var VERTEX_ATTRIB_BINDING:Int;
	@:native("GL_VERTEX_ATTRIB_RELATIVE_OFFSET")
	static var VERTEX_ATTRIB_RELATIVE_OFFSET:Int;
	@:native("GL_VERTEX_BINDING_DIVISOR")
	static var VERTEX_BINDING_DIVISOR:Int;
	@:native("GL_VERTEX_BINDING_OFFSET")
	static var VERTEX_BINDING_OFFSET:Int;
	@:native("GL_VERTEX_BINDING_STRIDE")
	static var VERTEX_BINDING_STRIDE:Int;
	@:native("GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET")
	static var MAX_VERTEX_ATTRIB_RELATIVE_OFFSET:Int;
	@:native("GL_MAX_VERTEX_ATTRIB_BINDINGS")
	static var MAX_VERTEX_ATTRIB_BINDINGS:Int;
	@:native("GL_VERTEX_BINDING_BUFFER")
	static var VERTEX_BINDING_BUFFER:Int;
	@:native("GL_DISPLAY_LIST")
	static var DISPLAY_LIST:Int;
	@:native("GL_STACK_UNDERFLOW")
	static var STACK_UNDERFLOW:Int;
	@:native("GL_STACK_OVERFLOW")
	static var STACK_OVERFLOW:Int;
	@:native("GL_MAX_VERTEX_ATTRIB_STRIDE")
	static var MAX_VERTEX_ATTRIB_STRIDE:Int;
	@:native("GL_PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED")
	static var PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED:Int;
	@:native("GL_TEXTURE_BUFFER_BINDING")
	static var TEXTURE_BUFFER_BINDING:Int;
	@:native("GL_MAP_PERSISTENT_BIT")
	static var MAP_PERSISTENT_BIT:Int;
	@:native("GL_MAP_COHERENT_BIT")
	static var MAP_COHERENT_BIT:Int;
	@:native("GL_DYNAMIC_STORAGE_BIT")
	static var DYNAMIC_STORAGE_BIT:Int;
	@:native("GL_CLIENT_STORAGE_BIT")
	static var CLIENT_STORAGE_BIT:Int;
	@:native("GL_CLIENT_MAPPED_BUFFER_BARRIER_BIT")
	static var CLIENT_MAPPED_BUFFER_BARRIER_BIT:Int;
	@:native("GL_BUFFER_IMMUTABLE_STORAGE")
	static var BUFFER_IMMUTABLE_STORAGE:Int;
	@:native("GL_BUFFER_STORAGE_FLAGS")
	static var BUFFER_STORAGE_FLAGS:Int;
	@:native("GL_CLEAR_TEXTURE")
	static var CLEAR_TEXTURE:Int;
	@:native("GL_LOCATION_COMPONENT")
	static var LOCATION_COMPONENT:Int;
	@:native("GL_TRANSFORM_FEEDBACK_BUFFER_INDEX")
	static var TRANSFORM_FEEDBACK_BUFFER_INDEX:Int;
	@:native("GL_TRANSFORM_FEEDBACK_BUFFER_STRIDE")
	static var TRANSFORM_FEEDBACK_BUFFER_STRIDE:Int;
	@:native("GL_QUERY_BUFFER")
	static var QUERY_BUFFER:Int;
	@:native("GL_QUERY_BUFFER_BARRIER_BIT")
	static var QUERY_BUFFER_BARRIER_BIT:Int;
	@:native("GL_QUERY_BUFFER_BINDING")
	static var QUERY_BUFFER_BINDING:Int;
	@:native("GL_QUERY_RESULT_NO_WAIT")
	static var QUERY_RESULT_NO_WAIT:Int;
	@:native("GL_MIRROR_CLAMP_TO_EDGE")
	static var MIRROR_CLAMP_TO_EDGE:Int;
	@:native("GL_CONTEXT_LOST")
	static var CONTEXT_LOST:Int;
	@:native("GL_NEGATIVE_ONE_TO_ONE")
	static var NEGATIVE_ONE_TO_ONE:Int;
	@:native("GL_ZERO_TO_ONE")
	static var ZERO_TO_ONE:Int;
	@:native("GL_CLIP_ORIGIN")
	static var CLIP_ORIGIN:Int;
	@:native("GL_CLIP_DEPTH_MODE")
	static var CLIP_DEPTH_MODE:Int;
	@:native("GL_QUERY_WAIT_INVERTED")
	static var QUERY_WAIT_INVERTED:Int;
	@:native("GL_QUERY_NO_WAIT_INVERTED")
	static var QUERY_NO_WAIT_INVERTED:Int;
	@:native("GL_QUERY_BY_REGION_WAIT_INVERTED")
	static var QUERY_BY_REGION_WAIT_INVERTED:Int;
	@:native("GL_QUERY_BY_REGION_NO_WAIT_INVERTED")
	static var QUERY_BY_REGION_NO_WAIT_INVERTED:Int;
	@:native("GL_MAX_CULL_DISTANCES")
	static var MAX_CULL_DISTANCES:Int;
	@:native("GL_MAX_COMBINED_CLIP_AND_CULL_DISTANCES")
	static var MAX_COMBINED_CLIP_AND_CULL_DISTANCES:Int;
	@:native("GL_TEXTURE_TARGET")
	static var TEXTURE_TARGET:Int;
	@:native("GL_QUERY_TARGET")
	static var QUERY_TARGET:Int;
	@:native("GL_GUILTY_CONTEXT_RESET")
	static var GUILTY_CONTEXT_RESET:Int;
	@:native("GL_INNOCENT_CONTEXT_RESET")
	static var INNOCENT_CONTEXT_RESET:Int;
	@:native("GL_UNKNOWN_CONTEXT_RESET")
	static var UNKNOWN_CONTEXT_RESET:Int;
	@:native("GL_RESET_NOTIFICATION_STRATEGY")
	static var RESET_NOTIFICATION_STRATEGY:Int;
	@:native("GL_LOSE_CONTEXT_ON_RESET")
	static var LOSE_CONTEXT_ON_RESET:Int;
	@:native("GL_NO_RESET_NOTIFICATION")
	static var NO_RESET_NOTIFICATION:Int;
	@:native("GL_CONTEXT_FLAG_ROBUST_ACCESS_BIT")
	static var CONTEXT_FLAG_ROBUST_ACCESS_BIT:Int;
	@:native("GL_COLOR_TABLE")
	static var COLOR_TABLE:Int;
	@:native("GL_POST_CONVOLUTION_COLOR_TABLE")
	static var POST_CONVOLUTION_COLOR_TABLE:Int;
	@:native("GL_POST_COLOR_MATRIX_COLOR_TABLE")
	static var POST_COLOR_MATRIX_COLOR_TABLE:Int;
	@:native("GL_PROXY_COLOR_TABLE")
	static var PROXY_COLOR_TABLE:Int;
	@:native("GL_PROXY_POST_CONVOLUTION_COLOR_TABLE")
	static var PROXY_POST_CONVOLUTION_COLOR_TABLE:Int;
	@:native("GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE")
	static var PROXY_POST_COLOR_MATRIX_COLOR_TABLE:Int;
	@:native("GL_CONVOLUTION_1D")
	static var CONVOLUTION_1D:Int;
	@:native("GL_CONVOLUTION_2D")
	static var CONVOLUTION_2D:Int;
	@:native("GL_SEPARABLE_2D")
	static var SEPARABLE_2D:Int;
	@:native("GL_HISTOGRAM")
	static var HISTOGRAM:Int;
	@:native("GL_PROXY_HISTOGRAM")
	static var PROXY_HISTOGRAM:Int;
	@:native("GL_MINMAX")
	static var MINMAX:Int;
	@:native("GL_CONTEXT_RELEASE_BEHAVIOR")
	static var CONTEXT_RELEASE_BEHAVIOR:Int;
	@:native("GL_CONTEXT_RELEASE_BEHAVIOR_FLUSH")
	static var CONTEXT_RELEASE_BEHAVIOR_FLUSH:Int;
	@:native("GL_SHADER_BINARY_FORMAT_SPIR_V")
	static var SHADER_BINARY_FORMAT_SPIR_V:Int;
	@:native("GL_SPIR_V_BINARY")
	static var SPIR_V_BINARY:Int;
	@:native("GL_PARAMETER_BUFFER")
	static var PARAMETER_BUFFER:Int;
	@:native("GL_PARAMETER_BUFFER_BINDING")
	static var PARAMETER_BUFFER_BINDING:Int;
	@:native("GL_CONTEXT_FLAG_NO_ERROR_BIT")
	static var CONTEXT_FLAG_NO_ERROR_BIT:Int;
	@:native("GL_VERTICES_SUBMITTED")
	static var VERTICES_SUBMITTED:Int;
	@:native("GL_PRIMITIVES_SUBMITTED")
	static var PRIMITIVES_SUBMITTED:Int;
	@:native("GL_VERTEX_SHADER_INVOCATIONS")
	static var VERTEX_SHADER_INVOCATIONS:Int;
	@:native("GL_TESS_CONTROL_SHADER_PATCHES")
	static var TESS_CONTROL_SHADER_PATCHES:Int;
	@:native("GL_TESS_EVALUATION_SHADER_INVOCATIONS")
	static var TESS_EVALUATION_SHADER_INVOCATIONS:Int;
	@:native("GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED")
	static var GEOMETRY_SHADER_PRIMITIVES_EMITTED:Int;
	@:native("GL_FRAGMENT_SHADER_INVOCATIONS")
	static var FRAGMENT_SHADER_INVOCATIONS:Int;
	@:native("GL_COMPUTE_SHADER_INVOCATIONS")
	static var COMPUTE_SHADER_INVOCATIONS:Int;
	@:native("GL_CLIPPING_INPUT_PRIMITIVES")
	static var CLIPPING_INPUT_PRIMITIVES:Int;
	@:native("GL_CLIPPING_OUTPUT_PRIMITIVES")
	static var CLIPPING_OUTPUT_PRIMITIVES:Int;
	@:native("GL_POLYGON_OFFSET_CLAMP")
	static var POLYGON_OFFSET_CLAMP:Int;
	@:native("GL_SPIR_V_EXTENSIONS")
	static var SPIR_V_EXTENSIONS:Int;
	@:native("GL_NUM_SPIR_V_EXTENSIONS")
	static var NUM_SPIR_V_EXTENSIONS:Int;
	@:native("GL_TEXTURE_MAX_ANISOTROPY")
	static var TEXTURE_MAX_ANISOTROPY:Int;
	@:native("GL_MAX_TEXTURE_MAX_ANISOTROPY")
	static var MAX_TEXTURE_MAX_ANISOTROPY:Int;
	@:native("GL_TRANSFORM_FEEDBACK_OVERFLOW")
	static var TRANSFORM_FEEDBACK_OVERFLOW:Int;
	@:native("GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW")
	static var TRANSFORM_FEEDBACK_STREAM_OVERFLOW:Int;
	@:native("GL_VERSION_ES_CL_1_0")
	static var VERSION_ES_CL_1_0:Int;
	@:native("GL_VERSION_ES_CM_1_1")
	static var VERSION_ES_CM_1_1:Int;
	@:native("GL_VERSION_ES_CL_1_1")
	static var VERSION_ES_CL_1_1:Int;
	@:native("GL_CLIP_PLANE0")
	static var CLIP_PLANE0:Int;
	@:native("GL_CLIP_PLANE1")
	static var CLIP_PLANE1:Int;
	@:native("GL_CLIP_PLANE2")
	static var CLIP_PLANE2:Int;
	@:native("GL_CLIP_PLANE3")
	static var CLIP_PLANE3:Int;
	@:native("GL_CLIP_PLANE4")
	static var CLIP_PLANE4:Int;
	@:native("GL_CLIP_PLANE5")
	static var CLIP_PLANE5:Int;
	@:native("GL_FOG")
	static var FOG:Int;
	@:native("GL_LIGHTING")
	static var LIGHTING:Int;
	@:native("GL_ALPHA_TEST")
	static var ALPHA_TEST:Int;
	@:native("GL_POINT_SMOOTH")
	static var POINT_SMOOTH:Int;
	@:native("GL_COLOR_MATERIAL")
	static var COLOR_MATERIAL:Int;
	@:native("GL_NORMALIZE")
	static var NORMALIZE:Int;
	@:native("GL_RESCALE_NORMAL")
	static var RESCALE_NORMAL:Int;
	@:native("GL_NORMAL_ARRAY")
	static var NORMAL_ARRAY:Int;
	@:native("GL_COLOR_ARRAY")
	static var COLOR_ARRAY:Int;
	@:native("GL_TEXTURE_COORD_ARRAY")
	static var TEXTURE_COORD_ARRAY:Int;
	@:native("GL_EXP")
	static var EXP:Int;
	@:native("GL_EXP2")
	static var EXP2:Int;
	@:native("GL_FOG_DENSITY")
	static var FOG_DENSITY:Int;
	@:native("GL_FOG_START")
	static var FOG_START:Int;
	@:native("GL_FOG_END")
	static var FOG_END:Int;
	@:native("GL_FOG_MODE")
	static var FOG_MODE:Int;
	@:native("GL_FOG_COLOR")
	static var FOG_COLOR:Int;
	@:native("GL_CURRENT_COLOR")
	static var CURRENT_COLOR:Int;
	@:native("GL_CURRENT_NORMAL")
	static var CURRENT_NORMAL:Int;
	@:native("GL_CURRENT_TEXTURE_COORDS")
	static var CURRENT_TEXTURE_COORDS:Int;
	@:native("GL_POINT_SIZE_MIN")
	static var POINT_SIZE_MIN:Int;
	@:native("GL_POINT_SIZE_MAX")
	static var POINT_SIZE_MAX:Int;
	@:native("GL_POINT_DISTANCE_ATTENUATION")
	static var POINT_DISTANCE_ATTENUATION:Int;
	@:native("GL_ALIASED_POINT_SIZE_RANGE")
	static var ALIASED_POINT_SIZE_RANGE:Int;
	@:native("GL_SHADE_MODEL")
	static var SHADE_MODEL:Int;
	@:native("GL_MATRIX_MODE")
	static var MATRIX_MODE:Int;
	@:native("GL_MODELVIEW_STACK_DEPTH")
	static var MODELVIEW_STACK_DEPTH:Int;
	@:native("GL_PROJECTION_STACK_DEPTH")
	static var PROJECTION_STACK_DEPTH:Int;
	@:native("GL_TEXTURE_STACK_DEPTH")
	static var TEXTURE_STACK_DEPTH:Int;
	@:native("GL_MODELVIEW_MATRIX")
	static var MODELVIEW_MATRIX:Int;
	@:native("GL_PROJECTION_MATRIX")
	static var PROJECTION_MATRIX:Int;
	@:native("GL_TEXTURE_MATRIX")
	static var TEXTURE_MATRIX:Int;
	@:native("GL_ALPHA_TEST_FUNC")
	static var ALPHA_TEST_FUNC:Int;
	@:native("GL_ALPHA_TEST_REF")
	static var ALPHA_TEST_REF:Int;
	@:native("GL_MAX_LIGHTS")
	static var MAX_LIGHTS:Int;
	@:native("GL_MAX_CLIP_PLANES")
	static var MAX_CLIP_PLANES:Int;
	@:native("GL_MAX_MODELVIEW_STACK_DEPTH")
	static var MAX_MODELVIEW_STACK_DEPTH:Int;
	@:native("GL_MAX_PROJECTION_STACK_DEPTH")
	static var MAX_PROJECTION_STACK_DEPTH:Int;
	@:native("GL_MAX_TEXTURE_STACK_DEPTH")
	static var MAX_TEXTURE_STACK_DEPTH:Int;
	@:native("GL_MAX_TEXTURE_UNITS")
	static var MAX_TEXTURE_UNITS:Int;
	@:native("GL_RED_BITS")
	static var RED_BITS:Int;
	@:native("GL_GREEN_BITS")
	static var GREEN_BITS:Int;
	@:native("GL_BLUE_BITS")
	static var BLUE_BITS:Int;
	@:native("GL_ALPHA_BITS")
	static var ALPHA_BITS:Int;
	@:native("GL_DEPTH_BITS")
	static var DEPTH_BITS:Int;
	@:native("GL_STENCIL_BITS")
	static var STENCIL_BITS:Int;
	@:native("GL_VERTEX_ARRAY_SIZE")
	static var VERTEX_ARRAY_SIZE:Int;
	@:native("GL_VERTEX_ARRAY_TYPE")
	static var VERTEX_ARRAY_TYPE:Int;
	@:native("GL_VERTEX_ARRAY_STRIDE")
	static var VERTEX_ARRAY_STRIDE:Int;
	@:native("GL_NORMAL_ARRAY_TYPE")
	static var NORMAL_ARRAY_TYPE:Int;
	@:native("GL_NORMAL_ARRAY_STRIDE")
	static var NORMAL_ARRAY_STRIDE:Int;
	@:native("GL_COLOR_ARRAY_SIZE")
	static var COLOR_ARRAY_SIZE:Int;
	@:native("GL_COLOR_ARRAY_TYPE")
	static var COLOR_ARRAY_TYPE:Int;
	@:native("GL_COLOR_ARRAY_STRIDE")
	static var COLOR_ARRAY_STRIDE:Int;
	@:native("GL_TEXTURE_COORD_ARRAY_SIZE")
	static var TEXTURE_COORD_ARRAY_SIZE:Int;
	@:native("GL_TEXTURE_COORD_ARRAY_TYPE")
	static var TEXTURE_COORD_ARRAY_TYPE:Int;
	@:native("GL_TEXTURE_COORD_ARRAY_STRIDE")
	static var TEXTURE_COORD_ARRAY_STRIDE:Int;
	@:native("GL_VERTEX_ARRAY_POINTER")
	static var VERTEX_ARRAY_POINTER:Int;
	@:native("GL_NORMAL_ARRAY_POINTER")
	static var NORMAL_ARRAY_POINTER:Int;
	@:native("GL_COLOR_ARRAY_POINTER")
	static var COLOR_ARRAY_POINTER:Int;
	@:native("GL_TEXTURE_COORD_ARRAY_POINTER")
	static var TEXTURE_COORD_ARRAY_POINTER:Int;
	@:native("GL_PERSPECTIVE_CORRECTION_HINT")
	static var PERSPECTIVE_CORRECTION_HINT:Int;
	@:native("GL_POINT_SMOOTH_HINT")
	static var POINT_SMOOTH_HINT:Int;
	@:native("GL_FOG_HINT")
	static var FOG_HINT:Int;
	@:native("GL_GENERATE_MIPMAP_HINT")
	static var GENERATE_MIPMAP_HINT:Int;
	@:native("GL_LIGHT_MODEL_AMBIENT")
	static var LIGHT_MODEL_AMBIENT:Int;
	@:native("GL_LIGHT_MODEL_TWO_SIDE")
	static var LIGHT_MODEL_TWO_SIDE:Int;
	@:native("GL_AMBIENT")
	static var AMBIENT:Int;
	@:native("GL_DIFFUSE")
	static var DIFFUSE:Int;
	@:native("GL_SPECULAR")
	static var SPECULAR:Int;
	@:native("GL_POSITION")
	static var POSITION:Int;
	@:native("GL_SPOT_DIRECTION")
	static var SPOT_DIRECTION:Int;
	@:native("GL_SPOT_EXPONENT")
	static var SPOT_EXPONENT:Int;
	@:native("GL_SPOT_CUTOFF")
	static var SPOT_CUTOFF:Int;
	@:native("GL_CONSTANT_ATTENUATION")
	static var CONSTANT_ATTENUATION:Int;
	@:native("GL_LINEAR_ATTENUATION")
	static var LINEAR_ATTENUATION:Int;
	@:native("GL_QUADRATIC_ATTENUATION")
	static var QUADRATIC_ATTENUATION:Int;
	@:native("GL_EMISSION")
	static var EMISSION:Int;
	@:native("GL_SHININESS")
	static var SHININESS:Int;
	@:native("GL_AMBIENT_AND_DIFFUSE")
	static var AMBIENT_AND_DIFFUSE:Int;
	@:native("GL_MODELVIEW")
	static var MODELVIEW:Int;
	@:native("GL_PROJECTION")
	static var PROJECTION:Int;
	@:native("GL_LUMINANCE")
	static var LUMINANCE:Int;
	@:native("GL_LUMINANCE_ALPHA")
	static var LUMINANCE_ALPHA:Int;
	@:native("GL_FLAT")
	static var FLAT:Int;
	@:native("GL_SMOOTH")
	static var SMOOTH:Int;
	@:native("GL_MODULATE")
	static var MODULATE:Int;
	@:native("GL_DECAL")
	static var DECAL:Int;
	@:native("GL_ADD")
	static var ADD:Int;
	@:native("GL_TEXTURE_ENV_MODE")
	static var TEXTURE_ENV_MODE:Int;
	@:native("GL_TEXTURE_ENV_COLOR")
	static var TEXTURE_ENV_COLOR:Int;
	@:native("GL_TEXTURE_ENV")
	static var TEXTURE_ENV:Int;
	@:native("GL_GENERATE_MIPMAP")
	static var GENERATE_MIPMAP:Int;
	@:native("GL_CLIENT_ACTIVE_TEXTURE")
	static var CLIENT_ACTIVE_TEXTURE:Int;
	@:native("GL_LIGHT0")
	static var LIGHT0:Int;
	@:native("GL_LIGHT1")
	static var LIGHT1:Int;
	@:native("GL_LIGHT2")
	static var LIGHT2:Int;
	@:native("GL_LIGHT3")
	static var LIGHT3:Int;
	@:native("GL_LIGHT4")
	static var LIGHT4:Int;
	@:native("GL_LIGHT5")
	static var LIGHT5:Int;
	@:native("GL_LIGHT6")
	static var LIGHT6:Int;
	@:native("GL_LIGHT7")
	static var LIGHT7:Int;
	@:native("GL_VERTEX_ARRAY_BUFFER_BINDING")
	static var VERTEX_ARRAY_BUFFER_BINDING:Int;
	@:native("GL_NORMAL_ARRAY_BUFFER_BINDING")
	static var NORMAL_ARRAY_BUFFER_BINDING:Int;
	@:native("GL_COLOR_ARRAY_BUFFER_BINDING")
	static var COLOR_ARRAY_BUFFER_BINDING:Int;
	@:native("GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING")
	static var TEXTURE_COORD_ARRAY_BUFFER_BINDING:Int;
	@:native("GL_SUBTRACT")
	static var SUBTRACT:Int;
	@:native("GL_COMBINE")
	static var COMBINE:Int;
	@:native("GL_COMBINE_RGB")
	static var COMBINE_RGB:Int;
	@:native("GL_COMBINE_ALPHA")
	static var COMBINE_ALPHA:Int;
	@:native("GL_RGB_SCALE")
	static var RGB_SCALE:Int;
	@:native("GL_ADD_SIGNED")
	static var ADD_SIGNED:Int;
	@:native("GL_INTERPOLATE")
	static var INTERPOLATE:Int;
	@:native("GL_CONSTANT")
	static var CONSTANT:Int;
	@:native("GL_PRIMARY_COLOR")
	static var PRIMARY_COLOR:Int;
	@:native("GL_PREVIOUS")
	static var PREVIOUS:Int;
	@:native("GL_OPERAND0_RGB")
	static var OPERAND0_RGB:Int;
	@:native("GL_OPERAND1_RGB")
	static var OPERAND1_RGB:Int;
	@:native("GL_OPERAND2_RGB")
	static var OPERAND2_RGB:Int;
	@:native("GL_OPERAND0_ALPHA")
	static var OPERAND0_ALPHA:Int;
	@:native("GL_OPERAND1_ALPHA")
	static var OPERAND1_ALPHA:Int;
	@:native("GL_OPERAND2_ALPHA")
	static var OPERAND2_ALPHA:Int;
	@:native("GL_ALPHA_SCALE")
	static var ALPHA_SCALE:Int;
	@:native("GL_SRC0_RGB")
	static var SRC0_RGB:Int;
	@:native("GL_SRC1_RGB")
	static var SRC1_RGB:Int;
	@:native("GL_SRC2_RGB")
	static var SRC2_RGB:Int;
	@:native("GL_SRC0_ALPHA")
	static var SRC0_ALPHA:Int;
	@:native("GL_SRC2_ALPHA")
	static var SRC2_ALPHA:Int;
	@:native("GL_DOT3_RGB")
	static var DOT3_RGB:Int;
	@:native("GL_DOT3_RGBA")
	static var DOT3_RGBA:Int;
	@:native("GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS")
	static var FRAMEBUFFER_INCOMPLETE_DIMENSIONS:Int;
	@:native("GL_MULTISAMPLE_LINE_WIDTH_RANGE")
	static var MULTISAMPLE_LINE_WIDTH_RANGE:Int;
	@:native("GL_MULTISAMPLE_LINE_WIDTH_GRANULARITY")
	static var MULTISAMPLE_LINE_WIDTH_GRANULARITY:Int;
	@:native("GL_MULTIPLY")
	static var MULTIPLY:Int;
	@:native("GL_SCREEN")
	static var SCREEN:Int;
	@:native("GL_OVERLAY")
	static var OVERLAY:Int;
	@:native("GL_DARKEN")
	static var DARKEN:Int;
	@:native("GL_LIGHTEN")
	static var LIGHTEN:Int;
	@:native("GL_COLORDODGE")
	static var COLORDODGE:Int;
	@:native("GL_COLORBURN")
	static var COLORBURN:Int;
	@:native("GL_HARDLIGHT")
	static var HARDLIGHT:Int;
	@:native("GL_SOFTLIGHT")
	static var SOFTLIGHT:Int;
	@:native("GL_DIFFERENCE")
	static var DIFFERENCE:Int;
	@:native("GL_EXCLUSION")
	static var EXCLUSION:Int;
	@:native("GL_HSL_HUE")
	static var HSL_HUE:Int;
	@:native("GL_HSL_SATURATION")
	static var HSL_SATURATION:Int;
	@:native("GL_HSL_COLOR")
	static var HSL_COLOR:Int;
	@:native("GL_HSL_LUMINOSITY")
	static var HSL_LUMINOSITY:Int;
	@:native("GL_PRIMITIVE_BOUNDING_BOX")
	static var PRIMITIVE_BOUNDING_BOX:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_4x4")
	static var COMPRESSED_RGBA_ASTC_4x4:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_5x4")
	static var COMPRESSED_RGBA_ASTC_5x4:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_5x5")
	static var COMPRESSED_RGBA_ASTC_5x5:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_6x5")
	static var COMPRESSED_RGBA_ASTC_6x5:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_6x6")
	static var COMPRESSED_RGBA_ASTC_6x6:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_8x5")
	static var COMPRESSED_RGBA_ASTC_8x5:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_8x6")
	static var COMPRESSED_RGBA_ASTC_8x6:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_8x8")
	static var COMPRESSED_RGBA_ASTC_8x8:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_10x5")
	static var COMPRESSED_RGBA_ASTC_10x5:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_10x6")
	static var COMPRESSED_RGBA_ASTC_10x6:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_10x8")
	static var COMPRESSED_RGBA_ASTC_10x8:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_10x10")
	static var COMPRESSED_RGBA_ASTC_10x10:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_12x10")
	static var COMPRESSED_RGBA_ASTC_12x10:Int;
	@:native("GL_COMPRESSED_RGBA_ASTC_12x12")
	static var COMPRESSED_RGBA_ASTC_12x12:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x4")
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_4x4:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x4")
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_5x4:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x5")
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_5x5:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x5")
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_6x5:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x6")
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_6x6:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x5")
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_8x5:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x6")
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_8x6:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x8")
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_8x8:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x5")
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_10x5:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x6")
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_10x6:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x8")
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_10x8:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x10")
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_10x10:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x10")
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_12x10:Int;
	@:native("GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x12")
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_12x12:Int;
	@:native("GL_CONTEXT_ROBUST_ACCESS")
	static var CONTEXT_ROBUST_ACCESS:Int;
    
    @:native("glCullFace")
	static function cullFace(mode:GlEnum):Void;

	@:native("glFrontFace")
	static function frontFace(mode:GlEnum):Void;

	@:native("glHint")
	static function hint(target:GlEnum, mode:GlEnum):Void;

	@:native("glLineWidth")
	static function lineWidth(width:GlFloat):Void;

	@:native("glPointSize")
	static function pointSize(size:GlFloat):Void;

	@:native("glPolygonMode")
	static function polygonMode(face:GlEnum, mode:GlEnum):Void;

	@:native("glScissor")
	static function scissor(x:GlInt, y:GlInt, width:GlSizeI, height:GlSizeI):Void;

	@:native("glTexParameterf")
	static function texParameterf(target:GlEnum, pname:GlEnum, param:GlFloat):Void;

	@:native("glTexParameterfv")
	static function texParameterfv(target:GlEnum, pname:GlEnum, params:RawPointer<GlFloat>):Void;

	@:native("glTexParameteri")
	static function texParameteri(target:GlEnum, pname:GlEnum, param:GlInt):Void;

	@:native("glTexParameteriv")
	static function texParameteriv(target:GlEnum, pname:GlEnum, params:RawPointer<GlInt>):Void;

	inline static function texImage1D(target:GlEnum, level:GlInt, internalFormat:GlInt, width:GlSizeI, border:GlInt, format:GlEnum, type:GlEnum, pixels:Any):Void {
		untyped __cpp__("glTexImage1D({0}, {1}, {2}, {3}, {4}, {5}, {6}, {7})", target, level, internalFormat, width, border, format, type, pixels);
	}

	inline static function texImage2D(target:GlEnum, level:GlInt, internalFormat:GlInt, width:GlSizeI, height:GlSizeI, border:GlInt, format:GlEnum, type:GlEnum, pixels:Any):Void {
		untyped __cpp__("glTexImage2D({0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}, {8})", target, level, internalFormat, width, height, border, format, type, pixels);
	}

	@:native("glDrawBuffer")
	static function drawBuffer(buf:GlEnum):Void;

	@:native("glClear")
	static function clear(mask:GlBitField):Void;

	@:native("glClearColor")
	static function clearColor(red:GlFloat, green:GlFloat, blue:GlFloat, alpha:GlFloat):Void;

	@:native("glClearStencil")
	static function clearStencil(s:GlInt):Void;

	@:native("glClearDepth")
	static function clearDepth(depth:GlDouble):Void;

	@:native("glStencilMask")
	static function stencilMask(mask:GlUInt):Void;

	@:native("glColorMask")
	static function colorMask(red:GlBool, green:GlBool, blue:GlBool, alpha:GlBool):Void;

	@:native("glDepthMask")
	static function depthMask(flag:GlBool):Void;

	@:native("glDisable")
	static function disable(cap:GlEnum):Void;

	@:native("glEnable")
	static function enable(cap:GlEnum):Void;

	@:native("glFinish")
	static function finish():Void;

	@:native("glFlush")
	static function flush():Void;

	@:native("glBlendFunc")
	static function blendFunc(sfactor:GlEnum, dfactor:GlEnum):Void;

	@:native("glLogicOp")
	static function logicOp(opcode:GlEnum):Void;

	@:native("glStencilFunc")
	static function stencilFunc(func:GlEnum, ref:GlInt, mask:GlUInt):Void;

	@:native("glStencilOp")
	static function stencilOp(fail:GlEnum, zfail:GlEnum, zpass:GlEnum):Void;

	@:native("glDepthFunc")
	static function depthFunc(func:GlEnum):Void;

	@:native("glPixelStoref")
	static function pixelStoref(pname:GlEnum, param:GlFloat):Void;

	@:native("glPixelStorei")
	static function pixelStorei(pname:GlEnum, param:GlInt):Void;

	@:native("glReadBuffer")
	static function readBuffer(src:GlEnum):Void;

	inline static function readPixels(x:GlInt, y:GlInt, width:GlSizeI, height:GlSizeI, format:GlEnum, type:GlEnum, pixels:Any):Void {
		untyped __cpp__("glTexImage1D({0}, {1}, {2}, {3}, {4}, {5}, {6})", x, y, width, height, format, type, pixels);
	}

	@:native("glGetBooleanv")
	static function getBooleanv(pname:GlEnum, data:RawPointer<GlBool>):Void;

	@:native("glGetDoublev")
	static function getDoublev(pname:GlEnum, data:RawPointer<GlDouble>):Void;

	@:native("glGetError")
	static function getError():GlEnum;

	@:native("glGetFloatv")
	static function getFloatv(pname:GlEnum, data:RawPointer<GlFloat>):Void;

	@:native("glGetIntegerv")
	static function getIntegerv(pname:GlEnum, data:RawPointer<GlInt>):Void;

	@:native("glGetString")
	static function getString(name:GlEnum):RawPointer<GlUByte>;

	inline static function getTexImage(target:GlEnum, level:GlInt, format:GlEnum, type:GlEnum, pixels:Any):Void {
		untyped __cpp__("getTexImage({0}, {1}, {2}, {3}, {4})", target, level, format, type, pixels);
	}

	@:native("glGetTexParameterfv")
	static function getTexParameterfv(target:GlEnum, pname:GlEnum, params:RawPointer<GlFloat>):Void;

	@:native("glGetTexParameteriv")
	static function getTexParameteriv(target:GlEnum, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glGetTexLevelParameterfv")
	static function getTexLevelParameterfv(target:GlEnum, level:GlInt, pname:GlEnum, params:RawPointer<GlFloat>):Void;

	@:native("glGetTexLevelParameteriv")
	static function getTexLevelParameteriv(target:GlEnum, level:GlInt, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glIsEnabled")
	static function isEnabled(cap:GlEnum):GlBool;

	@:native("glDepthRange")
	static function depthRange(n:GlDouble, f:GlDouble):Void;

	@:native("glViewport")
	static function viewport(x:GlInt, y:GlInt, width:GlSizeI, height:GlSizeI):Void;

	@:native("glDrawArrays")
	static function drawArrays(mode:GlEnum, first:GlInt, count:GlSizeI):Void;

	inline static function drawElements(mode:GlEnum, count:GlSizeI, type:GlEnum, indices:Any):Void {
		untyped __cpp__("glDrawElements({0}, {1}, {2}, {3})", mode, count, type, indices);
	}

	@:native("glPolygonOffset")
	static function polygonOffset(factor:GlFloat, units:GlFloat):Void;

	@:native("glCopyTexImage1D")
	static function copyTexImage1D(target:GlEnum, level:GlInt, internalformat:GlEnum, x:GlInt, y:GlInt, width:GlSizeI, border:GlInt):Void;

	@:native("glCopyTexImage2D")
	static function copyTexImage2D(target:GlEnum, level:GlInt, internalformat:GlEnum, x:GlInt, y:GlInt, width:GlSizeI, height:GlSizeI, border:GlInt):Void;

	@:native("glCopyTexSubImage1D")
	static function copyTexSubImage1D(target:GlEnum, level:GlInt, xOffset:GlInt, x:GlInt, y:GlInt, width:GlSizeI):Void;

	@:native("glCopyTexSubImage2D")
	static function copyTexSubImage2D(target:GlEnum, level:GlInt, xOffset:GlInt, yOffset:GlInt, x:GlInt, y:GlInt, width:GlSizeI, height:GlSizeI):Void;

	inline static function texSubImage1D(target:GlEnum, level:GlInt, xOffset:GlInt, width:GlSizeI, format:GlEnum, type:GlEnum, pixels:Any):Void {
		untyped __cpp__("glTexSubImage1D({0}, {1}, {2}, {3}, {4}, {5}, {6})", target, level, xOffset, width, format, type, pixels);
	}

	inline static function texSubImage2D(target:GlEnum, level:GlInt, xOffset:GlInt, yOffset:GlInt, width:GlSizeI, height:GlSizeI, format:GlEnum, type:GlEnum, pixels:Any):Void {
		untyped __cpp__("glTexSubImage2D({0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}, {8})", target, level, xOffset, yOffset, width, height, format, type, pixels);
	}

	@:native("glBindTexture")
	static function bindTexture(target:GlEnum, texture:GlUInt):Void;

	@:native("glDeleteTextures")
	static function deleteTextures(n:GlSizeI, textures:RawPointer<GlUInt>):Void;

	@:native("glGenTextures")
	static function genTextures(n:GlSizeI, textures:RawPointer<GlUInt>):Void;

	@:native("glIsTexture")
	static function isTexture(texture:GlUInt):GlBool;

	inline static function drawRangeElements(mode:GlEnum, start:GlUInt, end:GlUInt, count:GlSizeI, type:GlEnum, indices:Any):Void {
		untyped __cpp__("glDrawRangeElements({0}, {1}, {2}, {3}, {4}, {5})", mode, start, end, count, type, indices);
	}

	inline static function texImage3D(target:GlEnum, level:GlInt, internalFormat:GlInt, width:GlSizeI, height:GlSizeI, depth:GlSizeI, border:GlInt, format:GlEnum, type:GlEnum, pixels:Any):Void {
		untyped __cpp__("glTexImage3D({0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}, {8}, {9})", target, level, internalFormat, width, height, depth, border, format, type, pixels);
	}

	inline static function texSubImage3D(target:GlEnum, level:GlInt, xOffset:GlInt, yOffset:GlInt, zOffset:GlInt, width:GlSizeI, height:GlSizeI, depth:GlSizeI, format:GlEnum, type:GlEnum, pixels:Any):Void {
		untyped __cpp__("glTexSubImage3D({0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}, {8}, {9}, {10})", target, level, xOffset, yOffset, zOffset, width, height, depth, format, type, pixels);
	}

	@:native("glCopyTexSubImage3D")
	static function copyTexSubImage3D(target:GlEnum, level:GlInt, xOffset:GlInt, yOffset:GlInt, zOffset:GlInt, x:GlInt, y:GlInt, width:GlSizeI, height:GlSizeI):Void;

	@:native("glActiveTexture")
	static function activeTexture(texture:GlEnum):Void;

	@:native("glSampleCoverage")
	static function sampleCoverage(value:GlFloat, invert:GlBool):Void;

	inline static function compressedTexImage3D(target:GlEnum, level:GlInt, internalFormat:GlEnum, width:GlSizeI, height:GlSizeI, depth:GlSizeI, border:GlInt, imageSize:GlSizeI, data:Any):Void {
		untyped __cpp__("glCompressedTexImage3D({0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}, {8})", target, level, internalFormat, width, height, depth, border, imageSize, data);
	}

	inline static function compressedTexImage2D(target:GlEnum, level:GlInt, internalFormat:GlEnum, width:GlSizeI, height:GlSizeI, border:GlInt, imageSize:GlSizeI, data:Any):Void {
		untyped __cpp__("glCompressedTexImage2D({0}, {1}, {2}, {3}, {4}, {5}, {6}, {7})", target, level, internalFormat, width, height, border, imageSize, data);
	}

	inline static function compressedTexImage1D(target:GlEnum, level:GlInt, internalFormat:GlEnum, width:GlSizeI, border:GlInt, imageSize:GlSizeI, data:Any):Void {
		untyped __cpp__("glCompressedTexImage1D({0}, {1}, {2}, {3}, {4}, {5}, {6})", target, level, internalFormat, width, border, imageSize, data);
	}

	inline static function compressedTexSubImage3D(target:GlEnum, level:GlInt, internalFormat:GlEnum, xOffset:GlInt, yOffset:GlInt, zOffset:GlInt, width:GlSizeI, height:GlSizeI, depth:GlSizeI, border:GlInt, imageSize:GlSizeI, data:Any):Void {
		untyped __cpp__("glCompressedTexSubImage3D({0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}, {8}, {9}, {10}, {11})", target, level, internalFormat, xOffset, yOffset, zOffset, width, height, depth, border, imageSize, data);
	}

	inline static function compressedTexSubImage2D(target:GlEnum, level:GlInt, internalFormat:GlEnum, xOffset:GlInt, yOffset:GlInt, width:GlSizeI, height:GlSizeI, border:GlInt, imageSize:GlSizeI, data:Any):Void {
		untyped __cpp__("glCompressedTexSubImage2D({0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}, {8}, {9})", target, level, internalFormat, xOffset, yOffset, width, height, border, imageSize, data);
	}

	inline static function compressedTexSubImage1D(target:GlEnum, level:GlInt, internalFormat:GlEnum, xOffset:GlInt, width:GlSizeI, border:GlInt, imageSize:GlSizeI, data:Any):Void {
		untyped __cpp__("glCompressedTexSubImage1D({0}, {1}, {2}, {3}, {4}, {5}, {6}, {7})", target, level, internalFormat, xOffset, width, border, imageSize, data);
	}

	inline static function getCompressedTexImage<T>(target:GlEnum, level:GlInt):T {
		untyped __cpp__("void* _ptr; glGetCompressedTexImage({0}, {1}, &_ptr)", target, level);
		return cast untyped __cpp__("_ptr");
	}

	@:native("glBlendFuncSeparate")
	static function blendFuncSeparate(sfactorRGB:GlEnum, dfactorRGB:GlEnum, sfactorAlpha:GlEnum, dfactorAlpha:GlEnum):Void;

	@:native("glMultiDrawArrays")
	static function multiDrawArrays(mode:GlEnum, first:RawPointer<GlInt>, count:RawPointer<GlSizeI>, drawcount:GlSizeI):Void;

	// @:native("glMultiDrawElements") TODO: kill whoever the fuck decided to make a "const void* const*" as a var type.
	// static function multiDrawElements(mode:GlEnum, count:RawPointer<GlSizeI>, type:GlEnum, const*indices:Any, drawcount:GlSizeI):Void;

	@:native("glPointParameterf")
	static function pointParameterf(pname:GlEnum, param:GlFloat):Void;

	@:native("glPointParameterfv")
	static function pointParameterfv(pname:GlEnum, params:RawPointer<GlFloat>):Void;

	@:native("glPointParameteri")
	static function pointParameteri(pname:GlEnum, param:GlInt):Void;

	@:native("glPointParameteriv")
	static function pointParameteriv(pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glBlendColor")
	static function blendColor(red:GlFloat, green:GlFloat, blue:GlFloat, alpha:GlFloat):Void;

	@:native("glBlendEquation")
	static function blendEquation(mode:GlEnum):Void;

	@:native("glGenQueries")
	static function genQueries(n:GlSizeI, ids:RawPointer<GlUInt>):Void;

	@:native("glDeleteQueries")
	static function deleteQueries(n:GlSizeI, ids:RawPointer<GlUInt>):Void;

	@:native("glIsQuery")
	static function isQuery(id:GlUInt):GlBool;

	@:native("glBeginQuery")
	static function beginQuery(target:GlEnum, id:GlUInt):Void;

	@:native("glEndQuery")
	static function endQuery(target:GlEnum):Void;

	@:native("glGetQueryiv")
	static function getQueryiv(target:GlEnum, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glGetQueryObjectiv")
	static function getQueryObjectiv(id:GlUInt, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glGetQueryObjectuiv")
	static function getQueryObjectuiv(id:GlUInt, pname:GlEnum, params:RawPointer<GlUInt>):Void;

	@:native("glBindBuffer")
	static function bindBuffer(target:GlEnum, buffer:GlUInt):Void;

	@:native("glDeleteBuffers")
	static function deleteBuffers(n:GlSizeI, buffers:RawPointer<GlUInt>):Void;

	@:native("glGenBuffers")
	static function genBuffers(n:GlSizeI, buffers:RawPointer<GlUInt>):Void;

	@:native("glIsBuffer")
	static function isBuffer(buffer:GlUInt):GlBool;

	inline static function bufferData(target:GlEnum, size:GlSizeIPointer, data:Any, usage:GlEnum):Void {
		untyped __cpp__("glBufferData({0}, {1}, {2}, {3})", target, size, data, usage);
	}

	inline static function bufferSubData(target:GlEnum, offset:GlIntPointer, size:GlSizeIPointer, data:Any):Void {
		untyped __cpp__("glBufferSubData({0}, {1}, {2}, {3})", target, offset, size, data);
	}

	inline static function getBufferSubData(target:GlEnum, offset:GlIntPointer, size:GlSizeIPointer, data:Any):Void {
		untyped __cpp__("void* data; glGetBufferSubData({0}, {1}, {2}, &_data)", target, offset, size);
		return untyped __cpp__("_data");
	}

	inline static function mapBuffer<T>(target:GlEnum, access:GlEnum):T {
		return cast untyped __cpp__("glMapBuffer({0}, {1})", target, access);
	}

	@:native("glUnmapBuffer")
	static function unmapBuffer(target:GlEnum):GlBool;

	@:native("glGetBufferParameteriv")
	static function getBufferParameteriv(target:GlEnum, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glGetBufferPointerv")
	static function getBufferPointerv(target:GlEnum, pname:GlEnum, params:RawPointer<Any>):Void;

	@:native("glBlendEquationSeparate")
	static function blendEquationSeparate(modeRGB:GlEnum, modeAlpha:GlEnum):Void;

	@:native("glDrawBuffers")
	static function drawBuffers(n:GlSizeI, bufs:RawPointer<GlEnum>):Void;

	@:native("glStencilOpSeparate")
	static function stencilOpSeparate(face:GlEnum, sfail:GlEnum, dpfail:GlEnum, dppass:GlEnum):Void;

	@:native("glStencilFuncSeparate")
	static function stencilFuncSeparate(face:GlEnum, func:GlEnum, ref:GlInt, mask:GlUInt):Void;

	@:native("glStencilMaskSeparate")
	static function stencilMaskSeparate(face:GlEnum, mask:GlUInt):Void;

	@:native("glAttachShader")
	static function attachShader(program:GlUInt, shader:GlUInt):Void;

	@:native("glBindAttribLocation")
	static function bindAttribLocation(program:GlUInt, index:GlUInt, name:ConstCharStar):Void;

	@:native("glCompileShader")
	static function compileShader(shader:GlUInt):Void;

	@:native("glCreateProgram")
	static function createProgram():GlUInt;

	@:native("glCreateShader")
	static function createShader(type:GlEnum):GlUInt;

	@:native("glDeleteProgram")
	static function deleteProgram(program:GlUInt):Void;

	@:native("glDeleteShader")
	static function deleteShader(shader:GlUInt):Void;

	@:native("glDetachShader")
	static function detachShader(program:GlUInt, shader:GlUInt):Void;

	@:native("glDisableVertexAttribArray")
	static function disableVertexAttribArray(index:GlUInt):Void;

	@:native("glEnableVertexAttribArray")
	static function enableVertexAttribArray(index:GlUInt):Void;

	@:native("glGetActiveAttrib")
	static function getActiveAttrib(program:GlUInt, index:GlUInt, bufSize:GlSizeI, length:RawPointer<GlSizeI>, size:RawPointer<GlInt>, type:RawPointer<GlEnum>, name:RawPointer<GlChar>):Void;

	@:native("glGetActiveUniform")
	static function getActiveUniform(program:GlUInt, index:GlUInt, bufSize:GlSizeI, length:RawPointer<GlSizeI>, size:RawPointer<GlInt>, type:RawPointer<GlEnum>, name:RawPointer<GlChar>):Void;

	@:native("glGetAttachedShaders")
	static function getAttachedShaders(program:GlUInt, maxCount:GlSizeI, count:RawPointer<GlSizeI>, shaders:RawPointer<GlUInt>):Void;

	@:native("glGetAttribLocation")
	static function getAttribLocation(program:GlUInt, name:ConstCharStar):GlInt;

	@:native("glGetProgramiv")
	static function getProgramiv(program:GlUInt, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glGetProgramInfoLog")
	static function getProgramInfoLog(program:GlUInt, bufSize:GlSizeI, length:RawPointer<GlSizeI>, infoLog:RawPointer<GlChar>):Void;

	@:native("glGetShaderiv")
	static function getShaderiv(shader:GlUInt, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glGetShaderInfoLog")
	static function getShaderInfoLog(shader:GlUInt, bufSize:GlSizeI, length:RawPointer<GlSizeI>, infoLog:RawPointer<GlChar>):Void;

	@:native("glGetShaderSource")
	static function getShaderSource(shader:GlUInt, bufSize:GlSizeI, length:RawPointer<GlSizeI>, source:RawPointer<GlChar>):Void;

	@:native("glGetUniformLocation")
	static function getUniformLocation(program:GlUInt, name:ConstCharStar):GlInt;

	@:native("glGetUniformfv")
	static function getUniformfv(program:GlUInt, location:GlInt, params:RawPointer<GlFloat>):Void;

	@:native("glGetUniformiv")
	static function getUniformiv(program:GlUInt, location:GlInt, params:RawPointer<GlInt>):Void;

	@:native("glGetVertexAttribdv")
	static function getVertexAttribdv(index:GlUInt, pname:GlEnum, params:RawPointer<GlDouble>):Void;

	@:native("glGetVertexAttribfv")
	static function getVertexAttribfv(index:GlUInt, pname:GlEnum, params:RawPointer<GlFloat>):Void;

	@:native("glGetVertexAttribiv")
	static function getVertexAttribiv(index:GlUInt, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glGetVertexAttribPointerv")
	static function getVertexAttribPointerv(index:GlUInt, pname:GlEnum, pointer:RawPointer<Any>):Void;

	@:native("glIsProgram")
	static function isProgram(program:GlUInt):GlBool;

	@:native("glIsShader")
	static function isShader(shader:GlUInt):GlBool;

	@:native("glLinkProgram")
	static function linkProgram(program:GlUInt):Void;

	@:native("glShaderSource")
	static function shaderSource(shader:GlUInt, count:GlSizeI, string:RawPointer<ConstCharStar>, length:RawPointer<GlInt>):Void;

	@:native("glUseProgram")
	static function useProgram(program:GlUInt):Void;

	@:native("glUniform1f")
	static function uniform1f(location:GlInt, v0:GlFloat):Void;

	@:native("glUniform2f")
	static function uniform2f(location:GlInt, v0:GlFloat, v1:GlFloat):Void;

	@:native("glUniform3f")
	static function uniform3f(location:GlInt, v0:GlFloat, v1:GlFloat, v2:GlFloat):Void;

	@:native("glUniform4f")
	static function uniform4f(location:GlInt, v0:GlFloat, v1:GlFloat, v2:GlFloat, v3:GlFloat):Void;

	@:native("glUniform1i")
	static function uniform1i(location:GlInt, v0:GlInt):Void;

	@:native("glUniform2i")
	static function uniform2i(location:GlInt, v0:GlInt, v1:GlInt):Void;

	@:native("glUniform3i")
	static function uniform3i(location:GlInt, v0:GlInt, v1:GlInt, v2:GlInt):Void;

	@:native("glUniform4i")
	static function uniform4i(location:GlInt, v0:GlInt, v1:GlInt, v2:GlInt, v3:GlInt):Void;

	@:native("glUniform1fv")
	static function uniform1fv(location:GlInt, count:GlSizeI, value:RawPointer<GlFloat>):Void;

	@:native("glUniform2fv")
	static function uniform2fv(location:GlInt, count:GlSizeI, value:RawPointer<GlFloat>):Void;

	@:native("glUniform3fv")
	static function uniform3fv(location:GlInt, count:GlSizeI, value:RawPointer<GlFloat>):Void;

	@:native("glUniform4fv")
	static function uniform4fv(location:GlInt, count:GlSizeI, value:RawPointer<GlFloat>):Void;

	@:native("glUniform1iv")
	static function uniform1iv(location:GlInt, count:GlSizeI, value:RawPointer<GlInt>):Void;

	@:native("glUniform2iv")
	static function uniform2iv(location:GlInt, count:GlSizeI, value:RawPointer<GlInt>):Void;

	@:native("glUniform3iv")
	static function uniform3iv(location:GlInt, count:GlSizeI, value:RawPointer<GlInt>):Void;

	@:native("glUniform4iv")
	static function uniform4iv(location:GlInt, count:GlSizeI, value:RawPointer<GlInt>):Void;

	@:native("glUniformMatrix2fv")
	static function uniformMatrix2fv(location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlFloat>):Void;

	@:native("glUniformMatrix3fv")
	static function uniformMatrix3fv(location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlFloat>):Void;

	@:native("glUniformMatrix4fv")
	static function uniformMatrix4fv(location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlFloat>):Void;

	@:native("glValidateProgram")
	static function validateProgram(program:GlUInt):Void;

	@:native("glVertexAttrib1d")
	static function vertexAttrib1d(index:GlUInt, x:GlDouble):Void;

	@:native("glVertexAttrib1dv")
	static function vertexAttrib1dv(index:GlUInt, v:RawPointer<GlDouble>):Void;

	@:native("glVertexAttrib1f")
	static function vertexAttrib1f(index:GlUInt, x:GlFloat):Void;

	@:native("glVertexAttrib1fv")
	static function vertexAttrib1fv(index:GlUInt, v:RawPointer<GlFloat>):Void;

	@:native("glVertexAttrib1s")
	static function vertexAttrib1s(index:GlUInt, x:GlShort):Void;

	@:native("glVertexAttrib1sv")
	static function vertexAttrib1sv(index:GlUInt, v:RawPointer<GlShort>):Void;

	@:native("glVertexAttrib2d")
	static function vertexAttrib2d(index:GlUInt, x:GlDouble, y:GlDouble):Void;

	@:native("glVertexAttrib2dv")
	static function vertexAttrib2dv(index:GlUInt, v:RawPointer<GlDouble>):Void;

	@:native("glVertexAttrib2f")
	static function vertexAttrib2f(index:GlUInt, x:GlFloat, y:GlFloat):Void;

	@:native("glVertexAttrib2fv")
	static function vertexAttrib2fv(index:GlUInt, v:RawPointer<GlFloat>):Void;

	@:native("glVertexAttrib2s")
	static function vertexAttrib2s(index:GlUInt, x:GlShort, y:GlShort):Void;

	@:native("glVertexAttrib2sv")
	static function vertexAttrib2sv(index:GlUInt, v:RawPointer<GlShort>):Void;

	@:native("glVertexAttrib3d")
	static function vertexAttrib3d(index:GlUInt, x:GlDouble, y:GlDouble, z:GlDouble):Void;

	@:native("glVertexAttrib3dv")
	static function vertexAttrib3dv(index:GlUInt, v:RawPointer<GlDouble>):Void;

	@:native("glVertexAttrib3f")
	static function vertexAttrib3f(index:GlUInt, x:GlFloat, y:GlFloat, z:GlFloat):Void;

	@:native("glVertexAttrib3fv")
	static function vertexAttrib3fv(index:GlUInt, v:RawPointer<GlFloat>):Void;

	@:native("glVertexAttrib3s")
	static function vertexAttrib3s(index:GlUInt, x:GlShort, y:GlShort, z:GlShort):Void;

	@:native("glVertexAttrib3sv")
	static function vertexAttrib3sv(index:GlUInt, v:RawPointer<GlShort>):Void;

	@:native("glVertexAttrib4Nbv")
	static function vertexAttrib4Nbv(index:GlUInt, v:RawPointer<GlByte>):Void;

	@:native("glVertexAttrib4Niv")
	static function vertexAttrib4Niv(index:GlUInt, v:RawPointer<GlInt>):Void;

	@:native("glVertexAttrib4Nsv")
	static function vertexAttrib4Nsv(index:GlUInt, v:RawPointer<GlShort>):Void;

	@:native("glVertexAttrib4Nub")
	static function vertexAttrib4Nub(index:GlUInt, x:GlUByte, y:GlUByte, z:GlUByte, w:GlUByte):Void;

	@:native("glVertexAttrib4Nubv")
	static function vertexAttrib4Nubv(index:GlUInt, v:RawPointer<GlUByte>):Void;

	@:native("glVertexAttrib4Nuiv")
	static function vertexAttrib4Nuiv(index:GlUInt, v:RawPointer<GlUInt>):Void;

	@:native("glVertexAttrib4Nusv")
	static function vertexAttrib4Nusv(index:GlUInt, v:RawPointer<GlUShort>):Void;

	@:native("glVertexAttrib4bv")
	static function vertexAttrib4bv(index:GlUInt, v:RawPointer<GlByte>):Void;

	@:native("glVertexAttrib4d")
	static function vertexAttrib4d(index:GlUInt, x:GlDouble, y:GlDouble, z:GlDouble, w:GlDouble):Void;

	@:native("glVertexAttrib4dv")
	static function vertexAttrib4dv(index:GlUInt, v:RawPointer<GlDouble>):Void;

	@:native("glVertexAttrib4f")
	static function vertexAttrib4f(index:GlUInt, x:GlFloat, y:GlFloat, z:GlFloat, w:GlFloat):Void;

	@:native("glVertexAttrib4fv")
	static function vertexAttrib4fv(index:GlUInt, v:RawPointer<GlFloat>):Void;

	@:native("glVertexAttrib4iv")
	static function vertexAttrib4iv(index:GlUInt, v:RawPointer<GlInt>):Void;

	@:native("glVertexAttrib4s")
	static function vertexAttrib4s(index:GlUInt, x:GlShort, y:GlShort, z:GlShort, w:GlShort):Void;

	@:native("glVertexAttrib4sv")
	static function vertexAttrib4sv(index:GlUInt, v:RawPointer<GlShort>):Void;

	@:native("glVertexAttrib4ubv")
	static function vertexAttrib4ubv(index:GlUInt, v:RawPointer<GlUByte>):Void;

	@:native("glVertexAttrib4uiv")
	static function vertexAttrib4uiv(index:GlUInt, v:RawPointer<GlUInt>):Void;

	@:native("glVertexAttrib4usv")
	static function vertexAttrib4usv(index:GlUInt, v:RawPointer<GlUShort>):Void;

	@:native("glVertexAttribPointer")
	static function vertexAttribPointer(index:GlUInt, size:GlInt, type:GlEnum, normalized:GlBool, stride:GlSizeI, pointer:cpp.RawConstPointer<cpp.Void>):Void;

	@:native("glUniformMatrix2x3fv")
	static function uniformMatrix2x3fv(location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlFloat>):Void;

	@:native("glUniformMatrix3x2fv")
	static function uniformMatrix3x2fv(location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlFloat>):Void;

	@:native("glUniformMatrix2x4fv")
	static function uniformMatrix2x4fv(location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlFloat>):Void;

	@:native("glUniformMatrix4x2fv")
	static function uniformMatrix4x2fv(location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlFloat>):Void;

	@:native("glUniformMatrix3x4fv")
	static function uniformMatrix3x4fv(location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlFloat>):Void;

	@:native("glUniformMatrix4x3fv")
	static function uniformMatrix4x3fv(location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlFloat>):Void;

	@:native("glColorMaski")
	static function colorMaski(index:GlUInt, r:GlBool, g:GlBool, b:GlBool, a:GlBool):Void;

	@:native("glGetBooleani_v")
	static function getBooleani_v(target:GlEnum, index:GlUInt, data:RawPointer<GlBool>):Void;

	@:native("glGetIntegeri_v")
	static function getIntegeri_v(target:GlEnum, index:GlUInt, data:RawPointer<GlInt>):Void;

	@:native("glEnablei")
	static function enablei(target:GlEnum, index:GlUInt):Void;

	@:native("glDisablei")
	static function disablei(target:GlEnum, index:GlUInt):Void;

	@:native("glIsEnabledi")
	static function isEnabledi(target:GlEnum, index:GlUInt):GlBool;

	@:native("glBeginTransformFeedback")
	static function beginTransformFeedback(primitiveMode:GlEnum):Void;

	@:native("glEndTransformFeedback")
	static function endTransformFeedback():Void;

	@:native("glBindBufferRange")
	static function bindBufferRange(target:GlEnum, index:GlUInt, buffer:GlUInt, offset:GlIntPointer, size:GlSizeIPointer):Void;

	@:native("glBindBufferBase")
	static function bindBufferBase(target:GlEnum, index:GlUInt, buffer:GlUInt):Void;

	@:native("glTransformFeedbackVaryings")
	static function transformFeedbackVaryings(program:GlUInt, count:GlSizeI, varyings:RawPointer<ConstCharStar>, bufferMode:GlEnum):Void;

	@:native("glGetTransformFeedbackVarying")
	static function getTransformFeedbackVarying(program:GlUInt, index:GlUInt, bufSize:GlSizeI, length:RawPointer<GlSizeI>, size:RawPointer<GlSizeI>, type:RawPointer<GlEnum>, name:RawPointer<GlChar>):Void;

	@:native("glClampColor")
	static function clampColor(target:GlEnum, clamp:GlEnum):Void;

	@:native("glBeginConditionalRender")
	static function beginConditionalRender(id:GlUInt, mode:GlEnum):Void;

	@:native("glEndConditionalRender")
	static function endConditionalRender():Void;

	@:native("glVertexAttribIPointer")
	static function vertexAttribIPointer(index:GlUInt, size:GlInt, type:GlEnum, stride:GlSizeI, pointer:cpp.RawConstPointer<cpp.Void>):Void;

	@:native("glGetVertexAttribIiv")
	static function getVertexAttribIiv(index:GlUInt, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glGetVertexAttribIuiv")
	static function getVertexAttribIuiv(index:GlUInt, pname:GlEnum, params:RawPointer<GlUInt>):Void;

	@:native("glVertexAttribI1i")
	static function vertexAttribI1i(index:GlUInt, x:GlInt):Void;

	@:native("glVertexAttribI2i")
	static function vertexAttribI2i(index:GlUInt, x:GlInt, y:GlInt):Void;

	@:native("glVertexAttribI3i")
	static function vertexAttribI3i(index:GlUInt, x:GlInt, y:GlInt, z:GlInt):Void;

	@:native("glVertexAttribI4i")
	static function vertexAttribI4i(index:GlUInt, x:GlInt, y:GlInt, z:GlInt, w:GlInt):Void;

	@:native("glVertexAttribI1ui")
	static function vertexAttribI1ui(index:GlUInt, x:GlUInt):Void;

	@:native("glVertexAttribI2ui")
	static function vertexAttribI2ui(index:GlUInt, x:GlUInt, y:GlUInt):Void;

	@:native("glVertexAttribI3ui")
	static function vertexAttribI3ui(index:GlUInt, x:GlUInt, y:GlUInt, z:GlUInt):Void;

	@:native("glVertexAttribI4ui")
	static function vertexAttribI4ui(index:GlUInt, x:GlUInt, y:GlUInt, z:GlUInt, w:GlUInt):Void;

	@:native("glVertexAttribI1iv")
	static function vertexAttribI1iv(index:GlUInt, v:RawPointer<GlInt>):Void;

	@:native("glVertexAttribI2iv")
	static function vertexAttribI2iv(index:GlUInt, v:RawPointer<GlInt>):Void;

	@:native("glVertexAttribI3iv")
	static function vertexAttribI3iv(index:GlUInt, v:RawPointer<GlInt>):Void;

	@:native("glVertexAttribI4iv")
	static function vertexAttribI4iv(index:GlUInt, v:RawPointer<GlInt>):Void;

	@:native("glVertexAttribI1uiv")
	static function vertexAttribI1uiv(index:GlUInt, v:RawPointer<GlUInt>):Void;

	@:native("glVertexAttribI2uiv")
	static function vertexAttribI2uiv(index:GlUInt, v:RawPointer<GlUInt>):Void;

	@:native("glVertexAttribI3uiv")
	static function vertexAttribI3uiv(index:GlUInt, v:RawPointer<GlUInt>):Void;

	@:native("glVertexAttribI4uiv")
	static function vertexAttribI4uiv(index:GlUInt, v:RawPointer<GlUInt>):Void;

	@:native("glVertexAttribI4bv")
	static function vertexAttribI4bv(index:GlUInt, v:RawPointer<GlByte>):Void;

	@:native("glVertexAttribI4sv")
	static function vertexAttribI4sv(index:GlUInt, v:RawPointer<GlShort>):Void;

	@:native("glVertexAttribI4ubv")
	static function vertexAttribI4ubv(index:GlUInt, v:RawPointer<GlUByte>):Void;

	@:native("glVertexAttribI4usv")
	static function vertexAttribI4usv(index:GlUInt, v:RawPointer<GlUShort>):Void;

	@:native("glGetUniformuiv")
	static function getUniformuiv(program:GlUInt, location:GlInt, params:RawPointer<GlUInt>):Void;

	@:native("glBindFragDataLocation")
	static function bindFragDataLocation(program:GlUInt, color:GlUInt, name:ConstCharStar):Void;

	@:native("glGetFragDataLocation")
	static function getFragDataLocation(program:GlUInt, name:ConstCharStar):GlInt;

	@:native("glUniform1ui")
	static function uniform1ui(location:GlInt, v0:GlUInt):Void;

	@:native("glUniform2ui")
	static function uniform2ui(location:GlInt, v0:GlUInt, v1:GlUInt):Void;

	@:native("glUniform3ui")
	static function uniform3ui(location:GlInt, v0:GlUInt, v1:GlUInt, v2:GlUInt):Void;

	@:native("glUniform4ui")
	static function uniform4ui(location:GlInt, v0:GlUInt, v1:GlUInt, v2:GlUInt, v3:GlUInt):Void;

	@:native("glUniform1uiv")
	static function uniform1uiv(location:GlInt, count:GlSizeI, value:RawPointer<GlUInt>):Void;

	@:native("glUniform2uiv")
	static function uniform2uiv(location:GlInt, count:GlSizeI, value:RawPointer<GlUInt>):Void;

	@:native("glUniform3uiv")
	static function uniform3uiv(location:GlInt, count:GlSizeI, value:RawPointer<GlUInt>):Void;

	@:native("glUniform4uiv")
	static function uniform4uiv(location:GlInt, count:GlSizeI, value:RawPointer<GlUInt>):Void;

	@:native("glTexParameterIiv")
	static function texParameterIiv(target:GlEnum, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glTexParameterIuiv")
	static function texParameterIuiv(target:GlEnum, pname:GlEnum, params:RawPointer<GlUInt>):Void;

	@:native("glGetTexParameterIiv")
	static function getTexParameterIiv(target:GlEnum, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glGetTexParameterIuiv")
	static function getTexParameterIuiv(target:GlEnum, pname:GlEnum, params:RawPointer<GlUInt>):Void;

	@:native("glClearBufferiv")
	static function clearBufferiv(buffer:GlEnum, drawbuffer:GlInt, value:RawPointer<GlInt>):Void;

	@:native("glClearBufferuiv")
	static function clearBufferuiv(buffer:GlEnum, drawbuffer:GlInt, value:RawPointer<GlUInt>):Void;

	@:native("glClearBufferfv")
	static function clearBufferfv(buffer:GlEnum, drawbuffer:GlInt, value:RawPointer<GlFloat>):Void;

	@:native("glClearBufferfi")
	static function clearBufferfi(buffer:GlEnum, drawbuffer:GlInt, depth:GlFloat, stencil:GlInt):Void;

	@:native("glGetStringi")
	static function getStringi(name:GlEnum, index:GlUInt):RawPointer<GlUByte>;

	@:native("glIsRenderbuffer")
	static function isRenderbuffer(renderbuffer:GlUInt):GlBool;

	@:native("glBindRenderbuffer")
	static function bindRenderbuffer(target:GlEnum, renderbuffer:GlUInt):Void;

	@:native("glDeleteRenderbuffers")
	static function deleteRenderbuffers(n:GlSizeI, renderbuffers:RawPointer<GlUInt>):Void;

	@:native("glGenRenderbuffers")
	static function genRenderbuffers(n:GlSizeI, renderbuffers:RawPointer<GlUInt>):Void;

	@:native("glRenderbufferStorage")
	static function renderbufferStorage(target:GlEnum, internalformat:GlEnum, width:GlSizeI, height:GlSizeI):Void;

	@:native("glGetRenderbufferParameteriv")
	static function getRenderbufferParameteriv(target:GlEnum, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glIsFramebuffer")
	static function isFramebuffer(framebuffer:GlUInt):GlBool;

	@:native("glBindFramebuffer")
	static function bindFramebuffer(target:GlEnum, framebuffer:GlUInt):Void;

	@:native("glDeleteFramebuffers")
	static function deleteFramebuffers(n:GlSizeI, framebuffers:RawPointer<GlUInt>):Void;

	@:native("glGenFramebuffers")
	static function genFramebuffers(n:GlSizeI, framebuffers:RawPointer<GlUInt>):Void;

	@:native("glCheckFramebufferStatus")
	static function checkFramebufferStatus(target:GlEnum):GlEnum;

	@:native("glFramebufferTexture1D")
	static function framebufferTexture1D(target:GlEnum, attachment:GlEnum, textarget:GlEnum, texture:GlUInt, level:GlInt):Void;

	@:native("glFramebufferTexture2D")
	static function framebufferTexture2D(target:GlEnum, attachment:GlEnum, textarget:GlEnum, texture:GlUInt, level:GlInt):Void;

	@:native("glFramebufferTexture3D")
	static function framebufferTexture3D(target:GlEnum, attachment:GlEnum, textarget:GlEnum, texture:GlUInt, level:GlInt, zoffset:GlInt):Void;

	@:native("glFramebufferRenderbuffer")
	static function framebufferRenderbuffer(target:GlEnum, attachment:GlEnum, renderbuffertarget:GlEnum, renderbuffer:GlUInt):Void;

	@:native("glGetFramebufferAttachmentParameteriv")
	static function getFramebufferAttachmentParameteriv(target:GlEnum, attachment:GlEnum, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glGenerateMipmap")
	static function generateMipmap(target:GlEnum):Void;

	@:native("glBlitFramebuffer")
	static function blitFramebuffer(srcX0:GlInt, srcY0:GlInt, srcX1:GlInt, srcY1:GlInt, dstX0:GlInt, dstY0:GlInt, dstX1:GlInt, dstY1:GlInt, mask:GlBitField, filter:GlEnum):Void;

	@:native("glRenderbufferStorageMultisample")
	static function renderbufferStorageMultisample(target:GlEnum, samples:GlSizeI, internalformat:GlEnum, width:GlSizeI, height:GlSizeI):Void;

	@:native("glFramebufferTextureLayer")
	static function framebufferTextureLayer(target:GlEnum, attachment:GlEnum, texture:GlUInt, level:GlInt, layer:GlInt):Void;

	inline static function mapBufferRange(target:GlEnum, offset:GlIntPointer, length:GlSizeIPointer, access:GlBitField):Any {
		return untyped __cpp__("glMapBufferRange({0}, {1}, {2}, {3})", target, offset, length, access);
	}

	@:native("glFlushMappedBufferRange")
	static function flushMappedBufferRange(target:GlEnum, offset:GlIntPointer, length:GlSizeIPointer):Void;

	@:native("glBindVertexArray")
	static function bindVertexArray(array:GlUInt):Void;

	@:native("glDeleteVertexArrays")
	static function deleteVertexArrays(n:GlSizeI, arrays:RawPointer<GlUInt>):Void;

	@:native("glGenVertexArrays")
	static function genVertexArrays(n:GlSizeI, arrays:RawPointer<GlUInt>):Void;

	@:native("glIsVertexArray")
	static function isVertexArray(array:GlUInt):GlBool;

	@:native("glDrawArraysInstanced")
	static function drawArraysInstanced(mode:GlEnum, first:GlInt, count:GlSizeI, instanceCount:GlSizeI):Void;

	inline static function drawElementsInstanced(mode:GlEnum, count:GlSizeI, type:GlEnum, indices:Any, instanceCount:GlSizeI):Void {
		untyped __cpp__("glDrawElementsInstanced({0}, {1}, {2} {3}, {4})", mode, count, type, indices, instanceCount);
	}

	@:native("glTexBuffer")
	static function texBuffer(target:GlEnum, internalformat:GlEnum, buffer:GlUInt):Void;

	@:native("glPrimitiveRestartIndex")
	static function primitiveRestartIndex(index:GlUInt):Void;

	@:native("glCopyBufferSubData")
	static function copyBufferSubData(readTarget:GlEnum, writeTarget:GlEnum, readOffset:GlIntPointer, writeOffset:GlIntPointer, size:GlSizeIPointer):Void;

	@:native("glGetUniformIndices")
	static function getUniformIndices(program:GlUInt, uniformCount:GlSizeI, uniformNames:RawPointer<ConstCharStar>, uniformIndices:RawPointer<GlUInt>):Void;

	@:native("glGetActiveUniformsiv")
	static function getActiveUniformsiv(program:GlUInt, uniformCount:GlSizeI, uniformIndices:RawPointer<GlUInt>, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glGetActiveUniformName")
	static function getActiveUniformName(program:GlUInt, uniformIndex:GlUInt, bufSize:GlSizeI, length:RawPointer<GlSizeI>, uniformName:RawPointer<GlChar>):Void;

	@:native("glGetUniformBlockIndex")
	static function getUniformBlockIndex(program:GlUInt, uniformBlockName:ConstCharStar):GlUInt;

	@:native("glGetActiveUniformBlockiv")
	static function getActiveUniformBlockiv(program:GlUInt, uniformBlockIndex:GlUInt, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glGetActiveUniformBlockName")
	static function getActiveUniformBlockName(program:GlUInt, uniformBlockIndex:GlUInt, bufSize:GlSizeI, length:RawPointer<GlSizeI>, uniformBlockName:RawPointer<GlChar>):Void;

	@:native("glUniformBlockBinding")
	static function uniformBlockBinding(program:GlUInt, uniformBlockIndex:GlUInt, uniformBlockBinding:GlUInt):Void;

	inline static function drawElementsBaseVertex(mode:GlEnum, count:GlSizeI, type:GlEnum, indices:Any, baseVertex:GlInt):Void {
		untyped __cpp__("glDrawElementsBaseVertex({0}, {1}, {2} {3}, {4})", mode, count, type, indices, baseVertex);
	}

	inline static function drawRangeElementsBaseVertex(mode:GlEnum, start:GlUInt, end:GlUInt, count:GlSizeI, type:GlEnum, indices:Any, baseVertex:GlInt):Void {
		untyped __cpp__("glDrawRangeElementsBaseVertex({0}, {1}, {2} {3}, {4}, {5}, {6})", mode, start, end, count, type, indices, instanceCount);
	}

	inline static function drawElementsInstancedBaseVertex(mode:GlEnum, count:GlSizeI, type:GlEnum, indices:Any, instanceCount:GlSizeI, baseVertex:GlInt):Void {
		untyped __cpp__("glDrawElementsInstancedBaseVertex({0}, {1}, {2} {3}, {4}, {5})", mode, count, type, indices, instanceCount, baseVertex);
	}

	// @:native("glMultiDrawElementsBaseVertex") same reason as line 1855.
	// static function multiDrawElementsBaseVertex(mode:GlEnum, count:RawPointer<GlSizeI>, type:GlEnum, const*indices:Any, drawcount:GlSizeI, basevertex:RawPointer<GlInt>):Void;

	@:native("glProvokingVertex")
	static function provokingVertex(mode:GlEnum):Void;

	@:native("glFenceSync")
	static function fenceSync(condition:GlEnum, flags:GlBitField):GlSync;

	@:native("glIsSync")
	static function isSync(sync:GlSync):GlBool;

	@:native("glDeleteSync")
	static function deleteSync(sync:GlSync):Void;

	@:native("glClientWaitSync")
	static function clientWaitSync(sync:GlSync, flags:GlBitField, timeout:GlUInt64):GlEnum;

	@:native("glWaitSync")
	static function waitSync(sync:GlSync, flags:GlBitField, timeout:GlUInt64):Void;

	@:native("glGetInteger64v")
	static function getInteger64v(pname:GlEnum, data:RawPointer<cpp.Int64>):Void;

	@:native("glGetSynciv")
	static function getSynciv(sync:GlSync, pname:GlEnum, count:GlSizeI, length:RawPointer<GlSizeI>, values:RawPointer<GlInt>):Void;

	@:native("glGetInteger64i_v")
	static function getInteger64i_v(target:GlEnum, index:GlUInt, data:RawPointer<cpp.Int64>):Void;

	@:native("glGetBufferParameteri64v")
	static function getBufferParameteri64v(target:GlEnum, pname:GlEnum, params:RawPointer<cpp.Int64>):Void;

	@:native("glFramebufferTexture")
	static function framebufferTexture(target:GlEnum, attachment:GlEnum, texture:GlUInt, level:GlInt):Void;

	@:native("glTexImage2DMultisample")
	static function texImage2DMultisample(target:GlEnum, samples:GlSizeI, internalformat:GlEnum, width:GlSizeI, height:GlSizeI, fixedsamplelocations:GlBool):Void;

	@:native("glTexImage3DMultisample")
	static function texImage3DMultisample(target:GlEnum, samples:GlSizeI, internalformat:GlEnum, width:GlSizeI, height:GlSizeI, depth:GlSizeI, fixedsamplelocations:GlBool):Void;

	@:native("glGetMultisamplefv")
	static function getMultisamplefv(pname:GlEnum, index:GlUInt, val:RawPointer<GlFloat>):Void;

	@:native("glSampleMaski")
	static function sampleMaski(maskNumber:GlUInt, mask:GlBitField):Void;

	@:native("glBindFragDataLocationIndexed")
	static function bindFragDataLocationIndexed(program:GlUInt, colorNumber:GlUInt, index:GlUInt, name:ConstCharStar):Void;

	@:native("glGetFragDataIndex")
	static function getFragDataIndex(program:GlUInt, name:ConstCharStar):GlInt;

	@:native("glGenSamplers")
	static function genSamplers(count:GlSizeI, samplers:RawPointer<GlUInt>):Void;

	@:native("glDeleteSamplers")
	static function deleteSamplers(count:GlSizeI, samplers:RawPointer<GlUInt>):Void;

	@:native("glIsSampler")
	static function isSampler(sampler:GlUInt):GlBool;

	@:native("glBindSampler")
	static function bindSampler(unit:GlUInt, sampler:GlUInt):Void;

	@:native("glSamplerParameteri")
	static function samplerParameteri(sampler:GlUInt, pname:GlEnum, param:GlInt):Void;

	@:native("glSamplerParameteriv")
	static function samplerParameteriv(sampler:GlUInt, pname:GlEnum, param:RawPointer<GlInt>):Void;

	@:native("glSamplerParameterf")
	static function samplerParameterf(sampler:GlUInt, pname:GlEnum, param:GlFloat):Void;

	@:native("glSamplerParameterfv")
	static function samplerParameterfv(sampler:GlUInt, pname:GlEnum, param:RawPointer<GlFloat>):Void;

	@:native("glSamplerParameterIiv")
	static function samplerParameterIiv(sampler:GlUInt, pname:GlEnum, param:RawPointer<GlInt>):Void;

	@:native("glSamplerParameterIuiv")
	static function samplerParameterIuiv(sampler:GlUInt, pname:GlEnum, param:RawPointer<GlUInt>):Void;

	@:native("glGetSamplerParameteriv")
	static function getSamplerParameteriv(sampler:GlUInt, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glGetSamplerParameterIiv")
	static function getSamplerParameterIiv(sampler:GlUInt, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glGetSamplerParameterfv")
	static function getSamplerParameterfv(sampler:GlUInt, pname:GlEnum, params:RawPointer<GlFloat>):Void;

	@:native("glGetSamplerParameterIuiv")
	static function getSamplerParameterIuiv(sampler:GlUInt, pname:GlEnum, params:RawPointer<GlUInt>):Void;

	@:native("glQueryCounter")
	static function queryCounter(id:GlUInt, target:GlEnum):Void;

	@:native("glGetQueryObjecti64v")
	static function getQueryObjecti64v(id:GlUInt, pname:GlEnum, params:RawPointer<cpp.Int64>):Void;

	@:native("glGetQueryObjectui64v")
	static function getQueryObjectui64v(id:GlUInt, pname:GlEnum, params:RawPointer<cpp.UInt64>):Void;

	@:native("glVertexAttribDivisor")
	static function vertexAttribDivisor(index:GlUInt, divisor:GlUInt):Void;

	@:native("glVertexAttribP1ui")
	static function vertexAttribP1ui(index:GlUInt, type:GlEnum, normalized:GlBool, value:GlUInt):Void;

	@:native("glVertexAttribP1uiv")
	static function vertexAttribP1uiv(index:GlUInt, type:GlEnum, normalized:GlBool, value:RawPointer<GlUInt>):Void;

	@:native("glVertexAttribP2ui")
	static function vertexAttribP2ui(index:GlUInt, type:GlEnum, normalized:GlBool, value:GlUInt):Void;

	@:native("glVertexAttribP2uiv")
	static function vertexAttribP2uiv(index:GlUInt, type:GlEnum, normalized:GlBool, value:RawPointer<GlUInt>):Void;

	@:native("glVertexAttribP3ui")
	static function vertexAttribP3ui(index:GlUInt, type:GlEnum, normalized:GlBool, value:GlUInt):Void;

	@:native("glVertexAttribP3uiv")
	static function vertexAttribP3uiv(index:GlUInt, type:GlEnum, normalized:GlBool, value:RawPointer<GlUInt>):Void;

	@:native("glVertexAttribP4ui")
	static function vertexAttribP4ui(index:GlUInt, type:GlEnum, normalized:GlBool, value:GlUInt):Void;

	@:native("glVertexAttribP4uiv")
	static function vertexAttribP4uiv(index:GlUInt, type:GlEnum, normalized:GlBool, value:RawPointer<GlUInt>):Void;

	@:native("glVertexP2ui")
	static function vertexP2ui(type:GlEnum, value:GlUInt):Void;

	@:native("glVertexP2uiv")
	static function vertexP2uiv(type:GlEnum, value:RawPointer<GlUInt>):Void;

	@:native("glVertexP3ui")
	static function vertexP3ui(type:GlEnum, value:GlUInt):Void;

	@:native("glVertexP3uiv")
	static function vertexP3uiv(type:GlEnum, value:RawPointer<GlUInt>):Void;

	@:native("glVertexP4ui")
	static function vertexP4ui(type:GlEnum, value:GlUInt):Void;

	@:native("glVertexP4uiv")
	static function vertexP4uiv(type:GlEnum, value:RawPointer<GlUInt>):Void;

	@:native("glTexCoordP1ui")
	static function texCoordP1ui(type:GlEnum, coords:GlUInt):Void;

	@:native("glTexCoordP1uiv")
	static function texCoordP1uiv(type:GlEnum, coords:RawPointer<GlUInt>):Void;

	@:native("glTexCoordP2ui")
	static function texCoordP2ui(type:GlEnum, coords:GlUInt):Void;

	@:native("glTexCoordP2uiv")
	static function texCoordP2uiv(type:GlEnum, coords:RawPointer<GlUInt>):Void;

	@:native("glTexCoordP3ui")
	static function texCoordP3ui(type:GlEnum, coords:GlUInt):Void;

	@:native("glTexCoordP3uiv")
	static function texCoordP3uiv(type:GlEnum, coords:RawPointer<GlUInt>):Void;

	@:native("glTexCoordP4ui")
	static function texCoordP4ui(type:GlEnum, coords:GlUInt):Void;

	@:native("glTexCoordP4uiv")
	static function texCoordP4uiv(type:GlEnum, coords:RawPointer<GlUInt>):Void;

	@:native("glMultiTexCoordP1ui")
	static function multiTexCoordP1ui(texture:GlEnum, type:GlEnum, coords:GlUInt):Void;

	@:native("glMultiTexCoordP1uiv")
	static function multiTexCoordP1uiv(texture:GlEnum, type:GlEnum, coords:RawPointer<GlUInt>):Void;

	@:native("glMultiTexCoordP2ui")
	static function multiTexCoordP2ui(texture:GlEnum, type:GlEnum, coords:GlUInt):Void;

	@:native("glMultiTexCoordP2uiv")
	static function multiTexCoordP2uiv(texture:GlEnum, type:GlEnum, coords:RawPointer<GlUInt>):Void;

	@:native("glMultiTexCoordP3ui")
	static function multiTexCoordP3ui(texture:GlEnum, type:GlEnum, coords:GlUInt):Void;

	@:native("glMultiTexCoordP3uiv")
	static function multiTexCoordP3uiv(texture:GlEnum, type:GlEnum, coords:RawPointer<GlUInt>):Void;

	@:native("glMultiTexCoordP4ui")
	static function multiTexCoordP4ui(texture:GlEnum, type:GlEnum, coords:GlUInt):Void;

	@:native("glMultiTexCoordP4uiv")
	static function multiTexCoordP4uiv(texture:GlEnum, type:GlEnum, coords:RawPointer<GlUInt>):Void;

	@:native("glNormalP3ui")
	static function normalP3ui(type:GlEnum, coords:GlUInt):Void;

	@:native("glNormalP3uiv")
	static function normalP3uiv(type:GlEnum, coords:RawPointer<GlUInt>):Void;

	@:native("glColorP3ui")
	static function colorP3ui(type:GlEnum, color:GlUInt):Void;

	@:native("glColorP3uiv")
	static function colorP3uiv(type:GlEnum, color:RawPointer<GlUInt>):Void;

	@:native("glColorP4ui")
	static function colorP4ui(type:GlEnum, color:GlUInt):Void;

	@:native("glColorP4uiv")
	static function colorP4uiv(type:GlEnum, color:RawPointer<GlUInt>):Void;

	@:native("glSecondaryColorP3ui")
	static function secondaryColorP3ui(type:GlEnum, color:GlUInt):Void;

	@:native("glSecondaryColorP3uiv")
	static function secondaryColorP3uiv(type:GlEnum, color:RawPointer<GlUInt>):Void;

	@:native("glMinSampleShading")
	static function minSampleShading(value:GlFloat):Void;

	@:native("glBlendEquationi")
	static function blendEquationi(buf:GlUInt, mode:GlEnum):Void;

	@:native("glBlendEquationSeparatei")
	static function blendEquationSeparatei(buf:GlUInt, modeRGB:GlEnum, modeAlpha:GlEnum):Void;

	@:native("glBlendFunci")
	static function blendFunci(buf:GlUInt, src:GlEnum, dst:GlEnum):Void;

	@:native("glBlendFuncSeparatei")
	static function blendFuncSeparatei(buf:GlUInt, srcRGB:GlEnum, dstRGB:GlEnum, srcAlpha:GlEnum, dstAlpha:GlEnum):Void;

	@:native("glDrawArraysIndirect")
	static function drawArraysIndirect(mode:GlEnum, indirect:Any):Void;

	@:native("glDrawElementsIndirect")
	static function drawElementsIndirect(mode:GlEnum, type:GlEnum, indirect:Any):Void;

	@:native("glUniform1d")
	static function uniform1d(location:GlInt, x:GlDouble):Void;

	@:native("glUniform2d")
	static function uniform2d(location:GlInt, x:GlDouble, y:GlDouble):Void;

	@:native("glUniform3d")
	static function uniform3d(location:GlInt, x:GlDouble, y:GlDouble, z:GlDouble):Void;

	@:native("glUniform4d")
	static function uniform4d(location:GlInt, x:GlDouble, y:GlDouble, z:GlDouble, w:GlDouble):Void;

	@:native("glUniform1dv")
	static function uniform1dv(location:GlInt, count:GlSizeI, value:RawPointer<GlDouble>):Void;

	@:native("glUniform2dv")
	static function uniform2dv(location:GlInt, count:GlSizeI, value:RawPointer<GlDouble>):Void;

	@:native("glUniform3dv")
	static function uniform3dv(location:GlInt, count:GlSizeI, value:RawPointer<GlDouble>):Void;

	@:native("glUniform4dv")
	static function uniform4dv(location:GlInt, count:GlSizeI, value:RawPointer<GlDouble>):Void;

	@:native("glUniformMatrix2dv")
	static function uniformMatrix2dv(location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlDouble>):Void;

	@:native("glUniformMatrix3dv")
	static function uniformMatrix3dv(location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlDouble>):Void;

	@:native("glUniformMatrix4dv")
	static function uniformMatrix4dv(location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlDouble>):Void;

	@:native("glUniformMatrix2x3dv")
	static function uniformMatrix2x3dv(location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlDouble>):Void;

	@:native("glUniformMatrix2x4dv")
	static function uniformMatrix2x4dv(location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlDouble>):Void;

	@:native("glUniformMatrix3x2dv")
	static function uniformMatrix3x2dv(location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlDouble>):Void;

	@:native("glUniformMatrix3x4dv")
	static function uniformMatrix3x4dv(location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlDouble>):Void;

	@:native("glUniformMatrix4x2dv")
	static function uniformMatrix4x2dv(location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlDouble>):Void;

	@:native("glUniformMatrix4x3dv")
	static function uniformMatrix4x3dv(location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlDouble>):Void;

	@:native("glGetUniformdv")
	static function getUniformdv(program:GlUInt, location:GlInt, params:RawPointer<GlDouble>):Void;

	@:native("glGetSubroutineUniformLocation")
	static function getSubroutineUniformLocation(program:GlUInt, shadertype:GlEnum, name:ConstCharStar):GlInt;

	@:native("glGetSubroutineIndex")
	static function getSubroutineIndex(program:GlUInt, shadertype:GlEnum, name:ConstCharStar):GlUInt;

	@:native("glGetActiveSubroutineUniformiv")
	static function getActiveSubroutineUniformiv(program:GlUInt, shadertype:GlEnum, index:GlUInt, pname:GlEnum, values:RawPointer<GlInt>):Void;

	@:native("glGetActiveSubroutineUniformName")
	static function getActiveSubroutineUniformName(program:GlUInt, shadertype:GlEnum, index:GlUInt, bufSize:GlSizeI, length:RawPointer<GlSizeI>, name:RawPointer<GlChar>):Void;

	@:native("glGetActiveSubroutineName")
	static function getActiveSubroutineName(program:GlUInt, shadertype:GlEnum, index:GlUInt, bufSize:GlSizeI, length:RawPointer<GlSizeI>, name:RawPointer<GlChar>):Void;

	@:native("glUniformSubroutinesuiv")
	static function uniformSubroutinesuiv(shadertype:GlEnum, count:GlSizeI, indices:RawPointer<GlUInt>):Void;

	@:native("glGetUniformSubroutineuiv")
	static function getUniformSubroutineuiv(shadertype:GlEnum, location:GlInt, params:RawPointer<GlUInt>):Void;

	@:native("glGetProgramStageiv")
	static function getProgramStageiv(program:GlUInt, shadertype:GlEnum, pname:GlEnum, values:RawPointer<GlInt>):Void;

	@:native("glPatchParameteri")
	static function patchParameteri(pname:GlEnum, value:GlInt):Void;

	@:native("glPatchParameterfv")
	static function patchParameterfv(pname:GlEnum, values:RawPointer<GlFloat>):Void;

	@:native("glBindTransformFeedback")
	static function bindTransformFeedback(target:GlEnum, id:GlUInt):Void;

	@:native("glDeleteTransformFeedbacks")
	static function deleteTransformFeedbacks(n:GlSizeI, ids:RawPointer<GlUInt>):Void;

	@:native("glGenTransformFeedbacks")
	static function genTransformFeedbacks(n:GlSizeI, ids:RawPointer<GlUInt>):Void;

	@:native("glIsTransformFeedback")
	static function isTransformFeedback(id:GlUInt):GlBool;

	@:native("glPauseTransformFeedback")
	static function pauseTransformFeedback():Void;

	@:native("glResumeTransformFeedback")
	static function resumeTransformFeedback():Void;

	@:native("glDrawTransformFeedback")
	static function drawTransformFeedback(mode:GlEnum, id:GlUInt):Void;

	@:native("glDrawTransformFeedbackStream")
	static function drawTransformFeedbackStream(mode:GlEnum, id:GlUInt, stream:GlUInt):Void;

	@:native("glBeginQueryIndexed")
	static function beginQueryIndexed(target:GlEnum, index:GlUInt, id:GlUInt):Void;

	@:native("glEndQueryIndexed")
	static function endQueryIndexed(target:GlEnum, index:GlUInt):Void;

	@:native("glGetQueryIndexediv")
	static function getQueryIndexediv(target:GlEnum, index:GlUInt, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glReleaseShaderCompiler")
	static function releaseShaderCompiler():Void;

	@:native("glShaderBinary")
	static function shaderBinary(count:GlSizeI, shaders:RawPointer<GlUInt>, binaryFormat:GlEnum, binary:Any, length:GlSizeI):Void;

	@:native("glGetShaderPrecisionFormat")
	static function getShaderPrecisionFormat(shadertype:GlEnum, precisiontype:GlEnum, range:RawPointer<GlInt>, precision:RawPointer<GlInt>):Void;

	@:native("glDepthRangef")
	static function depthRangef(n:GlFloat, f:GlFloat):Void;

	@:native("glClearDepthf")
	static function clearDepthf(d:GlFloat):Void;

	@:native("glGetProgramBinary")
	static function getProgramBinary(program:GlUInt, bufSize:GlSizeI, length:RawPointer<GlSizeI>, binaryFormat:RawPointer<GlEnum>, binary:Any):Void;

	@:native("glProgramBinary")
	static function programBinary(program:GlUInt, binaryFormat:GlEnum, binary:Any, length:GlSizeI):Void;

	@:native("glProgramParameteri")
	static function programParameteri(program:GlUInt, pname:GlEnum, value:GlInt):Void;

	@:native("glUseProgramStages")
	static function useProgramStages(pipeline:GlUInt, stages:GlBitField, program:GlUInt):Void;

	@:native("glActiveShaderProgram")
	static function activeShaderProgram(pipeline:GlUInt, program:GlUInt):Void;

	@:native("glCreateShaderProgramv")
	static function createShaderProgramv(type:GlEnum, count:GlSizeI, strings:RawPointer<ConstCharStar>):GlUInt;

	@:native("glBindProgramPipeline")
	static function bindProgramPipeline(pipeline:GlUInt):Void;

	@:native("glDeleteProgramPipelines")
	static function deleteProgramPipelines(n:GlSizeI, pipelines:RawPointer<GlUInt>):Void;

	@:native("glGenProgramPipelines")
	static function genProgramPipelines(n:GlSizeI, pipelines:RawPointer<GlUInt>):Void;

	@:native("glIsProgramPipeline")
	static function isProgramPipeline(pipeline:GlUInt):GlBool;

	@:native("glGetProgramPipelineiv")
	static function getProgramPipelineiv(pipeline:GlUInt, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glProgramUniform1i")
	static function programUniform1i(program:GlUInt, location:GlInt, v0:GlInt):Void;

	@:native("glProgramUniform1iv")
	static function programUniform1iv(program:GlUInt, location:GlInt, count:GlSizeI, value:RawPointer<GlInt>):Void;

	@:native("glProgramUniform1f")
	static function programUniform1f(program:GlUInt, location:GlInt, v0:GlFloat):Void;

	@:native("glProgramUniform1fv")
	static function programUniform1fv(program:GlUInt, location:GlInt, count:GlSizeI, value:RawPointer<GlFloat>):Void;

	@:native("glProgramUniform1d")
	static function programUniform1d(program:GlUInt, location:GlInt, v0:GlDouble):Void;

	@:native("glProgramUniform1dv")
	static function programUniform1dv(program:GlUInt, location:GlInt, count:GlSizeI, value:RawPointer<GlDouble>):Void;

	@:native("glProgramUniform1ui")
	static function programUniform1ui(program:GlUInt, location:GlInt, v0:GlUInt):Void;

	@:native("glProgramUniform1uiv")
	static function programUniform1uiv(program:GlUInt, location:GlInt, count:GlSizeI, value:RawPointer<GlUInt>):Void;

	@:native("glProgramUniform2i")
	static function programUniform2i(program:GlUInt, location:GlInt, v0:GlInt, v1:GlInt):Void;

	@:native("glProgramUniform2iv")
	static function programUniform2iv(program:GlUInt, location:GlInt, count:GlSizeI, value:RawPointer<GlInt>):Void;

	@:native("glProgramUniform2f")
	static function programUniform2f(program:GlUInt, location:GlInt, v0:GlFloat, v1:GlFloat):Void;

	@:native("glProgramUniform2fv")
	static function programUniform2fv(program:GlUInt, location:GlInt, count:GlSizeI, value:RawPointer<GlFloat>):Void;

	@:native("glProgramUniform2d")
	static function programUniform2d(program:GlUInt, location:GlInt, v0:GlDouble, v1:GlDouble):Void;

	@:native("glProgramUniform2dv")
	static function programUniform2dv(program:GlUInt, location:GlInt, count:GlSizeI, value:RawPointer<GlDouble>):Void;

	@:native("glProgramUniform2ui")
	static function programUniform2ui(program:GlUInt, location:GlInt, v0:GlUInt, v1:GlUInt):Void;

	@:native("glProgramUniform2uiv")
	static function programUniform2uiv(program:GlUInt, location:GlInt, count:GlSizeI, value:RawPointer<GlUInt>):Void;

	@:native("glProgramUniform3i")
	static function programUniform3i(program:GlUInt, location:GlInt, v0:GlInt, v1:GlInt, v2:GlInt):Void;

	@:native("glProgramUniform3iv")
	static function programUniform3iv(program:GlUInt, location:GlInt, count:GlSizeI, value:RawPointer<GlInt>):Void;

	@:native("glProgramUniform3f")
	static function programUniform3f(program:GlUInt, location:GlInt, v0:GlFloat, v1:GlFloat, v2:GlFloat):Void;

	@:native("glProgramUniform3fv")
	static function programUniform3fv(program:GlUInt, location:GlInt, count:GlSizeI, value:RawPointer<GlFloat>):Void;

	@:native("glProgramUniform3d")
	static function programUniform3d(program:GlUInt, location:GlInt, v0:GlDouble, v1:GlDouble, v2:GlDouble):Void;

	@:native("glProgramUniform3dv")
	static function programUniform3dv(program:GlUInt, location:GlInt, count:GlSizeI, value:RawPointer<GlDouble>):Void;

	@:native("glProgramUniform3ui")
	static function programUniform3ui(program:GlUInt, location:GlInt, v0:GlUInt, v1:GlUInt, v2:GlUInt):Void;

	@:native("glProgramUniform3uiv")
	static function programUniform3uiv(program:GlUInt, location:GlInt, count:GlSizeI, value:RawPointer<GlUInt>):Void;

	@:native("glProgramUniform4i")
	static function programUniform4i(program:GlUInt, location:GlInt, v0:GlInt, v1:GlInt, v2:GlInt, v3:GlInt):Void;

	@:native("glProgramUniform4iv")
	static function programUniform4iv(program:GlUInt, location:GlInt, count:GlSizeI, value:RawPointer<GlInt>):Void;

	@:native("glProgramUniform4f")
	static function programUniform4f(program:GlUInt, location:GlInt, v0:GlFloat, v1:GlFloat, v2:GlFloat, v3:GlFloat):Void;

	@:native("glProgramUniform4fv")
	static function programUniform4fv(program:GlUInt, location:GlInt, count:GlSizeI, value:RawPointer<GlFloat>):Void;

	@:native("glProgramUniform4d")
	static function programUniform4d(program:GlUInt, location:GlInt, v0:GlDouble, v1:GlDouble, v2:GlDouble, v3:GlDouble):Void;

	@:native("glProgramUniform4dv")
	static function programUniform4dv(program:GlUInt, location:GlInt, count:GlSizeI, value:RawPointer<GlDouble>):Void;

	@:native("glProgramUniform4ui")
	static function programUniform4ui(program:GlUInt, location:GlInt, v0:GlUInt, v1:GlUInt, v2:GlUInt, v3:GlUInt):Void;

	@:native("glProgramUniform4uiv")
	static function programUniform4uiv(program:GlUInt, location:GlInt, count:GlSizeI, value:RawPointer<GlUInt>):Void;

	@:native("glProgramUniformMatrix2fv")
	static function programUniformMatrix2fv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlFloat>):Void;

	@:native("glProgramUniformMatrix3fv")
	static function programUniformMatrix3fv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlFloat>):Void;

	@:native("glProgramUniformMatrix4fv")
	static function programUniformMatrix4fv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlFloat>):Void;

	@:native("glProgramUniformMatrix2dv")
	static function programUniformMatrix2dv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlDouble>):Void;

	@:native("glProgramUniformMatrix3dv")
	static function programUniformMatrix3dv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlDouble>):Void;

	@:native("glProgramUniformMatrix4dv")
	static function programUniformMatrix4dv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlDouble>):Void;

	@:native("glProgramUniformMatrix2x3fv")
	static function programUniformMatrix2x3fv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlFloat>):Void;

	@:native("glProgramUniformMatrix3x2fv")
	static function programUniformMatrix3x2fv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlFloat>):Void;

	@:native("glProgramUniformMatrix2x4fv")
	static function programUniformMatrix2x4fv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlFloat>):Void;

	@:native("glProgramUniformMatrix4x2fv")
	static function programUniformMatrix4x2fv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlFloat>):Void;

	@:native("glProgramUniformMatrix3x4fv")
	static function programUniformMatrix3x4fv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlFloat>):Void;

	@:native("glProgramUniformMatrix4x3fv")
	static function programUniformMatrix4x3fv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlFloat>):Void;

	@:native("glProgramUniformMatrix2x3dv")
	static function programUniformMatrix2x3dv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlDouble>):Void;

	@:native("glProgramUniformMatrix3x2dv")
	static function programUniformMatrix3x2dv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlDouble>):Void;

	@:native("glProgramUniformMatrix2x4dv")
	static function programUniformMatrix2x4dv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlDouble>):Void;

	@:native("glProgramUniformMatrix4x2dv")
	static function programUniformMatrix4x2dv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlDouble>):Void;

	@:native("glProgramUniformMatrix3x4dv")
	static function programUniformMatrix3x4dv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlDouble>):Void;

	@:native("glProgramUniformMatrix4x3dv")
	static function programUniformMatrix4x3dv(program:GlUInt, location:GlInt, count:GlSizeI, transpose:GlBool, value:RawPointer<GlDouble>):Void;

	@:native("glValidateProgramPipeline")
	static function validateProgramPipeline(pipeline:GlUInt):Void;

	@:native("glGetProgramPipelineInfoLog")
	static function getProgramPipelineInfoLog(pipeline:GlUInt, bufSize:GlSizeI, length:RawPointer<GlSizeI>, infoLog:RawPointer<GlChar>):Void;

	@:native("glVertexAttribL1d")
	static function vertexAttribL1d(index:GlUInt, x:GlDouble):Void;

	@:native("glVertexAttribL2d")
	static function vertexAttribL2d(index:GlUInt, x:GlDouble, y:GlDouble):Void;

	@:native("glVertexAttribL3d")
	static function vertexAttribL3d(index:GlUInt, x:GlDouble, y:GlDouble, z:GlDouble):Void;

	@:native("glVertexAttribL4d")
	static function vertexAttribL4d(index:GlUInt, x:GlDouble, y:GlDouble, z:GlDouble, w:GlDouble):Void;

	@:native("glVertexAttribL1dv")
	static function vertexAttribL1dv(index:GlUInt, v:RawPointer<GlDouble>):Void;

	@:native("glVertexAttribL2dv")
	static function vertexAttribL2dv(index:GlUInt, v:RawPointer<GlDouble>):Void;

	@:native("glVertexAttribL3dv")
	static function vertexAttribL3dv(index:GlUInt, v:RawPointer<GlDouble>):Void;

	@:native("glVertexAttribL4dv")
	static function vertexAttribL4dv(index:GlUInt, v:RawPointer<GlDouble>):Void;

	@:native("glVertexAttribLPointer")
	static function vertexAttribLPointer(index:GlUInt, size:GlInt, type:GlEnum, stride:GlSizeI, pointer:Any):Void;

	@:native("glGetVertexAttribLdv")
	static function getVertexAttribLdv(index:GlUInt, pname:GlEnum, params:RawPointer<GlDouble>):Void;

	@:native("glViewportArrayv")
	static function viewportArrayv(first:GlUInt, count:GlSizeI, v:RawPointer<GlFloat>):Void;

	@:native("glViewportIndexedf")
	static function viewportIndexedf(index:GlUInt, x:GlFloat, y:GlFloat, w:GlFloat, h:GlFloat):Void;

	@:native("glViewportIndexedfv")
	static function viewportIndexedfv(index:GlUInt, v:RawPointer<GlFloat>):Void;

	@:native("glScissorArrayv")
	static function scissorArrayv(first:GlUInt, count:GlSizeI, v:RawPointer<GlInt>):Void;

	@:native("glScissorIndexed")
	static function scissorIndexed(index:GlUInt, left:GlInt, bottom:GlInt, width:GlSizeI, height:GlSizeI):Void;

	@:native("glScissorIndexedv")
	static function scissorIndexedv(index:GlUInt, v:RawPointer<GlInt>):Void;

	@:native("glDepthRangeArrayv")
	static function depthRangeArrayv(first:GlUInt, count:GlSizeI, v:RawPointer<GlDouble>):Void;

	@:native("glDepthRangeIndexed")
	static function depthRangeIndexed(index:GlUInt, n:GlDouble, f:GlDouble):Void;

	@:native("glGetFloati_v")
	static function getFloati_v(target:GlEnum, index:GlUInt, data:RawPointer<GlFloat>):Void;

	@:native("glGetDoublei_v")
	static function getDoublei_v(target:GlEnum, index:GlUInt, data:RawPointer<GlDouble>):Void;

	@:native("glDrawArraysInstancedBaseInstance")
	static function drawArraysInstancedBaseInstance(mode:GlEnum, first:GlInt, count:GlSizeI, instancecount:GlSizeI, baseinstance:GlUInt):Void;

	@:native("glDrawElementsInstancedBaseInstance")
	static function drawElementsInstancedBaseInstance(mode:GlEnum, count:GlSizeI, type:GlEnum, indices:Any, instancecount:GlSizeI, baseinstance:GlUInt):Void;

	@:native("glDrawElementsInstancedBaseVertexBaseInstance")
	static function drawElementsInstancedBaseVertexBaseInstance(mode:GlEnum, count:GlSizeI, type:GlEnum, indices:Any, instancecount:GlSizeI, basevertex:GlInt, baseinstance:GlUInt):Void;

	@:native("glGetInternalformativ")
	static function getInternalformativ(target:GlEnum, internalformat:GlEnum, pname:GlEnum, count:GlSizeI, params:RawPointer<GlInt>):Void;

	@:native("glGetActiveAtomicCounterBufferiv")
	static function getActiveAtomicCounterBufferiv(program:GlUInt, bufferIndex:GlUInt, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glBindImageTexture")
	static function bindImageTexture(unit:GlUInt, texture:GlUInt, level:GlInt, layered:GlBool, layer:GlInt, access:GlEnum, format:GlEnum):Void;

	@:native("glMemoryBarrier")
	static function memoryBarrier(barriers:GlBitField):Void;

	@:native("glTexStorage1D")
	static function texStorage1D(target:GlEnum, levels:GlSizeI, internalformat:GlEnum, width:GlSizeI):Void;

	@:native("glTexStorage2D")
	static function texStorage2D(target:GlEnum, levels:GlSizeI, internalformat:GlEnum, width:GlSizeI, height:GlSizeI):Void;

	@:native("glTexStorage3D")
	static function texStorage3D(target:GlEnum, levels:GlSizeI, internalformat:GlEnum, width:GlSizeI, height:GlSizeI, depth:GlSizeI):Void;

	@:native("glDrawTransformFeedbackInstanced")
	static function drawTransformFeedbackInstanced(mode:GlEnum, id:GlUInt, instancecount:GlSizeI):Void;

	@:native("glDrawTransformFeedbackStreamInstanced")
	static function drawTransformFeedbackStreamInstanced(mode:GlEnum, id:GlUInt, stream:GlUInt, instancecount:GlSizeI):Void;

	@:native("glClearBufferData")
	static function clearBufferData(target:GlEnum, internalformat:GlEnum, format:GlEnum, type:GlEnum, data:Any):Void;

	@:native("glClearBufferSubData")
	static function clearBufferSubData(target:GlEnum, internalformat:GlEnum, offset:GlIntPointer, size:GlSizeIPointer, format:GlEnum, type:GlEnum, data:Any):Void;

	@:native("glDispatchCompute")
	static function dispatchCompute(num_groups_x:GlUInt, num_groups_y:GlUInt, num_groups_z:GlUInt):Void;

	@:native("glDispatchComputeIndirect")
	static function dispatchComputeIndirect(indirect:GlIntPointer):Void;

	@:native("glCopyImageSubData")
	static function copyImageSubData(srcName:GlUInt, srcTarget:GlEnum, srcLevel:GlInt, srcX:GlInt, srcY:GlInt, srcZ:GlInt, dstName:GlUInt, dstTarget:GlEnum, dstLevel:GlInt, dstX:GlInt, dstY:GlInt, dstZ:GlInt, srcWidth:GlSizeI, srcHeight:GlSizeI, srcDepth:GlSizeI):Void;

	@:native("glFramebufferParameteri")
	static function framebufferParameteri(target:GlEnum, pname:GlEnum, param:GlInt):Void;

	@:native("glGetFramebufferParameteriv")
	static function getFramebufferParameteriv(target:GlEnum, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glGetInternalformati64v")
	static function getInternalformati64v(target:GlEnum, internalformat:GlEnum, pname:GlEnum, count:GlSizeI, params:RawPointer<cpp.Int64>):Void;

	@:native("glInvalidateTexSubImage")
	static function invalidateTexSubImage(texture:GlUInt, level:GlInt, xoffset:GlInt, yoffset:GlInt, zoffset:GlInt, width:GlSizeI, height:GlSizeI, depth:GlSizeI):Void;

	@:native("glInvalidateTexImage")
	static function invalidateTexImage(texture:GlUInt, level:GlInt):Void;

	@:native("glInvalidateBufferSubData")
	static function invalidateBufferSubData(buffer:GlUInt, offset:GlIntPointer, length:GlSizeIPointer):Void;

	@:native("glInvalidateBufferData")
	static function invalidateBufferData(buffer:GlUInt):Void;

	@:native("glInvalidateFramebuffer")
	static function invalidateFramebuffer(target:GlEnum, numAttachments:GlSizeI, attachments:RawPointer<GlEnum>):Void;

	@:native("glInvalidateSubFramebuffer")
	static function invalidateSubFramebuffer(target:GlEnum, numAttachments:GlSizeI, attachments:RawPointer<GlEnum>, x:GlInt, y:GlInt, width:GlSizeI, height:GlSizeI):Void;

	@:native("glMultiDrawArraysIndirect")
	static function multiDrawArraysIndirect(mode:GlEnum, indirect:Any, drawcount:GlSizeI, stride:GlSizeI):Void;

	@:native("glMultiDrawElementsIndirect")
	static function multiDrawElementsIndirect(mode:GlEnum, type:GlEnum, indirect:Any, drawcount:GlSizeI, stride:GlSizeI):Void;

	@:native("glGetProgramInterfaceiv")
	static function getProgramInterfaceiv(program:GlUInt, programInterface:GlEnum, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glGetProgramResourceIndex")
	static function getProgramResourceIndex(program:GlUInt, programInterface:GlEnum, name:ConstCharStar):GlUInt;

	@:native("glGetProgramResourceName")
	static function getProgramResourceName(program:GlUInt, programInterface:GlEnum, index:GlUInt, bufSize:GlSizeI, length:RawPointer<GlSizeI>, name:RawPointer<GlChar>):Void;

	@:native("glGetProgramResourceiv")
	static function getProgramResourceiv(program:GlUInt, programInterface:GlEnum, index:GlUInt, propCount:GlSizeI, props:RawPointer<GlEnum>, count:GlSizeI, length:RawPointer<GlSizeI>, params:RawPointer<GlInt>):Void;

	@:native("glGetProgramResourceLocation")
	static function getProgramResourceLocation(program:GlUInt, programInterface:GlEnum, name:ConstCharStar):GlInt;

	@:native("glGetProgramResourceLocationIndex")
	static function getProgramResourceLocationIndex(program:GlUInt, programInterface:GlEnum, name:ConstCharStar):GlInt;

	@:native("glShaderStorageBlockBinding")
	static function shaderStorageBlockBinding(program:GlUInt, storageBlockIndex:GlUInt, storageBlockBinding:GlUInt):Void;

	@:native("glTexBufferRange")
	static function texBufferRange(target:GlEnum, internalformat:GlEnum, buffer:GlUInt, offset:GlIntPointer, size:GlSizeIPointer):Void;

	@:native("glTexStorage2DMultisample")
	static function texStorage2DMultisample(target:GlEnum, samples:GlSizeI, internalformat:GlEnum, width:GlSizeI, height:GlSizeI, fixedsamplelocations:GlBool):Void;

	@:native("glTexStorage3DMultisample")
	static function texStorage3DMultisample(target:GlEnum, samples:GlSizeI, internalformat:GlEnum, width:GlSizeI, height:GlSizeI, depth:GlSizeI, fixedsamplelocations:GlBool):Void;

	@:native("glTextureView")
	static function textureView(texture:GlUInt, target:GlEnum, origtexture:GlUInt, internalformat:GlEnum, minlevel:GlUInt, numlevels:GlUInt, minlayer:GlUInt, numlayers:GlUInt):Void;

	@:native("glBindVertexBuffer")
	static function bindVertexBuffer(bindingindex:GlUInt, buffer:GlUInt, offset:GlIntPointer, stride:GlSizeI):Void;

	@:native("glVertexAttribFormat")
	static function vertexAttribFormat(attribindex:GlUInt, size:GlInt, type:GlEnum, normalized:GlBool, relativeoffset:GlUInt):Void;

	@:native("glVertexAttribIFormat")
	static function vertexAttribIFormat(attribindex:GlUInt, size:GlInt, type:GlEnum, relativeoffset:GlUInt):Void;

	@:native("glVertexAttribLFormat")
	static function vertexAttribLFormat(attribindex:GlUInt, size:GlInt, type:GlEnum, relativeoffset:GlUInt):Void;

	@:native("glVertexAttribBinding")
	static function vertexAttribBinding(attribindex:GlUInt, bindingindex:GlUInt):Void;

	@:native("glVertexBindingDivisor")
	static function vertexBindingDivisor(bindingindex:GlUInt, divisor:GlUInt):Void;

	@:native("glDebugMessageControl")
	static function debugMessageControl(source:GlEnum, type:GlEnum, severity:GlEnum, count:GlSizeI, ids:RawPointer<GlUInt>, enabled:GlBool):Void;

	@:native("glDebugMessageInsert")
	static function debugMessageInsert(source:GlEnum, type:GlEnum, id:GlUInt, severity:GlEnum, length:GlSizeI, buf:ConstCharStar):Void;

	@:native("glDebugMessageCallback")
	static function debugMessageCallback(callback:GlDebugProc, userParam:Any):Void;

	@:native("glGetDebugMessageLog")
	static function getDebugMessageLog(count:GlUInt, bufSize:GlSizeI, sources:RawPointer<GlEnum>, types:RawPointer<GlEnum>, ids:RawPointer<GlUInt>, severities:RawPointer<GlEnum>, lengths:RawPointer<GlSizeI>, messageLog:RawPointer<GlChar>):GlUInt;

	@:native("glPushDebugGroup")
	static function pushDebugGroup(source:GlEnum, id:GlUInt, length:GlSizeI, message:ConstCharStar):Void;

	@:native("glPopDebugGroup")
	static function popDebugGroup():Void;

	@:native("glObjectLabel")
	static function objectLabel(identifier:GlEnum, name:GlUInt, length:GlSizeI, label:ConstCharStar):Void;

	@:native("glGetObjectLabel")
	static function getObjectLabel(identifier:GlEnum, name:GlUInt, bufSize:GlSizeI, length:RawPointer<GlSizeI>, label:RawPointer<GlChar>):Void;

	@:native("glObjectPtrLabel")
	static function objectPtrLabel(ptr:Any, length:GlSizeI, label:ConstCharStar):Void;

	@:native("glGetObjectPtrLabel")
	static function getObjectPtrLabel(ptr:Any, bufSize:GlSizeI, length:RawPointer<GlSizeI>, label:RawPointer<GlChar>):Void;

	@:native("glGetPointerv")
	static function getPointerv(pname:GlEnum, params:RawPointer<Any>):Void;

	@:native("glBufferStorage")
	static function bufferStorage(target:GlEnum, size:GlSizeIPointer, data:Any, flags:GlBitField):Void;

	@:native("glClearTexImage")
	static function clearTexImage(texture:GlUInt, level:GlInt, format:GlEnum, type:GlEnum, data:Any):Void;

	@:native("glClearTexSubImage")
	static function clearTexSubImage(texture:GlUInt, level:GlInt, xoffset:GlInt, yoffset:GlInt, zoffset:GlInt, width:GlSizeI, height:GlSizeI, depth:GlSizeI, format:GlEnum, type:GlEnum, data:Any):Void;

	@:native("glBindBuffersBase")
	static function bindBuffersBase(target:GlEnum, first:GlUInt, count:GlSizeI, buffers:RawPointer<GlUInt>):Void;

	@:native("glBindBuffersRange")
	static function bindBuffersRange(target:GlEnum, first:GlUInt, count:GlSizeI, buffers:RawPointer<GlUInt>, offsets:RawPointer<GlIntPointer>, sizes:RawPointer<GlSizeIPointer>):Void;

	@:native("glBindTextures")
	static function bindTextures(first:GlUInt, count:GlSizeI, textures:RawPointer<GlUInt>):Void;

	@:native("glBindSamplers")
	static function bindSamplers(first:GlUInt, count:GlSizeI, samplers:RawPointer<GlUInt>):Void;

	@:native("glBindImageTextures")
	static function bindImageTextures(first:GlUInt, count:GlSizeI, textures:RawPointer<GlUInt>):Void;

	@:native("glBindVertexBuffers")
	static function bindVertexBuffers(first:GlUInt, count:GlSizeI, buffers:RawPointer<GlUInt>, offsets:RawPointer<GlIntPointer>, strides:RawPointer<GlSizeI>):Void;

	@:native("glClipControl")
	static function clipControl(origin:GlEnum, depth:GlEnum):Void;

	@:native("glCreateTransformFeedbacks")
	static function createTransformFeedbacks(n:GlSizeI, ids:RawPointer<GlUInt>):Void;

	@:native("glTransformFeedbackBufferBase")
	static function transformFeedbackBufferBase(xfb:GlUInt, index:GlUInt, buffer:GlUInt):Void;

	@:native("glTransformFeedbackBufferRange")
	static function transformFeedbackBufferRange(xfb:GlUInt, index:GlUInt, buffer:GlUInt, offset:GlIntPointer, size:GlSizeIPointer):Void;

	@:native("glGetTransformFeedbackiv")
	static function getTransformFeedbackiv(xfb:GlUInt, pname:GlEnum, param:RawPointer<GlInt>):Void;

	@:native("glGetTransformFeedbacki_v")
	static function getTransformFeedbacki_v(xfb:GlUInt, pname:GlEnum, index:GlUInt, param:RawPointer<GlInt>):Void;

	@:native("glGetTransformFeedbacki64_v")
	static function getTransformFeedbacki64_v(xfb:GlUInt, pname:GlEnum, index:GlUInt, param:RawPointer<cpp.Int64>):Void;

	@:native("glCreateBuffers")
	static function createBuffers(n:GlSizeI, buffers:RawPointer<GlUInt>):Void;

	@:native("glNamedBufferStorage")
	static function namedBufferStorage(buffer:GlUInt, size:GlSizeIPointer, data:Any, flags:GlBitField):Void;

	@:native("glNamedBufferData")
	static function namedBufferData(buffer:GlUInt, size:GlSizeIPointer, data:Any, usage:GlEnum):Void;

	@:native("glNamedBufferSubData")
	static function namedBufferSubData(buffer:GlUInt, offset:GlIntPointer, size:GlSizeIPointer, data:Any):Void;

	@:native("glCopyNamedBufferSubData")
	static function copyNamedBufferSubData(readBuffer:GlUInt, writeBuffer:GlUInt, readOffset:GlIntPointer, writeOffset:GlIntPointer, size:GlSizeIPointer):Void;

	@:native("glClearNamedBufferData")
	static function clearNamedBufferData(buffer:GlUInt, internalformat:GlEnum, format:GlEnum, type:GlEnum, data:Any):Void;

	@:native("glClearNamedBufferSubData")
	static function clearNamedBufferSubData(buffer:GlUInt, internalformat:GlEnum, offset:GlIntPointer, size:GlSizeIPointer, format:GlEnum, type:GlEnum, data:Any):Void;

	@:native("glMapNamedBuffer")
	static function mapNamedBuffer(buffer:GlUInt, access:GlEnum):Any;

	@:native("glMapNamedBufferRange")
	static function mapNamedBufferRange(buffer:GlUInt, offset:GlIntPointer, length:GlSizeIPointer, access:GlBitField):Any;

	@:native("glUnmapNamedBuffer")
	static function unmapNamedBuffer(buffer:GlUInt):GlBool;

	@:native("glFlushMappedNamedBufferRange")
	static function flushMappedNamedBufferRange(buffer:GlUInt, offset:GlIntPointer, length:GlSizeIPointer):Void;

	@:native("glGetNamedBufferParameteriv")
	static function getNamedBufferParameteriv(buffer:GlUInt, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glGetNamedBufferParameteri64v")
	static function getNamedBufferParameteri64v(buffer:GlUInt, pname:GlEnum, params:RawPointer<cpp.Int64>):Void;

	@:native("glGetNamedBufferPointerv")
	static function getNamedBufferPointerv(buffer:GlUInt, pname:GlEnum, params:RawPointer<Any>):Void;

	@:native("glGetNamedBufferSubData")
	static function getNamedBufferSubData(buffer:GlUInt, offset:GlIntPointer, size:GlSizeIPointer, data:Any):Void;

	@:native("glCreateFramebuffers")
	static function createFramebuffers(n:GlSizeI, framebuffers:RawPointer<GlUInt>):Void;

	@:native("glNamedFramebufferRenderbuffer")
	static function namedFramebufferRenderbuffer(framebuffer:GlUInt, attachment:GlEnum, renderbuffertarget:GlEnum, renderbuffer:GlUInt):Void;

	@:native("glNamedFramebufferParameteri")
	static function namedFramebufferParameteri(framebuffer:GlUInt, pname:GlEnum, param:GlInt):Void;

	@:native("glNamedFramebufferTexture")
	static function namedFramebufferTexture(framebuffer:GlUInt, attachment:GlEnum, texture:GlUInt, level:GlInt):Void;

	@:native("glNamedFramebufferTextureLayer")
	static function namedFramebufferTextureLayer(framebuffer:GlUInt, attachment:GlEnum, texture:GlUInt, level:GlInt, layer:GlInt):Void;

	@:native("glNamedFramebufferDrawBuffer")
	static function namedFramebufferDrawBuffer(framebuffer:GlUInt, buf:GlEnum):Void;

	@:native("glNamedFramebufferDrawBuffers")
	static function namedFramebufferDrawBuffers(framebuffer:GlUInt, n:GlSizeI, bufs:RawPointer<GlEnum>):Void;

	@:native("glNamedFramebufferReadBuffer")
	static function namedFramebufferReadBuffer(framebuffer:GlUInt, src:GlEnum):Void;

	@:native("glInvalidateNamedFramebufferData")
	static function invalidateNamedFramebufferData(framebuffer:GlUInt, numAttachments:GlSizeI, attachments:RawPointer<GlEnum>):Void;

	@:native("glInvalidateNamedFramebufferSubData")
	static function invalidateNamedFramebufferSubData(framebuffer:GlUInt, numAttachments:GlSizeI, attachments:RawPointer<GlEnum>, x:GlInt, y:GlInt, width:GlSizeI, height:GlSizeI):Void;

	@:native("glClearNamedFramebufferiv")
	static function clearNamedFramebufferiv(framebuffer:GlUInt, buffer:GlEnum, drawbuffer:GlInt, value:RawPointer<GlInt>):Void;

	@:native("glClearNamedFramebufferuiv")
	static function clearNamedFramebufferuiv(framebuffer:GlUInt, buffer:GlEnum, drawbuffer:GlInt, value:RawPointer<GlUInt>):Void;

	@:native("glClearNamedFramebufferfv")
	static function clearNamedFramebufferfv(framebuffer:GlUInt, buffer:GlEnum, drawbuffer:GlInt, value:RawPointer<GlFloat>):Void;

	@:native("glClearNamedFramebufferfi")
	static function clearNamedFramebufferfi(framebuffer:GlUInt, buffer:GlEnum, drawbuffer:GlInt, depth:GlFloat, stencil:GlInt):Void;

	@:native("glBlitNamedFramebuffer")
	static function blitNamedFramebuffer(readFramebuffer:GlUInt, drawFramebuffer:GlUInt, srcX0:GlInt, srcY0:GlInt, srcX1:GlInt, srcY1:GlInt, dstX0:GlInt, dstY0:GlInt, dstX1:GlInt, dstY1:GlInt, mask:GlBitField, filter:GlEnum):Void;

	@:native("glCheckNamedFramebufferStatus")
	static function checkNamedFramebufferStatus(framebuffer:GlUInt, target:GlEnum):GlEnum;

	@:native("glGetNamedFramebufferParameteriv")
	static function getNamedFramebufferParameteriv(framebuffer:GlUInt, pname:GlEnum, param:RawPointer<GlInt>):Void;

	@:native("glGetNamedFramebufferAttachmentParameteriv")
	static function getNamedFramebufferAttachmentParameteriv(framebuffer:GlUInt, attachment:GlEnum, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glCreateRenderbuffers")
	static function createRenderbuffers(n:GlSizeI, renderbuffers:RawPointer<GlUInt>):Void;

	@:native("glNamedRenderbufferStorage")
	static function namedRenderbufferStorage(renderbuffer:GlUInt, internalformat:GlEnum, width:GlSizeI, height:GlSizeI):Void;

	@:native("glNamedRenderbufferStorageMultisample")
	static function namedRenderbufferStorageMultisample(renderbuffer:GlUInt, samples:GlSizeI, internalformat:GlEnum, width:GlSizeI, height:GlSizeI):Void;

	@:native("glGetNamedRenderbufferParameteriv")
	static function getNamedRenderbufferParameteriv(renderbuffer:GlUInt, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glCreateTextures")
	static function createTextures(target:GlEnum, n:GlSizeI, textures:RawPointer<GlUInt>):Void;

	@:native("glTextureBuffer")
	static function textureBuffer(texture:GlUInt, internalformat:GlEnum, buffer:GlUInt):Void;

	@:native("glTextureBufferRange")
	static function textureBufferRange(texture:GlUInt, internalformat:GlEnum, buffer:GlUInt, offset:GlIntPointer, size:GlSizeIPointer):Void;

	@:native("glTextureStorage1D")
	static function textureStorage1D(texture:GlUInt, levels:GlSizeI, internalformat:GlEnum, width:GlSizeI):Void;

	@:native("glTextureStorage2D")
	static function textureStorage2D(texture:GlUInt, levels:GlSizeI, internalformat:GlEnum, width:GlSizeI, height:GlSizeI):Void;

	@:native("glTextureStorage3D")
	static function textureStorage3D(texture:GlUInt, levels:GlSizeI, internalformat:GlEnum, width:GlSizeI, height:GlSizeI, depth:GlSizeI):Void;

	@:native("glTextureStorage2DMultisample")
	static function textureStorage2DMultisample(texture:GlUInt, samples:GlSizeI, internalformat:GlEnum, width:GlSizeI, height:GlSizeI, fixedsamplelocations:GlBool):Void;

	@:native("glTextureStorage3DMultisample")
	static function textureStorage3DMultisample(texture:GlUInt, samples:GlSizeI, internalformat:GlEnum, width:GlSizeI, height:GlSizeI, depth:GlSizeI, fixedsamplelocations:GlBool):Void;

	@:native("glTextureSubImage1D")
	static function textureSubImage1D(texture:GlUInt, level:GlInt, xoffset:GlInt, width:GlSizeI, format:GlEnum, type:GlEnum, pixels:Any):Void;

	@:native("glTextureSubImage2D")
	static function textureSubImage2D(texture:GlUInt, level:GlInt, xoffset:GlInt, yoffset:GlInt, width:GlSizeI, height:GlSizeI, format:GlEnum, type:GlEnum, pixels:Any):Void;

	@:native("glTextureSubImage3D")
	static function textureSubImage3D(texture:GlUInt, level:GlInt, xoffset:GlInt, yoffset:GlInt, zoffset:GlInt, width:GlSizeI, height:GlSizeI, depth:GlSizeI, format:GlEnum, type:GlEnum, pixels:Any):Void;

	@:native("glCompressedTextureSubImage1D")
	static function compressedTextureSubImage1D(texture:GlUInt, level:GlInt, xoffset:GlInt, width:GlSizeI, format:GlEnum, imageSize:GlSizeI, data:Any):Void;

	@:native("glCompressedTextureSubImage2D")
	static function compressedTextureSubImage2D(texture:GlUInt, level:GlInt, xoffset:GlInt, yoffset:GlInt, width:GlSizeI, height:GlSizeI, format:GlEnum, imageSize:GlSizeI, data:Any):Void;

	@:native("glCompressedTextureSubImage3D")
	static function compressedTextureSubImage3D(texture:GlUInt, level:GlInt, xoffset:GlInt, yoffset:GlInt, zoffset:GlInt, width:GlSizeI, height:GlSizeI, depth:GlSizeI, format:GlEnum, imageSize:GlSizeI, data:Any):Void;

	@:native("glCopyTextureSubImage1D")
	static function copyTextureSubImage1D(texture:GlUInt, level:GlInt, xoffset:GlInt, x:GlInt, y:GlInt, width:GlSizeI):Void;

	@:native("glCopyTextureSubImage2D")
	static function copyTextureSubImage2D(texture:GlUInt, level:GlInt, xoffset:GlInt, yoffset:GlInt, x:GlInt, y:GlInt, width:GlSizeI, height:GlSizeI):Void;

	@:native("glCopyTextureSubImage3D")
	static function copyTextureSubImage3D(texture:GlUInt, level:GlInt, xoffset:GlInt, yoffset:GlInt, zoffset:GlInt, x:GlInt, y:GlInt, width:GlSizeI, height:GlSizeI):Void;

	@:native("glTextureParameterf")
	static function textureParameterf(texture:GlUInt, pname:GlEnum, param:GlFloat):Void;

	@:native("glTextureParameterfv")
	static function textureParameterfv(texture:GlUInt, pname:GlEnum, param:RawPointer<GlFloat>):Void;

	@:native("glTextureParameteri")
	static function textureParameteri(texture:GlUInt, pname:GlEnum, param:GlInt):Void;

	@:native("glTextureParameterIiv")
	static function textureParameterIiv(texture:GlUInt, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glTextureParameterIuiv")
	static function textureParameterIuiv(texture:GlUInt, pname:GlEnum, params:RawPointer<GlUInt>):Void;

	@:native("glTextureParameteriv")
	static function textureParameteriv(texture:GlUInt, pname:GlEnum, param:RawPointer<GlInt>):Void;

	@:native("glGenerateTextureMipmap")
	static function generateTextureMipmap(texture:GlUInt):Void;

	@:native("glBindTextureUnit")
	static function bindTextureUnit(unit:GlUInt, texture:GlUInt):Void;

	@:native("glGetTextureImage")
	static function getTextureImage(texture:GlUInt, level:GlInt, format:GlEnum, type:GlEnum, bufSize:GlSizeI, pixels:Any):Void;

	@:native("glGetCompressedTextureImage")
	static function getCompressedTextureImage(texture:GlUInt, level:GlInt, bufSize:GlSizeI, pixels:Any):Void;

	@:native("glGetTextureLevelParameterfv")
	static function getTextureLevelParameterfv(texture:GlUInt, level:GlInt, pname:GlEnum, params:RawPointer<GlFloat>):Void;

	@:native("glGetTextureLevelParameteriv")
	static function getTextureLevelParameteriv(texture:GlUInt, level:GlInt, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glGetTextureParameterfv")
	static function getTextureParameterfv(texture:GlUInt, pname:GlEnum, params:RawPointer<GlFloat>):Void;

	@:native("glGetTextureParameterIiv")
	static function getTextureParameterIiv(texture:GlUInt, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glGetTextureParameterIuiv")
	static function getTextureParameterIuiv(texture:GlUInt, pname:GlEnum, params:RawPointer<GlUInt>):Void;

	@:native("glGetTextureParameteriv")
	static function getTextureParameteriv(texture:GlUInt, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glCreateVertexArrays")
	static function createVertexArrays(n:GlSizeI, arrays:RawPointer<GlUInt>):Void;

	@:native("glDisableVertexArrayAttrib")
	static function disableVertexArrayAttrib(vaobj:GlUInt, index:GlUInt):Void;

	@:native("glEnableVertexArrayAttrib")
	static function enableVertexArrayAttrib(vaobj:GlUInt, index:GlUInt):Void;

	@:native("glVertexArrayElementBuffer")
	static function vertexArrayElementBuffer(vaobj:GlUInt, buffer:GlUInt):Void;

	@:native("glVertexArrayVertexBuffer")
	static function vertexArrayVertexBuffer(vaobj:GlUInt, bindingindex:GlUInt, buffer:GlUInt, offset:GlIntPointer, stride:GlSizeI):Void;

	@:native("glVertexArrayVertexBuffers")
	static function vertexArrayVertexBuffers(vaobj:GlUInt, first:GlUInt, count:GlSizeI, buffers:RawPointer<GlUInt>, offsets:RawPointer<GlIntPointer>, strides:RawPointer<GlSizeI>):Void;

	@:native("glVertexArrayAttribBinding")
	static function vertexArrayAttribBinding(vaobj:GlUInt, attribindex:GlUInt, bindingindex:GlUInt):Void;

	@:native("glVertexArrayAttribFormat")
	static function vertexArrayAttribFormat(vaobj:GlUInt, attribindex:GlUInt, size:GlInt, type:GlEnum, normalized:GlBool, relativeoffset:GlUInt):Void;

	@:native("glVertexArrayAttribIFormat")
	static function vertexArrayAttribIFormat(vaobj:GlUInt, attribindex:GlUInt, size:GlInt, type:GlEnum, relativeoffset:GlUInt):Void;

	@:native("glVertexArrayAttribLFormat")
	static function vertexArrayAttribLFormat(vaobj:GlUInt, attribindex:GlUInt, size:GlInt, type:GlEnum, relativeoffset:GlUInt):Void;

	@:native("glVertexArrayBindingDivisor")
	static function vertexArrayBindingDivisor(vaobj:GlUInt, bindingindex:GlUInt, divisor:GlUInt):Void;

	@:native("glGetVertexArrayiv")
	static function getVertexArrayiv(vaobj:GlUInt, pname:GlEnum, param:RawPointer<GlInt>):Void;

	@:native("glGetVertexArrayIndexediv")
	static function getVertexArrayIndexediv(vaobj:GlUInt, index:GlUInt, pname:GlEnum, param:RawPointer<GlInt>):Void;

	@:native("glGetVertexArrayIndexed64iv")
	static function getVertexArrayIndexed64iv(vaobj:GlUInt, index:GlUInt, pname:GlEnum, param:RawPointer<cpp.Int64>):Void;

	@:native("glCreateSamplers")
	static function createSamplers(n:GlSizeI, samplers:RawPointer<GlUInt>):Void;

	@:native("glCreateProgramPipelines")
	static function createProgramPipelines(n:GlSizeI, pipelines:RawPointer<GlUInt>):Void;

	@:native("glCreateQueries")
	static function createQueries(target:GlEnum, n:GlSizeI, ids:RawPointer<GlUInt>):Void;

	@:native("glGetQueryBufferObjecti64v")
	static function getQueryBufferObjecti64v(id:GlUInt, buffer:GlUInt, pname:GlEnum, offset:GlIntPointer):Void;

	@:native("glGetQueryBufferObjectiv")
	static function getQueryBufferObjectiv(id:GlUInt, buffer:GlUInt, pname:GlEnum, offset:GlIntPointer):Void;

	@:native("glGetQueryBufferObjectui64v")
	static function getQueryBufferObjectui64v(id:GlUInt, buffer:GlUInt, pname:GlEnum, offset:GlIntPointer):Void;

	@:native("glGetQueryBufferObjectuiv")
	static function getQueryBufferObjectuiv(id:GlUInt, buffer:GlUInt, pname:GlEnum, offset:GlIntPointer):Void;

	@:native("glMemoryBarrierByRegion")
	static function memoryBarrierByRegion(barriers:GlBitField):Void;

	@:native("glGetTextureSubImage")
	static function getTextureSubImage(texture:GlUInt, level:GlInt, xoffset:GlInt, yoffset:GlInt, zoffset:GlInt, width:GlSizeI, height:GlSizeI, depth:GlSizeI, format:GlEnum, type:GlEnum, bufSize:GlSizeI, pixels:Any):Void;

	@:native("glGetCompressedTextureSubImage")
	static function getCompressedTextureSubImage(texture:GlUInt, level:GlInt, xoffset:GlInt, yoffset:GlInt, zoffset:GlInt, width:GlSizeI, height:GlSizeI, depth:GlSizeI, bufSize:GlSizeI, pixels:Any):Void;

	@:native("glGetGraphicsResetStatus")
	static function getGraphicsResetStatus():GlEnum;

	@:native("glGetnCompressedTexImage")
	static function getnCompressedTexImage(target:GlEnum, lod:GlInt, bufSize:GlSizeI, pixels:Any):Void;

	@:native("glGetnTexImage")
	static function getnTexImage(target:GlEnum, level:GlInt, format:GlEnum, type:GlEnum, bufSize:GlSizeI, pixels:Any):Void;

	@:native("glGetnUniformdv")
	static function getnUniformdv(program:GlUInt, location:GlInt, bufSize:GlSizeI, params:RawPointer<GlDouble>):Void;

	@:native("glGetnUniformfv")
	static function getnUniformfv(program:GlUInt, location:GlInt, bufSize:GlSizeI, params:RawPointer<GlFloat>):Void;

	@:native("glGetnUniformiv")
	static function getnUniformiv(program:GlUInt, location:GlInt, bufSize:GlSizeI, params:RawPointer<GlInt>):Void;

	@:native("glGetnUniformuiv")
	static function getnUniformuiv(program:GlUInt, location:GlInt, bufSize:GlSizeI, params:RawPointer<GlUInt>):Void;

	@:native("glReadnPixels")
	static function readnPixels(x:GlInt, y:GlInt, width:GlSizeI, height:GlSizeI, format:GlEnum, type:GlEnum, bufSize:GlSizeI, data:Any):Void;

	@:native("glGetnMapdv")
	static function getnMapdv(target:GlEnum, query:GlEnum, bufSize:GlSizeI, v:RawPointer<GlDouble>):Void;

	@:native("glGetnMapfv")
	static function getnMapfv(target:GlEnum, query:GlEnum, bufSize:GlSizeI, v:RawPointer<GlFloat>):Void;

	@:native("glGetnMapiv")
	static function getnMapiv(target:GlEnum, query:GlEnum, bufSize:GlSizeI, v:RawPointer<GlInt>):Void;

	@:native("glGetnPixelMapfv")
	static function getnPixelMapfv(map:GlEnum, bufSize:GlSizeI, values:RawPointer<GlFloat>):Void;

	@:native("glGetnPixelMapuiv")
	static function getnPixelMapuiv(map:GlEnum, bufSize:GlSizeI, values:RawPointer<GlUInt>):Void;

	@:native("glGetnPixelMapusv")
	static function getnPixelMapusv(map:GlEnum, bufSize:GlSizeI, values:RawPointer<GlUShort>):Void;

	@:native("glGetnPolygonStipple")
	static function getnPolygonStipple(bufSize:GlSizeI, pattern:RawPointer<GlUByte>):Void;

	@:native("glGetnColorTable")
	static function getnColorTable(target:GlEnum, format:GlEnum, type:GlEnum, bufSize:GlSizeI, table:Any):Void;

	@:native("glGetnConvolutionFilter")
	static function getnConvolutionFilter(target:GlEnum, format:GlEnum, type:GlEnum, bufSize:GlSizeI, image:Any):Void;

	@:native("glGetnSeparableFilter")
	static function getnSeparableFilter(target:GlEnum, format:GlEnum, type:GlEnum, rowBufSize:GlSizeI, row:Any, columnBufSize:GlSizeI, column:Any, span:Any):Void;

	@:native("glGetnHistogram")
	static function getnHistogram(target:GlEnum, reset:GlBool, format:GlEnum, type:GlEnum, bufSize:GlSizeI, values:Any):Void;

	@:native("glGetnMinmax")
	static function getnMinmax(target:GlEnum, reset:GlBool, format:GlEnum, type:GlEnum, bufSize:GlSizeI, values:Any):Void;

	@:native("glTextureBarrier")
	static function textureBarrier():Void;

	@:native("glSpecializeShader")
	static function specializeShader(shader:GlUInt, pEntryPoint:ConstCharStar, numSpecializationConstants:GlUInt, pConstantIndex:RawPointer<GlUInt>, pConstantValue:RawPointer<GlUInt>):Void;

	@:native("glMultiDrawArraysIndirectCount")
	static function multiDrawArraysIndirectCount(mode:GlEnum, indirect:Any, drawcount:GlIntPointer, maxdrawcount:GlSizeI, stride:GlSizeI):Void;

	@:native("glMultiDrawElementsIndirectCount")
	static function multiDrawElementsIndirectCount(mode:GlEnum, type:GlEnum, indirect:Any, drawcount:GlIntPointer, maxdrawcount:GlSizeI, stride:GlSizeI):Void;

	@:native("glPolygonOffsetClamp")
	static function polygonOffsetClamp(factor:GlFloat, units:GlFloat, clamp:GlFloat):Void;

	@:native("glAlphaFunc")
	static function alphaFunc(func:GlEnum, ref:GlFloat):Void;

	@:native("glClipPlanef")
	static function clipPlanef(p:GlEnum, eqn:RawPointer<GlFloat>):Void;

	@:native("glColor4f")
	static function color4f(red:GlFloat, green:GlFloat, blue:GlFloat, alpha:GlFloat):Void;

	@:native("glFogf")
	static function fogf(pname:GlEnum, param:GlFloat):Void;

	@:native("glFogfv")
	static function fogfv(pname:GlEnum, params:RawPointer<GlFloat>):Void;

	@:native("glFrustumf")
	static function frustumf(l:GlFloat, r:GlFloat, b:GlFloat, t:GlFloat, n:GlFloat, f:GlFloat):Void;

	@:native("glGetClipPlanef")
	static function getClipPlanef(plane:GlEnum, equation:RawPointer<GlFloat>):Void;

	@:native("glGetLightfv")
	static function getLightfv(light:GlEnum, pname:GlEnum, params:RawPointer<GlFloat>):Void;

	@:native("glGetMaterialfv")
	static function getMaterialfv(face:GlEnum, pname:GlEnum, params:RawPointer<GlFloat>):Void;

	@:native("glGetTexEnvfv")
	static function getTexEnvfv(target:GlEnum, pname:GlEnum, params:RawPointer<GlFloat>):Void;

	@:native("glLightModelf")
	static function lightModelf(pname:GlEnum, param:GlFloat):Void;

	@:native("glLightModelfv")
	static function lightModelfv(pname:GlEnum, params:RawPointer<GlFloat>):Void;

	@:native("glLightf")
	static function lightf(light:GlEnum, pname:GlEnum, param:GlFloat):Void;

	@:native("glLightfv")
	static function lightfv(light:GlEnum, pname:GlEnum, params:RawPointer<GlFloat>):Void;

	@:native("glLoadMatrixf")
	static function loadMatrixf(m:RawPointer<GlFloat>):Void;

	@:native("glMaterialf")
	static function materialf(face:GlEnum, pname:GlEnum, param:GlFloat):Void;

	@:native("glMaterialfv")
	static function materialfv(face:GlEnum, pname:GlEnum, params:RawPointer<GlFloat>):Void;

	@:native("glMultMatrixf")
	static function multMatrixf(m:RawPointer<GlFloat>):Void;

	@:native("glMultiTexCoord4f")
	static function multiTexCoord4f(target:GlEnum, s:GlFloat, t:GlFloat, r:GlFloat, q:GlFloat):Void;

	@:native("glNormal3f")
	static function normal3f(nx:GlFloat, ny:GlFloat, nz:GlFloat):Void;

	@:native("glOrthof")
	static function orthof(l:GlFloat, r:GlFloat, b:GlFloat, t:GlFloat, n:GlFloat, f:GlFloat):Void;

	@:native("glRotatef")
	static function rotatef(angle:GlFloat, x:GlFloat, y:GlFloat, z:GlFloat):Void;

	@:native("glScalef")
	static function scalef(x:GlFloat, y:GlFloat, z:GlFloat):Void;

	@:native("glTexEnvf")
	static function texEnvf(target:GlEnum, pname:GlEnum, param:GlFloat):Void;

	@:native("glTexEnvfv")
	static function texEnvfv(target:GlEnum, pname:GlEnum, params:RawPointer<GlFloat>):Void;

	@:native("glTranslatef")
	static function translatef(x:GlFloat, y:GlFloat, z:GlFloat):Void;

	@:native("glAlphaFuncx")
	static function alphaFuncx(func:GlEnum, ref:GlFixed):Void;

	@:native("glClearColorx")
	static function clearColorx(red:GlFixed, green:GlFixed, blue:GlFixed, alpha:GlFixed):Void;

	@:native("glClearDepthx")
	static function clearDepthx(depth:GlFixed):Void;

	@:native("glClientActiveTexture")
	static function clientActiveTexture(texture:GlEnum):Void;

	@:native("glClipPlanex")
	static function clipPlanex(plane:GlEnum, equation:RawPointer<GlFixed>):Void;

	@:native("glColor4ub")
	static function color4ub(red:GlUByte, green:GlUByte, blue:GlUByte, alpha:GlUByte):Void;

	@:native("glColor4x")
	static function color4x(red:GlFixed, green:GlFixed, blue:GlFixed, alpha:GlFixed):Void;

	@:native("glColorPointer")
	static function colorPointer(size:GlInt, type:GlEnum, stride:GlSizeI, pointer:Any):Void;

	@:native("glDepthRangex")
	static function depthRangex(n:GlFixed, f:GlFixed):Void;

	@:native("glDisableClientState")
	static function disableClientState(array:GlEnum):Void;

	@:native("glEnableClientState")
	static function enableClientState(array:GlEnum):Void;

	@:native("glFogx")
	static function fogx(pname:GlEnum, param:GlFixed):Void;

	@:native("glFogxv")
	static function fogxv(pname:GlEnum, param:RawPointer<GlFixed>):Void;

	@:native("glFrustumx")
	static function frustumx(l:GlFixed, r:GlFixed, b:GlFixed, t:GlFixed, n:GlFixed, f:GlFixed):Void;

	@:native("glGetClipPlanex")
	static function getClipPlanex(plane:GlEnum, equation:RawPointer<GlFixed>):Void;

	@:native("glGetFixedv")
	static function getFixedv(pname:GlEnum, params:RawPointer<GlFixed>):Void;

	@:native("glGetLightxv")
	static function getLightxv(light:GlEnum, pname:GlEnum, params:RawPointer<GlFixed>):Void;

	@:native("glGetMaterialxv")
	static function getMaterialxv(face:GlEnum, pname:GlEnum, params:RawPointer<GlFixed>):Void;

	@:native("glGetTexEnviv")
	static function getTexEnviv(target:GlEnum, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glGetTexEnvxv")
	static function getTexEnvxv(target:GlEnum, pname:GlEnum, params:RawPointer<GlFixed>):Void;

	@:native("glGetTexParameterxv")
	static function getTexParameterxv(target:GlEnum, pname:GlEnum, params:RawPointer<GlFixed>):Void;

	@:native("glLightModelx")
	static function lightModelx(pname:GlEnum, param:GlFixed):Void;

	@:native("glLightModelxv")
	static function lightModelxv(pname:GlEnum, param:RawPointer<GlFixed>):Void;

	@:native("glLightx")
	static function lightx(light:GlEnum, pname:GlEnum, param:GlFixed):Void;

	@:native("glLightxv")
	static function lightxv(light:GlEnum, pname:GlEnum, params:RawPointer<GlFixed>):Void;

	@:native("glLineWidthx")
	static function lineWidthx(width:GlFixed):Void;

	@:native("glLoadIdentity")
	static function loadIdentity():Void;

	@:native("glLoadMatrixx")
	static function loadMatrixx(m:RawPointer<GlFixed>):Void;

	@:native("glMaterialx")
	static function materialx(face:GlEnum, pname:GlEnum, param:GlFixed):Void;

	@:native("glMaterialxv")
	static function materialxv(face:GlEnum, pname:GlEnum, param:RawPointer<GlFixed>):Void;

	@:native("glMatrixMode")
	static function matrixMode(mode:GlEnum):Void;

	@:native("glMultMatrixx")
	static function multMatrixx(m:RawPointer<GlFixed>):Void;

	@:native("glMultiTexCoord4x")
	static function multiTexCoord4x(texture:GlEnum, s:GlFixed, t:GlFixed, r:GlFixed, q:GlFixed):Void;

	@:native("glNormal3x")
	static function normal3x(nx:GlFixed, ny:GlFixed, nz:GlFixed):Void;

	@:native("glNormalPointer")
	static function normalPointer(type:GlEnum, stride:GlSizeI, pointer:Any):Void;

	@:native("glOrthox")
	static function orthox(l:GlFixed, r:GlFixed, b:GlFixed, t:GlFixed, n:GlFixed, f:GlFixed):Void;

	@:native("glPointParameterx")
	static function pointParameterx(pname:GlEnum, param:GlFixed):Void;

	@:native("glPointParameterxv")
	static function pointParameterxv(pname:GlEnum, params:RawPointer<GlFixed>):Void;

	@:native("glPointSizex")
	static function pointSizex(size:GlFixed):Void;

	@:native("glPolygonOffsetx")
	static function polygonOffsetx(factor:GlFixed, units:GlFixed):Void;

	@:native("glPopMatrix")
	static function popMatrix():Void;

	@:native("glPushMatrix")
	static function pushMatrix():Void;

	@:native("glRotatex")
	static function rotatex(angle:GlFixed, x:GlFixed, y:GlFixed, z:GlFixed):Void;

	@:native("glSampleCoveragex")
	static function sampleCoveragex(value:GlClampX, invert:GlBool):Void;

	@:native("glScalex")
	static function scalex(x:GlFixed, y:GlFixed, z:GlFixed):Void;

	@:native("glShadeModel")
	static function shadeModel(mode:GlEnum):Void;

	@:native("glTexCoordPointer")
	static function texCoordPointer(size:GlInt, type:GlEnum, stride:GlSizeI, pointer:Any):Void;

	@:native("glTexEnvi")
	static function texEnvi(target:GlEnum, pname:GlEnum, param:GlInt):Void;

	@:native("glTexEnvx")
	static function texEnvx(target:GlEnum, pname:GlEnum, param:GlFixed):Void;

	@:native("glTexEnviv")
	static function texEnviv(target:GlEnum, pname:GlEnum, params:RawPointer<GlInt>):Void;

	@:native("glTexEnvxv")
	static function texEnvxv(target:GlEnum, pname:GlEnum, params:RawPointer<GlFixed>):Void;

	@:native("glTexParameterx")
	static function texParameterx(target:GlEnum, pname:GlEnum, param:GlFixed):Void;

	@:native("glTexParameterxv")
	static function texParameterxv(target:GlEnum, pname:GlEnum, params:RawPointer<GlFixed>):Void;

	@:native("glTranslatex")
	static function translatex(x:GlFixed, y:GlFixed, z:GlFixed):Void;

	@:native("glVertexPointer")
	static function vertexPointer(size:GlInt, type:GlEnum, stride:GlSizeI, pointer:Any):Void;

	@:native("glBlendBarrier")
	static function blendBarrier():Void;

	@:native("glPrimitiveBoundingBox")
	static function primitiveBoundingBox(minX:GlFloat, minY:GlFloat, minZ:GlFloat, minW:GlFloat, maxX:GlFloat, maxY:GlFloat, maxZ:GlFloat, maxW:GlFloat):Void;
}
#end