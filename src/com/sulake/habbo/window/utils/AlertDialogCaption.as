package com.sulake.habbo.window.utils
{
    public class AlertDialogCaption implements ICaption 
    {

        private var _text:String;
        private var _toolTip:String;
        private var _visible:Boolean;

        public function AlertDialogCaption(_arg_1:String, _arg_2:String, _arg_3:Boolean)
        {
            _text = _arg_1;
            _toolTip = _arg_2;
            _visible = _arg_3;
        }

        public function get text():String
        {
            return (_text);
        }

        public function set text(_arg_1:String):void
        {
            _text = _arg_1;
        }

        public function get toolTip():String
        {
            return (_toolTip);
        }

        public function set toolTip(_arg_1:String):void
        {
            _toolTip = _arg_1;
        }

        public function get visible():Boolean
        {
            return (_visible);
        }

        public function set visible(_arg_1:Boolean):void
        {
            _visible = _arg_1;
        }


    }
}