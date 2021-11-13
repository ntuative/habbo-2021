package com.sulake.habbo.ui.widget.playlisteditor
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.IWindow;
    import flash.events.IEventDispatcher;
    import flash.geom.ColorTransform;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPlayListModificationMessage;
    import com.sulake.habbo.sound.IPlayListController;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPlayListPlayStateMessage;
    import com.sulake.habbo.sound.ISongInfo;
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPlayListUserActionMessage;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPlayListEditorEvent;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPlayListEditorNowPlayingEvent;

    public class PlayListEditorWidget extends RoomWidgetBase 
    {

        private static const DISK_COLOR_RED_MIN:int = 130;
        private static const DISK_COLOR_RED_RANGE:int = 100;
        private static const DISK_COLOR_GREEN_MIN:int = 130;
        private static const DISK_COLOR_GREEN_RANGE:int = 100;
        private static const DISK_COLOR_BLUE_MIN:int = 130;
        private static const DISK_COLOR_BLUE_RANGE:int = 100;

        private var _catalog:IHabboCatalog;
        private var _configuration:ICoreConfiguration;
        private var _soundManager:IHabboSoundManager;
        private var _mainWindowHandler:MainWindowHandler;
        private var _SafeStr_1936:int;

        public function PlayListEditorWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IHabboSoundManager, _arg_4:IAssetLibrary, _arg_5:IHabboLocalizationManager, _arg_6:ICoreConfiguration, _arg_7:IHabboCatalog)
        {
            super(_arg_1, _arg_2, _arg_4, _arg_5);
            _soundManager = _arg_3;
            _configuration = _arg_6;
            _catalog = _arg_7;
            _mainWindowHandler = null;
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                if (_mainWindowHandler)
                {
                    _mainWindowHandler.destroy();
                    _mainWindowHandler = null;
                };
                _soundManager = null;
                super.dispose();
            };
        }

        override public function get mainWindow():IWindow
        {
            if (_mainWindowHandler == null)
            {
                return (null);
            };
            return (_mainWindowHandler.window);
        }

        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            _arg_1.addEventListener("RWPLEE_SHOW_PLAYLIST_EDITOR", onShowPlayListEditorEvent);
            _arg_1.addEventListener("RWPLEE_HIDE_PLAYLIST_EDITOR", onHidePlayListEditorEvent);
            _arg_1.addEventListener("RWPLEE_INVENTORY_UPDATED", onInventoryUpdatedEvent);
            _arg_1.addEventListener("RWPLEE_SONG_DISK_INVENTORY_UPDATED", onSongDiskInventoryUpdatedEvent);
            _arg_1.addEventListener("RWPLEE_PLAY_LIST_UPDATED", onPlayListUpdatedEvent);
            _arg_1.addEventListener("RWPLEE_PLAY_LIST_FULL", onPlayListFullEvent);
            _arg_1.addEventListener("RWPLENPE_SONG_CHANGED", onNowPlayingChangedEvent);
            _arg_1.addEventListener("RWPLENPE_USER_PLAY_SONG", onNowPlayingChangedEvent);
            _arg_1.addEventListener("RWPLENPW_USER_STOP_SONG", onNowPlayingChangedEvent);
        }

        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            _arg_1.removeEventListener("RWPLEE_SHOW_PLAYLIST_EDITOR", onShowPlayListEditorEvent);
            _arg_1.removeEventListener("RWPLEE_HIDE_PLAYLIST_EDITOR", onHidePlayListEditorEvent);
            _arg_1.removeEventListener("RWPLEE_INVENTORY_UPDATED", onInventoryUpdatedEvent);
            _arg_1.removeEventListener("RWPLEE_SONG_DISK_INVENTORY_UPDATED", onSongDiskInventoryUpdatedEvent);
            _arg_1.removeEventListener("RWPLEE_PLAY_LIST_UPDATED", onPlayListUpdatedEvent);
            _arg_1.removeEventListener("RWPLEE_PLAY_LIST_FULL", onPlayListFullEvent);
            _arg_1.removeEventListener("RWPLENPE_SONG_CHANGED", onNowPlayingChangedEvent);
            _arg_1.removeEventListener("RWPLENPE_USER_PLAY_SONG", onNowPlayingChangedEvent);
            _arg_1.removeEventListener("RWPLENPW_USER_STOP_SONG", onNowPlayingChangedEvent);
        }

        public function get mainWindowHandler():MainWindowHandler
        {
            return (_mainWindowHandler);
        }

        public function getDiskColorTransformFromSongData(_arg_1:String):ColorTransform
        {
            var _local_5:int;
            var _local_2:uint;
            var _local_4:uint;
            var _local_3:uint;
            _local_5 = 0;
            while (_local_5 < _arg_1.length)
            {
                switch ((_local_5 % 3))
                {
                    case 0:
                        _local_2 = (_local_2 + ((_arg_1.charCodeAt(_local_5) * 37) as int));
                        break;
                    case 1:
                        _local_4 = (_local_4 + ((_arg_1.charCodeAt(_local_5) * 37) as int));
                        break;
                    case 2:
                        _local_3 = (_local_3 + ((_arg_1.charCodeAt(_local_5) * 37) as int));
                };
                _local_5++;
            };
            _local_2 = ((_local_2 % 100) + 130);
            _local_4 = ((_local_4 % 100) + 130);
            _local_3 = ((_local_3 % 100) + 130);
            return (new ColorTransform((_local_2 / 0xFF), (_local_4 / 0xFF), (_local_3 / 0xFF)));
        }

        public function sendAddToPlayListMessage(_arg_1:int):void
        {
            var _local_3:int;
            var _local_4:RoomWidgetPlayListModificationMessage;
            var _local_2:IPlayListController = _soundManager.musicController.getRoomItemPlaylist();
            if (_local_2 != null)
            {
                _local_3 = _local_2.length;
                _local_4 = new RoomWidgetPlayListModificationMessage("RWPLAM_ADD_TO_PLAYLIST", _local_3, _arg_1);
                if (messageListener != null)
                {
                    messageListener.processWidgetMessage(_local_4);
                };
            };
        }

        public function sendRemoveFromPlayListMessage(_arg_1:int):void
        {
            var _local_2:RoomWidgetPlayListModificationMessage = new RoomWidgetPlayListModificationMessage("RWPLAM_REMOVE_FROM_PLAYLIST", _arg_1);
            if (messageListener != null)
            {
                messageListener.processWidgetMessage(_local_2);
            };
        }

        public function sendTogglePlayPauseStateMessage():void
        {
            var _local_1:int;
            if (((!(_mainWindowHandler == null)) && (!(_mainWindowHandler.playListEditorView == null))))
            {
                _local_1 = ((_mainWindowHandler.playListEditorView.selectedItemIndex != -1) ? _mainWindowHandler.playListEditorView.selectedItemIndex : 0);
            };
            var _local_2:RoomWidgetPlayListPlayStateMessage = new RoomWidgetPlayListPlayStateMessage("RWPLPS_TOGGLE_PLAY_PAUSE", _SafeStr_1936, _local_1);
            if (messageListener != null)
            {
                messageListener.processWidgetMessage(_local_2);
            };
        }

        public function playUserSong(_arg_1:int):void
        {
            var _local_2:ISongInfo;
            var _local_3:int = _soundManager.musicController.getSongIdPlayingAtPriority(0);
            if (_local_3 != -1)
            {
                _local_2 = _soundManager.musicController.getSongInfo(_local_3);
                if (_local_2.soundObject != null)
                {
                    _local_2.soundObject.fadeOutSeconds = 0;
                };
            };
            _soundManager.musicController.playSong(_arg_1, 2, 0, 0, 0, 0);
        }

        public function stopUserSong():void
        {
            _soundManager.musicController.stop(2);
        }

        public function getImageGalleryAssetBitmap(_arg_1:String):BitmapData
        {
            var _local_2:BitmapData;
            var _local_3:BitmapDataAsset = (this.assets.getAssetByName(_arg_1) as BitmapDataAsset);
            if (_local_3 == null)
            {
                return (null);
            };
            _local_2 = (_local_3.content as BitmapData);
            return (_local_2.clone());
        }

        public function retrieveWidgetImage(_arg_1:String):void
        {
            var _local_4:String = _configuration.getProperty("image.library.playlist.url");
            var _local_5:String = ((_local_4 + _arg_1) + ".gif");
            Logger.log(("[PlayListEditorWidget]  : " + _local_5));
            var _local_2:URLRequest = new URLRequest(_local_5);
            var _local_3:AssetLoaderStruct = this.assets.loadAssetFromFile(_arg_1, _local_2, "image/gif");
            _local_3.addEventListener("AssetLoaderEventComplete", onWidgetImageReady);
        }

        public function openSongDiskShopCataloguePage():void
        {
            var _local_1:RoomWidgetPlayListUserActionMessage = new RoomWidgetPlayListUserActionMessage("RWPLUA_OPEN_CATALOGUE_BUTTON_PRESSED");
            if (messageListener != null)
            {
                messageListener.processWidgetMessage(_local_1);
            };
            _catalog.openCatalogPage("trax_songs");
        }

        public function alertPlayListFull():void
        {
            this.windowManager.alert("${playlist.editor.alert.playlist.full.title}", "${playlist.editor.alert.playlist.full}", 0, alertHandler);
        }

        private function alertHandler(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }

        private function onShowPlayListEditorEvent(_arg_1:RoomWidgetPlayListEditorEvent):void
        {
            var _local_2:IPlayListController;
            _SafeStr_1936 = _arg_1.furniId;
            if (!_mainWindowHandler)
            {
                _mainWindowHandler = new MainWindowHandler(this, _soundManager.musicController);
                _mainWindowHandler.window.visible = false;
            };
            if (!_mainWindowHandler.window.visible)
            {
                _mainWindowHandler.show();
                _soundManager.musicController.requestUserSongDisks();
                _local_2 = _soundManager.musicController.getRoomItemPlaylist();
                if (_local_2 != null)
                {
                    _local_2.requestPlayList();
                };
            };
        }

        private function onHidePlayListEditorEvent(_arg_1:RoomWidgetPlayListEditorEvent):void
        {
            if (_mainWindowHandler != null)
            {
                if (_mainWindowHandler.window.visible)
                {
                    _mainWindowHandler.hide();
                };
            };
        }

        private function onInventoryUpdatedEvent(_arg_1:RoomWidgetPlayListEditorEvent):void
        {
            if (!_mainWindowHandler)
            {
                return;
            };
            if (_mainWindowHandler.window.visible)
            {
                _soundManager.musicController.requestUserSongDisks();
            };
        }

        private function onWidgetImageReady(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:AssetLoaderStruct;
            if (_arg_1.type == "AssetLoaderEventComplete")
            {
                _local_2 = (_arg_1.target as AssetLoaderStruct);
                if (_local_2 != null)
                {
                    if (_mainWindowHandler != null)
                    {
                        _mainWindowHandler.refreshLoadableAsset(_local_2.assetName);
                    };
                };
            };
        }

        private function onSongDiskInventoryUpdatedEvent(_arg_1:RoomWidgetPlayListEditorEvent):void
        {
            if (_mainWindowHandler)
            {
                _mainWindowHandler.onSongDiskInventoryReceived();
            };
        }

        private function onPlayListUpdatedEvent(_arg_1:RoomWidgetPlayListEditorEvent):void
        {
            if (_mainWindowHandler)
            {
                _mainWindowHandler.onPlayListUpdated();
            };
        }

        private function onPlayListFullEvent(_arg_1:RoomWidgetPlayListEditorEvent):void
        {
            alertPlayListFull();
        }

        private function onNowPlayingChangedEvent(_arg_1:RoomWidgetPlayListEditorNowPlayingEvent):void
        {
            if (_mainWindowHandler)
            {
                _mainWindowHandler.onNowPlayingChanged(_arg_1);
            };
        }


    }
}

