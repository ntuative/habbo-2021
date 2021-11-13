package com.sulake.core.window.events
{
    import com.sulake.core.window.IWindow;

    public class WindowTouchEvent extends WindowEvent 
    {

        public static const WINDOW_EVENT_TOUCH_BEGIN:String = "WTE_BEGIN";
        public static const _SafeStr_1097:String = "WTE_END";
        public static const WINDOW_EVENT_TOUCH_MOVE:String = "WTE_MOVE";
        public static const _SafeStr_1098:String = "WTE_OUT";
        public static const WINDOW_EVENT_TOUCH_OVER:String = "WTE_OVER";
        public static const _SafeStr_1099:String = "WTE_ROLL_OUT";
        public static const WINDOW_EVENT_TOUCH_ROLL_OVER:String = "WTE_ROLL_OVER";
        public static const _SafeStr_1100:String = "WTE_TAP";
        private static const _SafeStr_1036:Array = [];

        public var localX:Number;
        public var localY:Number;
        public var stageX:Number;
        public var stageY:Number;
        public var altKey:Boolean;
        public var ctrlKey:Boolean;
        public var shiftKey:Boolean;
        public var pressure:Number;
        public var sizeX:Number;
        public var sizeY:Number;


        public static function allocate(_arg_1:String, _arg_2:IWindow, _arg_3:IWindow, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number, _arg_8:Number, _arg_9:Number, _arg_10:Number, _arg_11:Boolean, _arg_12:Boolean, _arg_13:Boolean):WindowTouchEvent
        {
            var _local_14:WindowTouchEvent = ((_SafeStr_1036.length > 0) ? _SafeStr_1036.pop() : new WindowTouchEvent());
            _local_14._SafeStr_741 = _arg_1;
            _local_14._window = _arg_2;
            _local_14._SafeStr_1084 = _arg_3;
            _local_14._SafeStr_1037 = false;
            _local_14._SafeStr_1038 = _SafeStr_1036;
            _local_14.sizeX = _arg_6;
            _local_14.sizeY = _arg_7;
            _local_14.localX = _arg_4;
            _local_14.localY = _arg_5;
            _local_14.stageX = _arg_8;
            _local_14.stageY = _arg_9;
            _local_14.pressure = _arg_10;
            _local_14.altKey = _arg_11;
            _local_14.ctrlKey = _arg_12;
            _local_14.shiftKey = _arg_13;
            return (_local_14);
        }


        override public function clone():WindowEvent
        {
            return (allocate(_SafeStr_741, window, related, localX, localY, sizeX, sizeY, stageX, stageY, pressure, altKey, ctrlKey, shiftKey));
        }

        override public function toString():String
        {
            return (((((((((("WindowTouchEvent { type: " + _SafeStr_741) + " cancelable: ") + _SafeStr_1085) + " window: ") + _window) + " localX: ") + localX) + " localY: ") + localY) + " }");
        }


    }
}

