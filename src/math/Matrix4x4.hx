package math;

abstract Matrix4x4(Array<Vector4>) from Array<Vector4> to Array<Vector4> {
    public function new(?x:Float = 0) {
        reset(x);
    }

    public inline function reset(?x:Float = 0) {
        this = [
            [x, 0, 0, 0],
            [0, x, 0, 0],
            [0, 0, x, 0],
            [0, 0, 0, x]
        ];
    }

    public function translate(move:Vector3):Matrix4x4 {
        for (i in 0...3)
            this[i][3] += move[i];
        return this;
    }

    public function scale(scalar:Vector3):Matrix4x4 {
        this[0] *= scalar[0];
        this[1] *= scalar[1];
        this[2] *= scalar[2];
        return this;
    }

    //Thanks to https://github.com/RafGamign for helping with this function.
    public function rotate(radians:Float, inputAxis:Vector3):Matrix4x4 {
        var sin = Math.sin(radians);
        var cos = Math.cos(radians);

        var x = inputAxis.x;
        var y = inputAxis.y;
        var z = inputAxis.z;
    
        var rotate = new Matrix4x4(1.0);
    
		rotate[0][0] = cos + x * x * (1 - cos);
		rotate[0][1] = x * y * (1 - cos) - z * sin;
		rotate[0][2] = x * z * (1 - cos) + y * sin;

		rotate[1][0] = y * x * (1 - cos) + z * sin;
		rotate[1][1] = cos + y * y * (1 - cos);
		rotate[1][2] = y * z * (1 - cos) - x * sin;
    
        rotate[2][0] = z * x * (1 - cos) - y * sin;
        rotate[2][1] = z * y * (1 - cos) + x * sin;
        rotate[2][2] = cos + z * z * (1 - cos);

        return copyFrom(rotate * this);
    }

    @:op(A + B)
    public inline function add(mat:Matrix4x4):Matrix4x4 {
        var newMat = [[], [], [], []];

        for (i in 0...16)
            newMat[i % 4][Math.floor(i / 4)] = this[i % 4][Math.floor(i / 4)] + mat[i % 4][Math.floor(i / 4)];

        return newMat;
    }

    @:op(A - B)
    public inline function subtract(mat:Matrix4x4):Matrix4x4 {
        var newMat = [[], [], [], []];

        for (i in 0...16)
            newMat[i % 4][Math.floor(i / 4)] = this[i % 4][Math.floor(i / 4)] - mat[i % 4][Math.floor(i / 4)];

        return newMat;
    }

    @:op(A * B)
    public inline function multiply(mat:Matrix4x4):Matrix4x4 {
        var newMat = [[], [], [], []];

        for (i in 0...4) {
            newMat[0][i] = this[0][i] * mat[i][0] + this[0][i] * mat[i][1] + this[0][i] * mat[i][2] + this[0][i] * mat[i][3];
            newMat[1][i] = this[1][i] * mat[i][0] + this[1][i] * mat[i][1] + this[1][i] * mat[i][2] + this[1][i] * mat[i][3];
            newMat[2][i] = this[2][i] * mat[i][0] + this[2][i] * mat[i][1] + this[2][i] * mat[i][2] + this[2][i] * mat[i][3];
            newMat[3][i] = this[3][i] * mat[i][0] + this[3][i] * mat[i][1] + this[3][i] * mat[i][2] + this[3][i] * mat[i][3];
        }

        return newMat;
    }

    @:op(A / B)
    public inline function divide(mat:Matrix4x4):Matrix4x4 {
        var newMat = [[], [], [], []];

        for (i in 0...16)
            newMat[i % 4][Math.floor(i / 4)] = this[i % 4][Math.floor(i / 4)] / mat[i % 4][Math.floor(i / 4)];

        return newMat;
    }

    @:op(A + B)
    public inline function addFloat(add:Float):Matrix4x4 {
        var newMat = [];

        for (i in 0...16)
            newMat[i % 4][Math.floor(i / 4)] = this[i % 4][Math.floor(i / 4)] + add;

        return newMat;
    }

    @:op(A - B)
    public inline function subFloat(sub:Float):Matrix4x4 {
        var newMat = [];

        for (i in 0...16)
            newMat[i % 4][Math.floor(i / 4)] = this[i % 4][Math.floor(i / 4)] - sub;

        return newMat;
    }

    @:op(A * B)
    public inline function multFloat(mult:Float):Matrix4x4 {
        var newMat = [];

        for (i in 0...16)
            newMat[i % 4][Math.floor(i / 4)] = this[i % 4][Math.floor(i / 4)] * mult;

        return newMat;
    }

    @:op(A / B)
    public inline function divFloat(div:Float):Matrix4x4 {
        var newMat = [];

        for (i in 0...16)
            newMat[i % 4][Math.floor(i / 4)] = this[i % 4][Math.floor(i / 4)] / div;

        return newMat;
    }

    @:op(A += B)
    public inline function addEq(mat:Matrix4x4):Matrix4x4 {
        for (i in 0...16)
            this[i % 4][Math.floor(i / 4)] += mat[i % 4][Math.floor(i / 4)];

        return this;
    }

    @:op(A -= B)
    public inline function subtractEq(mat:Matrix4x4):Matrix4x4 {
        for (i in 0...16)
            this[i % 4][Math.floor(i / 4)] -= mat[i % 4][Math.floor(i / 4)];

        return this;
    }

    @:op(A *= B)
    public inline function multiplyEq(mat:Matrix4x4):Matrix4x4 {
        for (i in 0...4) {
            this[0][i] = this[0][i] * mat[i][0] + this[0][i] * mat[i][1] + this[0][i] * mat[i][2] + this[0][i] * mat[i][3];
            this[1][i] = this[1][i] * mat[i][0] + this[1][i] * mat[i][1] + this[1][i] * mat[i][2] + this[1][i] * mat[i][3];
            this[2][i] = this[2][i] * mat[i][0] + this[2][i] * mat[i][1] + this[2][i] * mat[i][2] + this[2][i] * mat[i][3];
            this[3][i] = this[3][i] * mat[i][0] + this[3][i] * mat[i][1] + this[3][i] * mat[i][2] + this[3][i] * mat[i][3];
        }

        return this;
    }

    @:op(A /= B)
    public inline function divideEq(mat:Matrix4x4):Matrix4x4 {
        for (i in 0...16)
            this[i % 4][Math.floor(i / 4)] /= mat[i % 4][Math.floor(i / 4)];

        return this;
    }

    @:op(A += B)
    public inline function addFloatEq(add:Float):Matrix4x4 {
        for (i in 0...16)
            this[i % 4][Math.floor(i / 4)] += add;

        return this;
    }

    @:op(A -= B)
    public inline function subFloatEq(sub:Float):Matrix4x4 {
        for (i in 0...16)
            this[i % 4][Math.floor(i / 4)] -= sub;

        return this;
    }

    @:op(A *= B)
    public inline function multFloatEq(mult:Float):Matrix4x4 {
        for (i in 0...16)
            this[i % 4][Math.floor(i / 4)] *= mult;

        return this;
    }

    @:op(A /= B)
    public inline function divFloatEq(div:Float):Matrix4x4 {
        for (i in 0...16)
            this[i % 4][Math.floor(i / 4)] /= div;

        return this;
    }

    public inline function copyFrom(mat:Matrix4x4):Matrix4x4 {
        for (i in 0...16)
            this[i % 4][Math.floor(i / 4)] = mat[i % 4][Math.floor(i / 4)];

        return this;
    }

    public function toStar():cpp.Star<cpp.Float32> {
        var matArray:Array<Float> = [];
        for (i in 0...4) {
            matArray.push(this[0][i]);
            matArray.push(this[1][i]);
            matArray.push(this[2][i]);
            matArray.push(this[3][i]);
        }
        untyped __cpp__("
            float* _cArray = new float[16];
            for (int i = 0; i < 16; i++) {
                _cArray[i] = {0}->__get(i);
            }", matArray);
        return untyped __cpp__("_cArray");
    }

    public static function ortho(left:Float, right:Float, bottom:Float, top:Float, zNear:Float, zFar:Float) {
        var toReturn = new Matrix4x4(1);

        toReturn[0][0] = 2 / (right - left);
        toReturn[1][1] = 2 / (top - bottom);
        toReturn[0][3] = -(right + left) / (right - left);
        toReturn[1][3] = -(top + bottom) / (top - bottom);

        toReturn[2][2] = -2 / (zFar - zNear);
        toReturn[2][3] = -(zFar + zNear) / (zFar - zNear);

        return toReturn;
    }
}