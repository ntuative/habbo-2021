package com.sulake.room.utils
{
    public class RoomId 
    {

        private static const PREVIEW_ROOM_ID_BASE:int = 0x7FFF0000;


        public static function makeRoomPreviewerId(_arg_1:int):int
        {
            return ((_arg_1 & 0xFFFF) + 0x7FFF0000);
        }

        public static function isRoomPreviewerId(_arg_1:int):Boolean
        {
            return (_arg_1 >= 0x7FFF0000);
        }


    }
}