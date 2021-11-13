package com.sulake.habbo.sound.trax
{
    public class TraxChannel 
    {

        private var _SafeStr_698:int;
        private var _items:Array;

        public function TraxChannel(_arg_1:int)
        {
            _SafeStr_698 = _arg_1;
            _items = [];
        }

        public function get itemCount():int
        {
            return (_items.length);
        }

        public function addChannelItem(_arg_1:TraxChannelItem):void
        {
            _items.push(_arg_1);
        }

        public function getItem(_arg_1:int):TraxChannelItem
        {
            return (_items[_arg_1] as TraxChannelItem);
        }


    }
}

