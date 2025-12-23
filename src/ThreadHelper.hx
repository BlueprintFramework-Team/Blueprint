package;

import bindings.Glfw;
import blueprint.Game;

import sys.thread.Thread;
import sys.thread.Mutex;

class ThreadHelper {
	public static var mutex:Mutex = new Mutex();

	public static function startThread(func:Void->Void) {
		if (func == null) return;

		Glfw.makeContextCurrent(null);
		mutex.release();

		Thread.create(function() {
			mutex.acquire();
			Glfw.makeContextCurrent(Game.window.cWindow);
			func();
			Glfw.makeContextCurrent(null);
			mutex.release();
		});

		mutex.acquire();
		Glfw.makeContextCurrent(Game.window.cWindow);
	}

	/**
		Creates a thread that runs until the window is closed.

		@param func The function to run in the thread. Receives the current timestamp and returns how long it should wait until the next run. (It may also return a negative value to stop it!)
	**/
	public static function startWindowThread(func:Float->Float) {
		if (func == null) return;

		Thread.create(function() {
			var interval:Float = 0.0;
			mutex.acquire();
			Glfw.makeContextCurrent(Game.window.cWindow);
			while (!Glfw.windowShouldClose(Game.window.cWindow) && func != null && interval >= 0.0) {
				interval = func(Glfw.getTime());
				Glfw.makeContextCurrent(null);
				mutex.release();
				Glfw.postEmptyEvent();
				Sys.sleep(interval > 0 ? interval - (Glfw.getTime() % interval) : 0.0);
				mutex.acquire();
				Glfw.makeContextCurrent(Game.window.cWindow);
			}
			Glfw.makeContextCurrent(null);
			mutex.release();
		});
	}
}