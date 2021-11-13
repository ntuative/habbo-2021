package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarMutedUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _isMuted:Boolean;

        public function RoomObjectAvatarMutedUpdateMessage(_arg_1:Boolean=false)
        {
            _isMuted = _arg_1;
        }

        public function get isMuted():Boolean
        {
            return (_isMuted);
        }


    }
}