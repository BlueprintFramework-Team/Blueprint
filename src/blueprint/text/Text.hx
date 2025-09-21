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
 *  - Allow flipX, flipY
 *  - Allow sourceRect
 *  - Allow MSDFs for outlines
 */

enum TextAlignment {
	Left;
	Middle;
	Center; // why not
	Right;
	// a bit of Backwards Compactibility
	LEFT;
	MIDDLE;
	CENTER;
	RIGHT;
}

class Text extends blueprint.objects.Sprite {
	static inline final wordStopStr:String = " ,.!?:;/<({[]})>\\|~`+=-_^*&";
	static final wordStops:Array<Int> = [
		for (i in 0...wordStopStr.length)
			wordStopStr.charCodeAt(i)
	];

	public static var textQuality:Int = 4;
	public static var autoPreloadSizes:Bool = true;
	public static var defaultShader:Shader;
	public static var defaultShaderNoSDF:Shader;

	public var smoothing(default, set):Bool = true;
	public var quality(default, set):Int;
	var _smoothingMult:Float = 0.5;
	var _qualityFract:Float;
	var _oldStatQuality:Int;

	var _queueSize:Bool = true;
	var _lineMult:Float = 0;
	var _lineWidths:Array<Float> = [];
	var _newLines:Array<Int> = [];
	var _textWidth:Float;
	var _textHeight:Float;
	public var font(default, set):Font;
	public var text(default, set):String;
	public var size(default, set):Int;
	public var alignment(default, set):TextAlignment = LEFT;
	public var forceWidth(default, set):Float = 0.0;

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
		if (font == null || !visible || tint.a <= 0.0) return;

		if (_oldStatQuality != textQuality) {
			if (quality == _oldStatQuality)
				quality = textQuality;
			_oldStatQuality = textQuality;
		}

		if (_queueSize)
			updateTextSize();

		Glad.useProgram(shader.ID);
		shader.setUniform("fontSize", size);
		shader.setUniform("smoothingMult", _smoothingMult);
		Glad.uniform4f(Glad.getUniformLocation(shader.ID, "sourceRect"), 0, 0, 1, 1);
		transLoc = Glad.getUniformLocation(shader.ID, "transform");
		scaledSize = Math.floor(size * quality);

		if (outline > 0) {
			shader.setUniform("tint", outlineTint);
			curX = (_textWidth - _lineWidths[0]) * _lineMult * quality;
			lineNum = 0;
			for (i in 0...text.length) {
				if (lineNum < _newLines.length && _newLines[lineNum] == i) {
					++lineNum;
					curX = (_textWidth - _lineWidths[lineNum]) * _lineMult * quality;
					if (text.charAt(i) == "\n")
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
		curX = (_textWidth - _lineWidths[0]) * _lineMult * quality;
		lineNum = 0;
		for (i in 0...text.length) {
			if (lineNum < _newLines.length && _newLines[lineNum] == i) {
				++lineNum;
				curX = (_textWidth - _lineWidths[lineNum]) * _lineMult * quality;
				if (text.charAt(i) == "\n")
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
		if (_sinMult != 0)
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

	override function clone<T:Sprite>():T {
		var spr = new Text(0, 0, font.path, size, text);

		_copyOver(spr);

		spr.smoothing = smoothing;
		spr.quality = quality;
		spr.alignment = alignment;

		spr.outline = outline;
		spr.outlineTint.copyFrom(outlineTint);
		return cast spr;
	}

	override function destroy() {
		super.destroy();
		font = null;
		_lineWidths.splice(0, _lineWidths.length);
		_newLines.splice(0, _newLines.length);
	}

	function updateTextSize() {
		_queueSize = false;
		_lineWidths.splice(0, _lineWidths.length);
		_newLines.splice(0, _newLines.length);
		_textWidth = Math.max(forceWidth, 0.0);
		_textHeight = size;
		var firstLetter:Bool = true;
		var wasWordStop:Bool = false;
		var curWidth:Float = 0.0;
		var wordWidth:Float = 0.0;
		var widthSinceLastWord:Float = 0.0;
		var lastWordStop:Int = 0;

		inline function pushWidth(wid:Float, nextWid:Float) {
			_lineWidths.push(wid);
			_textWidth = Math.max(wid, _textWidth);
			_textHeight += size;

			curWidth = nextWid;
			wordWidth = nextWid;
			widthSinceLastWord = nextWid;
		}

		for (i in 0...text.length) {
			final code = text.charCodeAt(i);
			if (code == '\n'.code) {
				pushWidth(curWidth, 0.0);
				lastWordStop = i;
				firstLetter = true;
				wasWordStop = false;
				_newLines.push(i);
				continue;
			}

			firstLetter = false;
			final letter = font.getLetter(code, size, smoothing);
			final advance = letter.advance >> 6;

			curWidth += advance;

			if (forceWidth <= 0) continue;

			wordWidth += advance;

			if (curWidth > forceWidth) {
				if (wordWidth > forceWidth) { // just split the word
					pushWidth(curWidth - advance, advance);
					lastWordStop = i;
					_newLines.push(i);
				} else {
					pushWidth(widthSinceLastWord, wordWidth);
					_newLines.push(lastWordStop);
				}
			}

			if (wordStops.contains(code)) {
				if (code != " ".code) // may detach " " from the word stops later on to give a special case and make it feel less hardcoded.
					widthSinceLastWord = curWidth;
				else if (!wasWordStop)
					widthSinceLastWord = curWidth - advance;
				lastWordStop = i + 1;
				wordWidth = 0.0;
				wasWordStop = true;
			} else
				wasWordStop = false;
		}

		if (!firstLetter || _lineWidths.length <= 0) {
			_lineWidths.push(curWidth);
			_textWidth = Math.max(curWidth, _textWidth);
		}
	}

	function set_font(newFont:Font):Font {
		if (font == newFont)
			return font;

		if (font != null)
			--font.useCount;
		if (newFont != null)
			++newFont.useCount;

		return font = newFont;
	}

	function set_text(newText:String):String {
		_queueSize = _queueSize || (text != newText);
		return text = newText;
	}

	function set_size(newSize:Int):Int {
		_queueSize = _queueSize || (size != newSize);
		_smoothingMult = 6 / Math.abs(newSize); // dont think anybody would be doing negative size but yunno.
		return size = newSize;
	}

	function set_alignment(newAlign:TextAlignment):TextAlignment {
		switch (newAlign) {
			case Left | LEFT:
				_lineMult = 0;
				alignment = Left;
			case Middle | Center | MIDDLE | CENTER:
				_lineMult = 0.5;
				alignment = Center;
			case Right | RIGHT:
				_lineMult = 1.0;
				alignment = Right;
		}
		return alignment;
	}

	function set_forceWidth(newWidth:Float):Float {
		_queueSize = _queueSize || (forceWidth != newWidth);
		return forceWidth = newWidth;
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

	public static final defaultShaderSource:String = "
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
	";

	public static final defaultShaderSourceNoSDF:String = "
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
	";
}