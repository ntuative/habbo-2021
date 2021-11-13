package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetChatMessage extends RoomWidgetMessage 
    {

        public static const WIDGET_MESSAGE_CHAT:String = "RWCM_MESSAGE_CHAT";
        public static const CHAT_TYPE_SPEAK:int = 0;
        public static const CHAT_TYPE_WHISPER:int = 1;
        public static const CHAT_TYPE_SHOUT:int = 2;

        private var _chatType:int = 0;
        private var _text:String = "";
        private var _recipientName:String = "";
        private var _styleId:int;

        public function RoomWidgetChatMessage(_arg_1:String, _arg_2:String, _arg_3:int=0, _arg_4:String="", _arg_5:int=0)
        {
            super(_arg_1);
            _text = _arg_2;
            _chatType = _arg_3;
            _recipientName = _arg_4;
            _styleId = _arg_5;
        }

        public function get chatType():int
        {
            return (_chatType);
        }

        public function get text():String
        {
            return (_text);
        }

        public function get recipientName():String
        {
            return (_recipientName);
        }

        public function get styleId():int
        {
            return (_styleId);
        }


    }
}