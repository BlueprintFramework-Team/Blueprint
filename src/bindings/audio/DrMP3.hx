package bindings.audio;

// this is basically just DrWav.hx lmao but mp3
// - what-is-a-git

@:include('audio/DrMP3.h')
extern class DrMP3 {
    @:native('drmp3_open_file_and_read_pcm_frames_s16')
    static function openFileAndReadPCMFramesShort16(fileName:cpp.ConstCharStar, config:cpp.RawPointer<DrMP3Config>,
        totalFrameCount:cpp.RawPointer<DrMP3UInt64>, allocationCallbacks:cpp.RawPointer<DrMP3AllocationCallbacks>):cpp.RawPointer<cpp.Int16>;
    
    inline static function free(data:Any, allocationCallbacks:cpp.RawPointer<DrMP3AllocationCallbacks>):Void {
        untyped __cpp__('drmp3_free({0}, {1})', data, allocationCallbacks);
    }
}

@:include('audio/DrMP3.h')
@:native('drmp3_allocation_callbacks')
@:structAccess
extern class DrMP3AllocationCallbacks {
	var userData:Any;

	var onMalloc:Any;
	var onRealloc:Any;
	var onFree:Any;
}

@:include('audio/DrMP3.h')
@:native('drmp3_config')
@:structAccess
extern class DrMP3Config {
    var channels:cpp.UInt32;
    var sampleRate:cpp.UInt32;
}

/**
 * I love making new abstract types that aren't copied from cpp.SizeT! :3
 * @author what-is-a-git
 */
@:native("long long unsigned int")
@:scalar @:coreType @:notNull
extern abstract DrMP3UInt64 from(Int) to(Int) {}