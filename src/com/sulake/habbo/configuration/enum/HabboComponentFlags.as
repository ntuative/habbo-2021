package com.sulake.habbo.configuration.enum
{
    public class HabboComponentFlags 
    {

        public static const ROOM_VIEWER_MODE:int = 1;


        public static function isRoomViewerMode(_arg_1:int):Boolean
        {
            return (!((_arg_1 & 0x01) == 0));
        }


    }
}