package blueprint.graphics;

import cpp.ConstCharStar;
import cpp.Pointer;

import math.Vector4;
import math.Vector3;
import math.Vector2;
import math.Matrix4x4;

import bindings.CppHelpers;
import bindings.Glad;

class Shader {
	public var ID:cpp.UInt32;

	public var transform:Matrix4x4 = new Matrix4x4(1.0);

	public function new(fragString:String, vertString:String) {
		var fragID:cpp.UInt32;
		var vertID:cpp.UInt32;
		var fragContent = ConstCharStar.fromString(fragString);
		var vertContent = ConstCharStar.fromString(vertString);
		var success:Int = 0;

		vertID = Glad.createShader(Glad.VERTEX_SHADER);
		Glad.shaderSource(vertID, 1, CppHelpers.tempPointer(vertContent), null);
		Glad.compileShader(vertID);
		Glad.getShaderiv(vertID, Glad.COMPILE_STATUS, Pointer.addressOf(success));
		if (success == 0) {
			var infoLog:cpp.Star<cpp.Char> = CppHelpers.malloc(1024, cpp.Char);
			Glad.getShaderInfoLog(vertID, 1024, null, infoLog);
			CppHelpers.nativeTrace("Failed to load Vertex Shader.\n%s\n", infoLog);
			CppHelpers.free(infoLog);
		}

		fragID = Glad.createShader(Glad.FRAGMENT_SHADER);
		Glad.shaderSource(fragID, 1, CppHelpers.tempPointer(fragContent), null);
		Glad.compileShader(fragID);
		Glad.getShaderiv(fragID, Glad.COMPILE_STATUS, Pointer.addressOf(success));
		if (success == 0) {
			var infoLog:cpp.Star<cpp.Char> = CppHelpers.malloc(1024, cpp.Char);
			Glad.getShaderInfoLog(fragID, 1024, null, infoLog);
			CppHelpers.nativeTrace("Failed to load Fragment Shader.\n%s\n", infoLog);
			CppHelpers.free(infoLog);
		}

		ID = Glad.createProgram();
		Glad.attachShader(ID, vertID);
		Glad.attachShader(ID, fragID);
		Glad.linkProgram(ID);
		Glad.getProgramiv(ID, Glad.LINK_STATUS, Pointer.addressOf(success));
		if (success == 0) {
			var infoLog:cpp.Star<cpp.Char> = CppHelpers.malloc(1024, cpp.Char);
			Glad.getProgramInfoLog(ID, 1024, null, infoLog);
			CppHelpers.nativeTrace("Failed to link Shader Program.\n%s\n", infoLog);
			CppHelpers.free(infoLog);
		}

		Glad.deleteShader(vertID);
		Glad.deleteShader(fragID);

		Glad.useProgram(ID);
		Glad.uniform1i(Glad.getUniformLocation(ID, "shader"), 0);

		final projectLoc = Glad.getUniformLocation(ID, "projection");
		final projectStar = Game.projection.toStar();
		Glad.uniformMatrix4fv(projectLoc, 1, Glad.FALSE, projectStar);
		CppHelpers.free(projectStar);
	}

	overload public inline extern function setUniform(name:ConstCharStar, value:Int) {
		untyped __cpp__("glUniform1i(glGetUniformLocation({0}, {1}), {2})", ID, name, value);
	}

	overload public inline extern function setUniform(name:ConstCharStar, value:Float) {
		untyped __cpp__("glUniform1f(glGetUniformLocation({0}, {1}), {2})", ID, name, value);
	}

	overload public inline extern function setUniform(name:ConstCharStar, value:Vector2) {
		untyped __cpp__("glUniform2f(glGetUniformLocation({0}, {1}), {2}, {3})", ID, name, value.x, value.y);
	}

	overload public inline extern function setUniform(name:ConstCharStar, value:Vector3) {
		untyped __cpp__("glUniform3f(glGetUniformLocation({0}, {1}), {2}, {3}, {4})", ID, name, value.x, value.y, value.z);
	}

	overload public inline extern function setUniform(name:ConstCharStar, value:Vector4) {
		untyped __cpp__("glUniform4f(glGetUniformLocation({0}, {1}), {2}, {3}, {4}, {5})", ID, name, value.x, value.y, value.z, value.w);
	}

	overload public inline extern function setUniform(name:ConstCharStar, value:Matrix4x4) {
		untyped __cpp__("
			float* _star = {0};
			glUniformMatrix4fv(glGetUniformLocation({1}, {2}), 1, GL_FALSE, _star);
			free(_star)", value.toStar(), this.ID, name);
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