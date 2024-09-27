package blueprint.text;

import math.Vector2;
import math.Vector4;

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
 *  - Allow MSDFs for outlines
 */

enum abstract TextAlignment(cpp.Int8) from cpp.Int8 to cpp.Int8 {
	var LEFT = 0;
	var MIDDLE = 1;
	var RIGHT = 2;
}

class Text extends blueprint.objects.Sprite {
	public static var textQuality:Int = 4;
	public static var autoPreloadSizes:Bool = true;
	public static var defaultShader:Shader;
	public static var defaultShaderNoSDF:Shader;

	public var smoothing(default, set):Bool = true;
	public var quality(default, set):Int;
	var _qualityFract:Float;
	var _oldStatQuality:Int;

	var _queueSize:Bool = true;
	var _lineWidths:Array<Float> = [];
	var _textWidth:Float;
	var _textHeight:Float;
	public var font(default, set):Font;
	public var text(default, set):String;
	public var size(default, set):Int;
	public var alignment:TextAlignment = LEFT;

	public var outline:Int = 0;
	public var outlineTint:Color = new Color(0.0, 0.0, 0.0, 1.0);

	var letter:FontTexture = null;
	var outlineRef:OutlineRef = null;
	var transLoc:Int;
	var scaledSize:Int;
	var curX:Float;
	var lineNum:Int = 0;

	public function new(x:Float, y:Float, fontPath:String, fontSize:Int, text:String) {
		super(x, y);
		shader = Text.defaultShader;
		quality = _oldStatQuality = textQuality;
		
		font = Font.getCachedFont(fontPath);
		size = fontSize;
		if (autoPreloadSizes && font != null)
			font.preloadSize(fontSize * quality);
		this.text = text;
	}

	override public function draw() {
		if (font == null) return;

		if (_oldStatQuality != textQuality) {
			if (quality == _oldStatQuality)
				quality = textQuality;
			_oldStatQuality = textQuality;
		}

		if (_queueTrig)
			updateTrigValues();
		if (_queueSize)
			updateTextSize();

		if (memberOf != null && !memberOf.skipProperties)
			calcRenderOffset(memberOf.scale, memberOf._sinMult, memberOf._cosMult);
		else 
			calcRenderOffset(null, null, null);

		Glad.useProgram(shader.ID);
		shader.setUniform("fontSize", size);
		Glad.uniform4f(Glad.getUniformLocation(shader.ID, "sourceRect"), 0, 0, 1, 1);
		transLoc = Glad.getUniformLocation(shader.ID, "transform");
		scaledSize = Math.floor(size * quality);

		if (outline > 0) {
			shader.setUniform("tint", outlineTint);
			curX = (_textWidth - _lineWidths[0]) * (alignment * 0.5) * quality;
			lineNum = 0;
			for (i in 0...text.length) {
				if (text.charAt(i) == '\n') {
					lineNum++;
					curX = (_textWidth - _lineWidths[lineNum]) * (alignment * 0.5) * quality;
					continue;
				}
	
				outlineRef = font.getOutline(text.charCodeAt(i), scaledSize, outline * quality, smoothing);
				prepareTexture(outlineRef.texture);
				prepareShaderVars();
	
				Glad.bindVertexArray(Game.window.VAO);
				Glad.drawElements(Glad.TRIANGLES, 6, Glad.UNSIGNED_INT, 0);
	
				curX += outlineRef.parent.advance >> 6;
			}
			outlineRef = null;
		}

		shader.setUniform("tint", tint);
		curX = (_textWidth - _lineWidths[0]) * (alignment * 0.5) * quality;
		lineNum = 0;
		for (i in 0...text.length) {
			if (text.charAt(i) == '\n') {
				lineNum++;
				curX = (_textWidth - _lineWidths[lineNum]) * (alignment * 0.5) * quality;
				continue;
			}

			letter = font.getLetter(text.charCodeAt(i), scaledSize, smoothing);
			prepareTexture(letter.texture);
			prepareShaderVars();

			Glad.bindVertexArray(Game.window.VAO);
			Glad.drawElements(Glad.TRIANGLES, 6, Glad.UNSIGNED_INT, 0);

			curX += letter.advance >> 6;
		}
		letter = null;
	}

	override function prepareShaderVars() {
		final texture = (letter == null) ? outlineRef.texture : letter.texture;
		final data = (letter == null) ? outlineRef.parent : letter;

		shader.transform.reset(1.0);
		shader.transform.translate(Sprite._refVec3.set(
			((curX + data.bearingX) + (texture.width * 0.5) - (_textWidth * 0.5 * quality) + (dynamicOffset.x * quality) - (texture.width - data.texture.width) * 0.5) / texture.width,
			((scaledSize * lineNum + scaledSize) + (texture.height - data.bearingY) - (texture.height * 0.5) - (_textHeight * 0.5 * quality) + (dynamicOffset.y * quality) - (texture.height - data.texture.height) * 0.5) / texture.height,
			0
		));
		final letterWidth = texture.width * scale.x * _qualityFract;
		final letterHeight = texture.height * scale.y * _qualityFract;
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

			final letter = font.getLetter(text.charCodeAt(i), size, smoothing);

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

	function set_smoothing(newSmooth:Bool) {
		if (shader == defaultShader && !newSmooth)
			shader = defaultShaderNoSDF;
		else if (shader == defaultShaderNoSDF && newSmooth)
			shader = defaultShader;

		return smoothing = newSmooth;
	}

	function set_quality(newQual:Int) {
		newQual = Math.floor(Math.max(newQual, 1));
		_qualityFract = 1 / newQual;
		return quality = newQual;
	}
}