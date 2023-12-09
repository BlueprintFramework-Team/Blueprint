package blueprint.text;

import cpp.Pointer;
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
	static var fontCache:Map<String, Font> = [];

	public var loaded:Bool = true;
	var face:FreetypeFace;
	var sizes:Map<Int, Map<Int, FontTexture>> = [];

	public function new(path:String) {
		var daPath = FileSystem.absolutePath(path);
		loaded = Freetype.newFace(library, daPath, 0, Pointer.addressOf(face)) == 0;
		if (!loaded)
			Sys.println('FAILED TO LOAD FREETYPE FONT "$path"');
	}

	public function preloadSize(size:Int) {
		if (!sizes.exists(size)) sizes[size] = new Map<Int, FontTexture>();

		Glad.pixelStorei(Glad.UNPACK_ALIGNMENT, 1);
		Freetype.setPixelSizes(face, 0, size);
		for (i in 32...127) {
			if (sizes[size].exists(i)) continue;

			if (Freetype.loadChar(face, cast i, Freetype.LOAD_RENDER) != 0) {
				Sys.println('FAILED TO LOAD FREETYPE LETTER "${String.fromCharCode(i)}"');
				sizes[size].set(i, {
					texture: Sprite.defaultTexture,
					bearingX: 0,
					bearingY: 0,
					advance: Sprite.defaultTexture.width
				});
				continue;
			}

			var newTex = new Texture();
			Glad.texImage2D(
				Glad.TEXTURE_2D,
				0,
				Glad.RED,
				face[0].glyph.bitmap.width,
				face[0].glyph.bitmap.rows,
				0,
				Glad.RED,
				Glad.UNSIGNED_BYTE,
				cast face[0].glyph.bitmap.buffer
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

			if (Freetype.loadChar(face, cast letter, Freetype.LOAD_RENDER) != 0) {
				Sys.println('FAILED TO LOAD FREETYPE LETTER "${String.fromCharCode(letter)}"');
				sizes[size].set(letter, {
					texture: Sprite.defaultTexture,
					bearingX: 0,
					bearingY: 0,
					advance: Sprite.defaultTexture.width
				});
				return sizes[size].get(letter);
			}

			var newTex = new Texture();
			Glad.texImage2D(
				Glad.TEXTURE_2D,
				0,
				Glad.RED,
				face[0].glyph.bitmap.width,
				face[0].glyph.bitmap.rows,
				0,
				Glad.RED,
				Glad.UNSIGNED_BYTE,
				cast face[0].glyph.bitmap.buffer
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
		Freetype.doneFace(face);
		for (size in sizes.iterator()) {
			for (tex in size.iterator())
				tex.texture.destroy();
		}
		sizes = [];
	}

	public static function getCachedFont(filePath:String) {
		if (!fontCache.exists(filePath)) {
			var font = new Font(filePath);
			if (!font.loaded) 
				font.destroy();
			fontCache.set(filePath, font);
		}

		return fontCache[filePath];
	}
}