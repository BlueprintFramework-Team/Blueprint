package blueprint;

import haxe.io.Path;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

using haxe.macro.ExprTools;
using haxe.macro.TypeTools;
using StringTools;

class Macros {
    #if macro
    public static macro function embedAssets():Array<Field> {
        //var blueprintDir = Path.directory(Context.resolvePath("blueprint"));
        var process = new sys.io.Process("haxelib", ["libpath", "blueprint"]);
        var blueprintDir = process.stdout.readAll().toString().split("\n")[0].split("\r")[0];
        if (process.exitCode() != 0)
            Context.error("The library path for Blueprint was unable to be found. Certain assets will not be embedded properly.", Context.currentPos());
        Context.addResource("missingImage.png", sys.io.File.getBytes(Path.normalize(Path.join([blueprintDir, "/blueprintAssets/missingImage.png"]))));
        return Context.getBuildFields();
    }

    //public static macro function swizzle(props:Map<String, Array<String>>):Array<Field> {
    public static macro function swizzle(mainProps:Expr, newProps:Expr):Array<Field> {
        var mainFields:Array<String> = mainProps.getValue();
        var newFields:Array<Array<String>> = newProps.getValue();
        var fields = Context.getBuildFields();
        var pos = Context.currentPos();

        for (i in 0...mainFields.length) {
            var mainField = mainFields[i];
            for (newField in newFields[i]) {
                final factorIndex = newField.indexOf("::");
                final factor:Float = (factorIndex >= 0) ? Std.parseFloat(newField.substring(factorIndex + 2, newField.length)) : 1;
                newField = (factorIndex >= 0) ? newField.substring(0, factorIndex) : newField;

                fields.push({
                    name: newField,
                    access: [APublic],
                    kind: FProp("get", "set", (macro:Float)),
                    pos: pos
                });
                final getter:String = "get_" + mainField;
                fields.push({
                    name: "get_" + newField,
                    access: [APrivate, AInline],
                    kind: FFun({
                        args: [],
                        ret: (macro:Float),
                        expr: (factor == 1.0) ? (macro {return $i{getter}();}) : (macro {return $i{getter}() * $v{factor};})
                    }),
                    pos: pos
                });
                final setter:String = "set_" + mainField;
                fields.push({
                    name: "set_" + newField,
                    access: [APrivate, AInline],
                    kind: FFun({
                        args: [{
                            name: "value",
                            type: (macro:Float)
                        }],
                        ret: (macro:Float),
                        expr: (factor == 1.0) ? macro {return $i{setter}(value);} : (macro {return $i{setter}(value / $v{factor});})
                    }),
                    pos: pos
                });
            }
        }

        return fields;
    }
    #end

    public static macro function fieldsToMap(classPath:String, prefix:String, reverse:Bool):Expr {
        var classType:Type = Context.getType(classPath);
        var baseType:BaseType;
        var mapValues = [];

        switch (classType.follow()) {
            case TInst(_.get() => cls, _):
                baseType = cls;
                for (field in cls.statics.get()) {
                    if (field.name.startsWith(prefix))
                        mapValues.push({fullKey: field.name, trimKey: field.name.replace(prefix, "")});
                }
            case TAbstract(_.get() => abs, _):
                baseType = abs;
                for (field in abs.impl.get().statics.get()) {
                    if (field.name.startsWith(prefix))
                        mapValues.push({fullKey: field.name, trimKey: field.name.replace(prefix, "")});
                }
            default:
                // nothin
        }

        var arrayMap = reverse ? function(mapVal) {
            return macro $p{baseType.pack.concat([baseType.name, mapVal.fullKey])} => $v{mapVal.trimKey};
        } : function(mapVal) {
            return macro $v{mapVal.trimKey} => $p{baseType.pack.concat([baseType.name, mapVal.fullKey])};
        };
        return macro $a{mapValues.map(arrayMap)};
    }
}