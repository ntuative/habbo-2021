package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetGetObjectLocationMessage extends RoomWidgetMessage 
    {

        public static const _SafeStr_4194:String = "RWGOI_MESSAGE_GET_OBJECT_LOCATION";
        public static const _SafeStr_4195:String = "RWGOI_MESSAGE_GET_GAME_OBJECT_LOCATION";

        private var _objectId:int;
        private var _objectType:int;

        public function RoomWidgetGetObjectLocationMessage(_arg_1:String, _arg_2:int, _arg_3:int)
        {
            super(_arg_1);
            _objectId = _arg_2;
            _objectType = _arg_3;
        }

        public function get objectId():int
        {
            return (_objectId);
        }

        public function get objectType():int
        {
            return (_objectType);
        }


    }
}

