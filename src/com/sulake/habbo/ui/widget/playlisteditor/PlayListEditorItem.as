package com.sulake.habbo.ui.widget.playlisteditor
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components._SafeStr_143;
    import flash.geom.ColorTransform;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.XmlAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components._SafeStr_124;
    import com.sulake.core.window.components.ITextWindow;

    public class PlayListEditorItem 
    {

        public static const ICON_STATE_NORMAL:String = "PLEI_ICON_STATE_NORMAL";
        public static const ICON_STATE_PLAYING:String = "PLEI_ICON_STATE_PLAYING";
        private static const BG_COLOR_SELECTED:uint = 14283002;
        private static const BG_COLOR_UNSELECTED:uint = 0xF1F1F1;

        private var _SafeStr_1324:PlayListEditorWidget;
        private var _window:IWindowContainer;
        private var _removeButton:_SafeStr_143 = null;
        private var _SafeStr_1107:ColorTransform;

        public function PlayListEditorItem(_arg_1:PlayListEditorWidget, _arg_2:String, _arg_3:String, _arg_4:ColorTransform)
        {
            _SafeStr_1324 = _arg_1;
            _SafeStr_1107 = _arg_4;
            createWindow();
            setIconState("PLEI_ICON_STATE_NORMAL");
            deselect();
            trackName = _arg_2;
            trackAuthor = _arg_3;
            diskColor = _arg_4;
        }

        public function get window():IWindow
        {
            return (_window as IWindow);
        }

        public function get removeButton():_SafeStr_143
        {
            return (_removeButton);
        }

        private function createWindow():void
        {
            var _local_3:BitmapDataAsset;
            if (_SafeStr_1324 == null)
            {
                return;
            };
            var _local_2:XmlAsset = (_SafeStr_1324.assets.getAssetByName("playlisteditor_playlist_item") as XmlAsset);
            _window = (_SafeStr_1324.windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
            if (_window == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            _local_3 = (_SafeStr_1324.assets.getAssetByName("icon_arrow_left") as BitmapDataAsset);
            if (_local_3 != null)
            {
                if (_local_3.content != null)
                {
                    this.buttonRemoveBitmap = (_local_3.content as BitmapData);
                };
            };
            assignAssetByNameToElement("jb_icon_disc", (_window.getChildByName("song_name_icon_bitmap") as IBitmapWrapperWindow));
            assignAssetByNameToElement("jb_icon_composer", (_window.getChildByName("author_name_icon_bitmap") as IBitmapWrapperWindow));
            var _local_1:IWindowContainer = (_window.getChildByName("action_buttons") as IWindowContainer);
            if (_local_1 != null)
            {
                _local_1 = (_local_1.getChildByName("button_border") as IWindowContainer);
                if (_local_1 != null)
                {
                    _removeButton = (_local_1.getChildByName("button_remove_from_playlist") as _SafeStr_143);
                };
            };
        }

        public function select():void
        {
            var _local_2:_SafeStr_124 = (_window.getChildByName("background") as _SafeStr_124);
            if (_local_2 != null)
            {
                _local_2.color = 14283002;
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

        public function setIconState(_arg_1:String):void
        {
            var _local_3:BitmapDataAsset;
            var _local_2:BitmapData;
            switch (_arg_1)
            {
                case "PLEI_ICON_STATE_NORMAL":
                    diskColor = _SafeStr_1107;
                    return;
                case "PLEI_ICON_STATE_PLAYING":
                    _local_3 = (_SafeStr_1324.assets.getAssetByName("icon_notes_small") as BitmapDataAsset);
                    if (_local_3 == null)
                    {
                        return;
                    };
                    if (_local_3.content != null)
                    {
                        _local_2 = (_local_3.content as BitmapData);
                        this.diskIconBitmap = _local_2.clone();
                    };
                    return;
            };
        }

        public function set diskColor(_arg_1:ColorTransform):void
        {
            var _local_2:BitmapData;
            var _local_4:BitmapData;
            var _local_3:BitmapDataAsset = (_SafeStr_1324.assets.getAssetByName("icon_cd_small") as BitmapDataAsset);
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

        public function set trackName(_arg_1:String):void
        {
            var _local_2:ITextWindow = (_window.getChildByName("song_title_text") as ITextWindow);
            if (_local_2 != null)
            {
                _local_2.text = _arg_1;
            };
        }

        public function set trackAuthor(_arg_1:String):void
        {
            var _local_2:ITextWindow = (_window.getChildByName("song_author_text") as ITextWindow);
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

        private function set buttonRemoveBitmap(_arg_1:BitmapData):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            var _local_2:IWindowContainer = (_window.getChildByName("action_buttons") as IWindowContainer);
            if (_local_2 == null)
            {
                return;
            };
            _local_2 = (_local_2.getChildByName("button_border") as IWindowContainer);
            if (_local_2 == null)
            {
                return;
            };
            _local_2 = (_local_2.getChildByName("button_remove_from_playlist") as IWindowContainer);
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:IBitmapWrapperWindow = (_local_2.getChildByName("button_remove_from_playlist_image") as IBitmapWrapperWindow);
            if (_local_3 != null)
            {
                _local_3.bitmap = _arg_1.clone();
                _local_3.width = _arg_1.width;
                _local_3.height = _arg_1.height;
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

