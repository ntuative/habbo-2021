package com.sulake.core.window.events
{
    import com.sulake.core.window.IWindow;

    public class WindowMessage extends WindowEvent 
    {

        private static const WINDOW_EVENT_MESSAGE:String = "WE_MESSAGE";
        private static const _SafeStr_1036:Array = [];

        public var message:String;

        public function WindowMessage()
        {
            _SafeStr_741 = "WE_MESSAGE";
        }

        public static function allocate(_arg_1:String, _arg_2:IWindow, _arg_3:IWindow, _arg_4:Boolean=false):WindowEvent
        {
            var _local_5:WindowMessage = ((_SafeStr_1036.length > 0) ? _SafeStr_1036.pop() : new WindowMessage());
            _local_5.message = _arg_1;
            _local_5._window = _arg_2;
            _local_5._SafeStr_1084 = _arg_3;
            _local_5._SafeStr_1085 = _arg_4;
            _local_5._SafeStr_1037 = false;
            _local_5._SafeStr_1038 = _SafeStr_1036;
            return (_local_5);
        }


        override public function clone():WindowEvent
        {
            return (allocate(message, window, related, cancelable));
        }

        override public function toString():String
        {
            return (((((((("WindowLinkEvent { type: " + _SafeStr_741) + " message: ") + message) + " cancelable: ") + _SafeStr_1085) + " window: ") + _window) + " }");
        }


    }
}

