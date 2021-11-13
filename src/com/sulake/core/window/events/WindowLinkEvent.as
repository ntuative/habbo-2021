package com.sulake.core.window.events
{
    import com.sulake.core.window.IWindow;

    public class WindowLinkEvent extends WindowEvent 
    {

        public static const _SafeStr_1090:String = "WE_LINK";
        private static const _SafeStr_1036:Array = [];

        private var _link:String;

        public function WindowLinkEvent()
        {
            _SafeStr_741 = "WE_LINK";
        }

        public static function allocate(_arg_1:String, _arg_2:IWindow, _arg_3:IWindow):WindowEvent
        {
            var _local_4:WindowLinkEvent = ((_SafeStr_1036.length > 0) ? _SafeStr_1036.pop() : new WindowLinkEvent());
            _local_4._link = _arg_1;
            _local_4._window = _arg_2;
            _local_4._SafeStr_1084 = _arg_3;
            _local_4._SafeStr_1037 = false;
            _local_4._SafeStr_1038 = _SafeStr_1036;
            return (_local_4);
        }


        public function get link():String
        {
            return (_link);
        }

        override public function clone():WindowEvent
        {
            return (allocate(_link, window, related));
        }

        override public function toString():String
        {
            return (((((((("WindowLinkEvent { type: " + _SafeStr_741) + " link: ") + link) + " cancelable: ") + _SafeStr_1085) + " window: ") + _window) + " }");
        }


    }
}

