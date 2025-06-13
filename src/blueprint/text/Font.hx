package blueprint.text;

/**
 * TODO:
 * 	- Fix Freetype.errorString returning `null`.
 */

import ResourceHelper.InternalResource;
import cpp.RawPointer;
import sys.FileSystem;

import bindings.Glad;
import bindings.freetype.Freetype;
import bindings.freetype.FreetypeGlyph;
import bindings.freetype.FreetypeBitmap;
import bindings.freetype.FreetypeStroker;

import blueprint.objects.Sprite;
import blueprint.graphics.Texture;

@:structInit class OutlineRef {
	public var texture:Texture;
	public var parent:FontTexture;
}

@:structInit class FontTexture {
	public var texture:Texture;
	public var bearingX:Int;
	public var bearingY:Int;
	public var advance:Int;

	public var outlines:Map<Int, OutlineRef>;
}

class Font {
	@:allow(blueprint.Game) static var library:FTLibrary;
	@:allow(blueprint.Game) static var stroker:FTStroker;
	public static var enableKeepOnce:Bool = false;
	static final loadRenderTarget:cpp.UInt32 = Freetype.LOAD_TARGET(FTRenderMode.SDF);
	static var fontCache:Map<String, Font> = [];

	var face:FTFace;
	var tempGlyph:FTGlyph;
	var sizes:Map<Int, Map<Int, FontTexture>> = [];
	var sizesNoSDF:Map<Int, Map<Int, FontTexture>> = [];

	public var keepIfUnused:Bool = false;
	public var keepOnce:Bool = false;
	public var useCount:Int = 0;
	public var path:String;
	public var loaded:Bool = true;
	var _cacheKey:Null<String>;
	
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

			final errCode = Freetype.loadChar(face, cast i, Freetype.LOAD_RENDER | loadRenderTarget);
			if (errCode != 0) {
				Sys.println('Failed to load "${String.fromCharCode(i)}" for "$path": Error Code $errCode');
				//Sys.println('Failed to load "${String.fromCharCode(i)}" for "$path": ${Freetype.errorString(errCode)}');
				sizes[size].set(i, {
					texture: Sprite.defaultTexture,
					bearingX: 0,
					bearingY: 0,
					advance: Sprite.defaultTexture.width,
					outlines: []
				});
				continue;
			}

			sizes[size].set(i, {
				texture: textureFromFTBitmap(face[0].glyph.bitmap),
				bearingX: face[0].glyph.bitmapLeft,
				bearingY: face[0].glyph.bitmapTop,
				advance: cast face[0].glyph.advance.x,
				outlines: []
			});
		}
		Glad.pixelStorei(Glad.UNPACK_ALIGNMENT, 4);
	}

	public function getLetter(letter:Int, size:Int, useSDF:Bool) {
		var sizes = useSDF ? sizes : sizesNoSDF;
		if (!sizes.exists(size)) sizes[size] = new Map<Int, FontTexture>();

		if (!sizes[size].exists(letter)) {
			Glad.pixelStorei(Glad.UNPACK_ALIGNMENT, 1);
			Freetype.setPixelSizes(face, 0, size);

			final errCode = Freetype.loadChar(face, cast letter, Freetype.LOAD_RENDER | loadRenderTarget * CppHelpers.boolToInt(useSDF));
			if (errCode != 0) {
				Sys.println('Failed to load "${String.fromCharCode(letter)}" for "$path": Error Code $errCode');
				//Sys.println('Failed to load "${String.fromCharCode(letter)}" for "$path": ${Freetype.errorString(errCode)}');
				sizes[size].set(letter, {
					texture: Sprite.defaultTexture,
					bearingX: 0,
					bearingY: 0,
					advance: Sprite.defaultTexture.width,
					outlines: []
				});
				return sizes[size].get(letter);
			}

			sizes[size].set(letter, {
				texture: textureFromFTBitmap(face[0].glyph.bitmap),
				bearingX: face[0].glyph.bitmapLeft,
				bearingY: face[0].glyph.bitmapTop,
				advance: cast face[0].glyph.advance.x,
				outlines: []
			});
			Glad.pixelStorei(Glad.UNPACK_ALIGNMENT, 4);
		}

		return sizes[size].get(letter);
	}

	public function getOutline(letter:Int, size:Int, outline:Int, useSDF:Bool) {
		if (!sizes.exists(size)) sizes[size] = new Map<Int, FontTexture>();

		var data = getLetter(letter, size, useSDF);
		if (!data.outlines.exists(outline)) {
			Glad.pixelStorei(Glad.UNPACK_ALIGNMENT, 1);
			Freetype.setPixelSizes(face, 0, size);
			FreetypeStroker.set(stroker, cast(outline * 32), ROUND, ROUND, cast 0);

			final errCode = Freetype.loadChar(face, cast letter, Freetype.LOAD_DEFAULT);
			if (errCode != 0) {
				Sys.println('Failed to load "${String.fromCharCode(letter)}" for "$path": Error Code $errCode');
				//Sys.println('Failed to load "${String.fromCharCode(letter)}" for "$path": ${Freetype.errorString(errCode)}');
				data.outlines.set(outline, {texture: Sprite.defaultTexture, parent: data});
				return data.outlines[outline];
			}

			final errCodeOut = FreetypeGlyph.get(face[0].glyph, RawPointer.addressOf(tempGlyph));
			if (errCodeOut != 0) {
				Sys.println('Failed to load outline border $outline for "${String.fromCharCode(letter)}" for "$path": Error Code $errCodeOut');
				//Sys.println('Failed to load "${String.fromCharCode(letter)}" for "$path": ${Freetype.errorString(errCode)}');
				data.outlines.set(outline, {texture: Sprite.defaultTexture, parent: data});
				return data.outlines[outline];
			}
			FreetypeStroker.glyphStroke(RawPointer.addressOf(tempGlyph), stroker, 0);
			FreetypeGlyph.toBitmap(RawPointer.addressOf(tempGlyph), NORMAL, null, 1);
			final bitmapGlyph:FTBitmapGlyph = cast tempGlyph;

			data.outlines.set(outline, {texture: textureFromFTBitmap(bitmapGlyph.bitmap), parent: data});
			FreetypeBitmap.done(library, RawPointer.addressOf(bitmapGlyph.bitmap));
			FreetypeGlyph.done(tempGlyph);
			Glad.pixelStorei(Glad.UNPACK_ALIGNMENT, 4);
		}

		return data.outlines[outline];
	}

	function textureFromFTBitmap(bitmap:FTBitmap) {
		var newTex = new Texture();
		var buffer:RawPointer<cpp.UInt8> = bitmap.buffer;
		Glad.texImage2D(
			Glad.TEXTURE_2D,
			0,
			Glad.RED,
			bitmap.width,
			bitmap.rows,
			0,
			Glad.RED,
			Glad.UNSIGNED_BYTE,
			buffer
		);
		newTex.width = cast bitmap.width;
		newTex.height = cast bitmap.rows;

		Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_WRAP_S, Glad.CLAMP_TO_EDGE);
		Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_WRAP_T, Glad.CLAMP_TO_EDGE);
		Glad.bindTexture(Glad.TEXTURE_2D, 0);
		return newTex;
	}

	public function destroy() {
		if (face != null)
			Freetype.doneFace(face);
		for (size in sizes.iterator()) {
			for (tex in size.iterator()) {
				tex.texture.destroy();
				for (out in tex.outlines.iterator())
					out.texture.destroy();
			}
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
			} else {
				font._cacheKey = filePath;
				font.keepOnce = enableKeepOnce || font.keepOnce;
			}
			fontCache.set(filePath, font);
		} else 
			fontCache[filePath].keepOnce = enableKeepOnce || fontCache[filePath].keepOnce;

		return fontCache[filePath];
	}

	public static function clearCache(?force:Bool = false) {
		for (key in fontCache.keys()) {
			final font = fontCache[key];

			if (font == null)
				fontCache.remove(key);
			else {
				if (force || (!font.keepOnce && !font.keepIfUnused && font.useCount <= 0))
					font.destroy();
				font.keepOnce = false;
			}
		}
	}
}