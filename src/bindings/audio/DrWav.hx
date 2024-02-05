package bindings.audio;

// super not finished, but they don't have to be finished because abstraction <3
// - what-is-a-git

@:include('audio/dr_wav.h')
extern class DrWav {
	@:native('drwav_open_file_and_read_pcm_frames_s16')
	static function openFileAndReadPCMFramesShort16(fileName:cpp.ConstCharStar, channels:cpp.Pointer<cpp.UInt32>, sampleRate:cpp.Pointer<cpp.UInt32>,
		totalFrameCount:cpp.Pointer<cpp.UInt64>, allocationCallbacks:cpp.ConstPointer<DrWavAllocationCallbacks>):cpp.Star<cpp.Int16>;

	inline static function free(data:Any, allocationCallbacks:cpp.ConstPointer<DrWavAllocationCallbacks>):Void {
		untyped __cpp__('drwav_free({0}, {1})', data, allocationCallbacks);
	}
}

@:include('audio/dr_wav.h')
@:native('drwav_allocation_callbacks')
@:structAccess
extern class DrWavAllocationCallbacks {
	var userData:Any;

	var onMalloc:Any;
	var onRealloc:Any;
	var onFree:Any;
}
