package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarPetGestureUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _gesture:String;

        public function RoomObjectAvatarPetGestureUpdateMessage(_arg_1:String)
        {
            _gesture = _arg_1;
        }

        public function get gesture():String
        {
            return (_gesture);
        }


    }
}