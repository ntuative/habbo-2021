package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboGroupsManagerBootstrap;
    import com.sulake.iid.IIDHabboGroupsManager;

        public class HabboGroupsCom extends SimpleApplication 
    {

        public static var manifest:Class = HabboHabboGroupsCom_Habbomanifest_xml;
        public static var group:Class = HabboHabboGroupsCom_Habbogroup_xml;
        public static var guild_members_window:Class = HabboHabboGroupsCom_Habboguild_members_window_xml;
        public static var group_entry:Class = HabboHabboGroupsCom_Habbogroup_entry_xml;
        public static var member_entry:Class = HabboHabboGroupsCom_Habbomember_entry_xml;
        public static var group_info_window:Class = HabboHabboGroupsCom_Habbogroup_info_window_xml;
        public static var group_management_window:Class = HabboHabboGroupsCom_Habbogroup_management_window_xml;
        public static var new_extended_profile:Class = HabboHabboGroupsCom_Habbonew_extended_profile_xml;
        public static var club_required:Class = HabboHabboGroupsCom_Habboclub_required_xml;
        public static var group_created_window:Class = HabboHabboGroupsCom_Habbogroup_created_window_xml;
        public static var group_room_info:Class = HabboHabboGroupsCom_Habbogroup_room_info_xml;
        public static var no_groups:Class = HabboHabboGroupsCom_Habbono_groups_xml;
        public static var badge_color_item:Class = HabboHabboGroupsCom_Habbobadge_color_item_xml;
        public static var badge_editor:Class = HabboHabboGroupsCom_Habbobadge_editor_xml;
        public static var badge_layer:Class = HabboHabboGroupsCom_Habbobadge_layer_xml;
        public static var badge_part_item:Class = HabboHabboGroupsCom_Habbobadge_part_item_xml;
        public static var color_chooser_bg:Class = HabboHabboGroupsCom_Habbocolor_chooser_bg_png;
        public static var color_chooser_fg:Class = HabboHabboGroupsCom_Habbocolor_chooser_fg_png;
        public static var color_chooser_selected:Class = HabboHabboGroupsCom_Habbocolor_chooser_selected_png;
        public static var part_preview_bg:Class = HabboHabboGroupsCom_Habbopart_preview_bg_png;
        public static var position_grid:Class = HabboHabboGroupsCom_Habboposition_grid_png;
        public static var position_picker:Class = HabboHabboGroupsCom_Habboposition_picker_png;
        public static var badge_part_add:Class = HabboHabboGroupsCom_Habbobadge_part_add_png;
        public static var badge_part_empty:Class = HabboHabboGroupsCom_Habbobadge_part_empty_png;
        public static var badge_part_picker:Class = HabboHabboGroupsCom_Habbobadge_part_picker_png;
        public static var requiredClasses:Array = new Array(HabboGroupsManagerBootstrap, IIDHabboGroupsManager);


    }
}