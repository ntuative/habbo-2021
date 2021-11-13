package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarPostureUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _postureType:String;
        private var _parameter:String;

        public function RoomObjectAvatarPostureUpdateMessage(_arg_1:String, _arg_2:String="")
        {
            _postureType = _arg_1;
            _parameter = _arg_2;
        }

        public function get postureType():String
        {
            return (_postureType);
        }

        public function get parameter():String
        {
            return (_parameter);
        }


    }
}