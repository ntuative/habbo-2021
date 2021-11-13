package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarTypingUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _isTyping:Boolean;

        public function RoomObjectAvatarTypingUpdateMessage(_arg_1:Boolean=false)
        {
            _isTyping = _arg_1;
        }

        public function get isTyping():Boolean
        {
            return (_isTyping);
        }


    }
}