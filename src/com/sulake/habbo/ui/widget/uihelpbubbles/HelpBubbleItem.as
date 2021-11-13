package com.sulake.habbo.ui.widget.uihelpbubbles
{
    public class HelpBubbleItem 
    {

        private var _name:String;
        private var _text:String;
        private var _icon:String;
        private var _modal:Boolean;


        public function get text():String
        {
            return (_text);
        }

        public function set text(_arg_1:String):void
        {
            _text = _arg_1;
        }

        public function get name():String
        {
            return (_name);
        }

        public function set name(_arg_1:String):void
        {
            _name = _arg_1;
        }

        public function get icon():String
        {
            return (_icon);
        }

        public function set icon(_arg_1:String):void
        {
            _icon = _arg_1;
        }

        public function get modal():Boolean
        {
            return (_modal);
        }

        public function set modal(_arg_1:Boolean):void
        {
            _modal = _arg_1;
        }


    }
}