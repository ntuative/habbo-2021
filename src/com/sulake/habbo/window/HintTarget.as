package com.sulake.habbo.window
{
    import com.sulake.core.window.IWindow;

    public class HintTarget 
    {

        private var _key:String;
        private var _window:IWindow;
        private var _style:int;

        public function HintTarget(_arg_1:IWindow, _arg_2:String, _arg_3:int)
        {
            _window = _arg_1;
            _key = _arg_2;
            _style = _arg_3;
        }

        public function get window():IWindow
        {
            return (_window);
        }

        public function set window(_arg_1:IWindow):void
        {
            _window = _arg_1;
        }

        public function get key():String
        {
            return (_key);
        }

        public function set key(_arg_1:String):void
        {
            _key = _arg_1;
        }

        public function get style():int
        {
            return (_style);
        }

        public function set style(_arg_1:int):void
        {
            _style = _arg_1;
        }


    }
}