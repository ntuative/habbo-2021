package com.sulake.habbo.window
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IUpdateReceiver;
    import flash.utils.Dictionary;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.motion.Queue;
    import com.sulake.core.window.motion.Combo;
    import com.sulake.core.window.motion.EaseOut;
    import com.sulake.core.window.motion.MoveTo;
    import com.sulake.core.window.motion.ResizeTo;
    import com.sulake.core.window.motion.Callback;
    import com.sulake.core.window.motion.Motion;
    import com.sulake.core.window.motion.Motions;
    import flash.geom.Point;
    import flash.utils.getTimer;

    public class HintManager implements IDisposable, IUpdateReceiver 
    {

        private static const _SafeStr_4448:int = 10;
        private static const _SafeStr_4449:int = 400;
        private static const _SafeStr_4450:int = 15;

        private var _windowManager:HabboWindowManagerComponent;
        private var _registeredWindows:Dictionary = new Dictionary();
        private var _activeHint:HintTarget;
        private var _hint:IStaticBitmapWrapperWindow;
        private var _SafeStr_4451:Rectangle;
        private var _SafeStr_4452:Rectangle;

        public function HintManager(_arg_1:HabboWindowManagerComponent)
        {
            _windowManager = _arg_1;
        }

        public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            hideHint();
            _activeHint = null;
            _registeredWindows = null;
            _windowManager = null;
        }

        public function get disposed():Boolean
        {
            return (_windowManager == null);
        }

        public function registerWindow(_arg_1:String, _arg_2:IWindow, _arg_3:int):void
        {
            if (_registeredWindows[_arg_1] != null)
            {
                unregisterWindow(_arg_1);
            };
            _registeredWindows[_arg_1] = new HintTarget(_arg_2, _arg_1, _arg_3);
        }

        public function unregisterWindow(_arg_1:String):void
        {
            if (activeKey == _arg_1)
            {
                hideHint();
            };
            delete _registeredWindows[_arg_1]; //not popped
        }

        public function showHint(_arg_1:String, _arg_2:Rectangle=null):void
        {
            var _local_3:HintTarget = _registeredWindows[_arg_1];
            if ((((!(_local_3 == null)) && (!(_local_3.window == null))) && (!(_arg_1 == activeKey))))
            {
                hideHint();
                _hint = (_local_3.window.context.create("", "", 23, 0, 0, null, null, null, 0) as IStaticBitmapWrapperWindow);
                _hint.fitSizeToContents = true;
                _hint.visible = false;
                switch (_local_3.style)
                {
                    case 1:
                        _hint.assetUri = "common_green_arrow_vertical";
                        break;
                    default:
                        _hint.assetUri = "common_green_arrow_horizontal";
                };
                _activeHint = _local_3;
                _SafeStr_4451 = _arg_2;
                _SafeStr_4452 = getTargetRect(_activeHint.window);
                if (_arg_2 != null)
                {
                    animateHint(_arg_2);
                }
                else
                {
                    _windowManager.registerUpdateReceiver(this, 10);
                    update(0);
                };
            };
        }

        protected function animateHint(_arg_1:Rectangle):void
        {
            _hint.x = _arg_1.x;
            _hint.y = _arg_1.y;
            _hint.visible = true;
            var _local_3:int = (_arg_1.x - _SafeStr_4452.x);
            var _local_6:int = (_arg_1.y - _SafeStr_4452.y);
            var _local_4:Number = Math.sqrt(((_local_3 * _local_3) + (_local_6 * _local_6)));
            var _local_2:int = (500 - Math.abs(((((1 / _local_4) * 100) * 500) * 0.5)));
            var _local_8:int = _hint.width;
            var _local_7:int = _hint.height;
            _hint.width = (_hint.width * 0.4);
            _hint.height = (_hint.height * 0.4);
            var _local_5:Motion = new Queue(new Combo(new EaseOut(new MoveTo(_hint, _local_2, _SafeStr_4452.x, _SafeStr_4452.y), 1), new ResizeTo(_hint, _local_2, _local_8, _local_7)), new Callback(motionComplete));
            Motions.runMotion(_local_5);
        }

        protected function motionComplete(_arg_1:Motion):void
        {
            _windowManager.registerUpdateReceiver(this, 10);
            update(0);
        }

        public function hideHint():void
        {
            _windowManager.removeUpdateReceiver(this);
            _activeHint = null;
            if (!_hint)
            {
                return;
            };
            _hint.dispose();
            _hint = null;
        }

        public function hideMatchingHint(_arg_1:String):void
        {
            if (_arg_1 == activeKey)
            {
                hideHint();
            };
        }

        public function update(_arg_1:uint):void
        {
            var _local_4:Point;
            var _local_5:int;
            var _local_6:int;
            var _local_2:int;
            var _local_3:int;
            if ((((!(_activeHint == null)) && (!(_hint == null))) && (!(_activeHint.window == null))))
            {
                _local_4 = new Point();
                _activeHint.window.getGlobalPosition(_local_4);
                if (((_local_4.x == 0) && (_local_4.y == 0)))
                {
                    return;
                };
                _local_5 = _hint.zoomX;
                _local_6 = _hint.zoomY;
                switch (_activeHint.style)
                {
                    case 1:
                        if (((_local_4.y - _hint.height) - 10) > 0)
                        {
                            _local_2 = (_local_4.y - _hint.height);
                            if (_hint.y == 0)
                            {
                                _hint.y = Math.max((_local_2 - 400), 15);
                            };
                            if ((_local_2 - _hint.y) > (15 + 10))
                            {
                                _hint.y = (_hint.y + 15);
                            }
                            else
                            {
                                _hint.y = ((_local_2 - 10) - (5 * Math.abs(Math.sin((getTimer() * 0.003)))));
                            };
                            _hint.zoomY = 1;
                        }
                        else
                        {
                            _local_3 = (_local_4.y + _activeHint.window.height);
                            if (_hint.y == 0)
                            {
                                _hint.y = Math.min((_windowManager.context.displayObjectContainer.stage.stageHeight - _hint.height), (_hint.y + 400));
                            };
                            if ((_local_3 - _hint.y) > (15 + 10))
                            {
                                _hint.y = (_hint.y - 15);
                            }
                            else
                            {
                                _hint.y = ((_local_3 + 10) + (5 * Math.abs(Math.sin((getTimer() * 0.003)))));
                            };
                            _hint.zoomY = -1;
                        };
                        _hint.x = (_local_4.x + ((_activeHint.window.width - _hint.width) / 2));
                        break;
                    default:
                        if ((_local_4.x + (_activeHint.window.width / 2)) > (_activeHint.window.desktop.width / 2))
                        {
                            _hint.x = (((_local_4.x - _hint.width) - 10) - (5 * Math.abs(Math.sin((getTimer() * 0.003)))));
                            _hint.zoomX = 1;
                        }
                        else
                        {
                            _hint.x = (((_local_4.x + _activeHint.window.width) + 10) + (5 * Math.abs(Math.sin((getTimer() * 0.003)))));
                            _hint.zoomX = -1;
                        };
                        _hint.y = (_local_4.y + ((_activeHint.window.height - _hint.height) / 2));
                };
                if (((!(_hint.zoomX == _local_5)) || (!(_hint.zoomY == _local_6))))
                {
                    _hint.invalidate();
                };
                _hint.visible = _activeHint.window.visible;
            };
        }

        private function getTargetRect(_arg_1:IWindow):Rectangle
        {
            var _local_2:Rectangle = new Rectangle();
            var _local_3:Point = new Point();
            _arg_1.getGlobalPosition(_local_3);
            switch (_activeHint.style)
            {
                case 1:
                    if (((_local_3.y - _hint.height) - 10) > 0)
                    {
                        _local_2.y = ((_local_3.y - _hint.height) - 10);
                    }
                    else
                    {
                        _local_2.y = ((_local_3.y + _arg_1.height) + 10);
                    };
                    _local_2.x = (_local_3.x + ((_arg_1.width - _hint.width) / 2));
                    break;
                default:
                    if ((_local_3.x + (_arg_1.width / 2)) > (_arg_1.desktop.width / 2))
                    {
                        _local_2.x = ((_local_3.x - _hint.width) - 10);
                    }
                    else
                    {
                        _local_2.x = ((_local_3.x + _arg_1.width) + 10);
                    };
                    _local_2.y = (_local_3.y + ((_arg_1.height - _hint.height) / 2));
            };
            return (_local_2);
        }

        private function get activeKey():String
        {
            return ((_activeHint) ? _activeHint.key : null);
        }


    }
}

