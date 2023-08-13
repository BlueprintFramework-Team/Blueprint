package blueprint.objects;

import bindings.Glad;
import math.Vector2;
import math.MathExtras;
import blueprint.objects.Sprite;

class Group extends Sprite {
    public var members:Array<Sprite> = [];
    public var skipProperties:Bool = false;

    public function add(object:Sprite):Bool {
        if (members.indexOf(object) > -1) return false;

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
        if (members.indexOf(object) > -1) return false;

        members.insert(index, object);
        return true;
    }

    override public function update(elapsed:Float) {
        super.update(elapsed);

        for (object in members)
            object.update(elapsed);
    }

    override public function draw() {
        if (skipProperties) {
            for (object in members)
                object.draw();
            return;
        }

        var sinMult = Math.sin(MathExtras.toRad(rotation));
        var cosMult = Math.sin(MathExtras.toRad(rotation));
        var rotPosition:Vector2 = cast [
            position.x * cosMult + position.y * -sinMult,
            position.x * sinMult + position.y * cosMult
        ];
        rotPosition *= scale;

        for (object in members) {
            object.position += rotPosition;
            object.scale *= scale;
            object.rotation += rotation;
            object.tint *= tint;

            object.draw();

            object.position -= rotPosition;
            object.scale /= scale;
            object.rotation -= rotation;
            object.tint /= tint;
        }
    }
}