package blueprint.sound;

import cpp.Pointer;

import bindings.AL;
import bindings.StbVorbis;
import bindings.DrWav;
import bindings.CppHelpers;

class SoundData {
	static var soundCache:Map<String, SoundData> = [];

	var _cacheKey:Null<String>;
    public var path:String;
	public var loaded:Bool = false;
	public var buffer:cpp.UInt32 = 0;

    public function new(?filePath:String) {
        AL.genBuffers(1, cpp.Pointer.addressOf(buffer));

		if (filePath != null)
			loadFromFile(filePath);
    }

    public function loadFromFile(filePath:String) {
		path = filePath;
        filePath = sys.FileSystem.absolutePath(filePath);

        var format:Int = 0;
        var sampleData:cpp.Star<cpp.Int16> = null;
    
        var extension:String = filePath.substring(filePath.lastIndexOf('.') + 1).toLowerCase();

		switch (extension) {
			case 'wav':
				var channels:cpp.UInt32 = 0;
				var sampleRate:cpp.UInt32 = 0;
				var totalFrameCount:cpp.UInt64 = 0;
				sampleData = DrWav.openFileAndReadPCMFramesShort16(filePath, cpp.Pointer.addressOf(channels), cpp.Pointer.addressOf(sampleRate), cpp.Pointer.addressOf(totalFrameCount), null);

				if (sampleData == null) {
					Sys.println('Failed to load "$path": Sample Data was null.');
				} else {
					format = channels > 1 ? AL.FORMAT_STEREO16 : AL.FORMAT_MONO16;

					// I swear to god. Haxe (via hxcpp) is one of the most ANNOYING programming languages I have EVER had to deal with.
					// Seriously. Does it make ANY SENSE to ANYONE why a cpp.UInt64 ISN'T replaced with an "unsigned long long" OR EVEN an "unsigned long".
					// It just uses a stupid extra type which makes things more painful for the developer. ISTG porting dr_wav even MINORLY was H E L L because of this shit.
					// Like no joke, I feel like I could rip my hair out. I have to MANUALLY use UNTYPED CPP just to FUCKING GET THE LENGTH TOO.
					// Honestly I should've just wrote this whole function in cpp, but where is the fun in that y'know? Anyways, sorry for the ramble, hxcpp is just pain.
					// - MidnightBloxxer or something I guess.

					// also btw idk why we multiply by 4 and not 2 but 2 cuts it off half way so ig i missed something somewhere but whatever /shrug
					AL.bufferData(buffer, format, cast sampleData, untyped __cpp__('{0} * (unsigned long)(4)', totalFrameCount), cast sampleRate);
					loaded = true;
				}

				DrWav.free(cast sampleData, null);
			case 'ogg':
				var channels:Int = 0;
				var sampleRate:Int = 0;
				var totalFrameCount:Int = StbVorbis.decodeFileName(filePath, Pointer.addressOf(channels), Pointer.addressOf(sampleRate), cpp.RawPointer.addressOf(sampleData));

				format = channels > 1 ? AL.FORMAT_STEREO16 : AL.FORMAT_MONO16;

				AL.bufferData(buffer, format, cast sampleData, untyped __cpp__('{0} * (unsigned long)(4)', totalFrameCount), cast sampleRate);
				CppHelpers.free(cast sampleData);
				loaded = true;
			default:
				Sys.println('Failed to load "$path": Format $extension is currently unsupported.');
		}
    }

	public function destroy() {
		AL.deleteBuffers(1, cpp.Pointer.addressOf(buffer));

		if (_cacheKey != null)
			soundCache.remove(_cacheKey);
	}

	public static function getCachedSound(filePath:String) {
		if (!soundCache.exists(filePath)) {
			var data = new SoundData(filePath);
			if (!data.loaded) {
				data.destroy();
				data = null;
			} else
				data._cacheKey = filePath;
			soundCache.set(filePath, data);
		}

		return soundCache[filePath];
	}
}