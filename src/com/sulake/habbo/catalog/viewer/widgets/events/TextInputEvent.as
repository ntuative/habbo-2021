package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class TextInputEvent extends Event 
    {

        private var _text:String;

        public function TextInputEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super("TEXT_INPUT", _arg_2, _arg_3);
            _text = _arg_1;
        }

        public function get text():String
        {
            return (_text);
        }


    }
}