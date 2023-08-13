package blueprint;

import cpp.Pointer;
import cpp.Callable;
import bindings.Glad;
import bindings.Glfw;
import math.Matrix4x4;
import blueprint.Scene;
import blueprint.objects.Sprite;
import blueprint.graphics.Texture;
import blueprint.graphics.Shader;
import blueprint.graphics.Window;

using StringTools;

class Game {
	public static var projection:Matrix4x4;

	public static var currentScene:Scene;

	public static var elapsed:Float;

	public static var window:Window;

	public function new(width:Int, height:Int, name:String, startScene:Class<Scene>) {
		Glfw.init();
		Glfw.windowHint(Glfw.CONTEXT_VERSION_MAJOR, 3);
		Glfw.windowHint(Glfw.CONTEXT_VERSION_MINOR, 3);
		Glfw.windowHint(Glfw.OPENGL_PROFILE, Glfw.OPENGL_CORE_PROFILE);

		window = new Window(width, height, name);
		if (window.failed)
			return;

		projection = Matrix4x4.ortho(0.0, width, 0, height, -1.0, 1.0);
		Sprite.defaultShader = new Shader("#version 330 core
            out vec4 FragColor;
            in vec2 TexCoord;

            uniform vec4 tint;
            uniform sampler2D bitmap;

            void main() {
                FragColor = texture(bitmap, TexCoord) * tint;
            }", "#version 330 core
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
            }");

		Sprite.defaultTexture = new Texture("missingImage.png");

		currentScene = Type.createInstance(startScene, []);

		while (!Glfw.windowShouldClose(window.cWindow))
			update();

		window.destroy();

		Glfw.terminate();
	}

	static var lastTime:Float = 0;

	function update() {
		var runTime:Float = Glfw.getTime();
		elapsed = runTime - lastTime;
		lastTime = runTime;
		currentScene.update(elapsed);

		Glad.clear(Glad.COLOR_BUFFER_BIT);

		currentScene.draw();

		Glfw.swapBuffers(window.cWindow);
		Glfw.pollEvents();
	}
}
