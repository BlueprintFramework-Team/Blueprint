package math;

/**
 * Utilized from Droplet developed by Swordcube. (https://github.com/swordcube/Droplet-Framework/tree/master)
 */
abstract Vector4(Array<Float>) from Array<Float> to Array<Float> {
    public var x(get, set):Float;
    public var y(get, set):Float;
    public var z(get, set):Float;
    public var w(get, set):Float;

    public var magnitude(get, never):Float;

    public function new(?x:Float, ?y:Float, ?z:Float, ?w:Float) {
        set(x, y, z, w);
    }

    public inline function set(?x:Float, ?y:Float, ?z:Float, ?w:Float) {
        if (x == null) x = 0;
        if (y == null) y = x;
        if (z == null) z = y;
        if (w == null) w = z;

        this = [x, y, z, w];
    }

    @:op(A + B)
    public inline function add(vec:Vector4):Vector4 {
        var newVec:Vector4 = cast [];

        for (i in 0...4)
            newVec[i] = this[i] + vec[i];

        return newVec;
    }

    @:op(A - B)
    public inline function subtract(vec:Vector4):Vector4 {
        var newVec:Vector4 = cast [];

        for (i in 0...4)
            newVec[i] = this[i] - vec[i];

        return newVec;
    }

    @:op(A * B)
    public inline function multiply(vec:Vector4):Vector4 {
        var newVec:Vector4 = cast [];

        for (i in 0...4)
            newVec[i] = this[i] * vec[i];

        return newVec;
    }

    @:op(A / B)
    public inline function divide(vec:Vector4):Vector4 {
        var newVec:Vector4 = cast [];

        for (i in 0...4)
            newVec[i] = this[i] / vec[i];

        return newVec;
    }

    @:op(A + B)
    public inline function addFloat(add:Float):Vector4 {
        var newVec:Vector4 = cast [];

        for (i in 0...4)
            newVec[i] = this[i] + add;

        return newVec;
    }

    @:op(A - B)
    public inline function subFloat(sub:Float):Vector4 {
        var newVec:Vector4 = cast [];

        for (i in 0...4)
            newVec[i] = this[i] - sub;

        return newVec;
    }

    @:op(A * B)
    public inline function multFloat(mult:Float):Vector4 {
        var newVec:Vector4 = cast [];

        for (i in 0...4)
            newVec[i] = this[i] * mult;

        return newVec;
    }

    @:op(A / B)
    public inline function divFloat(div:Float):Vector4 {
        var newVec:Vector4 = cast [];

        for (i in 0...4)
            newVec[i] = this[i] / div;

        return newVec;
    }

    @:op(A += B)
    public inline function addEq(vec:Vector4):Vector4 {
        for (i in 0...4)
            this[i] += vec[i];

        return this;
    }

    @:op(A -= B)
    public inline function subtractEq(vec:Vector4):Vector4 {
        for (i in 0...4)
            this[i] -= vec[i];

        return this;
    }

    @:op(A *= B)
    public inline function multiplyEq(vec:Vector4):Vector4 {
        for (i in 0...4)
            this[i] *= vec[i];

        return this;
    }

    @:op(A /= B)
    public inline function divideEq(vec:Vector4):Vector4 {
        for (i in 0...4)
            this[i] /= vec[i];

        return this;
    }

    @:op(A += B)
    public inline function addFloatEq(add:Float):Vector4 {
        for (i in 0...4)
            this[i] += add;

        return this;
    }

    @:op(A -= B)
    public inline function subFloatEq(sub:Float):Vector4 {
        for (i in 0...4)
            this[i] -= sub;

        return this;
    }

    @:op(A *= B)
    public inline function multFloatEq(mult:Float):Vector4 {
        for (i in 0...4)
            this[i] *= mult;

        return this;
    }

    @:op(A /= B)
    public inline function divFloatEq(div:Float):Vector4 {
        for (i in 0...4)
            this[i] /= div;

        return this;
    }

    public inline function copyFrom(vec:Vector4) {
        set(vec.x, vec.y, vec.z, vec.w);
    }

    public function toStar():cpp.Star<cpp.Float32> {
        untyped __cpp__("
            float* _cArray = new float[4];
            for (int i = 0; i < 4; i++) {
                _cArray[i] = {0}->__get(i);
            }", this);
        return untyped __cpp__("_cArray");
    }

    @:noCompletion
    private inline function get_x():Float {
        return this[0];
    }

    @:noCompletion
    private inline function set_x(v:Float):Float {
        return this[0] = v;
    }

    @:noCompletion
    private inline function get_y():Float {
        return this[1];
    }

    @:noCompletion
    private inline function set_y(v:Float):Float {
        return this[1] = v;
    }

    @:noCompletion
    private inline function get_z():Float {
        return this[2];
    }

    @:noCompletion
    private inline function set_z(v:Float):Float {
        return this[2] = v;
    }

    @:noCompletion
    private inline function get_w():Float {
        return this[3];
    }

    @:noCompletion
    private inline function set_w(v:Float):Float {
        return this[3] = v;
    }

    public function get_magnitude() {
        var toSqrt:Float = 0;
        for (i in 0...4)
            toSqrt += this[i] * this[i];
        return Math.sqrt(toSqrt);
    }
}