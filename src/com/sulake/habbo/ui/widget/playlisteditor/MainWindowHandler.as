package com.sulake.habbo.ui.widget.playlisteditor
{
    import com.sulake.habbo.sound.IHabboMusicController;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components._SafeStr_124;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.sound.IPlayListController;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.XmlAsset;
    import flash.geom.Point;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPlayListEditorNowPlayingEvent;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class MainWindowHandler 
    {

        private static const SHOW_BUY_MORE_MUSIC_DISK_COUNT:int = 6;
        private static const MY_MUSIC_SHOW_SCROLLBAR_ITEM_COUNT_LIMIT:int = 9;
        private static const PLAYLIST_SHOW_SCROLLBAR_ITEM_COUNT_LIMIT:int = 5;

        private var _SafeStr_1324:PlayListEditorWidget;
        private var _SafeStr_3735:IHabboMusicController;
        private var _window:IWindowContainer;
        private var _SafeStr_4213:_SafeStr_124;
        private var _SafeStr_4214:_SafeStr_124;
        private var _musicInventoryView:MusicInventoryGridView;
        private var _playListEditorView:PlayListEditorItemListView;
        private var _SafeStr_4215:MusicInventoryStatusView;
        private var _SafeStr_4216:PlayListStatusView;
        private var _SafeStr_4217:IScrollbarWindow;
        private var _SafeStr_4218:IScrollbarWindow;

        public function MainWindowHandler(_arg_1:PlayListEditorWidget, _arg_2:IHabboMusicController)
        {
            super();
            var _local_3:BitmapData = null;
            _SafeStr_1324 = _arg_1;
            _SafeStr_3735 = _arg_2;
            var _local_5:Array = ["title_mymusic", "title_playlist", "background_preview_playing", "background_get_more_music", "background_add_songs"];
            for each (var _local_4:String in _local_5)
            {
                _local_3 = _SafeStr_1324.getImageGalleryAssetBitmap(_local_4);
                if (_local_3 != null)
                {
                    _local_3.dispose();
                }
                else
                {
                    _SafeStr_1324.retrieveWidgetImage(_local_4);
                };
            };
            createWindow();
            _musicInventoryView = new MusicInventoryGridView(_arg_1, getMusicInventoryGrid(), _arg_2);
            _playListEditorView = new PlayListEditorItemListView(_arg_1, getPlayListEditorItemList());
            _SafeStr_4215 = new MusicInventoryStatusView(_arg_1, getMusicInventoryStatusContainer());
            _SafeStr_4216 = new PlayListStatusView(_arg_1, getPlayListStatusContainer());
            refreshLoadableAsset();
        }

        public function get window():IWindow
        {
            return (_window);
        }

        public function get musicInventoryView():MusicInventoryGridView
        {
            return (_musicInventoryView);
        }

        public function get playListEditorView():PlayListEditorItemListView
        {
            return (_playListEditorView);
        }

        public function destroy():void
        {
            if (_SafeStr_3735)
            {
                _SafeStr_3735.stop(2);
                _SafeStr_3735 = null;
            };
            if (_musicInventoryView)
            {
                _musicInventoryView.destroy();
                _musicInventoryView = null;
            };
            if (_playListEditorView)
            {
                _playListEditorView.destroy();
                _playListEditorView = null;
            };
            if (_SafeStr_4216)
            {
                _SafeStr_4216.destroy();
                _SafeStr_4216 = null;
            };
            if (_SafeStr_4215)
            {
                _SafeStr_4215.destroy();
                _SafeStr_4215 = null;
            };
            _window.destroy();
            _window = null;
        }

        public function hide():void
        {
            _window.visible = false;
            if (_SafeStr_1324 != null)
            {
                _SafeStr_1324.stopUserSong();
            };
        }

        public function show():void
        {
            _SafeStr_3735.requestUserSongDisks();
            var _local_1:IPlayListController = _SafeStr_3735.getRoomItemPlaylist();
            if (_local_1 != null)
            {
                _local_1.requestPlayList();
                selectPlayListStatusViewByFurniPlayListState();
            };
            _window.visible = true;
        }

        public function refreshLoadableAsset(_arg_1:String=""):void
        {
            if (((_arg_1 == "") || (_arg_1 == "title_mymusic")))
            {
                assignWindowBitmapByAsset(_SafeStr_4213, "music_inventory_splash_image", "title_mymusic");
            };
            if (((_arg_1 == "") || (_arg_1 == "title_playlist")))
            {
                assignWindowBitmapByAsset(_SafeStr_4214, "playlist_editor_splash_image", "title_playlist");
            };
            if (((_arg_1 == "") || (_arg_1 == "background_preview_playing")))
            {
                _SafeStr_4215.setPreviewPlayingBackgroundImage(_SafeStr_1324.getImageGalleryAssetBitmap("background_preview_playing"));
            };
            if (((_arg_1 == "") || (_arg_1 == "background_get_more_music")))
            {
                _SafeStr_4215.setGetMoreMusicBackgroundImage(_SafeStr_1324.getImageGalleryAssetBitmap("background_get_more_music"));
            };
            if (((_arg_1 == "") || (_arg_1 == "background_add_songs")))
            {
                _SafeStr_4216.addSongsBackgroundImage = _SafeStr_1324.getImageGalleryAssetBitmap("background_add_songs");
            };
        }

        private function assignWindowBitmapByAsset(_arg_1:IWindowContainer, _arg_2:String, _arg_3:String):void
        {
            var _local_4:BitmapData;
            var _local_5:IBitmapWrapperWindow = (_arg_1.getChildByName(_arg_2) as IBitmapWrapperWindow);
            if (_local_5 != null)
            {
                _local_4 = _SafeStr_1324.getImageGalleryAssetBitmap(_arg_3);
                if (_local_4 != null)
                {
                    _local_5.bitmap = _local_4;
                    _local_5.width = _local_4.width;
                    _local_5.height = _local_4.height;
                };
            };
        }

        private function createWindow():void
        {
            if (_SafeStr_1324 == null)
            {
                return;
            };
            var _local_2:XmlAsset = (_SafeStr_1324.assets.getAssetByName("playlisteditor_main_window") as XmlAsset);
            _window = (_SafeStr_1324.windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
            if (_window == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            _window.position = new Point(80, 0);
            var _local_3:IWindowContainer = (_window.getChildByName("content_area") as IWindowContainer);
            if (_local_3 == null)
            {
                throw (new Error("Window is missing 'content_area' element"));
            };
            _SafeStr_4213 = (_local_3.getChildByName("my_music_border") as _SafeStr_124);
            _SafeStr_4214 = (_local_3.getChildByName("playlist_border") as _SafeStr_124);
            if (_SafeStr_4213 == null)
            {
                throw (new Error("Window content area is missing 'my_music_border' window element"));
            };
            if (_SafeStr_4214 == null)
            {
                throw (new Error("Window content area is missing 'playlist_border' window element"));
            };
            _SafeStr_4217 = (_SafeStr_4213.getChildByName("music_inventory_scrollbar") as IScrollbarWindow);
            _SafeStr_4218 = (_SafeStr_4214.getChildByName("playlist_scrollbar") as IScrollbarWindow);
            if (_SafeStr_4217 == null)
            {
                throw (new Error("Window content area is missing 'music_inventory_scrollbar' window element"));
            };
            if (_SafeStr_4218 == null)
            {
                throw (new Error("Window content area is missing 'playlist_scrollbar' window element"));
            };
            var _local_1:IWindow = _window.findChildByTag("close");
            if (_local_1 != null)
            {
                _local_1.addEventListener("WME_CLICK", onClose);
            };
        }

        private function getMusicInventoryGrid():IItemGridWindow
        {
            return (_SafeStr_4213.getChildByName("music_inventory_itemgrid") as IItemGridWindow);
        }

        private function getPlayListEditorItemList():IItemListWindow
        {
            return (_SafeStr_4214.getChildByName("playlist_editor_itemlist") as IItemListWindow);
        }

        private function getMusicInventoryStatusContainer():IWindowContainer
        {
            return (_SafeStr_4213.getChildByName("preview_play_container") as IWindowContainer);
        }

        private function getPlayListStatusContainer():IWindowContainer
        {
            return (_SafeStr_4214.getChildByName("now_playing_container") as IWindowContainer);
        }

        private function selectPlayListStatusViewByFurniPlayListState():void
        {
            var _local_1:IPlayListController = _SafeStr_3735.getRoomItemPlaylist();
            if (_local_1 == null)
            {
                return;
            };
            if (_local_1.isPlaying)
            {
                _SafeStr_4216.selectView("PLSV_NOW_PLAYING");
            }
            else
            {
                if (_local_1.length > 0)
                {
                    _SafeStr_4216.selectView("PLSV_START_PLAYBACK");
                }
                else
                {
                    _SafeStr_4216.selectView("PLSV_ADD_SONGS");
                };
            };
        }

        private function selectMusicStatusViewByMusicState():void
        {
            if (isPreviewPlaying())
            {
                _SafeStr_4215.show();
                _SafeStr_4215.selectView("MISV_PREVIEW_PLAYING");
            }
            else
            {
                if (_SafeStr_3735.getSongDiskInventorySize() <= 6)
                {
                    _SafeStr_4215.show();
                    _SafeStr_4215.selectView("MISV_BUY_MORE");
                }
                else
                {
                    _SafeStr_4215.hide();
                };
            };
        }

        private function updatePlaylistEditorView():void
        {
            var _local_4:int;
            var _local_5:ISongInfo;
            var _local_2:IPlayListController = _SafeStr_3735.getRoomItemPlaylist();
            var _local_3:Array = [];
            var _local_1:int = -1;
            if (_local_2 != null)
            {
                _local_4 = 0;
                while (_local_4 < _local_2.length)
                {
                    _local_5 = _local_2.getEntry(_local_4);
                    if (_local_5 != null)
                    {
                        _local_3.push(_local_5);
                    };
                    _local_4++;
                };
                _local_1 = _local_2.playPosition;
            };
            _playListEditorView.refresh(_local_3, _local_1);
        }

        public function onPlayListUpdated():void
        {
            var _local_3:ISongInfo;
            updatePlaylistEditorView();
            selectPlayListStatusViewByFurniPlayListState();
            var _local_1:IPlayListController = _SafeStr_3735.getRoomItemPlaylist();
            if (_local_1 == null)
            {
                return;
            };
            var _local_2:int = _local_1.nowPlayingSongId;
            if (_local_2 != -1)
            {
                _local_3 = _SafeStr_3735.getSongInfo(_local_2);
                _SafeStr_4216.nowPlayingTrackName = _local_3.name;
                _SafeStr_4216.nowPlayingAuthorName = _local_3.creator;
            };
            _SafeStr_4218.visible = (_local_1.length > 5);
        }

        public function onSongDiskInventoryReceived():void
        {
            _musicInventoryView.refresh();
            selectMusicStatusViewByMusicState();
            _SafeStr_4217.visible = (_musicInventoryView.itemCount > 9);
        }

        public function onNowPlayingChanged(_arg_1:RoomWidgetPlayListEditorNowPlayingEvent):void
        {
            var _local_3:ISongInfo;
            var _local_2:ISongInfo;
            switch (_arg_1.type)
            {
                case "RWPLENPE_SONG_CHANGED":
                    selectPlayListStatusViewByFurniPlayListState();
                    _playListEditorView.setItemIndexPlaying(_arg_1.position);
                    if (_arg_1.id != -1)
                    {
                        _local_3 = _SafeStr_3735.getSongInfo(_arg_1.id);
                        _SafeStr_4216.nowPlayingTrackName = ((_local_3 != null) ? _local_3.name : "");
                        _SafeStr_4216.nowPlayingAuthorName = ((_local_3 != null) ? _local_3.creator : "");
                    };
                    return;
                case "RWPLENPE_USER_PLAY_SONG":
                    _musicInventoryView.setPreviewIconToPause();
                    _local_2 = _SafeStr_3735.getSongInfo(_arg_1.id);
                    _SafeStr_4215.songName = ((_local_2 != null) ? _local_2.name : "");
                    _SafeStr_4215.songName = ((_local_2 != null) ? _local_2.name : "");
                    _SafeStr_4215.authorName = ((_local_2 != null) ? _local_2.creator : "");
                    selectMusicStatusViewByMusicState();
                    return;
                case "RWPLENPW_USER_STOP_SONG":
                    _musicInventoryView.setPreviewIconToPlay();
                    selectMusicStatusViewByMusicState();
                    return;
            };
        }

        private function onClose(_arg_1:WindowMouseEvent):void
        {
            hide();
        }

        private function isPreviewPlaying():Boolean
        {
            return (!(_SafeStr_3735.getSongIdPlayingAtPriority(2) == -1));
        }


    }
}

