package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetRoomObjectMessage extends RoomWidgetMessage 
    {

        public static const GET_OBJECT_INFO:String = "RWROM_GET_OBJECT_INFO";
        public static const GET_OBJECT_NAME:String = "RWROM_GET_OBJECT_NAME";
        public static const _SafeStr_4202:String = "RWROM_SELECT_OBJECT";
        public static const GET_OWN_CHARACTER_INFO:String = "RWROM_GET_OWN_CHARACTER_INFO";
        public static const GET_AVATAR_LIST:String = "RWROM_GET_AVATAR_LIST";

        private var _id:int = 0;
        private var _category:int = 0;

        public function RoomWidgetRoomObjectMessage(_arg_1:String, _arg_2:int, _arg_3:int)
        {
            super(_arg_1);
            _id = _arg_2;
            _category = _arg_3;
        }

        public function get id():int
        {
            return (_id);
        }

        public function get category():int
        {
            return (_category);
        }


    }
}

