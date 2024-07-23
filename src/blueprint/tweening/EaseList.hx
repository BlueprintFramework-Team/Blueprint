package blueprint.tweening;

/**
 * This class is a converted variation of the functions from [easings.net.](https://easings.net/)
 * 
 * The original function code can be found [here.](https://github.com/ai/easings.net/blob/master/src/easings/easingsFunctions.ts)
 */
@:headerCode("
const float EASE_PI = 3.1415926535897932385;
const float EASE_c1 = 1.70158;
const float EASE_c2 = EASE_c1 * 1.525;
const float EASE_c3 = EASE_c1 + 1.0;
const float EASE_c4 = (EASE_PI * 2.0) / 3.0;
const float EASE_c5 = (EASE_PI * 2.0) / 4.5;
")
class EaseList {
    @:native("EASE_c1")
    static extern var c1:Float;
    @:native("EASE_c2")
    static extern var c2:Float;
    @:native("EASE_c3")
    static extern var c3:Float;
    @:native("EASE_c4")
    static extern var c4:Float;
    @:native("EASE_c5")
    static extern var c5:Float;

    public static function linear(x:Float):Float {
        return x;
    }

	public static function quadIn(x:Float):Float {
		return x * x;
	}
	public static function quadOut(x:Float):Float {
		return 1 - (1 - x) * (1 - x);
	}
	public static function quadInOut(x:Float):Float {
		return x < 0.5 ? 2 * x * x : 1 - Math.pow(-2 * x + 2, 2) * 0.5;
	}
    
	public static function cubicIn(x:Float):Float {
		return x * x * x;
	}
	public static function cubicOut(x:Float):Float {
		return 1 - Math.pow(1 - x, 3);
	}
	public static function cubicInOut(x:Float):Float {
		return x < 0.5 ? 4 * x * x * x : 1 - Math.pow(-2 * x + 2, 3) * 0.5;
	}

	public static function quartIn(x:Float):Float {
		return x * x * x * x;
	}
	public static function quartOut(x:Float):Float {
		return 1 - Math.pow(1 - x, 4);
	}
	public static function quartInOut(x:Float):Float {
		return x < 0.5 ? 8 * x * x * x * x : 1 - Math.pow(-2 * x + 2, 4) * 0.5;
	}

	public static function quintIn(x:Float):Float {
		return x * x * x * x * x;
	}
	public static function quintOut(x:Float):Float {
		return 1 - Math.pow(1 - x, 5);
	}
	public static function quintInOut(x:Float):Float {
		return x < 0.5 ? 16 * x * x * x * x * x : 1 - Math.pow(-2 * x + 2, 5) * 0.5;
	}

	public static function sineIn(x:Float):Float {
		return 1 - Math.cos((x * Math.PI) * 0.5);
	}
	public static function sineOut(x:Float):Float {
		return Math.sin((x * Math.PI) * 0.5);
	}
	public static function sineInOut(x:Float):Float {
		return -(Math.cos(Math.PI * x) - 1) * 0.5;
	}

	public static function expoIn(x:Float):Float {
		return x == 0 ? 0 : Math.pow(2, 10 * x - 10);
	}
	public static function expoOut(x:Float):Float {
		return x == 1 ? 1 : 1 - Math.pow(2, -10 * x);
	}
	public static function expoInOut(x:Float):Float {
		return x == 0
			? 0
			: x == 1
			? 1
			: x < 0.5
			? Math.pow(2, 20 * x - 10) * 0.5
			: (2 - Math.pow(2, -20 * x + 10)) * 0.5;
	}

	public static function circIn(x:Float):Float {
		return 1 - Math.sqrt(1 - Math.pow(x, 2));
	}
	public static function circOut(x:Float):Float {
		return Math.sqrt(1 - Math.pow(x - 1, 2));
	}
	public static function circInOut(x:Float):Float {
		return x < 0.5
			? (1 - Math.sqrt(1 - Math.pow(2 * x, 2))) * 0.5
			: (Math.sqrt(1 - Math.pow(-2 * x + 2, 2)) + 1) * 0.5;
	}

	public static function backIn(x:Float):Float {
		return c3 * x * x * x - c1 * x * x;
	}
	public static function backOut(x:Float):Float {
		return 1 + c3 * Math.pow(x - 1, 3) + c1 * Math.pow(x - 1, 2);
	}
	public static function backInOut(x:Float):Float {
		return x < 0.5
			? (Math.pow(2 * x, 2) * ((c2 + 1) * 2 * x - c2)) * 0.5
			: (Math.pow(2 * x - 2, 2) * ((c2 + 1) * (x * 2 - 2) + c2) + 2) * 0.5;
	}

	public static function elasticIn(x:Float):Float {
		return x == 0
			? 0
			: x == 1
			? 1
			: -Math.pow(2, 10 * x - 10) * Math.sin((x * 10 - 10.75) * c4);
	}
	public static function elasticOut(x:Float):Float {
		return x == 0
			? 0
			: x == 1
			? 1
			: Math.pow(2, -10 * x) * Math.sin((x * 10 - 0.75) * c4) + 1;
	}
	public static function elasticInOut(x:Float):Float {
		return x == 0
			? 0
			: x == 1
			? 1
			: x < 0.5
			? -(Math.pow(2, 20 * x - 10) * Math.sin((20 * x - 11.125) * c5)) * 0.5
			: (Math.pow(2, -20 * x + 10) * Math.sin((20 * x - 11.125) * c5)) * 0.5 + 1;
	}
    
    static extern inline final n1 = 7.5625;
    static extern inline final d1 = 2.75;
	public static function bounceIn(x:Float):Float {
		return 1 - bounceOut(1 - x);
	}
	public static function bounceOut(x:Float):Float {
        if (x < 1 / d1)
            return n1 * x * x;
        else if (x < 2 / d1)
            return n1 * (x -= 1.5 / d1) * x + 0.75;
        else if (x < 2.5 / d1)
            return n1 * (x -= 2.25 / d1) * x + 0.9375;
        else
            return n1 * (x -= 2.625 / d1) * x + 0.984375;
    }
	public static function bounceInOut(x:Float):Float {
		return x < 0.5
			? (1 - bounceOut(1 - 2 * x)) * 0.5
			: (1 + bounceOut(2 * x - 1)) * 0.5;
	}
}