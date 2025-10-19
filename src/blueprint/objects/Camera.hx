package blueprint.objects;

import bindings.Glad;
import math.MathExtras;
import math.Matrix4x4;
import math.Vector4;
import math.Vector2;

class TransformCache {
	public var target:Sprite;

	public var position:Vector2;
	public var offset:Vector2;
	public var scale:Vector2;
	public var sin:Float;
	public var cos:Float;
	public var tint:Color;

	public function new() {
		position = new Vector2();
		offset = new Vector2();
		scale = new Vector2(1.0, 1.0);
		sin = 0.0;
		cos = 1.0;
		tint = new Color(1.0, 1.0, 1.0, 1.0);
	}

	public function set(target:Sprite, position:Vector2, offset:Vector2, scale:Vector2, sin:Float, cos:Float, tint:Color) {
		this.target = target;
		this.position.copyFrom(position);
		this.offset.copyFrom(offset);
		this.scale.copyFrom(scale);
		this.sin = sin;
		this.cos = cos;
		this.tint.copyFrom(tint);
	}
	public function reset() {
		target = null;
		position.setFull(0, 0);
		scale.setFull(1, 1);
		sin = 0;
		cos = 1;
		tint.setFull(1, 1, 1, 1);
	}
}
class QueuedDraw {
	public var target:Sprite;

	public var transform:Matrix4x4;
	public var tint:Color;

	public function new() {
		transform = new Matrix4x4();
		tint = new Color(1.0, 1.0, 1.0, 1.0);
	}

	public function set(target:Sprite, transform:Matrix4x4, tint:Color) {
		this.target = target;
		this.transform.copyFrom(transform);
		this.tint.copyFrom(tint);
	}
	public function reset() {
		target = null;
		transform.reset(1);
		tint.setFull(1, 1, 1, 1);
	}
}

@:allow(blueprint.objects.Sprite)
@:allow(blueprint.Game)
class Camera {
	public static var currentCameras:Array<Camera> = [];
	public static var cacheTransform:TransformCache = new TransformCache();
	public static var cacheDraw:QueuedDraw = new QueuedDraw();
	static var allCameras:Array<Camera> = [];

	public var firstViewCapture:ViewCapture = null;
	public var lastViewCapture:ViewCapture = null;
	
	public var keepOnSwitch:Bool = false;
	public var resetOnSwitch:Bool = true;

	public var targetPosition:Vector2;
	public var targetLerp:Float = 0.0;

	public var visible:Bool = true;
	public var position:Vector2;
	public var zoom:Vector2;
	public var rotation(default, set):Float = 0.0;
	public var tint:Color;
	public var layer(default, set):Int;

	var _queueTrig:Bool = false;
	var _sinMult:Float = 0;
	var _cosMult:Float = 1;

	var queuedDraws:Array<QueuedDraw> = [];

	public function new() {
		targetPosition = new Vector2();
		position = new Vector2();
		zoom = new Vector2(1.0, 1.0);
		tint = new Color(1.0, 1.0, 1.0, 1.0);
		layer = 0;
	}

	public function update(elapsed:Float) {
		if (_queueTrig)
			updateTrigValues();
		position.x = MathExtras.lerp(position.x, targetPosition.x, elapsed * targetLerp);
		position.y = MathExtras.lerp(position.y, targetPosition.y, elapsed * targetLerp);
	}

	public function queueDraw(target:Sprite, transform:Matrix4x4, tint:Color) {
		final queue:QueuedDraw = getQueue();
		queue.set(target, transform, tint);
		queuedDraws.push(queue);
	}

	public function drawQueues() {
		if (!visible || tint.a <= 0.0) {
			queuedDraws.splice(0, queuedDraws.length);
			firstViewCapture = null;
			lastViewCapture = null;
			return;
		}
		
		if (firstViewCapture != null) {
			Glad.bindFramebuffer(Glad.FRAMEBUFFER, firstViewCapture.framebuffer);
			Glad.viewport(0, 0, Std.int(Game.window.viewSize.x), Std.int(Game.window.viewSize.y));
			Glad.clearColor(0.0, 0.0, 0.0, 0.0);
			Glad.clear(Glad.COLOR_BUFFER_BIT);
			firstViewCapture = null;
		}

		for (queue in queuedDraws) {
			cacheDraw.set(null, queue.target.transform, queue.target.tint);

			queue.target.transform.copyFrom(queue.transform);
			queue.target.tint.copyFrom(queue.tint);

			queue.target.draw();

			queue.target.transform.copyFrom(cacheDraw.transform);
			queue.target.tint.copyFrom(cacheDraw.tint);
		}
		queuedDraws.splice(0, queuedDraws.length);
		lastViewCapture = null;
	}

	function updateTrigValues() {
		final radians = MathExtras.toRad(rotation);
		_cosMult = Math.cos(radians);
		_sinMult = Math.sin(radians);
		_queueTrig = false;
	}

	public function reset() {
		targetLerp = 0.0;
		targetPosition.setFull(0.0, 0.0);
		position.setFull(0.0, 0.0);
		zoom.setFull(1.0, 1.0);
		tint.setFull(1.0, 1.0, 1.0, 1.0);
		@:bypassAccessor rotation = 0.0;
		_sinMult = 1.0;
		_cosMult = 0.0;
		_queueTrig = false;
	}

	function set_layer(newLayer:Int) {
		allCameras.remove(this);

		var idx = allCameras.length;
		while (idx > 0 && allCameras[idx - 1].layer > newLayer)
            --idx;
		allCameras.insert(idx, this);

		return layer = newLayer;
	}

	function set_rotation(newRot:Float) {
		_queueTrig = _queueTrig || (newRot != rotation);
		return rotation = newRot;
	}

	static function clearCameras() {
		var i = 0;
		while (i < allCameras.length) {
			if (!allCameras[i].keepOnSwitch) {
				allCameras.splice(i, 1);
				continue;
			} else if (allCameras[i].resetOnSwitch)
				allCameras[i].reset();
			++i;
		}
	}

	// Queue pooling which will hopefully lower allocation
	static var pool:Array<QueuedDraw> = [];
	static var queuesInPool:Int = 0;

	public static function getQueue() {
		if (queuesInPool > 0) {
			--queuesInPool;
			final queue = pool[queuesInPool];
			pool[queuesInPool] = null;
			return queue;
		}

		return new QueuedDraw();
	}
	public static function dropQueue(queue:QueuedDraw) {
		queue.reset();
		if (queuesInPool == pool.length)
			pool.push(queue);
		else 
			pool[queuesInPool] = queue;
		++queuesInPool;
	}
}