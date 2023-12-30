package blueprint.objects;

import bindings.Glad;

import math.Vector2;
import math.MathExtras;

import blueprint.objects.Sprite;

class Group extends Sprite {
	public var members:Array<Sprite> = [];
	public var skipProperties:Bool = false;

	public function add(object:Sprite):Bool {
		if (members.indexOf(object) > -1)
			return false;

		members.push(object);
		return true;
	}

	public function remove(object:Sprite):Bool {
		var index = members.indexOf(object);

		if (index > -1) {
			members.splice(index, 1);
			return true;
		}
		return false;
	}

	public function insert(index:Int, object:Sprite):Bool {
		if (members.indexOf(object) > -1)
			return false;

		members.insert(index, object);
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

			object.position *= _cosMult;
			object.position.x += ogY * -_sinMult;
			object.position.y += ogX * _sinMult;
			object.position *= scale;
			object.position += position;

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
