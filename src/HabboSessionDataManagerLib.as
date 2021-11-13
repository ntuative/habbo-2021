package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.SessionDataManagerBootstrap;
    import com.sulake.iid.IIDSessionDataManager;

        public class HabboSessionDataManagerLib extends SimpleApplication 
    {

        public static var requiredClasses:Array = new Array(SessionDataManagerBootstrap, IIDSessionDataManager);
        public static var manifest:Class = HabboHabboSessionDataManagerLib_Habbomanifest_xml;
        public static var loading_icon:Class = HabboHabboSessionDataManagerLib_Habboloading_icon_png;


    }
}