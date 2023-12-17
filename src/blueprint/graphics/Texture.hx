package blueprint.graphics;

import bindings.CppHelpers;
import cpp.Pointer;
import sys.FileSystem;

import bindings.Glad;
import bindings.StbImage;

import blueprint.objects.Sprite;

class Texture {
	static var imageCache:Map<String, Texture> = [];

	public var ID:cpp.UInt32;

	var _cacheKey:Null<String>;
	public var path:String;

	public var width:Int;
	public var height:Int;
	public var numChannels:Int;
	public var loaded:Bool = false;

	public function new(?filePath:String) {
		Glad.genTextures(1, Pointer.addressOf(ID));
		Glad.bindTexture(Glad.TEXTURE_2D, ID);

		if (filePath != null)
			loadFromFile(filePath);
	}

	public function loadFromFile(filePath:String) {
		path = filePath;
		Glad.bindTexture(Glad.TEXTURE_2D, ID);

		var daPath = FileSystem.absolutePath(path);
		if (!FileSystem.exists(daPath))
			daPath = FileSystem.absolutePath("assets/missingImage.png");

		var data:cpp.Star<cpp.UInt8> = StbImage.load(daPath, Pointer.addressOf(width), Pointer.addressOf(height), Pointer.addressOf(numChannels), 0);

		var imageFormat = (numChannels == 4) ? Glad.RGBA : Glad.RGB;

		if (data != 0) {
			Glad.texImage2D(Glad.TEXTURE_2D, 0, imageFormat, width, height, 0, imageFormat, Glad.UNSIGNED_BYTE, cast data);
			Glad.generateMipmap(Glad.TEXTURE_2D);
		} else {
			Sys.println('Failed to load "$path": ${StbImage.failureReason()}');
			return this;
		}

		StbImage.freeImage(cast data);
		loaded = true;
		return this;
	}

	@:deprecated('"loadFromImage" is now deprecated! Please use "loadFromFile" instead.')
	public function loadFromImage(filePath:String) {return loadFromFile(filePath);}

	public function destroy() {
		Glad.deleteTextures(1, Pointer.addressOf(ID));

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

		return imageCache[filePath];
	}

	public static function clearCache() {
		for (key in imageCache.keys()) {
			if (imageCache[key] == Sprite.defaultTexture)
				imageCache.remove(key);
			else 
				imageCache[key].destroy();
		}
	}

	@:deprecated('"getImageTex" is now deprecated! Please use "getCachedTex" instead.')
	public static function getImageTex(filePath:String) {return getCachedTex(filePath);}
}
