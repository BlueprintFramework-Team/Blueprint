package blueprint.input;

import bindings.Glfw;
import blueprint.Game;
import ThreadHelper;

@:allow(blueprint.Game)
class InputHandler {
	public static final keyNames:Map<Int, String> = blueprint.Macros.fieldsToMap("bindings.Glfw", "KEY_", true);
	public static final keyValues:Map<String, Int> = blueprint.Macros.fieldsToMap("bindings.Glfw", "KEY_", false);
	
	// originally for multithreading input, currently scrapped because the main thread took that job and the main thread NEEDS pollEvents.
	static function updateInputs(runTime:Float):ThreadLoopFlag {
		Glfw.pollEvents();
        return CONTINUE_THREAD;
    }

    static function keyInput(window:GlfwWindow, key:Int, scancode:Int, action:Int, mods:Int) {
		ThreadHelper.mutex.acquire();
		Glfw.makeContextCurrent(Game.window.cWindow);
		switch (action) {
			case Glfw.PRESS: Game.currentScene.keyDown(key, scancode, mods);
			case Glfw.REPEAT: Game.currentScene.keyRepeat(key, scancode, mods);
			case Glfw.RELEASE: Game.currentScene.keyUp(key, scancode, mods);
		}
		Glfw.makeContextCurrent(null);
		ThreadHelper.mutex.release();
	}
}