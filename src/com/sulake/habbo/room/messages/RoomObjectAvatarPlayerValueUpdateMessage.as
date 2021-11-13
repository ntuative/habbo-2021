package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarPlayerValueUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _value:int;

        public function RoomObjectAvatarPlayerValueUpdateMessage(_arg_1:int)
        {
            _value = _arg_1;
        }

        public function get value():int
        {
            return (_value);
        }


    }
}