package com.sulake.habbo.session.enum
{
    public class RoomTradingLevelEnum 
    {

        public static const NO_TRADING:int = 0;
        public static const ROOM_CONTROLLER_REQUIRED:int = 1;
        public static const FREE_TRADING:int = 2;


        public static function getLocalizationKey(_arg_1:int):String
        {
            switch (_arg_1)
            {
                case 2:
                    return ("${trading.mode.free}");
                case 1:
                    return ("${trading.mode.controller}");
                case 0:
                    return ("${trading.mode.not.allowed}");
                default:
                    return ("");
            };
        }


    }
}