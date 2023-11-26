package math;

/**
 * Utilized from Droplet developed by Swordcube. (https://github.com/swordcube/Droplet-Framework/tree/master)
 */
abstract Rect(Array<Float>) from Array<Float> to Array<Float> {
    public var x(get, set):Float;
    public var y(get, set):Float;
    public var width(get, set):Float;
    public var height(get, set):Float;

    public var magnitude(get, never):Float;

    public function new(?x:Float, ?y:Float, ?width:Float, ?height:Float) {
        set(x, y, width, height);
    }

    public inline function set(?x:Float, ?y:Float, ?width:Float, ?height:Float) {
        if (x == null) x = 0;
        if (y == null) y = x;
        if (width == null) width = 0;
        if (height == null) height = width;

        this = [x, y, width, height];
    }

    @:op(A + B)
    public inline function add(vec:Rect):Rect {
        var newVec:Rect = cast [];

        for (i in 0...4)
            newVec[i] = this[i] + vec[i];

        return newVec;
    }

    @:op(A - B)
    public inline function subtract(vec:Rect):Rect {
        var newVec:Rect = cast [];

        for (i in 0...4)
            newVec[i] = this[i] - vec[i];

        return newVec;
    }

    @:op(A * B)
    public inline function multiply(vec:Rect):Rect {
        var newVec:Rect = cast [];

        for (i in 0...4)
            newVec[i] = this[i] * vec[i];

        return newVec;
    }

    @:op(A / B)
    public inline function divide(vec:Rect):Rect {
        var newVec:Rect = cast [];

        for (i in 0...4)
            newVec[i] = this[i] / vec[i];

        return newVec;
    }

    @:op(A + B)
    public inline function addFloat(add:Float):Rect {
        var newVec:Rect = cast [];

        for (i in 0...4)
            newVec[i] = this[i] + add;

        return newVec;
    }

    @:op(A - B)
    public inline function subFloat(sub:Float):Rect {
        var newVec:Rect = cast [];

        for (i in 0...4)
            newVec[i] = this[i] - sub;

        return newVec;
    }

    @:op(A * B)
    public inline function multFloat(mult:Float):Rect {
        var newVec:Rect = cast [];

        for (i in 0...4)
            newVec[i] = this[i] * mult;

        return newVec;
    }

    @:op(A / B)
    public inline function divFloat(div:Float):Rect {
        var newVec:Rect = cast [];

        for (i in 0...4)
            newVec[i] = this[i] / div;

        return newVec;
    }

    @:op(A += B)
    public inline function addEq(vec:Rect):Rect {
        for (i in 0...4)
            this[i] += vec[i];

        return this;
    }

    @:op(A -= B)
    public inline function subtractEq(vec:Rect):Rect {
        for (i in 0...4)
            this[i] -= vec[i];

        return this;
    }

    @:op(A *= B)
    public inline function multiplyEq(vec:Rect):Rect {
        for (i in 0...4)
            this[i] *= vec[i];

        return this;
    }

    @:op(A /= B)
    public inline function divideEq(vec:Rect):Rect {
        for (i in 0...4)
            this[i] /= vec[i];

        return this;
    }

    @:op(A += B)
    public inline function addFloatEq(add:Float):Rect {
        for (i in 0...4)
            this[i] += add;

        return this;
    }

    @:op(A -= B)
    public inline function subFloatEq(sub:Float):Rect {
        for (i in 0...4)
            this[i] -= sub;

        return this;
    }

    @:op(A *= B)
    public inline function multFloatEq(mult:Float):Rect {
        for (i in 0...4)
            this[i] *= mult;

        return this;
    }

    @:op(A /= B)
    public inline function divFloatEq(div:Float):Rect {
        for (i in 0...4)
            this[i] /= div;

        return this;
    }

    public inline function copyFrom(rect:Rect) {
        set(rect.x, rect.y, rect.width, rect.height);
    }

    public function toStar():cpp.Star<cpp.Float32> {
        untyped __cpp__("
            float* _cArray = (float*)malloc(sizeof(float) * 4);
            for (int i = 0; i < 4; i++) {
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
    private inline function get_width():Float {
        return this[2];
    }

    @:noCompletion
    private inline function set_width(v:Float):Float {
        return this[2] = v;
    }

    @:noCompletion
    private inline function get_height():Float {
        return this[3];
    }

    @:noCompletion
    private inline function set_height(v:Float):Float {
        return this[3] = v;
    }

    public function get_magnitude() {
        var toSqrt:Float = 0;
        for (i in 0...4)
            toSqrt += this[i] * this[i];
        return Math.sqrt(toSqrt);
    }
}