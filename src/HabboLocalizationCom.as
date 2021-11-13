package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboLocalizationManagerBootstrap;
    import com.sulake.iid.IIDCoreLocalizationManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.localization.HabboLocalizationManager;

        public class HabboLocalizationCom extends SimpleApplication 
    {

        public static var requiredClasses:Array = new Array(HabboLocalizationManagerBootstrap, IIDCoreLocalizationManager, IIDHabboLocalizationManager, ICoreLocalizationManager, IHabboLocalizationManager, HabboLocalizationManager);
        public static var manifest:Class = HabboHabboLocalizationCom_Habbomanifest_xml;
        public static var default_localizations_pt:Class = HabboHabboLocalizationCom_Habbodefault_localizations_pt_txt;
        public static var default_localizations_de:Class = HabboHabboLocalizationCom_Habbodefault_localizations_de_txt;
        public static var default_localizations_tr:Class = HabboHabboLocalizationCom_Habbodefault_localizations_tr_txt;
        public static var default_localizations_dk:Class = HabboHabboLocalizationCom_Habbodefault_localizations_dk_txt;
        public static var default_localizations_es:Class = HabboHabboLocalizationCom_Habbodefault_localizations_es_txt;
        public static var default_localizations_fi:Class = HabboHabboLocalizationCom_Habbodefault_localizations_fi_txt;
        public static var default_localizations_fr:Class = HabboHabboLocalizationCom_Habbodefault_localizations_fr_txt;
        public static var default_localizations_it:Class = HabboHabboLocalizationCom_Habbodefault_localizations_it_txt;
        public static var default_localizations_nl:Class = HabboHabboLocalizationCom_Habbodefault_localizations_nl_txt;
        public static var default_localizations_no:Class = HabboHabboLocalizationCom_Habbodefault_localizations_no_txt;
        public static var default_localizations_se:Class = HabboHabboLocalizationCom_Habbodefault_localizations_se_txt;
        public static var default_localizations_en:Class = HabboHabboLocalizationCom_Habbodefault_localizations_en_txt;


    }
}