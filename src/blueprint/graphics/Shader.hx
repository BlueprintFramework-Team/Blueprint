package blueprint.graphics;

import math.Matrix4x4;
import bindings.CppHelpers;
import cpp.ConstCharStar;
import cpp.Pointer;
import cpp.Native;
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
            Sys.println('Vertex Shader Failed.');
            var infoLog:cpp.Star<cpp.Char> = cast Native.nativeMalloc(1024);
            Glad.getShaderInfoLog(vertID, 1024, null, cast infoLog);
            CppHelpers.traceChar(infoLog);
            Native.nativeFree(cast infoLog);
        }

        fragID = Glad.createShader(Glad.FRAGMENT_SHADER);
        Glad.shaderSource(fragID, 1, CppHelpers.tempPointer(fragContent), null);
        Glad.compileShader(fragID);
        Glad.getShaderiv(fragID, Glad.COMPILE_STATUS, Pointer.addressOf(success));
        if (success == 0) {
            Sys.println('Fragment Shader Failed.');
            var infoLog:cpp.Star<cpp.Char> = cast Native.nativeMalloc(1024);
            Glad.getShaderInfoLog(fragID, 1024, null, cast infoLog);
            CppHelpers.traceChar(infoLog);
            Native.nativeFree(cast infoLog);
        }

        ID = Glad.createProgram();
        Glad.attachShader(ID, vertID);
        Glad.attachShader(ID, fragID);
        Glad.linkProgram(ID);
        Glad.getProgramiv(ID, Glad.LINK_STATUS, Pointer.addressOf(success));
        if (success == 0) {
            Sys.println('Shader Program Link Failed.');
            var infoLog:cpp.Star<cpp.Char> = cast Native.nativeMalloc(1024);
            Glad.getProgramInfoLog(ID, 1024, null, cast infoLog);
            CppHelpers.traceChar(infoLog);
            Native.nativeFree(cast infoLog);
        }

        Glad.deleteShader(vertID);
        Glad.deleteShader(fragID);

        Glad.useProgram(ID);
        Glad.uniform1i(Glad.getUniformLocation(ID, "shader"), 0);

        final projectLoc = Glad.getUniformLocation(ID, "projection");
        final projectStar = Game.projection.toStar();
        Glad.uniformMatrix4fv(projectLoc, 1, Glad.FALSE, projectStar);
        untyped __cpp__("free({0})", projectStar);
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