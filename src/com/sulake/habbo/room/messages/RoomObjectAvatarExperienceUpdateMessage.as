package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarExperienceUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _gainedExperience:int;

        public function RoomObjectAvatarExperienceUpdateMessage(_arg_1:int)
        {
            _gainedExperience = _arg_1;
        }

        public function get gainedExperience():int
        {
            return (_gainedExperience);
        }


    }
}