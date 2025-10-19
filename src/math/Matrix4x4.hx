package math;

import bindings.CppHelpers;
import math.Vector4;
import cpp.RawPointer;

abstract Matrix4x4(Array<Vector4>) from Array<Vector4> to Array<Vector4> {
	static var rotResult:Matrix4x4 = new Matrix4x4(1.0); // Might be renamed if i have to use this in a another function.

	public function new(?x:Float = 0) {
		this = [for (i in 0...4) {
			new Vector4(
				(i == 0) ? x : 0.0,
				(i == 1) ? x : 0.0,
				(i == 2) ? x : 0.0,
				(i == 3) ? x : 0.0
			);
		}];
	}

	public inline function reset(?x:Float = 0) {
		for (i in 0...4) {
			this[i].setFull(
				(i == 0) ? x : 0.0,
				(i == 1) ? x : 0.0,
				(i == 2) ? x : 0.0,
				(i == 3) ? x : 0.0
			);
		}
	}

	public function translate(move:Vector3):Matrix4x4 {
		this[0].w += move.x;
		this[1].w += move.y;
		this[2].w += move.z;
		return this;
	}

	public function scale(scalar:Vector3):Matrix4x4 {
		this[0] *= scalar.x;
		this[1] *= scalar.y;
		this[2] *= scalar.z;
		return this;
	}

	public function radRotate(radians:Float, inputAxis:Vector3) {
		var sin = Math.sin(radians);
		var cos = Math.cos(radians);
		return rotate(sin, cos, inputAxis);
	}

	//Thanks to https://github.com/RafGamign for helping with this function.
	public function rotate(sin:Float, cos:Float, inputAxis:Vector3):Matrix4x4 {
		var x = inputAxis.x;
		var y = inputAxis.y;
		var z = inputAxis.z;

		rotResult[0].x = (cos + x * x * (1 - cos));
		rotResult[0].y = (x * y * (1 - cos) - z * sin);
		rotResult[0].z = (x * z * (1 - cos) + y * sin);

		rotResult[1].x = (y * x * (1 - cos) + z * sin);
		rotResult[1].y = (cos + y * y * (1 - cos));
		rotResult[1].z = (y * z * (1 - cos) - x * sin);

		rotResult[2].x = (z * x * (1 - cos) - y * sin);
		rotResult[2].y = (z * y * (1 - cos) + x * sin);
		rotResult[2].z = (cos + z * z * (1 - cos));

		rotResult[0].setFull(
			(this[0].x * rotResult[0].x + this[1].x * rotResult[0].y + this[2].x * rotResult[0].z),
			(this[0].y * rotResult[0].x + this[1].y * rotResult[0].y + this[2].y * rotResult[0].z),
			(this[0].z * rotResult[0].x + this[1].z * rotResult[0].y + this[2].z * rotResult[0].z),
			(this[0].w * rotResult[0].x + this[1].w * rotResult[0].y + this[2].w * rotResult[0].z)
		);

		rotResult[1].setFull(
			(this[0].x * rotResult[1].x + this[1].x * rotResult[1].y + this[2].x * rotResult[1].z),
			(this[0].y * rotResult[1].x + this[1].y * rotResult[1].y + this[2].y * rotResult[1].z),
			(this[0].z * rotResult[1].x + this[1].z * rotResult[1].y + this[2].z * rotResult[1].z),
			(this[0].w * rotResult[1].x + this[1].w * rotResult[1].y + this[2].w * rotResult[1].z)
		);

		rotResult[2].setFull(
			(this[0].x * rotResult[2].x + this[1].x * rotResult[2].y + this[2].x * rotResult[2].z),
			(this[0].y * rotResult[2].x + this[1].y * rotResult[2].y + this[2].y * rotResult[2].z),
			(this[0].z * rotResult[2].x + this[1].z * rotResult[2].y + this[2].z * rotResult[2].z),
			(this[0].w * rotResult[2].x + this[1].w * rotResult[2].y + this[2].w * rotResult[2].z)
		);

		rotResult[3].copyFrom(this[3]);
		
		return copyFrom(rotResult);
	}

	@:op(A + B)
	public inline function add(mat:Matrix4x4):Matrix4x4 {
		var newMat = new Matrix4x4().copyFrom(this);

		for (i in 0...4)
			newMat[i].addEq(mat[i]);

		return newMat;
	}

	@:op(A - B)
	public inline function subtract(mat:Matrix4x4):Matrix4x4 {
		var newMat = new Matrix4x4().copyFrom(this);

		for (i in 0...4)
			newMat[i].subtractEq(mat[i]);

		return newMat;
	}

	@:op(A * B)
	public inline function multiply(mat:Matrix4x4):Matrix4x4 {
		var newMat = new Matrix4x4();

		// got this from an online friend but i dunno how to credit them properly (they didnt tell me)
		// adjusted a bit to account for multiplyEq and lack of array access in Vector4.
		// also had to unroll two of their loops lol
		for(x in 0...4) {
			final total0:Float = this[x].x * mat[0].x + this[x].y * mat[1].x + this[x].z * mat[2].x + this[x].w * mat[3].x;
			final total1:Float = this[x].x * mat[0].y + this[x].y * mat[1].y + this[x].z * mat[2].y + this[x].w * mat[3].y;
			final total2:Float = this[x].x * mat[0].z + this[x].y * mat[1].z + this[x].z * mat[2].z + this[x].w * mat[3].z;
			final total3:Float = this[x].x * mat[0].w + this[x].y * mat[1].w + this[x].z * mat[2].w + this[x].w * mat[3].w;

			newMat[x].setFull(total0, total1, total2, total3);
		}

		return newMat;
	}

	@:op(A + B)
	public inline function addFloat(val:Float):Matrix4x4 {
		var newMat = new Matrix4x4().copyFrom(this);

		for (i in 0...4)
			newMat[i].addFloatEq(val);

		return newMat;
	}

	@:op(A - B)
	public inline function subtractFloat(val:Float):Matrix4x4 {
		var newMat = new Matrix4x4().copyFrom(this);

		for (i in 0...4)
			newMat[i].subtractFloatEq(val);

		return newMat;
	}

	@:op(A * B)
	public inline function multiplyFloat(val:Float):Matrix4x4 {
		var newMat = new Matrix4x4().copyFrom(this);

		for (i in 0...4)
			newMat[i].multiplyFloatEq(val);

		return newMat;
	}

	@:op(A += B)
	public inline function addEq(mat:Matrix4x4):Matrix4x4 {
		for (i in 0...4)
			this[i].addEq(mat[i]);

		return this;
	}

	@:op(A -= B)
	public inline function subtractEq(mat:Matrix4x4):Matrix4x4 {
		for (i in 0...4)
			this[i].subtractEq(mat[i]);

		return this;
	}

	@:op(A *= B)
	public inline function multiplyEq(mat:Matrix4x4):Matrix4x4 {
		for(x in 0...4) {
			final total0:Float = this[x].x * mat[0].x + this[x].y * mat[1].x + this[x].z * mat[2].x + this[x].w * mat[3].x;
			final total1:Float = this[x].x * mat[0].y + this[x].y * mat[1].y + this[x].z * mat[2].y + this[x].w * mat[3].y;
			final total2:Float = this[x].x * mat[0].z + this[x].y * mat[1].z + this[x].z * mat[2].z + this[x].w * mat[3].z;
			final total3:Float = this[x].x * mat[0].w + this[x].y * mat[1].w + this[x].z * mat[2].w + this[x].w * mat[3].w;

			this[x].setFull(total0, total1, total2, total3);
		}

		return this;
	}

	@:op(A += B)
	public inline function addFloatEq(val:Float):Matrix4x4 {
		for (i in 0...4)
			this[i].addFloatEq(val);

		return this;
	}

	@:op(A -= B)
	public inline function subFloatEq(val:Float):Matrix4x4 {
		for (i in 0...4)
			this[i].subtractFloatEq(val);

		return this;
	}

	@:op(A *= B)
	public inline function multFloatEq(val:Float):Matrix4x4 {
		for (i in 0...4)
			this[i].multiplyFloatEq(val);

		return this;
	}

	public function transformVec4(vec:Vector4):Vector4 {
		return vec.setFull(
			this[0].x * vec.x + this[0].y * vec.y + this[0].z * vec.z + this[0].w * vec.w,
			this[1].x * vec.x + this[1].y * vec.y + this[1].z * vec.z + this[1].w * vec.w,
			this[2].x * vec.x + this[2].y * vec.y + this[2].z * vec.z + this[2].w * vec.w,
			this[3].x * vec.x + this[3].y * vec.y + this[3].z * vec.z + this[3].w * vec.w
		);
	}

	public inline function copyFrom(mat:Matrix4x4):Matrix4x4 {
		for (i in 0...4)
			this[i].copyFrom(mat[i]);

		return this;
	}

	/**
	 * Converts the matrix into a c array, mainly used for OpenGL Shaders.
	 * 
	 * NOTE: For proper memory management, please call `CppHelpers.free` when you are fully finished with the c array.
	 * 
	 * @return RawPointer<cpp.Float32>
	 */
	public function toCArray():RawPointer<cpp.Float32> {
		final cArray:RawPointer<cpp.Float32> = CppHelpers.malloc(16, cpp.Float32);
		for (i in 0...4) {
			final vector = this[i];
			cArray[i] = cast vector.x;
			cArray[4 + i] = cast vector.y;
			cArray[8 + i] = cast vector.z;
			cArray[12 + i] = cast vector.w;
		}
		return cArray;
	}

	public static function ortho(left:Float, right:Float, bottom:Float, top:Float, zNear:Float, zFar:Float) {
		var toReturn = new Matrix4x4(1);

		toReturn[0].x = 2 / (right - left);
		toReturn[1].y = 2 / (top - bottom);
		toReturn[0].w = -(right + left) / (right - left);
		toReturn[1].w = -(top + bottom) / (top - bottom);

		toReturn[2].z = -2 / (zFar - zNear);
		toReturn[2].w = -(zFar + zNear) / (zFar - zNear);

		return toReturn;
	}
}