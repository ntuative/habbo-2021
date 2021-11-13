package com.sulake.core.window.events
{
    import com.sulake.core.window.IWindow;

    public class WindowDisposeEvent extends WindowEvent 
    {

        public static const _SafeStr_1035:String = "WINDOW_DISPOSE_EVENT";
        private static const _SafeStr_1036:Array = [];

        public function WindowDisposeEvent()
        {
            _SafeStr_741 = "WINDOW_DISPOSE_EVENT";
        }

        public static function allocate(_arg_1:IWindow):WindowDisposeEvent
        {
            var _local_2:WindowDisposeEvent = ((_SafeStr_1036.length > 0) ? _SafeStr_1036.pop() : new WindowDisposeEvent());
            _local_2._window = _arg_1;
            _local_2._SafeStr_1037 = false;
            _local_2._SafeStr_1038 = _SafeStr_1036;
            return (_local_2);
        }


        override public function clone():WindowEvent
        {
            return (allocate(window));
        }

        override public function toString():String
        {
            return (((("WindowDisposeEvent { type: " + _SafeStr_741) + " window: ") + _window) + " }");
        }


    }
}

