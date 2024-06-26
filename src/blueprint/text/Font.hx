package blueprint.text;

/**
 * TODO:
 * 	- Fix Freetype.errorString returning `null`.
 */

import ResourceHelper.InternalResource;
import cpp.RawPointer;
import sys.FileSystem;

import bindings.Glad;
import bindings.Freetype;

import blueprint.objects.Sprite;
import blueprint.graphics.Texture;

@:structInit class FontTexture {
	public var texture:Texture;
	public var bearingX:Int;
	public var bearingY:Int;
	public var advance:Int;
}

class Font {
	@:allow(blueprint.Game) static var library:FreetypeLib;
	static final loadFlags:cpp.UInt32 = Freetype.LOAD_RENDER | Freetype.LOAD_TARGET(FreetypeRenderMode.SDF);
	static var fontCache:Map<String, Font> = [];

	var _cacheKey:Null<String>;
	var face:FreetypeFace;
	var sizes:Map<Int, Map<Int, FontTexture>> = [];

	public var path:String;
	public var loaded:Bool = true;
	
	public function new(path:String) {
		this.path = path;

		var error:Int = 0;
		final fullPath = sys.FileSystem.absolutePath(path);
		if (!sys.FileSystem.exists(fullPath)) {
			var res:InternalResource = ResourceHelper.getResource(path);
			if (res.dataLength > 0) // dont check if its "null". its fucky with that.
				error = Freetype.newMemoryFace(library, res.data, res.dataLength, 0, RawPointer.addressOf(face));
			else {
				Sys.println('Failed to load "$path": File nonexistent.');
				return;
			}
		} else
			error = Freetype.newFace(library, fullPath, 0, RawPointer.addressOf(face));

		loaded = error == 0;
		if (!loaded)
			Sys.println('Failed to load "$path": Error Code $error');
			//Sys.println('Failed to load "$path": ${Freetype.errorString(errCode)}');
	}

	public function preloadSize(size:Int) {
		if (!sizes.exists(size)) sizes[size] = new Map<Int, FontTexture>();

		Glad.pixelStorei(Glad.UNPACK_ALIGNMENT, 1);
		Freetype.setPixelSizes(face, 0, size);
		for (i in 32...127) {
			if (sizes[size].exists(i)) continue;

			final errCode = Freetype.loadChar(face, cast i, loadFlags);
			if (errCode != 0) {
				Sys.println('Failed to load "${String.fromCharCode(i)}" for "$path": Error Code $errCode');
				//Sys.println('Failed to load "${String.fromCharCode(i)}" for "$path": ${Freetype.errorString(errCode)}');
				sizes[size].set(i, {
					texture: Sprite.defaultTexture,
					bearingX: 0,
					bearingY: 0,
					advance: Sprite.defaultTexture.width
				});
				continue;
			}

			var newTex = new Texture();
			var buffer:RawPointer<cpp.UInt8> = face[0].glyph.bitmap.buffer;
			Glad.texImage2D(
				Glad.TEXTURE_2D,
				0,
				Glad.RED,
				face[0].glyph.bitmap.width,
				face[0].glyph.bitmap.rows,
				0,
				Glad.RED,
				Glad.UNSIGNED_BYTE,
				buffer
			);
			newTex.width = cast face[0].glyph.bitmap.width;
			newTex.height = cast face[0].glyph.bitmap.rows;

			Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_WRAP_S, Glad.CLAMP_TO_EDGE);
			Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_WRAP_T, Glad.CLAMP_TO_EDGE);

			sizes[size].set(i, {
				texture: newTex,
				bearingX: face[0].glyph.bitmapLeft,
				bearingY: face[0].glyph.bitmapTop,
				advance: cast face[0].glyph.advance.x
			});
			Glad.bindTexture(Glad.TEXTURE_2D, 0);
		}
		Glad.pixelStorei(Glad.UNPACK_ALIGNMENT, 4);
	}

	public function getLetter(letter:Int, size:Int) {
		if (!sizes.exists(size)) sizes[size] = new Map<Int, FontTexture>();

		if (!sizes[size].exists(letter)) {
			Glad.pixelStorei(Glad.UNPACK_ALIGNMENT, 1);
			Freetype.setPixelSizes(face, 0, size);

			final errCode = Freetype.loadChar(face, cast letter, loadFlags);
			if (errCode != 0) {
				Sys.println('Failed to load "${String.fromCharCode(letter)}" for "$path": Error Code $errCode');
				//Sys.println('Failed to load "${String.fromCharCode(letter)}" for "$path": ${Freetype.errorString(errCode)}');
				sizes[size].set(letter, {
					texture: Sprite.defaultTexture,
					bearingX: 0,
					bearingY: 0,
					advance: Sprite.defaultTexture.width
				});
				return sizes[size].get(letter);
			}

			var newTex = new Texture();
			var buffer:RawPointer<cpp.UInt8> = face[0].glyph.bitmap.buffer;
			Glad.texImage2D(
				Glad.TEXTURE_2D,
				0,
				Glad.RED,
				face[0].glyph.bitmap.width,
				face[0].glyph.bitmap.rows,
				0,
				Glad.RED,
				Glad.UNSIGNED_BYTE,
				buffer
			);
			newTex.width = cast face[0].glyph.bitmap.width;
			newTex.height = cast face[0].glyph.bitmap.rows;

			Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_WRAP_S, Glad.CLAMP_TO_EDGE);
			Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_WRAP_T, Glad.CLAMP_TO_EDGE);

			sizes[size].set(letter, {
				texture: newTex,
				bearingX: face[0].glyph.bitmapLeft,
				bearingY: face[0].glyph.bitmapTop,
				advance: cast face[0].glyph.advance.x
			});
			Glad.bindTexture(Glad.TEXTURE_2D, 0);
			Glad.pixelStorei(Glad.UNPACK_ALIGNMENT, 4);
		}

		return sizes[size].get(letter);
	}

	public function destroy() {
		if (face != null)
			Freetype.doneFace(face);
		for (size in sizes.iterator()) {
			for (tex in size.iterator())
				tex.texture.destroy();
		}
		sizes = [];

		if (_cacheKey != null)
			fontCache.remove(_cacheKey);
	}

	public static function getCachedFont(filePath:String) {
		if (!fontCache.exists(filePath)) {
			var font = new Font(filePath);
			if (!font.loaded)  {
				font.destroy();
				font = null;
			} else 
				font._cacheKey = filePath;
			fontCache.set(filePath, font);
		}

		return fontCache[filePath];
	}

	public static function clearCache() {
		for (key in fontCache.keys()) {
			if (fontCache[key] == null)
				fontCache.remove(key);
			else 
				fontCache[key].destroy();
		}
	}
}