package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetChatTypingMessage extends RoomWidgetMessage 
    {

        public static const TYPING_STATUS:String = "RWCTM_TYPING_STATUS";

        private var _isTyping:Boolean;

        public function RoomWidgetChatTypingMessage(_arg_1:Boolean)
        {
            super("RWCTM_TYPING_STATUS");
            _isTyping = _arg_1;
        }

        public function get isTyping():Boolean
        {
            return (_isTyping);
        }


    }
}