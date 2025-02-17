package blueprint.objects;

import haxe.ds.Vector;
import math.MathExtras;
import math.Vector4;
import math.Vector2;

class QueuedDraw {
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

@:allow(blueprint.objects.Sprite)
@:allow(blueprint.Game)
class Camera {
	public static var currentCameras:Array<Camera> = [];
	public static var cacheTransform:QueuedDraw = new QueuedDraw();
	static var allCameras:Array<Camera> = [];

	public var keepOnSwitch:Bool = false;
	public var resetOnSwitch:Bool = true;

	public var targetPosition:Vector2;
	public var targetLerp:Float = 0.0;

	public var position:Vector2;
	public var zoom:Vector2;
	public var rotation(default, set):Float = 0.0;
	public var tint:Color;

	var _queueTrig:Bool = false;
	var _sinMult:Float = 0;
	var _cosMult:Float = 1;

	var queuedDraws:Array<QueuedDraw> = [];

	public function new() {
		targetPosition = new Vector2();
		position = new Vector2();
		zoom = new Vector2(1.0, 1.0);
		tint = new Color(1.0, 1.0, 1.0, 1.0);
		allCameras.push(this);
	}

	public function update(elapsed:Float) {
		if (_queueTrig)
			updateTrigValues();
		position.x = MathExtras.lerp(position.x, targetPosition.x, elapsed * targetLerp);
		position.y = MathExtras.lerp(position.y, targetPosition.y, elapsed * targetLerp);
	}

	public function queueDraw(target:Sprite, position:Vector2, offset:Vector2, scale:Vector2, sin:Float, cos:Float, tint:Color) {
		final queue:QueuedDraw = getQueue();
		queue.set(target, position, offset, scale, sin, cos, tint);
		queuedDraws.push(queue);
	}

	public function drawQueues() {
		for (queue in queuedDraws) {
			cacheTransform.set(null, queue.target.position, queue.target.renderOffset, queue.target.scale, queue.target._sinMult, queue.target._cosMult, queue.target.tint);

			queue.target.position.copyFrom(queue.position);
			queue.target.renderOffset.copyFrom(queue.offset);
			queue.target.scale.copyFrom(queue.scale);
			queue.target._sinMult = queue.sin;
			queue.target._cosMult = queue.cos;
			queue.target.tint.copyFrom(queue.tint);

			queue.target.draw();

			queue.target.position.copyFrom(cacheTransform.position);
			queue.target.renderOffset.copyFrom(cacheTransform.offset);
			queue.target.scale.copyFrom(cacheTransform.scale);
			queue.target._sinMult = cacheTransform.sin;
			queue.target._cosMult = cacheTransform.cos;
			queue.target.tint.copyFrom(cacheTransform.tint);
		}
		queuedDraws.splice(0, queuedDraws.length);
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