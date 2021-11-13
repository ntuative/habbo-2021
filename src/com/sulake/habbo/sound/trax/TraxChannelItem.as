package com.sulake.habbo.sound.trax
{
    public class TraxChannelItem 
    {

        private var _id:int;
        private var _length:int;

        public function TraxChannelItem(_arg_1:int, _arg_2:int)
        {
            _id = _arg_1;
            _length = _arg_2;
        }

        public function get id():int
        {
            return (_id);
        }

        public function get length():int
        {
            return (_length);
        }


    }
}