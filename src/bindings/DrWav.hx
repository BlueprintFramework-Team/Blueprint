package bindings;

// super not finished, but they don't have to be finished because abstraction <3
// - MidnightBloxxer

@:include('dr_wav.h')
extern class DrWav {
	@:native('drwav_open_file_and_read_pcm_frames_s16')
	static function openFileAndReadPCMFramesShort16(fileName:cpp.ConstCharStar, channels:cpp.Pointer<cpp.UInt32>, sampleRate:cpp.Pointer<cpp.UInt32>,
		totalFrameCount:cpp.Pointer<cpp.UInt64>, allocationCallbacks:cpp.ConstPointer<DrWavAllocationCallbacks>):cpp.Pointer<cpp.Int16>;

	@:native('drwav_free')
	static function free(data:cpp.Pointer<cpp.Void>, allocationCallbacks:cpp.ConstPointer<DrWavAllocationCallbacks>):Void;
}

@:include('dr_wav.h')
@:native('drwav_allocation_callbacks')
@:structAccess
extern class DrWavAllocationCallbacks {
	var userData:cpp.Pointer<cpp.Void>;

	var onMalloc:cpp.Pointer<cpp.Void>;
	var onRealloc:cpp.Pointer<cpp.Void>;
	var onFree:cpp.Pointer<cpp.Void>;
}
