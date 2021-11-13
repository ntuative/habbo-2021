package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarGuideStatusUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _guideStatus:int;

        public function RoomObjectAvatarGuideStatusUpdateMessage(_arg_1:int)
        {
            _guideStatus = _arg_1;
        }

        public function get guideStatus():int
        {
            return (_guideStatus);
        }


    }
}