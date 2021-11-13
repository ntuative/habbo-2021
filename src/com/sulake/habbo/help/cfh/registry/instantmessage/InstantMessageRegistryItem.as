package com.sulake.habbo.help.cfh.registry.instantmessage
{
    public class InstantMessageRegistryItem 
    {

        private var _index:int;
        private var _userId:int;
        private var _userName:String = "";
        private var _text:String = "";
        private var _chatTime:Date;
        private var _selected:Boolean;

        public function InstantMessageRegistryItem(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:String)
        {
            _index = _arg_1;
            _userId = _arg_2;
            _userName = _arg_3;
            _text = _arg_4;
            _selected = false;
            _chatTime = new Date();
        }

        public function get index():int
        {
            return (_index);
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get userName():String
        {
            return (_userName);
        }

        public function get text():String
        {
            return (_text);
        }

        public function get selected():Boolean
        {
            return (_selected);
        }

        public function set selected(_arg_1:Boolean):void
        {
            _selected = _arg_1;
        }

        public function get chatTime():Date
        {
            return (_chatTime);
        }


    }
}