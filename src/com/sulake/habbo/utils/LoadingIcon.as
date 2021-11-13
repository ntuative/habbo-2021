package com.sulake.habbo.utils
{
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.Timer;
    import com.sulake.core.window.components.IIconWindow;
    import flash.events.Event;

    public class LoadingIcon implements IDisposable 
    {

        private static const FRAMES:Array = [23, 24, 25, 26];

        private var _SafeStr_1163:Timer = new Timer(160);
        private var _icon:IIconWindow;
        private var _SafeStr_4365:int;

        public function LoadingIcon()
        {
            _SafeStr_1163.addEventListener("timer", onTimer);
        }

        public function dispose():void
        {
            if (_SafeStr_1163)
            {
                _SafeStr_1163.removeEventListener("timer", onTimer);
                _SafeStr_1163.stop();
                _SafeStr_1163 = null;
            };
            _icon = null;
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_1163 == null);
        }

        public function setVisible(_arg_1:IIconWindow, _arg_2:Boolean):void
        {
            _icon = _arg_1;
            _icon.visible = _arg_2;
            if (_arg_2)
            {
                _icon.style = FRAMES[_SafeStr_4365];
                _SafeStr_1163.start();
            }
            else
            {
                _SafeStr_1163.stop();
            };
        }

        private function onTimer(_arg_1:Event):void
        {
            if (_icon == null)
            {
                return;
            };
            _SafeStr_4365++;
            if (_SafeStr_4365 >= FRAMES.length)
            {
                _SafeStr_4365 = 0;
            };
            _icon.style = FRAMES[_SafeStr_4365];
        }


    }
}

