package blueprint.objects;

import math.Vector2;
import haxe.io.Path;
import sys.FileSystem;

import blueprint.graphics.Texture;
import blueprint.graphics.SpriteFrames;

using StringTools;

@:structInit class AnimationData {
	public var fps:Float;
	public var length:Float;
	public var loop:Bool;
	public var indexes:Array<Int>;
	public var width:Float;
	public var height:Float;
}

class AnimatedSprite extends Sprite {
	public static var backupFrame:SpriteFrame;

	public var animWidth:Float;
	public var animHeight:Float;
	public var curAnim:String = "";
	public var animFinished:Bool = false;
	var frameSets:Array<SpriteFrameSet> = [];
	var frame:SpriteFrame;
	var animData:Map<String, AnimationData> = [];
	var animTime:Float = 0.0;
	var curFrame(default, set):Int = 0;

	public var finished:Signal<String->Void>;

	public function new(?x:Float = 0, ?y:Float = 0, ?filePath:String) {
		super(x, y);
		frame = backupFrame;
		animWidth = backupFrame.sourceWidth;
		animHeight = backupFrame.sourceHeight;
		texture = backupFrame.texture;
		finished = new Signal();

		if (filePath != null)
			loadFrames(filePath);
	}

	public function pushFrameSet(set:SpriteFrameSet) {
		frameSets.push(set);
		++set.useCount;
	}
	
	public function removeFrameSet(set:SpriteFrameSet) {
		if (frameSets.remove(set))
			--set.useCount;
	}

	public function getFrame(idx:Int) {
		var offset = 0;
		
		for (set in frameSets) {
			if (idx - offset < set.frames.length)
				return set.frames[idx - offset];
			offset += set.frames.length;
		}

		return backupFrame;
	}

	public function loadFrames(filePath:String, ?appendFrames:Bool = false) {
		if (!appendFrames) {
			for (set in frameSets)
				--set.useCount;
			frameSets.splice(0, frameSets.length);
		}
		
		final set = SpriteFrameSet.getCachedFrames(filePath);
		pushFrameSet(set);
		return set;
	}

	public function loadTilesFromPath(filePath:String, width:Float, height:Float, ?appendFrames:Bool = false) {
		return loadTilesFromTex(Texture.getCachedTex(filePath), width, height, appendFrames);
	}

	public function loadTilesFromTex(tex:Texture, width:Float, height:Float, ?appendFrames:Bool = false) {
		if (!appendFrames) {
			for (set in frameSets)
				--set.useCount;
			frameSets.splice(0, frameSets.length);
		}

		final set = SpriteFrameSet.getTilesFromTex(tex, width, height);
		pushFrameSet(set);
		return set;
	}

	public function addBasicAnim(animName:String, indexes:Array<Int>, ?fps:Float = 24, ?loop:Bool = false) {
		final anim:AnimationData = {fps: fps, length: (1 / fps) * (indexes.length - 0.001), loop: loop, indexes: indexes, width: 0, height: 0};

		for (idx in indexes) {
			final frame = getFrame(idx);
			if (frame != backupFrame) {
				anim.width = Math.max(anim.width, frame.sourceWidth);
				anim.height = Math.max(anim.height, frame.sourceHeight);
			}
		}
		
		animData.set(animName, anim);
	}

	public function addPrefixAnim(animName:String, prefix:String, ?fps:Float = 24, ?loop:Bool = false, ?indices:Array<Int>) {
		final anim:AnimationData = {fps: fps, length: 1 / fps, loop: loop, indexes: [], width: 0, height: 0};

		var offset = 0;
		for (set in frameSets) {
			for (i => frame in set.frames) {
				if (!frame.name.startsWith(prefix)) continue;
	
				anim.indexes.push(i + offset);
	
				anim.width = Math.max(anim.width, frame.sourceWidth);
				anim.height = Math.max(anim.height, frame.sourceHeight);
			}
			offset += set.frames.length;
		}

		if (indices != null && indices.length > 0)
			anim.indexes = [for (i in indices) anim.indexes[i]];

		anim.length *= anim.indexes.length - 0.001;
		animData.set(animName, anim);
	}

	public function playAnim(newAnim:String, ?forceRestart:Bool = true) {
		animTime = animTime * bindings.CppHelpers.boolToInt(!(curAnim != newAnim || animFinished || forceRestart));
		curAnim = newAnim;
		animFinished = false;

		if (animData.exists(curAnim)) {
			curFrame = animData[curAnim].indexes[0];
			animWidth = animData[curAnim].width;
			animHeight = animData[curAnim].height;
		} else
			curFrame = 0;
	}

	override function queueDraw() {
		if (!visible || tint.a <= 0.0) return;

		if (frameSets != null && frameSets.length > 0 && animData.exists(curAnim)) {
			final data = animData[curAnim];
			final alreadyFinished = animFinished;

			animTime = (data.loop) ? (animTime + Game.elapsed) % data.length : Math.min(animTime + Game.elapsed, data.length);
			animFinished = (animTime >= data.length && !data.loop);
			curFrame = data.indexes[Math.floor(animTime * data.fps)];
			if (animFinished && !alreadyFinished)
				finished.emit(curAnim);
		}
		
		super.queueDraw();
	}

	override function prepareShaderVars() {
		final uMult = bindings.CppHelpers.boolToInt(flipX);
		final vMult = bindings.CppHelpers.boolToInt(flipY);

		final sourceWidth = sourceWidth; // so im not constantly calling the setters.
		final sourceHeight = sourceHeight;

		shader.transform.reset(1.0);
		shader.transform.scale(Sprite._refVec3.set(sourceWidth, sourceHeight, 1));
		shader.transform.translate(Sprite._refVec3.set(
			dynamicOffset.x + frame.offsetX,
			dynamicOffset.y + frame.offsetY,
			0
		));
		shader.transform.scale(Sprite._refVec3.set(scale.x, scale.y, 1));
		if (_sinMult != 0)
			shader.transform.rotate(_sinMult, _cosMult, Sprite._refVec3.set(0, 0, 1));
		shader.transform.translate(Sprite._refVec3.set(
			position.x + renderOffset.x,
			position.y + renderOffset.y,
			0
		));
		shader.setUniform("transform", shader.transform);

		shader.setUniform("tint", tint);
		bindings.Glad.uniform4f(bindings.Glad.getUniformLocation(shader.ID, "sourceRect"),
			((sourceRect.x + frame.sourceX) + sourceWidth * uMult) / texture.width,
			((sourceRect.y + frame.sourceY) + sourceHeight * vMult) / texture.height,
			((sourceRect.x + frame.sourceX) + sourceWidth * (1 - uMult)) / texture.width,
			((sourceRect.y + frame.sourceY) + sourceHeight * (1 - vMult)) / texture.height
		);
	}

	override function calcRenderOffset(?parentScale:Vector2, ?parentSin:Float, ?parentCos:Float) {
		renderOffset.copyFrom(positionOffset);
		if (parentScale != null)
			renderOffset.multiplyEq(parentScale);
		renderOffset.x += width * 0.5 - ((animWidth - sourceRect.x) * scale.x) * anchor.x;
		renderOffset.y += height * 0.5 - ((animHeight - sourceRect.y) * scale.y) * anchor.y;
		if (parentSin != null && parentCos != null)
			renderOffset.rotate(parentSin, parentCos);
	}

	override function offScreen():Bool {
		final dynamX:Float = dynamicOffset.x + frame.offsetX;
		final dynamY:Float = dynamicOffset.y + frame.offsetY;
		final offsetX:Float = (dynamX * scale.x * _cosMult - dynamY * scale.y * _sinMult) + renderOffset.x;
		final offsetY:Float = (dynamX * scale.x * _sinMult + dynamY * scale.y * _cosMult) + renderOffset.y;
		
		var width:Float = width;
		var height:Float = height;

		// Do not apply anchors here. position + offset already takes care of that.
		final left:Float = position.x + offsetX - width * 0.5;
		final right:Float = position.x + offsetX + width * 0.5;
		final top:Float = position.y + offsetY - height * 0.5;
		final bottom:Float = position.y + offsetY + height * 0.5;

		final offScreenX:Bool = (Math.min(left, right) > Game.window.width) || (Math.max(left, right) < 0);
		final offScreenY:Bool = (Math.min(top, bottom) > Game.window.height) || (Math.max(top, bottom) < 0);

		return offScreenX || offScreenY;
	}

	override function clone<T:Sprite>():T {
		var spr = new AnimatedSprite();

		_copyOver(spr);

		for (set in frameSets)
			spr.pushFrameSet(set);
		for (anim in animData.keys())
			spr.animData.set(anim, animData[anim]);

		return cast spr;
	}

	override function destroy() {
		for (set in frameSets)
			--set.useCount;
		frameSets.splice(0, frameSets.length);
		super.destroy();
	}

	function set_curFrame(newFrame:Int) {
		if (curFrame == newFrame && frame != backupFrame)
			return curFrame;

		frame = getFrame(newFrame);
		texture = frame.texture;
		return curFrame = newFrame;
	}

	override function get_sourceWidth():Float {
		return (sourceRect.width <= 0) ? frame.sourceWidth : sourceRect.width;
	}

	override function get_sourceHeight():Float {
		return (sourceRect.height <= 0) ? frame.sourceHeight : sourceRect.height;
	}
}