package blueprint.sound;

final BUFFER_COUNT:Int = 4;

interface AudioFormat {
	var _cacheKey:Null<String>;
	public var useCount:Int;
	public var bufferNum:Int;
	public var buffers:Array<cpp.UInt32>;
	public var loaded:Bool;
	public var path:String;
	var loadFormat:cpp.UInt32;

	public function startSource(sourceID:Int):Void;
	public function queueBuffers(sourceID:Int):Void;
	public function seek(seconds:Float):Void;
	public function getLength():Float;

	public function destroy():Void;
}
