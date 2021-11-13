package com.sulake.core.window.utils
{
    import flash.geom.Point;
    import flash.events.IEventDispatcher;
    import flash.events.MouseEvent;

    public class MouseEventQueue extends GenericEventQueue 
    {

        protected var _mousePosition:Point;

        public function MouseEventQueue(_arg_1:IEventDispatcher)
        {
            super(_arg_1);
            _mousePosition = new Point();
            _SafeStr_832.addEventListener("click", mouseEventListener, false);
            _SafeStr_832.addEventListener("doubleClick", mouseEventListener, false);
            _SafeStr_832.addEventListener("mouseDown", mouseEventListener, false);
            _SafeStr_832.addEventListener("mouseMove", mouseEventListener, false);
            _SafeStr_832.addEventListener("mouseUp", mouseEventListener, false);
            _SafeStr_832.addEventListener("mouseWheel", mouseEventListener, false);
        }

        public function get mousePosition():Point
        {
            return (_mousePosition);
        }

        override public function dispose():void
        {
            if (!_disposed)
            {
                _SafeStr_832.removeEventListener("click", mouseEventListener, false);
                _SafeStr_832.removeEventListener("doubleClick", mouseEventListener, false);
                _SafeStr_832.removeEventListener("mouseDown", mouseEventListener, false);
                _SafeStr_832.removeEventListener("mouseMove", mouseEventListener, false);
                _SafeStr_832.removeEventListener("mouseUp", mouseEventListener, false);
                _SafeStr_832.removeEventListener("mouseWheel", mouseEventListener, false);
                super.dispose();
            };
        }

        private function mouseEventListener(_arg_1:MouseEvent):void
        {
            _mousePosition.x = _arg_1.stageX;
            _mousePosition.y = _arg_1.stageY;
            _eventArray.push(_arg_1);
        }


    }
}

