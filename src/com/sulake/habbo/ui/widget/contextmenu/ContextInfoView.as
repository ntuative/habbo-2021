package com.sulake.habbo.ui.widget.contextmenu
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.utils.FixedSizeStack;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.geom.Point;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.IDesktopWindow;
    import flash.geom.Rectangle;
    import com.sulake.core.assets.XmlAsset;

    public class ContextInfoView implements IDisposable 
    {

        protected static const CONTEXT_INFO_DELAY:uint = 3000;
        protected static const BUTTON_COLOR_DEFAULT:uint = 4281149991;
        protected static const BUTTON_COLOR_HOVER:uint = 4282950861;
        protected static const _SafeStr_3993:uint = 0xFF993300;
        protected static const LINK_COLOR_ACTIONS_DEFAULT:uint = 0xFFFFFF;
        protected static const LINK_COLOR_ACTIONS_HOVER:uint = 9552639;
        protected static const _SafeStr_3994:uint = 0xFFFFFF;
        protected static const _SafeStr_3995:uint = 5789011;
        protected static const ICON_COLOR_ENABLED:uint = 13947341;
        protected static const ICON_COLOR_DISABLED:uint = 5789011;
        private static const _SafeStr_3996:int = 25;
        private static const _SafeStr_3997:int = 3;

        protected static var _SafeStr_2776:Boolean = false;

        protected var _window:IWindowContainer;
        protected var _SafeStr_3998:IWindowContainer;
        protected var _SafeStr_3884:IWindowContainer;
        private var _forcedPositionUpdate:Boolean;
        protected var _SafeStr_1324:IContextMenuParentWidget;
        protected var _lockPosition:Boolean;
        protected var _SafeStr_3999:FixedSizeStack = new FixedSizeStack(25);
        protected var _SafeStr_4000:int = -1000000;
        protected var _disposed:Boolean = false;
        private var _forceActivateOnUpdate:Boolean = true;
        protected var _SafeStr_4001:Timer;
        protected var _SafeStr_3933:int = 3000;
        protected var _SafeStr_4002:Boolean;
        protected var _SafeStr_4003:Boolean;
        protected var _SafeStr_1230:Number;
        protected var _fadeTime:int;
        protected var _fadeLength:int = 500;
        protected var _SafeStr_3885:Boolean;

        public function ContextInfoView(_arg_1:IContextMenuParentWidget)
        {
            _SafeStr_1324 = _arg_1;
            _SafeStr_3885 = true;
            _SafeStr_4002 = false;
            _SafeStr_4003 = false;
        }

        public static function setupContext(_arg_1:ContextInfoView):void
        {
            _arg_1._SafeStr_4002 = false;
            _arg_1._fadeLength = 500;
            _arg_1._SafeStr_4003 = false;
            _arg_1._SafeStr_1230 = 1;
            if (_arg_1._SafeStr_3885)
            {
                if (!_arg_1._SafeStr_4001)
                {
                    _arg_1._SafeStr_4001 = new Timer(_arg_1._SafeStr_3933, 1);
                    _arg_1._SafeStr_4001.addEventListener("timerComplete", _arg_1.onTimerComplete);
                };
                _arg_1._SafeStr_4001.reset();
                _arg_1._SafeStr_4001.start();
            };
            _arg_1.updateWindow();
        }


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get maximumBlend():Number
        {
            return (1);
        }

        public function dispose():void
        {
            _SafeStr_1324 = null;
            _SafeStr_3884 = null;
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            if (_SafeStr_3998)
            {
                _SafeStr_3998.dispose();
                _SafeStr_3998 = null;
            };
            if (_SafeStr_4001)
            {
                _SafeStr_4001.removeEventListener("timerComplete", onTimerComplete);
                _SafeStr_4001.reset();
                _SafeStr_4001 = null;
            };
            _disposed = true;
        }

        private function onTimerComplete(_arg_1:TimerEvent):void
        {
            _SafeStr_4003 = true;
            _fadeTime = 0;
            hide(true);
        }

        protected function addMouseClickListener(_arg_1:IWindow, _arg_2:Function):void
        {
            if (_arg_1 != null)
            {
                _arg_1.addEventListener("WME_CLICK", _arg_2);
            };
        }

        protected function updateWindow():void
        {
        }

        protected function clickHandler(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1324.messageListener.processWidgetMessage(new RoomWidgetUserActionMessage("RWUAM_START_NAME_CHANGE"));
            _SafeStr_1324.removeView(this, false);
        }

        public function setImageAsset(_arg_1:IBitmapWrapperWindow, _arg_2:String, _arg_3:Boolean=false):void
        {
            var _local_6:Point;
            if ((((!(_arg_1)) || (!(_SafeStr_1324))) || (!(_SafeStr_1324.assets))))
            {
                return;
            };
            var _local_5:BitmapDataAsset = (_SafeStr_1324.assets.getAssetByName(_arg_2) as BitmapDataAsset);
            if (!_local_5)
            {
                return;
            };
            var _local_4:BitmapData = (_local_5.content as BitmapData);
            if (!_local_4)
            {
                return;
            };
            if (_arg_1.bitmap)
            {
                _arg_1.bitmap.fillRect(_arg_1.bitmap.rect, 0);
            }
            else
            {
                _arg_1.bitmap = new BitmapData(_arg_1.width, _arg_1.height, true, 0);
            };
            if (_arg_3)
            {
                _local_6 = new Point(((_arg_1.bitmap.width - _local_4.width) / 2), ((_arg_1.bitmap.height - _local_4.height) / 2));
            }
            else
            {
                _local_6 = new Point(0, 0);
            };
            _arg_1.bitmap.copyPixels(_local_4, _local_4.rect, _local_6, null, null, true);
            _arg_1.invalidate();
        }

        public function show():void
        {
            if (_SafeStr_3884 != null)
            {
                _SafeStr_3884.visible = true;
                if (!(_SafeStr_3884.parent is IDesktopWindow))
                {
                    _SafeStr_1324.windowManager.getDesktop(0).addChild(_SafeStr_3884);
                };
                if (_forceActivateOnUpdate)
                {
                    _SafeStr_3884.activate();
                };
            };
        }

        public function hide(_arg_1:Boolean):void
        {
            if (_SafeStr_3884 != null)
            {
                if (((!(_SafeStr_4002)) && (_arg_1)))
                {
                    _SafeStr_4002 = true;
                    _SafeStr_4001.start();
                }
                else
                {
                    _SafeStr_3884.visible = false;
                    _SafeStr_3884.parent = null;
                };
            };
        }

        protected function getOffset(_arg_1:Rectangle):int
        {
            var _local_2:int = -(_SafeStr_3884.height);
            return (_local_2 - 4);
        }

        public function update(_arg_1:Rectangle, _arg_2:Point, _arg_3:uint):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            if (!_arg_1)
            {
                return;
            };
            if (!_SafeStr_3884)
            {
                updateWindow();
            };
            if (_SafeStr_4003)
            {
                _fadeTime = (_fadeTime + _arg_3);
                _SafeStr_1230 = ((1 - (_fadeTime / _fadeLength)) * maximumBlend);
            }
            else
            {
                _SafeStr_1230 = maximumBlend;
            };
            if (_SafeStr_1230 <= 0)
            {
                _SafeStr_1324.removeView(this, false);
                return;
            };
            if (((!(_lockPosition)) || (_forcedPositionUpdate)))
            {
                _local_4 = getOffset(_arg_1);
                _local_5 = (_arg_2.y - _arg_1.top);
                _SafeStr_3999.addValue(_local_5);
                _local_6 = _SafeStr_3999.getMax();
                if (_local_6 < (_SafeStr_4000 - 3))
                {
                    _local_6 = (_SafeStr_4000 - 3);
                };
                _local_7 = (_arg_2.y - _local_6);
                _SafeStr_4000 = _local_6;
                _SafeStr_3884.x = (_arg_2.x - (_SafeStr_3884.width / 2));
                _SafeStr_3884.y = (_local_7 + _local_4);
                _forcedPositionUpdate = false;
            };
            _SafeStr_3884.blend = _SafeStr_1230;
            show();
        }

        protected function onMouseHoverEvent(_arg_1:WindowMouseEvent):void
        {
            if (_arg_1.type == "WME_OVER")
            {
                _lockPosition = true;
            }
            else
            {
                if (_arg_1.type == "WME_OUT")
                {
                    if (!_arg_1.window.hitTestGlobalPoint(new Point(_arg_1.stageX, _arg_1.stageY)))
                    {
                        _lockPosition = false;
                    };
                };
            };
        }

        protected function setMinimized(_arg_1:Boolean):void
        {
            _SafeStr_2776 = _arg_1;
            _forcedPositionUpdate = true;
            updateWindow();
        }

        protected function getMinimizedView():IWindowContainer
        {
            var _local_1:XML;
            if (!_SafeStr_3998)
            {
                _local_1 = (XmlAsset(_SafeStr_1324.assets.getAssetByName("minimized_menu")).content as XML);
                _SafeStr_3998 = (_SafeStr_1324.windowManager.buildFromXML(_local_1, 0) as IWindowContainer);
                _SafeStr_3998.findChildByName("minimize").addEventListener("WME_CLICK", onMaximize);
                _SafeStr_3998.findChildByName("minimize").addEventListener("WME_OVER", onMinimizeHover);
                _SafeStr_3998.findChildByName("minimize").addEventListener("WME_OUT", onMinimizeHover);
                _SafeStr_3998.addEventListener("WME_OVER", onMouseHoverEvent);
                _SafeStr_3998.addEventListener("WME_OUT", onMouseHoverEvent);
            };
            return (_SafeStr_3998);
        }

        private function onMaximize(_arg_1:WindowMouseEvent):void
        {
            setMinimized(false);
        }

        protected function set activeView(_arg_1:IWindowContainer):void
        {
            if (!_arg_1)
            {
                return;
            };
            if (_SafeStr_3884)
            {
                _SafeStr_3884.parent = null;
            };
            _SafeStr_3884 = _arg_1;
        }

        protected function onMinimize(_arg_1:WindowMouseEvent):void
        {
            setMinimized(true);
        }

        protected function onMinimizeHover(_arg_1:WindowMouseEvent):void
        {
            var _local_3:IWindow;
            var _local_2:IWindowContainer = (_arg_1.window as IWindowContainer);
            if (_local_2)
            {
                _local_3 = _local_2.findChildByName("icon");
                if (_local_3)
                {
                    if (_arg_1.type == "WME_OVER")
                    {
                        _local_3.color = 4282950861;
                    }
                    else
                    {
                        _local_3.color = 0xFFFFFF;
                    };
                };
            };
        }

        public function set forceActivateOnUpdate(_arg_1:Boolean):void
        {
            _forceActivateOnUpdate = _arg_1;
        }

        public function get window():IWindowContainer
        {
            return (_window);
        }


    }
}

