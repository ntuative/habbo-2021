package com.sulake.core.window.services
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindow;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class GestureAgentService implements IGestureAgentService, IDisposable 
    {

        private var _disposed:Boolean = false;
        protected var _SafeStr_1162:Boolean;
        protected var _window:IWindow;
        protected var _SafeStr_1163:Timer;
        protected var _SafeStr_852:uint = 0;
        protected var _callback:Function;
        protected var _SafeStr_1145:int;
        protected var _SafeStr_1146:int;


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            end(_window);
            _disposed = true;
        }

        public function begin(_arg_1:IWindow, _arg_2:Function, _arg_3:uint, _arg_4:int, _arg_5:int):IWindow
        {
            _SafeStr_852 = _arg_3;
            var _local_6:IWindow = _window;
            if (_window != null)
            {
                end(_window);
            };
            if (((_arg_1) && (!(_arg_1.disposed))))
            {
                _window = _arg_1;
                _window.addEventListener("WE_DESTROYED", clientWindowDestroyed);
                _callback = _arg_2;
                _SafeStr_1162 = true;
                _SafeStr_1145 = _arg_4;
                _SafeStr_1146 = _arg_5;
                _SafeStr_1163 = new Timer(40, 0);
                _SafeStr_1163.addEventListener("timer", operate);
                _SafeStr_1163.start();
            };
            return (_local_6);
        }

        protected function operate(_arg_1:TimerEvent):void
        {
            _SafeStr_1145 = (_SafeStr_1145 * 0.75);
            _SafeStr_1146 = (_SafeStr_1146 * 0.75);
            if (((Math.abs(_SafeStr_1145) <= 1) && (Math.abs(_SafeStr_1146) <= 1)))
            {
                end(_window);
            }
            else
            {
                if (_callback != null)
                {
                    (_callback(_SafeStr_1145, _SafeStr_1146));
                };
            };
        }

        public function end(_arg_1:IWindow):IWindow
        {
            var _local_2:IWindow = _window;
            if (_SafeStr_1163)
            {
                _SafeStr_1163.stop();
                _SafeStr_1163.removeEventListener("timer", operate);
                _SafeStr_1163 = null;
            };
            if (_SafeStr_1162)
            {
                if (_window == _arg_1)
                {
                    if (!_window.disposed)
                    {
                        _window.removeEventListener("WE_DESTROYED", clientWindowDestroyed);
                    };
                    _window = null;
                    _SafeStr_1162 = false;
                };
            };
            return (_local_2);
        }

        private function clientWindowDestroyed(_arg_1:WindowEvent):void
        {
            end(_window);
        }


    }
}

