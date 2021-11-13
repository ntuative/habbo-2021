package com.sulake.core.window.events
{
    import flash.events.KeyboardEvent;
    import flash.events.Event;
    import com.sulake.core.window.IWindow;

    public class WindowKeyboardEvent extends WindowEvent 
    {

        public static const _SafeStr_1087:String = "WKE_KEY_UP";
        public static const _SafeStr_1088:String = "WKE_KEY_DOWN";
        private static const _SafeStr_1036:Array = [];

        private var _SafeStr_1089:KeyboardEvent;


        public static function allocate(_arg_1:String, _arg_2:Event, _arg_3:IWindow, _arg_4:IWindow, _arg_5:Boolean=false):WindowKeyboardEvent
        {
            var _local_6:WindowKeyboardEvent = ((_SafeStr_1036.length > 0) ? _SafeStr_1036.pop() : new WindowKeyboardEvent());
            _local_6._SafeStr_741 = _arg_1;
            _local_6._SafeStr_1089 = (_arg_2 as KeyboardEvent);
            _local_6._window = _arg_3;
            _local_6._SafeStr_1084 = _arg_4;
            _local_6._SafeStr_1037 = false;
            _local_6._SafeStr_1085 = _arg_5;
            _local_6._SafeStr_1038 = _SafeStr_1036;
            return (_local_6);
        }


        public function get charCode():uint
        {
            return (_SafeStr_1089.charCode);
        }

        public function get keyCode():uint
        {
            return (_SafeStr_1089.keyCode);
        }

        public function get keyLocation():uint
        {
            return (_SafeStr_1089.keyLocation);
        }

        public function get altKey():Boolean
        {
            return (_SafeStr_1089.altKey);
        }

        public function get shiftKey():Boolean
        {
            return (_SafeStr_1089.shiftKey);
        }

        public function get ctrlKey():Boolean
        {
            return (_SafeStr_1089.ctrlKey);
        }

        override public function clone():WindowEvent
        {
            return (allocate(_SafeStr_741, _SafeStr_1089, window, related, cancelable));
        }

        override public function toString():String
        {
            return (((((((("WindowKeyboardEvent { type: " + _SafeStr_741) + " cancelable: ") + _SafeStr_1085) + " window: ") + _window) + " charCode: ") + charCode) + " }");
        }


    }
}

