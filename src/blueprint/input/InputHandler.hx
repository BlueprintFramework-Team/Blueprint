package blueprint.input;

import bindings.Glfw;
import blueprint.Game;
import ThreadHelper.ThreadLoopFlag;

@:allow(blueprint.Game)
class InputHandler {
    static function updateInputs(runTime:Float):ThreadLoopFlag {
        Glfw.pollEvents();
        return CONTINUE_THREAD;
    }

    static function keyInput(window:GlfwWindow, key:Int, scancode:Int, action:Int, mods:Int) {
		switch (action) {
			case Glfw.PRESS: Game.currentScene.keyDown(key, scancode, mods);
			case Glfw.REPEAT: Game.currentScene.keyRepeat(key, scancode, mods);
			case Glfw.RELEASE: Game.currentScene.keyUp(key, scancode, mods);
		}
	}
}