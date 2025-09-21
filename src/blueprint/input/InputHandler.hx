package blueprint.input;

import bindings.Glfw;
import blueprint.Game;
import ThreadHelper;

@:allow(blueprint.Game)
class InputHandler {
	public static final keyNames:Map<Int, String> = blueprint.Macros.fieldsToMap("bindings.Glfw", "KEY_", true);
	public static final keyValues:Map<String, Int> = blueprint.Macros.fieldsToMap("bindings.Glfw", "KEY_", false);

	public static final keyPressed:Signal<Int->Int->Int->Void> = new Signal();
	public static final keyRepeated:Signal<Int->Int->Int->Void> = new Signal();
	public static final keyReleased:Signal<Int->Int->Int->Void> = new Signal();

	public static final mousePressed:Signal<Int->Void> = new Signal();
	public static final mouseReleased:Signal<Int->Void> = new Signal();
	public static final mouseScrolled:Signal<Float->Float->Void> = new Signal();
	public static final charInputted:Signal<String->cpp.UInt32->Int->Void> = new Signal();
	
	// originally for multithreading input, currently scrapped because the main thread took that job and the main thread NEEDS pollEvents.
	static function updateInputs(runTime:Float):ThreadLoopFlag {
		Glfw.pollEvents();
        return CONTINUE_THREAD;
    }

	static function charInput(window:GlfwWindow, code:cpp.UInt32, mods:Int) {
		ThreadHelper.mutex.acquire();
		Glfw.makeContextCurrent(Game.window.cWindow);
		charInputted.emit(String.fromCharCode(code), code, mods);
		Glfw.makeContextCurrent(null);
		ThreadHelper.mutex.release();
	}

	static function scrollInput(window:GlfwWindow, xOff:Float, yOff:Float) {
		ThreadHelper.mutex.acquire();
		Glfw.makeContextCurrent(Game.window.cWindow);
		mouseScrolled.emit(yOff, xOff); // people are prob gonna prioritize y (who uses x)
		Glfw.makeContextCurrent(null);
		ThreadHelper.mutex.release();
	}

	static function mouseInput(window:GlfwWindow, button:Int, action:Int, mods:Int) {
		ThreadHelper.mutex.acquire();
		Glfw.makeContextCurrent(Game.window.cWindow);
		switch (action) {
			case Glfw.PRESS:
				mousePressed.emit(button);

				for (scene in Game.plugins) {
					if (scene.takeInput)
						scene.mouseDown(button);
				}

				if (Game.topScene.takeInput)
					Game.topScene.mouseUp(button);
			case Glfw.RELEASE:
				mouseReleased.emit(button);

				for (scene in Game.plugins) {
					if (scene.takeInput)
						scene.mouseUp(button);
				}

				if (Game.topScene.takeInput)
					Game.topScene.mouseUp(button);
		}
		Glfw.makeContextCurrent(null);
		ThreadHelper.mutex.release();
	}

    static function keyInput(window:GlfwWindow, key:Int, scancode:Int, action:Int, mods:Int) {
		ThreadHelper.mutex.acquire();
		Glfw.makeContextCurrent(Game.window.cWindow);
		switch (action) {
			case Glfw.PRESS:
				keyPressed.emit(key, scancode, mods);

				for (scene in Game.plugins) {
					if (scene.takeInput)
						scene.keyDown(key, scancode, mods);
				}

				if (Game.topScene.takeInput)
					Game.topScene.keyDown(key, scancode, mods);
			case Glfw.REPEAT:
				keyRepeated.emit(key, scancode, mods);

				for (scene in Game.plugins) {
					if (scene.takeInput)
						scene.keyRepeat(key, scancode, mods);
				}

				if (Game.topScene.takeInput)
					Game.topScene.keyRepeat(key, scancode, mods);
			case Glfw.RELEASE:
				keyReleased.emit(key, scancode, mods);

				for (scene in Game.plugins) {
					if (scene.takeInput)
						scene.keyUp(key, scancode, mods);
				}

				if (Game.topScene.takeInput)
					Game.topScene.keyUp(key, scancode, mods);
		}
		Glfw.makeContextCurrent(null);
		ThreadHelper.mutex.release();
	}
}