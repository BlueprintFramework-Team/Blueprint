package math;

class MathExtras {
    public static inline function toRad(deg:Float) {
        return deg * Math.PI / 180;
    }

    public static inline function toDeg(rad:Float) {
        return rad * 180 / Math.PI;
    }
}