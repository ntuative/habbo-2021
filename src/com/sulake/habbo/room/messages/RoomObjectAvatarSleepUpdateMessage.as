package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarSleepUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _isSleeping:Boolean;

        public function RoomObjectAvatarSleepUpdateMessage(_arg_1:Boolean=false)
        {
            _isSleeping = _arg_1;
        }

        public function get isSleeping():Boolean
        {
            return (_isSleeping);
        }


    }
}