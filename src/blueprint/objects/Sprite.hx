package blueprint.objects;

import bindings.Glad;

import math.MathExtras;
import math.Vector2;
import math.Vector4;
import math.Rect;

import blueprint.graphics.Texture;
import blueprint.graphics.Shader;

/**
 * The base render object. Contains everything used for rendering.
 */
class Sprite {
	public static var defaultShader:Shader;
	public static var defaultTexture:Texture;

	public var position:Vector2;
	public var positionOffset:Vector2 = new Vector2(0, 0);
	public var dynamicOffset:Vector2 = new Vector2(0, 0);

	public var scale:Vector2 = new Vector2(1, 1);
	public var width(get, null):Int;
	public var height(get, null):Int;

	public var rotation(default, set):Float = 0;

	var _queueTrig:Bool = false;
	var _cosMult:Float = 1;
	var _sinMult:Float = 0;

	public var anchor:Vector2 = new Vector2(0.5, 0.5);

	@:noCompletion private var _shader:Shader;

	public var shader(get, set):Shader;

	@:noCompletion private var _texture:Texture;

	public var texture(get, set):Texture;
	public var tint:Vector4 = new Vector4(1.0);

	public var sourceRect:Rect = new Rect(0.0, 0.0, -1.0, -1.0);
	public var horizontalWrap:Int;
	public var verticalWrap:Int;
	public var antialiasing:Bool = true;

	public function new(?x:Float = 0, ?y:Float = 0) {
		position = new Vector2(x, y);
	}

	public function update(elapsed:Float):Void {}

	public function draw():Void {
		if (_queueTrig)
			updateTrigValues();

		if (offScreen())
			return;

		var anchorX:Float = 0.5 - anchor.x;
		var anchorY:Float = 0.5 - anchor.y;

		Glad.activeTexture(Glad.TEXTURE0);
		Glad.bindTexture(Glad.TEXTURE_2D, texture.ID);

		Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_WRAP_S, horizontalWrap);
		Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_WRAP_T, verticalWrap);

		var filter = (antialiasing) ? Glad.LINEAR : Glad.NEAREST;
		Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_MIN_FILTER, filter);
		Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_MAG_FILTER, filter);

		Glad.useProgram(shader.ID);
		prepareShaderVars(anchorX, anchorY);

		Glad.bindVertexArray(Game.window.VAO);
		Glad.drawElements(Glad.TRIANGLES, 6, Glad.UNSIGNED_INT, untyped __cpp__('0'));
	}

	private function prepareShaderVars(anchorX:Float, anchorY:Float):Void {
		shader.transform.reset(1.0);
		shader.transform.translate([dynamicOffset.x / texture.width, dynamicOffset.y / texture.height, 0]);
		if (rotation != 0)
			shader.transform.rotate(_sinMult, _cosMult, [0, 0, 1]);
		shader.transform.scale([width, height, 1]);
		shader.transform.translate([
			position.x + Math.abs(width) * anchorX,
			position.y + Math.abs(height) * anchorY,
			0
		]);
		final transLoc:Int = Glad.getUniformLocation(shader.ID, "transform");
		final transStar = shader.transform.toStar();
		Glad.uniformMatrix4fv(transLoc, 1, Glad.FALSE, transStar);
		untyped __cpp__("free({0})", transStar);

		Glad.uniform4f(Glad.getUniformLocation(shader.ID, "tint"), tint.x, tint.y, tint.z, tint.w);
		Glad.uniform4f(Glad.getUniformLocation(shader.ID, "sourceRect"), sourceRect.x / texture.width, sourceRect.y / texture.height,
			(sourceRect.x + (width / scale.x)) / texture.width, (sourceRect.y + (height / scale.y)) / texture.height);
	}

	function updateTrigValues() {
		var radians = MathExtras.toRad(rotation);
		_cosMult = Math.cos(radians);
		_sinMult = Math.sin(radians);
		_queueTrig = false;
	}

	function offScreen():Bool {
		var onScreenX:Bool = (position.x + width * anchor.x >= 0) && (position.x * (1 - anchor.x) < Game.window.width);
		var onScreenY:Bool = (position.y + height * anchor.y >= 0) && (position.y * (1 - anchor.y) < Game.window.height);

		return !(onScreenX && onScreenY);
	}

	function set_rotation(newRot:Float) {
		_queueTrig = _queueTrig || (newRot != rotation);
		return rotation = newRot;
	}

	inline function get_width():Int {
		var rectWidth = (sourceRect.width < 0) ? texture.width : sourceRect.width;
		return Math.floor(rectWidth * scale.x);
	}

	inline function get_height():Int {
		var rectHeight = (sourceRect.height < 0) ? texture.height : sourceRect.height;
		return Math.floor(rectHeight * scale.y);
	}

	inline function get_shader():Shader {
		return (_shader != null) ? _shader : defaultShader;
	}

	inline function set_shader(newShader:Shader):Shader {
		return _shader = newShader;
	}

	inline function get_texture():Texture {
		return (_texture != null) ? _texture : defaultTexture;
	}

	inline function set_texture(newTex:Texture):Texture {
		return _texture = newTex;
	}
}
