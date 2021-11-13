package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboGameManagerBootstrap;
    import com.sulake.iid.IIDHabboGameManager;

        public class HabboGamesCom extends SimpleApplication 
    {

        private static var _logEnabled:Boolean = true;

        public static var manifest:Class = HabboHabboGamesCom_Habbomanifest_xml;
        public static const explosion0001:Class = HabboHabboGamesCom_Habboexplosion0001_png;
        public static const explosion0002:Class = HabboHabboGamesCom_Habboexplosion0002_png;
        public static const explosion0003:Class = HabboHabboGamesCom_Habboexplosion0003_png;
        public static const explosion0004:Class = HabboHabboGamesCom_Habboexplosion0004_png;
        public static const explosion0005:Class = HabboHabboGamesCom_Habboexplosion0005_png;
        public static const explosion0006:Class = HabboHabboGamesCom_Habboexplosion0006_png;
        public static const explosion0007:Class = HabboHabboGamesCom_Habboexplosion0007_png;
        public static const explosion0008:Class = HabboHabboGamesCom_Habboexplosion0008_png;
        public static const explosion0009:Class = HabboHabboGamesCom_Habboexplosion0009_png;
        public static const explosion0010:Class = HabboHabboGamesCom_Habboexplosion0010_png;
        public static const explosion0011:Class = HabboHabboGamesCom_Habboexplosion0011_png;
        public static const explosion0012:Class = HabboHabboGamesCom_Habboexplosion0012_png;
        public static const hc_icon:Class = HabboHabboGamesCom_Habbohc_icon_png;
        public static const btn_more_games_10:Class = HabboHabboGamesCom_Habbobtn_more_games_10_png;
        public static const btn_more_games_10_hi:Class = HabboHabboGamesCom_Habbobtn_more_games_10_hi_png;
        public static const btn_more_games_100:Class = HabboHabboGamesCom_Habbobtn_more_games_100_png;
        public static const btn_more_games_100_hi:Class = HabboHabboGamesCom_Habbobtn_more_games_100_hi_png;
        public static const btn_more_games_300:Class = HabboHabboGamesCom_Habbobtn_more_games_300_png;
        public static const btn_more_games_300_hi:Class = HabboHabboGamesCom_Habbobtn_more_games_300_hi_png;
        public static const bg_sky:Class = HabboHabboGamesCom_Habbobg_sky_png;
        public static const bg_sunshine:Class = HabboHabboGamesCom_Habbobg_sunshine_png;
        public static const bg_vista_1:Class = HabboHabboGamesCom_Habbobg_vista_1_png;
        public static const bg_vista_2:Class = HabboHabboGamesCom_Habbobg_vista_2_png;
        public static const bg_vista_3:Class = HabboHabboGamesCom_Habbobg_vista_3_png;
        public static const blue_ball:Class = HabboHabboGamesCom_Habboblue_ball_png;
        public static const blue_ball_rematch:Class = HabboHabboGamesCom_Habboblue_ball_rematch_png;
        public static const blue_glove:Class = HabboHabboGamesCom_Habboblue_glove_png;
        public static const blue_infobox:Class = HabboHabboGamesCom_Habboblue_infobox_png;
        public static const blue_square:Class = HabboHabboGamesCom_Habboblue_square_png;
        public static const gray_ball:Class = HabboHabboGamesCom_Habbogray_ball_png;
        public static const gray_infobox:Class = HabboHabboGamesCom_Habbogray_infobox_png;
        public static const gray_square:Class = HabboHabboGamesCom_Habbogray_square_png;
        public static const green_square:Class = HabboHabboGamesCom_Habbogreen_square_png;
        public static const load_1:Class = HabboHabboGamesCom_Habboload_1_png;
        public static const load_2:Class = HabboHabboGamesCom_Habboload_2_png;
        public static const load_3:Class = HabboHabboGamesCom_Habboload_3_png;
        public static const load_4:Class = HabboHabboGamesCom_Habboload_4_png;
        public static const load_5:Class = HabboHabboGamesCom_Habboload_5_png;
        public static const load_6:Class = HabboHabboGamesCom_Habboload_6_png;
        public static const load_7:Class = HabboHabboGamesCom_Habboload_7_png;
        public static const load_8:Class = HabboHabboGamesCom_Habboload_8_png;
        public static const red_ball:Class = HabboHabboGamesCom_Habbored_ball_png;
        public static const red_ball_rematch:Class = HabboHabboGamesCom_Habbored_ball_rematch_png;
        public static const red_glove:Class = HabboHabboGamesCom_Habbored_glove_png;
        public static const red_infobox:Class = HabboHabboGamesCom_Habbored_infobox_png;
        public static const red_square:Class = HabboHabboGamesCom_Habbored_square_png;
        public static const snowstorm_logo:Class = HabboHabboGamesCom_Habbosnowstorm_logo_png;
        public static const ui_ball_indicator_bg:Class = HabboHabboGamesCom_Habboui_ball_indicator_bg_png;
        public static const ui_ball:Class = HabboHabboGamesCom_Habboui_ball_png;
        public static const ui_exit_down:Class = HabboHabboGamesCom_Habboui_exit_down_png;
        public static const ui_exit_up:Class = HabboHabboGamesCom_Habboui_exit_up_png;
        public static const ui_make_balls_down:Class = HabboHabboGamesCom_Habboui_make_balls_down_png;
        public static const ui_make_balls_up:Class = HabboHabboGamesCom_Habboui_make_balls_up_png;
        public static const ui_me_bg:Class = HabboHabboGamesCom_Habboui_me_bg_png;
        public static const rematch_1:Class = HabboHabboGamesCom_Habborematch_1_png;
        public static const rematch_2:Class = HabboHabboGamesCom_Habborematch_2_png;
        public static const rematch_3:Class = HabboHabboGamesCom_Habborematch_3_png;
        public static const rematch_4:Class = HabboHabboGamesCom_Habborematch_4_png;
        public static const rematch_5:Class = HabboHabboGamesCom_Habborematch_5_png;
        public static const rematch_6:Class = HabboHabboGamesCom_Habborematch_6_png;
        public static const ui_me_health_0:Class = HabboHabboGamesCom_Habboui_me_health_0_png;
        public static const ui_me_health_1:Class = HabboHabboGamesCom_Habboui_me_health_1_png;
        public static const ui_me_health_2:Class = HabboHabboGamesCom_Habboui_me_health_2_png;
        public static const ui_me_health_3:Class = HabboHabboGamesCom_Habboui_me_health_3_png;
        public static const ui_me_health_4:Class = HabboHabboGamesCom_Habboui_me_health_4_png;
        public static const ui_me_health_5:Class = HabboHabboGamesCom_Habboui_me_health_5_png;
        public static const ui_me_minus_1:Class = HabboHabboGamesCom_Habboui_me_minus_1_png;
        public static const ui_me_minus_2:Class = HabboHabboGamesCom_Habboui_me_minus_2_png;
        public static const ui_me_minus_3:Class = HabboHabboGamesCom_Habboui_me_minus_3_png;
        public static const ui_me_minus_4:Class = HabboHabboGamesCom_Habboui_me_minus_4_png;
        public static const ui_me_plus_1:Class = HabboHabboGamesCom_Habboui_me_plus_1_png;
        public static const ui_me_plus_2:Class = HabboHabboGamesCom_Habboui_me_plus_2_png;
        public static const ui_me_plus_3:Class = HabboHabboGamesCom_Habboui_me_plus_3_png;
        public static const ui_me_plus_4:Class = HabboHabboGamesCom_Habboui_me_plus_4_png;
        public static const ui_no_balls_1:Class = HabboHabboGamesCom_Habboui_no_balls_1_png;
        public static const ui_no_balls_2:Class = HabboHabboGamesCom_Habboui_no_balls_2_png;
        public static const ui_no_balls_3:Class = HabboHabboGamesCom_Habboui_no_balls_3_png;
        public static const ui_no_balls_4:Class = HabboHabboGamesCom_Habboui_no_balls_4_png;
        public static const ui_timer_and_points:Class = HabboHabboGamesCom_Habboui_timer_and_points_png;
        public static const arena_8_preview:Class = HabboHabboGamesCom_Habboarena_8_preview_png;
        public static const arena_9_preview:Class = HabboHabboGamesCom_Habboarena_9_preview_png;
        public static const arena_10_preview:Class = HabboHabboGamesCom_Habboarena_10_preview_png;
        public static const arena_11_preview:Class = HabboHabboGamesCom_Habboarena_11_preview_png;
        public static const arena_12_preview:Class = HabboHabboGamesCom_Habboarena_12_preview_png;
        public static const star_empty:Class = HabboHabboGamesCom_Habbostar_empty_png;
        public static const star_filled_bronze:Class = HabboHabboGamesCom_Habbostar_filled_bronze_png;
        public static const star_filled_silver:Class = HabboHabboGamesCom_Habbostar_filled_silver_png;
        public static const star_filled_gold:Class = HabboHabboGamesCom_Habbostar_filled_gold_png;
        public static const quick_play_background:Class = HabboHabboGamesCom_Habboquick_play_background_png;
        public static const quick_play_instructions:Class = HabboHabboGamesCom_Habboquick_play_instructions_png;
        public static const quick_play_teaser:Class = HabboHabboGamesCom_Habboquick_play_teaser_png;
        public static const free_games_bg:Class = HabboHabboGamesCom_Habbofree_games_bg_png;
        public static const leaderboard_bg:Class = HabboHabboGamesCom_Habboleaderboard_bg_png;
        public static const leaderboard_divider:Class = HabboHabboGamesCom_Habboleaderboard_divider_png;
        public static const leaderboard_highlighter:Class = HabboHabboGamesCom_Habboleaderboard_highlighter_png;
        public static const left_black:Class = HabboHabboGamesCom_Habboleft_black_png;
        public static const left_blue:Class = HabboHabboGamesCom_Habboleft_blue_png;
        public static const right_black:Class = HabboHabboGamesCom_Habboright_black_png;
        public static const right_blue:Class = HabboHabboGamesCom_Habboright_blue_png;
        public static const add_friend_icon_blue:Class = HabboHabboGamesCom_Habboadd_friend_icon_blue_png;
        public static const add_friend_icon_red:Class = HabboHabboGamesCom_Habboadd_friend_icon_red_png;
        public static const add_friend_icon_green:Class = HabboHabboGamesCom_Habboadd_friend_icon_green_png;
        public static const scroll_down_normal:Class = HabboHabboGamesCom_Habboscroll_down_normal_png;
        public static const scroll_down_click:Class = HabboHabboGamesCom_Habboscroll_down_click_png;
        public static const scroll_down_hilite:Class = HabboHabboGamesCom_Habboscroll_down_hilite_png;
        public static const scroll_down_inactive:Class = HabboHabboGamesCom_Habboscroll_down_inactive_png;
        public static const scroll_up_normal:Class = HabboHabboGamesCom_Habboscroll_up_normal_png;
        public static const scroll_up_click:Class = HabboHabboGamesCom_Habboscroll_up_click_png;
        public static const scroll_up_hilite:Class = HabboHabboGamesCom_Habboscroll_up_hilite_png;
        public static const scroll_up_inactive:Class = HabboHabboGamesCom_Habboscroll_up_inactive_png;
        public static const scroll_left:Class = HabboHabboGamesCom_Habboscroll_left_png;
        public static const scroll_right:Class = HabboHabboGamesCom_Habboscroll_right_png;
        public static const throw_1_1:Class = HabboHabboGamesCom_Habbothrow_1_1_png;
        public static const throw_1_2:Class = HabboHabboGamesCom_Habbothrow_1_2_png;
        public static const throw_1_3:Class = HabboHabboGamesCom_Habbothrow_1_3_png;
        public static const throw_1_4:Class = HabboHabboGamesCom_Habbothrow_1_4_png;
        public static const throw_2_1:Class = HabboHabboGamesCom_Habbothrow_2_1_png;
        public static const throw_2_2:Class = HabboHabboGamesCom_Habbothrow_2_2_png;
        public static const throw_2_3:Class = HabboHabboGamesCom_Habbothrow_2_3_png;
        public static const throw_2_4:Class = HabboHabboGamesCom_Habbothrow_2_4_png;
        public static const throw_2_5:Class = HabboHabboGamesCom_Habbothrow_2_5_png;
        public static const throw_3_1:Class = HabboHabboGamesCom_Habbothrow_3_1_png;
        public static const throw_3_2:Class = HabboHabboGamesCom_Habbothrow_3_2_png;
        public static const throw_3_3:Class = HabboHabboGamesCom_Habbothrow_3_3_png;
        public static const throw_3_4:Class = HabboHabboGamesCom_Habbothrow_3_4_png;
        public static const throw_3_5:Class = HabboHabboGamesCom_Habbothrow_3_5_png;
        public static const balls_1:Class = HabboHabboGamesCom_Habboballs_1_png;
        public static const balls_2:Class = HabboHabboGamesCom_Habboballs_2_png;
        public static const balls_3:Class = HabboHabboGamesCom_Habboballs_3_png;
        public static const balls_4:Class = HabboHabboGamesCom_Habboballs_4_png;
        public static const balls_5:Class = HabboHabboGamesCom_Habboballs_5_png;
        public static const move_1:Class = HabboHabboGamesCom_Habbomove_1_png;
        public static const move_2:Class = HabboHabboGamesCom_Habbomove_2_png;
        public static const move_3:Class = HabboHabboGamesCom_Habbomove_3_png;
        public static const move_4:Class = HabboHabboGamesCom_Habbomove_4_png;
        public static const pagination_ball:Class = HabboHabboGamesCom_Habbopagination_ball_png;
        public static const pagination_ball_hilite:Class = HabboHabboGamesCom_Habbopagination_ball_hilite_png;
        public static const games_main:Class = HabboHabboGamesCom_Habbogames_main_xml;
        public static const instructions_list_item:Class = HabboHabboGamesCom_Habboinstructions_list_item_xml;
        public static const counter:Class = HabboHabboGamesCom_Habbocounter_xml;
        public static const figure:Class = HabboHabboGamesCom_Habbofigure_xml;
        public static const snowwar_ending:Class = HabboHabboGamesCom_Habbosnowwar_ending_xml;
        public static const snowwar_exit:Class = HabboHabboGamesCom_Habbosnowwar_exit_xml;
        public static const snowwar_lobby_player:Class = HabboHabboGamesCom_Habbosnowwar_lobby_player_xml;
        public static const snowwar_lobby_player_team_1:Class = HabboHabboGamesCom_Habbosnowwar_lobby_player_team_1_xml;
        public static const snowwar_lobby_player_team_2:Class = HabboHabboGamesCom_Habbosnowwar_lobby_player_team_2_xml;
        public static const snowwar_results_player_team_1:Class = HabboHabboGamesCom_Habbosnowwar_results_player_team_1_xml;
        public static const snowwar_results_player_team_2:Class = HabboHabboGamesCom_Habbosnowwar_results_player_team_2_xml;
        public static const snowwar_own_stats:Class = HabboHabboGamesCom_Habbosnowwar_own_stats_xml;
        public static const snowwar_snowballs:Class = HabboHabboGamesCom_Habbosnowwar_snowballs_xml;
        public static const snowwar_team_scores:Class = HabboHabboGamesCom_Habbosnowwar_team_scores_xml;
        public static const snowwar_timer:Class = HabboHabboGamesCom_Habbosnowwar_timer_xml;
        public static var snowwar_loading_background_xml:Class = HabboHabboGamesCom_snowwar_loading_background_xml;
        public static var snowwar_exit_confirmation:Class = HabboHabboGamesCom_Habbosnowwar_exit_confirmation_xml;
        public static var snowwar_leaderboard:Class = HabboHabboGamesCom_Habbosnowwar_leaderboard_xml;
        public static var snowwar_leaderboard_entry:Class = HabboHabboGamesCom_Habbosnowwar_leaderboard_entry_xml;
        public static var requiredClasses:Array = new Array(HabboGameManagerBootstrap, IIDHabboGameManager);


        public static function set logEnabled(_arg_1:Boolean):void
        {
            _logEnabled = _arg_1;
        }

        public static function get logEnabled():Boolean
        {
            return (false);
        }

        public static function log(... _args):void
        {
        }


    }
}