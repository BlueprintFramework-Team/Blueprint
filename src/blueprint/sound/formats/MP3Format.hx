package blueprint.sound.formats;

import ResourceHelper.InternalResource;
import cpp.RawPointer;
import bindings.CppHelpers;
import bindings.audio.AL;
import bindings.audio.DrMP3;

import blueprint.sound.AudioFormat;

import haxe.io.Bytes;

class MP3Format implements AudioFormat {
	public var sampleRate:Int;
	public var bufferNum:Int = BUFFER_COUNT;
	public var buffers:cpp.RawPointer<cpp.UInt32>;
	public var loaded:Bool = false;
	public var path:String;

	var framesToRead:cpp.UInt64;
	var loadFormat:cpp.UInt32;
	var data:DrMP3Data;
	var dataPtr(get, never):DrMP3Ptr;
	inline function get_dataPtr():DrMP3Ptr {
		return RawPointer.addressOf(data);
	}

	public function new(filePath:String) {
		buffers = CppHelpers.malloc(BUFFER_COUNT, cpp.UInt32);

		AL.genBuffers(BUFFER_COUNT, buffers);
		path = filePath;

		final fullPath = sys.FileSystem.absolutePath(path);
		if (!sys.FileSystem.exists(fullPath)) {
			var res:InternalResource = ResourceHelper.getResource(path);
			if (res.dataLength > 0) // dont check if its "null". its fucky with that.
				loaded = DrMP3.initMemory(dataPtr, res.data, cast res.dataLength, null);
			else
				Sys.println('Failed to load "$path": File nonexistent.');
		} else
			loaded = DrMP3.initFile(dataPtr, fullPath, null);

		if (loaded) {
			loadFormat = (data.channels == 1) ? AL.FORMAT_MONO16 : AL.FORMAT_STEREO16;
			sampleRate = data.sampleRate;
			framesToRead = untyped __cpp__("{0} / {1}", SAMPLE_COUNT, data.channels);
		}
	}


	public function startSource(sourceID:Int):Void {
		var stopLoading:Bool = false;
		for (i in 0...BUFFER_COUNT) {
			final sample:RawPointer<cpp.Int16> = CppHelpers.malloc(SAMPLE_COUNT, cpp.Int16);
			final framesRead = DrMP3.readPCMFramesShort16(dataPtr, framesToRead, sample);

			if (framesRead.toInt() == 0 || stopLoading) {
				--bufferNum;
				stopLoading = true;
				AL.deleteBuffers(1, RawPointer.addressOf(buffers[i]));
				CppHelpers.free(sample);
				continue;
			}
			stopLoading = (untyped __cpp__("{0} < {1}", framesRead, framesToRead));

			AL.bufferData(buffers[i], loadFormat, sample, untyped __cpp__("{0} * sizeof(short) * {1}", framesRead, data.channels), sampleRate);
			CppHelpers.free(sample);
		}
		AL.sourceQueueBuffers(sourceID, bufferNum, buffers);
    }

	public function queueBuffers(sourceID:Int):Void {
        final buffer:cpp.UInt32 = 0;
		AL.sourceUnqueueBuffers(sourceID, 1, RawPointer.addressOf(buffer));

		final newSample:RawPointer<cpp.Int16> = CppHelpers.malloc(SAMPLE_COUNT, cpp.Int16);
		final framesRead = DrMP3.readPCMFramesShort16(dataPtr, framesToRead, CppHelpers.makePointer(newSample[0]));

		AL.bufferData(buffer, loadFormat, newSample, untyped __cpp__("{0} * sizeof(short) * {1}", framesRead, data.channels), sampleRate);
		CppHelpers.free(newSample);

		if (framesRead.toInt() > 0) {
			AL.sourceQueueBuffers(sourceID, 1, RawPointer.addressOf(buffer));
		}
    }

	public function seek(seconds:Float):Void {
		DrMP3.seekToPCMFrame(dataPtr, cast sampleRate * seconds);
    }

	public function getLength():Float {
        return DrMP3.getPCMFrameCount(dataPtr).toInt() / sampleRate;
    }

	public function destroy():Void {
		DrMP3.uninit(dataPtr);
		AL.deleteBuffers(BUFFER_COUNT, buffers);
		CppHelpers.free(buffers);
    }
}