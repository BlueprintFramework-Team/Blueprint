package blueprint;

class Scene extends blueprint.objects.Group {
    public function new() {
        super();
    }

    /**
     * This function is called when a key has just been pressed.
     * @param keyCode The keyboard key that was pressed or released.
     * @param scanCode The system-specific scancode of the key.
     * @param mods Bit field describing which modifier keys were held down.
     */
    public function keyDown(keyCode:Int, scanCode:Int, mods:Int) {}

    /**
     * This function is called when a key has just been released.
     * @param keyCode The keyboard key that was pressed or released.
     * @param scanCode The system-specific scancode of the key.
     * @param mods Bit field describing which modifier keys were held down.
     */
    public function keyUp(keyCode:Int, scanCode:Int, mods:Int) {}
}