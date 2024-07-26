package blueprint.tweening;

class BaseTween {
    public var enabled:Bool = true;
    public var deleteWhenDone:Bool = true;
    public var nextTween(default, set):BaseTween;

    public var percent:Float = 0.0;
    public var duration:Float = 1.0;
    public var curTime:Float = 0.0;
    public var delay:Float = 0.0;
    public var easeFunc:Float->Float;
    public var reverse:Bool = false;
    public var complete(get, never):Bool;

    public var finished:Signal<BaseTween->Void>;

    public function new(duration:Float, easeFunc:Float->Float) {
        this.duration = duration;
        this.easeFunc = easeFunc;
        finished = new Signal();
        curTweens.push(this);
    }

    public function finish() {
        enabled = false;
        if (nextTween != null)
            nextTween.start(0.0);
        curTime = 0.0;
        finished.emit(this);
    }

    public function update(elapsed:Float) {
        updatePercent(elapsed);
    }
    public function updatePercent(elapsed:Float) {
        curTime = Math.min(curTime + elapsed, duration + delay);
        percent = Math.max(curTime - delay, 0) / duration;
        if (reverse)
            percent = 1 - percent;
        percent = easeFunc(percent);
    }

    public function start(?time:Float = 0.0) {
        curTime = time;
        updatePercent(0.0);
        enabled = true;
    }

    public function reset() {
        curTime = 0.0;
        percent = reverse ? 1.0 : 0.0;
    }

    function get_complete() {
        return curTime - delay >= duration;
    }

    function set_nextTween(twn:BaseTween) {
        twn.enabled = false;
        twn.reset();
        return nextTween = twn;
    }



    public static var curTweens:Array<BaseTween> = [];

    public static function updateTweens(elapsed:Float) {
        var i:Int = 0;
        while (i < curTweens.length) {
            final twn = curTweens[i];
            if (!twn.enabled) {
                i++;
                continue;
            }

            twn.update(elapsed);
            if (twn.complete) {
                twn.finish();
                if (twn.deleteWhenDone) {
                    curTweens.remove(twn);
                    continue;
                }
            }
            i++;
        }
    }
}