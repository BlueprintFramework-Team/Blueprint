package math;

import math.Vector2;
import math.Vector3;
import math.Vector4;

class MathExtras {
	public static inline function toRad(deg:Float) {
		return deg * Math.PI / 180;
	}

	public static inline function toDeg(rad:Float) {
		return rad * 180 / Math.PI;
	}

	public static function canLerp(a:Any) {
		return switch (Type.typeof(a)) {
			case TFloat | TInt: true;
			case TClass(Vector2Base) | TClass(Vector3Base) | TClass(Vector4Base): true;
			default: false;
		}
	}

	public static function lerpValue(a:Any, b:Any, r:Float):Dynamic {
		var aType = (a is Int) ? Type.ValueType.TFloat : Type.typeof(a);
		var bType = (b is Int) ? Type.ValueType.TFloat : Type.typeof(b);
		if (!aType.equals(bType))
			return null;

		return switch (aType) {
			case TFloat:
				var a:Float = cast a;
				var b:Float = cast b;
				lerp(a, b, r);
			case TClass(Vector2Base):
				var a:Vector2Base = cast a;
				var b:Vector2Base = cast b;
				lerp(a, b, r);
			case TClass(Vector3Base):
				var a:Vector3Base = cast a;
				var b:Vector3Base = cast b;
				lerp(a, b, r);
			case TClass(Vector4Base):
				var a:Vector4Base = cast a;
				var b:Vector4Base = cast b;
				lerp(a, b, r);
			default: null;
		}
	}

	overload extern public static inline function lerp(a:Float, b:Float, r:Float):Float {
		return a + r * (b - a);
	}

	overload extern public static inline function lerp(a:Vector2Base, b:Vector2Base, r:Float):Vector2Base {
		var newVector = new Vector2Base(a.x, a.y);
		newVector.x += r * (b.x - a.x);
		newVector.y += r * (b.y - a.y);
		return newVector;
	}

	overload extern public static inline function lerp(a:Vector3Base, b:Vector3Base, r:Float):Vector3Base {
		var newVector = new Vector3Base(a.x, a.y, a.z);
		newVector.x += r * (b.x - a.x);
		newVector.y += r * (b.y - a.y);
		newVector.z += r * (b.z - a.z);
		return newVector;
	}

	overload extern public static inline function lerp(a:Vector4Base, b:Vector4Base, r:Float):Vector4Base {
		var newVector = new Vector4Base(a.x, a.y, a.z, a.w);
		newVector.x += r * (b.x - a.x);
		newVector.y += r * (b.y - a.y);
		newVector.z += r * (b.z - a.z);
		newVector.w += r * (b.w - a.w);
		return newVector;
	}
}
