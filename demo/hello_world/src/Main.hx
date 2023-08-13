package;

import blueprint.Game;

class Main {
	public static var game:Game;

	public static function main():Void {
		// Width, Height, Scene (Class, not Scene instance)
		game = new Game(640, 480, HelloWorld);
	}
}
