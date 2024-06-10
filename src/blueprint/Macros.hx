package blueprint;

#if macro
import haxe.io.Path;
import haxe.macro.Context;

class Macros {
    public static macro function embedAssets():Array<haxe.macro.Expr.Field> {
        //var blueprintDir = Path.directory(Context.resolvePath("blueprint"));
        var process = new sys.io.Process("haxelib", ["libpath", "blueprint"]);
        var blueprintDir = process.stdout.readAll().toString().split("\n")[0].split("\r")[0];
        if (process.exitCode() != 0)
            Context.error("The library path for Blueprint was unable to be found. Certain assets will not be embedded properly.", Context.currentPos());
        Context.addResource("missingImage.png", sys.io.File.getBytes(Path.normalize(Path.join([blueprintDir, "/blueprintAssets/missingImage.png"]))));
        return Context.getBuildFields();
    }
}
#end