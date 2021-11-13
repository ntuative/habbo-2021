package com.sulake.habbo.toolbar.extensions.settings
{
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import com.sulake.habbo.toolbar.HabboToolbar;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class SoundSettingsView 
    {

        private var _window:IWindowContainer;
        private var _SafeStr_3783:SoundSettingsItem;
        private var _SafeStr_3784:SoundSettingsItem;
        private var _SafeStr_3785:SoundSettingsItem;
        private var _soundsOffIconColor:BitmapData;
        private var _soundsOffIconWhite:BitmapData;
        private var _soundsOnIconColor:BitmapData;
        private var _soundsOnIconWhite:BitmapData;
        private var _genericVolume:Number = 1;
        private var _furniVolume:Number = 1;
        private var _traxVolume:Number = 1;
        private var _toolbar:HabboToolbar;

        public function SoundSettingsView(_arg_1:HabboToolbar)
        {
            _toolbar = _arg_1;
            createWindow();
        }

        public function dispose():void
        {
            saveVolume(_genericVolume, _furniVolume, _traxVolume);
            if (_window != null)
            {
                _window.dispose();
            };
            _window = null;
            if (_SafeStr_3783 != null)
            {
                _SafeStr_3783.dispose();
            };
            _SafeStr_3783 = null;
            if (_SafeStr_3784 != null)
            {
                _SafeStr_3784.dispose();
            };
            _SafeStr_3784 = null;
            if (_SafeStr_3785 != null)
            {
                _SafeStr_3785.dispose();
            };
            _SafeStr_3785 = null;
            if (_soundsOffIconColor)
            {
                _soundsOffIconColor.dispose();
                _soundsOffIconColor = null;
            };
            if (_soundsOffIconWhite)
            {
                _soundsOffIconWhite.dispose();
                _soundsOffIconWhite = null;
            };
            if (_soundsOnIconColor)
            {
                _soundsOnIconColor.dispose();
                _soundsOnIconColor = null;
            };
            if (_soundsOnIconWhite)
            {
                _soundsOnIconWhite.dispose();
                _soundsOnIconWhite = null;
            };
        }

        public function get window():IWindowContainer
        {
            return (_window);
        }

        public function updateSettings():void
        {
            _genericVolume = _toolbar.soundManager.genericVolume;
            _furniVolume = _toolbar.soundManager.furniVolume;
            _traxVolume = _toolbar.soundManager.traxVolume;
            if (_SafeStr_3783 != null)
            {
                _SafeStr_3783.setValue(_genericVolume);
            };
            if (_SafeStr_3784 != null)
            {
                _SafeStr_3784.setValue(_furniVolume);
            };
            if (_SafeStr_3785 != null)
            {
                _SafeStr_3785.setValue(_traxVolume);
            };
        }

        private function createWindow():void
        {
            var _local_1:IWindow;
            var _local_3:int;
            var _local_2:XmlAsset = (_toolbar.assets.getAssetByName("me_menu_sound_settings_xml") as XmlAsset);
            _window = (_toolbar.windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
            _local_3 = 0;
            while (_local_3 < _window.numChildren)
            {
                _local_1 = _window.getChildAt(_local_3);
                _local_1.addEventListener("WME_CLICK", onButtonClicked);
                _local_3++;
            };
            _SafeStr_3783 = new SoundSettingsItem(this, 0, uiVolumeContainer);
            _SafeStr_3784 = new SoundSettingsItem(this, 1, furniVolumeContainer);
            _SafeStr_3785 = new SoundSettingsItem(this, 2, traxVolumeContainer);
            updateSettings();
        }

        private function onButtonClicked(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            Logger.log(_local_3);
            switch (_local_3)
            {
                case "back_btn":
                    dispose();
                    return;
                default:
                    Logger.log(("Me Menu Settings View: unknown button: " + _local_3));
                    return;
            };
        }

        public function saveVolume(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Boolean=true):void
        {
            var _local_6:Number = ((_arg_2 != -1) ? _arg_2 : _furniVolume);
            var _local_5:Number = ((_arg_1 != -1) ? _arg_1 : _genericVolume);
            var _local_7:Number = ((_arg_3 != -1) ? _arg_3 : _traxVolume);
            if (_arg_4)
            {
                if (_toolbar == null)
                {
                    return;
                };
                _toolbar.soundManager.furniVolume = _local_6;
                _toolbar.soundManager.genericVolume = _local_5;
                _toolbar.soundManager.traxVolume = _local_7;
            }
            else
            {
                _toolbar.soundManager.previewVolume(_local_5, _local_6, _local_7);
            };
        }

        public function updateUnseenItemCount(_arg_1:String, _arg_2:int):void
        {
        }

        public function get uiVolumeContainer():IWindowContainer
        {
            return (_window.findChildByName("ui_volume_container") as IWindowContainer);
        }

        public function get furniVolumeContainer():IWindowContainer
        {
            return (_window.findChildByName("furni_volume_container") as IWindowContainer);
        }

        public function get traxVolumeContainer():IWindowContainer
        {
            return (_window.findChildByName("trax_volume_container") as IWindowContainer);
        }

        public function get soundsOffIconColor():BitmapData
        {
            return (_soundsOffIconColor);
        }

        public function get soundsOffIconWhite():BitmapData
        {
            return (_soundsOffIconWhite);
        }

        public function get soundsOnIconColor():BitmapData
        {
            return (_soundsOnIconColor);
        }

        public function get soundsOnIconWhite():BitmapData
        {
            return (_soundsOnIconWhite);
        }

        public function get toolbar():HabboToolbar
        {
            return (_toolbar);
        }


    }
}

