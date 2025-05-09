package blueprint.graphics;

import ResourceHelper.InternalResource;
import haxe.io.Path;
import cpp.RawPointer;
import sys.FileSystem;

import bindings.Glad;
import bindings.texture.PngHelper;
import bindings.texture.StbImage;

import blueprint.objects.Sprite;

class Texture {
	public static var enableKeepOnce:Bool = false;
	static var imageCache:Map<String, Texture> = [];

	public var ID:cpp.UInt32;

	public var keepIfUnused:Bool = false;
	public var keepOnce:Bool = false;
	public var useCount:Int = 0;
	public var path:String;
	var _cacheKey:Null<String>;

	public var width:Int;
	public var height:Int;
	public var numChannels:Int;
	public var loaded:Bool = false;

	public function new(?filePath:String) {
		Glad.genTextures(1, RawPointer.addressOf(ID));
		Glad.bindTexture(Glad.TEXTURE_2D, ID);

		if (filePath != null)
			loadFromFile(filePath);
	}

	public function loadFromFile(filePath:String) {
		path = filePath;
		Glad.bindTexture(Glad.TEXTURE_2D, ID);

		var res:InternalResource = ResourceHelper.getResource(path);
		var fullPath = FileSystem.absolutePath(path);
		var fileExists = FileSystem.exists(fullPath);
		if (!fileExists && res.dataLength <= 0) {
			Sys.println('Failed to load "$path": File nonexistant.');
			return this;
		}

		switch (Path.extension(path)) {
			case "png":
				loaded = (!fileExists ? PngHelper.loadPngFromMemory(res.data, cast res.dataLength, RawPointer.addressOf(width), RawPointer.addressOf(height)) : PngHelper.loadPng(fullPath, RawPointer.addressOf(width), RawPointer.addressOf(height))) == 1;
			default:
				var data:RawPointer<cpp.UInt8> = !fileExists ? StbImage.loadFromMemory(res.data, res.dataLength, RawPointer.addressOf(width), RawPointer.addressOf(height), RawPointer.addressOf(numChannels), 0) : StbImage.load(fullPath, RawPointer.addressOf(width), RawPointer.addressOf(height), RawPointer.addressOf(numChannels), 0);
	
				var imageFormat = (numChannels == 4) ? Glad.RGBA : Glad.RGB;
		
				if (data[0] != 0) {
					Glad.texImage2D(Glad.TEXTURE_2D, 0, imageFormat, width, height, 0, imageFormat, Glad.UNSIGNED_BYTE, data);
				} else {
					Sys.println('Failed to load "$path": ${StbImage.failureReason()}');
					return this;
				}
		
				StbImage.freeImage(data);
				loaded = true;
		}
		return this;
	}

	@:deprecated('"loadFromImage" is now deprecated! Please use "loadFromFile" instead.')
	public function loadFromImage(filePath:String) {return loadFromFile(filePath);}

	public function destroy() {
		Glad.deleteTextures(1, RawPointer.addressOf(ID));

		if (_cacheKey != null)
			imageCache.remove(_cacheKey);
	}

	public static function getCachedTex(filePath:String) {
		if (!imageCache.exists(filePath)) {
			var tex = new Texture(filePath);
			if (!tex.loaded) {
				tex.destroy();
				tex = Sprite.defaultTexture;
			} else 
				tex._cacheKey = filePath;
			imageCache.set(filePath, tex);
		}
		
		imageCache[filePath].keepOnce = enableKeepOnce || imageCache[filePath].keepOnce;
		return imageCache[filePath];
	}

	public static function clearCache(?force:Bool = false) {
		for (key in imageCache.keys()) {
			final texture = imageCache[key];
			if (force) {
				texture.destroy();
				continue;
			}

			if (texture == Sprite.defaultTexture)
				imageCache.remove(key);
			else if (!texture.keepOnce && !texture.keepIfUnused && texture.useCount <= 0)
				texture.destroy();
			texture.keepOnce = false;
		}
	}

	@:deprecated('"getImageTex" is now deprecated! Please use "getCachedTex" instead.')
	public static function getImageTex(filePath:String) {return getCachedTex(filePath);}
}
