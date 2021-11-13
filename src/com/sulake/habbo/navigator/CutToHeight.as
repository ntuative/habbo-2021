package com.sulake.habbo.navigator
{
    import com.sulake.core.window.components.ITextWindow;

    public class CutToHeight implements BinarySearchTest 
    {

        private var _SafeStr_1623:String;
        private var _text:ITextWindow;
        private var _SafeStr_2995:int;


        public function test(_arg_1:int):Boolean
        {
            _text.text = (_SafeStr_1623.substring(0, _arg_1) + "...");
            return (_text.textHeight > _SafeStr_2995);
        }

        public function beforeSearch(_arg_1:String, _arg_2:ITextWindow, _arg_3:int):void
        {
            _SafeStr_1623 = _arg_1;
            _text = _arg_2;
            _SafeStr_2995 = _arg_3;
        }


    }
}

