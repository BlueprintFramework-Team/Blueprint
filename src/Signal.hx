package;

import haxe.Constraints.Function;

class Signal<T:Function> {
    public var funcsToCall:Array<T> = [];

    public function new() {}

    public function emit(...params:Dynamic) {
        if (funcsToCall.length <= 0) return;

        var params:Array<Dynamic> = params.toArray();

        var i:Int = 0;
        while (i < funcsToCall.length) {
            if (funcsToCall[i] == null) {
                funcsToCall.splice(i, 1);
                continue;
            }

            Reflect.callMethod(null, funcsToCall[i], params);
            i++;
        }
    }

    public function add(func:T, ?allowDups:Bool = false) {
        if (!funcsToCall.contains(func) || allowDups)
            funcsToCall.push(func);
    }

    public function remove(func:T) {
        funcsToCall.remove(func);
    }
}