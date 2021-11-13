package com.sulake.habbo.ui.widget.effects
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.widget.memenu.IWidgetAvatarEffect;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import flash.utils.Timer;
    import flash.events.Event;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.assets.BitmapDataAsset;

    public class EffectView 
    {

        private const UPDATE_TIMER_MS:int = 1000;

        private var _SafeStr_1324:EffectsWidget;
        private var _window:IWindowContainer;
        private var _effect:IWidgetAvatarEffect;
        private var _bar:IWindow;
        private var _maxWidth:Number;
        private var _SafeStr_4018:ITextWindow;
        private var _SafeStr_1163:Timer;
        private var _hilite:IWindow;

        public function EffectView(_arg_1:EffectsWidget, _arg_2:IWidgetAvatarEffect)
        {
            _effect = _arg_2;
            _SafeStr_1324 = _arg_1;
            _SafeStr_1163 = new Timer(1000);
            _SafeStr_1163.addEventListener("timer", onUpdate);
            update();
        }

        public function get effect():IWidgetAvatarEffect
        {
            return (_effect);
        }

        public function dispose():void
        {
            if (_SafeStr_1163 != null)
            {
                _SafeStr_1163.stop();
                _SafeStr_1163.removeEventListener("timer", onUpdate);
                _SafeStr_1163 = null;
            };
            _SafeStr_1324 = null;
            _effect = null;
            _bar = null;
            _SafeStr_4018 = null;
            _hilite = null;
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
        }

        public function get window():IWindowContainer
        {
            return (_window);
        }

        private function onUpdate(_arg_1:Event=null):void
        {
            var _local_2:Number;
            if (_bar == null)
            {
                _SafeStr_1163.stop();
                return;
            };
            if (_effect.isActive)
            {
                _local_2 = (_effect.secondsLeft / _effect.duration);
                _bar.width = (_local_2 * _maxWidth);
            }
            else
            {
                _bar.width = 0;
                _SafeStr_1163.stop();
            };
            setTimeLeft();
        }

        private function setTimeLeft():void
        {
            var _local_8:String;
            var _local_7:int;
            var _local_9:int;
            var _local_1:int;
            var _local_3:int;
            var _local_2:int;
            var _local_5:String;
            var _local_4:String;
            var _local_6:String;
            if (_SafeStr_4018 == null)
            {
                _SafeStr_4018 = (_window.findChildByName("time_left") as ITextWindow);
                if (_SafeStr_4018 == null)
                {
                    return;
                };
            };
            if (!_effect.isActive)
            {
                _SafeStr_4018.caption = "${widgets.memenu.effects.activate}";
                return;
            };
            if (_effect.secondsLeft > 86400)
            {
                _SafeStr_4018.caption = "${widgets.memenu.effects.active.daysleft}";
                _local_8 = _SafeStr_4018.text;
                _local_7 = int(Math.floor((_effect.secondsLeft / 86400)));
                _local_8 = _local_8.replace("%days_left%", _local_7);
            }
            else
            {
                _SafeStr_4018.caption = "${widgets.memenu.effects.active.timeleft}";
                _local_8 = _SafeStr_4018.text;
                _local_9 = _effect.secondsLeft;
                _local_1 = int(Math.floor((_local_9 / 3600)));
                _local_3 = int((Math.floor((_local_9 / 60)) % 60));
                _local_2 = (_local_9 % 60);
                _local_5 = ((_local_1 < 10) ? "0" : "");
                _local_4 = ((_local_3 < 10) ? "0" : "");
                _local_6 = ((_local_2 < 10) ? "0" : "");
                if (_local_1 > 0)
                {
                    _local_8 = _local_8.replace("%time_left%", (((((((_local_5 + _local_1) + ":") + _local_4) + _local_3) + ":") + _local_6) + _local_2));
                }
                else
                {
                    _local_8 = _local_8.replace("%time_left%", ((((_local_4 + _local_3) + ":") + _local_6) + _local_2));
                };
            };
            _SafeStr_4018.text = _local_8;
        }

        public function update():void
        {
            var _local_7:IWindow;
            var _local_5:XmlAsset;
            var _local_4:_SafeStr_101;
            if (!_window)
            {
                _window = (_SafeStr_1324.windowManager.createWindow("", "", 4, 0, 16) as IWindowContainer);
            };
            while (_window.numChildren > 0)
            {
                _local_7 = _window.removeChildAt(0);
                _local_7.dispose();
            };
            _bar = null;
            _hilite = null;
            _SafeStr_4018 = null;
            var _local_2:String = "";
            if (_effect.isInUse)
            {
                _local_2 = "memenu_effect_selected";
            }
            else
            {
                if (_effect.isActive)
                {
                    _local_2 = "memenu_effect_unselected";
                }
                else
                {
                    _local_2 = "memenu_effect_inactive";
                };
            };
            _local_5 = (_SafeStr_1324.assets.getAssetByName(_local_2) as XmlAsset);
            var _local_6:IWindowContainer = (_SafeStr_1324.windowManager.buildFromXML((_local_5.content as XML)) as IWindowContainer);
            _window.addChild(_local_6);
            var _local_3:ITextWindow = (_window.findChildByName("effect_name") as ITextWindow);
            if (_local_3 != null)
            {
                _local_3.caption = (("${fx_" + _effect.type) + "}");
            };
            var _local_8:ITextWindow = (_window.findChildByName("effect_amount") as ITextWindow);
            if (_local_8 != null)
            {
                _local_8.caption = (_effect.amountInInventory + "");
            };
            var _local_1:IWindowContainer = (_window.findChildByName("effect_amount_bg1") as IWindowContainer);
            if (_effect.amountInInventory < 2)
            {
                if (_local_1 != null)
                {
                    _local_1.visible = false;
                };
            };
            if (_local_2 == "memenu_effect_inactive")
            {
                _local_4 = (_window.findChildByName("activate_effect") as _SafeStr_101);
                if (_local_4 != null)
                {
                    _local_4.addEventListener("WME_CLICK", onMouseEvent);
                };
            }
            else
            {
                _local_6.addEventListener("WME_CLICK", onMouseEvent);
                if (_effect.isActive)
                {
                    _local_6.addEventListener("WME_OVER", onMouseEvent);
                    _local_6.addEventListener("WME_OUT", onMouseEvent);
                };
                if (_effect.isInUse)
                {
                    setElementImage("effect_hilite", "memenu_fx_pause");
                }
                else
                {
                    setElementImage("effect_hilite", "memenu_fx_play");
                };
                _hilite = _window.findChildByName("effect_hilite");
                _hilite.visible = false;
            };
            setTimeLeft();
            _bar = _window.findChildByName("loader_bar");
            if (_bar != null)
            {
                _maxWidth = _bar.width;
                _SafeStr_1163.start();
                onUpdate();
            };
            if (_effect.icon)
            {
                setElementBitmap("effect_icon", _effect.icon);
            };
            _window.rectangle = _local_6.rectangle;
        }

        private function setElementBitmap(_arg_1:String, _arg_2:BitmapData):void
        {
            var _local_3:IBitmapWrapperWindow = (_window.findChildByName(_arg_1) as IBitmapWrapperWindow);
            if (_local_3 != null)
            {
                if (_local_3.bitmap)
                {
                    _local_3.bitmap.dispose();
                };
                _local_3.bitmap = new BitmapData(_local_3.width, _local_3.height, true, 0);
                _local_3.bitmap.copyPixels(_arg_2, _arg_2.rect, new Point(0, 0));
            };
        }

        private function onMouseEvent(_arg_1:WindowMouseEvent):void
        {
            switch (_arg_1.type)
            {
                case "WME_OVER":
                    if (_hilite != null)
                    {
                        _hilite.visible = true;
                    };
                    return;
                case "WME_OUT":
                    if (_hilite != null)
                    {
                        _hilite.visible = false;
                    };
                    return;
                case "WME_CLICK":
                    _SafeStr_1324.selectEffect(_effect.type, _effect.isInUse);
                    return;
            };
        }

        private function setElementImage(_arg_1:String, _arg_2:String):void
        {
            var _local_4:BitmapDataAsset = (_SafeStr_1324.assets.getAssetByName(_arg_2) as BitmapDataAsset);
            var _local_3:BitmapData = (_local_4.content as BitmapData);
            setElementBitmap(_arg_1, _local_3);
        }


    }
}

