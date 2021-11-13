package com.sulake.habbo.toolbar.memenu.soundsettings
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;

    public class MeMenuSoundSettingsSlider 
    {

        private var _SafeStr_3796:*;
        private var _SafeStr_3666:IWindowContainer;
        private var _referenceWidth:int;
        private var _SafeStr_1624:Number = 0;
        private var _SafeStr_1625:Number = 1;

        public function MeMenuSoundSettingsSlider(_arg_1:*, _arg_2:IWindowContainer, _arg_3:IAssetLibrary, _arg_4:Number=0, _arg_5:Number=1)
        {
            _SafeStr_3796 = _arg_1;
            _SafeStr_3666 = _arg_2;
            _SafeStr_1624 = _arg_4;
            _SafeStr_1625 = _arg_5;
            displaySlider();
        }

        public function dispose():void
        {
            _SafeStr_3796 = null;
            _SafeStr_3666 = null;
        }

        public function setValue(_arg_1:Number):void
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

        private function getSliderPosition(_arg_1:Number):int
        {
            return (int((_referenceWidth * ((_arg_1 - _SafeStr_1624) / (_SafeStr_1625 - _SafeStr_1624)))));
        }

        private function getValue(_arg_1:Number):Number
        {
            return (((_arg_1 / _referenceWidth) * (_SafeStr_1625 - _SafeStr_1624)) + _SafeStr_1624);
        }

        private function buttonProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WE_RELOCATED")
            {
                return;
            };
            _SafeStr_3796.saveVolume(getValue(_arg_2.x), false);
        }

        private function displaySlider():void
        {
            var _local_2:IWindowContainer;
            var _local_1:IWindowContainer;
            if (_SafeStr_3666 == null)
            {
                return;
            };
            _local_2 = (_SafeStr_3666.findChildByName("slider_movement_area") as IWindowContainer);
            if (_local_2 != null)
            {
                _local_1 = (_local_2.findChildByName("slider_button") as IWindowContainer);
                if (_local_1 != null)
                {
                    _local_1.procedure = buttonProcedure;
                    _referenceWidth = (_local_2.width - _local_1.width);
                };
            };
        }


    }
}

