package bindings.audio;

import cpp.CastCharStar;
import cpp.ConstCharStar;
import cpp.Callable;
import cpp.RawPointer;

// this is basically just DrWav.hx lmao but flac
// - what-is-a-git
// nuh uh not anymore
// - Srt

@:include('audio/dr_flac.h')
@:native('drflac_allocation_callbacks')
@:structAccess
extern class DrFLACAllocationCallbacks {
	@:native("pUserData")
	var userData:RawPointer<cpp.Void>;

	@:native("onMalloc")
	var onMalloc:RawPointer<Callable<(size:cpp.UInt64, userdata:RawPointer<cpp.Void>) -> RawPointer<cpp.Void>>>;
	@:native("onRealloc")
	var onRealloc:RawPointer<Callable<(pointer:RawPointer<cpp.Void>, size:cpp.UInt64, userdata:RawPointer<cpp.Void>) -> RawPointer<cpp.Void>>>;
	@:native("onFree")
	var onFree:RawPointer<Callable<(pointer:RawPointer<cpp.Void>, userdata:RawPointer<cpp.Void>) -> RawPointer<cpp.Void>>>;
}

@:include('audio/dr_flac.h')
extern enum abstract DrFLACMetadataBlockType(cpp.UInt32) {
	@:native("DRFLAC_METADATA_BLOCK_TYPE_STREAMINFO")
	var STREAMINFO;
	@:native("DRFLAC_METADATA_BLOCK_TYPE_PADDING")
	var PADDING;
	@:native("DRFLAC_METADATA_BLOCK_TYPE_APPLICATION")
	var APPLICATION;
	@:native("DRFLAC_METADATA_BLOCK_TYPE_SEEKTABLE")
	var SEEKTABLE;
	@:native("DRFLAC_METADATA_BLOCK_TYPE_VORBIS_COMMENT")
	var VORBIS_COMMENT;
	@:native("DRFLAC_METADATA_BLOCK_TYPE_CUESHEET")
	var CUESHEET;
	@:native("DRFLAC_METADATA_BLOCK_TYPE_PICTURE")
	var PICTURE;
	@:native("DRFLAC_METADATA_BLOCK_TYPE_INVALID")
	var INVALID;
}

@:include('audio/dr_flac.h')
extern enum abstract DrFLACPictureType(cpp.UInt32) {
	@:native("DRFLAC_PICTURE_TYPE_OTHER")
	var OTHER;
	@:native("DRFLAC_PICTURE_TYPE_FILE_ICON")
	var FILE_ICON;
	@:native("DRFLAC_PICTURE_TYPE_OTHER_FILE_ICON")
	var OTHER_FILE_ICON;
	@:native("DRFLAC_PICTURE_TYPE_COVER_FRONT")
	var COVER_FRONT;
	@:native("DRFLAC_PICTURE_TYPE_COVER_BACK")
	var COVER_BACK;
	@:native("DRFLAC_PICTURE_TYPE_LEAFLET_PAGE")
	var LEAFLET_PAGE;
	@:native("DRFLAC_PICTURE_TYPE_MEDIA")
	var MEDIA;
	@:native("DRFLAC_PICTURE_TYPE_LEAD_ARTIST")
	var LEAD_ARTIST;
	@:native("DRFLAC_PICTURE_TYPE_ARTIST")
	var ARTIST;
	@:native("DRFLAC_PICTURE_TYPE_CONDUCTOR")
	var CONDUCTOR;
	@:native("DRFLAC_PICTURE_TYPE_BAND")
	var BAND;
	@:native("DRFLAC_PICTURE_TYPE_COMPOSER")
	var COMPOSER;
	@:native("DRFLAC_PICTURE_TYPE_LYRICIST")
	var LYRICIST;
	@:native("DRFLAC_PICTURE_TYPE_RECORDING_LOCATION")
	var RECORDING_LOCATION;
	@:native("DRFLAC_PICTURE_TYPE_DURING_RECORDING")
	var DURING_RECORDING;
	@:native("DRFLAC_PICTURE_TYPE_DURING_PERFORMANCE")
	var DURING_PERFORMANCE;
	@:native("DRFLAC_PICTURE_TYPE_SCREEN_CAPTURE")
	var SCREEN_CAPTURE;
	@:native("DRFLAC_PICTURE_TYPE_BRIGHT_COLORED_FISH")
	var BRIGHT_COLORED_FISH;
	@:native("DRFLAC_PICTURE_TYPE_ILLUSTRATION")
	var ILLUSTRATION;
	@:native("DRFLAC_PICTURE_TYPE_BAND_LOGOTYPE")
	var BAND_LOGOTYPE;
	@:native("DRFLAC_PICTURE_TYPE_PUBLISHER_LOGOTYPE")
	var PUBLISHER_LOGOTYPE;
}

enum abstract DrFLACContainer(cpp.UInt32) {
	var NATIVE;
	var OGG;
	var UNKNOWN;
}

typedef DrFLACSeekOrigin = DrMP3.DrMP3SeekOrigin;

@:include('audio/dr_flac.h')
@:native('drflac_seek_point')
@:structAccess
extern class DrFLACSeekPoint {
	@:native("firstPCMFrame")
	var firstPCMFrame:cpp.UInt64;
	@:native("flacFrameOffset")
	var flacFrameOffset:cpp.UInt64;
	@:native("pcmFrameCount")
	var pcmFrameCount:cpp.UInt64;
}

@:include('audio/dr_flac.h')
@:native('drflac_streaminfo')
@:structAccess
extern class DrFLACStreamInfo {
	@:native("minBlockSizeInPCMFrames")
	var minBlockSizeInPCMFrames:cpp.UInt16;
	@:native("maxBlockSizeInPCMFrames")
	var maxBlockSizeInPCMFrames:cpp.UInt16;
	@:native("minFrameSizeInPCMFrames")
	var minFrameSizeInPCMFrames:cpp.UInt32;
	@:native("maxFrameSizeInPCMFrames")
	var maxFrameSizeInPCMFrames:cpp.UInt32;
	@:native("sampleRate")
	var sampleRate:cpp.UInt32;
	@:native("channels")
	var channels:cpp.UInt8;
	@:native("bitsPerSample")
	var bitsPerSample:cpp.UInt8;
	@:native("totalPCMFrameCount")
	var totalPCMFrameCount:cpp.UInt64;
	@:native("md5")
	var md5:RawPointer<cpp.UInt8>;
}

@:structAccess
extern class DrFLACPadding {
	var unused:Int;
}
@:structAccess
extern class DrFLACApplication {
	var id:cpp.UInt32;
	var pData:RawPointer<cpp.Void>;
	var dataSize:cpp.UInt32;
}
@:structAccess
extern class DrFLACSeekTable {
	var seekpointCount:cpp.UInt32;
	var pSeekpoints:RawPointer<DrFLACSeekPoint>;
}
@:structAccess
extern class DrFLACComment {
	var vendorLength:cpp.UInt32;
	var vender:ConstCharStar;
	var commentCount:cpp.UInt32;
	var pComments:RawPointer<cpp.Void>;
}
@:structAccess
extern class DrFLACCueSheet {
	var catalog:CastCharStar;
	var leadInSampleCount:cpp.UInt64;
	var isCD:cpp.UInt32;
	var trackCount:cpp.UInt8;
	var pTrackData:RawPointer<cpp.Void>;
}
@:structAccess
extern class DrFLACPicture {
	var type:cpp.UInt32;
	var mimeLength:cpp.UInt32;
	var mime:ConstCharStar;
	var descriptionLength:cpp.UInt32;
	var description:ConstCharStar;
	var width:cpp.UInt32;
	var height:cpp.UInt32;
	var colorDepth:cpp.UInt32;
	var indexColorCount:cpp.UInt32;
	var pictureDataSize:cpp.UInt32;
	var pPictureData:RawPointer<cpp.UInt8>;
}
@:structAccess
extern class DrFLACMetadataUnion {
	var streamInfo:DrFLACStreamInfo;
	var padding:DrFLACPadding;
	var application:DrFLACApplication;
	var seektable:DrFLACSeekTable;
	@:native("vorbis_comment")
	var vorbisComment:DrFLACComment;
	var cuesheet:DrFLACCueSheet;
	var picture:DrFLACPicture;
}
@:include("audio/dr_flac.h")
@:native("drflac_metadata")
@:structAccess
extern class DrFLACMetadata {
	var type:DrFLACMetadataBlockType;
	var pRawData:RawPointer<cpp.Void>;
	var rawDataSize:cpp.UInt32;
	var data:DrFLACMetadataUnion;
}

typedef DrFLACReadProc = DrMP3.DrMP3ReadProc;
typedef DrFLACSeekProc = DrMP3.DrMP3SeekProc;
typedef DrFLACMetaProc = Callable<(userdata:RawPointer<cpp.Void>, metadata:DrFLACMetadata) -> Void>;

@:include("audio/dr_flac.h")
@:native("drflac__memory_stream")
@:structAccess
extern class DrFLACMemoryStream {
	var data:RawPointer<cpp.UInt8>;
	var dataSize:cpp.UInt64;
	var currentReadPos:cpp.UInt64;
}

@:include("audio/dr_flac.h")
@:native("drflac_bs")
@:structAccess
extern class DrFLACBitStream {
	var onRead:DrFLACReadProc;
	var onSeek:DrFLACSeekProc;
	var pUserData:RawPointer<cpp.Void>;

	var unalignedByteCount:cpp.UInt64;
	var unalignedCache:cpp.UInt64;
	var nextL2Line:cpp.UInt32;
	var consumedBits:cpp.UInt32;
	var cacheL2:RawPointer<cpp.UInt64>;
	var cache:cpp.UInt64;

	var crc16:cpp.UInt16;
	var crc16Cache:cpp.UInt64;
	var crc16CacheIgnoredBytes:cpp.UInt32;
}

extern enum abstract DrFLACSubFrameType(cpp.UInt32) from cpp.UInt32 to cpp.UInt32 {
	@:native("DRFLAC_SUBFRAME_CONSTANT")
	var CONSTANT;
	@:native("DRFLAC_SUBFRAME_VERBATIM")
	var VERBATIM;
	@:native("DRFLAC_SUBFRAME_FIXED")
	var FIXED;
	@:native("DRFLAC_SUBFRAME_LPC")
	var LPC;
	@:native("DRFLAC_SUBFRAME_RESERVED")
	var RESERVED;
}

@:include("audio/dr_flac.h")
@:native("drflac_subframe")
@:structAccess
extern class DrFLACSubFrame {
	var subframeType:DrFLACSubFrameType;
	var wastedBitsPerSample:cpp.UInt8;
	var lpcOrder:cpp.UInt8;
	var pSamplesS32:cpp.Int32;
}

@:include("audio/dr_flac.h")
@:native("drflac_frame_header")
@:structAccess
extern class DrFLACFrameHeader {
	var pcmFrameNumebr:cpp.UInt64;
	var flacFrameNumber:cpp.UInt32;
	var sampleRate:cpp.UInt32;
	var blockSizeInPCMFrames:cpp.Int16;
	var channelAssignment:cpp.UInt8;
	var bitsPerSample:cpp.UInt8;
	var crc8:cpp.UInt8;
}

@:include("audio/dr_flac.h")
@:native("drflac_frame")
@:structAccess
extern class DrFLACFrame {
	var header:DrFLACFrameHeader;
	var pcmFramesRemaining:cpp.UInt32;
	var subframes:RawPointer<DrFLACSubFrame>;
}

@:include("audio/dr_flac.h")
@:native("drflac")
@:structAccess
extern class _DrFLACData {
	@:native("onMeta")
	var onMeta:DrFLACMetaProc;
	@:native("pUserDataMD")
	var userdata:RawPointer<Void>;
	@:native("allocationCallbacks")
	var allocationCallbacks:DrFLACAllocationCallbacks;
	@:native("sampleRate")
	var sampleRate:cpp.UInt32;
	@:native("channels")
	var channels:cpp.UInt8;
	@:native("bitsPerSample")
	var bitsPerSample:cpp.UInt8;
	@:native("maxBlockSizeInPCMFrames")
	var maxBlockSizeInPCMFrames:cpp.UInt16;
	@:native("totalPCMFrameCount")
	var totalPCMFrameCount:cpp.UInt64;
	@:native("container")
	var container:DrFLACContainer;
	@:native("seekpointCount")
	var seekpointCount:cpp.UInt32;
	@:native("currentFLACFrame")
	var currentFLACFrame:DrFLACFrame;
	@:native("currentPCMFrame")
	var currentPCMFrame:cpp.UInt64;
	@:native("firstFLACFramePosInBytes")
	var firstFLACFramePosInBytes:cpp.UInt64;
	@:native("memoryStream")
	var memoryStream:DrFLACMemoryStream;
	@:native("pDecodedSamples")
	var decodedSamples:RawPointer<cpp.Int32>;
	@:native("pSeekpoints")
	var seekpoints:RawPointer<DrFLACSeekPoint>;
	@:native("bs")
	var bitstream:DrFLACBitStream;
	@:native("pExtraData")
	var extraData:RawPointer<cpp.UInt8>;
}
typedef DrFLACData = RawPointer<_DrFLACData>;

@:include("audio/dr_flac.h")
@:native("drflac_vorbis_comment_iterator")
@:structAccess
extern class _DrFLACCommentIterator {
	var countRemaining:cpp.UInt32;
	var pRunningData:ConstCharStar;
}
typedef DrFLACCommentIterator = RawPointer<_DrFLACCommentIterator>;

@:include("audio/dr_flac.h")
@:native("drflac_cuesheet_track_iterator")
@:structAccess
extern class _DrFLACCuesheetTrackIterator {
	var countRemaining:cpp.UInt32;
	var pRunningData:ConstCharStar;
}
typedef DrFLACCuesheetTrackIterator = RawPointer<_DrFLACCuesheetTrackIterator>;

@:include("audio/dr_flac.h")
@:native("drflac_cuesheet_track_index")
@:structAccess
extern class DrFLACCuesheetTrackIndex {
	var offset:cpp.UInt64;
	var index:cpp.UInt8;
	var reserved:RawPointer<cpp.UInt8>;
}

@:include("audio/dr_flac.h")
@:native("drflac_cuesheet_track")
@:structAccess
extern class DrFLACCuesheetTrack {
	var offset:cpp.UInt64;
	var trackNumber:cpp.UInt8;
	var ISRC:CastCharStar;
	var isAudio:cpp.UInt8;
	var preEmphasis:cpp.UInt8;
	var indexCount:cpp.UInt8;
	var pIndexPoints:RawPointer<DrFLACCuesheetTrackIndex>;
}

@:include('audio/dr_flac.h')
extern class DrFLAC {
	@:native("DRFLAC_VERSION_MAJOR")
	static final VERSION_MAJOR:cpp.UInt32;
	@:native("DRFLAC_VERSION_MINOR")
	static final VERSION_MINOR:cpp.UInt32;
	@:native("DRFLAC_VERSION_REVISION")
	static final VERSION_REVISION:cpp.UInt32;
	@:native("DRFLAC_VERSION_STRING")
	static final VERSION_STRING:ConstCharStar;



	@:native("drflac_open")
	static function open(onRead:DrFLACReadProc, onSeek:DrFLACSeekProc, userdata:RawPointer<cpp.Void>, allocationCallbacks:RawPointer<DrFLACAllocationCallbacks>):DrFLACData;

	@:native("drflac_open_relaxed")
	static function openRelaxed(onRead:DrFLACReadProc, onSeek:DrFLACSeekProc, container:DrFLACContainer, userdata:RawPointer<cpp.Void>, allocationCallbacks:RawPointer<DrFLACAllocationCallbacks>):DrFLACData;

	@:native("drflac_open_with_metadata")
	static function openWithMetadata(onRead:DrFLACReadProc, onSeek:DrFLACSeekProc, onMeta:DrFLACMetaProc, userdata:RawPointer<cpp.Void>, allocationCallbacks:RawPointer<DrFLACAllocationCallbacks>):DrFLACData;

	@:native("drflac_open_with_metadata_relaxed")
	static function openWithMetadataRelaxed(onRead:DrFLACReadProc, onSeek:DrFLACSeekProc, onMeta:DrFLACMetaProc, container:DrFLACContainer, userdata:RawPointer<cpp.Void>, allocationCallbacks:RawPointer<DrFLACAllocationCallbacks>):DrFLACData;

	@:native("drflac_close")
	static function close(data:DrFLACData):Void;



	@:native("drflac_read_pcm_frames_s32")
	static function readPCMFramesSigned32(data:DrFLACData, framesToRead:cpp.UInt64, bufferOut:RawPointer<cpp.Int32>):cpp.UInt64;

	@:native("drflac_read_pcm_frames_s16")
	static function readPCMFramesShort16(data:DrFLACData, framesToRead:cpp.UInt64, bufferOut:RawPointer<cpp.Int16>):cpp.UInt64;

	@:native("drflac_read_pcm_frames_f32")
	static function readPCMFramesFloat32(data:DrFLACData, framesToRead:cpp.UInt64, bufferOut:RawPointer<Float>):cpp.UInt64;

	static inline function seekToPCMFrame(data:DrFLACData, frame:cpp.UInt64):Bool
		return untyped __cpp__("drflac_seek_to_pcm_frame({0}, {1})", data, frame) == 1;



	@:native("drflac_open_file")
	static function openFile(fileName:ConstCharStar, allocationCallbacks:RawPointer<DrFLACAllocationCallbacks>):DrFLACData;

	@:native("drflac_open_file_w")
	static function openFileW(fileName:RawPointer<cpp.UInt16>, allocationCallbacks:RawPointer<DrFLACAllocationCallbacks>):DrFLACData;

	@:native("drflac_open_file_with_metadata")
	static function openFileWithMetadata(fileName:ConstCharStar, onMeta:DrFLACMetaProc, userdata:RawPointer<cpp.Void>, allocationCallbacks:RawPointer<DrFLACAllocationCallbacks>):DrFLACData;

	@:native("drflac_open_file_with_metadata_w")
	static function openFileWithMetadataW(fileName:RawPointer<cpp.UInt16>, onMeta:DrFLACMetaProc, userdata:RawPointer<cpp.Void>, allocationCallbacks:RawPointer<DrFLACAllocationCallbacks>):DrFLACData;



	@:native("drflac_open_memory")
	static function openMemory(data:RawPointer<cpp.Void>, dataSize:cpp.UInt64, allocationCallbacks:RawPointer<DrFLACAllocationCallbacks>):DrFLACData;

	@:native("drflac_open_memory_with_metadata")
	static function openMemoryWithMetadata(data:RawPointer<cpp.Void>, dataSize:cpp.UInt64, onMeta:DrFLACMetaProc, userdata:RawPointer<cpp.Void>, allocationCallbacks:RawPointer<DrFLACAllocationCallbacks>):DrFLACData;



	@:native('drflac_open_and_read_pcm_frames_s32')
	static function openAndReadPCMFramesSigned32(onRead:DrFLACReadProc, onSeek:DrFLACSeekProc, userdata:RawPointer<cpp.Void>, channels:cpp.RawPointer<cpp.UInt32>, sampleRate:cpp.RawPointer<cpp.UInt32>,
		totalFrameCount:cpp.RawPointer<DrFLACUInt64>, allocationCallbacks:RawPointer<DrFLACAllocationCallbacks>):cpp.RawPointer<cpp.Int32>;

	@:native('drflac_open_and_read_pcm_frames_s16')
	static function openAndReadPCMFramesShort16(onRead:DrFLACReadProc, onSeek:DrFLACSeekProc, userdata:RawPointer<cpp.Void>, channels:cpp.RawPointer<cpp.UInt32>, sampleRate:cpp.RawPointer<cpp.UInt32>,
		totalFrameCount:cpp.RawPointer<DrFLACUInt64>, allocationCallbacks:RawPointer<DrFLACAllocationCallbacks>):cpp.RawPointer<cpp.Int16>;

	@:native('drflac_open_and_read_pcm_frames_f32')
	static function openAndReadPCMFramesFloat32(onRead:DrFLACReadProc, onSeek:DrFLACSeekProc, userdata:RawPointer<cpp.Void>, channels:cpp.RawPointer<cpp.UInt32>, sampleRate:cpp.RawPointer<cpp.UInt32>,
		totalFrameCount:cpp.RawPointer<DrFLACUInt64>, allocationCallbacks:RawPointer<DrFLACAllocationCallbacks>):cpp.RawPointer<Float>;



	@:native('drflac_open_file_and_read_pcm_frames_s32')
	static function openFileAndReadPCMFramesSigned32(fileName:ConstCharStar, channels:cpp.RawPointer<cpp.UInt32>, sampleRate:cpp.RawPointer<cpp.UInt32>,
		totalFrameCount:cpp.RawPointer<DrFLACUInt64>, allocationCallbacks:RawPointer<DrFLACAllocationCallbacks>):cpp.RawPointer<cpp.Int32>;

	@:native('drflac_open_file_and_read_pcm_frames_s16')
	static function openFileAndReadPCMFramesShort16(fileName:ConstCharStar, channels:cpp.RawPointer<cpp.UInt32>, sampleRate:cpp.RawPointer<cpp.UInt32>,
		totalFrameCount:cpp.RawPointer<DrFLACUInt64>, allocationCallbacks:RawPointer<DrFLACAllocationCallbacks>):cpp.RawPointer<cpp.Int16>;

	@:native('drflac_open_file_and_read_pcm_frames_f32')
	static function openFileAndReadPCMFramesFloat32(fileName:ConstCharStar, channels:cpp.RawPointer<cpp.UInt32>, sampleRate:cpp.RawPointer<cpp.UInt32>,
		totalFrameCount:cpp.RawPointer<DrFLACUInt64>, allocationCallbacks:RawPointer<DrFLACAllocationCallbacks>):cpp.RawPointer<Float>;


		
	@:native('drflac_open_memory_and_read_pcm_frames_s32')
	static function openMemoryAndReadPCMFramesSigned32(data:RawPointer<cpp.Void>, dataSize:cpp.UInt64, channels:cpp.RawPointer<cpp.UInt32>, sampleRate:cpp.RawPointer<cpp.UInt32>,
		totalFrameCount:cpp.RawPointer<DrFLACUInt64>, allocationCallbacks:RawPointer<DrFLACAllocationCallbacks>):cpp.RawPointer<cpp.Int32>;

	@:native('drflac_open_memory_and_read_pcm_frames_s16')
	static function openMemoryAndReadPCMFramesShort16(data:RawPointer<cpp.Void>, dataSize:cpp.UInt64, channels:cpp.RawPointer<cpp.UInt32>, sampleRate:cpp.RawPointer<cpp.UInt32>,
		totalFrameCount:cpp.RawPointer<DrFLACUInt64>, allocationCallbacks:RawPointer<DrFLACAllocationCallbacks>):cpp.RawPointer<cpp.Int16>;

	@:native('drflac_open_memory_and_read_pcm_frames_f32')
	static function openMemoryAndReadPCMFramesFloat32(data:RawPointer<cpp.Void>, dataSize:cpp.UInt64, channels:cpp.RawPointer<cpp.UInt32>, sampleRate:cpp.RawPointer<cpp.UInt32>,
		totalFrameCount:cpp.RawPointer<DrFLACUInt64>, allocationCallbacks:RawPointer<DrFLACAllocationCallbacks>):cpp.RawPointer<Float>;	



	inline static function free(data:Any, allocationCallbacks:cpp.RawPointer<DrFLACAllocationCallbacks>):Void {
		untyped __cpp__('drflac_free({0}, {1})', data, allocationCallbacks);
	}

	static inline function initCommentIterator(commentCount:cpp.UInt32, comments:RawPointer<cpp.Void>):DrFLACCommentIterator {
		untyped __cpp__("drflac_vorbis_comment_iterator _iterator; drflac_init_vorbis_comment_iterator(&_iterator, {0}, {1})", commentCount, comments);
		return untyped __cpp__("&_iterator");
	}

	@:native("drflac_next_vorbis_comment")
	static function nextComment(iterator:DrFLACCommentIterator, commentLengthOut:RawPointer<cpp.UInt32>):ConstCharStar;

	static inline function initCuesheetTrackIterator(trackCount:cpp.UInt32, trackData:RawPointer<cpp.Void>):DrFLACCommentIterator {
		untyped __cpp__("drflac_cuesheet_track_iterator _iterator; drflac_init_cuesheet_track_iterator(&_iterator, {0}, {1})", trackCount, trackData);
		return untyped __cpp__("&_iterator");
	}

	static inline function nextCuesheetTrack(iterator:DrFLACCommentIterator, cuesheetTrack:RawPointer<DrFLACCuesheetTrack>):Bool
		return untyped __cpp__("drflac_next_cuesheet_track({0}, {1})", iterator, cuesheetTrack) == 1;
}

/**
 * I love making new abstract types that aren't copied from cpp.SizeT! :3
 * @author what-is-a-git
 */
 @:native("long long unsigned int")
 @:scalar @:coreType @:notNull
 extern abstract DrFLACUInt64 from(Int) to(Int) {}
