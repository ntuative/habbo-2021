package com.sulake.habbo.communication.messages.incoming.sound
{
        public class PlayListEntry 
    {

        protected var _SafeStr_1789:int;
        protected var _SafeStr_1844:int;
        protected var _songName:String;
        protected var _SafeStr_1845:String;
        private var _startPlayHeadPos:Number = 0;

        public function PlayListEntry(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:String)
        {
            _SafeStr_1789 = _arg_1;
            _SafeStr_1844 = _arg_2;
            _songName = _arg_3;
            _SafeStr_1845 = _arg_4;
        }

        public function get id():int
        {
            return (_SafeStr_1789);
        }

        public function get length():int
        {
            return (_SafeStr_1844);
        }

        public function get name():String
        {
            return (_songName);
        }

        public function get creator():String
        {
            return (_SafeStr_1845);
        }

        public function get startPlayHeadPos():Number
        {
            return (_startPlayHeadPos);
        }

        public function set startPlayHeadPos(_arg_1:Number):void
        {
            _startPlayHeadPos = _arg_1;
        }


    }
}

