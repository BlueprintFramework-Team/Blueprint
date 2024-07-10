package math;

@:forward extern abstract Vector4(Vector4Base) from Vector4Base to Vector4Base {
    @:op(-A) public inline function negative()      return this.multiplyFloat(-1);

	@:op(A + B) public inline function addOp(vec:Vector4Base)		return this.add(vec);
	@:op(A += B) public inline function addEqOp(vec:Vector4Base)	return this.addEq(vec);
    @:op(A + B) public inline function addFloatOp(val:Float)		return this.addFloat(val);
    @:op(A += B) public inline function addFloatEqOp(val:Float)		return this.addFloatEq(val);

    @:op(A - B) public inline function subtractOp(vec:Vector4Base)		return this.subtract(vec);
    @:op(A -= B) public inline function subtractEqOp(vec:Vector4Base)	return this.subtractEq(vec);
    @:op(A - B) public inline function subtractFloatOp(val:Float)		return this.subtractFloat(val);
    @:op(A -= B) public inline function subtractFloatEqOp(val:Float)	return this.subtractFloatEq(val);

    @:op(A * B) public inline function multiplyOp(vec:Vector4Base)		return this.multiply(vec);
    @:op(A *= B) public inline function multiplyEqOp(vec:Vector4Base)	return this.multiplyEq(vec);
    @:op(A * B) public inline function multiplyFloatOp(val:Float)		return this.multiplyFloat(val);
    @:op(A *= B) public inline function multiplyFloatEqOp(val:Float)	return this.multiplyFloatEq(val);

    @:op(A / B) public inline function divideOp(vec:Vector4Base)		return this.divide(vec);
    @:op(A /= B) public inline function divideEqOp(vec:Vector4Base)		return this.divideEq(vec);
    @:op(A / B) public inline function divideFloatOp(val:Float)			return this.divideFloat(val);
    @:op(A /= B) public inline function divideFloatEqOp(val:Float)		return this.divideFloatEq(val);
}

@:build(blueprint.Macros.swizzle(["x", "y", "z", "w"], [
	["r", "red::255"],
	["g", "green::255"],
	["b", "blue::255", "width"],
	["a", "alpha::255", "height"]
]))
class Vector4Base {
	@:isVar public var x(get, set):Float;
	@:isVar public var y(get, set):Float;
	@:isVar public var z(get, set):Float;
	@:isVar public var w(get, set):Float;

	public var magnitude(get, never):Float;

	public function new(?x:Float, ?y:Float, ?z:Float, ?w:Float) {
		set(x, y, z, w);
	}

	public inline function set(?x:Float, ?y:Float, ?z:Float, ?w:Float):Vector4Base {
		this.x = (x != null) ? x : 0;
		this.y = (y != null) ? y : this.x;
		this.z = (z != null) ? z : this.y;
		this.w = (w != null) ? w : this.z;

        return this;
	}

	public inline function add(vec:Vector4Base):Vector4Base
        return new Vector4Base(this.x + vec.x, this.y + vec.y, this.z + vec.z, this.w + vec.w);
	public inline function addEq(vec:Vector4Base):Vector4Base
        return set(this.x + vec.x, this.y + vec.y, this.z + vec.z, this.w + vec.w);
    public inline function addFloat(val:Float):Vector4Base
        return new Vector4Base(this.x + val, this.y + val, this.z + val, this.w + val);
    public inline function addFloatEq(val:Float):Vector4Base
        return set(this.x + val, this.y + val, this.z + val, this.w + val);

    public inline function subtract(vec:Vector4Base):Vector4Base
        return new Vector4Base(this.x - vec.x, this.y - vec.y, this.z - vec.z, this.w - vec.w);
    public inline function subtractEq(vec:Vector4Base):Vector4Base
        return set(this.x - vec.x, this.y - vec.y, this.z - vec.z, this.w - vec.w);
    public inline function subtractFloat(val:Float):Vector4Base
        return new Vector4Base(this.x - val, this.y - val, this.z - val, this.w - val);
    public inline function subtractFloatEq(val:Float):Vector4Base 
        return set(this.x - val, this.y - val, this.z - val, this.w - val);

    public inline function multiply(vec:Vector4Base):Vector4Base
        return new Vector4Base(this.x * vec.x, this.y * vec.y, this.z * vec.z, this.w * vec.w);
    public inline function multiplyEq(vec:Vector4Base):Vector4Base
        return set(this.x * vec.x, this.y * vec.y, this.z * vec.z, this.w * vec.w);
    public inline function multiplyFloat(val:Float):Vector4Base
        return new Vector4Base(this.x * val, this.y * val, this.z * val, this.w * val);
    public inline function multiplyFloatEq(val:Float):Vector4Base
        return set(this.x * val, this.y * val, this.z * val, this.w * val);

    public inline function divide(vec:Vector4Base):Vector4Base
        return new Vector4Base(this.x / vec.x, this.y / vec.y, this.z / vec.z, this.w / vec.w);
    public inline function divideEq(vec:Vector4Base):Vector4Base
        return set(this.x / vec.x, this.y / vec.y, this.z / vec.z, this.w / vec.w);
    public inline function divideFloat(val:Float):Vector4Base
        return new Vector4Base(this.x / val, this.y / val, this.z / val, this.w / val);
    public inline function divideFloatEq(val:Float):Vector4Base
        return set(this.x / val, this.y / val, this.z / val, this.w / val);

	public inline function copyFrom(vec:Vector4Base):Vector4Base
        return set(vec.x, vec.y, vec.z, vec.w);

	/**
	 * Converts the vector into a c array, mainly used for OpenGL Shaders.
	 * 
	 * NOTE: For proper memory management, please call `CppHelpers.free` when you are fully finished with the c array.
	 * 
     * @return RawPointer<cpp.Float32>
     */
	public function toCArray():cpp.RawPointer<cpp.Float32> {
		untyped __cpp__("float _cArray[4] = { {0}, {1}, {2}, {3} }", this.x, this.y, this.z, this.w);
		return untyped __cpp__("_cArray");
	}

	@:noCompletion private inline function get_x():Float return this.x;
	@:noCompletion private inline function set_x(v:Float):Float return this.x = v;

	@:noCompletion private inline function get_y():Float return this.y;
	@:noCompletion private inline function set_y(v:Float):Float return this.y = v;

	@:noCompletion private inline function get_z():Float return this.z;
	@:noCompletion private inline function set_z(v:Float):Float return this.z = v;

	@:noCompletion private inline function get_w():Float return this.w;
	@:noCompletion private inline function set_w(v:Float):Float return this.w = v;

	public function get_magnitude():Float
		return Math.sqrt(x * x + y * y + z * z + w * w);
}