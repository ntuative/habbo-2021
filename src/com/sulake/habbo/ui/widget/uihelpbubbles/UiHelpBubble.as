package com.sulake.habbo.ui.widget.uihelpbubbles
{
    import com.sulake.core.window.IWindowContainer;
    import flash.geom.Point;
    import com.sulake.core.window.components.IBubbleWindow;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.ITextFieldWindow;

    public class UiHelpBubble 
    {

        private var _window:IWindowContainer;
        private var _SafeStr_1324:UiHelpBubblesWidget;
        private var _SafeStr_698:String;
        private var _SafeStr_4292:Point;
        private var _SafeStr_4293:String;
        private var _SafeStr_4294:Boolean;
        private var _bubble:IBubbleWindow;
        private var _nextButton:_SafeStr_101;
        private var _SafeStr_1421:IWindowContainer;
        private var _SafeStr_4295:Boolean;
        private var _SafeStr_4296:IBitmapWrapperWindow;
        private var _SafeStr_4297:IWindow;
        private var _SafeStr_4298:IWindow;
        private var _SafeStr_3639:Function;

        public function UiHelpBubble(_arg_1:UiHelpBubblesWidget, _arg_2:HelpBubbleItem, _arg_3:Boolean)
        {
            _SafeStr_1324 = _arg_1;
            _SafeStr_698 = _arg_2.name;
            _SafeStr_4293 = _arg_2.text;
            _SafeStr_4294 = _arg_3;
            _SafeStr_4295 = _arg_2.modal;
            createWindow();
        }

        public function dispose():void
        {
            _SafeStr_1324 = null;
            if (((!(_SafeStr_4297 == null)) && (!(_SafeStr_3639 == null))))
            {
                _SafeStr_4297.removeEventListener("WME_CLICK", _SafeStr_3639);
            };
            if (_SafeStr_1421)
            {
                _SafeStr_1421.dispose();
                _SafeStr_1421 = null;
            };
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
        }

        private function addMouseClickListener(_arg_1:IWindow, _arg_2:Function):void
        {
            if (_arg_1 != null)
            {
                _arg_1.setParamFlag(1, true);
                _arg_1.addEventListener("WME_CLICK", _arg_2);
            };
        }

        private function createWindow():void
        {
            var _local_4:XmlAsset;
            var _local_1:int;
            if ((((!(_SafeStr_1324)) || (!(_SafeStr_1324.assets))) || (!(_SafeStr_1324.windowManager))))
            {
                return;
            };
            if (_SafeStr_4295)
            {
                _local_4 = (_SafeStr_1324.assets.getAssetByName("ui_help_modal") as XmlAsset);
                _SafeStr_1421 = (_SafeStr_1324.windowManager.buildFromXML((_local_4.content as XML), 3) as IWindowContainer);
            };
            if (_SafeStr_1421)
            {
                _SafeStr_1421.width = _SafeStr_1421.desktop.width;
                _SafeStr_1421.height = _SafeStr_1421.desktop.height;
                _SafeStr_4296 = (_SafeStr_1421.findChildByName("bitmap") as IBitmapWrapperWindow);
                addMouseClickListener(_SafeStr_4296, onActivateBubble);
            };
            var _local_2:XmlAsset = (_SafeStr_1324.assets.getAssetByName("ui_help_bubble") as XmlAsset);
            if (!_local_2)
            {
                return;
            };
            _window = (_SafeStr_1324.windowManager.buildFromXML((_local_2.content as XML), 3) as IWindowContainer);
            if (!_window)
            {
                return;
            };
            _nextButton = (_window.findChildByName("help_bubble_btn_ok") as _SafeStr_101);
            _bubble = (_window.findChildByName("bubble") as IBubbleWindow);
            var _local_3:ITextWindow = (_window.findChildByName("help_bubble_text") as ITextWindow);
            if (_local_3)
            {
                _local_3.text = _SafeStr_4293;
                _local_1 = _local_3.textHeight;
                _window.height = (_local_1 + 90);
                _nextButton.y = (_local_1 + 30);
            };
            if (!_SafeStr_4294)
            {
                _nextButton.caption = _SafeStr_1324.localizations.getLocalization("alert.close.button", "alert.close.button");
                addMouseClickListener(_nextButton, onLastBubble);
            }
            else
            {
                addMouseClickListener(_nextButton, onNext);
            };
            _window.visible = true;
        }

        public function show():void
        {
            if (_window != null)
            {
                _window.visible = true;
                _window.activate();
            };
        }

        private function onActivateBubble(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1421.deactivate();
            _window.activate();
        }

        private function onNext(_arg_1:WindowMouseEvent):void
        {
            if (!_SafeStr_1324)
            {
                return;
            };
            if (_SafeStr_1421)
            {
                _SafeStr_1421.visible = false;
            };
            _SafeStr_1324.removeHelpBubble(_SafeStr_698);
        }

        private function onLastBubble(_arg_1:WindowMouseEvent):void
        {
            if (!_SafeStr_1324)
            {
                return;
            };
            _SafeStr_1324.sendScriptProceedMessage();
            if (_SafeStr_1421)
            {
                _SafeStr_1421.visible = false;
            };
            _SafeStr_1324.removeHelpBubble(_SafeStr_698);
        }

        public function setModal(_arg_1:Rectangle):void
        {
            if (!_SafeStr_4296)
            {
                return;
            };
            var _local_3:BitmapData = new BitmapData(_SafeStr_1421.width, _SafeStr_1421.height, true, 0xFFE00000);
            var _local_2:BitmapData = new BitmapData(_arg_1.width, _arg_1.height, true, 0xFFFFFF);
            _local_3.copyPixels(_local_2, _local_2.rect, new Point(_arg_1.x, _arg_1.y));
            _SafeStr_4296.bitmap = _local_3;
            _SafeStr_4296.invalidate();
        }

        public function setPosition(_arg_1:Point):void
        {
            _SafeStr_4292 = _arg_1;
            _window.y = _SafeStr_4292.y;
            _window.x = (_SafeStr_4292.x - (_window.width / 2));
        }

        public function setArrowPos(_arg_1:String, _arg_2:int):void
        {
            _bubble.direction = _arg_1;
            _bubble.pointerOffset = (_arg_2 - 8);
        }

        public function setCallback(_arg_1:IWindow):void
        {
            if (_SafeStr_3639 != null)
            {
                return;
            };
            _SafeStr_4297 = _arg_1;
            if (!_SafeStr_4294)
            {
                _SafeStr_3639 = onLastBubble;
            }
            else
            {
                _SafeStr_3639 = onNext;
            };
            _SafeStr_4297.addEventListener("WME_CLICK", _SafeStr_3639);
        }

        public function setChatFieldCallback(_arg_1:ITextFieldWindow):void
        {
            if (_SafeStr_3639 != null)
            {
                return;
            };
            _SafeStr_4298 = _arg_1;
            if (!_SafeStr_4294)
            {
                _SafeStr_3639 = onLastBubble;
            }
            else
            {
                _SafeStr_3639 = onNext;
            };
            _SafeStr_4298.addEventListener("WME_CLICK", _SafeStr_3639);
        }

        public function getWindow():IWindowContainer
        {
            return (_window);
        }

        public function getName():String
        {
            return (_SafeStr_698);
        }


    }
}

