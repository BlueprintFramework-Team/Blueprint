package blueprint.sound;

import bindings.audio.StbVorbis;
import bindings.audio.DrWav;
import bindings.audio.DrFLAC;
import bindings.audio.DrMP3;
import bindings.audio.AL;
import bindings.CppHelpers;
import cpp.Pointer;

class SoundData {
	static var soundCache:Map<String, SoundData> = [];

	var _cacheKey:Null<String>;
	public var useCount:Int = 0;
    public var path:String;
	public var loaded:Bool = false;
	public var buffer:cpp.UInt32 = 0;
	public var length:Float = 0;

    public function new(?filePath:String) {
        AL.genBuffers(1, cpp.Pointer.addressOf(buffer));

		if (filePath != null)
			loadFromFile(filePath);
    }

    public function loadFromFile(filePath:String) {
		path = filePath;
        filePath = sys.FileSystem.absolutePath(filePath);
		if (!sys.FileSystem.exists(filePath)) {
            Sys.println('Failed to load "$path": File nonexistant.');
            return this;
        }

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
					AL.bufferData(buffer, format, sampleData, untyped __cpp__('{0} * (unsigned long)(4)', totalFrameCount), cast sampleRate);
					loaded = true;
				}

				DrWav.free(sampleData, null);
			case 'ogg':
				var channels:Int = 0;
				var sampleRate:Int = 0;
				var totalFrameCount:Int = StbVorbis.decodeFileName(filePath, Pointer.addressOf(channels), Pointer.addressOf(sampleRate), cpp.RawPointer.addressOf(sampleData));

				format = channels > 1 ? AL.FORMAT_STEREO16 : AL.FORMAT_MONO16;

				length = totalFrameCount / sampleRate;
				AL.bufferData(buffer, format, sampleData, untyped __cpp__('{0} * (unsigned long)(4)', totalFrameCount), sampleRate);
				CppHelpers.free(sampleData);
				loaded = true;
			case 'mp3':
				var config:cpp.Pointer<DrMP3Config> = null;
				untyped __cpp__('
					drmp3_config config_but_good;
					{0} = &config_but_good;
				', config);

				var totalFrameCount:DrMP3UInt64 = 0;
				sampleData = DrMP3.openFileAndReadPCMFramesShort16(filePath, config, cpp.Pointer.addressOf(totalFrameCount), null);

				if (sampleData == null) {
					Sys.println('Failed to load "$path": Sample Data was null.');
				} else {
					format = config.ref.channels > 1 ? AL.FORMAT_STEREO16 : AL.FORMAT_MONO16;
					AL.bufferData(buffer, format, sampleData, untyped __cpp__('{0} * (unsigned long)(4)', totalFrameCount), cast config.ref.sampleRate);
					loaded = true;
				}

				DrMP3.free(sampleData, null);
			case 'flac' | 'oga':
				var channels:cpp.UInt32 = 0;
				var sampleRate:cpp.UInt32 = 0;
				var totalFrameCount:DrFLACUInt64 = 0;
				sampleData = DrFLAC.openFileAndReadPCMFramesShort16(filePath, cpp.Pointer.addressOf(channels), cpp.Pointer.addressOf(sampleRate), cpp.Pointer.addressOf(totalFrameCount), null);

				if (sampleData == null) {
					Sys.println('Failed to load "$path": Sample Data was null.');
				} else {
					format = channels > 1 ? AL.FORMAT_STEREO16 : AL.FORMAT_MONO16;

					AL.bufferData(buffer, format, sampleData, untyped __cpp__('{0} * (unsigned long)(4)', totalFrameCount), cast sampleRate);
					loaded = true;
				}

				DrFLAC.free(sampleData, null);
			default:
				Sys.println('Failed to load "$path": Format $extension is currently unsupported.');
		}

		return this;
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

	public static function clearCache() {
		for (key in soundCache.keys()) {
			if (soundCache[key] == null)
				soundCache.remove(key);
			else if (soundCache[key].useCount <= 0)
				soundCache[key].destroy();
		}
	}
}