package blueprint;

import blueprint.objects.Camera;

class Scene extends blueprint.objects.Group {
    public var mainCamera:Camera;

    public function new() {
        super();
        
        if (Game.currentScene == null)
            Game.currentScene = this;

        mainCamera = new Camera();
        cameras = [mainCamera];
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
}