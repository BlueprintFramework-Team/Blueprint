package;

import blueprint.Game;
import blueprint.Scene;
import blueprint.sound.Sound;
import bindings.Glfw;

class DemoScene extends Scene {
	var song:Sound;

	public function new() {
		super();

		song = new Sound('assets/music/life_of_riley.ogg', false, false, 0.5, 10);
		song.play();
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		if (!song.playing) {
			Game.queueClose();
		}
	}
}
