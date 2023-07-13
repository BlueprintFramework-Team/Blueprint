package bindings;

#if !macro
import cpp.RawPointer;
import cpp.ConstPointer;
import cpp.Star;
import cpp.Callable;
import cpp.Pointer;
import cpp.Struct;
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
typedef VideoMode = Struct<GlfwVidMode>;

@:include("includeWorkaround.h")
@:native("GLFWgammaramp")
@:structAccess
extern class GlfwGammaRamp {
    var red:UInt;
    var green:UInt;
    var blue:UInt;
    var size:UInt;
}
typedef GammaRamp = Struct<GlfwGammaRamp>;

@:include("includeWorkaround.h")
@:native("GLFWimage")
@:structAccess
extern class GflwImageStruct {
    var width:Int;
    var height:Int;
    var pixels:cpp.Star<Int>;
}
typedef GlfwImage = Struct<GflwImageStruct>;

@:include("includeWorkaround.h")
@:native("GLFWgamepadstate")
@:structAccess
extern class GlfwGamepadState {
    var buttons:Array<cpp.UInt8>;
    var axes:Array<Float>;
}
typedef GamepadState = Struct<GlfwGamepadState>;

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
	public static var VERSION_MAJOR:Int;
	@:native("GLFW_VERSION_MINOR")
	public static var VERSION_MINOR:Int;
	@:native("GLFW_VERSION_REVISION")
	public static var VERSION_REVISION:Int;

	@:native("GLFW_TRUE")
	public static var TRUE:Int;
	@:native("GLFW_FALSE")
	public static var FALSE:Int;

	@:native("GLFW_RELEASE")
	public static var RELEASE:Int;
	@:native("GLFW_PRESS")
	public static var PRESS:Int;
	@:native("GLFW_REPEAT")
	public static var REPEAT:Int;

	@:native("GLFW_HAT_CENTERED")
	public static var HAT_CENTERED:Int;
	@:native("GLFW_HAT_UP")
	public static var HAT_UP:Int;
	@:native("GLFW_HAT_RIGHT")
	public static var HAT_RIGHT:Int;
	@:native("GLFW_HAT_DOWN")
	public static var HAT_DOWN:Int;
	@:native("GLFW_HAT_LEFT")
	public static var HAT_LEFT:Int;
	@:native("GLFW_HAT_RIGHT_UP")
	public static var HAT_RIGHT_UP:Int;
	@:native("GLFW_HAT_RIGHT_DOWN")
	public static var HAT_RIGHT_DOWN:Int;
	@:native("GLFW_HAT_LEFT_UP")
	public static var HAT_LEFT_UP:Int;
	@:native("GLFW_HAT_LEFT_DOWN")
	public static var HAT_LEFT_DOWN:Int;

	@:native("GLFW_KEY_UNKNOWN")
	public static var KEY_UNKNOWN:Int;
	@:native("GLFW_KEY_SPACE")
	public static var KEY_SPACE:Int;
	@:native("GLFW_KEY_APOSTROPHE")
	public static var KEY_APOSTROPHE:Int;
	@:native("GLFW_KEY_COMMA")
	public static var KEY_COMMA:Int;
	@:native("GLFW_KEY_MINUS")
	public static var KEY_MINUS:Int;
	@:native("GLFW_KEY_PERIOD")
	public static var KEY_PERIOD:Int;
	@:native("GLFW_KEY_SLASH")
	public static var KEY_SLASH:Int;
	@:native("GLFW_KEY_0")
	public static var KEY_0:Int;
	@:native("GLFW_KEY_1")
	public static var KEY_1:Int;
	@:native("GLFW_KEY_2")
	public static var KEY_2:Int;
	@:native("GLFW_KEY_3")
	public static var KEY_3:Int;
	@:native("GLFW_KEY_4")
	public static var KEY_4:Int;
	@:native("GLFW_KEY_5")
	public static var KEY_5:Int;
	@:native("GLFW_KEY_6")
	public static var KEY_6:Int;
	@:native("GLFW_KEY_7")
	public static var KEY_7:Int;
	@:native("GLFW_KEY_8")
	public static var KEY_8:Int;
	@:native("GLFW_KEY_9")
	public static var KEY_9:Int;
	@:native("GLFW_KEY_SEMICOLON")
	public static var KEY_SEMICOLON:Int;
	@:native("GLFW_KEY_EQUAL")
	public static var KEY_EQUAL:Int;
	@:native("GLFW_KEY_A")
	public static var KEY_A:Int;
	@:native("GLFW_KEY_B")
	public static var KEY_B:Int;
	@:native("GLFW_KEY_C")
	public static var KEY_C:Int;
	@:native("GLFW_KEY_D")
	public static var KEY_D:Int;
	@:native("GLFW_KEY_E")
	public static var KEY_E:Int;
	@:native("GLFW_KEY_F")
	public static var KEY_F:Int;
	@:native("GLFW_KEY_G")
	public static var KEY_G:Int;
	@:native("GLFW_KEY_H")
	public static var KEY_H:Int;
	@:native("GLFW_KEY_I")
	public static var KEY_I:Int;
	@:native("GLFW_KEY_J")
	public static var KEY_J:Int;
	@:native("GLFW_KEY_K")
	public static var KEY_K:Int;
	@:native("GLFW_KEY_L")
	public static var KEY_L:Int;
	@:native("GLFW_KEY_M")
	public static var KEY_M:Int;
	@:native("GLFW_KEY_N")
	public static var KEY_N:Int;
	@:native("GLFW_KEY_O")
	public static var KEY_O:Int;
	@:native("GLFW_KEY_P")
	public static var KEY_P:Int;
	@:native("GLFW_KEY_Q")
	public static var KEY_Q:Int;
	@:native("GLFW_KEY_R")
	public static var KEY_R:Int;
	@:native("GLFW_KEY_S")
	public static var KEY_S:Int;
	@:native("GLFW_KEY_T")
	public static var KEY_T:Int;
	@:native("GLFW_KEY_U")
	public static var KEY_U:Int;
	@:native("GLFW_KEY_V")
	public static var KEY_V:Int;
	@:native("GLFW_KEY_W")
	public static var KEY_W:Int;
	@:native("GLFW_KEY_X")
	public static var KEY_X:Int;
	@:native("GLFW_KEY_Y")
	public static var KEY_Y:Int;
	@:native("GLFW_KEY_Z")
	public static var KEY_Z:Int;
	@:native("GLFW_KEY_LEFT_BRACKET")
	public static var KEY_LEFT_BRACKET:Int;
	@:native("GLFW_KEY_BACKSLASH")
	public static var KEY_BACKSLASH:Int;
	@:native("GLFW_KEY_RIGHT_BRACKET")
	public static var KEY_RIGHT_BRACKET:Int;
	@:native("GLFW_KEY_GRAVE_ACCENT")
	public static var KEY_GRAVE_ACCENT:Int;
	@:native("GLFW_KEY_WORLD_1")
	public static var KEY_WORLD_1:Int;
	@:native("GLFW_KEY_WORLD_2")
	public static var KEY_WORLD_2:Int;
	@:native("GLFW_KEY_ESCAPE")
	public static var KEY_ESCAPE:Int;
	@:native("GLFW_KEY_ENTER")
	public static var KEY_ENTER:Int;
	@:native("GLFW_KEY_TAB")
	public static var KEY_TAB:Int;
	@:native("GLFW_KEY_BACKSPACE")
	public static var KEY_BACKSPACE:Int;
	@:native("GLFW_KEY_INSERT")
	public static var KEY_INSERT:Int;
	@:native("GLFW_KEY_DELETE")
	public static var KEY_DELETE:Int;
	@:native("GLFW_KEY_RIGHT")
	public static var KEY_RIGHT:Int;
	@:native("GLFW_KEY_LEFT")
	public static var KEY_LEFT:Int;
	@:native("GLFW_KEY_DOWN")
	public static var KEY_DOWN:Int;
	@:native("GLFW_KEY_UP")
	public static var KEY_UP:Int;
	@:native("GLFW_KEY_PAGE_UP")
	public static var KEY_PAGE_UP:Int;
	@:native("GLFW_KEY_PAGE_DOWN")
	public static var KEY_PAGE_DOWN:Int;
	@:native("GLFW_KEY_HOME")
	public static var KEY_HOME:Int;
	@:native("GLFW_KEY_END")
	public static var KEY_END:Int;
	@:native("GLFW_KEY_CAPS_LOCK")
	public static var KEY_CAPS_LOCK:Int;
	@:native("GLFW_KEY_SCROLL_LOCK")
	public static var KEY_SCROLL_LOCK:Int;
	@:native("GLFW_KEY_NUM_LOCK")
	public static var KEY_NUM_LOCK:Int;
	@:native("GLFW_KEY_PRINT_SCREEN")
	public static var KEY_PRINT_SCREEN:Int;
	@:native("GLFW_KEY_PAUSE")
	public static var KEY_PAUSE:Int;
	@:native("GLFW_KEY_F1")
	public static var KEY_F1:Int;
	@:native("GLFW_KEY_F2")
	public static var KEY_F2:Int;
	@:native("GLFW_KEY_F3")
	public static var KEY_F3:Int;
	@:native("GLFW_KEY_F4")
	public static var KEY_F4:Int;
	@:native("GLFW_KEY_F5")
	public static var KEY_F5:Int;
	@:native("GLFW_KEY_F6")
	public static var KEY_F6:Int;
	@:native("GLFW_KEY_F7")
	public static var KEY_F7:Int;
	@:native("GLFW_KEY_F8")
	public static var KEY_F8:Int;
	@:native("GLFW_KEY_F9")
	public static var KEY_F9:Int;
	@:native("GLFW_KEY_F10")
	public static var KEY_F10:Int;
	@:native("GLFW_KEY_F11")
	public static var KEY_F11:Int;
	@:native("GLFW_KEY_F12")
	public static var KEY_F12:Int;
	@:native("GLFW_KEY_F13")
	public static var KEY_F13:Int;
	@:native("GLFW_KEY_F14")
	public static var KEY_F14:Int;
	@:native("GLFW_KEY_F15")
	public static var KEY_F15:Int;
	@:native("GLFW_KEY_F16")
	public static var KEY_F16:Int;
	@:native("GLFW_KEY_F17")
	public static var KEY_F17:Int;
	@:native("GLFW_KEY_F18")
	public static var KEY_F18:Int;
	@:native("GLFW_KEY_F19")
	public static var KEY_F19:Int;
	@:native("GLFW_KEY_F20")
	public static var KEY_F20:Int;
	@:native("GLFW_KEY_F21")
	public static var KEY_F21:Int;
	@:native("GLFW_KEY_F22")
	public static var KEY_F22:Int;
	@:native("GLFW_KEY_F23")
	public static var KEY_F23:Int;
	@:native("GLFW_KEY_F24")
	public static var KEY_F24:Int;
	@:native("GLFW_KEY_F25")
	public static var KEY_F25:Int;
	@:native("GLFW_KEY_KP_0")
	public static var KEY_KP_0:Int;
	@:native("GLFW_KEY_KP_1")
	public static var KEY_KP_1:Int;
	@:native("GLFW_KEY_KP_2")
	public static var KEY_KP_2:Int;
	@:native("GLFW_KEY_KP_3")
	public static var KEY_KP_3:Int;
	@:native("GLFW_KEY_KP_4")
	public static var KEY_KP_4:Int;
	@:native("GLFW_KEY_KP_5")
	public static var KEY_KP_5:Int;
	@:native("GLFW_KEY_KP_6")
	public static var KEY_KP_6:Int;
	@:native("GLFW_KEY_KP_7")
	public static var KEY_KP_7:Int;
	@:native("GLFW_KEY_KP_8")
	public static var KEY_KP_8:Int;
	@:native("GLFW_KEY_KP_9")
	public static var KEY_KP_9:Int;
	@:native("GLFW_KEY_KP_DECIMAL")
	public static var KEY_KP_DECIMAL:Int;
	@:native("GLFW_KEY_KP_DIVIDE")
	public static var KEY_KP_DIVIDE:Int;
	@:native("GLFW_KEY_KP_MULTIPLY")
	public static var KEY_KP_MULTIPLY:Int;
	@:native("GLFW_KEY_KP_SUBTRACT")
	public static var KEY_KP_SUBTRACT:Int;
	@:native("GLFW_KEY_KP_ADD")
	public static var KEY_KP_ADD:Int;
	@:native("GLFW_KEY_KP_ENTER")
	public static var KEY_KP_ENTER:Int;
	@:native("GLFW_KEY_KP_EQUAL")
	public static var KEY_KP_EQUAL:Int;
	@:native("GLFW_KEY_LEFT_SHIFT")
	public static var KEY_LEFT_SHIFT:Int;
	@:native("GLFW_KEY_LEFT_CONTROL")
	public static var KEY_LEFT_CONTROL:Int;
	@:native("GLFW_KEY_LEFT_ALT")
	public static var KEY_LEFT_ALT:Int;
	@:native("GLFW_KEY_LEFT_SUPER")
	public static var KEY_LEFT_SUPER:Int;
	@:native("GLFW_KEY_RIGHT_SHIFT")
	public static var KEY_RIGHT_SHIFT:Int;
	@:native("GLFW_KEY_RIGHT_CONTROL")
	public static var KEY_RIGHT_CONTROL:Int;
	@:native("GLFW_KEY_RIGHT_ALT")
	public static var KEY_RIGHT_ALT:Int;
	@:native("GLFW_KEY_RIGHT_SUPER")
	public static var KEY_RIGHT_SUPER:Int;
	@:native("GLFW_KEY_MENU")
	public static var KEY_MENU:Int;
	@:native("GLFW_KEY_LAST")
	public static var KEY_LAST:Int;

	@:native("GLFW_MOD_SHIFT")
	public static var MOD_SHIFT:Int;
	@:native("GLFW_MOD_CONTROL")
	public static var MOD_CONTROL:Int;
	@:native("GLFW_MOD_ALT")
	public static var MOD_ALT:Int;
	@:native("GLFW_MOD_SUPER")
	public static var MOD_SUPER:Int;
	@:native("GLFW_MOD_CAPS_LOCK")
	public static var MOD_CAPS_LOCK:Int;
	@:native("GLFW_MOD_NUM_LOCK")
	public static var MOD_NUM_LOCK:Int;

	@:native("GLFW_MOUSE_BUTTON_1")
	public static var MOUSE_BUTTON_1:Int;
	@:native("GLFW_MOUSE_BUTTON_2")
	public static var MOUSE_BUTTON_2:Int;
	@:native("GLFW_MOUSE_BUTTON_3")
	public static var MOUSE_BUTTON_3:Int;
	@:native("GLFW_MOUSE_BUTTON_4")
	public static var MOUSE_BUTTON_4:Int;
	@:native("GLFW_MOUSE_BUTTON_5")
	public static var MOUSE_BUTTON_5:Int;
	@:native("GLFW_MOUSE_BUTTON_6")
	public static var MOUSE_BUTTON_6:Int;
	@:native("GLFW_MOUSE_BUTTON_7")
	public static var MOUSE_BUTTON_7:Int;
	@:native("GLFW_MOUSE_BUTTON_8")
	public static var MOUSE_BUTTON_8:Int;
	@:native("GLFW_MOUSE_BUTTON_LAST")
	public static var MOUSE_BUTTON_LAST:Int;
	@:native("GLFW_MOUSE_BUTTON_LEFT")
	public static var MOUSE_BUTTON_LEFT:Int;
	@:native("GLFW_MOUSE_BUTTON_RIGHT")
	public static var MOUSE_BUTTON_RIGHT:Int;
	@:native("GLFW_MOUSE_BUTTON_MIDDLE")
	public static var MOUSE_BUTTON_MIDDLE:Int;

	@:native("GLFW_JOYSTICK_1")
	public static var JOYSTICK_1:Int;
	@:native("GLFW_JOYSTICK_2")
	public static var JOYSTICK_2:Int;
	@:native("GLFW_JOYSTICK_3")
	public static var JOYSTICK_3:Int;
	@:native("GLFW_JOYSTICK_4")
	public static var JOYSTICK_4:Int;
	@:native("GLFW_JOYSTICK_5")
	public static var JOYSTICK_5:Int;
	@:native("GLFW_JOYSTICK_6")
	public static var JOYSTICK_6:Int;
	@:native("GLFW_JOYSTICK_7")
	public static var JOYSTICK_7:Int;
	@:native("GLFW_JOYSTICK_8")
	public static var JOYSTICK_8:Int;
	@:native("GLFW_JOYSTICK_9")
	public static var JOYSTICK_9:Int;
	@:native("GLFW_JOYSTICK_10")
	public static var JOYSTICK_10:Int;
	@:native("GLFW_JOYSTICK_11")
	public static var JOYSTICK_11:Int;
	@:native("GLFW_JOYSTICK_12")
	public static var JOYSTICK_12:Int;
	@:native("GLFW_JOYSTICK_13")
	public static var JOYSTICK_13:Int;
	@:native("GLFW_JOYSTICK_14")
	public static var JOYSTICK_14:Int;
	@:native("GLFW_JOYSTICK_15")
	public static var JOYSTICK_15:Int;
	@:native("GLFW_JOYSTICK_16")
	public static var JOYSTICK_16:Int;
	@:native("GLFW_JOYSTICK_LAST")
	public static var JOYSTICK_LAST:Int;

	@:native("GLFW_GAMEPAD_BUTTON_A")
	public static var GAMEPAD_BUTTON_A:Int;
	@:native("GLFW_GAMEPAD_BUTTON_B")
	public static var GAMEPAD_BUTTON_B:Int;
	@:native("GLFW_GAMEPAD_BUTTON_X")
	public static var GAMEPAD_BUTTON_X:Int;
	@:native("GLFW_GAMEPAD_BUTTON_Y")
	public static var GAMEPAD_BUTTON_Y:Int;
	@:native("GLFW_GAMEPAD_BUTTON_LEFT_BUMPER")
	public static var GAMEPAD_BUTTON_LEFT_BUMPER:Int;
	@:native("GLFW_GAMEPAD_BUTTON_RIGHT_BUMPER")
	public static var GAMEPAD_BUTTON_RIGHT_BUMPER:Int;
	@:native("GLFW_GAMEPAD_BUTTON_BACK")
	public static var GAMEPAD_BUTTON_BACK:Int;
	@:native("GLFW_GAMEPAD_BUTTON_START")
	public static var GAMEPAD_BUTTON_START:Int;
	@:native("GLFW_GAMEPAD_BUTTON_GUIDE")
	public static var GAMEPAD_BUTTON_GUIDE:Int;
	@:native("GLFW_GAMEPAD_BUTTON_LEFT_THUMB")
	public static var GAMEPAD_BUTTON_LEFT_THUMB:Int;
	@:native("GLFW_GAMEPAD_BUTTON_RIGHT_THUMB")
	public static var GAMEPAD_BUTTON_RIGHT_THUMB:Int;
	@:native("GLFW_GAMEPAD_BUTTON_DPAD_UP")
	public static var GAMEPAD_BUTTON_DPAD_UP:Int;
	@:native("GLFW_GAMEPAD_BUTTON_DPAD_RIGHT")
	public static var GAMEPAD_BUTTON_DPAD_RIGHT:Int;
	@:native("GLFW_GAMEPAD_BUTTON_DPAD_DOWN")
	public static var GAMEPAD_BUTTON_DPAD_DOWN:Int;
	@:native("GLFW_GAMEPAD_BUTTON_DPAD_LEFT")
	public static var GAMEPAD_BUTTON_DPAD_LEFT:Int;
	@:native("GLFW_GAMEPAD_BUTTON_LAST")
	public static var GAMEPAD_BUTTON_LAST:Int;
	@:native("GLFW_GAMEPAD_BUTTON_CROSS")
	public static var GAMEPAD_BUTTON_CROSS:Int;
	@:native("GLFW_GAMEPAD_BUTTON_CIRCLE")
	public static var GAMEPAD_BUTTON_CIRCLE:Int;
	@:native("GLFW_GAMEPAD_BUTTON_SQUARE")
	public static var GAMEPAD_BUTTON_SQUARE:Int;
	@:native("GLFW_GAMEPAD_BUTTON_TRIANGLE")
	public static var GAMEPAD_BUTTON_TRIANGLE:Int;
    
	@:native("GLFW_GAMEPAD_AXIS_LEFT_X")
	public static var GAMEPAD_AXIS_LEFT_X:Int;
	@:native("GLFW_GAMEPAD_AXIS_LEFT_Y")
	public static var GAMEPAD_AXIS_LEFT_Y:Int;
	@:native("GLFW_GAMEPAD_AXIS_RIGHT_X")
	public static var GAMEPAD_AXIS_RIGHT_X:Int;
	@:native("GLFW_GAMEPAD_AXIS_RIGHT_Y")
	public static var GAMEPAD_AXIS_RIGHT_Y:Int;
	@:native("GLFW_GAMEPAD_AXIS_LEFT_TRIGGER")
	public static var GAMEPAD_AXIS_LEFT_TRIGGER:Int;
	@:native("GLFW_GAMEPAD_AXIS_RIGHT_TRIGGER")
	public static var GAMEPAD_AXIS_RIGHT_TRIGGER:Int;
	@:native("GLFW_GAMEPAD_AXIS_LAST")
	public static var GAMEPAD_AXIS_LAST:Int;

	@:native("GLFW_NO_ERROR")
	public static var NO_ERROR:Int;
	@:native("GLFW_NOT_INITIALIZED")
	public static var NOT_INITIALIZED:Int;
	@:native("GLFW_NO_CURRENT_CONTEXT")
	public static var NO_CURRENT_CONTEXT:Int;
	@:native("GLFW_INVALID_ENUM")
	public static var INVALID_ENUM:Int;
	@:native("GLFW_INVALID_VALUE")
	public static var INVALID_VALUE:Int;
	@:native("GLFW_OUT_OF_MEMORY")
	public static var OUT_OF_MEMORY:Int;
	@:native("GLFW_API_UNAVAILABLE")
	public static var API_UNAVAILABLE:Int;
	@:native("GLFW_VERSION_UNAVAILABLE")
	public static var VERSION_UNAVAILABLE:Int;
	@:native("GLFW_PLATFORM_ERROR")
	public static var PLATFORM_ERROR:Int;
	@:native("GLFW_FORMAT_UNAVAILABLE")
	public static var FORMAT_UNAVAILABLE:Int;
	@:native("GLFW_NO_WINDOW_CONTEXT")
	public static var NO_WINDOW_CONTEXT:Int;

	@:native("GLFW_FOCUSED")
	public static var FOCUSED:Int;
	@:native("GLFW_ICONIFIED")
	public static var ICONIFIED:Int;
	@:native("GLFW_RESIZABLE")
	public static var RESIZABLE:Int;
	@:native("GLFW_VISIBLE")
	public static var VISIBLE:Int;
	@:native("GLFW_DECORATED")
	public static var DECORATED:Int;
	@:native("GLFW_AUTO_ICONIFY")
	public static var AUTO_ICONIFY:Int;
	@:native("GLFW_FLOATING")
	public static var FLOATING:Int;
	@:native("GLFW_MAXIMIZED")
	public static var MAXIMIZED:Int;
	@:native("GLFW_CENTER_CURSOR")
	public static var CENTER_CURSOR:Int;
	@:native("GLFW_TRANSPARENT_FRAMEBUFFER")
	public static var TRANSPARENT_FRAMEBUFFER:Int;
	@:native("GLFW_HOVERED")
	public static var HOVERED:Int;
	@:native("GLFW_FOCUS_ON_SHOW")
	public static var FOCUS_ON_SHOW:Int;
	@:native("GLFW_RED_BITS")
	public static var RED_BITS:Int;
	@:native("GLFW_GREEN_BITS")
	public static var GREEN_BITS:Int;
	@:native("GLFW_BLUE_BITS")
	public static var BLUE_BITS:Int;
	@:native("GLFW_ALPHA_BITS")
	public static var ALPHA_BITS:Int;
	@:native("GLFW_DEPTH_BITS")
	public static var DEPTH_BITS:Int;
	@:native("GLFW_STENCIL_BITS")
	public static var STENCIL_BITS:Int;
	@:native("GLFW_ACCUM_RED_BITS")
	public static var ACCUM_RED_BITS:Int;
	@:native("GLFW_ACCUM_GREEN_BITS")
	public static var ACCUM_GREEN_BITS:Int;
	@:native("GLFW_ACCUM_BLUE_BITS")
	public static var ACCUM_BLUE_BITS:Int;
	@:native("GLFW_ACCUM_ALPHA_BITS")
	public static var ACCUM_ALPHA_BITS:Int;
	@:native("GLFW_AUX_BUFFERS")
	public static var AUX_BUFFERS:Int;
	@:native("GLFW_STEREO")
	public static var STEREO:Int;
	@:native("GLFW_SAMPLES")
	public static var SAMPLES:Int;
	@:native("GLFW_SRGB_CAPABLE")
	public static var SRGB_CAPABLE:Int;
	@:native("GLFW_REFRESH_RATE")
	public static var REFRESH_RATE:Int;
	@:native("GLFW_DOUBLEBUFFER")
	public static var DOUBLEBUFFER:Int;
	@:native("GLFW_CLIENT_API")
	public static var CLIENT_API:Int;
	@:native("GLFW_CONTEXT_VERSION_MAJOR")
	public static var CONTEXT_VERSION_MAJOR:Int;
	@:native("GLFW_CONTEXT_VERSION_MINOR")
	public static var CONTEXT_VERSION_MINOR:Int;
	@:native("GLFW_CONTEXT_REVISION")
	public static var CONTEXT_REVISION:Int;
	@:native("GLFW_CONTEXT_ROBUSTNESS")
	public static var CONTEXT_ROBUSTNESS:Int;
	@:native("GLFW_OPENGL_FORWARD_COMPAT")
	public static var OPENGL_FORWARD_COMPAT:Int;
	@:native("GLFW_OPENGL_DEBUG_CONTEXT")
	public static var OPENGL_DEBUG_CONTEXT:Int;
	@:native("GLFW_OPENGL_PROFILE")
	public static var OPENGL_PROFILE:Int;
	@:native("GLFW_CONTEXT_RELEASE_BEHAVIOR")
	public static var CONTEXT_RELEASE_BEHAVIOR:Int;
	@:native("GLFW_CONTEXT_NO_ERROR")
	public static var CONTEXT_NO_ERROR:Int;
	@:native("GLFW_CONTEXT_CREATION_API")
	public static var CONTEXT_CREATION_API:Int;
	@:native("GLFW_SCALE_TO_MONITOR")
	public static var SCALE_TO_MONITOR:Int;
	@:native("GLFW_COCOA_RETINA_FRAMEBUFFER")
	public static var COCOA_RETINA_FRAMEBUFFER:Int;
	@:native("GLFW_COCOA_FRAME_NAME")
	public static var COCOA_FRAME_NAME:Int;
	@:native("GLFW_COCOA_GRAPHICS_SWITCHING")
	public static var COCOA_GRAPHICS_SWITCHING:Int;
	@:native("GLFW_X11_CLASS_NAME")
	public static var X11_CLASS_NAME:Int;
	@:native("GLFW_X11_INSTANCE_NAME")
	public static var X11_INSTANCE_NAME:Int;
	@:native("GLFW_NO_API")
	public static var NO_API:Int;
	@:native("GLFW_OPENGL_API")
	public static var OPENGL_API:Int;
	@:native("GLFW_OPENGL_ES_API")
	public static var OPENGL_ES_API:Int;
	@:native("GLFW_NO_ROBUSTNESS")
	public static var NO_ROBUSTNESS:Int;
	@:native("GLFW_NO_RESET_NOTIFICATION")
	public static var NO_RESET_NOTIFICATION:Int;
	@:native("GLFW_LOSE_CONTEXT_ON_RESET")
	public static var LOSE_CONTEXT_ON_RESET:Int;
	@:native("GLFW_OPENGL_ANY_PROFILE")
	public static var OPENGL_ANY_PROFILE:Int;
	@:native("GLFW_OPENGL_CORE_PROFILE")
	public static var OPENGL_CORE_PROFILE:Int;
	@:native("GLFW_OPENGL_COMPAT_PROFILE")
	public static var OPENGL_COMPAT_PROFILE:Int;
	@:native("GLFW_CURSOR")
	public static var CURSOR:Int;
	@:native("GLFW_STICKY_KEYS")
	public static var STICKY_KEYS:Int;
	@:native("GLFW_STICKY_MOUSE_BUTTONS")
	public static var STICKY_MOUSE_BUTTONS:Int;
	@:native("GLFW_LOCK_KEY_MODS")
	public static var LOCK_KEY_MODS:Int;
	@:native("GLFW_RAW_MOUSE_MOTION")
	public static var RAW_MOUSE_MOTION:Int;
	@:native("GLFW_CURSOR_NORMAL")
	public static var CURSOR_NORMAL:Int;
	@:native("GLFW_CURSOR_HIDDEN")
	public static var CURSOR_HIDDEN:Int;
	@:native("GLFW_CURSOR_DISABLED")
	public static var CURSOR_DISABLED:Int;
	@:native("GLFW_ANY_RELEASE_BEHAVIOR")
	public static var ANY_RELEASE_BEHAVIOR:Int;
	@:native("GLFW_RELEASE_BEHAVIOR_FLUSH")
	public static var RELEASE_BEHAVIOR_FLUSH:Int;
	@:native("GLFW_RELEASE_BEHAVIOR_NONE")
	public static var RELEASE_BEHAVIOR_NONE:Int;
	@:native("GLFW_NATIVE_CONTEXT_API")
	public static var NATIVE_CONTEXT_API:Int;
	@:native("GLFW_EGL_CONTEXT_API")
	public static var EGL_CONTEXT_API:Int;
	@:native("GLFW_OSMESA_CONTEXT_API")
	public static var OSMESA_CONTEXT_API:Int;
	@:native("GLFW_ARROW_CURSOR")
	public static var ARROW_CURSOR:Int;
	@:native("GLFW_IBEAM_CURSOR")
	public static var IBEAM_CURSOR:Int;
	@:native("GLFW_CROSSHAIR_CURSOR")
	public static var CROSSHAIR_CURSOR:Int;
	@:native("GLFW_HAND_CURSOR")
	public static var HAND_CURSOR:Int;
	@:native("GLFW_HRESIZE_CURSOR")
	public static var HRESIZE_CURSOR:Int;
	@:native("GLFW_VRESIZE_CURSOR")
	public static var VRESIZE_CURSOR:Int;
	@:native("GLFW_CONNECTED")
	public static var CONNECTED:Int;
	@:native("GLFW_DISCONNECTED")
	public static var DISCONNECTED:Int;
	@:native("GLFW_JOYSTICK_HAT_BUTTONS")
	public static var JOYSTICK_HAT_BUTTONS:Int;
	@:native("GLFW_COCOA_CHDIR_RESOURCES")
	public static var COCOA_CHDIR_RESOURCES:Int;
	@:native("GLFW_COCOA_MENUBAR")
	public static var COCOA_MENUBAR:Int;
	@:native("GLFW_DONT_CARE")
	public static var DONT_CARE:Int; 

    @:native("glfwInit")
    public static function init():Int;

    @:native("glfwTerminate")
    public static function terminate():Void;

    @:native("glfwInitHint")
    public static function initHint(hint:Int, value:Int):Void;

    @:native("glfwGetVersion")
    public static function getVersion(major:Pointer<Int>, minor:Pointer<Int>, rev:Pointer<Int>):Void;

    @:native("glfwGetVersionString")
    public static function _getVersionString():ConstCharStar;

    public static inline function getVersionString():String
        return _getVersionString().toString();

    @:native("glfwGetError")
    public static function getError(desc:Pointer<ConstCharStar>):Int;

    @:native("glfwSetErrorCallback")
    public static function setErrorCallback(func:ErrorFunc):ErrorFunc;

    @:native("glfwGetMonitors")
    public static function getMonitors(count:Pointer<Int>):Pointer<GlfwMonitor>;

    @:native("glfwGetPrimaryMonitor")
    public static function getPrimaryMonitor():GlfwMonitor;

    @:native("glfwGetMonitorPos")
    public static function getMonitorPos(monitor:GlfwMonitor, xPos:Pointer<Int>, yPos:Pointer<Int>):Void;

    @:native("glfwGetMonitorWorkarea")
    public static function getMonitorWorkarea(monitor:GlfwMonitor, xPos:Pointer<Int>, yPos:Pointer<Int>, width:Pointer<Int>, height:Pointer<Int>):Void;

    @:native("glfwGetMonitorPhysicalSize")
    public static function getMonitorPhysicalSize(monitor:GlfwMonitor, widthMM:Pointer<Int>, heightMM:Pointer<Int>):Void;

    @:native("glfwGetMonitorContentScale")
    public static function getMonitorContentScale(monitor:GlfwMonitor, xScale:Pointer<Float>, yScale:Pointer<Float>):Void;

    @:native("getMonitorName")
    public static function _getMonitorName(monitor:GlfwMonitor):ConstCharStar;

    public static inline function getMonitorName(monitor:GlfwMonitor):String
        return _getMonitorName(monitor).toString();

    @:native("glfwSetMonitorUserPointer")
    public static function setMonitorUserPointer(monitor:GlfwMonitor, pointer:Pointer<cpp.Void>):Void;

    @:native("glfwGetMonitorUserPointer")
    public static function getMonitorUserPointer(monitor:GlfwMonitor):Pointer<cpp.Void>;

    @:native("glfwSetMonitorCallback")
    public static function setMonitorCallback(callback:MonitorFunc):MonitorFunc;

    @:native("glfwGetVideoModes")
    public static function getVideoModes(monitor:GlfwMonitor, count:Pointer<Int>):cpp.ConstPointer<VideoMode>;

    @:native("glfwGetVideoMode")
    public static function getVideoMode(monitor:GlfwMonitor):cpp.ConstPointer<VideoMode>;

    @:native("glfwSetGamma")
    public static function setGamma(monitor:GlfwMonitor, gamma:Float):Void;

    @:native("glfwGetGammaRamp")
    public static function getGammaRamp(monitor:GlfwMonitor):ConstPointer<GammaRamp>;

    @:native("glfwSetGammaRamp")
    public static function setGammaRamp(monitor:GlfwMonitor, ramp:ConstPointer<GammaRamp>):Void;

    @:native("glfwDefaultWindowHints")
    public static function defaultWindowHints():Void;

    @:native("glfwWindowHint")
    public static function windowHint(hint:Int, value:Int):Void;

    @:native("glfwWindowHintString")
    public static function windowHintString(hint:Int, value:ConstCharStar):Void;

    @:native("glfwCreateWindow")
    public static function createWindow(width:Int, height:Int, title:ConstCharStar, monitor:GlfwMonitor, share:GlfwWindow):GlfwWindow;

    @:native("glfwDestroyWindow")
    public static function destroyWindow(window:GlfwWindow):Void;
    
    @:native("glfwWindowShouldClose")
    public static function _windowShouldClose(window:GlfwWindow):Int;

    public static inline function windowShouldClose(window:GlfwWindow):Bool
        return _windowShouldClose(window) != 0;

    @:native("glfwSetWindowShouldClose")
    public static function setWindowShouldClose(window:GlfwWindow, value:Int):Void;

    @:native("glfwSetWindowTitle")
    public static function setWindowTitle(window:GlfwWindow, title:ConstCharStar):Void;

    @:native("glfwSetWindowIcon") //TODO: When the Blueprint Texture is finished, make a function for using that for icons.
    public static function setWindowIcon(window:GlfwWindow, count:Int, images:ConstPointer<GlfwImage>):Void;

    @:native("glfwGetWindowPos")
    public static function getWindowPos(window:GlfwWindow, xPos:Pointer<Int>, yPos:Pointer<Int>):Void;

    @:native("glfwSetWindowPos")
    public static function setWindowPos(window:GlfwWindow, xPos:Int, yPos:Int):Void;

    @:native("glfwGetWindowSize")
    public static function getWindowSize(window:GlfwWindow, width:Pointer<Int>, height:Pointer<Int>):Void;

    @:native("glfwSetWindowSizeLimits")
    public static function setWindowSizeLimits(window:GlfwWindow, minWidth:Int, minHeight:Int, maxWidth:Int, maxHeight:Int):Void;

    @:native("glfwSetWindowAspectRatio")
    public static function setWindowAspectRatio(window:GlfwWindow, numerator:Int, denominator:Int):Void;

    @:native("glfwSetWindowSize")
    public static function setWindowSize(window:GlfwWindow, width:Int, height:Int):Void;

    @:native("glfwGetFramebufferSize")
    public static function getFramebufferSize(window:GlfwWindow, width:Pointer<Int>, height:Pointer<Int>):Void;

    @:native("glfwGetWindowFrameSize")
    public static function getWindowFrameSize(window:GlfwWindow, left:Pointer<Int>, top:Pointer<Int>, right:Pointer<Int>, bottom:Pointer<Int>):Void;

    @:native("glfwGetWindowContentScale")
    public static function getWindowContentScale(window:GlfwWindow, xScale:Pointer<Float>, yScale:Pointer<Float>):Void;

    @:native("glfwGetWindowOpacity")
    public static function getWindowOpacity(window:GlfwWindow):Float;

    @:native("glfwSetWindowOpacity")
    public static function setWindowOpacity(window:GlfwWindow, opacity:Float):Void;

    @:native("iconifyWindow")
    public static function glfwIconifyWindow(window:GlfwWindow):Void;

    @:native("glfwRestoreWindow")
    public static function restoreWindow(window:GlfwWindow):Void;

    @:native("glfwMaximizeWindow")
    public static function maximizeWindow(window:GlfwWindow):Void;

    @:native("glfwShowWindow")
    public static function showWindow(window:GlfwWindow):Void;

    @:native("glfwHideWindow")
    public static function hideWindow(window:GlfwWindow):Void;

    @:native("glfwFocusWindow")
    public static function focusWindow(window:GlfwWindow):Void;

    @:native("glfwRequestWindowAttention")
    public static function requestWindowAttention(window:GlfwWindow):Void;

    @:native("getWindowMonitor")
    public static function glfwGetWindowMonitor(window:GlfwWindow):GlfwMonitor;
        
    @:native("glfwSetWindowMonitor")
    public static function setWindowMonitor(window:GlfwWindow, monitor:GlfwMonitor, xPos:Int, yPos:Int, width:Int, height:Int, refreshRate:Int):Void;

    @:native("glfwGetWindowAttrib")
    public static function getWindowAttribute(window:GlfwWindow, attribute:Int):Int;

    @:native("glfwSetWindowAttrib")
    public static function setWindowAttribute(window:GlfwWindow, attribute:Int, value:Int):Void;

    @:native("glfwSetWindowUserPointer")
    public static function setWindowUserPointer(window:GlfwWindow, pointer:Pointer<cpp.Void>):Void;

    @:native("glfwGetWindowUserPointer")
    public static function getWindowUserPointer(window:GlfwWindow):Pointer<cpp.Void>;

    @:native("glfwSetWindowPosCallback")
    public static function setWindowPosCallback(window:GlfwWindow, callback:WindowPosFunc):WindowPosFunc;

    @:native("glfwSetWindowSizeCallback")
    public static function setWindowSizeCallback(window:GlfwWindow, callback:WindowSizeFunc):WindowSizeFunc;

    @:native("glfwSetWindowCloseCallback")
    public static function setWindowCloseCallback(window:GlfwWindow, callback:WindowCloseFunc):WindowCloseFunc;

    @:native("glfwSetWindowRefreshCallback")
    public static function setWindowRefreshCallback(window:GlfwWindow, callback:WindowRefreshFunc):WindowRefreshFunc;

    @:native("glfwSetWindowFocusCallback")
    public static function setWindowFocusCallback(window:GlfwWindow, callback:WindowFocusFunc):WindowFocusFunc;

    @:native("glfwSetWindowIconifyCallback")
    public static function setWindowIconifyCallback(window:GlfwWindow, callback:WindowIconifyFunc):WindowIconifyFunc;

    @:native("glfwSetWindowMaximizeCallback")
    public static function setWindowMaximizeCallback(window:GlfwWindow, callback:WindowMaximizeFunc):WindowMaximizeFunc;

    @:native("glfwSetFramebufferSizeCallback")
    public static function setFramebufferSizeCallback(window:GlfwWindow, callback:FrameBufferSizeFunc):FrameBufferSizeFunc;

    @:native("glfwSetWindowContentScaleCallback")
    public static function setWindowContentScaleCallback(window:GlfwWindow, callback:WindowContentScaleFunc):WindowContentScaleFunc;

    @:native("glfwPollEvents")
    public static function pollEvents():Void;

    @:native("glfwWaitEvents")
    public static function waitEvents():Void;

    @:native("glfwWaitEventsTimeout")
    public static function waitEventsTimeout(timeout:Float):Void;

    @:native("glfwPostEmptyEvent")
    public static function postEmptyEvent():Void;

    @:native("glfwGetInputMode")
    public static function getInputMode(window:GlfwWindow, mode:Int):Int;

    @:native("glfwSetInputMode")
    public static function setInputMode(window:GlfwWindow, mode:Int, value:Int):Void;

    @:native("glfwRawMouseMotionSupported")
    public static function _rawMouseMotionSupported():Int;

    public static inline function rawMouseMotionSupported():Bool
        return _rawMouseMotionSupported() != 0;

    @:native("glfwGetKeyName")
    public static function _getKeyName(key:Int, scancode:Int):ConstCharStar;

    public static inline function getKeyName(key:Int, scancode:Int):String
        return _getKeyName(key, scancode).toString();

    @:native("glfwGetKeyScancode")
    public static function getKeyScancode(key:Int):Int;

    @:native("glfwGetKey")
    public static function getKey(window:GlfwWindow, key:Int):Void;

    @:native("glfwGetCursorPos")
    public static function getCursorPos(window:GlfwWindow, xPos:Pointer<Float>, yPos:Pointer<Float>):Void;

    @:native("glfwSetCursorPos")
    public static function setCursorPos(window:GlfwWindow, xPos:Float, yPos:Float):Void;

    @:native("glfwCreateCursor")
    public static function createCursor(image:ConstPointer<GlfwImage>, hotspotX:Int, hotspotY:Int):GlfwCursor;

    @:native("glfwCreateStandardCursor")
    public static function createStandardCursor(shape:Int):GlfwCursor;

    @:native("glfwDestroyCursor")
    public static function destroyCursor(cursor:GlfwCursor):Void;

    @:native("glfwSetCursor")
    public static function setCursor(window:GlfwWindow, cursor:GlfwCursor):Void;

    @:native("glfwSetKeyCallback")
    public static function setKeyCallback(window:GlfwWindow, callback:KeyInputFunc):KeyInputFunc;

    @:native("glfwSetCharCallback")
    public static function setCharCallback(window:GlfwWindow, callback:CharFunc):CharFunc;

    @:native("glfwSetCharModsCallback")
    public static function setCharModsCallback(window:GlfwWindow, callback:CharModsFunc):CharModsFunc;

    @:native("glfwSetMouseButtonCallback")
    public static function setMouseButtonCallback(window:GlfwWindow, callback:MouseButtonFunc):MouseButtonFunc;
    
    @:native("glfwSetCursorPosCallback")
    public static function setCursorPosCallback(window:GlfwWindow, callback:CursorPosFunc):CursorPosFunc;

    @:native("glfwSetCursorEnterCallback")
    public static function setCursorEnterCallback(window:GlfwWindow, callback:CursorEnterFunc):CursorEnterFunc;

    @:native("glfwSetScrollCallback")
    public static function setScrollCallback(window:GlfwWindow, callback:ScrollFunc):ScrollFunc;

    @:native("glfwSetDropCallback")
    public static function setDropCallback(window:GlfwWindow, callback:FileDropFunc):FileDropFunc;

    @:native("glfwJoystickPresent")
    public static function _joystickPresent(joystickID:Int):Int;

    public static inline function joystickPresent(joystickID:Int):Bool
        return _joystickPresent(joystickID) != 0;

    @:native("glfwGetJoystickAxes")
    public static function getJoystickAxes(joystickID:Int, count:Pointer<Int>):ConstPointer<Float>;

    @:native("glfwGetJoystickButtons")
    public static function getJoystickButtons(joystickID:Int, count:Pointer<Int>):cpp.ConstPointer<Int>;

    @:native("glfwGetJoystickHats")
    public static function getJoystickHats(joystickID:Int, count:Pointer<Int>):cpp.ConstPointer<Int>;

    @:native("glfwGetJoystickName")
    public static function _getJoystickName(joystickID:Int):ConstCharStar;
    
    public static inline function getJoystickName(joystickID:Int):String
        return _getJoystickName(joystickID).toString();

    @:native("glfwGetJoystickGUID")
    public static function _getJoystickGUID(joystickID:Int):ConstCharStar;

    public static inline function getJoystickGUID(joystickID:Int):String
        return _getJoystickGUID(joystickID).toString();

    @:native("glfwSetJoystickUserPointer")
    public static function setJoystickUserPointer(joystickID:Int, pointer:Pointer<cpp.Void>):Void;

    @:native("glfwGetJoystickUserPointer")
    public static function getJoystickUserPointer(joystickID:Int):Pointer<cpp.Void>;

    @:native("glfwJoystickIsGamepad")
    public static function _joystickIsGamepad(joystickID:Int):Int;

    public static inline function joystickIsGamepad(joystickID:Int):Bool
        return _joystickIsGamepad(joystickID) != 0;

    @:native("glfwSetJoystickCallback")
    public static function setJoystickCallback(callback:JoystickFunc):JoystickFunc;

    @:native("glfwUpdateGamepadMappings")
    public static function updateGamepadMappings(mappings:ConstCharStar):Int;

    @:native("glfwGetGamepadName")
    public static function _getGamepadName(gamepadID:Int):ConstCharStar;

    public static inline function getGamepadName(gamepadID:Int):String
        return _getGamepadName(gamepadID).toString();

    @:native("glfwGetGamepadState")
    public static function getGamepadState(gamepadID:Int, state:GamepadState):Int;

    @:native("glfwSetClipboardString")
    public static function setClipboardString(window:GlfwWindow, string:ConstCharStar):Void;

    @:native("glfwGetClipboardString")
    public static function _getClipboardString(window:GlfwWindow):ConstCharStar;

    public static inline function getClipboardString(window:GlfwWindow):String
        return _getClipboardString(window).toString();

    @:native("glfwGetTime")
    public static function getTime():Float;

    @:native("glfwSetTime")
    public static function setTime(time:Float):Void;

    @:native("glfwGetTimerValue")
    public static function getTimerValue():Int;

    @:native("glfwGetTimerFrequency")
    public static function getTimerFrequency():Int;

    @:native("glfwMakeContextCurrent")
    public static function makeContextCurrent(window:GlfwWindow):Void;

    @:native("glfwGetCurrentContext")
    public static function getCurrentContext():GlfwWindow;

    @:native("glfwSwapBuffers")
    public static function swapBuffers(window:GlfwWindow):Void;

    @:native("glfwSwapInterval")
    public static function swapInterval(interval:Int):Void;

    @:native("glfwExtensionSupported")
    public static function _extensionSupported(extension:ConstCharStar):Int;

    public static inline function extensionSupported(extension:String):Bool
        return _extensionSupported(ConstCharStar.fromString(extension)) != 0;

	@:native("glfwGetProcAddress")
    public static function getProcAddress(procName:ConstCharStar):Void;

    @:native("glfwVulkanSupported")
    public static function _vulkanSupported():Int;

    public static inline function vulkanSupported():Bool
        return _vulkanSupported() != 0;

    @:native("glfwGetRequiredInstanceExtensions")
    public static function getRequiredInstanceExtensions(count:Pointer<Int>):Pointer<ConstCharStar>;
}
#end