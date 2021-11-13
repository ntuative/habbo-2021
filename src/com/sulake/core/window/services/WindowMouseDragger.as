package com.sulake.core.window.services
{
    import flash.display.DisplayObject;

    public class WindowMouseDragger extends WindowMouseOperator implements IMouseDraggingService 
    {

        public function WindowMouseDragger(_arg_1:DisplayObject)
        {
            super(_arg_1);
        }

        override public function operate(_arg_1:int, _arg_2:int):void
        {
            _mouse.x = _arg_1;
            _mouse.y = _arg_2;
            getMousePositionRelativeTo(_window, _mouse, _SafeStr_1172);
            _window.offset((_SafeStr_1172.x - _offset.x), (_SafeStr_1172.y - _offset.y));
        }


    }
}

