package com.sulake.core.window.utils
{
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Point;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.graphics.IWindowRenderer;
    import com.sulake.core.window.components.IDesktopWindow;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.IInputEventTracker;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.events.MouseEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IInteractiveWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.RegionController;
    import com.sulake.core.window.enum.*;

    public class MouseEventProcessor implements IEventProcessor, IDisposable 
    {

        protected static var _SafeStr_1201:Array;
        protected static var _SafeStr_1202:Array;
        protected static var GLOBAL_POINT:Point = new Point();

        protected var _absMousePosition:Point;
        protected var _SafeStr_1195:WindowController;
        protected var _SafeStr_1194:WindowController;
        protected var _SafeStr_1196:IWindowRenderer;
        protected var _SafeStr_1193:IDesktopWindow;
        protected var _eventTrackers:Vector.<IInputEventTracker>;
        private var _disposed:Boolean = false;

        public function MouseEventProcessor()
        {
            _absMousePosition = new Point();
            if (_SafeStr_1201 == null)
            {
                _SafeStr_1201 = [];
                _SafeStr_1201[0] = 2;
                _SafeStr_1201[1] = 0;
                _SafeStr_1201[2] = 2;
                _SafeStr_1201[3] = 2;
                _SafeStr_1201[4] = 2;
                _SafeStr_1201[5] = 0;
                _SafeStr_1201[6] = 2;
            };
            if (_SafeStr_1202 == null)
            {
                _SafeStr_1202 = [];
                _SafeStr_1202[0] = 1;
                _SafeStr_1202[1] = 2;
                _SafeStr_1202[2] = 4;
                _SafeStr_1202[3] = 64;
                _SafeStr_1202[4] = 8;
                _SafeStr_1202[5] = 16;
                _SafeStr_1202[6] = 32;
            };
        }

        public static function setMouseCursorByState(_arg_1:uint, _arg_2:uint):void
        {
            var _local_3:int = _SafeStr_1202.indexOf(_arg_1);
            if (_local_3 > -1)
            {
                _SafeStr_1201[_local_3] = _arg_2;
            };
        }

        public static function getMouseCursorByState(_arg_1:uint):uint
        {
            var _local_2:uint = _SafeStr_1202.length;
            while (_local_2-- > 0)
            {
                if ((_arg_1 & _SafeStr_1202[_local_2]) > 0)
                {
                    return (_SafeStr_1201[_local_2]);
                };
            };
            return (0);
        }

        protected static function convertMouseEventType(_arg_1:MouseEvent, _arg_2:IWindow, _arg_3:IWindow):WindowMouseEvent
        {
            var _local_4:String;
            var _local_5:Boolean;
            var _local_6:Point = new Point(_arg_1.stageX, _arg_1.stageY);
            _arg_2.convertPointFromGlobalToLocalSpace(_local_6);
            switch (_arg_1.type)
            {
                case "mouseMove":
                    _local_4 = "WME_MOVE";
                    break;
                case "mouseOver":
                    _local_4 = "WME_OVER";
                    break;
                case "mouseOut":
                    _local_4 = "WME_OUT";
                    break;
                case "rollOut":
                    _local_4 = "WME_ROLL_OUT";
                    break;
                case "rollOver":
                    _local_4 = "WME_ROLL_OVER";
                    break;
                case "click":
                    _local_4 = "WME_CLICK";
                    break;
                case "doubleClick":
                    _local_4 = "WME_DOUBLE_CLICK";
                    break;
                case "mouseDown":
                    _local_4 = "WME_DOWN";
                    break;
                case "mouseUp":
                    _local_5 = ((((_local_6.x > -1) && (_local_6.y > -1)) && (_local_6.x < _arg_2.width)) && (_local_6.y < _arg_2.height));
                    _local_4 = ((_local_5) ? "WME_UP" : "WME_UP_OUTSIDE");
                    break;
                case "mouseWheel":
                    _local_4 = "WME_WHEEL";
                    break;
                default:
                    _local_4 = "";
            };
            return (WindowMouseEvent.allocate(_local_4, _arg_2, _arg_3, _local_6.x, _local_6.y, _arg_1.stageX, _arg_1.stageY, _arg_1.altKey, _arg_1.ctrlKey, _arg_1.shiftKey, _arg_1.buttonDown, _arg_1.delta));
        }


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                _disposed = true;
            };
        }

        public function process(_arg_1:EventProcessorState, _arg_2:IEventQueue):void
        {
            var _local_5:int;
            var _local_9:WindowController;
            var _local_4:Array;
            var _local_8:MouseEvent;
            var _local_6:WindowEvent;
            var _local_7:IWindow;
            var _local_3:IWindow;
            if (_arg_2.length == 0)
            {
                return;
            };
            _SafeStr_1193 = _arg_1.desktop;
            _SafeStr_1194 = (_arg_1._SafeStr_643 as WindowController);
            _SafeStr_1195 = (_arg_1.lastClickTarget as WindowController);
            _SafeStr_1196 = _arg_1.renderer;
            _eventTrackers = _arg_1.eventTrackers;
            _arg_2.begin();
            _absMousePosition.x = -1;
            _absMousePosition.y = -1;
            var _local_10:int;
            while (true)
            {
                _local_8 = (_arg_2.next() as MouseEvent);
                if (_local_8 == null) break;
                if (((!(_local_8.stageX == _absMousePosition.x)) || (!(_local_8.stageY == _absMousePosition.y))))
                {
                    _absMousePosition.x = _local_8.stageX;
                    _absMousePosition.y = _local_8.stageY;
                    _local_4 = [];
                    _SafeStr_1193.groupParameterFilteredChildrenUnderPoint(_absMousePosition, _local_4, 1);
                };
                _local_5 = ((_local_4 != null) ? _local_4.length : 0);
                if (_local_5 == 0)
                {
                    switch (_local_8.type)
                    {
                        case "mouseMove":
                            if (((!(_SafeStr_1194 == _SafeStr_1193)) && (!(_SafeStr_1194.disposed))))
                            {
                                _SafeStr_1194.getGlobalPosition(GLOBAL_POINT);
                                _local_6 = WindowMouseEvent.allocate("WME_OUT", _SafeStr_1194, null, (_local_8.stageX - GLOBAL_POINT.x), (_local_8.stageY - GLOBAL_POINT.y), _local_8.stageX, _local_8.stageY, _local_8.altKey, _local_8.ctrlKey, _local_8.shiftKey, _local_8.buttonDown, _local_8.delta);
                                _SafeStr_1194.update(_SafeStr_1194, _local_6);
                                _SafeStr_1194 = WindowController(_SafeStr_1193);
                                _local_6.recycle();
                            };
                            break;
                        case "mouseDown":
                            _local_7 = _SafeStr_1193.getActiveWindow();
                            if (_local_7)
                            {
                                _local_7.deactivate();
                            };
                            break;
                        case "mouseUp":
                            if (_SafeStr_1195)
                            {
                                _local_4.push(_SafeStr_1195);
                                _local_5++;
                            };
                    };
                };
                while (--_local_5 > -1)
                {
                    _local_9 = passMouseEvent(WindowController(_local_4[_local_5]), _local_8);
                    if (((!(_local_9 == null)) && (_local_9.visible)))
                    {
                        if (_local_8.type == "mouseMove")
                        {
                            if (_local_9 != _SafeStr_1194)
                            {
                                if (!_SafeStr_1194.disposed)
                                {
                                    _SafeStr_1194.getGlobalPosition(GLOBAL_POINT);
                                    _local_6 = WindowMouseEvent.allocate("WME_OUT", _SafeStr_1194, _local_9, (_local_8.stageX - GLOBAL_POINT.x), (_local_8.stageY - GLOBAL_POINT.y), _local_8.stageX, _local_8.stageY, _local_8.altKey, _local_8.ctrlKey, _local_8.shiftKey, _local_8.buttonDown, _local_8.delta);
                                    _SafeStr_1194.update(_SafeStr_1194, _local_6);
                                    _local_6.recycle();
                                };
                                if (!_local_9.disposed)
                                {
                                    _local_9.getGlobalPosition(GLOBAL_POINT);
                                    _local_6 = WindowMouseEvent.allocate("WME_OVER", _local_9, null, (_local_8.stageX - GLOBAL_POINT.x), (_local_8.stageY - GLOBAL_POINT.y), _local_8.stageX, _local_8.stageY, _local_8.altKey, _local_8.ctrlKey, _local_8.shiftKey, _local_8.buttonDown, _local_8.delta);
                                    _local_9.update(_local_9, _local_6);
                                    _local_6.recycle();
                                };
                                if (!_local_9.disposed)
                                {
                                    _SafeStr_1194 = _local_9;
                                };
                            };
                        };
                        _local_3 = _local_9.parent;
                        while (((_local_3) && (!(_local_3.disposed))))
                        {
                            if ((_local_3 is IInputProcessorRoot))
                            {
                                _local_6 = convertMouseEventType(_local_8, _local_3, _local_9);
                                IInputProcessorRoot(_local_3).process(_local_6);
                                _local_6.recycle();
                                break;
                            };
                            _local_3 = _local_3.parent;
                        };
                        if ((_SafeStr_1194 is IInteractiveWindow))
                        {
                            try
                            {
                                _local_10 = IInteractiveWindow(_SafeStr_1194).getMouseCursorByState(_SafeStr_1194.state);
                                if (_local_10 == 0)
                                {
                                    _local_10 = getMouseCursorByState(_SafeStr_1194.state);
                                };
                            }
                            catch(e:Error)
                            {
                                _local_10 = 0;
                            };
                        };
                        if (_local_9 != _SafeStr_1193)
                        {
                            _local_8.stopPropagation();
                            _arg_2.remove();
                        };
                        break;
                    };
                };
            };
            _arg_2.end();
            MouseCursorControl.type = _local_10;
            _arg_1.desktop = _SafeStr_1193;
            _arg_1._SafeStr_643 = _SafeStr_1194;
            _arg_1.lastClickTarget = _SafeStr_1195;
            _arg_1.renderer = _SafeStr_1196;
            _arg_1.eventTrackers = _eventTrackers;
        }

        private function passMouseEvent(_arg_1:WindowController, _arg_2:MouseEvent, _arg_3:Boolean=false):WindowController
        {
            var _local_9:BitmapData;
            if (_arg_1.disposed)
            {
                return (null);
            };
            if ((((_arg_1.testStateFlag(32)) && (_arg_2.type == "mouseMove")) && (_arg_1 is RegionController)))
            {
                return (_arg_1);
            };
            if (_arg_1.testStateFlag(32))
            {
                return (null);
            };
            var _local_7:Boolean;
            var _local_10:Point = new Point(_arg_2.stageX, _arg_2.stageY);
            _arg_1.convertPointFromGlobalToLocalSpace(_local_10);
            if (_arg_2.type == "mouseUp")
            {
                if (_arg_1 != _SafeStr_1195)
                {
                    if (((_SafeStr_1195) && (!(_SafeStr_1195.disposed))))
                    {
                        _SafeStr_1195.update(_SafeStr_1195, convertMouseEventType(new MouseEvent("mouseUp", false, true, _arg_2.localX, _arg_2.localY, null, _arg_2.ctrlKey, _arg_2.altKey, _arg_2.shiftKey, _arg_2.buttonDown, _arg_2.delta), _SafeStr_1195, _arg_1));
                        _SafeStr_1195 = null;
                        if (_arg_1.disposed)
                        {
                            return (null);
                        };
                    };
                }
                else
                {
                    _local_7 = (!(_arg_1.hitTestLocalPoint(_local_10)));
                };
            };
            if (!_local_7)
            {
                _local_9 = _SafeStr_1196.getDrawBufferForRenderable(_arg_1);
                if (!_arg_1.validateLocalPointIntersection(_local_10, _local_9))
                {
                    return (null);
                };
            };
            if (_arg_1.testParamFlag(3))
            {
                if (_arg_1.parent != null)
                {
                    return (passMouseEvent(WindowController(_arg_1.parent), _arg_2));
                };
            };
            if (!_arg_3)
            {
                switch (_arg_2.type)
                {
                    case "mouseDown":
                        _SafeStr_1195 = _arg_1;
                        break;
                    case "click":
                        if (_SafeStr_1195 != _arg_1)
                        {
                            return (null);
                        };
                        _SafeStr_1195 = null;
                        break;
                    case "doubleClick":
                        if (_SafeStr_1195 != _arg_1)
                        {
                            return (null);
                        };
                        _SafeStr_1195 = null;
                };
            };
            var _local_5:IWindow;
            var _local_6:WindowMouseEvent = convertMouseEventType(_arg_2, _arg_1, _local_5);
            var _local_4:Boolean = _arg_1.update(_arg_1, _local_6);
            for each (var _local_8:IInputEventTracker in _eventTrackers)
            {
                _local_8.eventReceived(_local_6, _arg_1);
            };
            _local_6.recycle();
            if (((!(_local_4)) && (!(_arg_3))))
            {
                if (_arg_1.parent)
                {
                    return (passMouseEvent(WindowController(_arg_1.parent), _arg_2));
                };
            };
            return (_arg_1);
        }


    }
}

