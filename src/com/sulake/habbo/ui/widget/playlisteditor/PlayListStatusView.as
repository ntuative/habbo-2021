package com.sulake.habbo.ui.widget.playlisteditor
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.components._SafeStr_143;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class PlayListStatusView 
    {

        public static const ADD_SONGS:String = "PLSV_ADD_SONGS";
        public static const START_PLAYBACK:String = "PLSV_START_PLAYBACK";
        public static const NOW_PLAYING:String = "PLSV_NOW_PLAYING";

        private var _container:IWindowContainer;
        private var _SafeStr_4222:Map = new Map();
        private var _SafeStr_1324:PlayListEditorWidget;
        private var _SafeStr_2682:String;

        public function PlayListStatusView(_arg_1:PlayListEditorWidget, _arg_2:IWindowContainer)
        {
            _container = _arg_2;
            _SafeStr_1324 = _arg_1;
            createWindows();
        }

        public function destroy():void
        {
            for each (var _local_1:IWindowContainer in _SafeStr_4222.getValues())
            {
                _local_1.destroy();
            };
            _SafeStr_4222 = null;
        }

        public function selectView(_arg_1:String):void
        {
            _container.removeChildAt(0);
            _container.addChildAt((_SafeStr_4222[_arg_1] as IWindowContainer), 0);
            _SafeStr_2682 = _arg_1;
        }

        public function set nowPlayingTrackName(_arg_1:String):void
        {
            if (_SafeStr_2682 != "PLSV_NOW_PLAYING")
            {
                return;
            };
            var _local_2:IWindowContainer = _SafeStr_4222[_SafeStr_2682];
            var _local_3:ITextWindow = (_local_2.getChildByName("now_playing_track_name") as ITextWindow);
            if (_local_3 != null)
            {
                _local_3.text = _arg_1;
            };
        }

        public function set nowPlayingAuthorName(_arg_1:String):void
        {
            if (_SafeStr_2682 != "PLSV_NOW_PLAYING")
            {
                return;
            };
            var _local_2:IWindowContainer = _SafeStr_4222[_SafeStr_2682];
            var _local_3:ITextWindow = (_local_2.getChildByName("now_playing_author_name") as ITextWindow);
            if (_local_3 != null)
            {
                _local_3.text = _arg_1;
            };
        }

        public function set addSongsBackgroundImage(_arg_1:BitmapData):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            var _local_2:IWindowContainer = _SafeStr_4222["PLSV_ADD_SONGS"];
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:IBitmapWrapperWindow = (_local_2.getChildByName("background_image") as IBitmapWrapperWindow);
            if (_local_3 == null)
            {
                return;
            };
            _local_3.bitmap = _arg_1.clone();
            _local_3.width = _arg_1.width;
            _local_3.height = _arg_1.height;
        }

        private function createWindows():void
        {
            var _local_3:IWindowContainer;
            var _local_2:XmlAsset;
            var _local_4:_SafeStr_101;
            var _local_1:_SafeStr_143;
            _local_2 = (_SafeStr_1324.assets.getAssetByName("playlisteditor_playlist_subwindow_add_songs") as XmlAsset);
            _local_3 = (_SafeStr_1324.windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
            if (_local_3 != null)
            {
                _SafeStr_4222.add("PLSV_ADD_SONGS", _local_3);
            };
            _local_2 = (_SafeStr_1324.assets.getAssetByName("playlisteditor_playlist_subwindow_play_now") as XmlAsset);
            _local_3 = (_SafeStr_1324.windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
            if (_local_3 != null)
            {
                _SafeStr_4222.add("PLSV_START_PLAYBACK", _local_3);
                _local_4 = (_local_3.getChildByName("play_now_button") as _SafeStr_101);
                _local_4.addEventListener("WME_CLICK", onPlayPauseClicked);
            };
            _local_2 = (_SafeStr_1324.assets.getAssetByName("playlisteditor_playlist_subwindow_nowplaying") as XmlAsset);
            _local_3 = (_SafeStr_1324.windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
            if (_local_3 != null)
            {
                _SafeStr_4222.add("PLSV_NOW_PLAYING", _local_3);
                _local_1 = (_local_3.getChildByName("button_pause") as _SafeStr_143);
                _local_1.addEventListener("WME_CLICK", onPlayPauseClicked);
                assignAssetToElement("icon_pause_large", (_local_1.getChildByName("pause_image") as IBitmapWrapperWindow));
                assignAssetToElement("jb_icon_disc", (_local_3.getChildByName("song_name_icon_bitmap") as IBitmapWrapperWindow));
                assignAssetToElement("jb_icon_composer", (_local_3.getChildByName("author_name_icon_bitmap") as IBitmapWrapperWindow));
            };
        }

        private function assignAssetToElement(_arg_1:String, _arg_2:IBitmapWrapperWindow):void
        {
            var _local_3:BitmapData;
            var _local_4:BitmapDataAsset = (_SafeStr_1324.assets.getAssetByName(_arg_1) as BitmapDataAsset);
            if (_local_4 != null)
            {
                if (((!(_arg_2 == null)) && (!(_local_4.content == null))))
                {
                    _local_3 = (_local_4.content as BitmapData);
                    _arg_2.bitmap = _local_3.clone();
                };
            };
        }

        private function onPlayPauseClicked(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1324.sendTogglePlayPauseStateMessage();
        }


    }
}

