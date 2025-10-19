package blueprint.objects;

import bindings.Glad;
import blueprint.graphics.Texture;

/**
TO NOTE WHILE USING VIEW CAPTURES:
 - Some things will break if you try to either give an instance multiple cameras or add it to multiple groups.
 - Due to our projection technique, flipY will have to be enabled in order for it to look right.
 - Alpha is currently iffy. Research on how to remedy this may be sought for but it may help to adapt your shader for now.
**/
class ViewCapture extends Sprite {
	public var framebuffer:cpp.UInt32;
	public var next:ViewCapture = null;

	public var drawAfter:Bool = false;

	public function new() {
		super();
		flipY = true;

		texture = new Texture();
		Game.window.resized.add(fixTexture);
		fixTexture(1, 1); // we dont use the params.

		Glad.genFramebuffers(1, RawPointer.addressOf(framebuffer));
		Glad.bindFramebuffer(Glad.FRAMEBUFFER, framebuffer);
		Glad.bindTexture(Glad.TEXTURE_2D, texture.ID);
		Glad.framebufferTexture2D(Glad.FRAMEBUFFER, Glad.COLOR_ATTACHMENT0, Glad.TEXTURE_2D, texture.ID, 0);
		Glad.bindFramebuffer(Glad.FRAMEBUFFER, 0);
		Glad.bindTexture(Glad.TEXTURE_2D, 0);
	}

	function fixTexture(wid:Int, hei:Int) {
		texture.width = Game.window.width;
		texture.height = Game.window.height;

		Glad.bindTexture(Glad.TEXTURE_2D, texture.ID);
		Glad.texImage2D(Glad.TEXTURE_2D, 0, Glad.RGBA, Std.int(Game.window.viewSize.x), Std.int(Game.window.viewSize.y), 0, Glad.RGBA, Glad.UNSIGNED_BYTE, cast null);
	}

	override function queueDraw() {
		if (!visible || tint.a <= 0.0) return;
		
		final cam = (cameras != null && cameras.length > 0) ? cameras[0] : Camera.currentCameras[0];

		if (cam.lastViewCapture != null)
			cam.lastViewCapture.next = this;
		else 
			cam.firstViewCapture = this;
		cam.lastViewCapture = this;

		prepareTransform();
		if (cam.visible && cam.tint.a >= 0.0)
			cam.queueDraw(this, transform, tint);
	}

	override function draw() {
		if (next != null) {
			Glad.bindFramebuffer(Glad.FRAMEBUFFER, next.framebuffer);
			Glad.clear(Glad.COLOR_BUFFER_BIT);
			next = null;
		} else {
			Glad.bindFramebuffer(Glad.FRAMEBUFFER, 0);
			Glad.clearColor(Game.window.clearColor.r, Game.window.clearColor.g, Game.window.clearColor.b, Game.window.clearColor.a);
			Glad.viewport(
				Std.int(Game.window.viewOffset.x),
				Std.int(Game.window.viewOffset.y),
				Std.int(Game.window.viewSize.x),
				Std.int(Game.window.viewSize.y)
			);
		}

		if (drawAfter)
			super.draw();
	}

	override function prepareShaderVars() {
		final uMult = bindings.CppHelpers.boolToInt(flipX);
		final vMult = bindings.CppHelpers.boolToInt(flipY);
	
		final sourceWidth = sourceWidth; // so im not constantly calling the setters.
		final sourceHeight = sourceHeight;

		shader.transform.reset(1.0);
		shader.transform.scale(Sprite._refVec3.set(sourceWidth, sourceHeight, 1));
		shader.transform.translate(Sprite._refVec3.set(Game.window.width * 0.5, Game.window.height * 0.5, 1));
		shader.setUniform("transform", shader.transform);

		shader.setUniform("tint", tint);
		Glad.uniform4f(Glad.getUniformLocation(shader.ID, "sourceRect"),
			(sourceRect.x + sourceWidth * uMult) / texture.width,
			(sourceRect.y + sourceHeight * vMult) / texture.height,
			(sourceRect.x + sourceWidth * (1 - uMult)) / texture.width,
			(sourceRect.y + sourceHeight * (1 - vMult)) / texture.height
		);
	}

	override function destroy() {
		texture.destroy();
		Glad.deleteFramebuffers(1, RawPointer.addressOf(framebuffer));
		super.destroy();
	}
}