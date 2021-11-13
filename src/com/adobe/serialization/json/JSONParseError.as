package com.adobe.serialization.json
{
    public class JSONParseError extends Error
    {

        private var _location:int;
        private var _text:String;

        public function JSONParseError(_arg_1:String="", _arg_2:int=0, _arg_3:String="")
        {
            super(_arg_1);
            name = "JSONParseError";
            _location = _arg_2;
            _text = _arg_3;
        }

        public function get location():int
        {
            return (_location);
        }

        public function get text():String
        {
            return (_text);
        }


    }
}
