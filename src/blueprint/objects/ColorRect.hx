package blueprint.objects;

import math.Vector2;
import math.Vector4.Color;
import blueprint.graphics.Texture;
import bindings.Glad;

class ColorRect extends Sprite {
    public static var pixel:Texture;
    public var color(get, set):Color; // a wrapper for tint. fits better with the context of ColorRect.
    public var size:Vector2;

    public function new(x:Float, y:Float, width:Float, height:Float) {
        super(x, y);
        texture = pixel;
        size = new Vector2(width, height);
    }

    // merely to simplfy
    override function prepareTransform() {
        transform.reset(1.0);
		transform.scale(Sprite._refVec3.set(size.x, size.y, 1));
		transform.translate(Sprite._refVec3.set(dynamicOffset.x, dynamicOffset.y, 0));
		transform.scale(Sprite._refVec3.set(scale.x, scale.y, 1));
		if (_sinMult != 0)
			transform.rotate(_sinMult, _cosMult, Sprite._refVec3.set(0, 0, 1));
		transform.translate(Sprite._refVec3.set(
			position.x + renderOffset.x,
			position.y + renderOffset.y,
			0
		));
    }

	override function prepareShaderVars():Void {
		shader.setUniform("transform", transform);
		shader.setUniform("tint", tint);
		Glad.uniform4f(Glad.getUniformLocation(shader.ID, "sourceRect"), 0, 0, 1, 1);
	}

    inline function get_color():Color {
        return tint;
    }

    inline function set_color(newColor:Color):Color {
        return tint = newColor;
    }

    override function get_sourceWidth():Float {
        return size.x;
    }

    override function get_sourceHeight():Float {
        return size.y;
    }
}