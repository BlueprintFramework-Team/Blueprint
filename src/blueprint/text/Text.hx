package blueprint.text;

import math.Vector2;

import bindings.Glad;
import bindings.CppHelpers;

import blueprint.objects.Sprite;
import blueprint.graphics.Shader;
import blueprint.text.Font;

/**
 * TODO:
 *	- Allow Field Widths
 *  - Allow flipX, flipY
 *  - Allow sourceRect
 */

enum abstract TextAlignment(cpp.Int8) from cpp.Int8 to cpp.Int8 {
	var LEFT = 0;
	var MIDDLE = 1;
	var RIGHT = 2;
}

class Text extends blueprint.objects.Sprite {
	public static var textQuality(default, set):Int = 4;
	public static var autoPreloadSizes:Bool = true;
	public static var defaultShader:Shader;
	static var qualityFract:Float = 1 / textQuality;

	var _queueSize:Bool = true;
	var _lineWidths:Array<Float> = [];
	var _textWidth:Float;
	var _textHeight:Float;
	public var font(default, set):Font;
	public var text(default, set):String;
	public var size(default, set):Int;
	public var alignment:TextAlignment = LEFT;

	var letter:FontTexture;
	var transLoc:Int;
	var scaledSize:Int;
	var curX:Float;
	var lineNum:Int = 0;

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
		calcRenderOffset(memberOf.scale, memberOf._sinMult, memberOf._cosMult);

		Glad.useProgram(shader.ID);
		shader.setUniform("tint", tint);
		shader.setUniform("fontSize", size);
		Glad.uniform4f(Glad.getUniformLocation(shader.ID, "sourceRect"), 0, 0, 1, 1);
		transLoc = Glad.getUniformLocation(shader.ID, "transform");
		scaledSize = Math.floor(size * textQuality);

		curX = (_textWidth - _lineWidths[0]) * (alignment * 0.5) * textQuality;
		lineNum = 0;
		for (i in 0...text.length) {
			if (text.charAt(i) == '\n') {
				lineNum++;
				curX = (_textWidth - _lineWidths[lineNum]) * (alignment * 0.5) * textQuality;
				continue;
			}

			letter = font.getLetter(text.charCodeAt(i), scaledSize);
			prepareTexture(letter.texture);
			prepareShaderVars();

			Glad.bindVertexArray(Game.window.VAO);
			Glad.drawElements(Glad.TRIANGLES, 6, Glad.UNSIGNED_INT, 0);

			curX += letter.advance >> 6;
		}
	}

	override function prepareShaderVars() {
		shader.transform.reset(1.0);
		shader.transform.translate(Sprite._refVec3.set(
			((curX + letter.bearingX) + (letter.texture.width * 0.5) - (_textWidth * 0.5 * textQuality) + (dynamicOffset.x * textQuality)) / letter.texture.width,
			((scaledSize * lineNum + scaledSize) + (letter.texture.height - letter.bearingY) - (letter.texture.height * 0.5) - (_textHeight * 0.5 * textQuality) + (dynamicOffset.y * textQuality)) / letter.texture.height,
			0
		));
		final letterWidth = letter.texture.width * scale.x * qualityFract;
		final letterHeight = letter.texture.height * scale.y * qualityFract;
		shader.transform.scale(Sprite._refVec3.set(letterWidth, letterHeight, 1));
		if (rotation != 0)
			shader.transform.rotate(_sinMult, _cosMult, Sprite._refVec3.set(0, 0, 1));
		shader.transform.translate(Sprite._refVec3.set(
			position.x + renderOffset.x,
			position.y + renderOffset.y,
			0
		));
		final transStar = shader.transform.toCArray();
		Glad.uniformMatrix4fv(transLoc, 1, Glad.FALSE, transStar);
		CppHelpers.free(transStar);
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

	static function set_textQuality(newQual:Int) {
		newQual = Math.floor(Math.max(newQual, 1));
		qualityFract = 1 / newQual;
		return textQuality = newQual;
	}
}