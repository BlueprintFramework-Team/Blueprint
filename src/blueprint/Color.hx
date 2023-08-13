package blueprint;

// Credit to the HaxeFlixel team for making a decently simple Color abstract of their own that is used heavily here.
// https://github.com/HaxeFlixel/flixel/blob/master/flixel/util/FlxColor.hx
abstract Color(Int) from Int from UInt to UInt to Int {
	public static inline final TRANSPARENT:Color = 0x00000000;
	public static inline final WHITE:Color = 0xFFFFFFFF;
	public static inline final GRAY:Color = 0xFF808080;
	public static inline final BLACK:Color = 0xFF000000;

	public static inline final PINK:Color = 0xFFFFC0CB;
	public static inline final RED:Color = 0xFFFF0000;
	public static inline final ORANGE:Color = 0xFFFFA800;
	public static inline final YELLOW:Color = 0xFFFFFF00;
	public static inline final LIME:Color = 0xFF00FF00;
	public static inline final GREEN:Color = 0xFF008000;
	public static inline final CYAN:Color = 0xFF00FFFF;
	public static inline final BLUE:Color = 0xFF0000FF;
	public static inline final MAGENTA:Color = 0xFFFF00FF;
	public static inline final PURPLE:Color = 0xFF800080;

	public static inline final BROWN:Color = 0xFF8B4513;

	public var red(get, set):Int;
	public var green(get, set):Int;
	public var blue(get, set):Int;
	public var alpha(get, set):Int;

	public var redFloat(get, set):Float;
	public var greenFloat(get, set):Float;
	public var blueFloat(get, set):Float;
	public var alphaFloat(get, set):Float;

	public static inline function fromInt(value:Int):Color {
		return new Color(value);
	}

	public static inline function fromRGBA(r:Int, g:Int, b:Int, a:Int = 255):Color {
		var color:Color = new Color();
		color.red = r;
		color.green = g;
		color.blue = b;
		color.alpha = a;
		return color;
	}

	public static inline function fromFloat(r:Float, g:Float, b:Float, a:Float = 1.0):Color {
		var color:Color = new Color();
		color.redFloat = r;
		color.greenFloat = g;
		color.blueFloat = b;
		color.alphaFloat = a;
		return color;
	}

	public function new(value:Int = 0) {
		this = value;
	}

	private inline function get_red():Int {
		return (this >> 16) & 0xFF;
	}

	private inline function get_green():Int {
		return (this >> 8) & 0xFF;
	}

	private inline function get_blue():Int {
		return this & 0xFF;
	}

	private inline function get_alpha():Int {
		return (this >> 24) & 0xFF;
	}

	private inline function get_redFloat():Float {
		return red / 255;
	}

	private inline function get_greenFloat():Float {
		return green / 255;
	}

	private inline function get_blueFloat():Float {
		return blue / 255;
	}

	private inline function get_alphaFloat():Float {
		return alpha / 255;
	}

	private inline function set_red(Value:Int):Int {
		this &= 0xff00ffff;
		this |= boundChannel(Value) << 16;
		return Value;
	}

	private inline function set_green(Value:Int):Int {
		this &= 0xffff00ff;
		this |= boundChannel(Value) << 8;
		return Value;
	}

	private inline function set_blue(Value:Int):Int {
		this &= 0xffffff00;
		this |= boundChannel(Value);
		return Value;
	}

	private inline function set_alpha(Value:Int):Int {
		this &= 0x00ffffff;
		this |= boundChannel(Value) << 24;
		return Value;
	}

	private inline function set_redFloat(Value:Float):Float {
		red = Math.round(Value * 255);
		return Value;
	}

	private inline function set_greenFloat(Value:Float):Float {
		green = Math.round(Value * 255);
		return Value;
	}

	private inline function set_blueFloat(Value:Float):Float {
		blue = Math.round(Value * 255);
		return Value;
	}

	private inline function set_alphaFloat(Value:Float):Float {
		alpha = Math.round(Value * 255);
		return Value;
	}

	private inline function boundChannel(value:Int):Int {
		return value > 0xFF ? 0xFF : value < 0 ? 0 : value;
	}
}
