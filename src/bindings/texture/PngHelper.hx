/**
 * TODO: actually bind libpng. (hopefully i actually do that one day.)
 * 
 * Yes, I'm being lazy.
 * But I really don't want to make bindings right now.
 * Especially when they're hecka tedious.
 * 
 * - Srt
 */
package bindings.texture;

import cpp.Pointer;
import cpp.ConstCharStar;

@:include("texture/png_helper.h")
extern class PngHelper {
    @:native("loadPng")
    static function loadPng(path:ConstCharStar, width:Pointer<Int>, height:Pointer<Int>):Int;
}