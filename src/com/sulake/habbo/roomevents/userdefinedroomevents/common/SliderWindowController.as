package com.sulake.habbo.roomevents.userdefinedroomevents.common
{
    import com.sulake.core.runtime.events.EventDispatcherWrapper;
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.Event;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components._SafeStr_143;
    import flash.geom.Point;
    import com.sulake.core.assets.BitmapDataAsset;

    public class SliderWindowController extends EventDispatcherWrapper 
    {

        private var _SafeStr_3667:Number = 0;
        private var _SafeStr_3666:IWindowContainer;
        private var _SafeStr_3668:Boolean = false;
        private var _SafeStr_3669:BitmapData;
        private var _sliderButton:BitmapData;
        private var _referenceWidth:int;
        private var _SafeStr_1624:Number = 0;
        private var _SafeStr_1625:Number = 1;
        private var _SafeStr_3670:Number = 0;

        public function SliderWindowController(_arg_1:HabboUserDefinedRoomEvents, _arg_2:IWindowContainer, _arg_3:IAssetLibrary, _arg_4:Number=0, _arg_5:Number=1, _arg_6:Number=0)
        {
            _SafeStr_3666 = IWindowContainer(_arg_1.getXmlWindow("ude_slider"));
            _arg_2.addChild(_SafeStr_3666);
            _SafeStr_1624 = _arg_4;
            _SafeStr_1625 = _arg_5;
            _SafeStr_3670 = _arg_6;
            _SafeStr_3667 = 0;
            storeAssets(_arg_3);
            displaySlider();
        }

        override public function dispose():void
        {
            super.dispose();
            _SafeStr_3666 = null;
            _SafeStr_3669 = null;
            _sliderButton = null;
        }

        public function setValue(_arg_1:Number, _arg_2:Boolean=true):void
        {
            _arg_1 = Math.max(_SafeStr_1624, _arg_1);
            _arg_1 = Math.min(_SafeStr_1625, _arg_1);
            _SafeStr_3667 = _arg_1;
            if (_arg_2)
            {
                updateSliderPosition();
            };
            dispatchEvent(new Event("change"));
        }

        public function getValue():Number
        {
            return (_SafeStr_3667);
        }

        public function set min(_arg_1:Number):void
        {
            _SafeStr_1624 = _arg_1;
        }

        public function set max(_arg_1:Number):void
        {
            _SafeStr_1625 = _arg_1;
        }

        private function updateSliderPosition():void
        {
            if (_SafeStr_3666 == null)
            {
                return;
            };
            var _local_1:IWindow = _SafeStr_3666.findChildByName("slider_button");
            if (_local_1 != null)
            {
                _local_1.x = getSliderPosition(_SafeStr_3667);
            };
            _local_1.parent.invalidate();
        }

        private function getSliderPosition(_arg_1:Number):int
        {
            return (int((_referenceWidth * ((_arg_1 - _SafeStr_1624) / (_SafeStr_1625 - _SafeStr_1624)))));
        }

        private function getValueAtPosition(_arg_1:Number):Number
        {
            return (((_arg_1 / _referenceWidth) * (_SafeStr_1625 - _SafeStr_1624)) + _SafeStr_1624);
        }

        private function sliderProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:Number;
            var _local_3:Number;
            if (_arg_1.type == "WME_DOWN")
            {
                _SafeStr_3668 = true;
            };
            if (_SafeStr_3668)
            {
                if (((_arg_1.type == "WME_UP") || (_arg_1.type == "WME_UP_OUTSIDE")))
                {
                    _SafeStr_3668 = false;
                };
            };
            if (((!(_SafeStr_3668)) || (!(_arg_1.type == "WE_RELOCATED"))))
            {
                return;
            };
            if (_SafeStr_3670 != 0)
            {
                _local_4 = getValueAtPosition(_arg_2.x);
                _local_3 = (Math.round((_local_4 / _SafeStr_3670)) * _SafeStr_3670);
                setValue(_local_3, false);
            };
        }

        private function sliderButtonRightProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:Number;
            if (_arg_1.type == "WME_CLICK")
            {
                _SafeStr_3668 = false;
                if (_SafeStr_3670 != 0)
                {
                    _local_3 = (_SafeStr_3667 + _SafeStr_3670);
                    setValue(_local_3);
                };
            };
        }

        private function sliderButtonLeftProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:Number;
            if (_arg_1.type == "WME_CLICK")
            {
                _SafeStr_3668 = false;
                if (_SafeStr_3670 != 0)
                {
                    _local_3 = (_SafeStr_3667 - _SafeStr_3670);
                    setValue(_local_3);
                };
            };
        }

        private function displaySlider():void
        {
            var _local_1:IWindowContainer;
            var _local_3:IBitmapWrapperWindow;
            var _local_4:_SafeStr_143;
            var _local_2:_SafeStr_143;
            if (_SafeStr_3666 == null)
            {
                return;
            };
            _local_3 = (_SafeStr_3666.findChildByName("slider_base") as IBitmapWrapperWindow);
            if (((!(_local_3 == null)) && (!(_SafeStr_3669 == null))))
            {
                _local_3.bitmap = new BitmapData(_SafeStr_3669.width, _SafeStr_3669.height, true, 0xFFFFFF);
                _local_3.bitmap.copyPixels(_SafeStr_3669, _SafeStr_3669.rect, new Point(0, 0), null, null, true);
            };
            _local_1 = (_SafeStr_3666.findChildByName("slider_movement_area") as IWindowContainer);
            if (_local_1 != null)
            {
                _local_3 = (_local_1.findChildByName("slider_button") as IBitmapWrapperWindow);
                if (((!(_local_3 == null)) && (!(_sliderButton == null))))
                {
                    _local_3.bitmap = new BitmapData(_sliderButton.width, _sliderButton.height, true, 0xFFFFFF);
                    _local_3.bitmap.copyPixels(_sliderButton, _sliderButton.rect, new Point(0, 0), null, null, true);
                    _local_3.procedure = sliderProcedure;
                    _referenceWidth = (_local_1.width - _local_3.width);
                };
            };
            _local_2 = (_SafeStr_3666.findChildByName("slider_button_left") as _SafeStr_143);
            if (_local_2)
            {
                _local_2.procedure = sliderButtonLeftProcedure;
            };
            _local_4 = (_SafeStr_3666.findChildByName("slider_button_right") as _SafeStr_143);
            if (_local_4)
            {
                _local_4.procedure = sliderButtonRightProcedure;
            };
        }

        private function storeAssets(_arg_1:IAssetLibrary):void
        {
            var _local_2:BitmapDataAsset;
            if (_arg_1 == null)
            {
                return;
            };
            _local_2 = BitmapDataAsset(_arg_1.getAssetByName("slider_bg_png"));
            _SafeStr_3669 = BitmapData(_local_2.content);
            _local_2 = BitmapDataAsset(_arg_1.getAssetByName("slider_obj_png"));
            _sliderButton = BitmapData(_local_2.content);
        }


    }
}

