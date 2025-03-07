package blueprint.objects;

import math.Vector3;
import bindings.Glad;

import math.MathExtras;
import math.Vector2;
import math.Vector4;

import blueprint.graphics.Texture;
import blueprint.graphics.Shader;

/**
 * The base render object. Contains everything used for rendering.
 */
@:allow(blueprint.objects.Camera)
class Sprite {
	public static var defaultShader:Shader;
	public static var defaultTexture:Texture;
	static var _refVec3:Vector3 = new Vector3();
	static var _refVec2:Vector2 = new Vector2();

	public var memberOf(default, set):Group;
	public var cameras:Array<Camera> = [];
	public var parallax:Vector2 = new Vector2(1, 1);
	public var zoomFactor:Float = 1.0;
	public var targetZoom:Float = 1.0;

	public var position:Vector2;
	public var positionOffset:Vector2 = new Vector2(0, 0);
	public var dynamicOffset:Vector2 = new Vector2(0, 0);
	var renderOffset:Vector2 = new Vector2(0, 0);

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
	public var tint:Color = new Color(1.0);

	public var sourceRect:Rect = new Rect(0.0, 0.0, -1.0, -1.0);
	public var horizontalWrap:Int;
	public var verticalWrap:Int;
	public var antialiasing:Bool = true;
	public var visible:Bool = true;

	public function new(?x:Float = 0, ?y:Float = 0, ?imagePath:String) {
		position = new Vector2(x, y);
		
		horizontalWrap = Glad.CLAMP_TO_EDGE;
		verticalWrap = Glad.CLAMP_TO_EDGE;

		if (imagePath != null)
			texture = Texture.getCachedTex(imagePath);
	}

	public function update(elapsed:Float):Void {}

	public function getGlobalPosition(?stopAt:Group, ?result:Vector2):Vector2 {
		result = (result == null) ? new Vector2() : result;

		var curParent:Group = memberOf;
		var parents:Array<Group> = [];
		
		while (curParent != null && curParent != stopAt && !curParent.skipProperties) {
			parents.insert(0, curParent);
			curParent = curParent.memberOf;
		}
		if (parents.length <= 0) {
			result.copyFrom(position);
			result += positionOffset;
			return result;
		}
		
		var curSin:Float = 0.0;
		var curCos:Float = 1.0;
		var curScaleX:Float = 1.0;
		var curScaleY:Float = 1.0;
		result.copyFrom(parents[0].position);
		for (i in 0...parents.length) {
			final parent = parents[i];
			final offsetX = (parent.positionOffset.x * curScaleX * curCos - parent.positionOffset.y * curScaleY * curSin);
			final offsetY = (parent.positionOffset.x * curScaleX * curSin + parent.positionOffset.y * curScaleY * curCos);
			var nextX = (i == parents.length - 1) ? position.x : parents[i + 1].position.x;
			var nextY = (i == parents.length - 1) ? position.y : parents[i + 1].position.y;

			curScaleX *= parent.scale.x;
			curScaleY *= parent.scale.y;
			nextX *= curScaleX;
			nextY *= curScaleY;
			if (curSin != 0 || parent.rotation != 0) {
				final rad = MathExtras.toRad(parent.rotation);
				final cacheSin:Float = curSin;
				final cacheX:Float = nextX;
				final sin = Math.sin(rad);
				final cos = Math.cos(rad);
				curSin = cacheSin * cos + curCos * sin;
				curCos = curCos * cos - cacheSin * sin;

				nextX = cacheX * curCos - nextY * curSin;
				nextY = cacheX * curSin + nextY * curCos;
			}
			nextX += result.x * parent.positionFactor.x + offsetX;
			nextY += result.y * parent.positionFactor.y + offsetY;
			result.setFull(nextX, nextY);
		}

		result.x += (positionOffset.x * curScaleX * curCos - positionOffset.y * curScaleY * curSin);
		result.y += (positionOffset.x * curScaleX * curSin + positionOffset.y * curScaleY * curCos);
		return result;
	}
	public function getGlobalScale(?stopAt:Group, ?result:Vector2):Vector2 {
		var curParent:Group = memberOf;

		result = (result == null) ? new Vector2() : result;
		result.copyFrom(this.scale);

		while (curParent != null && curParent != stopAt && !curParent.skipProperties) {
			result *= curParent.scale;
			curParent = curParent.memberOf;
		}

		return result;
	}
	public function getGlobalRotation(?stopAt:Group):Float {
		var curParent:Group = memberOf;
		var result:Float = this.rotation;

		while (curParent != null && curParent != stopAt && !curParent.skipProperties) {
			result += curParent.rotation;
			curParent = curParent.memberOf;
		}

		return result;
	}

	public function queueDraw():Void {
		if (!visible || tint.a <= 0.0) return;

		if (_queueTrig)
			updateTrigValues();

		if (memberOf != null && !memberOf.skipProperties)
			calcRenderOffset(memberOf.scale, memberOf._sinMult, memberOf._cosMult);
		else 
			calcRenderOffset(null, null, null);

		final lastCameras = Camera.currentCameras;
		Camera.currentCameras = (cameras != null && cameras.length > 0) ? cameras : lastCameras;

		for (cam in Camera.currentCameras) {
			if (!cam.visible || cam.tint.a <= 0.0) continue;

			Camera.cacheTransform.set(null, position, renderOffset, scale, _sinMult, _cosMult, tint);
			_refVec2.x = MathExtras.lerp(targetZoom, cam.zoom.x, zoomFactor);
			_refVec2.y = MathExtras.lerp(targetZoom, cam.zoom.y, zoomFactor);

			// -cam.position to make the camera position look additional
			// as every sprite moves to the right, it looks like the camera is moving to the left
			position.x += -cam.position.x * parallax.x - Game.window.width * 0.5;
			position.y += -cam.position.y * parallax.y - Game.window.height * 0.5;
			position *= _refVec2;
			renderOffset *= _refVec2;

			if (cam.rotation != 0) {
				position.rotate(cam._sinMult, cam._cosMult);
				renderOffset.rotate(cam._sinMult, cam._cosMult);
	
				// sin(a + b) and cos(a + b) less go all that precalc is paying off
				// wait a minute this is just rotated point all over again
				final cacheSin:Float = _sinMult;
				_sinMult = cacheSin * cam._cosMult + _cosMult * cam._sinMult;
				_cosMult = _cosMult * cam._cosMult - cacheSin * cam._sinMult;
			}

			position.x += Game.window.width * 0.5;
			position.y += Game.window.height * 0.5;

			scale *= _refVec2;
			tint *= cam.tint;

			if (!offScreen())
				cam.queueDraw(this, position, renderOffset, scale, _sinMult, _cosMult, tint);

			position.copyFrom(Camera.cacheTransform.position);
			renderOffset.copyFrom(Camera.cacheTransform.offset);
            scale.copyFrom(Camera.cacheTransform.scale);
			_sinMult = Camera.cacheTransform.sin;
			_cosMult = Camera.cacheTransform.cos;
            tint.copyFrom(Camera.cacheTransform.tint);
		}

		Camera.currentCameras = lastCameras;
	}

	public function draw():Void {
		prepareTexture(texture);
		Glad.useProgram(shader.ID);
		prepareShaderVars();

		Glad.bindVertexArray(Game.window.VAO);
		Glad.drawElements(Glad.TRIANGLES, 6, Glad.UNSIGNED_INT, 0);
	}

	private function prepareTexture(texture:Texture):Void {
		Glad.activeTexture(Glad.TEXTURE0);
		Glad.bindTexture(Glad.TEXTURE_2D, texture.ID);

		Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_WRAP_S, horizontalWrap);
		Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_WRAP_T, verticalWrap);

		final filter = (antialiasing) ? Glad.LINEAR : Glad.NEAREST;
		Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_MIN_FILTER, filter);
		Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_MAG_FILTER, filter);
	}

	private function prepareShaderVars():Void {
		final uMult = bindings.CppHelpers.boolToInt(flipX);
		final vMult = bindings.CppHelpers.boolToInt(flipY);

		final sourceWidth = sourceWidth; // so im not constantly calling the setters.
		final sourceHeight = sourceHeight;
		
		shader.transform.reset(1.0);
		shader.transform.scale(_refVec3.set(sourceWidth, sourceHeight, 1));
		shader.transform.translate(_refVec3.set(dynamicOffset.x, dynamicOffset.y, 0));
		shader.transform.scale(_refVec3.set(scale.x, scale.y, 1));
		if (_sinMult != 0)
			shader.transform.rotate(_sinMult, _cosMult, _refVec3.set(0, 0, 1));
		shader.transform.translate(_refVec3.set(
			position.x + renderOffset.x,
			position.y + renderOffset.y,
			0
		));
		shader.setUniform("transform", shader.transform);

		shader.setUniform("tint", tint);
		Glad.uniform4f(Glad.getUniformLocation(shader.ID, "sourceRect"),
			(sourceRect.x + sourceWidth * uMult) / texture.width,
			(sourceRect.y + sourceHeight * vMult) / texture.height,
			(sourceRect.x + sourceWidth * (1 - uMult)) / texture.width,
			(sourceRect.y + sourceHeight * (1 - vMult)) / texture.height
		);
	}

	public function calcRenderOffset(?parentScale:Vector2, ?parentSin:Float, ?parentCos:Float):Void {
		renderOffset.copyFrom(positionOffset);
		if (parentScale != null)
			renderOffset.multiplyEq(parentScale);
		renderOffset.x += width * (0.5 - anchor.x);
		renderOffset.y += height * (0.5 - anchor.y);
		if (parentSin != null && parentCos != null)
			renderOffset.rotate(parentSin, parentCos);
	}

	private function updateTrigValues():Void {
		final radians = MathExtras.toRad(rotation);
		_cosMult = Math.cos(radians);
		_sinMult = Math.sin(radians);
		_queueTrig = false;
	}

	private function offScreen():Bool {
		final offsetX:Float = (dynamicOffset.x * scale.x * _cosMult - dynamicOffset.y * scale.y * _sinMult) + renderOffset.x;
		final offsetY:Float = (dynamicOffset.x * scale.x * _sinMult + dynamicOffset.y * scale.y * _cosMult) + renderOffset.y;
		
		var width:Float = width;
		var height:Float = height;
		// TODO: get the proper formula for proper sizes.
		// width = (width * _cosMult - height * _sinMult);
		// height = (this.width * _sinMult + height * _cosMult);

		// Do not apply anchors here. position + offset already takes care of that.
		final left:Float = position.x + offsetX - width * 0.5;
		final right:Float = position.x + offsetX + width * 0.5;
		final top:Float = position.y + offsetY - height * 0.5;
		final bottom:Float = position.y + offsetY + height * 0.5;

		final offScreenX:Bool = (Math.min(left, right) > Game.window.width) || (Math.max(left, right) < 0);
		final offScreenY:Bool = (Math.min(top, bottom) > Game.window.height) || (Math.max(top, bottom) < 0);

		return offScreenX || offScreenY;
	}

	public function destroy():Void {
		shader = null;
		texture = null;
	}

	function set_memberOf(parent:Group):Group {
		if (memberOf == parent)
			return parent;

		if (memberOf != null)
			memberOf.remove(this);
		if (parent != null)
			parent.add(this);
		return memberOf = parent;
	}

	function set_rotation(newRot:Float):Float {
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
		return (shader != null) ? shader : defaultShader;
	}

	inline function get_texture():Texture {
		return (texture != null) ? texture : defaultTexture;
	}
}