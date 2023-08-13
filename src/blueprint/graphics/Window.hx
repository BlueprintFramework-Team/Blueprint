package blueprint.graphics;

import cpp.Pointer;
import bindings.Glfw;
import bindings.Glad;
import math.Vector4;

class Window {
    public var failed:Bool = false;

    public var VBO:cpp.UInt32;
    public var VAO:cpp.UInt32;
    public var EBO:cpp.UInt32;

    public var cWindow:GlfwWindow;

    public var width:Int;
    public var height:Int;
    public var clearColor:Vector4 = new Vector4(0.0, 0.0, 0.0, 1.0);

    public function new(width:Int, height:Int, name:String) {
        this.width = width;
        this.height = height;

        Glfw.windowHint(Glfw.CONTEXT_VERSION_MAJOR, 3);
        Glfw.windowHint(Glfw.CONTEXT_VERSION_MINOR, 3);
        Glfw.windowHint(Glfw.OPENGL_PROFILE, Glfw.OPENGL_CORE_PROFILE);

        cWindow = Glfw.createWindow(width, height, name, null, null);
        if (cWindow == null) {
            Sys.println("FAILED TO CREATE WINDOW. TERMINATING APPLICATION.");
            Glfw.terminate();
            failed = true;
            return;
        }
        Glfw.makeContextCurrent(cWindow);
        Glfw.setFramebufferSizeCallback(cWindow, cpp.Callable.fromStaticFunction(bufferResize));
        Glfw.swapInterval(0);
        
        if (Glad.loadHelper(Glfw.getProcAddress) == 0) {
            Sys.println("FAILED TO LOAD GLAD. TERMINATING APPLICATION.");
            Glfw.terminate();
            failed = true;
            return;
        }

        initBuffers();
        Glad.enable(Glad.BLEND);
        Glad.blendFunc(Glad.SRC_ALPHA, Glad.ONE_MINUS_SRC_ALPHA);
    }

    public function initBuffers() {
        var vertices:Array<cpp.Float32> = [
            //positions       //tex coords
            0.5,  0.5, 0.0,   1.0, 0.0,   // top right
            0.5, -0.5, 0.0,   1.0, 1.0,   // bottom right
           -0.5, -0.5, 0.0,   0.0, 1.0,   // bottom left
           -0.5,  0.5, 0.0,   0.0, 0.0    // top left 
        ];
        var indices:Array<Int> = [
            0, 1, 3,  // first Triangle
            1, 2, 3   // second Triangle
        ];

        Glad.genVertexArrays(1, Pointer.addressOf(VAO));
        Glad.genBuffers(1, Pointer.addressOf(VBO));
        Glad.genBuffers(1, Pointer.addressOf(EBO));
        Glad.bindVertexArray(VAO);
    
        Glad.bindBuffer(Glad.ARRAY_BUFFER, VBO);
        Glad.bufferFloatArray(Glad.ARRAY_BUFFER, vertices, Glad.STATIC_DRAW, 20);

        Glad.bindBuffer(Glad.ELEMENT_ARRAY_BUFFER, EBO);
        Glad.bufferIntArray(Glad.ELEMENT_ARRAY_BUFFER, cast indices, Glad.STATIC_DRAW, 6);
    
        Glad.vertexFloatAttrib(0, 3, Glad.FALSE, 5, 0);
        Glad.enableVertexAttribArray(0);
        Glad.vertexFloatAttrib(1, 2, Glad.FALSE, 5, 3);
        Glad.enableVertexAttribArray(1);
    
        Glad.bindBuffer(Glad.ARRAY_BUFFER, 0); 
        Glad.bindVertexArray(0);
    }

    public function destroy() {
        Glad.deleteVertexArrays(1, Pointer.addressOf(VAO));
        Glad.deleteBuffers(1, Pointer.addressOf(VBO));
        Glad.genBuffers(1, Pointer.addressOf(EBO));
    }

    // https://github.com/Leather128 - kept a consistent ratio when resizing.
    static function bufferResize(window:GlfwWindow, width:Int, height:Int) {
        var originalWidth:Int = width;
        var originalHeight:Int = height;
        var aspectRatio:Float = width / height;
        var x:Int = 0;
        var y:Int = 0;

        if (height > width) {
            height = Math.floor(height * aspectRatio);
            y = Math.floor((originalHeight - height) / 2);
        } else {
            width = Math.floor(width / aspectRatio);
            x = Math.floor((originalWidth - width) / 2);
        }

        Glad.viewport(x, y, width, height);
    }
}