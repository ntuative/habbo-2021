package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboConfigurationManagerBootstrap;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.habbo.configuration.HabboConfigurationManager;

        public class HabboConfigurationCom extends SimpleApplication 
    {

        public static var requiredClasses:Array = new Array(HabboConfigurationManagerBootstrap, IIDHabboConfigurationManager, HabboConfigurationManager);
        public static var manifest:Class = HabboHabboConfigurationCom_Habbomanifest_xml;
        public static var common_configuration:Class = HabboHabboConfigurationCom_Habbocommon_configuration_txt;
        public static var localization_configuration:Class = HabboHabboConfigurationCom_Habbolocalization_configuration_txt;


    }
}