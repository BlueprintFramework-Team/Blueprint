package blueprint.graphics;

import cpp.ConstCharStar;
import cpp.RawPointer;

import math.Vector4;
import math.Vector3;
import math.Vector2;
import math.Matrix4x4;

import bindings.CppHelpers;
import bindings.Glad;

class Shader {
	private static var curShaders:Array<Shader> = [];
	public var keepIfUnused:Bool = false;
	public var useCount:Int = 0;

	public var ID:cpp.UInt32;

	public var transform:Matrix4x4 = new Matrix4x4(1.0);

	public function new(fragString:String, vertString:String) {
		var fragID:cpp.UInt32;
		var vertID:cpp.UInt32;
		var fragContent = ConstCharStar.fromString(fragString);
		var vertContent = ConstCharStar.fromString(vertString);
		var success:Int = 0;

		vertID = Glad.createShader(Glad.VERTEX_SHADER);
		Glad.shaderSource(vertID, 1, RawPointer.addressOf(vertContent), null);
		Glad.compileShader(vertID);
		Glad.getShaderiv(vertID, Glad.COMPILE_STATUS, RawPointer.addressOf(success));
		if (success == 0) {
			var infoLog:RawPointer<cpp.Char> = CppHelpers.malloc(1024, cpp.Char);
			Glad.getShaderInfoLog(vertID, 1024, null, infoLog);
			CppHelpers.nativeTrace("Failed to load Vertex Shader.\n%s\n", infoLog);
			CppHelpers.free(infoLog);
		}

		fragID = Glad.createShader(Glad.FRAGMENT_SHADER);
		Glad.shaderSource(fragID, 1, RawPointer.addressOf(fragContent), null);
		Glad.compileShader(fragID);
		Glad.getShaderiv(fragID, Glad.COMPILE_STATUS, RawPointer.addressOf(success));
		if (success == 0) {
			var infoLog:RawPointer<cpp.Char> = CppHelpers.malloc(1024, cpp.Char);
			Glad.getShaderInfoLog(fragID, 1024, null, infoLog);
			CppHelpers.nativeTrace("Failed to load Fragment Shader.\n%s\n", infoLog);
			CppHelpers.free(infoLog);
		}

		ID = Glad.createProgram();
		Glad.attachShader(ID, vertID);
		Glad.attachShader(ID, fragID);
		Glad.linkProgram(ID);
		Glad.getProgramiv(ID, Glad.LINK_STATUS, RawPointer.addressOf(success));
		if (success == 0) {
			var infoLog:RawPointer<cpp.Char> = CppHelpers.malloc(1024, cpp.Char);
			Glad.getProgramInfoLog(ID, 1024, null, infoLog);
			CppHelpers.nativeTrace("Failed to link Shader Program.\n%s\n", infoLog);
			CppHelpers.free(infoLog);
		}

		Glad.deleteShader(vertID);
		Glad.deleteShader(fragID);

		Glad.useProgram(ID);
		Glad.uniform1i(Glad.getUniformLocation(ID, "shader"), 0);

		final projectLoc = Glad.getUniformLocation(ID, "projection");
		final projectStar = Game.projection.toCArray();
		Glad.uniformMatrix4fv(projectLoc, 1, Glad.FALSE, projectStar);
		CppHelpers.free(projectStar);

		curShaders.push(this);
	}

	public function destroy() {
		curShaders.remove(this);
		Glad.deleteProgram(ID);
		transform = null;
	}

	public function setUniformVar(name:ConstCharStar, value:Any) {
		switch (Type.getClass(value)) {
			case Int:
				Glad.uniform1i(Glad.getUniformLocation(ID, name), value);
			case Float:
				Glad.uniform1f(Glad.getUniformLocation(ID, name), value);
			case Vector2Base:
				var vec:Vector2Base = cast value;
				setUniform(name, vec);
			case Vector3Base:
				var vec:Vector3Base = cast value;
				setUniform(name, vec);
			case Vector4Base:
				var vec:Vector4Base = cast value;
				setUniform(name, vec);
			// case Matrix4x4:
			// 	var mat:Matrix4x4 = cast value;
			// 	setUniform(name, mat);
		}
	}

	overload public inline extern function setUniform(name:ConstCharStar, value:Int) {
		Glad.uniform1i(Glad.getUniformLocation(ID, name), value);
	}

	overload public inline extern function setUniform(name:ConstCharStar, value:Float) {
		Glad.uniform1f(Glad.getUniformLocation(ID, name), value);
	}

	overload public inline extern function setUniform(name:ConstCharStar, value:Vector2Base) {
		Glad.uniform2f(Glad.getUniformLocation(ID, name), value.x, value.y);
	}

	overload public inline extern function setUniform(name:ConstCharStar, value:Vector3Base) {
		Glad.uniform3f(Glad.getUniformLocation(ID, name), value.x, value.y, value.z);
	}

	overload public inline extern function setUniform(name:ConstCharStar, value:Vector4Base) {
		Glad.uniform4f(Glad.getUniformLocation(ID, name), value.x, value.y, value.z, value.w);
	}

	overload public inline extern function setUniform(name:ConstCharStar, value:Matrix4x4) {
		final star = value.toCArray();
		Glad.uniformMatrix4fv(Glad.getUniformLocation(ID, name), 1, Glad.FALSE, star);
		CppHelpers.free(star);
	}

	public static function clearShaders(?force:Bool = false) {
		var i:Int = 0; // So I have more control over the iterator. (Removing stuff can mess up for loops.)
		while (i < curShaders.length) {
			final shader = curShaders[i];
			if (!force && (shader.keepIfUnused || shader.useCount > 0))
				i++;
			else
				shader.destroy();
		}
	}

	public static final defaultVertexSource:String = "
		#version 330 core
		layout (location = 0) in vec3 vertexPos;
		layout (location = 1) in vec2 texPos;

		uniform mat4 projection;
		uniform mat4 transform;
		uniform vec4 sourceRect;

		out vec2 TexCoord;

		void main() {
			gl_Position = projection * transform * vec4(vertexPos, 1.0);
			TexCoord = vec2(
				mix(sourceRect.x, sourceRect.z, texPos.x),
				mix(sourceRect.y, sourceRect.w, texPos.y)
			);
		}
	";

	public static final defaultFragmentSource:String = "
		#version 330 core
		out vec4 FragColor;
		in vec2 TexCoord;

		uniform vec4 tint;
		uniform sampler2D bitmap;

		void main() {
			FragColor = texture(bitmap, TexCoord) * tint;
		}
	";
}