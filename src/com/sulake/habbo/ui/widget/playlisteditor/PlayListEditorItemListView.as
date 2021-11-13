package com.sulake.habbo.ui.widget.playlisteditor
{
    import com.sulake.core.window.components.IItemListWindow;
    import flash.geom.ColorTransform;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class PlayListEditorItemListView 
    {

        private var _SafeStr_1564:IItemListWindow;
        private var _items:Array;
        private var _SafeStr_1324:PlayListEditorWidget;
        private var _SafeStr_2623:PlayListEditorItem;
        private var _selectedItemIndex:int = -1;
        private var _SafeStr_4225:int = -1;

        public function PlayListEditorItemListView(_arg_1:PlayListEditorWidget, _arg_2:IItemListWindow)
        {
            _SafeStr_1564 = _arg_2;
            _SafeStr_1324 = _arg_1;
            _SafeStr_2623 = null;
        }

        public function get selectedItemIndex():int
        {
            return (_selectedItemIndex);
        }

        public function destroy():void
        {
            if (_SafeStr_1564 == null)
            {
                return;
            };
            _SafeStr_1564.destroyListItems();
        }

        public function refresh(_arg_1:Array, _arg_2:int):void
        {
            var _local_3:String;
            var _local_7:String;
            var _local_5:ColorTransform;
            var _local_4:PlayListEditorItem;
            if (_SafeStr_1564 == null)
            {
                return;
            };
            if (_arg_1 == null)
            {
                return;
            };
            _SafeStr_4225 = -1;
            _items = [];
            _SafeStr_1564.destroyListItems();
            for each (var _local_6:ISongInfo in _arg_1)
            {
                _local_3 = _local_6.name;
                _local_7 = _local_6.creator;
                _local_5 = _SafeStr_1324.getDiskColorTransformFromSongData(_local_6.songData);
                _local_4 = new PlayListEditorItem(_SafeStr_1324, _local_3, _local_7, _local_5);
                _local_4.window.procedure = itemEventProc;
                _local_4.removeButton.procedure = itemEventProc;
                _SafeStr_1564.addListItem(_local_4.window);
                _items.push(_local_4);
            };
            setItemIndexPlaying(_arg_2);
        }

        public function setItemIndexPlaying(_arg_1:int):void
        {
            var _local_2:PlayListEditorItem;
            if (_items == null)
            {
                return;
            };
            if (_arg_1 < 0)
            {
                for each (var _local_3:PlayListEditorItem in _items)
                {
                    _local_3.setIconState("PLEI_ICON_STATE_NORMAL");
                };
                return;
            };
            if (_arg_1 >= _items.length)
            {
                return;
            };
            if (((_SafeStr_4225 >= 0) && (_SafeStr_4225 < _items.length)))
            {
                _local_2 = (_items[_SafeStr_4225] as PlayListEditorItem);
                _local_2.setIconState("PLEI_ICON_STATE_NORMAL");
            };
            _local_2 = (_items[_arg_1] as PlayListEditorItem);
            _local_2.setIconState("PLEI_ICON_STATE_PLAYING");
            _SafeStr_4225 = _arg_1;
        }

        public function deselectAny():void
        {
            if (_SafeStr_2623 != null)
            {
                _SafeStr_2623.deselect();
                _SafeStr_2623 = null;
                _selectedItemIndex = -1;
            };
        }

        private function itemEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:int;
            var _local_3:Boolean = (_arg_1.type == "WME_DOUBLE_CLICK");
            if (((_arg_1.type == "WME_CLICK") || (_local_3)))
            {
                if (((_arg_2.name == "button_remove_from_playlist") || (_local_3)))
                {
                    if (_SafeStr_2623 != null)
                    {
                        _SafeStr_2623.deselect();
                    };
                    if (_selectedItemIndex > -1)
                    {
                        _SafeStr_1324.sendRemoveFromPlayListMessage(_selectedItemIndex);
                    };
                    _SafeStr_2623 = null;
                    _selectedItemIndex = -1;
                }
                else
                {
                    if (_SafeStr_2623 != null)
                    {
                        _SafeStr_2623.deselect();
                    };
                    _local_4 = _SafeStr_1564.getListItemIndex(_arg_1.window);
                    if (_local_4 != -1)
                    {
                        _selectedItemIndex = _local_4;
                        _SafeStr_2623 = _items[_local_4];
                        _SafeStr_2623.select();
                        if (_arg_2.name == "button_remove_from_playlist")
                        {
                            _SafeStr_1324.sendRemoveFromPlayListMessage(_local_4);
                        };
                        if (_SafeStr_1324.mainWindowHandler != null)
                        {
                            _SafeStr_1324.mainWindowHandler.musicInventoryView.deselectAny();
                        };
                    };
                };
            };
        }


    }
}

