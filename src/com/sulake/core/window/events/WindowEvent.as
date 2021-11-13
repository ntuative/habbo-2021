package com.sulake.core.window.events
{
    import com.sulake.core.window.IWindow;

    public class WindowEvent 
    {

        public static const _SafeStr_1039:String = "WE_DESTROY";
        public static const _SafeStr_1040:String = "WE_DESTROYED";
        public static const _SafeStr_1041:String = "WE_OPEN";
        public static const _SafeStr_1042:String = "WE_OPENED";
        public static const _SafeStr_1043:String = "WE_CLOSE";
        public static const _SafeStr_1044:String = "WE_CLOSED";
        public static const WINDOW_EVENT_FOCUS:String = "WE_FOCUS";
        public static const _SafeStr_1045:String = "WE_FOCUSED";
        public static const WINDOW_EVENT_UNFOCUS:String = "WE_UNFOCUS";
        public static const _SafeStr_1046:String = "WE_UNFOCUSED";
        public static const _SafeStr_1047:String = "WE_ACTIVATE";
        public static const _SafeStr_1048:String = "WE_ACTIVATED";
        public static const _SafeStr_1049:String = "WE_DEACTIVATE";
        public static const _SafeStr_1050:String = "WE_DEACTIVATED";
        public static const _SafeStr_1051:String = "WE_SELECT";
        public static const _SafeStr_1052:String = "WE_SELECTED";
        public static const _SafeStr_1053:String = "WE_UNSELECT";
        public static const _SafeStr_1054:String = "WE_UNSELECTED";
        public static const WINDOW_EVENT_LOCK:String = "WE_LOCK";
        public static const _SafeStr_1055:String = "WE_LOCKED";
        public static const WINDOW_EVENT_UNLOCK:String = "WE_UNLOCK";
        public static const _SafeStr_1056:String = "WE_UNLOCKED";
        public static const _SafeStr_1057:String = "WE_ENABLE";
        public static const _SafeStr_1058:String = "WE_ENABLED";
        public static const _SafeStr_1059:String = "WE_DISABLE";
        public static const _SafeStr_1060:String = "WE_DISABLED";
        public static const _SafeStr_1061:String = "WE_RELOCATE";
        public static const _SafeStr_1062:String = "WE_RELOCATED";
        public static const _SafeStr_1063:String = "WE_RESIZE";
        public static const _SafeStr_1064:String = "WE_RESIZED";
        public static const _SafeStr_1065:String = "WE_MINIMIZE";
        public static const _SafeStr_1066:String = "WE_MINIMIZED";
        public static const _SafeStr_1067:String = "WE_MAXIMIZE";
        public static const _SafeStr_1068:String = "WE_MAXIMIZED";
        public static const WINDOW_EVENT_RESTORE:String = "WE_RESTORE";
        public static const _SafeStr_1069:String = "WE_RESTORED";
        public static const _SafeStr_1070:String = "WE_CHILD_ADDED";
        public static const _SafeStr_1071:String = "WE_CHILD_REMOVED";
        public static const _SafeStr_1072:String = "WE_CHILD_RELOCATED";
        public static const _SafeStr_1073:String = "WE_CHILD_RESIZED";
        public static const _SafeStr_1074:String = "WE_CHILD_ACTIVATED";
        public static const _SafeStr_1075:String = "WE_CHILD_VISIBILITY";
        public static const _SafeStr_1076:String = "WE_PARENT_ADDED";
        public static const _SafeStr_1077:String = "WE_PARENT_REMOVED";
        public static const _SafeStr_1078:String = "WE_PARENT_RELOCATED";
        public static const _SafeStr_1079:String = "WE_PARENT_RESIZED";
        public static const _SafeStr_1080:String = "WE_PARENT_ACTIVATED";
        public static const _SafeStr_1081:String = "WE_OK";
        public static const _SafeStr_1082:String = "WE_CANCEL";
        public static const WINDOW_EVENT_CHANGE:String = "WE_CHANGE";
        public static const _SafeStr_1083:String = "WE_SCROLL";
        public static const UNKNOWN:String = "";
        private static const _SafeStr_1036:Array = [];

        protected var _SafeStr_741:String;
        protected var _window:IWindow;
        protected var _SafeStr_1084:IWindow;
        protected var _SafeStr_1086:Boolean;
        protected var _SafeStr_1085:Boolean;
        protected var _SafeStr_1037:Boolean;
        protected var _SafeStr_1038:Array;


        public static function allocate(_arg_1:String, _arg_2:IWindow, _arg_3:IWindow, _arg_4:Boolean=false):WindowEvent
        {
            var _local_5:WindowEvent = ((_SafeStr_1036.length > 0) ? _SafeStr_1036.pop() : new WindowEvent());
            _local_5._SafeStr_741 = _arg_1;
            _local_5._window = _arg_2;
            _local_5._SafeStr_1084 = _arg_3;
            _local_5._SafeStr_1085 = _arg_4;
            _local_5._SafeStr_1037 = false;
            _local_5._SafeStr_1038 = _SafeStr_1036;
            return (_local_5);
        }


        public function get type():String
        {
            return (_SafeStr_741);
        }

        public function get target():IWindow
        {
            return (_window);
        }

        public function get window():IWindow
        {
            return (_window);
        }

        public function get related():IWindow
        {
            return (_SafeStr_1084);
        }

        public function get cancelable():Boolean
        {
            return (_SafeStr_1085);
        }

        public function recycle():void
        {
            if (_SafeStr_1037)
            {
                throw (new Error("Event already recycled!"));
            };
            _window = (_SafeStr_1084 = null);
            _SafeStr_1037 = true;
            _SafeStr_1086 = false;
            _SafeStr_1038.push(this);
        }

        public function clone():WindowEvent
        {
            return (allocate(_SafeStr_741, window, related, cancelable));
        }

        public function preventDefault():void
        {
            preventWindowOperation();
        }

        public function isDefaultPrevented():Boolean
        {
            return (_SafeStr_1086);
        }

        public function preventWindowOperation():void
        {
            if (cancelable)
            {
                _SafeStr_1086 = true;
            }
            else
            {
                throw (new Error("Attempted to prevent window operation that is not cancelable!"));
            };
        }

        public function isWindowOperationPrevented():Boolean
        {
            return (_SafeStr_1086);
        }

        public function stopPropagation():void
        {
            _SafeStr_1086 = true;
        }

        public function stopImmediatePropagation():void
        {
            _SafeStr_1086 = true;
        }

        public function toString():String
        {
            return (((((("WindowEvent { type: " + _SafeStr_741) + " cancelable: ") + _SafeStr_1085) + " window: ") + _window) + " }");
        }


    }
}

