package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.AdManagerBootstrap;
    import com.sulake.iid.IIDHabboAdManager;

        public class HabboAdManagerCom extends SimpleApplication 
    {

        public static var manifest:Class = HabboHabboAdManagerCom_Habbomanifest_xml;
        public static var requiredClasses:Array = new Array(AdManagerBootstrap, IIDHabboAdManager);


    }
}