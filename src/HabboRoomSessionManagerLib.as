package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.RoomSessionManagerBootstrap;
    import com.sulake.iid.IIDHabboRoomSessionManager;

        public class HabboRoomSessionManagerLib extends SimpleApplication 
    {

        public static var manifest:Class = HabboHabboRoomSessionManagerLib_Habbomanifest_xml;
        public static var requiredClasses:Array = new Array(RoomSessionManagerBootstrap, IIDHabboRoomSessionManager);


    }
}