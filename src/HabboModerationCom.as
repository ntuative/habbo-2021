package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.ModerationManagerBootstrap;
    import com.sulake.iid.IIDHabboModeration;

        public class HabboModerationCom extends SimpleApplication 
    {

        public static var manifest:Class = HabboHabboModerationCom_Habbomanifest_xml;
        public static var requiredClasses:Array = new Array(ModerationManagerBootstrap, IIDHabboModeration);
        public static var evidence_frame_xml:Class = HabboHabboModerationCom_evidence_frame_xml;
        public static var issue_browser_xml:Class = HabboHabboModerationCom_issue_browser_xml;
        public static var modact_summary_xml:Class = HabboHabboModerationCom_modact_summary_xml;
        public static var send_msgs_xml:Class = HabboHabboModerationCom_send_msgs_xml;
        public static var start_panel_xml:Class = HabboHabboModerationCom_start_panel_xml;
        public static var user_info_xml:Class = HabboHabboModerationCom_user_info_xml;
        public static var user_info_frame_xml:Class = HabboHabboModerationCom_user_info_frame_xml;
        public static var issue_handler_xml:Class = HabboHabboModerationCom_issue_handler_xml;
        public static var roomtool_frame_xml:Class = HabboHabboModerationCom_roomtool_frame_xml;
        public static var roomvisits_frame_xml:Class = HabboHabboModerationCom_roomvisits_frame_xml;
        public static var userclassification_frame_xml:Class = HabboHabboModerationCom_userclassification_frame_xml;
        public static var room_icon_png:Class = HabboHabboModerationCom_room_icon_png;
        public static var user_icon_png:Class = HabboHabboModerationCom_user_icon_png;


    }
}