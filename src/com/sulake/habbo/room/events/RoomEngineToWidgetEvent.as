package com.sulake.habbo.room.events
{
    public class RoomEngineToWidgetEvent extends RoomEngineObjectEvent 
    {

        public static const REQUEST_OPEN_WIDGET:String = "RETWE_OPEN_WIDGET";
        public static const REQUEST_CLOSE_WIDGET:String = "RETWE_CLOSE_WIDGET";
        public static const REQUEST_OPEN_FURNI_CONTEXT_MENU:String = "RETWE_OPEN_FURNI_CONTEXT_MENU";
        public static const REQUEST_CLOSE_FURNI_CONTEXT_MENU:String = "RETWE_CLOSE_FURNI_CONTEXT_MENU";
        public static const REQUEST_PLACEHOLDER:String = "RETWE_REQUEST_PLACEHOLDER";
        public static const REQUEST_CREDITFURNI:String = "RETWE_REQUEST_CREDITFURNI";
        public static const REQUEST_STICKIE:String = "RETWE_REQUEST_STICKIE";
        public static const REQUEST_PRESENT:String = "RETWE_REQUEST_PRESENT";
        public static const REQUEST_TROPHY:String = "RETWE_REQUEST_TROPHY";
        public static const REQUEST_TEASER:String = "RETWE_REQUEST_TEASER";
        public static const REQUEST_ECOTRONBOX:String = "RETWE_REQUEST_ECOTRONBOX";
        public static const REQUEST_DIMMER:String = "RETWE_REQUEST_DIMMER";
        public static const REMOVE_DIMMER:String = "RETWE_REMOVE_DIMMER";
        public static const REQUEST_CLOTHING_CHANGE:String = "RETWE_REQUEST_CLOTHING_CHANGE";
        public static const REQUEST_PLAYLIST_EDITOR:String = "RETWE_REQUEST_PLAYLIST_EDITOR";
        public static const REQUEST_MANNEQUIN:String = "RETWE_REQUEST_MANNEQUIN";
        public static const REQUEST_MONSTERPLANT_SEED_PLANT_CONFIRMATION_DIALOG:String = "ROWRE_REQUEST_MONSTERPLANT_SEED_PLANT_CONFIRMATION_DIALOG";
        public static const REQUEST_PURCHASABLE_CLOTHING_CONFIRMATION_DIALOG:String = "ROWRE_REQUEST_PURCHASABLE_CLOTHING_CONFIRMATION_DIALOG";
        public static const REQUEST_BACKGROUND_COLOR:String = "RETWE_REQUEST_BACKGROUND_COLOR";
        public static const REQUEST_MYSTERYBOX_OPEN_DIALOG:String = "RETWE_REQUEST_MYSTERYBOX_OPEN_DIALOG";
        public static const REQUEST_EFFECTBOX_OPEN_DIALOG:String = "RETWE_REQUEST_EFFECTBOX_OPEN_DIALOG";
        public static const REQUEST_MYSTERYTROPHY_OPEN_DIALOG:String = "RETWE_REQUEST_MYSTERYTROPHY_OPEN_DIALOG";
        public static const REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING:String = "RETWE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING";
        public static const REQUEST_ACHIEVEMENT_RESOLUTION_FAILED:String = "RETWE_REQUEST_ACHIEVEMENT_RESOLUTION_FAILED";
        public static const REQUEST_FRIEND_FURNITURE_CONFIRM:String = "RETWE_REQUEST_FRIEND_FURNITURE_CONFIRM";
        public static const REQUEST_FRIEND_FURNITURE_ENGRAVING:String = "RETWE_REQUEST_FRIEND_FURNITURE_ENGRAVING";
        public static const REQUEST_BADGE_DISPLAY_ENGRAVING:String = "RETWE_REQUEST_BADGE_DISPLAY_ENGRAVING";
        public static const REQUEST_HIGH_SCORE_DISPLAY:String = "RETWE_REQUEST_HIGH_SCORE_DISPLAY";
        public static const REQUEST_HIDE_HIGH_SCORE_DISPLAY:String = "RETWE_REQUEST_HIDE_HIGH_SCORE_DISPLAY";
        public static const REQUEST_INTERNAL_LINK:String = "RETWE_REQUEST_INTERNAL_LINK";
        public static const REQUEST_ROOM_LINK:String = "RETWE_REQUEST_ROOM_LINK";

        private var _contextMenu:String;

        public function RoomEngineToWidgetEvent(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:String=null, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_6, _arg_7);
            _contextMenu = _arg_5;
        }

        public function get widget():String
        {
            return (_contextMenu);
        }

        public function get contextMenu():String
        {
            return (_contextMenu);
        }


    }
}