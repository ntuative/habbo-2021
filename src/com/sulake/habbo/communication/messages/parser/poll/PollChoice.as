package com.sulake.habbo.communication.messages.parser.poll
{
        public class PollChoice 
    {

        private var _value:String;
        private var _choiceText:String;
        private var _choiceType:int;

        public function PollChoice(_arg_1:String, _arg_2:String, _arg_3:int)
        {
            _value = _arg_1;
            _choiceText = _arg_2;
            _choiceType = _arg_3;
        }

        public function get value():String
        {
            return (_value);
        }

        public function set value(_arg_1:String):void
        {
            _value = _arg_1;
        }

        public function get choiceText():String
        {
            return (_choiceText);
        }

        public function set choiceText(_arg_1:String):void
        {
            _choiceText = _arg_1;
        }

        public function get choiceType():int
        {
            return (_choiceType);
        }

        public function set choiceType(_arg_1:int):void
        {
            _choiceType = _arg_1;
        }


    }
}