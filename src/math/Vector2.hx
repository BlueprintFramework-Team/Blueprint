package math;

@:forward extern abstract Vector2(Vector2Base) from Vector2Base to Vector2Base {
	public inline function new(?x:Float, ?y:Float) {
		this = new Vector2Base(x, y);
	}

    @:op(-A) public inline function negative()      return this.multiplyFloat(-1);

	@:op(A + B) public inline function addOp(vec:Vector2Base)		return this.add(vec);
	@:op(A += B) public inline function addEqOp(vec:Vector2Base)	return this.addEq(vec);
    @:op(A + B) public inline function addFloatOp(val:Float)		return this.addFloat(val);
    @:op(A += B) public inline function addFloatEqOp(val:Float)		return this.addFloatEq(val);

    @:op(A - B) public inline function subtractOp(vec:Vector2Base)		return this.subtract(vec);
    @:op(A -= B) public inline function subtractEqOp(vec:Vector2Base)	return this.subtractEq(vec);
    @:op(A - B) public inline function subtractFloatOp(val:Float)		return this.subtractFloat(val);
    @:op(A -= B) public inline function subtractFloatEqOp(val:Float)	return this.subtractFloatEq(val);

    @:op(A * B) public inline function multiplyOp(vec:Vector2Base)		return this.multiply(vec);
    @:op(A *= B) public inline function multiplyEqOp(vec:Vector2Base)	return this.multiplyEq(vec);
    @:op(A * B) public inline function multiplyFloatOp(val:Float)		return this.multiplyFloat(val);
    @:op(A *= B) public inline function multiplyFloatEqOp(val:Float)	return this.multiplyFloatEq(val);

    @:op(A / B) public inline function divideOp(vec:Vector2Base)		return this.divide(vec);
    @:op(A /= B) public inline function divideEqOp(vec:Vector2Base)		return this.divideEq(vec);
    @:op(A / B) public inline function divideFloatOp(val:Float)			return this.divideFloat(val);
    @:op(A /= B) public inline function divideFloatEqOp(val:Float)		return this.divideFloatEq(val);
}

class Vector2Base {
	@:isVar public var x(get, set):Float;
	@:isVar public var y(get, set):Float;

	public var magnitude(get, never):Float;

	public function new(?x:Float, ?y:Float) {
		set(x, y);
	}

    public inline function setFull(x:Float, y:Float):Vector2Base {
        this.x = x;
        this.y = y;

        return this;
    }

	public inline function set(?x:Float, ?y:Float):Vector2Base {
		this.x = (x != null) ? x : 0;
		this.y = (y != null) ? y : this.x;

        return this;
	}

	public inline function add(vec:Vector2Base):Vector2Base
        return new Vector2Base(this.x + vec.x, this.y + vec.y);
	public inline function addEq(vec:Vector2Base):Vector2Base
        return setFull(this.x + vec.x, this.y + vec.y);
    public inline function addFloat(val:Float):Vector2Base
        return new Vector2Base(this.x + val, this.y + val);
    public inline function addFloatEq(val:Float):Vector2Base
        return setFull(this.x + val, this.y + val);

    public inline function subtract(vec:Vector2Base):Vector2Base
        return new Vector2Base(this.x - vec.x, this.y - vec.y);
    public inline function subtractEq(vec:Vector2Base):Vector2Base
        return setFull(this.x - vec.x, this.y - vec.y);
    public inline function subtractFloat(val:Float):Vector2Base
        return new Vector2Base(this.x - val, this.y - val);
    public inline function subtractFloatEq(val:Float):Vector2Base 
        return setFull(this.x - val, this.y - val);

    public inline function multiply(vec:Vector2Base):Vector2Base
        return new Vector2Base(this.x * vec.x, this.y * vec.y);
    public inline function multiplyEq(vec:Vector2Base):Vector2Base
        return setFull(this.x * vec.x, this.y * vec.y);
    public inline function multiplyFloat(val:Float):Vector2Base
        return new Vector2Base(this.x * val, this.y * val);
    public inline function multiplyFloatEq(val:Float):Vector2Base
        return setFull(this.x * val, this.y * val);

    public inline function divide(vec:Vector2Base):Vector2Base
        return new Vector2Base(this.x / vec.x, this.y / vec.y);
    public inline function divideEq(vec:Vector2Base):Vector2Base
        return setFull(this.x / vec.x, this.y / vec.y);
    public inline function divideFloat(val:Float):Vector2Base
        return new Vector2Base(this.x / val, this.y / val);
    public inline function divideFloatEq(val:Float):Vector2Base
        return setFull(this.x / val, this.y / val);

	public inline function copyFrom(vec:Vector2Base):Vector2Base
        return setFull(vec.x, vec.y);

	public inline function radRotate(radians:Float) {
		var sin = Math.sin(radians);
		var cos = Math.cos(radians);
		return rotate(sin, cos);
	}

    public inline function rotate(sin:Float, cos:Float) {
        return setFull(
            x * cos - y * sin,
            x * sin + y * cos
        );
    }

	/**
	 * Converts the vector into a c array, mainly used for OpenGL Shaders.
	 * 
	 * NOTE: For proper memory management, please call `CppHelpers.free` when you are fully finished with the c array.
	 * 
     * @return RawPointer<cpp.Float32>
     */
	public function toCArray():cpp.RawPointer<cpp.Float32> {
		untyped __cpp__("float _cArray[2] = { {0}, {1} }", this.x, this.y);
		return untyped __cpp__("_cArray");
	}

	@:noCompletion private inline function get_x():Float return this.x;
	@:noCompletion private inline function set_x(v:Float):Float return this.x = v;

	@:noCompletion private inline function get_y():Float return this.y;
	@:noCompletion private inline function set_y(v:Float):Float return this.y = v;

	public function get_magnitude():Float
		return Math.sqrt(x * x + y * y);

    public function toString():String
        return '($x, $y)';
}