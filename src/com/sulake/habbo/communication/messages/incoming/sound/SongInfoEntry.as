package com.sulake.habbo.communication.messages.incoming.sound
{
        public class SongInfoEntry extends PlayListEntry 
    {

        private var _data:String = "";

        public function SongInfoEntry(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:String)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            _data = _arg_5;
        }

        public function get data():String
        {
            return (_data);
        }


    }
}