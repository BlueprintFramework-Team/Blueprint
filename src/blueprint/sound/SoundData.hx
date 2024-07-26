package blueprint.sound;

import blueprint.sound.formats.*;
import blueprint.sound.SoundPlayer;
import ThreadHelper.ThreadLoopFlag;

@:allow(blueprint.Game)
@:allow(blueprint.sound.SoundPlayer)
class SoundData {
	private static var curSounds:Array<SoundPlayer> = [];
	private static var lastSoundUpdate:Float = 0.0;

	public static function getSoundData(filePath:String):AudioFormat {
		var data = switch (haxe.io.Path.extension(filePath)) {
			case "flac": 	new FlacFormat(filePath);
			case "mp3": 	new MP3Format(filePath);
			case "wav": 	new WavFormat(filePath);
			default: 		new OggFormat(filePath);
		}

		if (!data.loaded) {
			data.destroy();
			data = null;
		}

		return data;
	}

	private static function updateSounds(runTime:Float):ThreadLoopFlag {
		final elapsed = runTime - lastSoundUpdate;
		lastSoundUpdate = runTime;

		for (sound in curSounds) {
			if (sound.data == null || !sound.playing) continue;

			var soundTime = sound.time;
			if (sound.looping && soundTime >= sound.length)
				sound.play(0.0);
			else if (soundTime >= sound.length) {
				sound.stop();
				sound.time = sound.length;
				sound.complete = true;
				sound.finished.emit(sound);
			}
			sound.update();
		}

		return CONTINUE_THREAD;
	}

	public static function clearSounds() {
		var i:Int = 0; // So I have more control over the iterator. (Removing stuff can mess up for loops.)
		while (i < curSounds.length) {
			if (curSounds[i].keepOnSwitch)
				i++;
			else
				curSounds[i].destroy();
		}
	}
}