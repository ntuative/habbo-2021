package com.sulake.habbo.ui.widget.memenu.soundsettings
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;

    public class MeMenuSoundSettingsItem implements IDisposable 
    {

        public static const TYPE_UI_VOLUME:int = 0;
        public static const TYPE_FURNI_VOLUME:int = 1;
        public static const TYPE_TRAX_VOLUME:int = 2;

        private var _SafeStr_741:int;
        private var _volume:Number;
        private var _window:IWindowContainer;
        private var _SafeStr_3664:MeMenuSoundSettingsSlider;
        private var _SafeStr_3782:MeMenuSoundSettingsView;

        public function MeMenuSoundSettingsItem(_arg_1:MeMenuSoundSettingsView, _arg_2:int, _arg_3:IWindowContainer):void
        {
            super();
            var _local_4:IWindow = null;
            _SafeStr_741 = _arg_2;
            _SafeStr_3782 = _arg_1;
            _window = _arg_3;
            _SafeStr_3664 = new MeMenuSoundSettingsSlider(this, (_window.findChildByName("volume_container") as IWindowContainer), _SafeStr_3782.widget.assets, 0, 1);
            _local_4 = _window.findChildByName("sounds_off");
            if (_local_4 != null)
            {
                _local_4.addEventListener("WME_CLICK", onButtonClicked);
                _local_4.addEventListener("WME_OVER", onButtonOver);
                _local_4.addEventListener("WME_OUT", onButtonOut);
            };
            _local_4 = _window.findChildByName("sounds_on");
            if (_local_4 != null)
            {
                _local_4.addEventListener("WME_CLICK", onButtonClicked);
                _local_4.addEventListener("WME_OVER", onButtonOver);
                _local_4.addEventListener("WME_OUT", onButtonOut);
            };
            updateSoundIcons();
        }

        public function dispose():void
        {
            if (!disposed)
            {
                if (_SafeStr_3664)
                {
                    _SafeStr_3664.dispose();
                    _SafeStr_3664 = null;
                };
                if (_window)
                {
                    _window.dispose();
                    _window = null;
                };
            };
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_3782 == null);
        }

        public function saveVolume(_arg_1:Number, _arg_2:Boolean):void
        {
            _volume = _arg_1;
            switch (_SafeStr_741)
            {
                case 0:
                    _SafeStr_3782.saveVolume(_arg_1, -1, -1, _arg_2);
                    break;
                case 1:
                    _SafeStr_3782.saveVolume(-1, _arg_1, -1, _arg_2);
                    break;
                case 2:
                    _SafeStr_3782.saveVolume(-1, -1, _arg_1, _arg_2);
                default:
            };
            updateSoundIcons();
        }

        private function updateSoundIcons():void
        {
            if (_volume == 0)
            {
                setBitmapWrapperContent("sounds_on_icon", _SafeStr_3782.soundsOnIconWhite);
                setBitmapWrapperContent("sounds_off_icon", _SafeStr_3782.soundsOffIconColor);
            }
            else
            {
                setBitmapWrapperContent("sounds_on_icon", _SafeStr_3782.soundsOnIconColor);
                setBitmapWrapperContent("sounds_off_icon", _SafeStr_3782.soundsOffIconWhite);
            };
        }

        private function onButtonOver(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            switch (_local_3)
            {
                case "sounds_off_icon":
                case "sounds_off":
                    setBitmapWrapperContent("sounds_off_icon", _SafeStr_3782.soundsOffIconColor);
                    return;
                case "sounds_on_icon":
                case "sounds_on":
                    setBitmapWrapperContent("sounds_on_icon", _SafeStr_3782.soundsOnIconColor);
                    return;
            };
        }

        private function onButtonOut(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            switch (_local_3)
            {
                case "sounds_off":
                    if (_volume != 0)
                    {
                        setBitmapWrapperContent("sounds_off_icon", _SafeStr_3782.soundsOffIconWhite);
                    };
                    return;
                case "sounds_on":
                    if (_volume != 1)
                    {
                        setBitmapWrapperContent("sounds_on_icon", _SafeStr_3782.soundsOnIconWhite);
                    };
                    return;
            };
        }

        private function onButtonClicked(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            switch (_local_3)
            {
                case "sounds_off":
                    saveVolume(0, false);
                    return;
                case "sounds_on":
                    saveVolume(1, false);
                    return;
                default:
                    Logger.log(("Me Menu Settings, Sound settings item: unknown button: " + _local_3));
                    return;
            };
        }

        private function setBitmapWrapperContent(_arg_1:String, _arg_2:BitmapData):void
        {
            var _local_3:IBitmapWrapperWindow = (_window.findChildByName(_arg_1) as IBitmapWrapperWindow);
            if (((!(_local_3 == null)) && (!(_arg_2 == null))))
            {
                _local_3.bitmap = _arg_2.clone();
            };
        }

        public function setValue(_arg_1:Number):void
        {
            _SafeStr_3664.setValue(_arg_1);
            updateSoundIcons();
        }


    }
}

