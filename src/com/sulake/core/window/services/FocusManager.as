package com.sulake.core.window.services
{
    import flash.display.Stage;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.components.IFocusWindow;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.events.FocusEvent;
    import com.sulake.core.window.utils.*;

    public class FocusManager implements IFocusManagerService 
    {

        private var _disposed:Boolean = false;
        private var _SafeStr_1161:Stage;
        private var _SafeStr_875:Vector.<IFocusWindow> = new Vector.<IFocusWindow>();

        public function FocusManager(_arg_1:DisplayObject)
        {
            _SafeStr_1161 = _arg_1.stage;
            _SafeStr_1161.addEventListener("activate", onActivateEvent);
            _SafeStr_1161.addEventListener("focusOut", onFocusEvent);
            _SafeStr_1161.addEventListener("keyFocusChange", onFocusEvent);
            _SafeStr_1161.addEventListener("mouseFocusChange", onFocusEvent);
            super();
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                _SafeStr_1161.removeEventListener("activate", onActivateEvent);
                _SafeStr_1161.removeEventListener("focusOut", onFocusEvent);
                _SafeStr_1161.removeEventListener("keyFocusChange", onFocusEvent);
                _SafeStr_1161.removeEventListener("mouseFocusChange", onFocusEvent);
                _SafeStr_1161 = null;
                _disposed = true;
                _SafeStr_875 = null;
            };
        }

        public function registerFocusWindow(_arg_1:IFocusWindow):void
        {
            if (_arg_1 != null)
            {
                if (_SafeStr_875.indexOf(_arg_1) == -1)
                {
                    _SafeStr_875.push(_arg_1);
                    if (_SafeStr_1161.focus == null)
                    {
                        _arg_1.focus();
                    };
                };
            };
        }

        public function removeFocusWindow(_arg_1:IFocusWindow):void
        {
            var _local_2:int;
            if (_arg_1 != null)
            {
                _local_2 = _SafeStr_875.indexOf(_arg_1);
                if (_local_2 > -1)
                {
                    _SafeStr_875.splice(_local_2, 1);
                };
            };
            if (_SafeStr_1161.focus == null)
            {
                resolveNextFocusTarget();
            };
        }

        private function resolveNextFocusTarget():IFocusWindow
        {
            var _local_1:IFocusWindow;
            var _local_2:uint = _SafeStr_875.length;
            while (_local_2-- != 0)
            {
                _local_1 = (_SafeStr_875[_local_2] as IFocusWindow);
                if (_local_1.disposed)
                {
                    _SafeStr_875.splice(_local_2, 1);
                }
                else
                {
                    _local_1.focus();
                    break;
                };
            };
            return (_local_1);
        }

        private function onActivateEvent(_arg_1:Event):void
        {
            if (_SafeStr_1161.focus == null)
            {
                resolveNextFocusTarget();
            };
        }

        private function onFocusEvent(_arg_1:FocusEvent):void
        {
            if (_SafeStr_1161.focus == null)
            {
                resolveNextFocusTarget();
            };
        }


    }
}

