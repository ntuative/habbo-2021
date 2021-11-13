package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarSignUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _signType:int;

        public function RoomObjectAvatarSignUpdateMessage(_arg_1:int)
        {
            _signType = _arg_1;
        }

        public function get signType():int
        {
            return (_signType);
        }


    }
}