package blueprint.graphics;

import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;

import ResourceHelper.InternalResource;

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

@:allow(blueprint.objects.AnimatedSprite)
class SpriteFrameSet {
	public static var enableKeepOnce:Bool = false;
    static var frameCache:Map<String, SpriteFrameSet> = [];
    
	public var keepIfUnused:Bool = false;
	public var keepOnce:Bool = false;
	public var useCount:Int = 0;
    public var path:String;
    var _cacheKey:Null<String>;

    public var frames:Array<SpriteFrame> = [];
    public var textures:Array<Texture> = [];
    public var loaded:Bool = false;

    public function new(?filePath:String) {
		keepOnce = enableKeepOnce;

        if (filePath != null)
            loadFromFile(filePath);
    }

    public function loadFromFile(filePath:String) {
        path = filePath;

        // TODO: Add `reinterpret_cast` and support embedded frame data.
        final res:InternalResource = ResourceHelper.getResource(path);
		final fullPath = FileSystem.absolutePath(path);
		final fileExists = FileSystem.exists(fullPath);
        if (!FileSystem.exists(fullPath)) {
			Sys.println('Failed to load "$filePath": File nonexistant.');
			return this;
		}

        switch (Path.extension(fullPath)) {
			case "xml":
				var xml:Xml;
				try {
					xml = Xml.parse(sys.io.File.getContent(fullPath));
				} catch (e) {
					Sys.println('Failed to load "$filePath": $e');
					return this;
				}

				for (atlas in xml.elementsNamed("TextureAtlas")) {
					var tex = Texture.getCachedTex(Path.directory(filePath) + "/" + atlas.get("imagePath"));
                    textures.push(tex);
					++tex.useCount;
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

        loaded = true;
        return this;
    }

    public function destroy() {
        frames = null;
        for (texture in textures)
            --texture.useCount;
        textures = null;

		if (_cacheKey != null)
			frameCache.remove(_cacheKey);
	}

	public static function getCachedFrames(filePath:String) {
		if (!frameCache.exists(filePath)) {
			var frames = new SpriteFrameSet(filePath);
			if (!frames.loaded)
				frames.destroy();
			else 
                frames._cacheKey = filePath;
            frameCache.set(filePath, frames);
		}

		frameCache[filePath].keepOnce = enableKeepOnce || frameCache[filePath].keepOnce;
		return frameCache[filePath];
	}

    public static function clearCache(?force:Bool = false) {
		for (key in frameCache.keys()) {
			final set = frameCache[key];
			if (force || (!set.keepOnce && !set.keepIfUnused && set.useCount <= 0))
				set.destroy();
			set.keepOnce = false;
		}
	}
}