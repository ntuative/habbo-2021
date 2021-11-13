package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetStickieSendUpdateMessage extends RoomWidgetMessage 
    {

        public static const _SafeStr_4208:String = "RWSUM_STICKIE_SEND_UPDATE";
        public static const _SafeStr_4209:String = "RWSUM_STICKIE_SEND_DELETE";

        private var _objectId:int;
        private var _text:String;
        private var _colorHex:String;

        public function RoomWidgetStickieSendUpdateMessage(_arg_1:String, _arg_2:int, _arg_3:String="", _arg_4:String="")
        {
            super(_arg_1);
            _objectId = _arg_2;
            _text = _arg_3;
            _colorHex = _arg_4;
        }

        public function get objectId():int
        {
            return (_objectId);
        }

        public function get text():String
        {
            return (_text);
        }

        public function get colorHex():String
        {
            return (_colorHex);
        }


    }
}

