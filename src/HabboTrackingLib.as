package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboTrackingBootstrap;
    import com.sulake.iid.IIDHabboTracking;

        public class HabboTrackingLib extends SimpleApplication 
    {

        public static var manifest:Class = HabboHabboTrackingLib_Habbomanifest_xml;
        public static var requiredClasses:Array = new Array(HabboTrackingBootstrap, IIDHabboTracking);


    }
}