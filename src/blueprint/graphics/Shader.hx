package blueprint.graphics;

import bindings.CppHelpers;
import cpp.ConstCharStar;
import cpp.Pointer;
import cpp.Native;
import bindings.Glad;

class Shader {
    public var ID:cpp.UInt32;

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

        var projectLoc = Glad.getUniformLocation(ID, "projection");
        Glad.uniformMatrix4fv(projectLoc, 1, Glad.FALSE, Game.projection.toStar());
    }
}