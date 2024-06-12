package blueprint.objects;

import bindings.Glad;

import math.MathExtras;
import math.Vector2;
import math.Vector4;

import blueprint.graphics.Texture;
import blueprint.graphics.Shader;

/**
 * The base render object. Contains everything used for rendering.
 */
class Sprite {
	public static var defaultShader:Shader;
	public static var defaultTexture:Texture;

	public var memberOf(default, set):Group;

	public var position:Vector2;
	public var positionOffset:Vector2 = new Vector2(0, 0);
	public var dynamicOffset:Vector2 = new Vector2(0, 0);

	public var scale:Vector2 = new Vector2(1, 1);
	public var flipX:Bool = false;
	public var flipY:Bool = false;
	public var width(get, null):Float;
	public var height(get, null):Float;
	public var sourceWidth(get, null):Float;
	public var sourceHeight(get, null):Float;

	public var rotation(default, set):Float = 0;

	var _queueTrig:Bool = false;
	var _cosMult:Float = 1;
	var _sinMult:Float = 0;

	public var anchor:Vector2 = new Vector2(0.5, 0.5);

	@:isVar public var shader(get, default):Shader;
	@:isVar public var texture(get, default):Texture;
	public var tint:Vector4 = new Vector4(1.0);

	public var sourceRect:Rect = new Rect(0.0, 0.0, -1.0, -1.0);
	public var horizontalWrap:Int;
	public var verticalWrap:Int;
	public var antialiasing:Bool = true;

	public function new(?x:Float = 0, ?y:Float = 0, ?imagePath:String) {
		position = new Vector2(x, y);
		
		horizontalWrap = Glad.CLAMP_TO_EDGE;
		verticalWrap = Glad.CLAMP_TO_EDGE;

		if (imagePath != null)
			texture = Texture.getCachedTex(imagePath);
	}

	public function update(elapsed:Float):Void {}

	public function draw():Void {
		if (_queueTrig)
			updateTrigValues();

		if (offScreen())
			return;

		final anchorX:Float = 0.5 - anchor.x;
		final anchorY:Float = 0.5 - anchor.y;

		Glad.activeTexture(Glad.TEXTURE0);
		Glad.bindTexture(Glad.TEXTURE_2D, texture.ID);

		Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_WRAP_S, horizontalWrap);
		Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_WRAP_T, verticalWrap);

		final filter = (antialiasing) ? Glad.LINEAR : Glad.NEAREST;
		Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_MIN_FILTER, filter);
		Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_MAG_FILTER, filter);

		Glad.useProgram(shader.ID);
		prepareShaderVars(anchorX, anchorY);

		Glad.bindVertexArray(Game.window.VAO);
		Glad.drawElements(Glad.TRIANGLES, 6, Glad.UNSIGNED_INT, 0);
	}

	private function prepareShaderVars(anchorX:Float, anchorY:Float):Void {
		final uMult = bindings.CppHelpers.boolToInt(flipX);
		final vMult = bindings.CppHelpers.boolToInt(flipY);

		final sourceWidth = sourceWidth; // so im not constantly calling the setters.
		final sourceHeight = sourceHeight;
		final width = width;
		final height = height;
		
		shader.transform.reset(1.0);
		shader.transform.translate([dynamicOffset.x / sourceWidth, dynamicOffset.y / sourceHeight, 0]);
		shader.transform.scale([width, height, 1]);
		if (rotation != 0)
			shader.transform.rotate(_sinMult, _cosMult, [0, 0, 1]);
		shader.transform.translate([
			position.x + positionOffset.x + width * anchorX,
			position.y + positionOffset.y + height * anchorY,
			0
		]);
		shader.setUniform("transform", shader.transform);

		shader.setUniform("tint", tint);
		Glad.uniform4f(Glad.getUniformLocation(shader.ID, "sourceRect"),
			(sourceRect.x + sourceWidth * uMult) / texture.width,
			(sourceRect.y + sourceHeight * vMult) / texture.height,
			(sourceRect.x + sourceWidth * (1 - uMult)) / texture.width,
			(sourceRect.y + sourceHeight * (1 - vMult)) / texture.height
		);
	}

	function updateTrigValues() {
		final radians = MathExtras.toRad(rotation);
		_cosMult = Math.cos(radians);
		_sinMult = Math.sin(radians);
		_queueTrig = false;
	}

	function offScreen():Bool {
		final offsetX:Float = (dynamicOffset.x * scale.x * _cosMult - dynamicOffset.y * scale.y * _sinMult) + positionOffset.x;
		final offsetY:Float = (dynamicOffset.x * scale.x * _sinMult + dynamicOffset.y * scale.y * _cosMult) + positionOffset.y;
		var width:Float = width;
		var height:Float = height;
		width = (width * _cosMult - height * _sinMult);
		height = (this.width * _sinMult + height * _cosMult);

		final onScreenX:Bool = (position.x + offsetX - width * anchor.x >= 0) || (position.x + offsetX + width * (1 - anchor.x) <= Game.window.width);
		final onScreenY:Bool = (position.y + offsetY - height * anchor.y >= 0) || (position.y + offsetY + height * (1 - anchor.y) <= Game.window.height);

		return !(onScreenX && onScreenY);
	}

	public function destroy() {
		shader = null;
		texture = null;
	}

	function set_memberOf(parent:Group) {
		if (memberOf == parent)
			return parent;

		if (memberOf != null)
			memberOf.remove(this);
		if (parent != null)
			memberOf.add(this);
		return memberOf = parent;
	}

	function set_rotation(newRot:Float) {
		_queueTrig = _queueTrig || (newRot != rotation);
		return rotation = newRot;
	}

	inline function get_width():Float {
		return sourceWidth * scale.x;
	}

	inline function get_height():Float {
		return sourceHeight * scale.y;
	}

	function get_sourceWidth():Float {
		return ((sourceRect.width < 0) ? texture.width : sourceRect.width) - sourceRect.x;
	}

	function get_sourceHeight():Float {
		return ((sourceRect.height < 0) ? texture.height : sourceRect.height) - sourceRect.y;
	}

	inline function get_shader():Shader {
		return (shader != null) ? shader : defaultShader;
	}

	inline function get_texture():Texture {
		return (texture != null) ? texture : defaultTexture;
	}
}
