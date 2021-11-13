package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarDanceUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _danceStyle:int;

        public function RoomObjectAvatarDanceUpdateMessage(_arg_1:int=0)
        {
            _danceStyle = _arg_1;
        }

        public function get danceStyle():int
        {
            return (_danceStyle);
        }


    }
}