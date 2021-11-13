package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionErrorMessageEvent extends RoomSessionEvent 
    {

        public static const KICKED_BY_OWNER:String = "RSEME_KICKED";
        public static const PETS_FORBIDDEN_IN_HOTEL:String = "RSEME_PETS_FORBIDDEN_IN_HOTEL";
        public static const PETS_FORBIDDEN_IN_FLAT:String = "RSEME_PETS_FORBIDDEN_IN_FLAT";
        public static const MAX_NUMBER_OF_PETS:String = "RSEME_MAX_PETS";
        public static const MAX_NUMBER_OF_OWN_PETS:String = "RSEME_MAX_NUMBER_OF_OWN_PETS";
        public static const NO_FREE_TILES_FOR_PET:String = "RSEME_NO_FREE_TILES_FOR_PET";
        public static const SELECTED_TILE_NOT_FREE_FOR_PET:String = "RSEME_SELECTED_TILE_NOT_FREE_FOR_PET";
        public static const BOTS_FORBIDDEN_IN_HOTEL:String = "RSEME_BOTS_FORBIDDEN_IN_HOTEL";
        public static const BOTS_FORBIDDEN_IN_FLAT:String = "RSEME_BOTS_FORBIDDEN_IN_FLAT";
        public static const BOT_LIMIT_REACHED:String = "RSEME_BOT_LIMIT_REACHED";
        public static const _SafeStr_3682:String = "RSEME_SELECTED_TILE_NOT_FREE_FOR_BOT";
        public static const BOT_NAME_NOT_ACCEPTED:String = "RSEME_BOT_NAME_NOT_ACCEPTED";

        private var _message:String;

        public function RoomSessionErrorMessageEvent(_arg_1:String, _arg_2:IRoomSession, _arg_3:String=null, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_4, _arg_5);
            _message = _arg_3;
        }

        public function get message():String
        {
            return (_message);
        }


    }
}

