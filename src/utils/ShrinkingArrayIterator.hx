package utils;

/**
	A variation of `haxe.iterators.ArrayIterator` meant to allow for in loop removal.

	NOTE: REORDERING HAS NOT BEEN TESTED WITH THIS CLASS!
**/
class ShrinkingArrayIterator<T> {
	final array:Array<T>;
	var checkLength:Int = 0;
	var current:Int = -1;

	public #if !hl inline #end function new(array:Array<T>) {
		this.array = array;
		checkLength = array.length;
	}

	public #if !hl inline #end function hasNext():Bool {
		var inc = array.length - checkLength;
		current += 1 + inc;
		checkLength = array.length;
		return current < checkLength;
	}

	public #if !hl inline #end function next():T {
		return array[current];
	}
}

/**
	A variation of `haxe.iterators.ArrayKeyValueIterator` meant to allow for in loop removal.

	NOTE: REORDERING HAS NOT BEEN TESTED WITH THIS CLASS!
**/
class ShrinkingKeyValueArrayIterator<T> {
	final array:Array<T>;
	var checkLength:Int = 0;
	var current:Int = -1;

	public #if !hl inline #end function new(array:Array<T>) {
		this.array = array;
		checkLength = array.length;
	}

	public #if !hl inline #end function hasNext():Bool {
		var inc = array.length - checkLength;
		current += 1 + inc;
		checkLength = array.length;
		return current < checkLength;
	}

	public #if !hl inline #end function next():{key:Int,value:T}  {
		return {key: current, value: array[current]};
	}
}