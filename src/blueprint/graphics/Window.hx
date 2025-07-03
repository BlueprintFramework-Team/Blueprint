package blueprint.graphics;

import cpp.RawPointer;

import bindings.Glfw;
import bindings.Glad;

import math.Vector4;
import math.Vector2;

class Window {
	public var failed:Bool = false;

	public var VBO:cpp.UInt32;
	public var VAO:cpp.UInt32;
	public var EBO:cpp.UInt32;

	public var cWindow:GlfwWindow;

	public var width:Int;
	public var height:Int;

	public var viewSize:Vector2;
	public var viewOffset:Vector2;
	public var resized:Signal<Int->Int->Void>;

	public var vSync(default, set):Bool;
	public var clearColor(default, set):Vector4;

	private function set_clearColor(value:Vector4):Vector4 {
		Glad.clearColor(value.r * value.a, value.g * value.a, value.b * value.a, value.a);
		return clearColor = value;
	}

	private function set_vSync(value:Bool):Bool {
		Glfw.swapInterval(value ? Glfw.TRUE : Glfw.FALSE);
		return vSync = value;
	}

	public function new(width:Int, height:Int, name:String) {
		this.width = width;
		this.height = height;
		this.resized = new Signal();
		this.viewSize = new Vector2(width, height);
		this.viewOffset = new Vector2();

		cWindow = Glfw.createWindow(width, height, name, null, null);
		if (cWindow == null) {
			Sys.println("Failed to create window. Terminating application.");
			Glfw.terminate();
			failed = true;
			return;
		}
		Glfw.makeContextCurrent(cWindow);
		Glfw.setFramebufferSizeCallback(cWindow, cpp.Callable.fromStaticFunction(bufferResize));
		vSync = false;

		if (Glad.loadHelper(Glfw.getProcAddress) == 0) {
			Sys.println("Failed to load Glad. Terminating application.");
			Glfw.terminate();
			failed = true;
			return;
		}

		initBuffers();
		Glad.enable(Glad.BLEND);
		Glad.blendFunc(Glad.SRC_ALPHA, Glad.ONE_MINUS_SRC_ALPHA);
		clearColor = new Vector4(0.0, 0.0, 0.0, 1.0);
	}

	public function initBuffers() {
		var vertices:Array<cpp.Float32> = [
			// position,		texture coords
			0.5, -0.5, 0.0,		1.0, 0.0,
			0.5, 0.5, 0.0,		1.0, 1.0,
			-0.5, 0.5, 0.0,		0.0, 1.0,
			-0.5, -0.5, 0.0,	0.0, 0.0,
		];
		var indices:Array<cpp.UInt32> = [
			0, 1, 3, // first Triangle
			1, 2, 3 // second Triangle
		];

		Glad.genVertexArrays(1, RawPointer.addressOf(VAO));
		Glad.genBuffers(1, RawPointer.addressOf(VBO));
		Glad.genBuffers(1, RawPointer.addressOf(EBO));
		Glad.bindVertexArray(VAO);

		Glad.bindBuffer(Glad.ARRAY_BUFFER, VBO);
		Glad.bufferFloatArray(Glad.ARRAY_BUFFER, vertices, Glad.STATIC_DRAW, 20);

		Glad.bindBuffer(Glad.ELEMENT_ARRAY_BUFFER, EBO);
		Glad.bufferIntArray(Glad.ELEMENT_ARRAY_BUFFER, indices, Glad.STATIC_DRAW, 6);

		Glad.vertexFloatAttrib(0, 3, Glad.FALSE, 5, 0);
		Glad.enableVertexAttribArray(0);
		Glad.vertexFloatAttrib(1, 2, Glad.FALSE, 5, 3);
		Glad.enableVertexAttribArray(1);

		Glad.bindBuffer(Glad.ARRAY_BUFFER, 0);
		Glad.bindVertexArray(0);
	}

	public function destroy() {
		Glfw.destroyWindow(cWindow);
		Glad.deleteVertexArrays(1, RawPointer.addressOf(VAO));
		Glad.deleteBuffers(1, RawPointer.addressOf(VBO));
		Glad.genBuffers(1, RawPointer.addressOf(EBO));
	}

	// function by MidnightBloxxer, using code by swordcube for reference.
	private static function bufferResize(window:GlfwWindow, width:Int, height:Int) {
		ThreadHelper.mutex.acquire();
		Glfw.makeContextCurrent(Game.window.cWindow);

		final gameRatio:Float = Game.window.width / Game.window.height;
		final windowRatio:Float = width / height;

		Game.window.viewSize.setFull(
			Math.ffloor((windowRatio > gameRatio) ? (height * gameRatio) : (width)),
			Math.ffloor((windowRatio < gameRatio) ? (width / gameRatio) : (height))
		);
		Game.window.viewOffset.setFull(
			Math.ffloor((width - Game.window.viewSize.x) * 0.5),
			Math.ffloor((height - Game.window.viewSize.y) * 0.5)
		);

		Glad.viewport(
			Std.int(Game.window.viewOffset.x),
			Std.int(Game.window.viewOffset.y),
			Std.int(Game.window.viewSize.x),
			Std.int(Game.window.viewSize.y)
		);
		Game.window.resized.emit(width, height);

		Glfw.makeContextCurrent(null);
		ThreadHelper.mutex.release();
	}
}
