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
extern class _DrMP3Data {
    var decoder:DrMP3Decoder;
    var channels:cpp.UInt32;
    var sampleRate:cpp.UInt32;
    var onRead:DrMP3ReadProc;
    var onSeek:DrMP3SeekProc;
    var userdata:RawPointer<cpp.Void>;
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
typedef DrMP3Data = RawPointer<_DrMP3Data>;

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

    @:native("DRMP3_SUCCESS")
    static final SUCCESS:Int;
    @:native("DRMP3_ERROR")
    static final ERROR:Int;
    @:native("DRMP3_INVALID_ARGS")
    static final INVALID_ARGS:Int;
    @:native("DRMP3_INVALID_OPERATION")
    static final INVALID_OPERATION:Int;
    @:native("DRMP3_OUT_OF_MEMORY")
    static final OUT_OF_MEMORY:Int;
    @:native("DRMP3_OUT_OF_RANGE")
    static final OUT_OF_RANGE:Int;
    @:native("DRMP3_ACCESS_DENIED")
    static final ACCESS_DENIED:Int;
    @:native("DRMP3_DOES_NOT_EXIST")
    static final DOES_NOT_EXIST:Int;
    @:native("DRMP3_ALREADY_EXISTS")
    static final ALREADY_EXISTS:Int;
    @:native("DRMP3_TOO_MANY_OPEN_FILES")
    static final TOO_MANY_OPEN_FILES:Int;
    @:native("DRMP3_INVALID_FILE")
    static final INVALID_FILE:Int;
    @:native("DRMP3_TOO_BIG")
    static final TOO_BIG:Int;
    @:native("DRMP3_PATH_TOO_LONG")
    static final PATH_TOO_LONG:Int;
    @:native("DRMP3_NAME_TOO_LONG")
    static final NAME_TOO_LONG:Int;
    @:native("DRMP3_NOT_DIRECTORY")
    static final NOT_DIRECTORY:Int;
    @:native("DRMP3_IS_DIRECTORY")
    static final IS_DIRECTORY:Int;
    @:native("DRMP3_DIRECTORY_NOT_EMPTY")
    static final DIRECTORY_NOT_EMPTY:Int;
    @:native("DRMP3_END_OF_FILE")
    static final END_OF_FILE:Int;
    @:native("DRMP3_NO_SPACE")
    static final NO_SPACE:Int;
    @:native("DRMP3_BUSY")
    static final BUSY:Int;
    @:native("DRMP3_IO_ERROR")
    static final IO_ERROR:Int;
    @:native("DRMP3_INTERRUPT")
    static final INTERRUPT:Int;
    @:native("DRMP3_UNAVAILABLE")
    static final UNAVAILABLE:Int;
    @:native("DRMP3_ALREADY_IN_USE")
    static final ALREADY_IN_USE:Int;
    @:native("DRMP3_BAD_ADDRESS")
    static final BAD_ADDRESS:Int;
    @:native("DRMP3_BAD_SEEK")
    static final BAD_SEEK:Int;
    @:native("DRMP3_BAD_PIPE")
    static final BAD_PIPE:Int;
    @:native("DRMP3_DEADLOCK")
    static final DEADLOCK:Int;
    @:native("DRMP3_TOO_MANY_LINKS")
    static final TOO_MANY_LINKS:Int;
    @:native("DRMP3_NOT_IMPLEMENTED")
    static final NOT_IMPLEMENTED:Int;
    @:native("DRMP3_NO_MESSAGE")
    static final NO_MESSAGE:Int;
    @:native("DRMP3_BAD_MESSAGE")
    static final BAD_MESSAGE:Int;
    @:native("DRMP3_NO_DATA_AVAILABLE")
    static final NO_DATA_AVAILABLE:Int;
    @:native("DRMP3_INVALID_DATA")
    static final INVALID_DATA:Int;
    @:native("DRMP3_TIMEOUT")
    static final TIMEOUT:Int;
    @:native("DRMP3_NO_NETWORK")
    static final NO_NETWORK:Int;
    @:native("DRMP3_NOT_UNIQUE")
    static final NOT_UNIQUE:Int;
    @:native("DRMP3_NOT_SOCKET")
    static final NOT_SOCKET:Int;
    @:native("DRMP3_NO_ADDRESS")
    static final NO_ADDRESS:Int;
    @:native("DRMP3_BAD_PROTOCOL")
    static final BAD_PROTOCOL:Int;
    @:native("DRMP3_PROTOCOL_UNAVAILABLE")
    static final PROTOCOL_UNAVAILABLE:Int;
    @:native("DRMP3_PROTOCOL_NOT_SUPPORTED")
    static final PROTOCOL_NOT_SUPPORTED:Int;
    @:native("DRMP3_PROTOCOL_FAMILY_NOT_SUPPORTED")
    static final PROTOCOL_FAMILY_NOT_SUPPORTED:Int;
    @:native("DRMP3_ADDRESS_FAMILY_NOT_SUPPORTED")
    static final ADDRESS_FAMILY_NOT_SUPPORTED:Int;
    @:native("DRMP3_SOCKET_NOT_SUPPORTED")
    static final SOCKET_NOT_SUPPORTED:Int;
    @:native("DRMP3_CONNECTION_RESET")
    static final CONNECTION_RESET:Int;
    @:native("DRMP3_ALREADY_CONNECTED")
    static final ALREADY_CONNECTED:Int;
    @:native("DRMP3_NOT_CONNECTED")
    static final NOT_CONNECTED:Int;
    @:native("DRMP3_CONNECTION_REFUSED")
    static final CONNECTION_REFUSED:Int;
    @:native("DRMP3_NO_HOST")
    static final NO_HOST:Int;
    @:native("DRMP3_IN_PROGRESS")
    static final IN_PROGRESS:Int;
    @:native("DRMP3_CANCELLED")
    static final CANCELLED:Int;
    @:native("DRMP3_MEMORY_ALREADY_MAPPED")
    static final MEMORY_ALREADY_MAPPED:Int;
    @:native("DRMP3_AT_END")
    static final AT_END:Int;

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

    static inline function init(data:DrMP3Data, onRead:DrMP3ReadProc, onSeek:DrMP3SeekProc, userdata:Any, allocationCallbacks:RawPointer<DrMP3AllocationCallbacks>):Bool
        return untyped __cpp__("drmp3_init({0}, {1}, {2}, {3}, {4})", data, onRead, onSeek, userdata, allocationCallbacks) == 1;

    static inline function initMemory(data:DrMP3Data, memData:Any, dataSize:cpp.UInt64, allocationCallbacks:RawPointer<DrMP3AllocationCallbacks>):Bool
        return untyped __cpp__("drmp3_init_memory({0}, {1}, {2}, {3})", data, memData, dataSize, allocationCallbacks) == 1;

    static inline function initFile(data:DrMP3Data, filePath:ConstCharStar, allocationCallbacks:RawPointer<DrMP3AllocationCallbacks>):Bool
        return untyped __cpp__("drmp3_init_file({0}, {1}, {2})", data, filePath, allocationCallbacks) == 1;

    static inline function initFileW(data:DrMP3Data, filePath:RawPointer<cpp.UInt16>, allocationCallbacks:RawPointer<DrMP3AllocationCallbacks>):Bool
        return untyped __cpp__("drmp3_init_file_w({0}, {1}, {2})", data, filePath, allocationCallbacks) == 1;
    
    @:native("drmp3_uninit")
    static function uninit(data:DrMP3Data):Void;
    
    @:native("drmp3_read_pcm_frames_f32")
    static function readPCMFramesFloat32(data:DrMP3Data, framesToRead:cpp.UInt64, bufferOut:RawPointer<Float>):cpp.UInt64;

    @:native("drmp3_read_pcm_frames_s16")
    static function readPCMFramesShort16(data:DrMP3Data, framesToRead:cpp.UInt64, bufferOut:RawPointer<cpp.Int16>):cpp.UInt64;

    static inline function seekToPCMFrame(data:DrMP3Data, frameIndex:cpp.UInt64):Bool
        return untyped __cpp__("drmp3_seek_to_pcm_frame({0}, {1})", data, frameIndex) == 1;

    @:native("drmp3_get_pcm_frame_count")
    static function getPCMFrameCount(data:DrMP3Data):cpp.UInt64;

    @:native("drmp3_get_mp3_frame_count")
    static function getMP3FrameCount(data:DrMP3Data):cpp.UInt64;

    static inline function getMP3AndPCMFrameCount(data:DrMP3Data, mp3Frames:RawPointer<cpp.UInt64>, pcmFrames:RawPointer<cpp.UInt64>):Bool
        return untyped __cpp__("drmp3_get_mp3_and_pcm_frame_count({0}, {1}, {2})", data, mp3Frames, pcmFrames) == 1;

    static inline function calculateSeekPoints(data:DrMP3Data, seekPointCount:RawPointer<cpp.UInt32>, seekPoints:RawPointer<DrMP3SeekPoint>):Bool
        return untyped __cpp__("drmp3_calculate_seek_points({0}, {1}, {2})", data, seekPointCount, seekPoints) == 1;

    static inline function bindSeekTable(data:DrMP3Data, seekPointCount:cpp.UInt32, seekPoints:RawPointer<DrMP3SeekPoint>):Bool
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