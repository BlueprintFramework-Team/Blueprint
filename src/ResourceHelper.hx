package;

import bindings.CppHelpers;
import cpp.RawPointer;

@:include("hx/StdLibs.h")
@:native("hx::Resource")
@:structAccess
extern class InternalResource {
    @:native("mName")
    var name:String;
    @:native("mDataLength")
    var dataLength:Int;
    @:native("mData")
    var data:RawPointer<cpp.UInt8>;
}

@:include("hx/StdLibs.h")
class ResourceHelper {
    @:native("hx::GetResources")
    public static extern function getResources():RawPointer<InternalResource>;

    /**
     * Returns an InternalResource instance with the matching name.
     * 
     * NOTE: DO NOT CHECK IF IT IS NULL THROUGH `== null`!
     * Instead, use `.name == null` or `.dataLength == 0`
     * @param name 
     * @return InternalResource
     */
    public static function getResource(name:String):InternalResource {
        var resources = getResources();
        var i = 0;
        while (resources[i].name != null) {
            if (resources[i].name == name)
                return resources[i];
            i++;
        }
        return resources[i]; // the last resource should theoretically be null.
    }

    public static function getResourceIndex(name:String):Int {
        var resources = getResources();
        var i = 0;
        while (resources[i].name != null) {
            if (resources[i].name == name)
                return i;
            i++;
        }
        return -1;
    }

    public static function getRawResourceBytes(name:String):RawPointer<cpp.UInt8> {
        var resources = getResources();
        var i = 0;
        while (resources[i].name != null) {
            if (resources[i].name == name)
                return resources[i].data;
            i++;
        }
        return null;
    }

    public static function getRawResourceBytesLength(name:String):Int {
        var resources = getResources();
        var i = 0;
        while (resources[i].name != null) {
            if (resources[i].name == name)
                return resources[i].dataLength;
            i++;
        }
        return 0;
    }
}