package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.RoomObjectFactoryBootstrap;
    import com.sulake.iid.IIDRoomObjectFactory;

        public class HabboRoomObjectLogicLib extends SimpleApplication 
    {

        public static var manifest:Class = HabboHabboRoomObjectLogicLib_Habbomanifest_xml;
        public static var requiredClasses:Array = new Array(RoomObjectFactoryBootstrap, IIDRoomObjectFactory);


    }
}