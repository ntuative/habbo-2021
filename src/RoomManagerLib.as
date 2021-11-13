package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.RoomManagerBootstrap;
    import com.sulake.iid.IIDRoomManager;

        public class RoomManagerLib extends SimpleApplication 
    {

        public static var manifest:Class = HabboRoomManagerLib_Habbomanifest_xml;
        public static var requiredClasses:Array = new Array(RoomManagerBootstrap, IIDRoomManager);


    }
}