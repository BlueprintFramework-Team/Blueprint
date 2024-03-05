package bindings.audio;

import cpp.RawPointer;

// this is basically just DrWav.hx lmao but flac
// - what-is-a-git

@:include('audio/DrFLAC.h')
extern class DrFLAC {
	@:native('drflac_open_file_and_read_pcm_frames_s16')
	static function openFileAndReadPCMFramesShort16(fileName:cpp.ConstCharStar, channels:cpp.RawPointer<cpp.UInt32>, sampleRate:cpp.RawPointer<cpp.UInt32>,
		totalFrameCount:cpp.RawPointer<DrFLACUInt64>, allocationCallbacks:RawPointer<DrFLACAllocationCallbacks>):cpp.RawPointer<cpp.Int16>;

	inline static function free(data:Any, allocationCallbacks:cpp.RawPointer<DrFLACAllocationCallbacks>):Void {
		untyped __cpp__('drflac_free({0}, {1})', data, allocationCallbacks);
	}
}

@:include('audio/DrFLAC.h')
@:native('drflac_allocation_callbacks')
@:structAccess
extern class DrFLACAllocationCallbacks {
	var userData:Any;

	var onMalloc:Any;
	var onRealloc:Any;
	var onFree:Any;
}

/**
 * I love making new abstract types that aren't copied from cpp.SizeT! :3
 * @author what-is-a-git
 */
 @:native("long long unsigned int")
 @:scalar @:coreType @:notNull
 extern abstract DrFLACUInt64 from(Int) to(Int) {}
