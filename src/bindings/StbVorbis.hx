package bindings;

@:include('stb_vorbis.h')
extern class StbVorbis {
	@:native('stb_vorbis_decode_filename')
	static function decodeFileName(fileName:cpp.ConstCharStar, channels:cpp.Pointer<Int>, sampleRate:cpp.Pointer<Int>,
		output:cpp.Pointer<cpp.Pointer<cpp.Int16>>):Int;
}
