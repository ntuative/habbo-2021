package com.sulake.core.window.services
{
    import com.sulake.core.window.components.IToolTipWindow;
    import flash.utils.Timer;
    import flash.geom.Point;
    import flash.display.DisplayObject;
    import com.sulake.core.window.components.IInteractiveWindow;
    import com.sulake.core.window.IWindow;
    import flash.events.TimerEvent;

    public class WindowToolTipAgent extends WindowMouseOperator implements IToolTipAgentService 
    {

        protected var _toolTipCaption:String;
        protected var _SafeStr_1173:IToolTipWindow;
        protected var _SafeStr_1174:Timer;

        protected var _pointerOffset:Point = new Point();
        protected var _toolTipOffset:Point = new Point(20, 20);
        protected var _SafeStr_915:uint = 500;

        public function WindowToolTipAgent(_arg_1:DisplayObject)
        {
            super(_arg_1);
        }

        override public function begin(_arg_1:IWindow, _arg_2:uint=0):IWindow
        {
            if (((_arg_1) && (!(_arg_1.disposed))))
            {
                if ((_arg_1 is IInteractiveWindow))
                {
                    _toolTipCaption = IInteractiveWindow(_arg_1).toolTipCaption;
                    _SafeStr_915 = IInteractiveWindow(_arg_1).toolTipDelay;
                }
                else
                {
                    _toolTipCaption = _arg_1.caption;
                    _SafeStr_915 = 500;
                };
                _mouse.x = _SafeStr_1165.mouseX;
                _mouse.y = _SafeStr_1165.mouseY;
                getMousePositionRelativeTo(_arg_1, _mouse, _pointerOffset);
                if (_SafeStr_1174 == null)
                {
                    _SafeStr_1174 = new Timer(_SafeStr_915, 1);
                    _SafeStr_1174.addEventListener("timer", showToolTip);
                };
                _SafeStr_1174.reset();
                _SafeStr_1174.start();
            };
            return (super.begin(_arg_1, _arg_2));
        }

        override public function end(_arg_1:IWindow):IWindow
        {
            if (_SafeStr_1174 != null)
            {
                _SafeStr_1174.stop();
                _SafeStr_1174.removeEventListener("timer", showToolTip);
                _SafeStr_1174 = null;
            };
            hideToolTip();
            return (super.end(_arg_1));
        }

        override public function operate(_arg_1:int, _arg_2:int):void
        {
            if (((_window) && (!(_window.disposed))))
            {
                _mouse.x = _arg_1;
                _mouse.y = _arg_2;
                getMousePositionRelativeTo(_window, _mouse, _pointerOffset);
                if (((!(_SafeStr_1173 == null)) && (!(_SafeStr_1173.disposed))))
                {
                    _SafeStr_1173.x = (_arg_1 + _toolTipOffset.x);
                    _SafeStr_1173.y = (_arg_2 + _toolTipOffset.y);
                };
            };
        }

        protected function showToolTip(_arg_1:TimerEvent):void
        {
            var _local_2:Point;
            if (_SafeStr_1174 != null)
            {
                _SafeStr_1174.reset();
            };
            if (((_window) && (!(_window.disposed))))
            {
                if ((_window is IInteractiveWindow))
                {
                    _toolTipCaption = IInteractiveWindow(_window).toolTipCaption;
                }
                else
                {
                    _toolTipCaption = _window.caption;
                };
                if (((_SafeStr_1173 == null) || (_SafeStr_1173.disposed)))
                {
                    _SafeStr_1173 = (_window.context.create((_window.name + "::ToolTip"), _toolTipCaption, 8, _window.style, (0x20 | 0x00), null, null, null, 0, null, null) as IToolTipWindow);
                };
                _local_2 = new Point();
                _window.getGlobalPosition(_local_2);
                _SafeStr_1173.x = ((_local_2.x + _pointerOffset.x) + _toolTipOffset.x);
                _SafeStr_1173.y = ((_local_2.y + _pointerOffset.y) + _toolTipOffset.y);
                _SafeStr_1173.visible = (_SafeStr_1173.caption.length > 0);
            };
        }

        protected function hideToolTip():void
        {
            if (((!(_SafeStr_1173 == null)) && (!(_SafeStr_1173.disposed))))
            {
                _SafeStr_1173.destroy();
                _SafeStr_1173 = null;
            };
        }

        public function updateCaption(_arg_1:IWindow):void
        {
            var _local_2:String;
            if (((((_arg_1 == null) || (_arg_1.disposed)) || (_SafeStr_1173 == null)) || (_SafeStr_1173.disposed)))
            {
                return;
            };
            if ((_arg_1 is IInteractiveWindow))
            {
                _local_2 = IInteractiveWindow(_arg_1).toolTipCaption;
            }
            else
            {
                _local_2 = _arg_1.caption;
            };
            if (_local_2 != _toolTipCaption)
            {
                _toolTipCaption = _local_2;
                if (((_local_2 == null) || (_local_2.length == 0)))
                {
                    _SafeStr_1173.visible = false;
                }
                else
                {
                    _SafeStr_1173.caption = _local_2;
                    _SafeStr_1173.visible = true;
                };
            };
        }


    }
}

