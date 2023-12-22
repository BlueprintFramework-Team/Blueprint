package blueprint.objects;

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
	var frames:Array<SpriteFrame>;
	var animData:Map<String, AnimationData> = [];
	var animTime:Float = 0.0;
	var curFrame:Int = 0;

	public function new(?x:Float = 0, ?y:Float = 0, ?filePath:String) {
		super(x, y);
		animWidth = backupFrame.sourceWidth;
		animHeight = backupFrame.sourceHeight;

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

		anim.length *= anim.indexes.length - 1;
		animData.set(animName, anim);
	}

	public function playAnim(newAnim:String, ?forceRestart:Bool = true) {
		animTime = (curAnim != newAnim || forceRestart) ? 0.0 : animTime;
		curFrame = 0;
		curAnim = newAnim;

		if (animData.exists(curAnim)) {
			animWidth = animData[curAnim].width;
			animHeight = animData[curAnim].height;
		}
	}

	override function draw() {
		if (frames == null || frames.length <= 0) {
			texture = backupFrame.texture;
			super.draw();
			return;
		}

		if (animData.exists(curAnim)) {
			final data = animData[curAnim];

			animTime = (data.loop) ? (animTime + Game.elapsed) % data.length : Math.min(animTime + Game.elapsed, data.length);
			curFrame = data.indexes[Math.floor(animTime * data.fps)];
		}
		
		texture = frames[curFrame].texture;
		super.draw();
	}

	override function prepareShaderVars(anchorX:Float, anchorY:Float) {
		final frame = (frames == null || frames.length <= 0) ? backupFrame : frames[curFrame];

		shader.transform.reset(1.0);
		shader.transform.translate([(dynamicOffset.x + frame.offsetX) / sourceWidth, (dynamicOffset.y + frame.offsetY) / sourceHeight, 0]);
		if (rotation != 0)
			shader.transform.rotate(_sinMult, _cosMult, [0, 0, 1]);
		shader.transform.scale([width, height, 1]);
		shader.transform.translate([
			position.x + positionOffset.x + Math.abs(width) * 0.5 - (Math.abs((animWidth - sourceRect.x) * scale.x)) * anchor.x,
			position.y + positionOffset.y + Math.abs(height) * 0.5 - (Math.abs((animHeight - sourceRect.y) * scale.x)) * anchor.y,
			0
		]);
		shader.setUniform("transform", shader.transform);

		shader.setUniform("tint", tint);
		bindings.Glad.uniform4f(bindings.Glad.getUniformLocation(shader.ID, "sourceRect"),
			(sourceRect.x + frame.sourceX) / texture.width,
			(sourceRect.y + frame.sourceY) / texture.height,
			((sourceRect.x + frame.sourceX) + sourceWidth) / texture.width,
			((sourceRect.y + frame.sourceY) + sourceHeight) / texture.height
		);
	}

	override function get_sourceWidth():Float {
		final frame = (frames == null || frames.length <= 0) ? backupFrame : frames[curFrame];
		return ((sourceRect.width <= 0) ? frame.sourceWidth : sourceRect.width) - sourceRect.x;
	}

	override function get_sourceHeight():Float {
		final frame = (frames == null || frames.length <= 0) ? backupFrame : frames[curFrame];
		return ((sourceRect.height <= 0) ? frame.sourceHeight : sourceRect.height) - sourceRect.y;
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
					var tex = new Texture(Path.directory(daPath) + "/" + atlas.get("imagePath"));
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