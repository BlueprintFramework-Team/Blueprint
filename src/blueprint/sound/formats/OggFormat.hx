package blueprint.sound.formats;

import ResourceHelper.InternalResource;
import cpp.RawPointer;
import bindings.audio.StbVorbis;
import bindings.CppHelpers;
import bindings.audio.AL;

import blueprint.sound.IAudioFormat;

import haxe.io.Bytes;

class OggFormat implements IAudioFormat {
	public var sampleRate:Int;
	public var bufferNum:Int = BUFFER_COUNT;
	public var buffers:cpp.RawPointer<cpp.UInt32>;
	public var loaded:Bool = false;
	public var path:String;

	var framesToLoad:Int;
	var loadFormat:cpp.UInt32;
	var data:VorbisData;

	public function new(filePath:String) {
		buffers = CppHelpers.malloc(BUFFER_COUNT, cpp.UInt32);

		AL.genBuffers(BUFFER_COUNT, buffers);
		path = filePath;

		var error:Int = 0;
		final fullPath = sys.FileSystem.absolutePath(path);
		if (!sys.FileSystem.exists(fullPath)) {
			var res:InternalResource = ResourceHelper.getResource(path);
			if (res.dataLength > 0) // dont check if its "null". its fucky with that.
				data = StbVorbis.openMemory(res.data, res.dataLength, CppHelpers.makePointer(error), null);
			else
				Sys.println('Failed to load "$path": File nonexistent.');
		} else
			data = StbVorbis.openFileName(fullPath, CppHelpers.makePointer(error), null);

		if (data != null) {
			loaded = true;
			loadFormat = (data[0].channels == 1) ? AL.FORMAT_MONO16 : AL.FORMAT_STEREO16;
			sampleRate = data[0].sampleRate;
			framesToLoad = Math.floor(SAMPLE_COUNT / data[0].channels);
		} else 
			Sys.println('Failed to load "$path": Error code $error.');
	}

	public function startSource(sourceID:Int) {
		for (i in 0...BUFFER_COUNT) {
			final sample = CppHelpers.malloc(framesToLoad, cpp.Int16);
			final samplesStored = StbVorbis.getSamplesShortInterleaved(data, data[0].channels, sample, SAMPLE_COUNT);

			if (samplesStored == 0) {
				--bufferNum;
				AL.deleteBuffers(1, RawPointer.addressOf(buffers[i]));
				CppHelpers.free(sample);
				continue;
			}

			AL.bufferData(buffers[i], loadFormat, sample, SAMPLE_SIZE, sampleRate);
			CppHelpers.free(sample);
		}
		AL.sourceQueueBuffers(sourceID, bufferNum, buffers);
	}

	public function queueBuffers(sourceID:Int) {
        final buffer:cpp.UInt32 = 0;
		AL.sourceUnqueueBuffers(sourceID, 1, RawPointer.addressOf(buffer));

		final newSample = CppHelpers.malloc(framesToLoad, cpp.Int16);
		final samplesStored = StbVorbis.getSamplesShortInterleaved(data, data[0].channels, newSample, SAMPLE_COUNT);

		AL.bufferData(buffer, loadFormat, newSample, SAMPLE_SIZE, sampleRate);
		CppHelpers.free(newSample);

		if (samplesStored > 0) {
			AL.sourceQueueBuffers(sourceID, 1, RawPointer.addressOf(buffer));
		}
	}

    public function seek(seconds:Float) {
        StbVorbis.seek(data, Math.floor(sampleRate * seconds));
    }

	public function getLength() {
		return StbVorbis.streamLengthInSeconds(data);
	}

	var destroyed:Bool = false;
	public function destroy() {
		if (destroyed) return;

		destroyed = true;
		if (data != null)
			StbVorbis.close(data);
		AL.deleteBuffers(BUFFER_COUNT, buffers);
		CppHelpers.free(buffers);
	}
}
