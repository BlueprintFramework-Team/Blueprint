package bindings.audio;

import cpp.Callable;
import cpp.RawPointer;
import cpp.ConstCharStar;

// this is basically just DrWav.hx lmao but mp3
// - what-is-a-git

@:include('audio/dr_mp3.h')
@:native('drmp3_allocation_callbacks')
@:structAccess
extern class DrMP3AllocationCallbacks {
	@:native("pUserData")
	var userData:RawPointer<cpp.Void>;

	@:native("onMalloc")
	var onMalloc:RawPointer<Callable<(size:cpp.UInt64, userdata:RawPointer<cpp.Void>) -> RawPointer<cpp.Void>>>;
	@:native("onRealloc")
	var onRealloc:RawPointer<Callable<(pointer:RawPointer<cpp.Void>, size:cpp.UInt64, userdata:RawPointer<cpp.Void>) -> RawPointer<cpp.Void>>>;
	@:native("onFree")
	var onFree:RawPointer<Callable<(pointer:RawPointer<cpp.Void>, userdata:RawPointer<cpp.Void>) -> RawPointer<cpp.Void>>>;
}

@:include('audio/dr_mp3.h')
@:native('drmp3dec_frame_info')
@:structAccess
extern class DrMP3FrameInfo {
	@:native("frame_bytes")
	var frameBytes:Int;
	@:native("channels")
	var channels:Int;
	@:native("hz")
	var hz:Int;
	@:native("layer")
	var layer:Int;
	@:native("bitrate_kbps")
	var bitrateKbps:Int;
}

@:include('audio/dr_mp3.h')
@:native('drmp3dec')
@:structAccess
extern class _DrMP3Decoder {
	@:native("mdct_overlap")
	var mdctOverlap:RawPointer<Float>;
	@:native("qmf_state")
	var qmfState:RawPointer<Float>;
	@:native("reserv")
	var reserve:Int;
	@:native("free_format_bytes")
	var freeFormatBytes:Int;
	@:native("header")
	var header:RawPointer<cpp.UInt8>;
	@:native("reserv_buf")
	var reserveBuffer:RawPointer<cpp.UInt8>;
}
typedef DrMP3Decoder = RawPointer<_DrMP3Decoder>;

enum abstract DrMP3SeekOrigin(cpp.UInt32) {
	var START;
	var CURRENT;
}

@:include('audio/dr_mp3.h')
@:native('drmp3_seek_point')
@:structAccess
extern class DrMP3SeekPoint {
	@:native("seekPosInBytes")
	var posInBytes:cpp.UInt64;
	@:native("pcmFrameIndex")
	var pcmFrameIndex:cpp.UInt64;
	@:native("mp3FramesToDiscard")
	var mp3FramesToDiscard:cpp.UInt16;
	@:native("pcmFramesToDiscard")
	var pcmFramesToDiscard:Int;
}

typedef DrMP3ReadProc = Callable<(userdata:RawPointer<cpp.Void>, bufferOut:RawPointer<cpp.Void>, bytesToRead:cpp.UInt64) -> cpp.UInt64>;
typedef DrMP3SeekProc = Callable<(userdata:RawPointer<cpp.Void>, offset:Int, origin:DrMP3SeekOrigin) -> cpp.UInt32>;

@:include('audio/dr_mp3.h')
@:native('drmp3_config')
@:structAccess
extern class DrMP3Config {
	var channels:cpp.UInt32;
	var sampleRate:cpp.UInt32;
}

@:structAccess
extern class DrMP3Memory {
	var pData:RawPointer<cpp.UInt8>;
	var dataSize:cpp.UInt64;
	var currentReadPos:cpp.UInt64;
}

@:include('audio/dr_mp3.h')
@:native('drmp3')
@:structAccess
extern class DrMP3Data {
	var decoder:DrMP3Decoder;
	var channels:cpp.UInt32;
	var sampleRate:cpp.UInt32;
	var onRead:DrMP3ReadProc;
	var onSeek:DrMP3SeekProc;
	var pUserData:RawPointer<cpp.Void>;
	var allocationCallbacks:DrMP3AllocationCallbacks;
	var mp3FrameChannels:cpp.UInt32;
	var mp3FrameSampleRate:cpp.UInt32;
	var pcmFramesConsumedInMP3Frame:cpp.UInt32;
	var pcmFramesRemainingInMP3Frame:cpp.UInt32;
	var pcmFrames:RawPointer<cpp.UInt8>;
	var currentPCMFrame:cpp.UInt64;
	var streamCursor:cpp.UInt64;
	var pSeekPoints:RawPointer<DrMP3SeekPoint>;
	var dataSize:cpp.UInt64;
	var dataCapacity:cpp.UInt64;
	var dataConsumed:cpp.UInt64;
	var pData:RawPointer<cpp.UInt8>;
	var atEnd:cpp.UInt32;
	var memory:DrMP3Memory;
}
typedef DrMP3Ptr = RawPointer<DrMP3Data>;

@:include('audio/dr_mp3.h')
extern class DrMP3 {
	@:native("DRMP3_VERSION_MAJOR")
	static final VERSION_MAJOR:cpp.UInt32;
	@:native("DRMP3_VERSION_MINOR")
	static final VERSION_MINOR:cpp.UInt32;
	@:native("DRMP3_VERSION_REVISION")
	static final VERSION_REVISION:cpp.UInt32;
	@:native("DRMP3_VERSION_STRING")
	static final VERSION_STRING:ConstCharStar;

	@:native("DRMP3_MAX_PCM_FRAMES_PER_MP3_FRAME")
	static final MAX_PCM_FRAMES_PER_MP3_FRAME:cpp.UInt32;
	@:native("DRMP3_MAX_SAMPLES_PER_FRAME")
	static final MAX_SAMPLES_PER_FRAME:cpp.UInt32;



	@:native("drmp3_version")
	static function version(major:RawPointer<cpp.UInt32>, minor:RawPointer<cpp.UInt32>, revision:RawPointer<cpp.UInt32>):Void;
	@:native("drmp3_version_string")
	static function versionString():ConstCharStar;



	@:native("drmp3dec_init")
	static function decoderInit(decoder:DrMP3Decoder):Void;
	@:native("drmp3dec_decode_frame")
	static function decoderDecodeFrame(decoder:DrMP3Decoder, mp3:RawPointer<cpp.UInt8>, bytes:Int, pcm:RawPointer<cpp.Void>, info:RawPointer<DrMP3FrameInfo>):Int;
	@:native("drmp3dec_f32_to_s16")
	static function decoderFloatToShort():Void;



	static inline function init(data:DrMP3Ptr, onRead:DrMP3ReadProc, onSeek:DrMP3SeekProc, userdata:Any, allocationCallbacks:RawPointer<DrMP3AllocationCallbacks>):Bool
		return untyped __cpp__("drmp3_init({0}, {1}, {2}, {3}, {4})", data, onRead, onSeek, userdata, allocationCallbacks) == 1;

	static inline function initMemory(data:DrMP3Ptr, memData:Any, dataSize:cpp.UInt64, allocationCallbacks:RawPointer<DrMP3AllocationCallbacks>):Bool
		return untyped __cpp__("drmp3_init_memory({0}, {1}, {2}, {3})", data, memData, dataSize, allocationCallbacks) == 1;

	static inline function initFile(data:DrMP3Ptr, filePath:ConstCharStar, allocationCallbacks:RawPointer<DrMP3AllocationCallbacks>):Bool
		return untyped __cpp__("drmp3_init_file({0}, {1}, {2})", data, filePath, allocationCallbacks) == 1;

	static inline function initFileW(data:DrMP3Ptr, filePath:RawPointer<cpp.UInt16>, allocationCallbacks:RawPointer<DrMP3AllocationCallbacks>):Bool
		return untyped __cpp__("drmp3_init_file_w({0}, {1}, {2})", data, filePath, allocationCallbacks) == 1;
	
	@:native("drmp3_uninit")
	static function uninit(data:DrMP3Ptr):Void;


	
	@:native("drmp3_read_pcm_frames_f32")
	static function readPCMFramesFloat32(data:DrMP3Ptr, framesToRead:cpp.UInt64, bufferOut:RawPointer<Float>):cpp.UInt64;

	@:native("drmp3_read_pcm_frames_s16")
	static function readPCMFramesShort16(data:DrMP3Ptr, framesToRead:cpp.UInt64, bufferOut:RawPointer<cpp.Int16>):cpp.UInt64;

	static inline function seekToPCMFrame(data:DrMP3Ptr, frameIndex:cpp.UInt64):Bool
		return untyped __cpp__("drmp3_seek_to_pcm_frame({0}, {1})", data, frameIndex) == 1;



	@:native("drmp3_get_pcm_frame_count")
	static function getPCMFrameCount(data:DrMP3Ptr):cpp.UInt64;

	@:native("drmp3_get_mp3_frame_count")
	static function getMP3FrameCount(data:DrMP3Ptr):cpp.UInt64;

	static inline function getMP3AndPCMFrameCount(data:DrMP3Ptr, mp3Frames:RawPointer<cpp.UInt64>, pcmFrames:RawPointer<cpp.UInt64>):Bool
		return untyped __cpp__("drmp3_get_mp3_and_pcm_frame_count({0}, {1}, {2})", data, mp3Frames, pcmFrames) == 1;

	static inline function calculateSeekPoints(data:DrMP3Ptr, seekPointCount:RawPointer<cpp.UInt32>, seekPoints:RawPointer<DrMP3SeekPoint>):Bool
		return untyped __cpp__("drmp3_calculate_seek_points({0}, {1}, {2})", data, seekPointCount, seekPoints) == 1;

	static inline function bindSeekTable(data:DrMP3Ptr, seekPointCount:cpp.UInt32, seekPoints:RawPointer<DrMP3SeekPoint>):Bool
		return untyped __cpp__("drmp3_bind_seek_table({0}, {1}, {2})", data, seekPointCount, seekPoints) == 1;



	@:native('drmp3_open_and_read_pcm_frames_f32')
	static function openAndReadPCMFramesFloat32(onRead:DrMP3ReadProc, onSeek:DrMP3SeekProc, userdata:Any, config:RawPointer<DrMP3Config>, totalFrameCount:RawPointer<DrMP3UInt64>, allocationCallbacks:RawPointer<DrMP3AllocationCallbacks>):RawPointer<Float>;

	@:native('drmp3_open_and_read_pcm_frames_s16')
	static function openAndReadPCMFramesShort16(onRead:DrMP3ReadProc, onSeek:DrMP3SeekProc, userdata:Any, config:RawPointer<DrMP3Config>, totalFrameCount:RawPointer<DrMP3UInt64>, allocationCallbacks:RawPointer<DrMP3AllocationCallbacks>):RawPointer<cpp.Int16>;

	@:native('drmp3_open_memory_and_read_pcm_frames_f32')
	static function openMemoryAndReadPCMFramesFloat32(memData:Any, dataSize:cpp.UInt64, config:RawPointer<DrMP3Config>, totalFrameCount:RawPointer<DrMP3UInt64>, allocationCallbacks:RawPointer<DrMP3AllocationCallbacks>):RawPointer<Float>;

	@:native('drmp3_open_memory_and_read_pcm_frames_s16')
	static function openMemoryAndReadPCMFramesShort16(memData:Any, dataSize:cpp.UInt64, config:RawPointer<DrMP3Config>, totalFrameCount:RawPointer<DrMP3UInt64>, allocationCallbacks:RawPointer<DrMP3AllocationCallbacks>):RawPointer<cpp.Int16>;

	@:native('drmp3_open_file_and_read_pcm_frames_f32')
	static function openFileAndReadPCMFramesFloat32(fileName:cpp.ConstCharStar, config:RawPointer<DrMP3Config>, totalFrameCount:RawPointer<DrMP3UInt64>, allocationCallbacks:RawPointer<DrMP3AllocationCallbacks>):RawPointer<Float>;

	@:native('drmp3_open_file_and_read_pcm_frames_s16')
	static function openFileAndReadPCMFramesShort16(fileName:cpp.ConstCharStar, config:RawPointer<DrMP3Config>, totalFrameCount:RawPointer<DrMP3UInt64>, allocationCallbacks:RawPointer<DrMP3AllocationCallbacks>):RawPointer<cpp.Int16>;
	

	
	@:native("drmp3_malloc")
	static function malloc(size:cpp.UInt64, allocationCallbacks:RawPointer<DrMP3AllocationCallbacks>):Void;

	static inline function free(data:Any, allocationCallbacks:RawPointer<DrMP3AllocationCallbacks>):Void {
		untyped __cpp__('drmp3_free({0}, {1})', data, allocationCallbacks);
	}
}

/**
 * I love making new abstract types that aren't copied from cpp.SizeT! :3
 * @author what-is-a-git
 */
@:native("long long unsigned int")
@:scalar @:coreType @:notNull
extern abstract DrMP3UInt64 from(Int) to(Int) {}