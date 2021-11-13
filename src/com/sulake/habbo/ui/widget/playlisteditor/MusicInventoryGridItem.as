package com.sulake.habbo.ui.widget.playlisteditor
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components._SafeStr_143;
    import flash.geom.ColorTransform;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.components._SafeStr_124;
    import com.sulake.core.window.components.ITextWindow;

    public class MusicInventoryGridItem 
    {

        public static const _SafeStr_4219:int = 0;
        public static const _SafeStr_4220:int = 1;
        public static const BUTTON_STATE_DOWNLOAD:int = 2;
        private static const BG_COLOR_SELECTED:uint = 14612159;
        private static const BG_COLOR_UNSELECTED:uint = 0xF1F1F1;

        private var _SafeStr_1324:PlayListEditorWidget;
        private var _window:IWindowContainer = null;
        private var _diskId:int;
        private var _songId:int;
        private var _toPlayListButton:_SafeStr_143 = null;
        private var _playButtonState:int;

        public function MusicInventoryGridItem(_arg_1:PlayListEditorWidget, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:ColorTransform)
        {
            _SafeStr_1324 = _arg_1;
            _diskId = _arg_2;
            _songId = _arg_3;
            createWindow();
            deselect();
            if (((!(_arg_4 == null)) && (!(_arg_5 == null))))
            {
                trackName = _arg_4;
                diskColor = _arg_5;
            };
        }

        public function get window():IWindow
        {
            return (_window as IWindow);
        }

        public function get diskId():int
        {
            return (_diskId);
        }

        public function get songId():int
        {
            return (_songId);
        }

        public function get toPlayListButton():_SafeStr_143
        {
            return (_toPlayListButton);
        }

        public function get playButtonState():int
        {
            return (_playButtonState);
        }

        public function update(_arg_1:int, _arg_2:String, _arg_3:ColorTransform):void
        {
            if (_arg_1 == _songId)
            {
                trackName = _arg_2;
                diskColor = _arg_3;
            };
        }

        public function destroy():void
        {
            if (_window)
            {
                _window.destroy();
            };
        }

        private function createWindow():void
        {
            var _local_3:BitmapDataAsset;
            if (_SafeStr_1324 == null)
            {
                return;
            };
            var _local_2:XmlAsset = (_SafeStr_1324.assets.getAssetByName("playlisteditor_music_inventory_item") as XmlAsset);
            _window = (_SafeStr_1324.windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
            if (_window == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            var _local_1:IWindowContainer = (_window.getChildByName("action_buttons") as IWindowContainer);
            if (_local_1 != null)
            {
                _toPlayListButton = (_local_1.getChildByName("button_to_playlist") as _SafeStr_143);
            };
            assignAssetByNameToElement("title_fader", (_window.getChildByName("title_fader_bitmap") as IBitmapWrapperWindow));
            _local_3 = (_SafeStr_1324.assets.getAssetByName("icon_arrow") as BitmapDataAsset);
            if (_local_3 != null)
            {
                if (_local_3.content != null)
                {
                    this.buttonToPlaylistBitmap = (_local_3.content as BitmapData);
                };
            };
            this.playButtonState = 0;
        }

        public function select():void
        {
            var _local_2:_SafeStr_124 = (_window.getChildByName("background") as _SafeStr_124);
            if (_local_2 != null)
            {
                _local_2.color = 14612159;
            };
            var _local_3:IWindowContainer = (_window.getChildByName("action_buttons") as IWindowContainer);
            if (_local_3 != null)
            {
                _local_3.visible = true;
            };
            var _local_1:_SafeStr_124 = (_window.getChildByName("selected") as _SafeStr_124);
            if (_local_1 != null)
            {
                _local_1.visible = true;
            };
        }

        public function deselect():void
        {
            var _local_2:_SafeStr_124 = (_window.getChildByName("background") as _SafeStr_124);
            if (_local_2 != null)
            {
                _local_2.color = 0xF1F1F1;
            };
            var _local_3:IWindowContainer = (_window.getChildByName("action_buttons") as IWindowContainer);
            if (_local_3 != null)
            {
                _local_3.visible = false;
            };
            var _local_1:_SafeStr_124 = (_window.getChildByName("selected") as _SafeStr_124);
            if (_local_1 != null)
            {
                _local_1.visible = false;
            };
        }

        public function set diskColor(_arg_1:ColorTransform):void
        {
            var _local_2:BitmapData;
            var _local_4:BitmapData;
            var _local_3:BitmapDataAsset = (_SafeStr_1324.assets.getAssetByName("icon_cd_big") as BitmapDataAsset);
            if (_local_3 == null)
            {
                return;
            };
            if (_local_3.content != null)
            {
                _local_2 = (_local_3.content as BitmapData);
                _local_4 = _local_2.clone();
                if (_local_4 != null)
                {
                    _local_4.colorTransform(_local_2.rect, _arg_1);
                    this.diskIconBitmap = _local_4;
                };
            };
        }

        public function set playButtonState(_arg_1:int):void
        {
            var _local_2:BitmapDataAsset;
            if (_arg_1 == 0)
            {
                _local_2 = (_SafeStr_1324.assets.getAssetByName("icon_play") as BitmapDataAsset);
            }
            else
            {
                if (_arg_1 == 1)
                {
                    _local_2 = (_SafeStr_1324.assets.getAssetByName("icon_pause") as BitmapDataAsset);
                }
                else
                {
                    if (_arg_1 == 2)
                    {
                        _local_2 = (_SafeStr_1324.assets.getAssetByName("icon_download") as BitmapDataAsset);
                    };
                };
            };
            if (_local_2 != null)
            {
                if (_local_2.content != null)
                {
                    this.buttonPlayPauseBitmap = (_local_2.content as BitmapData);
                };
            };
            _playButtonState = _arg_1;
        }

        public function set trackName(_arg_1:String):void
        {
            var _local_2:ITextWindow = (_window.getChildByName("song_title_text") as ITextWindow);
            if (_local_2 != null)
            {
                _local_2.text = _arg_1;
            };
        }

        private function set diskIconBitmap(_arg_1:BitmapData):void
        {
            var _local_2:IBitmapWrapperWindow = (_window.getChildByName("disk_image") as IBitmapWrapperWindow);
            if (_local_2 != null)
            {
                _local_2.bitmap = _arg_1;
            };
        }

        private function set buttonToPlaylistBitmap(_arg_1:BitmapData):void
        {
            assignBitmapDataToButton("button_to_playlist", "image_button_to_playlist", _arg_1);
        }

        private function set buttonPlayPauseBitmap(_arg_1:BitmapData):void
        {
            assignBitmapDataToButton("button_play_pause", "image_button_play_pause", _arg_1);
        }

        private function assignBitmapDataToButton(_arg_1:String, _arg_2:String, _arg_3:BitmapData):void
        {
            if (_arg_3 == null)
            {
                return;
            };
            var _local_4:IWindowContainer = (_window.getChildByName("action_buttons") as IWindowContainer);
            if (_local_4 == null)
            {
                return;
            };
            _local_4 = (_local_4.getChildByName(_arg_1) as IWindowContainer);
            if (_local_4 == null)
            {
                return;
            };
            var _local_5:IBitmapWrapperWindow = (_local_4.getChildByName(_arg_2) as IBitmapWrapperWindow);
            if (_local_5 != null)
            {
                _local_5.bitmap = _arg_3.clone();
                _local_5.width = _arg_3.width;
                _local_5.height = _arg_3.height;
            };
        }

        private function assignAssetByNameToElement(_arg_1:String, _arg_2:IBitmapWrapperWindow):void
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


    }
}

