package;

import haxe.Constraints.Function;

class Signal<T> {
    public var funcsToCall:Array<Function> = [];

    public function new() {}

    public function emit(...params:Dynamic) {
        var toRemove:Array<Int> = [];
        var params:Array<Dynamic> = params.toArray();

        for (i => func in funcsToCall) {
            if (func == null) {
                toRemove.push(i);
                continue;
            }

            Reflect.callMethod(null, func, params);
        }

        for (remove in toRemove)
            funcsToCall.splice(remove, 1);
    }

    public function add(func:Function, ?allowDups:Bool = false) {
        if (funcsToCall.contains(func) && !allowDups)
            return;

        funcsToCall.push(func);
    }

    public function remove(func:Function) {
        funcsToCall.remove(func);
    }
}