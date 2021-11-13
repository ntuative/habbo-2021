package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarGestureUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _gesture:int = 0;

        public function RoomObjectAvatarGestureUpdateMessage(_arg_1:int)
        {
            _gesture = _arg_1;
        }

        public function get gesture():int
        {
            return (_gesture);
        }


    }
}