package;

import bindings.Glfw;
import blueprint.Game;

import sys.thread.Thread;
import sys.thread.Mutex;

enum abstract ThreadLoopFlag(Bool) from Bool to Bool {
	var CONTINUE_THREAD = true;
	var STOP_THREAD = false;
}

class ThreadHelper {
	public static var mutex:Mutex = new Mutex();

	public static function startThread(func:Void->Void) {
		if (func == null) return;
		Thread.create(function() {
			mutex.acquire();
			func();
			mutex.release();
		});
	}

	public static function startWindowThread(func:Float->ThreadLoopFlag, ?interval:Float = 0.0) {
		if (func == null) return;

		Thread.create(function() {
			var continueThread:ThreadLoopFlag = CONTINUE_THREAD;
			mutex.acquire();
			while (!Glfw.windowShouldClose(Game.window.cWindow) && func != null && continueThread) {
				continueThread = func(Glfw.getTime());
				mutex.release();
				if (interval > 0)
					Sys.sleep(interval - (Glfw.getTime() % interval));
				mutex.acquire();
			}
			mutex.release();
		});
	}
}