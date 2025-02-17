package blueprint.objects;

import math.Vector2;
import haxe.io.Path;
import sys.FileSystem;

import blueprint.graphics.Texture;

using StringTools;

@:structInit class SpriteFrame {
	public var name:String;
	public var texture:Texture;

	public var sourceX:Float;
	public var sourceY:Float;
	public var sourceWidth:Float;
	public var sourceHeight:Float;

	public var offsetX:Float;
	public var offsetY:Float;
}

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
	static var dataCache:Map<String, Array<SpriteFrame>> = [];

	public var animWidth:Float;
	public var animHeight:Float;
	public var curAnim:String = "";
	public var animFinished:Bool = false;
	var frames:Array<SpriteFrame>;
	var animData:Map<String, AnimationData> = [];
	var animTime:Float = 0.0;
	var curFrame:Int = 0;

	public var finished:Signal<String->Void>;

	public function new(?x:Float = 0, ?y:Float = 0, ?filePath:String) {
		super(x, y);
		animWidth = backupFrame.sourceWidth;
		animHeight = backupFrame.sourceHeight;
		finished = new Signal();

		if (filePath != null)
			loadFrames(filePath);
	}

	public function loadFrames(filePath:String, ?appendFrames:Bool = false) {
		if (!dataCache.exists(filePath))
			dataCache.set(filePath, loadFromFile(filePath));

		frames = (frames != null && appendFrames) ? frames.concat(dataCache[filePath]) : dataCache[filePath];
		return dataCache[filePath];
	}

	public function addPrefixAnim(animName:String, prefix:String, ?fps:Float = 24, ?loop:Bool = false, ?indices:Array<Int>) {
		final anim:AnimationData = {fps: fps, length: 1 / fps, loop: loop, indexes: [], width: 0, height: 0};

		for (i => frame in frames) {
			if (!frame.name.startsWith(prefix)) continue;

			anim.indexes.push(i);

			anim.width = Math.max(anim.width, frame.sourceWidth);
			anim.height = Math.max(anim.height, frame.sourceHeight);
		}

		if (indices != null && indices.length > 0)
			anim.indexes = [for (i in indices) anim.indexes[i]];

		anim.length *= anim.indexes.length - 0.01;
		animData.set(animName, anim);
	}

	public function playAnim(newAnim:String, ?forceRestart:Bool = true) {
		animTime = animTime * bindings.CppHelpers.boolToInt(!(curAnim != newAnim || animFinished || forceRestart));
		curFrame = 0;
		curAnim = newAnim;
		animFinished = false;

		if (animData.exists(curAnim)) {
			curFrame = animData[curAnim].indexes[0];
			animWidth = animData[curAnim].width;
			animHeight = animData[curAnim].height;
		}
	}

	override function queueDraw() {
		if (frames == null || frames.length <= 0) {
			texture = backupFrame.texture;
			super.queueDraw();
			return;
		}

		if (animData.exists(curAnim)) {
			final data = animData[curAnim];
			final alreadyFinished = animFinished;

			animTime = (data.loop) ? (animTime + Game.elapsed) % data.length : Math.min(animTime + Game.elapsed, data.length);
			animFinished = (animTime >= data.length && !data.loop);
			curFrame = data.indexes[Math.floor(animTime * data.fps)];
			if (animFinished && !alreadyFinished)
				finished.emit(curAnim);
		}
		
		texture = frames[curFrame].texture;
		super.queueDraw();
	}

	override function prepareShaderVars() {
		final frame = (frames == null || frames.length <= 0) ? backupFrame : frames[curFrame];
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

	override function get_sourceWidth():Float {
		final frame = (frames == null || frames.length <= 0) ? backupFrame : frames[curFrame];
		return (sourceRect.width <= 0) ? frame.sourceWidth : sourceRect.width;
	}

	override function get_sourceHeight():Float {
		final frame = (frames == null || frames.length <= 0) ? backupFrame : frames[curFrame];
		return (sourceRect.height <= 0) ? frame.sourceHeight : sourceRect.height;
	}

	static function loadFromFile(filePath:String) {
		final daPath = FileSystem.absolutePath(filePath);
		if (!FileSystem.exists(daPath)) {
			Sys.println('Failed to load "$filePath": File nonexistant.');
			return [];
		}

		var frames:Array<SpriteFrame> = [];
		switch (Path.extension(daPath)) {
			case "xml":
				var xml:Xml;
				try {
					xml = Xml.parse(sys.io.File.getContent(daPath));
				} catch (e) {
					Sys.println('Failed to load "$filePath": $e');
					return [];
				}

				for (atlas in xml.elementsNamed("TextureAtlas")) {
					var tex = Texture.getCachedTex(Path.directory(filePath) + "/" + atlas.get("imagePath"));
					for (node in atlas.elementsNamed("SubTexture")) {
						frames.push({
							name: node.get("name"),
							texture: tex,
							sourceX: Std.parseFloat(node.get("x")),
							sourceY: Std.parseFloat(node.get("y")),
							sourceWidth: Std.parseFloat(node.get("width")),
							sourceHeight: Std.parseFloat(node.get("height")),
							offsetX: (node.exists("frameX")) ? -Std.parseFloat(node.get("frameX")) : 0,
							offsetY: (node.exists("frameY")) ? -Std.parseFloat(node.get("frameY")) : 0,
						});
					}
				}
		}

		return frames;
	}

	public static function clearCache() {
		dataCache.clear();
	}
}