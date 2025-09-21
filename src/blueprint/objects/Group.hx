package blueprint.objects;

import bindings.Glad;

import math.Vector2;
import math.MathExtras;

import blueprint.objects.Sprite;
import blueprint.objects.Camera;

class Group extends Sprite {
	var cacheTransform:QueuedDraw = new QueuedDraw(); // Sprite also uses cacheTransform so I can't really use Camera.cacheTransform.

	public var positionFactor:Vector2 = new Vector2(1.0);
	public var members:Array<Sprite> = [];
	public var skipProperties:Bool = false;

	public function add(object:Sprite):Bool {
		if (members.indexOf(object) > -1)
			return false;

		members.push(object);
		@:bypassAccessor object.memberOf = this;
		return true;
	}

	public function remove(object:Sprite):Bool {
		var index = members.indexOf(object);

		if (index > -1) {
			members.splice(index, 1);
			@:bypassAccessor object.memberOf = null;
			return true;
		}
		return false;
	}

	public function insert(index:Int, object:Sprite):Bool {
		if (members.indexOf(object) > -1)
			return false;

		members.insert(index, object);
		@:bypassAccessor object.memberOf = this;
		return true;
	}

	override public function update(elapsed:Float):Void {
		for (object in members) {
			if (!object.frozen)
				object.update(elapsed);
		}
	}

	override public function queueDraw():Void {
		if (!visible || tint.a <= 0.0) return;

		final lastCameras = Camera.currentCameras;
		Camera.currentCameras = (cameras != null && cameras.length > 0) ? cameras : lastCameras;

		if (skipProperties || hasDefaultProps()) {
			for (object in members) {
				if (object.visible && object.tint.a > 0.0)
					object.queueDraw();
			}
			Camera.currentCameras = lastCameras;
			return;
		}

		final queueTrig = _queueTrig;
		if (queueTrig)
			updateTrigValues();

		if (memberOf != null && !memberOf.skipProperties)
			calcRenderOffset(memberOf.scale, memberOf._sinMult, memberOf._cosMult);
		else 
			calcRenderOffset(null, null, null);
		for (object in members) {
			if (!object.visible || object.tint.a <= 0.0) continue;

			final ogParaX = object.parallax.x;
			final ogParaY = object.parallax.y;
			final ogParaZoom = object.zoomFactor;
			cacheTransform.set(null, object.position, object.renderOffset, object.scale, 0, 1, object.tint);
			
			object.parallax *= parallax;
			object.zoomFactor *= zoomFactor;

			object.position *= scale;
			if (rotation != 0)
				object.position.rotate(_sinMult, _cosMult);
			object.position.x += position.x * positionFactor.x + renderOffset.x;
			object.position.y += position.y * positionFactor.y + renderOffset.y;
			object.scale *= scale;

			@:bypassAccessor object.rotation += rotation;
			object._queueTrig = object._queueTrig || queueTrig;

			object.tint *= tint;

			object.queueDraw();

			object.parallax.setFull(ogParaX, ogParaY);
			object.zoomFactor = ogParaZoom;
            object.position.copyFrom(cacheTransform.position);
            object.scale.copyFrom(cacheTransform.scale);
            object.tint.copyFrom(cacheTransform.tint);
			@:bypassAccessor object.rotation -= rotation;
		}

		Camera.currentCameras = lastCameras;
	}

	override function calcRenderOffset(?parentScale:Vector2, ?parentSin:Float, ?parentCos:Float):Void {
		renderOffset.copyFrom(positionOffset);
		if (parentScale != null)
			renderOffset.multiplyEq(parentScale);
		if (parentSin != null && parentCos != null)
			renderOffset.rotate(parentSin, parentCos);
	}

	function hasDefaultProps():Bool {
		return (position.x == 0.0 && position.y == 0.0)
			&& (positionOffset.x == 0.0 && positionOffset.y == 0.0)
			&& (scale.x == 1.0 && scale.y == 1.0)
			&& rotation == 0.0
			&& (tint.r == 1.0 && tint.g == 1.0 && tint.b == 1.0 && tint.a == 1.0)
			&& (parallax.x == 1.0 && parallax.y == 1.0)
			&& (zoomFactor.x == 1.0 && zoomFactor.y == 1.0);
	}

	override function clone<T:Sprite>():T {
		Sys.println("Group.clone() is currently unimplemented.");
		return cast new Group();
	}

	override function destroy():Void {
		for (object in members)
			object.destroy();
		members.splice(0, members.length);
	}
}
