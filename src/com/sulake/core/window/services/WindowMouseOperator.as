package com.sulake.core.window.services
{
    import com.sulake.core.runtime.IDisposable;
    import flash.display.DisplayObject;
    import com.sulake.core.window.WindowController;
    import flash.geom.Point;
    import com.sulake.core.window.IWindow;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import com.sulake.core.window.events.WindowEvent;

    public class WindowMouseOperator implements IDisposable 
    {

        protected var _SafeStr_1165:DisplayObject;
        protected var _window:WindowController;
        protected var _SafeStr_1162:Boolean;
        protected var _offset:Point;
        protected var _mouse:Point;
        protected var _SafeStr_1172:Point;
        protected var _SafeStr_852:uint;
        private var _disposed:Boolean = false;

        public function WindowMouseOperator(_arg_1:DisplayObject)
        {
            _SafeStr_1165 = _arg_1;
            _SafeStr_1172 = new Point();
            _mouse = new Point();
            _offset = new Point();
            _SafeStr_1162 = false;
            _SafeStr_852 = 0;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            end(_window);
            _offset = null;
            _mouse = null;
            _SafeStr_1172 = null;
            _SafeStr_1165 = null;
            _disposed = true;
        }

        public function begin(_arg_1:IWindow, _arg_2:uint=0):IWindow
        {
            _SafeStr_852 = _arg_2;
            var _local_3:IWindow = _window;
            if (_window != null)
            {
                end(_window);
            };
            if (((_arg_1) && (!(_arg_1.disposed))))
            {
                _SafeStr_1165.addEventListener("mouseDown", handler, false);
                _SafeStr_1165.addEventListener("mouseUp", handler, false);
                _SafeStr_1165.addEventListener("enterFrame", handler);
                _mouse.x = _SafeStr_1165.mouseX;
                _mouse.y = _SafeStr_1165.mouseY;
                _window = WindowController(_arg_1);
                getMousePositionRelativeTo(_arg_1, _mouse, _offset);
                _window.addEventListener("WE_DESTROYED", clientWindowDestroyed);
                _SafeStr_1162 = true;
            };
            return (_local_3);
        }

        public function end(_arg_1:IWindow):IWindow
        {
            var _local_2:IWindow = _window;
            if (_SafeStr_1162)
            {
                if (_window == _arg_1)
                {
                    _SafeStr_1165.removeEventListener("mouseDown", handler, false);
                    _SafeStr_1165.removeEventListener("mouseUp", handler, false);
                    _SafeStr_1165.removeEventListener("enterFrame", handler);
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

        protected function handler(_arg_1:Event):void
        {
            var _local_2:MouseEvent;
            if (_SafeStr_1162)
            {
                if (_arg_1.type == "enterFrame")
                {
                    if (_window.disposed)
                    {
                        end(_window);
                    }
                    else
                    {
                        if (((!(_mouse.x == _SafeStr_1165.mouseX)) || (!(_mouse.y == _SafeStr_1165.mouseY))))
                        {
                            operate(_SafeStr_1165.mouseX, _SafeStr_1165.mouseY);
                            _mouse.x = _SafeStr_1165.mouseX;
                            _mouse.y = _SafeStr_1165.mouseY;
                        };
                    };
                    return;
                };
                _local_2 = (_arg_1 as MouseEvent);
                if (_local_2 != null)
                {
                    switch (_local_2.type)
                    {
                        case "mouseUp":
                            end(_window);
                            return;
                    };
                };
            };
        }

        public function operate(_arg_1:int, _arg_2:int):void
        {
            _mouse.x = _arg_1;
            _mouse.y = _arg_2;
            getMousePositionRelativeTo(_window, _mouse, _SafeStr_1172);
            _window.offset((_SafeStr_1172.x - _offset.x), (_SafeStr_1172.y - _offset.y));
        }

        private function clientWindowDestroyed(_arg_1:WindowEvent):void
        {
            end(_window);
        }

        protected function getMousePositionRelativeTo(_arg_1:IWindow, _arg_2:Point, _arg_3:Point):void
        {
            _arg_1.getGlobalPosition(_arg_3);
            _arg_3.x = (_arg_2.x - _arg_3.x);
            _arg_3.y = (_arg_2.y - _arg_3.y);
        }


    }
}

