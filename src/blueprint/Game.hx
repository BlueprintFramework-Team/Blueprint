package blueprint;

import blueprint.tweening.BaseTween;
import blueprint.input.InputHandler;
import cpp.Callable;

import bindings.Glad;
import bindings.Glfw;
import bindings.freetype.Freetype;
import bindings.freetype.FreetypeStroker;
import bindings.audio.ALC;

import math.Matrix4x4;

import blueprint.Scene;
import blueprint.objects.Sprite;
import blueprint.objects.AnimatedSprite;
import blueprint.graphics.Texture;
import blueprint.graphics.Shader;
import blueprint.graphics.Window;
import blueprint.sound.SoundData;
import blueprint.sound.Mixer;
import blueprint.text.Font;
import blueprint.text.Text;

class Game {
	public static var projection:Matrix4x4;

	public static var currentScene:Scene;
	private static var queuedSceneChange:Class<Scene> = null;
	private static var queuedSceneParams:Array<Dynamic> = [];

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

            // credit for the msdf shader: Blatko1/awesome-msdf
            // :)

            uniform int fontSize;
			uniform float smoothingMult;

            float uvToPixels(void) {
                vec2 unitRange = vec2(fontSize) / vec2(textureSize(bitmap, 0));
                vec2 screenTexSize = vec2(1.0) / fwidth(TexCoord);
                return max(smoothingMult * dot(unitRange, screenTexSize), 1.0);
            }

            void main(void) {
                float distance = texture(bitmap, TexCoord).r;
                
                float pixelDistance = uvToPixels() * (distance - 0.5);
                float alpha = clamp(pixelDistance + 0.5, 0.0, 1.0);
                
                FragColor = tint;
				FragColor.a *= alpha;
            }
		", Shader.defaultVertexSource);
		Text.defaultShaderNoSDF = new Shader("
			#version 330 core
			out vec4 FragColor;
			in vec2 TexCoord;

			uniform vec4 tint;
			uniform sampler2D bitmap;

			// unused when theres no smoothing
			uniform int fontSize;
			uniform float smoothingMult;

			void main(void) {
				FragColor = tint;
				FragColor.a *= texture(bitmap, TexCoord).r;
			}
		", Shader.defaultVertexSource);
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
		Freetype.init(RawPointer.addressOf(Font.library));
		FreetypeStroker.init(Font.library, RawPointer.addressOf(Font.stroker));

		currentScene = Type.createInstance(startScene, []);

		Glfw.setCharModsCallback(window.cWindow, Callable.fromStaticFunction(InputHandler.charInput));
		Glfw.setMouseButtonCallback(window.cWindow, Callable.fromStaticFunction(InputHandler.mouseInput));
		Glfw.setScrollCallback(window.cWindow, Callable.fromStaticFunction(InputHandler.scrollInput));
		Glfw.setKeyCallback(window.cWindow, Callable.fromStaticFunction(InputHandler.keyInput));

		ThreadHelper.startWindowThread(SoundData.updateSounds, 0.5); // may make a static var in the future to change the interval. (theres a delay to lower cpu on audio)
		ThreadHelper.mutex.acquire();
		while (!Glfw.windowShouldClose(window.cWindow)) {
			update();
			ThreadHelper.mutex.acquire();
			Glfw.makeContextCurrent(Game.window.cWindow);
		}
		ThreadHelper.mutex.release();

		currentScene.destroy();
		SoundData.clearSounds();
		Texture.clearCache();
		AnimatedSprite.clearCache();
		Font.clearCache();

		window.destroy();
		mixer.destroy();
		Glfw.terminate();
		Freetype.done(Font.library);
	}

	private static var lastTime:Float = 0;

	private function update():Void {
		if (queuedSceneChange != null) {
			currentScene.destroy();

			SoundData.clearSounds();
			Texture.clearCache();
			AnimatedSprite.clearCache();
			Font.clearCache();
			BaseTween.curTweens.splice(0, BaseTween.curTweens.length);

			currentScene = Type.createInstance(queuedSceneChange, queuedSceneParams);
			queuedSceneChange = null;
			lastTime = Glfw.getTime();
			cpp.vm.Gc.run(true);

			Glfw.makeContextCurrent(null);
			ThreadHelper.mutex.release();
			Glfw.pollEvents();

			return;
		}

		var runTime:Float = Glfw.getTime();
		elapsed = runTime - lastTime;
		lastTime = runTime;
		currentScene.update(elapsed);
		BaseTween.updateTweens(elapsed);

		Glad.clear(Glad.COLOR_BUFFER_BIT);

		currentScene.draw();

		Glfw.swapBuffers(window.cWindow);
		Glfw.makeContextCurrent(null);
		ThreadHelper.mutex.release();
		Glfw.pollEvents();
	}

	public static function queueClose():Void {
		Glfw.setWindowShouldClose(window.cWindow, 1);
	}

	public static function unQueueClose():Void {
		Glfw.setWindowShouldClose(window.cWindow, 0);
	}

	public static function changeSceneTo(scene:Class<Scene>, ...params:Dynamic) {
		queuedSceneChange = scene;
		queuedSceneParams = params.toArray();
	}
}
