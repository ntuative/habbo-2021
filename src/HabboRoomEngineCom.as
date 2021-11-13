package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.RoomEngineBootstrap;
    import com.sulake.iid.IIDRoomEngine;

        public class HabboRoomEngineCom extends SimpleApplication 
    {

        public static var manifest:Class = HabboHabboRoomEngineCom_Habbomanifest_xml;
        public static var requiredClasses:Array = new Array(RoomEngineBootstrap, IIDRoomEngine);


    }
}