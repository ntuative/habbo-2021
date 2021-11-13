package com.sulake.habbo.ui.widget.memenu.soundsettings
{
    import com.sulake.habbo.ui.widget.memenu.IMeMenuView;
    import com.sulake.habbo.ui.widget.memenu.MeMenuWidget;
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import com.sulake.habbo.ui.widget.events.RoomWidgetSettingsUpdateEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetSettingsMessage;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetStoreSettingsMessage;

    public class MeMenuSoundSettingsView implements IMeMenuView 
    {

        private var _widget:MeMenuWidget;
        private var _window:IWindowContainer;
        private var _SafeStr_3783:MeMenuSoundSettingsItem;
        private var _SafeStr_3784:MeMenuSoundSettingsItem;
        private var _SafeStr_3785:MeMenuSoundSettingsItem;
        private var _soundsOffIconColor:BitmapData;
        private var _soundsOffIconWhite:BitmapData;
        private var _soundsOnIconColor:BitmapData;
        private var _soundsOnIconWhite:BitmapData;
        private var _genericVolume:Number = 1;
        private var _furniVolume:Number = 1;
        private var _traxVolume:Number = 1;


        public function init(_arg_1:MeMenuWidget, _arg_2:String):void
        {
            _widget = _arg_1;
            createWindow(_arg_2);
        }

        public function dispose():void
        {
            saveVolume(_genericVolume, _furniVolume, _traxVolume);
            _widget = null;
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

        public function updateSettings(_arg_1:RoomWidgetSettingsUpdateEvent):void
        {
            _genericVolume = _arg_1.uiVolume;
            _furniVolume = _arg_1.furniVolume;
            _traxVolume = _arg_1.traxVolume;
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

        private function createWindow(_arg_1:String):void
        {
            var _local_2:IWindow;
            var _local_5:int;
            var _local_4:BitmapDataAsset;
            var _local_3:XmlAsset = (_widget.assets.getAssetByName("memenu_settings") as XmlAsset);
            if (_local_3)
            {
                _window = (_widget.windowManager.buildFromXML((_local_3.content as XML)) as IWindowContainer);
            };
            if (_window == null)
            {
                throw (new Error("Failed to construct sound settings window from XML!"));
            };
            _window.name = _arg_1;
            _local_5 = 0;
            while (_local_5 < _window.numChildren)
            {
                _local_2 = _window.getChildAt(_local_5);
                _local_2.addEventListener("WME_CLICK", onButtonClicked);
                _local_5++;
            };
            _local_4 = (_widget.assets.getAssetByName("sounds_off_color") as BitmapDataAsset);
            if (((!(_local_4 == null)) && (!(_local_4.content == null))))
            {
                _soundsOffIconColor = (_local_4.content as BitmapData).clone();
            };
            _local_4 = (_widget.assets.getAssetByName("sounds_off_white") as BitmapDataAsset);
            if (((!(_local_4 == null)) && (!(_local_4.content == null))))
            {
                _soundsOffIconWhite = (_local_4.content as BitmapData).clone();
            };
            _local_4 = (_widget.assets.getAssetByName("sounds_on_color") as BitmapDataAsset);
            if (((!(_local_4 == null)) && (!(_local_4.content == null))))
            {
                _soundsOnIconColor = (_local_4.content as BitmapData).clone();
            };
            _local_4 = (_widget.assets.getAssetByName("sounds_on_white") as BitmapDataAsset);
            if (((!(_local_4 == null)) && (!(_local_4.content == null))))
            {
                _soundsOnIconWhite = (_local_4.content as BitmapData).clone();
            };
            _SafeStr_3783 = new MeMenuSoundSettingsItem(this, 0, uiVolumeContainer);
            _SafeStr_3784 = new MeMenuSoundSettingsItem(this, 1, furniVolumeContainer);
            _SafeStr_3785 = new MeMenuSoundSettingsItem(this, 2, traxVolumeContainer);
            _widget.messageListener.processWidgetMessage(new RoomWidgetGetSettingsMessage("RWGSM_GET_SETTINGS"));
        }

        private function onButtonClicked(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            switch (_local_3)
            {
                case "back_btn":
                    _widget.changeView("me_menu_settings_view");
                    return;
                default:
                    Logger.log(("Me Menu Settings View: unknown button: " + _local_3));
                    return;
            };
        }

        public function saveVolume(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Boolean=true):void
        {
            var _local_5:RoomWidgetStoreSettingsMessage;
            if (_arg_4)
            {
                _local_5 = new RoomWidgetStoreSettingsMessage("RWSSM_STORE_SOUND");
            }
            else
            {
                _local_5 = new RoomWidgetStoreSettingsMessage("RWSSM_PREVIEW_SOUND");
            };
            _local_5.genericVolume = ((_arg_1 != -1) ? _arg_1 : _genericVolume);
            _local_5.furniVolume = ((_arg_2 != -1) ? _arg_2 : _furniVolume);
            _local_5.traxVolume = ((_arg_3 != -1) ? _arg_3 : _traxVolume);
            _widget.messageListener.processWidgetMessage(_local_5);
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

        public function get widget():MeMenuWidget
        {
            return (_widget);
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


    }
}

