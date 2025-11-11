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


	public inline function signOf(val:Float)
		return val == 0 ? 0 : val / Math.abs(val); // where did i get this idea from again? i know i saw val / abs(val) somewhere


	public static function truncate(val:Float, places:Int) {
		final pow = Math.pow(10, places);
		return Math.floor(val * pow) / pow;
	}
	public static function roundBy(val:Float, places:Int) {
		final pow = Math.pow(10, places);
		return Math.round(val * pow) / pow;
	}


	public static inline function remapRange(val:Float, oldStart:Float, oldEnd:Float, newStart:Float, newEnd:Float)
		return ((val - oldStart) / (oldEnd - oldStart)) * (newEnd - newStart) + newStart;	


	public static function canLerp(a:Any) {
		return switch (Type.typeof(a)) {
			case TFloat | TInt: true;
			case TClass(Vector2Base) | TClass(Vector3Base) | TClass(Vector4Base): true;
			default: false;
		}
	}

	public static function lerpFloat(a:Float, b:Float, r:Float) {
		return lerp(a, b, r);
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
	overload extern public static inline function lerp(a:Float, b:Float, r:Float):Float
		return a + r * (b - a);
	overload extern public static inline function lerp(a:Vector2Base, b:Vector2Base, r:Float):Vector2Base
		return a.clone().lerpSelf(b, r);
	overload extern public static inline function lerp(a:Vector3Base, b:Vector3Base, r:Float):Vector3Base
		return a.clone().lerpSelf(b, r);
	overload extern public static inline function lerp(a:Vector4Base, b:Vector4Base, r:Float):Vector4Base
		return a.clone().lerpSelf(b, r);


	public static function wrapFloat(val:Float, min:Float, max:Float) {
		return wrap(val, min, max);
	}
	public static function wrapValue(val:Any, min:Any, max:Any):Dynamic {
		var valType = (val is Int) ? Type.ValueType.TFloat : Type.typeof(val);
		var minType = (min is Int) ? Type.ValueType.TFloat : Type.typeof(min);
		var maxType = (max is Int) ? Type.ValueType.TFloat : Type.typeof(max);
		if (!valType.equals(minType) || !minType.equals(maxType))
			return null;

		return switch (valType) {
			case TFloat:
				var val:Float = cast val;
				var min:Float = cast min;
				var max:Float = cast max;
				wrap(val, min, max);
			case TClass(Vector2Base):
				var val:Vector2Base = cast val;
				var min:Vector2Base = cast min;
				var max:Vector2Base = cast max;
				wrap(val, min, max);
			case TClass(Vector3Base):
				var val:Vector3Base = cast val;
				var min:Vector3Base = cast min;
				var max:Vector3Base = cast max;
				wrap(val, min, max);
			case TClass(Vector4Base):
				var val:Vector4Base = cast val;
				var min:Vector4Base = cast min;
				var max:Vector4Base = cast max;
				wrap(val, min, max);
			default: null;
		}
	}
	overload extern public static inline function wrap(val:Float, min:Float, max:Float):Float {
		final range = max - min;
		return (((val - min) % range) + range) % range + min;
	}
	overload extern public static inline function wrap(val:Vector2Base, min:Vector2Base, max:Vector2Base):Vector2Base
		return val.clone().wrapSelf(min, max);
	overload extern public static inline function wrap(val:Vector3Base, min:Vector3Base, max:Vector3Base):Vector3Base
		return val.clone().wrapSelf(min, max);
	overload extern public static inline function wrap(val:Vector4Base, min:Vector4Base, max:Vector4Base):Vector4Base
		return val.clone().wrapSelf(min, max);


	public static function clampFloat(val:Float, min:Float, max:Float) {
		return clamp(val, min, max);
	}
	public static function clampValue(val:Any, min:Any, max:Any):Dynamic {
		var valType = (val is Int) ? Type.ValueType.TFloat : Type.typeof(val);
		var minType = (min is Int) ? Type.ValueType.TFloat : Type.typeof(min);
		var maxType = (max is Int) ? Type.ValueType.TFloat : Type.typeof(max);
		if (!valType.equals(minType) || !minType.equals(maxType))
			return null;

		return switch (valType) {
			case TFloat:
				var val:Float = cast val;
				var min:Float = cast min;
				var max:Float = cast max;
				clamp(val, min, max);
			case TClass(Vector2Base):
				var val:Vector2Base = cast val;
				var min:Vector2Base = cast min;
				var max:Vector2Base = cast max;
				clamp(val, min, max);
			case TClass(Vector3Base):
				var val:Vector3Base = cast val;
				var min:Vector3Base = cast min;
				var max:Vector3Base = cast max;
				clamp(val, min, max);
			case TClass(Vector4Base):
				var val:Vector4Base = cast val;
				var min:Vector4Base = cast min;
				var max:Vector4Base = cast max;
				clamp(val, min, max);
			default: null;
		}
	}
	overload extern public static inline function clamp(val:Float, min:Float, max:Float):Float
		return Math.min(Math.max(val, min), max);
	overload extern public static inline function clamp(val:Vector2Base, min:Vector2Base, max:Vector2Base):Vector2Base
		return val.clone().clampSelf(min, max);
	overload extern public static inline function clamp(val:Vector3Base, min:Vector3Base, max:Vector3Base):Vector3Base
		return val.clone().clampSelf(min, max);
	overload extern public static inline function clamp(val:Vector4Base, min:Vector4Base, max:Vector4Base):Vector4Base
		return val.clone().clampSelf(min, max);
}
