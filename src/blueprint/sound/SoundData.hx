package blueprint.sound;

import blueprint.sound.formats.*;
import blueprint.sound.SoundPlayer;
import ThreadHelper.ThreadLoopFlag;

@:allow(blueprint.Game)
@:allow(blueprint.sound.SoundPlayer)
class SoundData {
	private static var curSounds:Array<SoundPlayer> = [];
	private static var lastSoundUpdate:Float = 0.0;
	private static var soundCache:Map<String, Array<AudioFormat>> = [];

	public static function getSoundData(filePath:String):AudioFormat {
		final hasCache = soundCache.exists(filePath);
		if (hasCache && soundCache[filePath].length > 0)
			return soundCache[filePath].shift();

		var data = switch (haxe.io.Path.extension(filePath)) {
			case "flac": 	new FlacFormat(filePath);
			case "mp3": 	new MP3Format(filePath);
			case "wav": 	new WavFormat(filePath);
			default: 		new OggFormat(filePath);
		}

		if (!data.loaded) {
			data.destroy();
			data = null;
		} else if (!hasCache)
			soundCache.set(filePath, []);

		return data;
	}

	private static function updateSounds(runTime:Float):ThreadLoopFlag {
		final elapsed = runTime - lastSoundUpdate;
		lastSoundUpdate = runTime;

		var i = 0;
		while (i < curSounds.length) {
			final sound = curSounds[i];
			if (sound.data == null || !sound.playing) {
				++i;
				continue;
			}

			final soundTime = sound.time;
			if (sound.looping && soundTime >= sound.length)
				sound.play(0.0);
			else if (soundTime >= sound.length) {
				sound.stop();
				sound.time = sound.length;
				sound.complete = true;
				sound.finished.emit(sound);
			}
			sound.update();

			if (curSounds.contains(sound))
				++i;
		}

		return CONTINUE_THREAD;
	}

	public static function clearSounds(?force:Bool = false) {
		var i:Int = 0; // So I have more control over the iterator. (Removing stuff can mess up for loops.)
		while (i < curSounds.length) {
			if (!force && curSounds[i].keepOnSwitch) {
				if (curSounds[i].data != null)
					soundCache[curSounds[i].data.path].push(null);
				i++;
			} else 
				curSounds[i].destroy();
		}
	}

	public static function clearCache(?force:Bool = false) {
		for (key in soundCache.keys()) {
			final cache = soundCache[key];

			var i = 0;
			while (i < cache.length) {
				if (!force && (cache[i] == null || cache[i].keepOnSwitch)) {
					++i;
				} else if (cache[i] != null) {
					cache[i].destroy();
					cache.splice(i, 1);
				}
			}

			if (force || cache.length <= 0)
				soundCache.remove(key);
			else if (cache.contains(null))
				cache.remove(null);
		}
	}
}