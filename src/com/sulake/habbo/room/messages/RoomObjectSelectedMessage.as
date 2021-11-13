package com.sulake.habbo.room.messages
{
    public class RoomObjectSelectedMessage extends RoomObjectUpdateStateMessage 
    {

        private var _selected:Boolean;

        public function RoomObjectSelectedMessage(_arg_1:Boolean)
        {
            _selected = _arg_1;
        }

        public function get selected():Boolean
        {
            return (_selected);
        }


    }
}