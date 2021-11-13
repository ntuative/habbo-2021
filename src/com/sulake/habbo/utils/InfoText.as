package com.sulake.habbo.utils
{
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.events.WindowEvent;

    public class InfoText 
    {

        private var _input:ITextFieldWindow;
        private var _includeInfo:Boolean;
        private var _SafeStr_2469:String = "";

        public function InfoText(_arg_1:ITextFieldWindow, _arg_2:String=null)
        {
            _input = _arg_1;
            if (_arg_2 != null)
            {
                _includeInfo = true;
                _SafeStr_2469 = _arg_2;
                _input.text = _arg_2;
            };
            _input.addEventListener("WE_FOCUSED", onFocus);
        }

        public function dispose():void
        {
            if (_input)
            {
                _input.dispose();
                _input = null;
            };
        }

        public function goBackToInitialState():void
        {
            _input.text = _SafeStr_2469;
            _includeInfo = true;
        }

        public function getText():String
        {
            return ((_includeInfo) ? "" : _input.text);
        }

        public function setText(_arg_1:String):void
        {
            _includeInfo = false;
            _input.text = _arg_1;
        }

        public function get input():ITextFieldWindow
        {
            return (_input);
        }

        private function onFocus(_arg_1:WindowEvent):void
        {
            if (!_includeInfo)
            {
                return;
            };
            _input.text = "";
            _includeInfo = false;
        }


    }
}

