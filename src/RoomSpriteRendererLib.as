package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.RoomRendererFactoryBootstrap;
    import com.sulake.iid.IIDRoomRendererFactory;

        public class RoomSpriteRendererLib extends SimpleApplication 
    {

        public static var manifest:Class = HabboRoomSpriteRendererLib_Habbomanifest_xml;
        public static var requiredClasses:Array = new Array(RoomRendererFactoryBootstrap, IIDRoomRendererFactory);


    }
}