package blueprint.tweening;

import math.MathExtras;

@:structInit class PropTweenData {
    public var target:Dynamic;
    public var prop:String;
    public var start:Dynamic;
    public var end:Dynamic;
}

class PropertyTween extends BaseTween {
    var target:Dynamic;
    var tweenData:Array<PropTweenData> = [];
    public var properties(default, set):Dynamic = null;

    public function new(target:Dynamic, properties:Dynamic, duration:Float, easeFunc:Float->Float) {
        super(duration, easeFunc);
        this.target = target;
        this.properties = properties;
    }

    override function update(elapsed:Float) {
        if (tweenData.length < 1) {
            percent = reverse ? 0.0 : 1.0;
            return;
        }

        updatePercent(elapsed);
        if (!complete && curTime >= delay) {
            for (prop in tweenData)
                Reflect.setProperty(prop.target, prop.prop, MathExtras.lerpValue(prop.start, prop.end, percent));
        }
    }

    function tryData(data:PropTweenData) {
        var field = data.prop;
        var dotIndex = field.indexOf(".");
        while (dotIndex > -1) {
            data.target = Reflect.getProperty(data.target, data.prop.substring(0, dotIndex));
            if (data.target == null)
                break;
            data.prop = data.prop.substring(dotIndex + 1, data.prop.length);
            dotIndex = data.prop.indexOf(".");
        }
        
        if (data.target == null) {
            Sys.println('Unable to create data for "$field": The target was null.');
            return false;
        }
        data.start = Reflect.getProperty(data.target, data.prop);
        if (data.start == null) {
            Sys.println('Unable to create data for "$field": The starting value was null.');
            return false;
        }

        var startType = (data.start is Int) ? Type.ValueType.TFloat : Type.typeof(data.start);
        var endType = (data.end is Int) ? Type.ValueType.TFloat : Type.typeof(data.end);
        if (!startType.equals(endType)) {
            Sys.println('Unable to create data for "$field": The inputed type ($endType) does not match the target type. ($startType)');
            return false;
        } else if (!MathExtras.canLerp(data.start)) {
            Sys.println('Unable to create data for "$field": The type is unabled to be lerped. Please input a Float, Vector2, Vector3, or Vector4 instance.');
            return false;
        }

        return true;
    }

    function set_properties(newProps:Dynamic) {
        if (!Reflect.isObject(newProps)) {
            Sys.println('Unable to create tween data: The inputted properties is not a {key: value} type.');
            return properties;
        }
        tweenData.splice(0, tweenData.length);
        properties = newProps;

        for (field in Reflect.fields(properties)) {
            var data:PropTweenData = {
                target: target,
                prop: field,
                start: null,
                end: Reflect.field(properties, field)
            };

            if (tryData(data))
                tweenData.push(data);
        }
        return properties;
    }
}