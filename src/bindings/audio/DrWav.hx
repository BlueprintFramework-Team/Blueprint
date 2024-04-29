package bindings.audio;

import cpp.CastCharStar;
import cpp.ConstCharStar;
import cpp.RawPointer;
import cpp.Callable;

// super not finished, but they don't have to be finished because abstraction <3
// - what-is-a-git

@:include('audio/dr_wav.h')
extern enum abstract DrWavResult(cpp.Int32) from cpp.Int32 to cpp.Int32 {
	@:native("DRWAV_SUCCESS")
	var SUCCESS;
	@:native("DRWAV_ERROR")
	var ERROR;
	@:native("DRWAV_INVALID_ARGS")
	var INVALID_ARGS;
	@:native("DRWAV_INVALID_OPERATION")
	var INVALID_OPERATION;
	@:native("DRWAV_OUT_OF_MEMORY")
	var OUT_OF_MEMORY;
	@:native("DRWAV_OUT_OF_RANGE")
	var OUT_OF_RANGE;
	@:native("DRWAV_ACCESS_DENIED")
	var ACCESS_DENIED;
	@:native("DRWAV_DOES_NOT_EXIST")
	var DOES_NOT_EXIST;
	@:native("DRWAV_ALREADY_EXISTS")
	var ALREADY_EXISTS;
	@:native("DRWAV_TOO_MANY_OPEN_FILES")
	var TOO_MANY_OPEN_FILES;
	@:native("DRWAV_INVALID_FILE")
	var INVALID_FILE;
	@:native("DRWAV_TOO_BIG")
	var TOO_BIG;
	@:native("DRWAV_PATH_TOO_LONG")
	var PATH_TOO_LONG;
	@:native("DRWAV_NAME_TOO_LONG")
	var NAME_TOO_LONG;
	@:native("DRWAV_NOT_DIRECTORY")
	var NOT_DIRECTORY;
	@:native("DRWAV_IS_DIRECTORY")
	var IS_DIRECTORY;
	@:native("DRWAV_DIRECTORY_NOT_EMPTY")
	var DIRECTORY_NOT_EMPTY;
	@:native("DRWAV_END_OF_FILE")
	var END_OF_FILE;
	@:native("DRWAV_NO_SPACE")
	var NO_SPACE;
	@:native("DRWAV_BUSY")
	var BUSY;
	@:native("DRWAV_IO_ERROR")
	var IO_ERROR;
	@:native("DRWAV_INTERRUPT")
	var INTERRUPT;
	@:native("DRWAV_UNAVAILABLE")
	var UNAVAILABLE;
	@:native("DRWAV_ALREADY_IN_USE")
	var ALREADY_IN_USE;
	@:native("DRWAV_BAD_ADDRESS")
	var BAD_ADDRESS;
	@:native("DRWAV_BAD_SEEK")
	var BAD_SEEK;
	@:native("DRWAV_BAD_PIPE")
	var BAD_PIPE;
	@:native("DRWAV_DEADLOCK")
	var DEADLOCK;
	@:native("DRWAV_TOO_MANY_LINKS")
	var TOO_MANY_LINKS;
	@:native("DRWAV_NOT_IMPLEMENTED")
	var NOT_IMPLEMENTED;
	@:native("DRWAV_NO_MESSAGE")
	var NO_MESSAGE;
	@:native("DRWAV_BAD_MESSAGE")
	var BAD_MESSAGE;
	@:native("DRWAV_NO_DATA_AVAILABLE")
	var NO_DATA_AVAILABLE;
	@:native("DRWAV_INVALID_DATA")
	var INVALID_DATA;
	@:native("DRWAV_TIMEOUT")
	var TIMEOUT;
	@:native("DRWAV_NO_NETWORK")
	var NO_NETWORK;
	@:native("DRWAV_NOT_UNIQUE")
	var NOT_UNIQUE;
	@:native("DRWAV_NOT_SOCKET")
	var NOT_SOCKET;
	@:native("DRWAV_NO_ADDRESS")
	var NO_ADDRESS;
	@:native("DRWAV_BAD_PROTOCOL")
	var BAD_PROTOCOL;
	@:native("DRWAV_PROTOCOL_UNAVAILABLE")
	var PROTOCOL_UNAVAILABLE;
	@:native("DRWAV_PROTOCOL_NOT_SUPPORTED")
	var PROTOCOL_NOT_SUPPORTED;
	@:native("DRWAV_PROTOCOL_FAMILY_NOT_SUPPORTED")
	var PROTOCOL_FAMILY_NOT_SUPPORTED;
	@:native("DRWAV_ADDRESS_FAMILY_NOT_SUPPORTED")
	var ADDRESS_FAMILY_NOT_SUPPORTED;
	@:native("DRWAV_SOCKET_NOT_SUPPORTED")
	var SOCKET_NOT_SUPPORTED;
	@:native("DRWAV_CONNECTION_RESET")
	var CONNECTION_RESET;
	@:native("DRWAV_ALREADY_CONNECTED")
	var ALREADY_CONNECTED;
	@:native("DRWAV_NOT_CONNECTED")
	var NOT_CONNECTED;
	@:native("DRWAV_CONNECTION_REFUSED")
	var CONNECTION_REFUSED;
	@:native("DRWAV_NO_HOST")
	var NO_HOST;
	@:native("DRWAV_IN_PROGRESS")
	var IN_PROGRESS;
	@:native("DRWAV_CANCELLED")
	var CANCELLED;
	@:native("DRWAV_MEMORY_ALREADY_MAPPED")
	var MEMORY_ALREADY_MAPPED;
	@:native("DRWAV_AT_END")
	var AT_END;
}

@:include('audio/dr_wav.h')
extern enum abstract DrWavFormat(cpp.UInt16) from cpp.UInt16 to cpp.UInt16 {
	@:native("DR_WAVE_FORMAT_PCM")
	var PCM;
	@:native("DR_WAVE_FORMAT_ADPCM")
	var ADPCM;
	@:native("DR_WAVE_FORMAT_IEEE_FLOAT")
	var IEEE_FLOAT;
	@:native("DR_WAVE_FORMAT_ALAW")
	var ALAW;
	@:native("DR_WAVE_FORMAT_MULAW")
	var MULAW;
	@:native("DR_WAVE_FORMAT_DVI_ADPCM")
	var DVI_ADPCM;
	@:native("DR_WAVE_FORMAT_EXTENSIBLE")
	var EXTENSIBLE;
}

@:include('audio/dr_wav.h')
@:native('drwav_allocation_callbacks')
@:structAccess
extern class DrWavAllocationCallbacks {
	@:native("pUserData")
	var userData:RawPointer<cpp.Void>;

	@:native("onMalloc")
	var onMalloc:RawPointer<Callable<(size:cpp.UInt64, userdata:RawPointer<cpp.Void>) -> RawPointer<cpp.Void>>>;
	@:native("onRealloc")
	var onRealloc:RawPointer<Callable<(pointer:RawPointer<cpp.Void>, size:cpp.UInt64, userdata:RawPointer<cpp.Void>) -> RawPointer<cpp.Void>>>;
	@:native("onFree")
	var onFree:RawPointer<Callable<(pointer:RawPointer<cpp.Void>, userdata:RawPointer<cpp.Void>) -> RawPointer<cpp.Void>>>;
}

typedef DrWavSeekOrigin = DrMP3.DrMP3SeekOrigin;

enum abstract DrWavContainer(cpp.UInt32) {
	var RIFF;
	var RIFX;
	var W64;
	var RF64;
	var AIFF;
}

@:structAccess
extern class DrWavChunkHeaderID {
	var fourcc:RawPointer<cpp.UInt8>;
	var guid:RawPointer<cpp.UInt8>;
}
@:include('audio/dr_wav.h')
@:native('drwav_chunk_header')
@:structAccess
extern class DrWavChunkHeader {
	var id:DrWavChunkHeaderID;
	var sizeInBytes:cpp.UInt64;
	var paddingSize:cpp.UInt32;
}

@:include('audio/dr_wav.h')
@:native('drwav_fmt')
@:structAccess
extern class DrWavFmt {
	var formatTag:cpp.UInt16;
	var channels:cpp.UInt16;
	var sampleRate:cpp.UInt32;
	var avgBytesPerSec:cpp.UInt32;
	var blockAlign:cpp.UInt16;
	var bitsPerSample:cpp.UInt16;
	var extendedSize:cpp.UInt16;
	var validBitsPerSample:cpp.UInt16;
	var channelMask:cpp.UInt32;
	var subFormat:RawPointer<cpp.UInt8>;
}

typedef DrWavReadProc = DrMP3.DrMP3ReadProc;
typedef DrWavWriteProc = Callable<(userdata:RawPointer<cpp.Void>, data:RawPointer<cpp.Void>, bytesToWrite:cpp.UInt64) -> cpp.UInt64>;
typedef DrWavSeekProc = DrMP3.DrMP3SeekProc;
typedef DrWavChunkProc = Callable<(chunkUserdata:RawPointer<cpp.Void>, onRead:DrWavReadProc, onSeek:DrWavSeekProc, readSeekUserdata:RawPointer<cpp.Void>, chunkHeader:DrWavChunkHeader, container:DrWavContainer, fmt:DrWavFmt) -> cpp.UInt64>;

@:include('audio/dr_wav.h')
@:native('drwav__memory_stream')
@:structAccess
extern class DrWavMemoryStream {
	var data:RawPointer<cpp.UInt8>;
	var dataSize:cpp.UInt64;
	var currentReadPos:cpp.UInt64;
}

@:include('audio/dr_wav.h')
@:native('drwav__memory_stream_write')
@:structAccess
extern class DrWavMemoryStreamWrite {
	@:native("ppData")
	var data:RawPointer<RawPointer<cpp.Void>>;
	var pDataSize:RawPointer<cpp.UInt64>;
	var dataSize:cpp.UInt64;
	var dataCapacity:cpp.UInt64;
	var currentWritePos:cpp.UInt64;
}

@:include('audio/dr_wav.h')
@:native('drwav_data_format')
@:structAccess
extern class DrWavDataFormat {
	var container:DrWavContainer;
	var format:DrWavFormat;
	var channels:cpp.UInt32;
	var sampleRate:cpp.UInt32;
	var bitsPerSample:cpp.UInt32;
}

@:include("audio/dr_wav.h")
@:native("drwav_metadata_type")
extern enum abstract DrWavMetadataType(cpp.Int32) {
	@:native("drwav_metadata_type_none")
	var NONE;
	
	@:native("drwav_metadata_type_unknown")
	var UNKNOWN;

	@:native("drwav_metadata_type_smpl")
	var SMPL;
	@:native("drwav_metadata_type_inst")
	var INST;
	@:native("drwav_metadata_type_cue")
	var CUE;
	@:native("drwav_metadata_type_acid")
	var ACID;
	@:native("drwav_metadata_type_bext")
	var BEXT;

	@:native("drwav_metadata_type_list_label")
	var LIST_LABEL;
	@:native("drwav_metadata_type_list_note")
	var LIST_NOTE;
	@:native("drwav_metadata_type_list_labelled_cue_region")
	var LIST_LABELLED_CUE_REGION;

	@:native("drwav_metadata_type_list_info_software")
	var LIST_INFO_SOFTWARE;
	@:native("drwav_metadata_type_list_info_copyright")
	var LIST_INFO_COPYRIGHT;
	@:native("drwav_metadata_type_list_info_title")
	var LIST_INFO_TITLE;
	@:native("drwav_metadata_type_list_info_artist")
	var LIST_INFO_ARTIST;
	@:native("drwav_metadata_type_list_info_comment")
	var LIST_INFO_COMMENT;
	@:native("drwav_metadata_type_list_info_date")
	var LIST_INFO_DATE;
	@:native("drwav_metadata_type_list_info_genre")
	var LIST_INFO_GENRE;
	@:native("drwav_metadata_type_list_info_album")
	var LIST_INFO_ALBUM;
	@:native("drwav_metadata_type_list_info_tracknumber")
	var LIST_INFO_TRACKNUM;

	@:native("drwav_metadata_type_list_all_info_strings")
	var LIST_ALL_INFO_STRINGS;
	@:native("drwav_metadata_type_list_all_adt")
	var LIST_ALL_ADT;

	@:native("drwav_metadata_type_all")
	var ALL;
	@:native("drwav_metadata_type_all_including_unknown")
	var ALL_INCLUDING_UNKNOWN;
}

enum abstract DrWavSmplLoopType(cpp.UInt32) {
	var FORWARD;
	var PINGPONG;
	var BACKWARD;
}

@:include('audio/dr_wav.h')
@:native('drwav_smpl_loop')
@:structAccess
extern class DrWavSmplLoop {
	var cuePointId:cpp.UInt32;
	var type:DrWavSmplLoopType;
	var firstSampleByteOffset:cpp.UInt32;
	var lastSampleByteOffset:cpp.UInt32;
	var sampleFraction:cpp.UInt32;
	var playCount:cpp.UInt32;
}

@:include('audio/dr_wav.h')
@:native('drwav_smpl')
@:structAccess
extern class DrWavSmpl {
	var manufacturerId:cpp.UInt32;
	var productId:cpp.UInt32;

	var samplePeriodNanoseconds:cpp.UInt32;
	var midiUnityNote:cpp.UInt32;
	var midiPitchFraction:cpp.UInt32;
	var smpteFormat:cpp.UInt32;
	var smpteOffset:cpp.UInt32;

	var sampleLoopCount:cpp.UInt32;
	var samplerSpecificDataSizeInBytes:cpp.UInt32;

	var pLoops:RawPointer<DrWavSmplLoop>;
	var pSamplerSpecificData:RawPointer<cpp.UInt8>;
}

@:include('audio/dr_wav.h')
@:native('drwav_inst')
@:structAccess
extern class DrWavInst {
	var midiUnityNote:cpp.Int8;
	var fineTuneCents:cpp.Int8;
	var gainDecibels:cpp.Int8;
	var lowNote:cpp.Int8;
	var highNote:cpp.Int8;
	var lowVelocity:cpp.Int8;
	var highVelocity:cpp.Int8;
}

@:include('audio/dr_wav.h')
@:native('drwav_inst')
@:structAccess
extern class DrWavCuePoint {
	var id:cpp.UInt32;
	var playOrderPosition:cpp.UInt32;
	var dataChunkId:RawPointer<cpp.UInt8>;
	var chunkStart:cpp.UInt32;
	var blockStart:cpp.UInt32;
	var sampleByteOffset:cpp.UInt32;
}

@:include('audio/dr_wav.h')
@:native('drwav_cue')
@:structAccess
extern class DrWavCue {
	var cuePointCount:cpp.UInt32;
	var pCuePoints:RawPointer<DrWavCuePoint>;
}

@:include('audio/dr_wav.h')
@:native('drwav_acid_flag')
extern enum abstract DrWavAcidFlag(cpp.UInt32) {
	@:native("drwav_acid_flag_one_shot")
	var ONE_SHOT;
	@:native("drwav_acid_flag_root_note_set")
	var ROOT_NOTE_SET;
	@:native("drwav_acid_flag_stretch")
	var STRETCH;
	@:native("drwav_acid_flag_disk_based")
	var DISK_BASED;
	@:native("drwav_acid_flag_acidizer")
	var ACIDIZER;
}

@:include('audio/dr_wav.h')
@:native('drwav_acid')
@:structAccess
extern class DrWavAcid {
	var flags:cpp.UInt32;
	var midiUnityNote:cpp.UInt16;

	var reserved1:cpp.UInt16;
	var reserved2:Float;

	var numBeats:cpp.UInt32;

	var meterDenominator:cpp.UInt16;
	var meterNumerator:cpp.UInt16;

	var tempo:Float;
}

@:include('audio/dr_wav.h')
@:native('drwav_list_label_or_note')
@:structAccess
extern class DrWavListLabelOrNote {
	var cuePointId:cpp.UInt32;
	var stringLength:cpp.UInt32;
	var pString:CastCharStar;
}

@:include('audio/dr_wav.h')
@:native('drwav_bext')
@:structAccess
extern class DrWavBext {
	var pDescription:CastCharStar;
	var pOriginatorName:CastCharStar;
	var pOriginatorReference:CastCharStar;
	var pOriginationData:CastCharStar;
	var pOriginationTime:CastCharStar;
	var timeReference:cpp.UInt64;
	var version:cpp.UInt16;

	var pCodingHistory:CastCharStar;
	var codingHistorySIze:cpp.UInt32;

	var pUMID:RawPointer<cpp.UInt8>;

	var loudnessValue:cpp.UInt16;
	var loudnessRange:cpp.UInt16;
	var maxTruePeakLevel:cpp.UInt16;
	var maxMomentaryLoudness:cpp.UInt16;
	var maxShortTermLoudness:cpp.UInt16;
}

@:include('audio/dr_wav.h')
@:native('drwav_list_info_text')
@:structAccess
extern class DrWavListInfoText {
	var pStringLength:cpp.UInt32;
	var pString:CastCharStar;
}

@:include('audio/dr_wav.h')
@:native('drwav_list_labelled_cue_region')
@:structAccess
extern class DrWavListLabelledCueRegion {
	var cuePointId:cpp.UInt32;
	var sampleLength:cpp.UInt32;
	
	var purposeId:RawPointer<cpp.UInt8>;

	var country:cpp.UInt16;
	var language:cpp.UInt16;
	var dialect:cpp.UInt16;
	var codePage:cpp.UInt16;

	var stringLength:cpp.UInt32;
	var pString:CastCharStar;
}

@:include('audio/dr_wav.h')
@:native('drwav_metadata_location')
extern enum abstract DrWavMetadataLocation(cpp.UInt32) {
	@:native("drwav_metadata_location_invalid")
	var INVALID;
	@:native("drwav_metadata_location_top_level")
	var TOP_LEVEL;
	@:native("drwav_metadata_location_inside_info_list")
	var INSIDE_INFO_LIST;
	@:native("drwav_metadata_location_inside_adtl_list")
	var INSIDE_ADTL_LIST;
}

@:include('audio/dr_wav.h')
@:native('drwav_unknown_metadata')
@:structAccess
extern class DrWavUnknownMetadata {
	var id:RawPointer<cpp.UInt8>;
	var chunkLocation:DrWavMetadataLocation;
	var dataSizeInBytes:cpp.UInt32;
	var pData:RawPointer<cpp.UInt8>;
}

@:structAccess 
extern class DrWavMetadata_Data { // metadata data
	var cue:DrWavCue;
	var smpl:DrWavSmpl;
	var acid:DrWavAcid;
	var inst:DrWavInst;
	var bext:DrWavBext;
	var labelOrNote:DrWavListLabelOrNote;
	var labelledCueRegion:DrWavListLabelledCueRegion;
	var infoText:DrWavListInfoText;
	var unknown:DrWavUnknownMetadata;
}
@:include("audio/dr_wav.h")
@:native("drwav_metadata")
@:structAccess
extern class DrWavMetadata {
	var type:DrWavMetadataType;
	var data:DrWavMetadata_Data;
}

@:structAccess
extern class DrWavMsadpcm {
	var bytesRemainingInBlock:cpp.UInt32;
	var predictor:RawPointer<cpp.UInt16>;
	var delta:cpp.Int32;
	var cachedFrames:RawPointer<cpp.Int32>;
	var cachedFrameCount:cpp.UInt32;
	var prevFrames:RawPointer<RawPointer<cpp.Int32>>;
}
@:structAccess
extern class DrWavIma {
	var bytesRemainingInBlock:cpp.UInt32;
	var predictor:RawPointer<cpp.Int32>;
	var stepIndex:RawPointer<cpp.Int32>;
	var cachedFrames:RawPointer<cpp.Int32>;
	var cachedFrameCount:cpp.UInt32;
}
@:structAccess
extern class DrWavAiff {
	var isLE:cpp.UInt8;
	var isUnsigned:cpp.UInt8;
}
@:include("audio/dr_wav.h")
@:native("drwav")
@:structAccess
extern class DrWavData {
	var onRead:DrWavReadProc;
	var onWrite:DrWavWriteProc;
	var onSeek:DrWavSeekProc;
	var pUserData:RawPointer<cpp.Void>;
	var allocationCallbacks:DrWavAllocationCallbacks;

	var container:DrWavContainer;

	var fmt:DrWavFmt;

	var sampleRate:cpp.UInt32;
	var channels:cpp.UInt16;
	var bitsPerSample:cpp.UInt16;
	var translatedFormatTag:cpp.UInt16;
	var totalPCMFrameCount:cpp.UInt64;

	var dataChunkDataSize:cpp.UInt64;
	var dataChunkDataPos:cpp.UInt64;
	var bytesRemaining:cpp.UInt64;
	var readCursorInPCMFrames:cpp.UInt64;

	var dataChunkDataSizeTargetWrite:cpp.UInt64;
	var isSequentialWrite:cpp.UInt32;

	var pMetadata:RawPointer<DrWavMetadata>;
	var metadataCount:cpp.UInt32;
	
	var memoryStream:DrWavMemoryStream;
	var memoryStreamWrite:DrWavMemoryStreamWrite;

	var msadpcm:DrWavMsadpcm;
	var ima:DrWavIma;
	var aiff:DrWavAiff;
}
typedef DrWavPtr = RawPointer<DrWavData>;

@:include('audio/dr_wav.h')
extern class DrWav {
	@:native("DRWAV_VERSION_MAJOR")
	static final VERSION_MAJOR:cpp.UInt32;
	@:native("DRWAV_VERSION_MINOR")
	static final VERSION_MINOR:cpp.UInt32;
	@:native("DRWAV_VERSION_REVISION")
	static final VERSION_REVISION:cpp.UInt32;
	@:native("DRWAV_VERSION_STRING")
	static final VERSION_STRING:ConstCharStar;

	@:native("DRWAV_SEQUENTIAL")
	static final SEQUENTIAL:cpp.UInt32;
	@:native("DRWAV_WITH_METADATA")
	static final WITH_METADATA:cpp.UInt32;



	@:native("drwav_fmt_get_format")
	static function fmtGetFormat(fmt:DrWavFmt):DrWavFormat;



	static inline function init(data:DrWavPtr, onRead:DrWavReadProc, onSeek:DrWavSeekProc, userdata:Any, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):Bool
		return untyped __cpp__("drwav_init({0}, {1}, {2}, {3}, {4})", data, onRead, onSeek, userdata, allocationCallbacks) == 1;

	static inline function initEX(data:DrWavPtr, onRead:DrWavReadProc, onSeek:DrWavSeekProc, onChunk:DrWavChunkProc, readSeekUserdata:Any, chunkUserdata:Any, flags:cpp.UInt32, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):Bool
		return untyped __cpp__("drwav_init_ex({0}, {1}, {2}, {3}, {4}, {5}, {6}, {7})", data, onRead, onSeek, onChunk, readSeekUserdata, chunkUserdata, flags, allocationCallbacks) == 1;

	static inline function initWithMetadata(data:DrWavPtr, onRead:DrWavReadProc, onSeek:DrWavSeekProc, userdata:Any, flags:cpp.UInt32, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):Bool
		return untyped __cpp__("drwav_init_with_metadata({0}, {1}, {2}, {3}, {4}, {5})", data, onRead, onSeek, userdata, flags, allocationCallbacks) == 1;



	static inline function initWrite(data:DrWavPtr, format:DrWavDataFormat, onWrite:DrWavWriteProc, onSeek:DrWavSeekProc, userdata:Any, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):Bool
		return untyped __cpp__("drwav_init_write({0}, {1}, {2}, {3}, {4}, {5})", data, format, onWrite, onSeek, userdata, allocationCallbacks) == 1;

	static inline function initWriteSequential(data:DrWavPtr, format:DrWavDataFormat, totalSampleCount:cpp.UInt64, onWrite:DrWavWriteProc, userdata:Any, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):Bool
		return untyped __cpp__("drwav_init_write_sequential({0}, {1}, {2}, {3}, {4}, {5})", data, format, totalSampleCount, onWrite, userdata, allocationCallbacks) == 1;

	static inline function initWriteSequentialPCMFrames(data:DrWavPtr, format:DrWavDataFormat, totalPCMFrameCount:cpp.UInt64, onWrite:DrWavWriteProc, userdata:Any, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):Bool
		return untyped __cpp__("drwav_init_write_sequential_pcm_frames({0}, {1}, {2}, {3}, {4}, {5})", data, format, totalPCMFrameCount, onWrite, userdata, allocationCallbacks) == 1;

	static inline function initWriteWithMetadata(data:DrWavPtr, format:DrWavDataFormat, onWrite:DrWavWriteProc, onSeek:DrWavSeekProc, userdata:Any, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>, metadata:RawPointer<DrWavMetadata>, metadataCount:cpp.UInt32):Bool
		return untyped __cpp__("drwav_init_write_with_metadata({0}, {1}, {2}, {3}, {4}, {5}, {6}, {7})", data, format, onWrite, onSeek, userdata, allocationCallbacks, metadata, metadataCount) == 1;



	@:native("drwav_target_write_size_bytes")
	static function targetWriteSizeBytes(format:DrWavDataFormat, totalFrameCount:cpp.UInt64, metadata:RawPointer<DrWavMetadata>, metadataCount:cpp.UInt32):Void;

	@:native("drwav_take_ownership_of_metadata")
	static function takeOwnershipOfMetadata(data:DrWavPtr):RawPointer<DrWavMetadata>;

	@:native("drwav_uninit")
	static function uninit(data:DrWavPtr):DrWavResult;



	@:native("drwav_read_raw")
	static function readRaw(data:DrWavPtr, bytesToRead:cpp.UInt64, bufferOut:RawPointer<cpp.Void>):cpp.UInt64;

	@:native("drwav_read_pcm_frames")
	static function readPCMFrames(data:DrWavPtr, framesToRead:cpp.UInt64, bufferOut:RawPointer<cpp.Void>):cpp.UInt64;

	@:native("drwav_read_pcm_frames_le")
	static function readPCMFramesLe(data:DrWavPtr, framesToRead:cpp.UInt64, bufferOut:RawPointer<cpp.Void>):cpp.UInt64;

	@:native("drwav_read_pcm_frames_be")
	static function readPCMFramesBe(data:DrWavPtr, framesToRead:cpp.UInt64, bufferOut:RawPointer<cpp.Void>):cpp.UInt64;

	static inline function seekToPCMFrame(data:DrWavPtr, frameIndex:cpp.UInt64):Bool
		return untyped __cpp__("drwav_seek_to_pcm_frame({0}, {1})", data, frameIndex) == 1;

	static inline function getCursorInPCMFrames(data:DrWavPtr, cursor:RawPointer<cpp.UInt64>):Bool
		return untyped __cpp__("drwav_get_cursor_in_pcm_frames({0}, {1})", data, cursor) == 1;

	static inline function getLengthInPCMFrames(data:DrWavPtr, length:RawPointer<cpp.UInt64>):Bool
		return untyped __cpp__("drwav_get_length_in_pcm_frames({0}, {1})", data, length) == 1;



	@:native("drwav_write_raw")
	static function writeRaw(data:DrWavPtr, bytesToWrite:cpp.UInt64, data:RawPointer<cpp.Void>):cpp.UInt64;

	@:native("drwav_write_pcm_frames")
	static function writePCMFrames(data:DrWavPtr, framesToWrite:cpp.UInt64, data:RawPointer<cpp.Void>):cpp.UInt64;

	@:native("drwav_write_pcm_frames_le")
	static function writePCMFramesLe(data:DrWavPtr, framesToWrite:cpp.UInt64, data:RawPointer<cpp.Void>):cpp.UInt64;

	@:native("drwav_write_pcm_frames_be")
	static function writePCMFramesBe(data:DrWavPtr, framesToWrite:cpp.UInt64, data:RawPointer<cpp.Void>):cpp.UInt64;



	@:native("drwav_read_pcm_frames_s16")
	static function readPCMFramesShort16(data:DrWavPtr, framesToRead:cpp.UInt64, bufferOut:RawPointer<cpp.Int16>):cpp.UInt64;

	@:native("drwav_read_pcm_frames_s16le")
	static function readPCMFramesShort16Le(data:DrWavPtr, framesToRead:cpp.UInt64, bufferOut:RawPointer<cpp.Int16>):cpp.UInt64;

	@:native("drwav_read_pcm_frames_s16be")
	static function readPCMFramesShort16Be(data:DrWavPtr, framesToRead:cpp.UInt64, bufferOut:RawPointer<cpp.Int16>):cpp.UInt64;

	@:native("drwav_u8_to_s16")
	static function unsignedShortToShort16(out:RawPointer<cpp.Int16>, input:RawPointer<cpp.UInt8>, sampleCount:cpp.UInt64):Void;

	@:native("drwav_s24_to_s16")
	static function signed24ToShort16(out:RawPointer<cpp.Int16>, input:RawPointer<cpp.UInt8>, sampleCount:cpp.UInt64):Void;

	@:native("drwav_s32_to_s16")
	static function signed32ToShort16(out:RawPointer<cpp.Int16>, input:RawPointer<cpp.Int32>, sampleCount:cpp.UInt64):Void;

	@:native("drwav_f32_to_s16")
	static function float32ToShort16(out:RawPointer<cpp.Int16>, input:RawPointer<Float>, sampleCount:cpp.UInt64):Void;

	@:native("drwav_f64_to_s16")
    static function float64ToShort16(out:RawPointer<cpp.Int16>, input:RawPointer<Float>, sampleCount:cpp.UInt64):Void;

	@:native("drwav_alaw_to_s16")
    static function alawToShort16(out:RawPointer<cpp.Int16>, input:RawPointer<cpp.UInt8>, sampleCount:cpp.UInt64):Void;

	@:native("drwav_mulaw_to_s16")
    static function mulawToShort16(out:RawPointer<cpp.Int16>, input:RawPointer<cpp.UInt8>, sampleCount:cpp.UInt64):Void;



	@:native("drwav_read_pcm_frames_f32")
	static function readPCMFramesFloat32(data:DrWavPtr, framesToRead:cpp.UInt64, bufferOut:RawPointer<Float>):cpp.UInt64;

	@:native("drwav_read_pcm_frames_f32le")
	static function readPCMFramesFloat32Le(data:DrWavPtr, framesToRead:cpp.UInt64, bufferOut:RawPointer<Float>):cpp.UInt64;

	@:native("drwav_read_pcm_frames_f32be")
	static function readPCMFramesFloat32Be(data:DrWavPtr, framesToRead:cpp.UInt64, bufferOut:RawPointer<Float>):cpp.UInt64;

	@:native("drwav_u8_to_f32")
	static function unsignedShortToFloat32(out:RawPointer<Float>, input:RawPointer<cpp.UInt8>, sampleCount:cpp.UInt64):Void;

	@:native("drwav_s16_to_f32")
	static function signed24ToFloat32(out:RawPointer<Float>, input:RawPointer<cpp.Int16>, sampleCount:cpp.UInt64):Void;

	@:native("drwav_s24_to_f32")
	static function signed32ToFloat32(out:RawPointer<Float>, input:RawPointer<cpp.UInt8>, sampleCount:cpp.UInt64):Void;

	@:native("drwav_s32_to_f32")
	static function float32ToFloat32(out:RawPointer<Float>, input:RawPointer<cpp.Int32>, sampleCount:cpp.UInt64):Void;

	@:native("drwav_f64_to_f32")
    static function float64ToFloat32(out:RawPointer<Float>, input:RawPointer<Float>, sampleCount:cpp.UInt64):Void;

	@:native("drwav_alaw_to_f32")
    static function alawToFloat32(out:RawPointer<Float>, input:RawPointer<cpp.UInt8>, sampleCount:cpp.UInt64):Void;

	@:native("drwav_mulaw_to_f32")
    static function mulawToFloat32(out:RawPointer<Float>, input:RawPointer<cpp.UInt8>, sampleCount:cpp.UInt64):Void;



	@:native("drwav_read_pcm_frames_s32")
	static function readPCMFramesSigned32(data:DrWavPtr, framesToRead:cpp.UInt64, bufferOut:RawPointer<cpp.Int32>):cpp.UInt64;

	@:native("drwav_read_pcm_frames_s32le")
	static function readPCMFramesSigned32Le(data:DrWavPtr, framesToRead:cpp.UInt64, bufferOut:RawPointer<cpp.Int32>):cpp.UInt64;

	@:native("drwav_read_pcm_frames_s32be")
	static function readPCMFramesSigned32Be(data:DrWavPtr, framesToRead:cpp.UInt64, bufferOut:RawPointer<cpp.Int32>):cpp.UInt64;

	@:native("drwav_u8_to_s32")
	static function unsignedShortToSigned32(out:RawPointer<cpp.Int32>, input:RawPointer<cpp.UInt8>, sampleCount:cpp.UInt64):Void;
	
	@:native("drwav_s16_to_s32")
	static function short16ToSigned32(out:RawPointer<cpp.Int32>, input:RawPointer<cpp.Int16>, sampleCount:cpp.UInt64):Void;

	@:native("drwav_s24_to_s32")
	static function signed24ToSigned32(out:RawPointer<cpp.Int32>, input:RawPointer<cpp.UInt8>, sampleCount:cpp.UInt64):Void;

	@:native("drwav_f32_to_s32")
	static function float32ToSigned32(out:RawPointer<cpp.Int32>, input:RawPointer<Float>, sampleCount:cpp.UInt64):Void;

	@:native("drwav_f64_to_s32")
    static function float64ToSigned32(out:RawPointer<cpp.Int32>, input:RawPointer<Float>, sampleCount:cpp.UInt64):Void;

	@:native("drwav_alaw_to_s32")
    static function alawToSigned32(out:RawPointer<cpp.Int32>, input:RawPointer<cpp.UInt8>, sampleCount:cpp.UInt64):Void;

	@:native("drwav_mulaw_to_s32")
    static function mulawToSigned32(out:RawPointer<cpp.Int32>, input:RawPointer<cpp.UInt8>, sampleCount:cpp.UInt64):Void;


	
	static inline function initFile(data:DrWavPtr, filename:ConstCharStar, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):Bool
		return untyped __cpp__("drwav_init_file({0}, {1}, {2})", data, filename, allocationCallbacks) == 1;

	static inline function initFileEX(data:DrWavPtr, filename:ConstCharStar, onChunk:DrWavChunkProc, chunkUserdata:Any, flags:cpp.UInt32, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):Bool
		return untyped __cpp__("drwav_init_file_ex({0}, {1}, {2}, {3}, {4}, {5})", data, filename, onChunk, chunkUserdata, flags, allocationCallbacks) == 1;

	static inline function initFileWithMetadata(data:DrWavPtr, filename:ConstCharStar, flags:cpp.UInt32, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):Bool
		return untyped __cpp__("drwav_init_file_with_metadata({0}, {1}, {2}, {3})", data, filename, flags, allocationCallbacks) == 1;

	static inline function initFileWrite(data:DrWavPtr, filename:ConstCharStar, format:DrWavDataFormat, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):Bool
		return untyped __cpp__("drwav_init_file_write({0}, {1}, {2}, {3})", data, filename, format, allocationCallbacks) == 1;

	static inline function initFileWriteSequential(data:DrWavPtr, filename:ConstCharStar, format:DrWavDataFormat, totalSampleCount:cpp.UInt64, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):Bool
		return untyped __cpp__("drwav_init_file_write_sequential({0}, {1}, {2}, {3}, {4})", data, filename, format, totalSampleCount, allocationCallbacks) == 1;

	static inline function initFileWriteSequentialPCMFrames(data:DrWavPtr, filename:ConstCharStar, format:DrWavDataFormat, totalPCMFrameCount:cpp.UInt64, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):Bool
		return untyped __cpp__("drwav_init_file_write_sequential_pcm_frames({0}, {1}, {2}, {3}, {4})", data, filename, format, totalPCMFrameCount, allocationCallbacks) == 1;

	
	
	static inline function initFileW(data:DrWavPtr, filename:RawPointer<cpp.UInt16>, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):Bool
		return untyped __cpp__("drwav_init_file_w({0}, {1}, {2})", data, filename, allocationCallbacks) == 1;

	static inline function initFileEXW(data:DrWavPtr, filename:RawPointer<cpp.UInt16>, onChunk:DrWavChunkProc, chunkUserdata:Any, flags:cpp.UInt32, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):Bool
		return untyped __cpp__("drwav_init_file_ex_w({0}, {1}, {2}, {3}, {4}, {5})", data, filename, onChunk, chunkUserdata, flags, allocationCallbacks) == 1;

	static inline function initFileWithMetadataW(data:DrWavPtr, filename:RawPointer<cpp.UInt16>, flags:cpp.UInt32, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):Bool
		return untyped __cpp__("drwav_init_file_with_metadata_w({0}, {1}, {2}, {3})", data, filename, flags, allocationCallbacks) == 1;

	static inline function initFileWriteW(data:DrWavPtr, filename:RawPointer<cpp.UInt16>, format:DrWavDataFormat, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):Bool
		return untyped __cpp__("drwav_init_file_write_w({0}, {1}, {2}, {3})", data, filename, format, allocationCallbacks) == 1;

	static inline function initFileWriteSequentialW(data:DrWavPtr, filename:RawPointer<cpp.UInt16>, format:DrWavDataFormat, totalSampleCount:cpp.UInt64, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):Bool
		return untyped __cpp__("drwav_init_file_write_sequential_w({0}, {1}, {2}, {3}, {4})", data, filename, format, totalSampleCount, allocationCallbacks) == 1;

	static inline function initFileWriteSequentialPCMFramesW(data:DrWavPtr, filename:RawPointer<cpp.UInt16>, format:DrWavDataFormat, totalPCMFrameCount:cpp.UInt64, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):Bool
		return untyped __cpp__("drwav_init_file_write_sequential_pcm_frames_w({0}, {1}, {2}, {3}, {4})", data, filename, format, totalPCMFrameCount, allocationCallbacks) == 1;



	static inline function initMemory(wav:DrWavPtr, data:RawPointer<cpp.Void>, dataSize:cpp.UInt64, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):Bool
		return untyped __cpp__("drwav_init_memory({0}, {1}, {2}, {3})", wav, data, dataSize, allocationCallbacks) == 1;

	static inline function initMemoryEX(wav:DrWavPtr, data:RawPointer<cpp.Void>, dataSize:cpp.UInt64, onChunk:DrWavChunkProc, chunkUserdata:Any, flags:cpp.UInt32, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):Bool
		return untyped __cpp__("drwav_init_memory_ex({0}, {1}, {2}, {3}, {4}, {5}, {6})", wav, data, dataSize, onChunk, chunkUserdata, flags, allocationCallbacks) == 1;

	static inline function initMemoryWithMetadata(wav:DrWavPtr, data:RawPointer<cpp.Void>, dataSize:cpp.UInt64, flags:cpp.UInt32, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):Bool
		return untyped __cpp__("drwav_init_memory_with_metadata({0}, {1}, {2}, {3}, {4})", wav, data, dataSize, flags, allocationCallbacks) == 1;

	static inline function initMemoryWrite(wav:DrWavPtr, data:RawPointer<RawPointer<cpp.Void>>, dataSize:RawPointer<cpp.UInt64>, format:DrWavDataFormat, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):Bool
		return untyped __cpp__("drwav_init_memory_write({0}, {1}, {2}, {3}, {4})", wav, data, dataSize, format, allocationCallbacks) == 1;

	static inline function initMemoryWriteSequential(wav:DrWavPtr, data:RawPointer<RawPointer<cpp.Void>>, dataSize:RawPointer<cpp.UInt64>, format:DrWavDataFormat, totalSampleCount:cpp.UInt64, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):Bool
		return untyped __cpp__("drwav_init_memory_write_sequential({0}, {1}, {2}, {3}, {4}, {5})", wav, data, dataSize, format, totalSampleCount, allocationCallbacks) == 1;

	static inline function initMemoryWriteSequentialPCMFrames(wav:DrWavPtr, data:RawPointer<RawPointer<cpp.Void>>, dataSize:RawPointer<cpp.UInt64>, format:DrWavDataFormat, totalPCMFrameCount:cpp.UInt64, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):Bool
		return untyped __cpp__("drwav_init_memory_write_sequential_pcm_frames({0}, {1}, {2}, {3}, {4}, {6})", wav, data, dataSize, format, totalPCMFrameCount, allocationCallbacks) == 1;


	@:native('drwav_open_and_read_pcm_frames_s16')
	static function openAndReadPCMFramesShort16(onRead:DrWavReadProc, onSeek:DrWavSeekProc, userdata:Any, channels:RawPointer<cpp.UInt32>, sampleRate:RawPointer<cpp.UInt32>,
		totalFrameCount:RawPointer<cpp.UInt64>, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):RawPointer<cpp.Int16>;

	@:native('drwav_open_and_read_pcm_frames_f32')
	static function openAndReadPCMFramesFloat32(onRead:DrWavReadProc, onSeek:DrWavSeekProc, userdata:Any, channels:RawPointer<cpp.UInt32>, sampleRate:RawPointer<cpp.UInt32>,
		totalFrameCount:RawPointer<cpp.UInt64>, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):RawPointer<Float>;

	@:native('drwav_open_and_read_pcm_frames_s32')
	static function openAndReadPCMFramesSigned32(onRead:DrWavReadProc, onSeek:DrWavSeekProc, userdata:Any, channels:RawPointer<cpp.UInt32>, sampleRate:RawPointer<cpp.UInt32>,
		totalFrameCount:RawPointer<cpp.UInt64>, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):RawPointer<cpp.Int32>;



	@:native('drwav_open_file_and_read_pcm_frames_s16')
	static function openFileAndReadPCMFramesShort16(fileName:ConstCharStar, channels:RawPointer<cpp.UInt32>, sampleRate:RawPointer<cpp.UInt32>,
		totalFrameCount:RawPointer<cpp.UInt64>, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):RawPointer<cpp.Int16>;

	@:native('drwav_open_file_and_read_pcm_frames_f32')
	static function openFileAndReadPCMFramesFloat32(fileName:ConstCharStar, channels:RawPointer<cpp.UInt32>, sampleRate:RawPointer<cpp.UInt32>,
		totalFrameCount:RawPointer<cpp.UInt64>, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):RawPointer<Float>;

	@:native('drwav_open_file_and_read_pcm_frames_s32')
	static function openFileAndReadPCMFramesSigned32(fileName:ConstCharStar, channels:RawPointer<cpp.UInt32>, sampleRate:RawPointer<cpp.UInt32>,
		totalFrameCount:RawPointer<cpp.UInt64>, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):RawPointer<cpp.Int32>;



	@:native('drwav_open_file_and_read_pcm_frames_s16_w')
	static function openFileAndReadPCMFramesShort16W(fileName:RawPointer<cpp.UInt16>, channels:RawPointer<cpp.UInt32>, sampleRate:RawPointer<cpp.UInt32>,
		totalFrameCount:RawPointer<cpp.UInt64>, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):RawPointer<cpp.Int16>;

	@:native('drwav_open_file_and_read_pcm_frames_f32_w')
	static function openFileAndReadPCMFramesFloat32W(fileName:RawPointer<cpp.UInt16>, channels:RawPointer<cpp.UInt32>, sampleRate:RawPointer<cpp.UInt32>,
		totalFrameCount:RawPointer<cpp.UInt64>, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):RawPointer<Float>;

	@:native('drwav_open_file_and_read_pcm_frames_s32_w')
	static function openFileAndReadPCMFramesSigned32W(fileName:RawPointer<cpp.UInt16>, channels:RawPointer<cpp.UInt32>, sampleRate:RawPointer<cpp.UInt32>,
		totalFrameCount:RawPointer<cpp.UInt64>, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):RawPointer<cpp.Int32>;



	@:native('drwav_open_memory_and_read_pcm_frames_s16')
	static function openMemoryAndReadPCMFramesShort16(data:RawPointer<cpp.Void>, dataSize:cpp.UInt64, channels:RawPointer<cpp.UInt32>, sampleRate:RawPointer<cpp.UInt32>,
		totalFrameCount:RawPointer<cpp.UInt64>, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):RawPointer<cpp.Int16>;

	@:native('drwav_open_memory_and_read_pcm_frames_f32')
	static function openMemoryAndReadPCMFramesFloat32(data:RawPointer<cpp.Void>, dataSize:cpp.UInt64, channels:RawPointer<cpp.UInt32>, sampleRate:RawPointer<cpp.UInt32>,
		totalFrameCount:RawPointer<cpp.UInt64>, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):RawPointer<Float>;

	@:native('drwav_open_memory_and_read_pcm_frames_s32')
	static function openMemoryAndReadPCMFramesSigned32(data:RawPointer<cpp.Void>, dataSize:cpp.UInt64, channels:RawPointer<cpp.UInt32>, sampleRate:RawPointer<cpp.UInt32>,
		totalFrameCount:RawPointer<cpp.UInt64>, allocationCallbacks:RawPointer<DrWavAllocationCallbacks>):RawPointer<cpp.Int32>;



	inline static function free(data:Any, allocationCallbacks:cpp.RawPointer<DrWavAllocationCallbacks>):Void
		untyped __cpp__('drwav_free({0}, {1})', data, allocationCallbacks);

	@:native("drwav_bytes_to_u16")
	static function bytesToUnsigned16(data:RawPointer<cpp.UInt8>):RawPointer<cpp.UInt16>;

	@:native("drwav_bytes_to_s16")
	static function bytesToShort16(data:RawPointer<cpp.UInt8>):RawPointer<cpp.Int16>;

	@:native("drwav_bytes_to_u32")
	static function bytesToUnsigned32(data:RawPointer<cpp.UInt8>):RawPointer<cpp.UInt32>;

	@:native("drwav_bytes_to_s32")
	static function bytesToSigned32(data:RawPointer<cpp.UInt8>):RawPointer<cpp.Int32>;

	@:native("drwav_bytes_to_u64")
	static function bytesToUnsigned64(data:RawPointer<cpp.UInt8>):RawPointer<cpp.UInt64>;

	@:native("drwav_bytes_to_s64")
	static function bytesToSigned64(data:RawPointer<cpp.UInt8>):RawPointer<cpp.Int64>;

	@:native("drwav_bytes_to_f32")
	static function bytesToFloat32(data:RawPointer<cpp.UInt8>):RawPointer<Float>;

	static inline function guidEqual(a:RawPointer<cpp.UInt8>, b:RawPointer<cpp.UInt8>):Bool
		return untyped __cpp__("drwav_guid_equal({0}, {1})", a, b) == 1;

	static inline function fourccEqual(a:RawPointer<cpp.UInt8>, b:ConstCharStar):Bool
		return untyped __cpp__("drwav_fourcc_equal({0}, {1})", a, b) == 1;
}