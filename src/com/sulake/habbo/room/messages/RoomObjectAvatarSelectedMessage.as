package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarSelectedMessage extends RoomObjectUpdateStateMessage 
    {

        private var _selected:Boolean;

        public function RoomObjectAvatarSelectedMessage(_arg_1:Boolean)
        {
            _selected = _arg_1;
        }

        public function get selected():Boolean
        {
            return (_selected);
        }


    }
}