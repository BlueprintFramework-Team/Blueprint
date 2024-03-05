package bindings.audio;

import cpp.FILE;
import cpp.RawPointer;
import cpp.CastCharStar;

@:include('audio/stb_vorbis.h')
@:native("stb_vorbis_alloc")
@:structAccess
extern class VorbisAlloc {
	@:native("alloc_buffer")
	var allocBuffer:CastCharStar;
	@:native("alloc_buffer_length_in_bytes")
	var lengthInBytes:Int;
}

@:include('audio/stb_vorbis.h')
@:native("ProbedPage")
@:structAccess
extern class ProbedPage {
	@:native("page_start")
	var start:cpp.UInt32;
	@:native("page_end")
	var end:cpp.UInt32;
	@:native("last_decoded_sample")
	var lastDecodedSample:cpp.UInt32;
}

@:include('audio/stb_vorbis.h')
@:native("Codebook")
@:structAccess
extern class Codebook {
	@:native("dimensions")
	var dimensions:Int;
	@:native("enteries")
	var enteries:Int;
	@:native("codeword_lengths")
	var codewordLengths:RawPointer<cpp.UInt8>;
	@:native("minimum_value")
	var minValue:Float;
	@:native("delta_value")
	var deltaValue:Float;
	@:native("value_bits")
	var valueBits:cpp.UInt8;
	@:native("lookup_type")
	var lookupType:cpp.UInt8;
	@:native("sequence_p")
	var sequenceP:cpp.UInt8;
	@:native("sparse")
	var sparse:cpp.UInt8;
	@:native("lookup_values")
	var lookupValues:cpp.UInt32;
	@:native("multiplicands")
	var multiplicands:RawPointer<Float>;
	@:native("codewords")
	var codewords:RawPointer<cpp.UInt32>;
	@:native("fast_huffman")
	var fastHuffman:RawPointer<cpp.Int16>;
	@:native("sorted_codewords")
	var sortedCodewords:RawPointer<cpp.UInt32>;
	@:native("sorted_values")
	var sorted_values:RawPointer<Int>;
	@:native("sorted_entries")
	var sortedEntries:Int;
}

@:include('audio/stb_vorbis.h')
@:native("Floor")
@:structAccess
extern class Floor {
	@:native("floor0")
	var floor0:Floor0;
	@:native("floor1")
	var floor1:Floor1;
}

@:include('audio/stb_vorbis.h')
@:native("Floor0")
@:structAccess
extern class Floor0 {
	@:native("order")
	var order:cpp.UInt8;
	@:native("rate")
	var rate:cpp.UInt16;
	@:native("bark_map_size")
	var barkMapSize:cpp.UInt16;
	@:native("amplitude_bits")
	var amplitideBits:cpp.UInt8;
	@:native("amplitude_offset")
	var amplitudeOffset:cpp.UInt8;
	@:native("number_of_books")
	var numBooks:cpp.UInt8;
	@:native("book_list")
	var bookList:RawPointer<cpp.UInt8>;
}

@:include('audio/stb_vorbis.h')
@:native("Floor1")
@:structAccess
extern class Floor1 {
	@:native("partitions")
	var partitions:cpp.UInt8;
	@:native("partition_class_list")
	var partitionClassList:RawPointer<cpp.UInt8>;
	@:native("class_dimensions")
	var classDimensions:RawPointer<cpp.UInt8>;
	@:native("class_subclasses")
	var classSubclasses:RawPointer<cpp.UInt8>;
	@:native("class_masterbooks")
	var classMasterbooks:RawPointer<cpp.UInt8>;
	@:native("subclass_books")
	var subclassBooks:RawPointer<cpp.Int16>;
	@:native("Xlist")
	var Xlist:RawPointer<cpp.UInt16>;
	@:native("sorted_order")
	var sortedOrder:RawPointer<cpp.UInt8>;
	@:native("neighbors")
	var neighbors:RawPointer<cpp.UInt8>;
	@:native("floor1_multiplier")
	var floor1Multiplier:cpp.UInt8;
	@:native("rangebits")
	var rangeBits:cpp.UInt8;
	@:native("values")
	var values:Int;
}

@:include('audio/stb_vorbis.h')
@:native("Residue")
@:structAccess
extern class Residue {
	@:native("begin")
	var begin:cpp.UInt32;
	@:native("end")
	var end:cpp.UInt32;
	@:native("part_size")
	var partSize:cpp.UInt32;
	@:native("classifications")
	var classifications:cpp.UInt8;
	@:native("classbook")
	var classbook:cpp.UInt8;
	@:native("classdata")
	var classData:RawPointer<RawPointer<cpp.UInt8>>;
	@:native("residue_books")
	var residueBooks:RawPointer<cpp.Int16>;
}

@:include('audio/stb_vorbis.h')
@:native("MappingChannel")
@:structAccess
extern class MappingChannel {
	@:native("magnitude")
	var magnitude:cpp.UInt8;
	@:native("angle")
	var angle:cpp.UInt8;
	@:native("mux")
	var mux:cpp.UInt8;
}

@:include('audio/stb_vorbis.h')
@:native("Mapping")
@:structAccess
extern class Mapping {
	@:native("coupling_steps")
	var couplingSteps:cpp.UInt16;
	@:native("chan")
	var channel:RawPointer<MappingChannel>;
	@:native("submaps")
	var submaps:cpp.UInt8;
	@:native("submap_floor")
	var submapFloor:RawPointer<RawPointer<cpp.UInt8>>;
	@:native("submap_residue")
	var submapResidue:RawPointer<cpp.Int16>;
}

@:include('audio/stb_vorbis.h')
@:native("Mode")
@:structAccess
extern class VorbisMode {
	@:native("blockflag")
	var blockFlag:cpp.UInt8;
	@:native("mapping")
	var mapping:cpp.UInt8;
	@:native("windowtype")
	var windowType:cpp.UInt16;
	@:native("transformtype")
	var transformType:cpp.Int16;
}

@:include('audio/stb_vorbis.h')
@:native("CRCscan")
@:structAccess
extern class CRCScan {
	@:native("goal_crc")
	var goalCRC:cpp.UInt32;
	@:native("bytes_left")
	var bytesLeft:Int;
	@:native("crc_so_far")
	var CRCSoFar:cpp.UInt32;
	@:native("bytes_done")
	var bytesDone:Int;
	@:native("sample_loc")
	var sampleLoc:cpp.UInt32;
}

enum abstract VorbisError(cpp.UInt32) {
	var NO_ERROR;

	var NEED_MORE_DATA = 1;             // not a real error

	var INVALID_API_MIXIN;           // can't mix API modes
	var OUT_OF_MEM;                     // not enough memory
	var FEATURE_NOT_SUPPORTED;        // uses floor 0
	var TOO_MAMY_CHANNELS;            // STB_var MAX_CHANNELS is too small
	var FILE_OPEN_FAIL;            // fopen() failed
	var SEEK_WITHOUT_LENGTH;          // can't seek in unknown-length file

	var UNEXPECTED_EOF = 10;            // file is truncated?
	var SEEK_INVALID;                 // seek past EOF

	// decoding errors (corrupt/invalid stream) -- you probably
	// don't care about the exact details of these

	// vorbis errors:
	var INVALID_SETUP = 20;
	var INVALID_STREAM;

	// ogg errors:
	var MISSING_CAPTURE_PATTERN = 30;
	var INVALID_STREAM_STRUCTURE_VERSION;
	var CONTINUED_PACKET_FLAG_INVALID;
	var INCORRECT_STREAM_SERIAL_NUMBER;
	var INVALID_FIRST_PAGE;
	var BAD_PACKET_TYPE;
	var CANT_FIND_LAST_PAGE;
	var SEEK_FAILED;
	var OGG_SKELETON_NOT_SUPPORTED;
}

@:include('audio/stb_vorbis.h')
@:native("stb_vorbis")
@:structAccess
extern class VorbisInfo {
	@:native("sample_rate")
	var sampleRate:cpp.UInt32;
	@:native("channels")
	var channels:Int;

	@:native("setup_memory_required")
	var setupMemoryRequired:cpp.UInt32;
	@:native("temp_memory_required")
	var tempMemoryRequired:cpp.UInt32;
	@:native("setup_temp_memory_required")
	var setupTempMemoryRequired:cpp.UInt32;

	@:native("max_frame_size")
	var maxFrameSize:Int;
}

@:include('audio/stb_vorbis.h')
@:native("stb_vorbis_comment")
@:structAccess
extern class VorbisComment {
	@:native("vendor")
	var vendor:CastCharStar;

	@:native("comment_list_length")
	var commentListLength:Int;
	@:native("max_frame_size")
	var commentList:RawPointer<CastCharStar>;
}

@:include('audio/stb_vorbis.h')
@:native("stb_vorbis")
@:structAccess
extern class StbVorbisData {
	@:native("sample_rate")
	var sampleRate:cpp.UInt32;
	@:native("channels")
	var channels:Int;

	@:native("setup_memory_required")
	var setupMemoryRequired:cpp.UInt32;
	@:native("temp_memory_required")
	var tempMemoryRequired:cpp.UInt32;
	@:native("setup_temp_memory_required")
	var setupTempMemoryRequired:cpp.UInt32;

	@:native("vendor")
	var vendor:CastCharStar;
	@:native("comment_list_length")
	var commentListLength:Int;
	@:native("comment_list")
	var commentList:RawPointer<CastCharStar>;

	@:native("f")
	var file:FILE;
	@:native("f_start")
	var fileStart:cpp.UInt32;
	@:native("close_on_free")
	var closeOnFree:Int;

	@:native("stream")
	var stream:RawPointer<cpp.UInt8>;
	@:native("stream_start")
	var streamStart:RawPointer<cpp.UInt8>;
	@:native("stream_end")
	var streamEnd:RawPointer<cpp.UInt8>;

	@:native("stream_len")
	var streamLength:cpp.UInt32;
	@:native("push_mode")
	var pushMode:cpp.UInt8;

	@:native("first_audio_page_offset")
	var firstAudioPageOffset:cpp.UInt32;
	@:native("p_first")
	var firstPage:ProbedPage;
	@:native("p_last")
	var lastProbedPage:ProbedPage;

	@:native("alloc")
	var alloc:VorbisAlloc;
	@:native("setup_offset")
	var setupOffset:Int;
	@:native("temp_offset")
	var tempOffset:Int;

	@:native("eof")
	var eof:Int;
	@:native("error")
	var error:VorbisError;

	@:native("blocksize")
	var blockSize:RawPointer<Int>;
	@:native("blocksize_0")
	var blockSize0:Int;
	@:native("blocksize_1")
	var blockSize1:Int;
	@:native("codebook_count")
	var codebookCount:Int;
	@:native("codebooks")
	var codebooks:RawPointer<Codebook>;
	@:native("floor_count")
	var floorCount:Int;
	@:native("floor_types")
	var floorTypes:RawPointer<cpp.UInt16>;
	@:native("floor_config")
	var floorConfig:RawPointer<Floor>;
	@:native("residue_count")
	var residueCount:Int;
	@:native("residue_types")
	var residueTypes:RawPointer<cpp.UInt16>;
	@:native("residue_config")
	var residueConfig:RawPointer<Residue>;
	@:native("mappingcount")
	var mappingCount:Int;
	@:native("mapping")
	var mapping:RawPointer<Mapping>;
	@:native("mode_count")
	var modeCount:Int;
	@:native("mode_config")
	var modeConfig:RawPointer<VorbisMode>;

	@:native("total_samples")
	var totalSamples:cpp.UInt32;

	@:native("channel_buffers")
	var channelBuffers:RawPointer<RawPointer<Float>>;
	@:native("outputs")
	var outputs:RawPointer<RawPointer<Float>>;

	@:native("previous_window")
	var previousWindow:RawPointer<RawPointer<Float>>;
	@:native("previous_length")
	var previousLength:Int;

	@:native("finalY")
	var finalY:RawPointer<RawPointer<cpp.Int16>>;

	@:native("current_loc")
	var currentLoc:cpp.UInt32;
	@:native("current_loc_valid")
	var currentLocValid:Int;

	@:native("A")
	var twiddleFactorA:RawPointer<RawPointer<Float>>;
	@:native("B")
	var twiddleFactorB:RawPointer<RawPointer<Float>>;
	@:native("C")
	var twiddleFactorC:RawPointer<RawPointer<Float>>;
	@:native("window")
	var window:RawPointer<RawPointer<Float>>;
	@:native("bit_reverse")
	var bitReverse:RawPointer<RawPointer<cpp.UInt16>>;

	@:native("serial")
	var serial:cpp.UInt32;
	@:native("last_page")
	var lastPage:Int;
	@:native("segment_count")
	var segmentCount:Int;
	@:native("segments")
	var segments:RawPointer<cpp.UInt8>;
	@:native("page_flag")
	var pageFlag:cpp.UInt8;
	@:native("bytes_in_seg")
	var bytesInSegment:cpp.UInt8;
	@:native("first_decode")
	var firstDecode:cpp.UInt8;
	@:native("next_seg")
	var nextSegment:Int;
	@:native("last_seg")
	var lastSegment:Int;
	@:native("last_seg_which")
	var lastSegWhich:Int;
	@:native("acc")
	var acc:cpp.UInt32;
	@:native("valid_bits")
	var validBits:Int;
	@:native("packet_bytes")
	var packetBytes:Int;
	@:native("eng_seg_with_known_loc")
	var endSegWithKnownLoc:Int;
	@:native("known_loc_for_packet")
	var knownLocForPacket:cpp.UInt32;
	@:native("discard_samples_deferred")
	var discardSamplesDeferred:Int;
	@:native("samples_output")
	var samplesOutput:cpp.UInt32;

	@:native("page_crc_tests")
	var pageCRCTests:Int;
	@:native("scan")
	var scan:RawPointer<CRCScan>;

	@:native("channel_buffer_start")
	var channelBufferStart:Int;
	@:native("channel_buffer_end")
	var channelBufferEnd:Int;
}
typedef VorbisData = RawPointer<StbVorbisData>;

@:include('audio/stb_vorbis.h')
extern class StbVorbis {
	@:native("stb_vorbis_get_info")
	static function getInfo(data:VorbisData):VorbisInfo;
	
	@:native("stb_vorbis_get_comment")
	static function getComment(data:VorbisData):VorbisComment;

	@:native("stb_vorbis_get_error")
	static function getError(data:VorbisData):Int;

	@:native("stb_vorbis_close")
	static function close(data:VorbisData):Void;

	@:native("stb_vorbis_get_sample_offset")
	static function getSampleOffset(data:VorbisData):Int;
	
	@:native("stb_vorbis_get_file_offset")
	static function getFileOffset(data:VorbisData):cpp.UInt32;

	@:native("stb_vorbis_open_pushdata")
	static function openPushdata(dataBlock:RawPointer<cpp.UInt8>, dataBlockLengthInBytes:Int, dataBlockMemoryConsumedInBytes:Int, error:Int, allocBuffer:RawPointer<VorbisAlloc>):VorbisData;

	@:native("stb_vorbis_decode_frame_pushdata")
	static function decodeFramePushdata(data:VorbisData, dataBlock:RawPointer<cpp.UInt8>, dataBlockLengthInBytes:Int, channels:RawPointer<Int>, output:RawPointer<RawPointer<RawPointer<Float>>>, samples:RawPointer<Int>):Int;

	@:native("stb_vorbis_flush_pushdata")
	static function flushPushdata(data:VorbisData):Void;

	@:native('stb_vorbis_decode_filename')
	static function decodeFileName(fileName:cpp.ConstCharStar, channels:cpp.RawPointer<Int>, sampleRate:cpp.RawPointer<Int>,
		output:RawPointer<cpp.RawPointer<cpp.Int16>>):Int;

	@:native('stb_vorbis_decode_memory')
	static function decodeMemory(mem:RawPointer<cpp.UInt8>, length:Int, channels:cpp.RawPointer<Int>, sampleRate:cpp.RawPointer<Int>,
		output:cpp.RawPointer<cpp.RawPointer<cpp.Int16>>):Int;

	@:native('stb_vorbis_open_filename')
	static function openFileName(fileName:cpp.ConstCharStar, error:RawPointer<Int>, allocBuffer:RawPointer<VorbisAlloc>):VorbisData;

	@:native('stb_vorbis_open_memory')
	static function openMemory(mem:RawPointer<cpp.UInt8>, length:Int, error:RawPointer<Int>, allocBuffer:RawPointer<VorbisAlloc>):VorbisData;

	@:native("stb_vorbis_seek_frame")
	static function seekFrame(data:VorbisData, sampleNum:cpp.UInt32):Int;

	@:native("stb_vorbis_seek")
	static function seek(data:VorbisData, sampleNum:cpp.UInt32):Int;

	@:native("stb_vorbis_seek_start")
	static function seekStart(data:VorbisData):Int;

	@:native("stb_vorbis_stream_length_in_samples")
	static function streamLengthInSamples(data:VorbisData):cpp.UInt32;

	@:native("stb_vorbis_stream_length_in_seconds")
	static function streamLengthInSeconds(data:VorbisData):Float;

	@:native("stb_vorbis_get_frame_float")
	static function getFrameFloat(data:VorbisData, channels:RawPointer<Int>, output:RawPointer<RawPointer<RawPointer<Float>>>):Int;

	@:native("stb_vorbis_get_frame_short_interleaved")
	static function getFrameShortInterleaved(data:VorbisData, numChannels:Int, buffer:RawPointer<cpp.Int16>, numShorts:Int):Int;

	@:native("stb_vorbis_get_frame_short")
	static function getFrameShort(data:VorbisData, numChannels:Int, buffer:RawPointer<RawPointer<cpp.UInt16>>, numSamples:Int):Int;

	@:native("stb_vorbis_get_samples_float_interleaved")
	static function getSamplesFloatInterleaved(data:VorbisData, numChannels:Int, buffer:RawPointer<Float>, numShorts:Int):Int;

	@:native("stb_vorbis_get_samples_float")
	static function getSamplesFloat(data:VorbisData, numChannels:Int, buffer:RawPointer<RawPointer<Float>>, numSamples:Int):Int;

	@:native("stb_vorbis_get_samples_short_interleaved")
	static function getSamplesShortInterleaved(data:VorbisData, channels:Int, buffer:RawPointer<cpp.Int16>, numShorts:Int):Int;

	@:native("stb_vorbis_get_samples_short")
	static function getSamplesShort(data:VorbisData, channels:Int, buffer:RawPointer<RawPointer<cpp.UInt16>>, numSamples:Int):Int;
}
