package blueprint;

import cpp.Pointer;
import cpp.Callable;

import bindings.Glad;
import bindings.Glfw;
import bindings.Freetype;

import math.Matrix4x4;

import blueprint.Scene;
import blueprint.objects.Sprite;
import blueprint.graphics.Texture;
import blueprint.graphics.Shader;
import blueprint.graphics.Window;
import blueprint.sound.Mixer;
import blueprint.text.Font;
import blueprint.text.Text;

class Game {
	public static var projection:Matrix4x4;

	public static var currentScene:Scene;
	private static var queuedSceneChange:Class<Scene> = null;

	public static var elapsed:Float;

	public static var window:Window;

	public static var mixer:Mixer;

	public function new(width:Int, height:Int, name:String, startScene:Class<Scene>) {
		Glfw.init();
		Glfw.windowHint(Glfw.CONTEXT_VERSION_MAJOR, 3);
		Glfw.windowHint(Glfw.CONTEXT_VERSION_MINOR, 3);
		Glfw.windowHint(Glfw.OPENGL_PROFILE, Glfw.OPENGL_CORE_PROFILE);

		window = new Window(width, height, name);
		if (window.failed) {
			return;
		}

		mixer = new Mixer();
		if (mixer.failed) {
			return;
		}

		projection = Matrix4x4.ortho(0.0, width, height, 0.0, -1.0, 1.0);
		Sprite.defaultShader = new Shader(Shader.defaultFragmentSource, Shader.defaultVertexSource);
		Sprite.defaultTexture = new Texture("missingImage.png");
		Text.defaultShader = new Shader("
			#version 330 core
			out vec4 FragColor;
			in vec2 TexCoord;

			uniform vec4 tint;
			uniform sampler2D bitmap;

			void main() {
				float red = texture(bitmap, TexCoord).r;
				float derivativeSum = fwidth(red);
				FragColor = tint * smoothstep(0.5 - derivativeSum, 0.5 + derivativeSum, red);
        	}
		", Shader.defaultVertexSource);
		Freetype.init(Pointer.addressOf(Font.library));

		currentScene = Type.createInstance(startScene, []);

		Glfw.setKeyCallback(window.cWindow, Callable.fromStaticFunction(keyInput));

		while (!Glfw.windowShouldClose(window.cWindow)) {
			update();
		}

		window.destroy();
		mixer.destroy();
		Glfw.terminate();
		Freetype.done(Font.library);
	}

	private static var lastTime:Float = 0;

	private function update():Void {
		if (queuedSceneChange != null) {
			currentScene = Type.createInstance(queuedSceneChange, []);
			queuedSceneChange = null;
		}

		var runTime:Float = Glfw.getTime();
		elapsed = runTime - lastTime;
		lastTime = runTime;
		currentScene.update(elapsed);

		Glad.clear(Glad.COLOR_BUFFER_BIT);

		currentScene.draw();

		Glfw.swapBuffers(window.cWindow);
		Glfw.pollEvents();
	}

	static function keyInput(window:GlfwWindow, key:Int, scancode:Int, action:Int, mods:Int) {
		switch (action) {
			case Glfw.PRESS: Game.currentScene.keyDown(key, scancode, mods);
			case Glfw.REPEAT: Game.currentScene.keyRepeat(key, scancode, mods);
			case Glfw.RELEASE: Game.currentScene.keyUp(key, scancode, mods);
		}
	}

	public static function queueClose():Void {
		Glfw.setWindowShouldClose(window.cWindow, 1);
	}

	public static function unQueueClose():Void {
		Glfw.setWindowShouldClose(window.cWindow, 0);
	}

	public static function changeSceneTo(scene:Class<Scene>) {
		queuedSceneChange = scene;
	}
}
