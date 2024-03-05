package bindings;

#if !macro
import cpp.RawPointer;
import cpp.Callable;
import cpp.ConstCharStar;

@:include("includeWorkaround.h")
@:native("GLFWmonitor")
@:structAccess
extern class GlfwMonitorStruct {}
typedef GlfwMonitor = RawPointer<GlfwMonitorStruct>;

@:include("includeWorkaround.h")
@:native("GLFWwindow")
@:structAccess
extern class GlfwWindowStruct {}
typedef GlfwWindow = RawPointer<GlfwWindowStruct>;

@:include("includeWorkaround.h")
@:native("GLFWcursor")
@:structAccess
extern class GlfwCursorStruct {}
typedef GlfwCursor = RawPointer<GlfwCursorStruct>;

@:include("includeWorkaround.h")
@:native("GLFWvidmode")
@:structAccess
extern class GlfwVidMode {
    var width:Int;
    var height:Int;
    var redBits:Int;
    var greenBits:Int;
    var blueBits:Int;
    var refreshRate:Int;
}
typedef VideoMode = RawPointer<GlfwVidMode>;

@:include("includeWorkaround.h")
@:native("GLFWgammaramp")
@:structAccess
extern class GlfwGammaRamp {
    var red:UInt;
    var green:UInt;
    var blue:UInt;
    var size:UInt;
}
typedef GammaRamp = RawPointer<GlfwGammaRamp>;

@:include("includeWorkaround.h")
@:native("GLFWimage")
@:structAccess
extern class GflwImageStruct {
    var width:Int;
    var height:Int;
    var pixels:RawPointer<Int>;
}
typedef GlfwImage = RawPointer<GflwImageStruct>;

@:include("includeWorkaround.h")
@:native("GLFWgamepadstate")
@:structAccess
extern class GlfwGamepadState {
    var buttons:Array<cpp.UInt8>;
    var axes:Array<Float>;
}
typedef GamepadState = RawPointer<GlfwGamepadState>;

typedef ErrorFunc = Callable<(errorCode:Int, description:ConstCharStar) -> Void>;
typedef WindowPosFunc = Callable<(window:GlfwWindow, xPos:Int, yPos:Int) -> Void>;
typedef WindowSizeFunc = Callable<(window:GlfwWindow, width:Int, height:Int) -> Void>;
typedef WindowCloseFunc = Callable<(window:GlfwWindow) -> Void>;
typedef WindowRefreshFunc = Callable<(window:GlfwWindow) -> Void>;
typedef WindowFocusFunc = Callable<(window:GlfwWindow, focused:Bool) -> Void>;
typedef WindowIconifyFunc = Callable<(window:GlfwWindow, iconified:Bool) -> Void>;
typedef WindowMaximizeFunc = Callable<(window:GlfwWindow, maximized:Bool) -> Void>;
typedef FrameBufferSizeFunc = Callable<(window:GlfwWindow, width:Int, height:Int) -> Void>;
typedef WindowContentScaleFunc = Callable<(window:GlfwWindow, xScale:Float, yScale:Float) -> Void>;
typedef MouseButtonFunc = Callable<(window:GlfwWindow, button:Int, action:Int, mods:Int) -> Void>;
typedef CursorPosFunc = Callable<(window:GlfwWindow, xPos:Float, yPos:Float) -> Void>;
typedef CursorEnterFunc = Callable<(window:GlfwWindow, entered:Int) -> Void>;
typedef ScrollFunc = Callable<(window:GlfwWindow, xOffset:Float, yOffset:Float) -> Void>;
typedef KeyInputFunc = Callable<(window:GlfwWindow, key:Int, scancode:Int, action:Int, mods:Int) -> Void>;
typedef CharFunc = Callable<(window:GlfwWindow, codepoint:UInt) -> Void>;
typedef CharModsFunc = Callable<(window:GlfwWindow, codepoint:UInt, mods:Int) -> Void>;
typedef FileDropFunc = Callable<(window:GlfwWindow, pathCount:Int, paths:Array<ConstCharStar>) -> Void>;
typedef MonitorFunc = Callable<(monitor:GlfwMonitor, event:Int) -> Void>;
typedef JoystickFunc = Callable<(joystickID:Int, event:Int) -> Void>;

@:buildXml("<include name='${haxelib:blueprint}/src/Build.xml'/>")
@:include("includeWorkaround.h")
extern class Glfw {
	@:native("GLFW_VERSION_MAJOR")
	static final VERSION_MAJOR:Int;
	@:native("GLFW_VERSION_MINOR")
	static final VERSION_MINOR:Int;
	@:native("GLFW_VERSION_REVISION")
	static final VERSION_REVISION:Int;

	@:native("GLFW_TRUE")
	static final TRUE:Int;
	@:native("GLFW_FALSE")
	static final FALSE:Int;

	@:native("GLFW_RELEASE")
	static final RELEASE:Int;
	@:native("GLFW_PRESS")
	static final PRESS:Int;
	@:native("GLFW_REPEAT")
	static final REPEAT:Int;

	@:native("GLFW_HAT_CENTERED")
	static final HAT_CENTERED:Int;
	@:native("GLFW_HAT_UP")
	static final HAT_UP:Int;
	@:native("GLFW_HAT_RIGHT")
	static final HAT_RIGHT:Int;
	@:native("GLFW_HAT_DOWN")
	static final HAT_DOWN:Int;
	@:native("GLFW_HAT_LEFT")
	static final HAT_LEFT:Int;
	@:native("GLFW_HAT_RIGHT_UP")
	static final HAT_RIGHT_UP:Int;
	@:native("GLFW_HAT_RIGHT_DOWN")
	static final HAT_RIGHT_DOWN:Int;
	@:native("GLFW_HAT_LEFT_UP")
	static final HAT_LEFT_UP:Int;
	@:native("GLFW_HAT_LEFT_DOWN")
	static final HAT_LEFT_DOWN:Int;

	@:native("GLFW_KEY_UNKNOWN")
	static final KEY_UNKNOWN:Int;
	@:native("GLFW_KEY_SPACE")
	static final KEY_SPACE:Int;
	@:native("GLFW_KEY_APOSTROPHE")
	static final KEY_APOSTROPHE:Int;
	@:native("GLFW_KEY_COMMA")
	static final KEY_COMMA:Int;
	@:native("GLFW_KEY_MINUS")
	static final KEY_MINUS:Int;
	@:native("GLFW_KEY_PERIOD")
	static final KEY_PERIOD:Int;
	@:native("GLFW_KEY_SLASH")
	static final KEY_SLASH:Int;
	@:native("GLFW_KEY_0")
	static final KEY_0:Int;
	@:native("GLFW_KEY_1")
	static final KEY_1:Int;
	@:native("GLFW_KEY_2")
	static final KEY_2:Int;
	@:native("GLFW_KEY_3")
	static final KEY_3:Int;
	@:native("GLFW_KEY_4")
	static final KEY_4:Int;
	@:native("GLFW_KEY_5")
	static final KEY_5:Int;
	@:native("GLFW_KEY_6")
	static final KEY_6:Int;
	@:native("GLFW_KEY_7")
	static final KEY_7:Int;
	@:native("GLFW_KEY_8")
	static final KEY_8:Int;
	@:native("GLFW_KEY_9")
	static final KEY_9:Int;
	@:native("GLFW_KEY_SEMICOLON")
	static final KEY_SEMICOLON:Int;
	@:native("GLFW_KEY_EQUAL")
	static final KEY_EQUAL:Int;
	@:native("GLFW_KEY_A")
	static final KEY_A:Int;
	@:native("GLFW_KEY_B")
	static final KEY_B:Int;
	@:native("GLFW_KEY_C")
	static final KEY_C:Int;
	@:native("GLFW_KEY_D")
	static final KEY_D:Int;
	@:native("GLFW_KEY_E")
	static final KEY_E:Int;
	@:native("GLFW_KEY_F")
	static final KEY_F:Int;
	@:native("GLFW_KEY_G")
	static final KEY_G:Int;
	@:native("GLFW_KEY_H")
	static final KEY_H:Int;
	@:native("GLFW_KEY_I")
	static final KEY_I:Int;
	@:native("GLFW_KEY_J")
	static final KEY_J:Int;
	@:native("GLFW_KEY_K")
	static final KEY_K:Int;
	@:native("GLFW_KEY_L")
	static final KEY_L:Int;
	@:native("GLFW_KEY_M")
	static final KEY_M:Int;
	@:native("GLFW_KEY_N")
	static final KEY_N:Int;
	@:native("GLFW_KEY_O")
	static final KEY_O:Int;
	@:native("GLFW_KEY_P")
	static final KEY_P:Int;
	@:native("GLFW_KEY_Q")
	static final KEY_Q:Int;
	@:native("GLFW_KEY_R")
	static final KEY_R:Int;
	@:native("GLFW_KEY_S")
	static final KEY_S:Int;
	@:native("GLFW_KEY_T")
	static final KEY_T:Int;
	@:native("GLFW_KEY_U")
	static final KEY_U:Int;
	@:native("GLFW_KEY_V")
	static final KEY_V:Int;
	@:native("GLFW_KEY_W")
	static final KEY_W:Int;
	@:native("GLFW_KEY_X")
	static final KEY_X:Int;
	@:native("GLFW_KEY_Y")
	static final KEY_Y:Int;
	@:native("GLFW_KEY_Z")
	static final KEY_Z:Int;
	@:native("GLFW_KEY_LEFT_BRACKET")
	static final KEY_LEFT_BRACKET:Int;
	@:native("GLFW_KEY_BACKSLASH")
	static final KEY_BACKSLASH:Int;
	@:native("GLFW_KEY_RIGHT_BRACKET")
	static final KEY_RIGHT_BRACKET:Int;
	@:native("GLFW_KEY_GRAVE_ACCENT")
	static final KEY_GRAVE_ACCENT:Int;
	@:native("GLFW_KEY_WORLD_1")
	static final KEY_WORLD_1:Int;
	@:native("GLFW_KEY_WORLD_2")
	static final KEY_WORLD_2:Int;
	@:native("GLFW_KEY_ESCAPE")
	static final KEY_ESCAPE:Int;
	@:native("GLFW_KEY_ENTER")
	static final KEY_ENTER:Int;
	@:native("GLFW_KEY_TAB")
	static final KEY_TAB:Int;
	@:native("GLFW_KEY_BACKSPACE")
	static final KEY_BACKSPACE:Int;
	@:native("GLFW_KEY_INSERT")
	static final KEY_INSERT:Int;
	@:native("GLFW_KEY_DELETE")
	static final KEY_DELETE:Int;
	@:native("GLFW_KEY_RIGHT")
	static final KEY_RIGHT:Int;
	@:native("GLFW_KEY_LEFT")
	static final KEY_LEFT:Int;
	@:native("GLFW_KEY_DOWN")
	static final KEY_DOWN:Int;
	@:native("GLFW_KEY_UP")
	static final KEY_UP:Int;
	@:native("GLFW_KEY_PAGE_UP")
	static final KEY_PAGE_UP:Int;
	@:native("GLFW_KEY_PAGE_DOWN")
	static final KEY_PAGE_DOWN:Int;
	@:native("GLFW_KEY_HOME")
	static final KEY_HOME:Int;
	@:native("GLFW_KEY_END")
	static final KEY_END:Int;
	@:native("GLFW_KEY_CAPS_LOCK")
	static final KEY_CAPS_LOCK:Int;
	@:native("GLFW_KEY_SCROLL_LOCK")
	static final KEY_SCROLL_LOCK:Int;
	@:native("GLFW_KEY_NUM_LOCK")
	static final KEY_NUM_LOCK:Int;
	@:native("GLFW_KEY_PRINT_SCREEN")
	static final KEY_PRINT_SCREEN:Int;
	@:native("GLFW_KEY_PAUSE")
	static final KEY_PAUSE:Int;
	@:native("GLFW_KEY_F1")
	static final KEY_F1:Int;
	@:native("GLFW_KEY_F2")
	static final KEY_F2:Int;
	@:native("GLFW_KEY_F3")
	static final KEY_F3:Int;
	@:native("GLFW_KEY_F4")
	static final KEY_F4:Int;
	@:native("GLFW_KEY_F5")
	static final KEY_F5:Int;
	@:native("GLFW_KEY_F6")
	static final KEY_F6:Int;
	@:native("GLFW_KEY_F7")
	static final KEY_F7:Int;
	@:native("GLFW_KEY_F8")
	static final KEY_F8:Int;
	@:native("GLFW_KEY_F9")
	static final KEY_F9:Int;
	@:native("GLFW_KEY_F10")
	static final KEY_F10:Int;
	@:native("GLFW_KEY_F11")
	static final KEY_F11:Int;
	@:native("GLFW_KEY_F12")
	static final KEY_F12:Int;
	@:native("GLFW_KEY_F13")
	static final KEY_F13:Int;
	@:native("GLFW_KEY_F14")
	static final KEY_F14:Int;
	@:native("GLFW_KEY_F15")
	static final KEY_F15:Int;
	@:native("GLFW_KEY_F16")
	static final KEY_F16:Int;
	@:native("GLFW_KEY_F17")
	static final KEY_F17:Int;
	@:native("GLFW_KEY_F18")
	static final KEY_F18:Int;
	@:native("GLFW_KEY_F19")
	static final KEY_F19:Int;
	@:native("GLFW_KEY_F20")
	static final KEY_F20:Int;
	@:native("GLFW_KEY_F21")
	static final KEY_F21:Int;
	@:native("GLFW_KEY_F22")
	static final KEY_F22:Int;
	@:native("GLFW_KEY_F23")
	static final KEY_F23:Int;
	@:native("GLFW_KEY_F24")
	static final KEY_F24:Int;
	@:native("GLFW_KEY_F25")
	static final KEY_F25:Int;
	@:native("GLFW_KEY_KP_0")
	static final KEY_KP_0:Int;
	@:native("GLFW_KEY_KP_1")
	static final KEY_KP_1:Int;
	@:native("GLFW_KEY_KP_2")
	static final KEY_KP_2:Int;
	@:native("GLFW_KEY_KP_3")
	static final KEY_KP_3:Int;
	@:native("GLFW_KEY_KP_4")
	static final KEY_KP_4:Int;
	@:native("GLFW_KEY_KP_5")
	static final KEY_KP_5:Int;
	@:native("GLFW_KEY_KP_6")
	static final KEY_KP_6:Int;
	@:native("GLFW_KEY_KP_7")
	static final KEY_KP_7:Int;
	@:native("GLFW_KEY_KP_8")
	static final KEY_KP_8:Int;
	@:native("GLFW_KEY_KP_9")
	static final KEY_KP_9:Int;
	@:native("GLFW_KEY_KP_DECIMAL")
	static final KEY_KP_DECIMAL:Int;
	@:native("GLFW_KEY_KP_DIVIDE")
	static final KEY_KP_DIVIDE:Int;
	@:native("GLFW_KEY_KP_MULTIPLY")
	static final KEY_KP_MULTIPLY:Int;
	@:native("GLFW_KEY_KP_SUBTRACT")
	static final KEY_KP_SUBTRACT:Int;
	@:native("GLFW_KEY_KP_ADD")
	static final KEY_KP_ADD:Int;
	@:native("GLFW_KEY_KP_ENTER")
	static final KEY_KP_ENTER:Int;
	@:native("GLFW_KEY_KP_EQUAL")
	static final KEY_KP_EQUAL:Int;
	@:native("GLFW_KEY_LEFT_SHIFT")
	static final KEY_LEFT_SHIFT:Int;
	@:native("GLFW_KEY_LEFT_CONTROL")
	static final KEY_LEFT_CONTROL:Int;
	@:native("GLFW_KEY_LEFT_ALT")
	static final KEY_LEFT_ALT:Int;
	@:native("GLFW_KEY_LEFT_SUPER")
	static final KEY_LEFT_SUPER:Int;
	@:native("GLFW_KEY_RIGHT_SHIFT")
	static final KEY_RIGHT_SHIFT:Int;
	@:native("GLFW_KEY_RIGHT_CONTROL")
	static final KEY_RIGHT_CONTROL:Int;
	@:native("GLFW_KEY_RIGHT_ALT")
	static final KEY_RIGHT_ALT:Int;
	@:native("GLFW_KEY_RIGHT_SUPER")
	static final KEY_RIGHT_SUPER:Int;
	@:native("GLFW_KEY_MENU")
	static final KEY_MENU:Int;
	@:native("GLFW_KEY_LAST")
	static final KEY_LAST:Int;

	@:native("GLFW_MOD_SHIFT")
	static final MOD_SHIFT:Int;
	@:native("GLFW_MOD_CONTROL")
	static final MOD_CONTROL:Int;
	@:native("GLFW_MOD_ALT")
	static final MOD_ALT:Int;
	@:native("GLFW_MOD_SUPER")
	static final MOD_SUPER:Int;
	@:native("GLFW_MOD_CAPS_LOCK")
	static final MOD_CAPS_LOCK:Int;
	@:native("GLFW_MOD_NUM_LOCK")
	static final MOD_NUM_LOCK:Int;

	@:native("GLFW_MOUSE_BUTTON_1")
	static final MOUSE_BUTTON_1:Int;
	@:native("GLFW_MOUSE_BUTTON_2")
	static final MOUSE_BUTTON_2:Int;
	@:native("GLFW_MOUSE_BUTTON_3")
	static final MOUSE_BUTTON_3:Int;
	@:native("GLFW_MOUSE_BUTTON_4")
	static final MOUSE_BUTTON_4:Int;
	@:native("GLFW_MOUSE_BUTTON_5")
	static final MOUSE_BUTTON_5:Int;
	@:native("GLFW_MOUSE_BUTTON_6")
	static final MOUSE_BUTTON_6:Int;
	@:native("GLFW_MOUSE_BUTTON_7")
	static final MOUSE_BUTTON_7:Int;
	@:native("GLFW_MOUSE_BUTTON_8")
	static final MOUSE_BUTTON_8:Int;
	@:native("GLFW_MOUSE_BUTTON_LAST")
	static final MOUSE_BUTTON_LAST:Int;
	@:native("GLFW_MOUSE_BUTTON_LEFT")
	static final MOUSE_BUTTON_LEFT:Int;
	@:native("GLFW_MOUSE_BUTTON_RIGHT")
	static final MOUSE_BUTTON_RIGHT:Int;
	@:native("GLFW_MOUSE_BUTTON_MIDDLE")
	static final MOUSE_BUTTON_MIDDLE:Int;

	@:native("GLFW_JOYSTICK_1")
	static final JOYSTICK_1:Int;
	@:native("GLFW_JOYSTICK_2")
	static final JOYSTICK_2:Int;
	@:native("GLFW_JOYSTICK_3")
	static final JOYSTICK_3:Int;
	@:native("GLFW_JOYSTICK_4")
	static final JOYSTICK_4:Int;
	@:native("GLFW_JOYSTICK_5")
	static final JOYSTICK_5:Int;
	@:native("GLFW_JOYSTICK_6")
	static final JOYSTICK_6:Int;
	@:native("GLFW_JOYSTICK_7")
	static final JOYSTICK_7:Int;
	@:native("GLFW_JOYSTICK_8")
	static final JOYSTICK_8:Int;
	@:native("GLFW_JOYSTICK_9")
	static final JOYSTICK_9:Int;
	@:native("GLFW_JOYSTICK_10")
	static final JOYSTICK_10:Int;
	@:native("GLFW_JOYSTICK_11")
	static final JOYSTICK_11:Int;
	@:native("GLFW_JOYSTICK_12")
	static final JOYSTICK_12:Int;
	@:native("GLFW_JOYSTICK_13")
	static final JOYSTICK_13:Int;
	@:native("GLFW_JOYSTICK_14")
	static final JOYSTICK_14:Int;
	@:native("GLFW_JOYSTICK_15")
	static final JOYSTICK_15:Int;
	@:native("GLFW_JOYSTICK_16")
	static final JOYSTICK_16:Int;
	@:native("GLFW_JOYSTICK_LAST")
	static final JOYSTICK_LAST:Int;

	@:native("GLFW_GAMEPAD_BUTTON_A")
	static final GAMEPAD_BUTTON_A:Int;
	@:native("GLFW_GAMEPAD_BUTTON_B")
	static final GAMEPAD_BUTTON_B:Int;
	@:native("GLFW_GAMEPAD_BUTTON_X")
	static final GAMEPAD_BUTTON_X:Int;
	@:native("GLFW_GAMEPAD_BUTTON_Y")
	static final GAMEPAD_BUTTON_Y:Int;
	@:native("GLFW_GAMEPAD_BUTTON_LEFT_BUMPER")
	static final GAMEPAD_BUTTON_LEFT_BUMPER:Int;
	@:native("GLFW_GAMEPAD_BUTTON_RIGHT_BUMPER")
	static final GAMEPAD_BUTTON_RIGHT_BUMPER:Int;
	@:native("GLFW_GAMEPAD_BUTTON_BACK")
	static final GAMEPAD_BUTTON_BACK:Int;
	@:native("GLFW_GAMEPAD_BUTTON_START")
	static final GAMEPAD_BUTTON_START:Int;
	@:native("GLFW_GAMEPAD_BUTTON_GUIDE")
	static final GAMEPAD_BUTTON_GUIDE:Int;
	@:native("GLFW_GAMEPAD_BUTTON_LEFT_THUMB")
	static final GAMEPAD_BUTTON_LEFT_THUMB:Int;
	@:native("GLFW_GAMEPAD_BUTTON_RIGHT_THUMB")
	static final GAMEPAD_BUTTON_RIGHT_THUMB:Int;
	@:native("GLFW_GAMEPAD_BUTTON_DPAD_UP")
	static final GAMEPAD_BUTTON_DPAD_UP:Int;
	@:native("GLFW_GAMEPAD_BUTTON_DPAD_RIGHT")
	static final GAMEPAD_BUTTON_DPAD_RIGHT:Int;
	@:native("GLFW_GAMEPAD_BUTTON_DPAD_DOWN")
	static final GAMEPAD_BUTTON_DPAD_DOWN:Int;
	@:native("GLFW_GAMEPAD_BUTTON_DPAD_LEFT")
	static final GAMEPAD_BUTTON_DPAD_LEFT:Int;
	@:native("GLFW_GAMEPAD_BUTTON_LAST")
	static final GAMEPAD_BUTTON_LAST:Int;
	@:native("GLFW_GAMEPAD_BUTTON_CROSS")
	static final GAMEPAD_BUTTON_CROSS:Int;
	@:native("GLFW_GAMEPAD_BUTTON_CIRCLE")
	static final GAMEPAD_BUTTON_CIRCLE:Int;
	@:native("GLFW_GAMEPAD_BUTTON_SQUARE")
	static final GAMEPAD_BUTTON_SQUARE:Int;
	@:native("GLFW_GAMEPAD_BUTTON_TRIANGLE")
	static final GAMEPAD_BUTTON_TRIANGLE:Int;
    
	@:native("GLFW_GAMEPAD_AXIS_LEFT_X")
	static final GAMEPAD_AXIS_LEFT_X:Int;
	@:native("GLFW_GAMEPAD_AXIS_LEFT_Y")
	static final GAMEPAD_AXIS_LEFT_Y:Int;
	@:native("GLFW_GAMEPAD_AXIS_RIGHT_X")
	static final GAMEPAD_AXIS_RIGHT_X:Int;
	@:native("GLFW_GAMEPAD_AXIS_RIGHT_Y")
	static final GAMEPAD_AXIS_RIGHT_Y:Int;
	@:native("GLFW_GAMEPAD_AXIS_LEFT_TRIGGER")
	static final GAMEPAD_AXIS_LEFT_TRIGGER:Int;
	@:native("GLFW_GAMEPAD_AXIS_RIGHT_TRIGGER")
	static final GAMEPAD_AXIS_RIGHT_TRIGGER:Int;
	@:native("GLFW_GAMEPAD_AXIS_LAST")
	static final GAMEPAD_AXIS_LAST:Int;

	@:native("GLFW_NO_ERROR")
	static final NO_ERROR:Int;
	@:native("GLFW_NOT_INITIALIZED")
	static final NOT_INITIALIZED:Int;
	@:native("GLFW_NO_CURRENT_CONTEXT")
	static final NO_CURRENT_CONTEXT:Int;
	@:native("GLFW_INVALID_ENUM")
	static final INVALID_ENUM:Int;
	@:native("GLFW_INVALID_VALUE")
	static final INVALID_VALUE:Int;
	@:native("GLFW_OUT_OF_MEMORY")
	static final OUT_OF_MEMORY:Int;
	@:native("GLFW_API_UNAVAILABLE")
	static final API_UNAVAILABLE:Int;
	@:native("GLFW_VERSION_UNAVAILABLE")
	static final VERSION_UNAVAILABLE:Int;
	@:native("GLFW_PLATFORM_ERROR")
	static final PLATFORM_ERROR:Int;
	@:native("GLFW_FORMAT_UNAVAILABLE")
	static final FORMAT_UNAVAILABLE:Int;
	@:native("GLFW_NO_WINDOW_CONTEXT")
	static final NO_WINDOW_CONTEXT:Int;

	@:native("GLFW_FOCUSED")
	static final FOCUSED:Int;
	@:native("GLFW_ICONIFIED")
	static final ICONIFIED:Int;
	@:native("GLFW_RESIZABLE")
	static final RESIZABLE:Int;
	@:native("GLFW_VISIBLE")
	static final VISIBLE:Int;
	@:native("GLFW_DECORATED")
	static final DECORATED:Int;
	@:native("GLFW_AUTO_ICONIFY")
	static final AUTO_ICONIFY:Int;
	@:native("GLFW_FLOATING")
	static final FLOATING:Int;
	@:native("GLFW_MAXIMIZED")
	static final MAXIMIZED:Int;
	@:native("GLFW_CENTER_CURSOR")
	static final CENTER_CURSOR:Int;
	@:native("GLFW_TRANSPARENT_FRAMEBUFFER")
	static final TRANSPARENT_FRAMEBUFFER:Int;
	@:native("GLFW_HOVERED")
	static final HOVERED:Int;
	@:native("GLFW_FOCUS_ON_SHOW")
	static final FOCUS_ON_SHOW:Int;
	@:native("GLFW_RED_BITS")
	static final RED_BITS:Int;
	@:native("GLFW_GREEN_BITS")
	static final GREEN_BITS:Int;
	@:native("GLFW_BLUE_BITS")
	static final BLUE_BITS:Int;
	@:native("GLFW_ALPHA_BITS")
	static final ALPHA_BITS:Int;
	@:native("GLFW_DEPTH_BITS")
	static final DEPTH_BITS:Int;
	@:native("GLFW_STENCIL_BITS")
	static final STENCIL_BITS:Int;
	@:native("GLFW_ACCUM_RED_BITS")
	static final ACCUM_RED_BITS:Int;
	@:native("GLFW_ACCUM_GREEN_BITS")
	static final ACCUM_GREEN_BITS:Int;
	@:native("GLFW_ACCUM_BLUE_BITS")
	static final ACCUM_BLUE_BITS:Int;
	@:native("GLFW_ACCUM_ALPHA_BITS")
	static final ACCUM_ALPHA_BITS:Int;
	@:native("GLFW_AUX_BUFFERS")
	static final AUX_BUFFERS:Int;
	@:native("GLFW_STEREO")
	static final STEREO:Int;
	@:native("GLFW_SAMPLES")
	static final SAMPLES:Int;
	@:native("GLFW_SRGB_CAPABLE")
	static final SRGB_CAPABLE:Int;
	@:native("GLFW_REFRESH_RATE")
	static final REFRESH_RATE:Int;
	@:native("GLFW_DOUBLEBUFFER")
	static final DOUBLEBUFFER:Int;
	@:native("GLFW_CLIENT_API")
	static final CLIENT_API:Int;
	@:native("GLFW_CONTEXT_VERSION_MAJOR")
	static final CONTEXT_VERSION_MAJOR:Int;
	@:native("GLFW_CONTEXT_VERSION_MINOR")
	static final CONTEXT_VERSION_MINOR:Int;
	@:native("GLFW_CONTEXT_REVISION")
	static final CONTEXT_REVISION:Int;
	@:native("GLFW_CONTEXT_ROBUSTNESS")
	static final CONTEXT_ROBUSTNESS:Int;
	@:native("GLFW_OPENGL_FORWARD_COMPAT")
	static final OPENGL_FORWARD_COMPAT:Int;
	@:native("GLFW_OPENGL_DEBUG_CONTEXT")
	static final OPENGL_DEBUG_CONTEXT:Int;
	@:native("GLFW_OPENGL_PROFILE")
	static final OPENGL_PROFILE:Int;
	@:native("GLFW_CONTEXT_RELEASE_BEHAVIOR")
	static final CONTEXT_RELEASE_BEHAVIOR:Int;
	@:native("GLFW_CONTEXT_NO_ERROR")
	static final CONTEXT_NO_ERROR:Int;
	@:native("GLFW_CONTEXT_CREATION_API")
	static final CONTEXT_CREATION_API:Int;
	@:native("GLFW_SCALE_TO_MONITOR")
	static final SCALE_TO_MONITOR:Int;
	@:native("GLFW_COCOA_RETINA_FRAMEBUFFER")
	static final COCOA_RETINA_FRAMEBUFFER:Int;
	@:native("GLFW_COCOA_FRAME_NAME")
	static final COCOA_FRAME_NAME:Int;
	@:native("GLFW_COCOA_GRAPHICS_SWITCHING")
	static final COCOA_GRAPHICS_SWITCHING:Int;
	@:native("GLFW_X11_CLASS_NAME")
	static final X11_CLASS_NAME:Int;
	@:native("GLFW_X11_INSTANCE_NAME")
	static final X11_INSTANCE_NAME:Int;
	@:native("GLFW_NO_API")
	static final NO_API:Int;
	@:native("GLFW_OPENGL_API")
	static final OPENGL_API:Int;
	@:native("GLFW_OPENGL_ES_API")
	static final OPENGL_ES_API:Int;
	@:native("GLFW_NO_ROBUSTNESS")
	static final NO_ROBUSTNESS:Int;
	@:native("GLFW_NO_RESET_NOTIFICATION")
	static final NO_RESET_NOTIFICATION:Int;
	@:native("GLFW_LOSE_CONTEXT_ON_RESET")
	static final LOSE_CONTEXT_ON_RESET:Int;
	@:native("GLFW_OPENGL_ANY_PROFILE")
	static final OPENGL_ANY_PROFILE:Int;
	@:native("GLFW_OPENGL_CORE_PROFILE")
	static final OPENGL_CORE_PROFILE:Int;
	@:native("GLFW_OPENGL_COMPAT_PROFILE")
	static final OPENGL_COMPAT_PROFILE:Int;
	@:native("GLFW_CURSOR")
	static final CURSOR:Int;
	@:native("GLFW_STICKY_KEYS")
	static final STICKY_KEYS:Int;
	@:native("GLFW_STICKY_MOUSE_BUTTONS")
	static final STICKY_MOUSE_BUTTONS:Int;
	@:native("GLFW_LOCK_KEY_MODS")
	static final LOCK_KEY_MODS:Int;
	@:native("GLFW_RAW_MOUSE_MOTION")
	static final RAW_MOUSE_MOTION:Int;
	@:native("GLFW_CURSOR_NORMAL")
	static final CURSOR_NORMAL:Int;
	@:native("GLFW_CURSOR_HIDDEN")
	static final CURSOR_HIDDEN:Int;
	@:native("GLFW_CURSOR_DISABLED")
	static final CURSOR_DISABLED:Int;
	@:native("GLFW_ANY_RELEASE_BEHAVIOR")
	static final ANY_RELEASE_BEHAVIOR:Int;
	@:native("GLFW_RELEASE_BEHAVIOR_FLUSH")
	static final RELEASE_BEHAVIOR_FLUSH:Int;
	@:native("GLFW_RELEASE_BEHAVIOR_NONE")
	static final RELEASE_BEHAVIOR_NONE:Int;
	@:native("GLFW_NATIVE_CONTEXT_API")
	static final NATIVE_CONTEXT_API:Int;
	@:native("GLFW_EGL_CONTEXT_API")
	static final EGL_CONTEXT_API:Int;
	@:native("GLFW_OSMESA_CONTEXT_API")
	static final OSMESA_CONTEXT_API:Int;
	@:native("GLFW_ARROW_CURSOR")
	static final ARROW_CURSOR:Int;
	@:native("GLFW_IBEAM_CURSOR")
	static final IBEAM_CURSOR:Int;
	@:native("GLFW_CROSSHAIR_CURSOR")
	static final CROSSHAIR_CURSOR:Int;
	@:native("GLFW_HAND_CURSOR")
	static final HAND_CURSOR:Int;
	@:native("GLFW_HRESIZE_CURSOR")
	static final HRESIZE_CURSOR:Int;
	@:native("GLFW_VRESIZE_CURSOR")
	static final VRESIZE_CURSOR:Int;
	@:native("GLFW_CONNECTED")
	static final CONNECTED:Int;
	@:native("GLFW_DISCONNECTED")
	static final DISCONNECTED:Int;
	@:native("GLFW_JOYSTICK_HAT_BUTTONS")
	static final JOYSTICK_HAT_BUTTONS:Int;
	@:native("GLFW_COCOA_CHDIR_RESOURCES")
	static final COCOA_CHDIR_RESOURCES:Int;
	@:native("GLFW_COCOA_MENUBAR")
	static final COCOA_MENUBAR:Int;
	@:native("GLFW_DONT_CARE")
	static final DONT_CARE:Int; 

    @:native("glfwInit")
    static function init():Int;

    @:native("glfwTerminate")
    static function terminate():Void;

    @:native("glfwInitHint")
    static function initHint(hint:Int, value:Int):Void;

    @:native("glfwGetVersion")
    static function getVersion(major:RawPointer<Int>, minor:RawPointer<Int>, rev:RawPointer<Int>):Void;

    @:native("glfwGetVersionString")
    static function _getVersionString():ConstCharStar;

    static inline function getVersionString():String
        return _getVersionString().toString();

    @:native("glfwGetError")
    static function getError(desc:RawPointer<ConstCharStar>):Int;

    @:native("glfwSetErrorCallback")
    static function setErrorCallback(func:ErrorFunc):ErrorFunc;

    @:native("glfwGetMonitors")
    static function getMonitors(count:RawPointer<Int>):RawPointer<GlfwMonitor>;

    @:native("glfwGetPrimaryMonitor")
    static function getPrimaryMonitor():GlfwMonitor;

    @:native("glfwGetMonitorPos")
    static function getMonitorPos(monitor:GlfwMonitor, xPos:RawPointer<Int>, yPos:RawPointer<Int>):Void;

    @:native("glfwGetMonitorWorkarea")
    static function getMonitorWorkarea(monitor:GlfwMonitor, xPos:RawPointer<Int>, yPos:RawPointer<Int>, width:RawPointer<Int>, height:RawPointer<Int>):Void;

    @:native("glfwGetMonitorPhysicalSize")
    static function getMonitorPhysicalSize(monitor:GlfwMonitor, widthMM:RawPointer<Int>, heightMM:RawPointer<Int>):Void;

    @:native("glfwGetMonitorContentScale")
    static function getMonitorContentScale(monitor:GlfwMonitor, xScale:RawPointer<Float>, yScale:RawPointer<Float>):Void;

    @:native("getMonitorName")
    static function _getMonitorName(monitor:GlfwMonitor):ConstCharStar;

    static inline function getMonitorName(monitor:GlfwMonitor):String
        return _getMonitorName(monitor).toString();

    @:native("glfwSetMonitorUserPointer")
    static function setMonitorUserPointer(monitor:GlfwMonitor, pointer:Any):Void;

    @:native("glfwGetMonitorUserPointer")
    static function getMonitorUserPointer(monitor:GlfwMonitor):Any;

    @:native("glfwSetMonitorCallback")
    static function setMonitorCallback(callback:MonitorFunc):MonitorFunc;

    @:native("glfwGetVideoModes")
    static function getVideoModes(monitor:GlfwMonitor, count:RawPointer<Int>):cpp.ConstPointer<VideoMode>;

    @:native("glfwGetVideoMode")
    static function getVideoMode(monitor:GlfwMonitor):cpp.ConstPointer<VideoMode>;

    @:native("glfwSetGamma")
    static function setGamma(monitor:GlfwMonitor, gamma:Float):Void;

    @:native("glfwGetGammaRamp")
    static function getGammaRamp(monitor:GlfwMonitor):RawPointer<GammaRamp>;

    @:native("glfwSetGammaRamp")
    static function setGammaRamp(monitor:GlfwMonitor, ramp:RawPointer<GammaRamp>):Void;

    @:native("glfwDefaultWindowHints")
    static function defaultWindowHints():Void;

    @:native("glfwWindowHint")
    static function windowHint(hint:Int, value:Int):Void;

    @:native("glfwWindowHintString")
    static function windowHintString(hint:Int, value:ConstCharStar):Void;

    @:native("glfwCreateWindow")
    static function createWindow(width:Int, height:Int, title:ConstCharStar, monitor:GlfwMonitor, share:GlfwWindow):GlfwWindow;

    @:native("glfwDestroyWindow")
    static function destroyWindow(window:GlfwWindow):Void;
    
    @:native("glfwWindowShouldClose")
    static function _windowShouldClose(window:GlfwWindow):Int;

    static inline function windowShouldClose(window:GlfwWindow):Bool
        return _windowShouldClose(window) != 0;

    @:native("glfwSetWindowShouldClose")
    static function setWindowShouldClose(window:GlfwWindow, value:Int):Void;

    @:native("glfwSetWindowTitle")
    static function setWindowTitle(window:GlfwWindow, title:ConstCharStar):Void;

    @:native("glfwSetWindowIcon") //TODO: When the Blueprint Texture is finished, make a function for using that for icons.
    static function setWindowIcon(window:GlfwWindow, count:Int, images:RawPointer<GlfwImage>):Void;

    @:native("glfwGetWindowPos")
    static function getWindowPos(window:GlfwWindow, xPos:RawPointer<Int>, yPos:RawPointer<Int>):Void;

    @:native("glfwSetWindowPos")
    static function setWindowPos(window:GlfwWindow, xPos:Int, yPos:Int):Void;

    @:native("glfwGetWindowSize")
    static function getWindowSize(window:GlfwWindow, width:RawPointer<Int>, height:RawPointer<Int>):Void;

    @:native("glfwSetWindowSizeLimits")
    static function setWindowSizeLimits(window:GlfwWindow, minWidth:Int, minHeight:Int, maxWidth:Int, maxHeight:Int):Void;

    @:native("glfwSetWindowAspectRatio")
    static function setWindowAspectRatio(window:GlfwWindow, numerator:Int, denominator:Int):Void;

    @:native("glfwSetWindowSize")
    static function setWindowSize(window:GlfwWindow, width:Int, height:Int):Void;

    @:native("glfwGetFramebufferSize")
    static function getFramebufferSize(window:GlfwWindow, width:RawPointer<Int>, height:RawPointer<Int>):Void;

    @:native("glfwGetWindowFrameSize")
    static function getWindowFrameSize(window:GlfwWindow, left:RawPointer<Int>, top:RawPointer<Int>, right:RawPointer<Int>, bottom:RawPointer<Int>):Void;

    @:native("glfwGetWindowContentScale")
    static function getWindowContentScale(window:GlfwWindow, xScale:RawPointer<Float>, yScale:RawPointer<Float>):Void;

    @:native("glfwGetWindowOpacity")
    static function getWindowOpacity(window:GlfwWindow):Float;

    @:native("glfwSetWindowOpacity")
    static function setWindowOpacity(window:GlfwWindow, opacity:Float):Void;

    @:native("iconifyWindow")
    static function glfwIconifyWindow(window:GlfwWindow):Void;

    @:native("glfwRestoreWindow")
    static function restoreWindow(window:GlfwWindow):Void;

    @:native("glfwMaximizeWindow")
    static function maximizeWindow(window:GlfwWindow):Void;

    @:native("glfwShowWindow")
    static function showWindow(window:GlfwWindow):Void;

    @:native("glfwHideWindow")
    static function hideWindow(window:GlfwWindow):Void;

    @:native("glfwFocusWindow")
    static function focusWindow(window:GlfwWindow):Void;

    @:native("glfwRequestWindowAttention")
    static function requestWindowAttention(window:GlfwWindow):Void;

    @:native("getWindowMonitor")
    static function glfwGetWindowMonitor(window:GlfwWindow):GlfwMonitor;
        
    @:native("glfwSetWindowMonitor")
    static function setWindowMonitor(window:GlfwWindow, monitor:GlfwMonitor, xPos:Int, yPos:Int, width:Int, height:Int, refreshRate:Int):Void;

    @:native("glfwGetWindowAttrib")
    static function getWindowAttribute(window:GlfwWindow, attribute:Int):Int;

    @:native("glfwSetWindowAttrib")
    static function setWindowAttribute(window:GlfwWindow, attribute:Int, value:Int):Void;

    @:native("glfwSetWindowUserPointer")
    static function setWindowUserPointer(window:GlfwWindow, pointer:Any):Void;

    @:native("glfwGetWindowUserPointer")
    static function getWindowUserPointer(window:GlfwWindow):Any;

    @:native("glfwSetWindowPosCallback")
    static function setWindowPosCallback(window:GlfwWindow, callback:WindowPosFunc):WindowPosFunc;

    @:native("glfwSetWindowSizeCallback")
    static function setWindowSizeCallback(window:GlfwWindow, callback:WindowSizeFunc):WindowSizeFunc;

    @:native("glfwSetWindowCloseCallback")
    static function setWindowCloseCallback(window:GlfwWindow, callback:WindowCloseFunc):WindowCloseFunc;

    @:native("glfwSetWindowRefreshCallback")
    static function setWindowRefreshCallback(window:GlfwWindow, callback:WindowRefreshFunc):WindowRefreshFunc;

    @:native("glfwSetWindowFocusCallback")
    static function setWindowFocusCallback(window:GlfwWindow, callback:WindowFocusFunc):WindowFocusFunc;

    @:native("glfwSetWindowIconifyCallback")
    static function setWindowIconifyCallback(window:GlfwWindow, callback:WindowIconifyFunc):WindowIconifyFunc;

    @:native("glfwSetWindowMaximizeCallback")
    static function setWindowMaximizeCallback(window:GlfwWindow, callback:WindowMaximizeFunc):WindowMaximizeFunc;

    @:native("glfwSetFramebufferSizeCallback")
    static function setFramebufferSizeCallback(window:GlfwWindow, callback:FrameBufferSizeFunc):FrameBufferSizeFunc;

    @:native("glfwSetWindowContentScaleCallback")
    static function setWindowContentScaleCallback(window:GlfwWindow, callback:WindowContentScaleFunc):WindowContentScaleFunc;

    @:native("glfwPollEvents")
    static function pollEvents():Void;

    @:native("glfwWaitEvents")
    static function waitEvents():Void;

    @:native("glfwWaitEventsTimeout")
    static function waitEventsTimeout(timeout:Float):Void;

    @:native("glfwPostEmptyEvent")
    static function postEmptyEvent():Void;

    @:native("glfwGetInputMode")
    static function getInputMode(window:GlfwWindow, mode:Int):Int;

    @:native("glfwSetInputMode")
    static function setInputMode(window:GlfwWindow, mode:Int, value:Int):Void;

    @:native("glfwRawMouseMotionSupported")
    static function _rawMouseMotionSupported():Int;

    static inline function rawMouseMotionSupported():Bool
        return _rawMouseMotionSupported() != 0;

    @:native("glfwGetKeyName")
    static function _getKeyName(key:Int, scancode:Int):ConstCharStar;

    static inline function getKeyName(key:Int, scancode:Int):String
        return _getKeyName(key, scancode).toString();

    @:native("glfwGetKeyScancode")
    static function getKeyScancode(key:Int):Int;

    @:native("glfwGetKey")
    static function getKey(window:GlfwWindow, key:Int):Int;

    @:native("glfwGetCursorPos")
    static function getCursorPos(window:GlfwWindow, xPos:RawPointer<Float>, yPos:RawPointer<Float>):Void;

    @:native("glfwSetCursorPos")
    static function setCursorPos(window:GlfwWindow, xPos:Float, yPos:Float):Void;

    @:native("glfwCreateCursor")
    static function createCursor(image:RawPointer<GlfwImage>, hotspotX:Int, hotspotY:Int):GlfwCursor;

    @:native("glfwCreateStandardCursor")
    static function createStandardCursor(shape:Int):GlfwCursor;

    @:native("glfwDestroyCursor")
    static function destroyCursor(cursor:GlfwCursor):Void;

    @:native("glfwSetCursor")
    static function setCursor(window:GlfwWindow, cursor:GlfwCursor):Void;

    @:native("glfwSetKeyCallback")
    static function setKeyCallback(window:GlfwWindow, callback:KeyInputFunc):KeyInputFunc;

    @:native("glfwSetCharCallback")
    static function setCharCallback(window:GlfwWindow, callback:CharFunc):CharFunc;

    @:native("glfwSetCharModsCallback")
    static function setCharModsCallback(window:GlfwWindow, callback:CharModsFunc):CharModsFunc;

    @:native("glfwSetMouseButtonCallback")
    static function setMouseButtonCallback(window:GlfwWindow, callback:MouseButtonFunc):MouseButtonFunc;
    
    @:native("glfwSetCursorPosCallback")
    static function setCursorPosCallback(window:GlfwWindow, callback:CursorPosFunc):CursorPosFunc;

    @:native("glfwSetCursorEnterCallback")
    static function setCursorEnterCallback(window:GlfwWindow, callback:CursorEnterFunc):CursorEnterFunc;

    @:native("glfwSetScrollCallback")
    static function setScrollCallback(window:GlfwWindow, callback:ScrollFunc):ScrollFunc;

    @:native("glfwSetDropCallback")
    static function setDropCallback(window:GlfwWindow, callback:FileDropFunc):FileDropFunc;

    @:native("glfwJoystickPresent")
    static function _joystickPresent(joystickID:Int):Int;

    static inline function joystickPresent(joystickID:Int):Bool
        return _joystickPresent(joystickID) != 0;

    @:native("glfwGetJoystickAxes")
    static function getJoystickAxes(joystickID:Int, count:RawPointer<Int>):RawPointer<Float>;

    @:native("glfwGetJoystickButtons")
    static function getJoystickButtons(joystickID:Int, count:RawPointer<Int>):cpp.ConstPointer<Int>;

    @:native("glfwGetJoystickHats")
    static function getJoystickHats(joystickID:Int, count:RawPointer<Int>):cpp.ConstPointer<Int>;

    @:native("glfwGetJoystickName")
    static function _getJoystickName(joystickID:Int):ConstCharStar;
    
    static inline function getJoystickName(joystickID:Int):String
        return _getJoystickName(joystickID).toString();

    @:native("glfwGetJoystickGUID")
    static function _getJoystickGUID(joystickID:Int):ConstCharStar;

    static inline function getJoystickGUID(joystickID:Int):String
        return _getJoystickGUID(joystickID).toString();

    @:native("glfwSetJoystickUserPointer")
    static function setJoystickUserPointer(joystickID:Int, pointer:Any):Void;

    @:native("glfwGetJoystickUserPointer")
    static function getJoystickUserPointer(joystickID:Int):Any;

    @:native("glfwJoystickIsGamepad")
    static function _joystickIsGamepad(joystickID:Int):Int;

    static inline function joystickIsGamepad(joystickID:Int):Bool
        return _joystickIsGamepad(joystickID) != 0;

    @:native("glfwSetJoystickCallback")
    static function setJoystickCallback(callback:JoystickFunc):JoystickFunc;

    @:native("glfwUpdateGamepadMappings")
    static function updateGamepadMappings(mappings:ConstCharStar):Int;

    @:native("glfwGetGamepadName")
    static function _getGamepadName(gamepadID:Int):ConstCharStar;

    static inline function getGamepadName(gamepadID:Int):String
        return _getGamepadName(gamepadID).toString();

    @:native("glfwGetGamepadState")
    static function getGamepadState(gamepadID:Int, state:GamepadState):Int;

    @:native("glfwSetClipboardString")
    static function setClipboardString(window:GlfwWindow, string:ConstCharStar):Void;

    @:native("glfwGetClipboardString")
    static function _getClipboardString(window:GlfwWindow):ConstCharStar;

    static inline function getClipboardString(window:GlfwWindow):String
        return _getClipboardString(window).toString();

    @:native("glfwGetTime")
    static function getTime():Float;

    @:native("glfwSetTime")
    static function setTime(time:Float):Void;

    @:native("glfwGetTimerValue")
    static function getTimerValue():Int;

    @:native("glfwGetTimerFrequency")
    static function getTimerFrequency():Int;

    @:native("glfwMakeContextCurrent")
    static function makeContextCurrent(window:GlfwWindow):Void;

    @:native("glfwGetCurrentContext")
    static function getCurrentContext():GlfwWindow;

    @:native("glfwSwapBuffers")
    static function swapBuffers(window:GlfwWindow):Void;

    @:native("glfwSwapInterval")
    static function swapInterval(interval:Int):Void;

    @:native("glfwExtensionSupported")
    static function _extensionSupported(extension:ConstCharStar):Int;

    static inline function extensionSupported(extension:String):Bool
        return _extensionSupported(ConstCharStar.fromString(extension)) != 0;

	@:native("glfwGetProcAddress")
    static function getProcAddress(procName:ConstCharStar):Void;

    @:native("glfwVulkanSupported")
    static function _vulkanSupported():Int;

    static inline function vulkanSupported():Bool
        return _vulkanSupported() != 0;

    @:native("glfwGetRequiredInstanceExtensions")
    static function getRequiredInstanceExtensions(count:RawPointer<Int>):RawPointer<ConstCharStar>;
}
#end