package blueprint;

import sys.thread.Thread;
import cpp.Callable;

import bindings.Glad;
import bindings.Glfw;
import bindings.freetype.Freetype;
import bindings.freetype.FreetypeStroker;
import bindings.audio.ALC;

import math.Matrix4x4;

import blueprint.Scene;
import blueprint.objects.Camera;
import blueprint.objects.Sprite;
import blueprint.objects.ColorRect;
import blueprint.objects.AnimatedSprite;
import blueprint.graphics.SpriteFrames;
import blueprint.graphics.Texture;
import blueprint.graphics.Shader;
import blueprint.graphics.Window;
import blueprint.sound.SoundData;
import blueprint.sound.Mixer;
import blueprint.text.Font;
import blueprint.text.Text;
import blueprint.input.InputHandler;
import blueprint.tweening.BaseTween;

class Game {
	public static var projection:Matrix4x4;

	/**
		Additional scenes which all take updates.

		Useful for additional functionality or debug info.
	**/
	public static var plugins:Array<Scene> = [];
	/**
		The main scenes of the game, clearing itself on a scene change.

		Only the top scene will update and take inputs.
	**/
	public static var sceneStack:Array<Scene> = [null];

	public static var currentScene(get, set):Scene;
	public static var topScene(get, set):Scene;

	private static var queuedSceneChange:Class<Scene> = null;
	private static var queuedSceneParams:Array<Dynamic> = [];

	public static var updateFPS(default, set):Float = 0.0;
	private static var updateInterval:Float = 0.0;
	public static var drawFPS(default, set):Float = 0.0;
	private static var drawInterval:Float = 0.0;
	public static var elapsed:Float;

	public static var window:Window;

	public static var mixer:Mixer;

	public static var preLoop:Signal<Void->Void> = new Signal();

	public function new(width:Int, height:Int, name:String, startScene:Class<Scene>, ?startingPlugins:Array<Class<Scene>>) {
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
		Sprite.defaultShader.keepIfUnused = true;

		Text.defaultShader = new Shader(Text.defaultShaderSource, Shader.defaultVertexSource);
		Text.defaultShaderNoSDF = new Shader(Text.defaultShaderSourceNoSDF, Shader.defaultVertexSource);
		Text.defaultShader.keepIfUnused = true;
		Text.defaultShaderNoSDF.keepIfUnused = true;

		AnimatedSprite.backupFrame = {
			name: "BACKUP FRAME",
			texture: Sprite.defaultTexture,
			sourceX: 0,
			sourceY: 0,
			sourceWidth: Sprite.defaultTexture.width,
			sourceHeight: Sprite.defaultTexture.height,
			offsetX: 0,
			offsetY: 0
		};

		ColorRect.pixel = new Texture();
		ColorRect.pixel.keepIfUnused = true;
		var pixelData:cpp.RawPointer<cpp.UInt8> = CppHelpers.malloc(3, cpp.UInt8);
		pixelData[0] = pixelData[1] = pixelData[2] = 255;
		Glad.texImage2D(Glad.TEXTURE_2D, 0, Glad.RGB, 1, 1, 0, Glad.RGB, Glad.UNSIGNED_BYTE, pixelData);
		CppHelpers.free(pixelData);

		Freetype.init(RawPointer.addressOf(Font.library));
		FreetypeStroker.init(Font.library, RawPointer.addressOf(Font.stroker));

		Type.createInstance(startScene, []);
		if (startingPlugins != null && startingPlugins.length > 0) {
			for (cls in startingPlugins)
				createPlugin(cls);
		}

		Glfw.setCharModsCallback(window.cWindow, Callable.fromStaticFunction(InputHandler.charInput));
		Glfw.setMouseButtonCallback(window.cWindow, Callable.fromStaticFunction(InputHandler.mouseInput));
		Glfw.setScrollCallback(window.cWindow, Callable.fromStaticFunction(InputHandler.scrollInput));
		Glfw.setKeyCallback(window.cWindow, Callable.fromStaticFunction(InputHandler.keyInput));

		preLoop.emit();

		ThreadHelper.startWindowThread(SoundData.updateSounds);
		ThreadHelper.startWindowThread(update);
		ThreadHelper.startWindowThread(draw);
		ThreadHelper.mutex.acquire();
		while (!Glfw.windowShouldClose(window.cWindow)) {
			Glfw.makeContextCurrent(null);
			ThreadHelper.mutex.release();
			Glfw.waitEventsTimeout(0.1);
			ThreadHelper.mutex.acquire();
			Glfw.makeContextCurrent(Game.window.cWindow);
		}
		ThreadHelper.mutex.release();

		currentScene.destroy();

		Shader.clearShaders(true);
		Font.clearCache(true);
		SpriteFrameSet.clearCache(true);
		Texture.clearCache(true);
		ColorRect.pixel.destroy();
		SoundData.clearSounds(true);
		SoundData.clearCache(true);
		BaseTween.curTweens.splice(0, BaseTween.curTweens.length);
		Camera.clearCameras();

		window.destroy();
		mixer.destroy();
		Glfw.terminate();
		Freetype.done(Font.library);
	}

	private static var lastTime:Float = 0;

	private function update(runTime:Float):Float {
		// Sys.println("UPDATE TIMESTAMP: " + runTime);

		if (queuedSceneChange != null) {
			while (sceneStack.length > 0)
				sceneStack[sceneStack.length - 1].destroy();
			
			SoundData.clearSounds();
			SoundData.clearCache();
			BaseTween.curTweens.splice(0, BaseTween.curTweens.length);
			Camera.clearCameras();

			Font.enableKeepOnce = SpriteFrameSet.enableKeepOnce = Texture.enableKeepOnce = true;

			sceneStack.push(null);
			Type.createInstance(queuedSceneChange, queuedSceneParams);
			queuedSceneChange = null;

			Shader.clearShaders();
			Font.clearCache();
			SpriteFrameSet.clearCache();
			Texture.clearCache();

			Font.enableKeepOnce = SpriteFrameSet.enableKeepOnce = Texture.enableKeepOnce = false;

			lastTime = Glfw.getTime();
			cpp.vm.Gc.run(true);

			return 0.0;
		}

		elapsed = runTime - lastTime;
		lastTime = runTime;
		sceneStack[sceneStack.length - 1].update(elapsed);
		for (plugin in plugins)
			plugin.update(elapsed);
		BaseTween.updateTweens(elapsed);

		for (cam in Camera.allCameras)
			cam.update(elapsed);

		return updateInterval;
	}

	private function draw(runTime:Float):Float {
		// Sys.println("UPDATE TIMESTAMP: " + runTime);

		for (scene in sceneStack)
			scene.queueDraw();
		for (plugin in plugins)
			plugin.queueDraw();

		Glad.clear(Glad.COLOR_BUFFER_BIT);

		for (cam in Camera.allCameras)
			cam.drawQueues();

		Glfw.swapBuffers(window.cWindow);

		return drawInterval;
	}

	public static function queueClose():Void {
		Glfw.setWindowShouldClose(window.cWindow, 1);
	}

	public static function unQueueClose():Void {
		Glfw.setWindowShouldClose(window.cWindow, 0);
	}

	public static function addScene<T:Scene>(scene:Class<T>, ...params:Dynamic):T {
		sceneStack.push(null);
		return Type.createInstance(scene, params.toArray());
	}

	public static function createPlugin<T:Scene>(plugin:Class<T>, ...params:Dynamic):T {
		final scene:T = Type.createInstance(plugin, params.toArray());
		plugins.push(scene);
		return scene;
	}

	public static function changeSceneTo(scene:Class<Scene>, ...params:Dynamic):Void {
		queuedSceneChange = scene;
		queuedSceneParams = params.toArray();
	}

	static function get_currentScene():Scene {
		return sceneStack[0];
	}

	static function set_currentScene(newScene:Scene):Scene {
		return sceneStack[0] = newScene;
	}

	static function get_topScene():Scene {
		return sceneStack[sceneStack.length - 1];
	}

	static function set_topScene(newScene:Scene):Scene {
		return sceneStack[sceneStack.length - 1] = newScene;
	}

	static function set_updateFPS(newFPS:Float):Float {
		updateInterval = (newFPS <= 0.0) ? 0.0 : 1.0 / newFPS;
		return updateFPS = newFPS;
	}
	static function set_drawFPS(newFPS:Float):Float {
		drawInterval = (newFPS <= 0.0) ? 0.0 : 1.0 / newFPS;
		return drawFPS = newFPS;
	}
}
