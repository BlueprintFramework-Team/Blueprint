package blueprint.textData;

import blueprint.graphics.Texture;
import cpp.Pointer;
import sys.FileSystem;
import bindings.Freetype;

// NOTE: THIS IS AT A VERY EARLY STAGE RIGHT NOW. DO NOT ATTEMPT TO USE.

class FontTexture {
	public var texture:Texture;
	public var bearingX:Int;
	public var bearingY:Int;
	public var advance:cpp.UInt32;
}

class Font {
	@:allow(blueprint.Game) static var library:FreetypeLib;

	var face:FreetypeFace;
	var sizes:Map<Int, Map<String, FontTexture>> = [];

	public function new(path:String) {
		var daPath = FileSystem.absolutePath(path);
		Freetype.newFace(library, daPath, 0, Pointer.addressOf(face));
		// trace(face.numGlyphs);
	}

	public function destroy() {
		Freetype.doneFace(face);
		for (size in sizes.iterator()) {
			for (tex in size.iterator())
				tex.texture.destroy();
		}
	}
}