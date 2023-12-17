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
	public var width(get, null):Float;
	public var height(get, null):Float;
	public var sourceWidth(get, null):Float;
	public var sourceHeight(get, null):Float;

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
		horizontalWrap = Glad.CLAMP_TO_EDGE;
		verticalWrap = Glad.CLAMP_TO_EDGE;
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
		Glad.uniform4f(Glad.getUniformLocation(shader.ID, "sourceRect"),
			sourceRect.x / texture.width,
			sourceRect.y / texture.height,
			(sourceRect.x + sourceWidth) / texture.width,
			(sourceRect.y + sourceHeight) / texture.height
		);
	}

	function updateTrigValues() {
		final radians = MathExtras.toRad(rotation);
		_cosMult = Math.cos(radians);
		_sinMult = Math.sin(radians);
		_queueTrig = false;
	}

	function offScreen():Bool {
		final onScreenX:Bool = (position.x + width * anchor.x >= 0) && (position.x * (1 - anchor.x) < Game.window.width);
		final onScreenY:Bool = (position.y + height * anchor.y >= 0) && (position.y * (1 - anchor.y) < Game.window.height);

		return !(onScreenX && onScreenY);
	}

	public function destroy() {
		shader = null;
		texture = null;
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
		return (sourceRect.width < 0) ? texture.width : sourceRect.width;
	}

	function get_sourceHeight():Float {
		return (sourceRect.height < 0) ? texture.height : sourceRect.height;
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
