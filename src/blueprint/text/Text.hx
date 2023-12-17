package blueprint.text;

import blueprint.graphics.Shader;

/**
 * TODO:
 *	- Allow Field Widths
 *	- Fix Rotation
 *	- Fix Y Positioning
 */

import bindings.Glad;

enum abstract TextAlignment(cpp.Int8) from cpp.Int8 to cpp.Int8 {
	var LEFT = 0;
	var MIDDLE = 1;
	var RIGHT = 2;
}

class Text extends blueprint.objects.Sprite {
	public static var autoPreloadSizes:Bool = true;
	public static var defaultShader:Shader;

	var _queueSize:Bool = true;
	var _lineWidths:Array<Float> = [];
	var _textWidth:Float;
	var _textHeight:Float;
	public var font(default, set):Font;
	public var text(default, set):String;
	public var size(default, set):Int;
	public var alignment:TextAlignment = LEFT;

	public function new(x:Float, y:Float, fontPath:String, fontSize:Int, text:String) {
		super(x, y);
		shader = Text.defaultShader;

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
		if (_queueSize)
			updateTextSize();

		Glad.useProgram(shader.ID);
		Glad.uniform4f(Glad.getUniformLocation(shader.ID, "tint"), tint.x, tint.y, tint.z, tint.w);
		Glad.uniform4f(Glad.getUniformLocation(shader.ID, "sourceRect"), 0, 0, 1, 1);
		final transLoc:Int = Glad.getUniformLocation(shader.ID, "transform");

		var curX:Float = (_textWidth - _lineWidths[0]) * (alignment * 0.5);
		var lineNum:Int = 0;
		for (i in 0...text.length) {
			if (text.charAt(i) == '\n') {
				lineNum++;
				curX = (_textWidth - _lineWidths[lineNum]) * (alignment * 0.5);
				continue;
			}

			final letter = font.getLetter(text.charCodeAt(i), size);

			Glad.activeTexture(Glad.TEXTURE0);
			Glad.bindTexture(Glad.TEXTURE_2D, letter.texture.ID);

			final filter = (antialiasing) ? Glad.LINEAR : Glad.NEAREST;
			Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_MIN_FILTER, filter);
			Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_MAG_FILTER, filter);
			
			shader.transform.reset(1.0);
			shader.transform.translate([(curX + letter.bearingX) / letter.texture.width, ((size * lineNum + size) + (letter.texture.height - letter.bearingY)) / letter.texture.height, 0]);
			// final xMove = curX * _cosMult + curY * -_sinMult;
			// final yMove = curX * _sinMult + curY * _cosMult;
			if (rotation != 0)
				shader.transform.rotate(_sinMult, _cosMult, [0, 0, 1]);
			final letterWidth = Math.abs(letter.texture.width * scale.x);
			final letterHeight = Math.abs(letter.texture.height * scale.y);
			shader.transform.scale([letterWidth, letterHeight, 1]);
			shader.transform.translate([
				position.x + letterWidth * 0.5 - Math.abs(width) * anchor.x,
				position.y + letterHeight * -0.5 - Math.abs(height) * anchor.y,
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

	override function destroy() {
		shader = null;
		_lineWidths.splice(0, _lineWidths.length);
	}

	function updateTextSize() {
		_queueSize = false;
		_lineWidths.splice(0, _lineWidths.length);
		_textHeight = size;
		var firstLetter:Bool = true;
		var curWidth:Float = 0.0;

		for (i in 0...text.length) {
			if (text.charAt(i) == '\n') {
				_lineWidths.push(curWidth);
				_textHeight += size;
				curWidth = 0.0;
				firstLetter = true;
				continue;
			}

			final letter = font.getLetter(text.charCodeAt(i), size);

			curWidth += letter.advance >> 6;
			_textWidth = Math.max(curWidth, _textWidth);
		}
		_lineWidths.push(curWidth);
	}

	function set_font(newFont:Font):Font {
		_queueSize = _queueSize || (font != newFont);
		return font = newFont;
	}

	function set_text(newText:String):String {
		_queueSize = _queueSize || (text != newText);
		return text = newText;
	}

	function set_size(newSize:Int):Int {
		_queueSize = _queueSize || (size != newSize);
		return size = newSize;
	}

	override function get_sourceWidth():Float {
		if (_queueSize)
			updateTextSize();
		return _textWidth;
	}

	override function get_sourceHeight():Float {
		if (_queueSize)
			updateTextSize();
		return _textHeight;
	}
}