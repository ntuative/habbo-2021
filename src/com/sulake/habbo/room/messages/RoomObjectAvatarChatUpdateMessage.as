package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarChatUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _numberOfWords:int;

        public function RoomObjectAvatarChatUpdateMessage(_arg_1:int)
        {
            _numberOfWords = _arg_1;
        }

        public function get numberOfWords():int
        {
            return (_numberOfWords);
        }


    }
}