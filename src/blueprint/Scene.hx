package blueprint;

import blueprint.objects.Camera;

class Scene extends blueprint.objects.Group {
	public var mainCamera:Camera;
	public var takeInput:Bool = true;

	public function new() {
		super();
		
		if (Game.topScene == null)
			Game.topScene = this;

		mainCamera = new Camera();
		cameras = [mainCamera];
	}

	override function destroy() {
		super.destroy();

		if (Game.sceneStack.contains(this))
			Game.sceneStack.remove(this);
		if (Game.plugins.contains(this))
			Game.plugins.remove(this);
	}

	/**
	 * This function is called when a key has just been pressed.
	 * @param keyCode The keyboard key that was pressed.
	 * @param scanCode The system-specific scancode of the key.
	 * @param mods Bit field describing which modifier keys were held down.
	 */
	public function keyDown(keyCode:Int, scanCode:Int, mods:Int) {}

	/**
	 * This function is called when the computer starts inputting key holds.
	 * @param keyCode The keyboard key that was held.
	 * @param scanCode The system-specific scancode of the key.
	 * @param mods Bit field describing which modifier keys were held down.
	 */
	public function keyRepeat(keyCode:Int, scanCode:Int, mods:Int) {}

	/**
	 * This function is called when a key has just been released.
	 * @param keyCode The keyboard key that was released.
	 * @param scanCode The system-specific scancode of the key.
	 * @param mods Bit field describing which modifier keys were held down.
	 */
	public function keyUp(keyCode:Int, scanCode:Int, mods:Int) {}

	/**
	 * This function is called when the mouse just pushed a button down.
	 * @param button The index of what mouse button was pressed.
	 */
	public function mouseDown(button:Int) {}

	/**
	 * This function is called when the mouse just lifted a button up.
	 * @param button The index of what mouse button was released.
	 */
	public function mouseUp(button:Int) {}
}