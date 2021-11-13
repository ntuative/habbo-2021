package com.sulake.habbo.ui.widget.infostand
{
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.core.window.IWindow;
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components._SafeStr_124;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.ui.widget.events.RoomWidgetSongUpdateEvent;

    public class InfoStandJukeboxView extends InfoStandFurniView 
    {

        private var _SafeStr_1789:int = -1;
        private var _songName:String = "";
        private var _SafeStr_4154:String = "";

        public function InfoStandJukeboxView(_arg_1:InfoStandWidget, _arg_2:String, _arg_3:IHabboCatalog)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        override public function dispose():void
        {
            super.dispose();
        }

        override protected function createWindow(_arg_1:String):void
        {
            var _local_2:IWindow;
            var _local_7:int;
            var _local_5:BitmapData;
            var _local_10:BitmapDataAsset;
            var _local_4:XmlAsset = (_SafeStr_1324.assets.getAssetByName("jukebox_view") as XmlAsset);
            _window = (_SafeStr_1324.windowManager.buildFromXML((_local_4.content as XML)) as IItemListWindow);
            if (_window == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            _SafeStr_1276 = (_window.getListItemByName("info_border") as _SafeStr_124);
            _buttons = (_window.getListItemByName("button_list") as IItemListWindow);
            if (_SafeStr_1276 != null)
            {
                _SafeStr_4145 = (_SafeStr_1276.findChildByName("infostand_element_list") as IItemListWindow);
            };
            _window.name = _arg_1;
            _SafeStr_1324.mainContainer.addChild(_window);
            var _local_3:IWindow = _SafeStr_1276.findChildByTag("close");
            if (_local_3 != null)
            {
                _local_3.addEventListener("WME_CLICK", onClose);
            };
            if (_buttons != null)
            {
                _local_7 = 0;
                while (_local_7 < _buttons.numListItems)
                {
                    _local_2 = _buttons.getListItemAt(_local_7);
                    _local_2.addEventListener("WME_CLICK", onButtonClicked);
                    _local_7++;
                };
            };
            _catalogButton = _SafeStr_1276.findChildByTag("catalog");
            if (_catalogButton != null)
            {
                _catalogButton.addEventListener("WME_CLICK", onCatalogButtonClicked);
            };
            _rentButton = _SafeStr_1276.findChildByName("rent_button");
            if (_rentButton != null)
            {
                _rentButton.addEventListener("WME_CLICK", onRentButtonClicked);
            };
            _extendButton = _SafeStr_1276.findChildByName("extend_button");
            if (_extendButton != null)
            {
                _extendButton.addEventListener("WME_CLICK", onExtendButtonClicked);
            };
            _buyoutButton = _SafeStr_1276.findChildByName("buyout_button");
            if (_buyoutButton != null)
            {
                _buyoutButton.addEventListener("WME_CLICK", onBuyoutButtonClicked);
            };
            var _local_6:IBitmapWrapperWindow = (_SafeStr_1276.findChildByName("icon_disc") as IBitmapWrapperWindow);
            if (_local_6 != null)
            {
                _local_10 = (_SafeStr_1324.assets.getAssetByName("jb_icon_disc") as BitmapDataAsset);
                _local_5 = (_local_10.content as BitmapData);
                _local_6.bitmap = _local_5.clone();
            };
            var _local_9:IBitmapWrapperWindow = (_SafeStr_1276.findChildByName("icon_composer") as IBitmapWrapperWindow);
            if (_local_9 != null)
            {
                _local_10 = (_SafeStr_1324.assets.getAssetByName("jb_icon_composer") as BitmapDataAsset);
                _local_5 = (_local_10.content as BitmapData);
                _local_9.bitmap = _local_5.clone();
            };
            var _local_8:IRegionWindow = (_SafeStr_4145.getListItemByName("owner_region") as IRegionWindow);
            if (_local_8 != null)
            {
                _local_8.addEventListener("WME_CLICK", onOwnerRegion);
                _local_8.addEventListener("WME_OVER", onOwnerRegion);
                _local_8.addEventListener("WME_OUT", onOwnerRegion);
            };
        }

        private function set nowPlayingTrackName(_arg_1:String):void
        {
            var _local_2:IWindowContainer = (_SafeStr_4145.getListItemByName("trackname_container") as IWindowContainer);
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:ITextWindow = (_local_2.getChildByName("track_name_text") as ITextWindow);
            if (_local_3 == null)
            {
                return;
            };
            _local_3.text = _arg_1;
            _local_3.visible = true;
            _local_3.height = (_local_3.textHeight + 5);
        }

        private function set nowPlayingAuthorName(_arg_1:String):void
        {
            var _local_2:IWindowContainer = (_SafeStr_4145.getListItemByName("creatorname_container") as IWindowContainer);
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:ITextWindow = (_local_2.getChildByName("track_creator_text") as ITextWindow);
            if (_local_3 == null)
            {
                return;
            };
            _local_3.text = _arg_1;
            _local_3.visible = true;
            _local_3.height = (_local_3.textHeight + 5);
        }

        public function updateSongInfo(_arg_1:RoomWidgetSongUpdateEvent):void
        {
            if (_arg_1.type == "RWSUE_PLAYING_CHANGED")
            {
                _SafeStr_1789 = _arg_1.songId;
            };
            if (_arg_1.songId == _SafeStr_1789)
            {
                _songName = _arg_1.songName;
                _SafeStr_4154 = _arg_1.songAuthor;
                updateNowPlaying((_SafeStr_1789 >= 0));
            };
        }

        private function updateNowPlaying(_arg_1:Boolean):void
        {
            var _local_2:String;
            var _local_3:ITextWindow = (_SafeStr_4145.getListItemByName("now_playing_text") as ITextWindow);
            if (_local_3 != null)
            {
                if (_arg_1)
                {
                    _local_2 = _SafeStr_1324.localizations.getLocalization("infostand.jukebox.text.now.playing");
                }
                else
                {
                    _local_2 = _SafeStr_1324.localizations.getLocalization("infostand.jukebox.text.not.playing");
                };
                _local_3.text = _local_2;
            };
            if (_arg_1)
            {
                nowPlayingTrackName = _songName;
                nowPlayingAuthorName = _SafeStr_4154;
            }
            else
            {
                nowPlayingTrackName = "";
                nowPlayingAuthorName = "";
            };
            updateWindow();
        }


    }
}

