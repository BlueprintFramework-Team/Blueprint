package blueprint.sound;

final BUFFER_COUNT:Int = 4;
final SAMPLE_SIZE:Int = 65536;
final SAMPLE_COUNT:Int = untyped __cpp__("{0} / sizeof(short)", SAMPLE_SIZE);

interface AudioFormat {
	private var _cacheKey:Null<String>;
	public var useCount:Int;
	public var bufferNum:Int;
	public var buffers:RawPointer<cpp.UInt32>;
	public var loaded:Bool;
	public var path:String;
	private var loadFormat:cpp.UInt32;

	public function startSource(sourceID:Int):Void;
	public function queueBuffers(sourceID:Int):Void;
	public function seek(seconds:Float):Void;
	public function getLength():Float;

	public function destroy():Void;
}
