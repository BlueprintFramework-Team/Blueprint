package blueprint.text;

/**
 * TODO:
 *	- Fix Y Positioning
 *	- Fix Rotation
 *	- Allow Anchoring
 *	- Calculate Width & Height
 */

import bindings.Glad;

class Text extends blueprint.objects.Sprite {
	public static var autoPreloadSizes:Bool = true;

	public var font(default, set):Font;
	public var text(default, set):String;
	public var size(default, set):Int;

	public function new(x:Float, y:Float, fontPath:String, fontSize:Int, text:String) {
		super(x, y);

		font = Font.getCachedFont(fontPath);
		size = fontSize;
		if (autoPreloadSizes && font != null)
			font.preloadSize(fontSize);
		this.text = text;
	}

	override public function draw() {
		if (font == null) return;

		if (_queueTrig)
			updateTrigValues();

		Glad.useProgram(shader.ID);
		Glad.uniform4f(Glad.getUniformLocation(shader.ID, "tint"), tint.x, tint.y, tint.z, tint.w);
		Glad.uniform4f(Glad.getUniformLocation(shader.ID, "sourceRect"), 0, 0, 1, 1);
		final transLoc:Int = Glad.getUniformLocation(shader.ID, "transform");

		var curX:Float = 0.0;
		var curY:Float = 0.0;
		for (i in 0...text.length) {
			if (text.charAt(i) == '\n') {
				curX = 0.0;
				curY += size;
				continue;
			}

			var letter = font.getLetter(text.charCodeAt(i), size);

			Glad.activeTexture(Glad.TEXTURE0);
			Glad.bindTexture(Glad.TEXTURE_2D, letter.texture.ID);

			var filter = (antialiasing) ? Glad.LINEAR : Glad.NEAREST;
			Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_MIN_FILTER, filter);
			Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_MAG_FILTER, filter);
			
			shader.transform.reset(1.0);
			shader.transform.translate([(curX + letter.bearingX) / letter.texture.width, (curY - (letter.texture.height - letter.bearingY)) / letter.texture.height, 0]);
			// final xMove = curX * _cosMult + curY * -_sinMult;
			// final yMove = curX * _sinMult + curY * _cosMult;
			if (rotation != 0)
				shader.transform.rotate(_sinMult, _cosMult, [0, 0, 1]);
			final letterWidth = Math.abs(letter.texture.width * scale.x);
			final letterHeight = Math.abs(letter.texture.height * scale.y);
			shader.transform.scale([letterWidth, letterHeight, 1]);
			shader.transform.translate([
				position.x + letterWidth * 0.5,
				position.y + letterHeight * 0.5,
				0
			]);
			final transStar = shader.transform.toStar();
			Glad.uniformMatrix4fv(transLoc, 1, Glad.FALSE, transStar);
			untyped __cpp__("free({0})", transStar);

			Glad.bindVertexArray(Game.window.VAO);
			Glad.drawElements(Glad.TRIANGLES, 6, Glad.UNSIGNED_INT, untyped __cpp__('0'));

			curX += letter.advance >> 6;
		}
	}

	function set_font(newFont:Font):Font {
		return font = newFont;
	}

	function set_text(newText:String):String {
		return text = newText;
	}

	function set_size(newSize:Int):Int {
		return size = newSize;
	}
}