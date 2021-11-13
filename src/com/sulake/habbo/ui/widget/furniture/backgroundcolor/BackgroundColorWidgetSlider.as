package com.sulake.habbo.ui.widget.furniture.backgroundcolor
{
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;

    public class BackgroundColorWidgetSlider 
    {

        private static const _SafeStr_1624:int = 0;
        private static const _SafeStr_1625:int = 0xFF;

        private var _SafeStr_1324:BackgroundColorFurniWidget;
        private var _SafeStr_3666:IWindowContainer;
        private var _SafeStr_4061:String;
        private var _SafeStr_3669:BitmapData;
        private var _sliderButton:BitmapData;
        private var _referenceWidth:int;
        private var _SafeStr_3941:int;

        public function BackgroundColorWidgetSlider(_arg_1:BackgroundColorFurniWidget, _arg_2:String, _arg_3:IWindowContainer, _arg_4:int=0)
        {
            super();
            var _local_5:BitmapDataAsset = null;
            _SafeStr_1324 = _arg_1;
            _SafeStr_4061 = _arg_2;
            _SafeStr_3666 = _arg_3;
            _local_5 = BitmapDataAsset(_arg_1.assets.getAssetByName("dimmer_slider_base"));
            _SafeStr_3669 = BitmapData(_local_5.content);
            _local_5 = BitmapDataAsset(_arg_1.assets.getAssetByName("dimmer_slider_button"));
            _sliderButton = BitmapData(_local_5.content);
            displaySlider();
            setValue(_arg_4);
        }

        public function dispose():void
        {
            _SafeStr_1324 = null;
            _SafeStr_3666 = null;
            _SafeStr_3669 = null;
            _sliderButton = null;
        }

        public function setValue(_arg_1:int):void
        {
            if (_SafeStr_3666 == null)
            {
                return;
            };
            var _local_2:IWindow = _SafeStr_3666.findChildByName("slider_button");
            if (_local_2 != null)
            {
                _local_2.x = getSliderPosition(_arg_1);
            };
        }

        private function getSliderPosition(_arg_1:int):int
        {
            return (int((_referenceWidth * ((_arg_1 - 0) / (0xFF - 0)))));
        }

        private function getValue(_arg_1:Number):int
        {
            return (int(((_arg_1 / _referenceWidth) * (0xFF - 0))) + 0);
        }

        private function buttonProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            _SafeStr_1324.setParameterCallback(_SafeStr_4061, getValue(_arg_2.x));
        }

        private function displaySlider():void
        {
            var _local_2:IWindowContainer;
            var _local_1:IBitmapWrapperWindow;
            if (_SafeStr_3666 == null)
            {
                return;
            };
            _local_1 = (_SafeStr_3666.findChildByName("slider_base") as IBitmapWrapperWindow);
            if (((!(_local_1 == null)) && (!(_SafeStr_3669 == null))))
            {
                _local_1.bitmap = new BitmapData(_SafeStr_3669.width, _SafeStr_3669.height, true, 0xFFFFFF);
                _local_1.bitmap.copyPixels(_SafeStr_3669, _SafeStr_3669.rect, new Point(0, 0), null, null, true);
            };
            _local_2 = (_SafeStr_3666.findChildByName("slider_movement_area") as IWindowContainer);
            if (_local_2 != null)
            {
                _local_1 = (_local_2.findChildByName("slider_button") as IBitmapWrapperWindow);
                if (((!(_local_1 == null)) && (!(_sliderButton == null))))
                {
                    _local_1.bitmap = new BitmapData(_sliderButton.width, _sliderButton.height, true, 0xFFFFFF);
                    _local_1.bitmap.copyPixels(_sliderButton, _sliderButton.rect, new Point(0, 0), null, null, true);
                    _local_1.procedure = buttonProcedure;
                    _referenceWidth = (_local_2.width - _local_1.width);
                };
            };
        }


    }
}

