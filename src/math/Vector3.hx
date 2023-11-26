package math;

/**
 * Utilized from Droplet developed by Swordcube. (https://github.com/swordcube/Droplet-Framework/tree/master)
 */
abstract Vector3(Array<Float>) from Array<Float> to Array<Float> {
    public var x(get, set):Float;
    public var y(get, set):Float;
    public var z(get, set):Float;

    public var magnitude(get, never):Float;

    public function new(?x:Float, ?y:Float, ?z:Float) {
        set(x, y, z);
    }

    public inline function set(?x:Float, ?y:Float, ?z:Float) {
        if (x == null) x = 0;
        if (y == null) y = x;
        if (z == null) z = y;

        this = [x, y, z];
    }

    @:op(A + B)
    public inline function add(vec:Vector3):Vector3 {
        var newVec:Vector3 = cast [];

        for (i in 0...3)
            newVec[i] = this[i] + vec[i];

        return newVec;
    }

    @:op(A - B)
    public inline function subtract(vec:Vector3):Vector3 {
        var newVec:Vector3 = cast [];

        for (i in 0...3)
            newVec[i] = this[i] - vec[i];

        return newVec;
    }

    @:op(A * B)
    public inline function multiply(vec:Vector3):Vector3 {
        var newVec:Vector3 = cast [];

        for (i in 0...3)
            newVec[i] = this[i] * vec[i];

        return newVec;
    }

    @:op(A / B)
    public inline function divide(vec:Vector3):Vector3 {
        var newVec:Vector3 = cast [];

        for (i in 0...3)
            newVec[i] = this[i] / vec[i];

        return newVec;
    }

    @:op(A + B)
    public inline function addFloat(add:Float):Vector3 {
        var newVec:Vector3 = cast [];

        for (i in 0...3)
            newVec[i] = this[i] + add;

        return newVec;
    }

    @:op(A - B)
    public inline function subFloat(sub:Float):Vector3 {
        var newVec:Vector3 = cast [];

        for (i in 0...3)
            newVec[i] = this[i] - sub;

        return newVec;
    }

    @:op(A * B)
    public inline function multFloat(mult:Float):Vector3 {
        var newVec:Vector3 = cast [];

        for (i in 0...3)
            newVec[i] = this[i] * mult;

        return newVec;
    }

    @:op(A / B)
    public inline function divFloat(div:Float):Vector3 {
        var newVec:Vector3 = cast [];

        for (i in 0...3)
            newVec[i] = this[i] / div;

        return newVec;
    }

    @:op(A += B)
    public inline function addEq(vec:Vector3):Vector3 {
        for (i in 0...3)
            this[i] += vec[i];

        return this;
    }

    @:op(A -= B)
    public inline function subtractEq(vec:Vector3):Vector3 {
        for (i in 0...3)
            this[i] -= vec[i];

        return this;
    }

    @:op(A *= B)
    public inline function multiplyEq(vec:Vector3):Vector3 {
        for (i in 0...3)
            this[i] *= vec[i];

        return this;
    }

    @:op(A /= B)
    public inline function divideEq(vec:Vector3):Vector3 {
        for (i in 0...3)
            this[i] /= vec[i];

        return this;
    }

    @:op(A += B)
    public inline function addFloatEq(add:Float):Vector3 {
        for (i in 0...3)
            this[i] += add;

        return this;
    }

    @:op(A -= B)
    public inline function subFloatEq(sub:Float):Vector3 {
        for (i in 0...3)
            this[i] -= sub;

        return this;
    }

    @:op(A *= B)
    public inline function multFloatEq(mult:Float):Vector3 {
        for (i in 0...3)
            this[i] *= mult;

        return this;
    }

    @:op(A /= B)
    public inline function divFloatEq(div:Float):Vector3 {
        for (i in 0...3)
            this[i] /= div;

        return this;
    }

    public inline function copyFrom(vec:Vector3) {
        set(vec.x, vec.y, vec.z);
    }

    public function toStar():cpp.Star<cpp.Float32> {
        untyped __cpp__("
            float* _cArray = (float*)malloc(sizeof(float) * 3);
            for (int i = 0; i < 3; i++) {
                _cArray[i] = {0}->__get(i);
            }", this);
        untyped __cpp__("free(_cArray)");
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

    public function get_magnitude() {
        var toSqrt:Float = 0;
        for (i in 0...3)
            toSqrt += this[i] * this[i];
        return Math.sqrt(toSqrt);
    }
}