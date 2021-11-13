package com.sulake.habbo.communication.messages.parser.perk
{
        public class Perk 
    {

        private var _code:String;
        private var _isAllowed:Boolean = false;
        private var _errorMessage:String = "";


        public function get code():String
        {
            return (_code);
        }

        public function set code(_arg_1:String):void
        {
            _code = _arg_1;
        }

        public function get isAllowed():Boolean
        {
            return (_isAllowed);
        }

        public function set isAllowed(_arg_1:Boolean):void
        {
            _isAllowed = _arg_1;
        }

        public function get errorMessage():String
        {
            return (_errorMessage);
        }

        public function set errorMessage(_arg_1:String):void
        {
            _errorMessage = _arg_1;
        }


    }
}