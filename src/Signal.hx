package;

import haxe.Constraints.Function;

class Signal<T:Function> {
    public var funcsToCall:Array<T> = [];

    public function new() {}

    public function emit(...params:Dynamic) {
        var toRemove:Array<T> = [];
        var params:Array<Dynamic> = params.toArray();

        for (func in funcsToCall) {
            if (func == null) {
                toRemove.push(func);
                continue;
            }

            Reflect.callMethod(null, func, params);
        }

        for (remove in toRemove)
            funcsToCall.remove(remove);
    }

    public function add(func:T, ?allowDups:Bool = false) {
        if (!funcsToCall.contains(func) || allowDups)
            funcsToCall.push(func);
    }

    public function remove(func:T) {
        funcsToCall.remove(func);
    }
}