package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboCommunicationDemoBootstrap;

        public class HabboCommunicationDemoCom extends SimpleApplication 
    {

        public static var manifest:Class = HabboHabboCommunicationDemoCom_Habbomanifest_xml;
        public static var login_window:Class = HabboHabboCommunicationDemoCom_Habbologin_window_xml;
        public static var login_environment_list_item:Class = HabboHabboCommunicationDemoCom_Habbologin_environment_list_item_xml;
        public static var requiredClasses:Array = new Array(HabboCommunicationDemoBootstrap);


    }
}