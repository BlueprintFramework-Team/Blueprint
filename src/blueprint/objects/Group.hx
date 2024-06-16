package blueprint.objects;

import bindings.Glad;

import math.Vector2;
import math.MathExtras;

import blueprint.objects.Sprite;

class Group extends Sprite {
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
			return true;
		}
		@:bypassAccessor object.memberOf = null;
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
		for (object in members)
			object.update(elapsed);
	}

	override public function draw():Void {
		if (skipProperties || hasDefaultProps()) {
			for (object in members)
				object.draw();
			return;
		}

		final queueTrig = _queueTrig;
		if (queueTrig)
			updateTrigValues();

		for (object in members) {
			final ogX = object.position.x;
			final ogY = object.position.y;
			final ogScaleX = object.scale.x;
			final ogScaleY = object.scale.y;
			final width = object.width;
			final height = object.height;

			object.position *= _cosMult;
			// man i need to find a better way to fix anchoring with rotated groups.
			// this is just..... duct tape glore.
			object.position.x += ogY * -_sinMult + width * (object.anchor.x - 0.5);
			object.position.y += ogX * _sinMult + height * (object.anchor.y - 0.5);
			object.position.x += (width * (0.5 - object.anchor.x) * _cosMult - height * (0.5 - object.anchor.y) * _sinMult);
			object.position.y += (width * (0.5 - object.anchor.x) * _sinMult + height * (0.5 - object.anchor.y) * _cosMult);
			object.position *= scale;
			object.position += position * positionFactor;

			object.scale *= scale;

			@:bypassAccessor object.rotation += rotation;
			object._queueTrig = object._queueTrig || queueTrig;

			object.tint *= tint;

			object.draw();

			object.position.set(ogX, ogY);
			object.scale.set(ogScaleX, ogScaleY);
			@:bypassAccessor object.rotation -= rotation;
			object.tint /= tint;
		}
	}

	function hasDefaultProps():Bool {
		return (position.x == 0.0 && position.y == 0.0)
			&& (scale.x == 1.0 && scale.y == 1.0)
			&& (tint.r == 1.0 && tint.g == 1.0 && tint.b == 1.0 && tint.a == 1.0);
	}

	override function destroy() {
		for (object in members)
			object.destroy();
		members.splice(0, members.length);
	}
}
