package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetPlayListEditorEvent extends RoomWidgetUpdateEvent 
    {

        public static const SHOW_PLAYLIST_EDITOR:String = "RWPLEE_SHOW_PLAYLIST_EDITOR";
        public static const _SafeStr_4041:String = "RWPLEE_HIDE_PLAYLIST_EDITOR";
        public static const INVENTORY_UPDATED:String = "RWPLEE_INVENTORY_UPDATED";
        public static const SONG_DISK_INVENTORY_UPDATED:String = "RWPLEE_SONG_DISK_INVENTORY_UPDATED";
        public static const PLAY_LIST_UPDATED:String = "RWPLEE_PLAY_LIST_UPDATED";
        public static const PLAY_LIST_FULL:String = "RWPLEE_PLAY_LIST_FULL";

        private var _furniId:int;

        public function RoomWidgetPlayListEditorEvent(_arg_1:String, _arg_2:int=-1, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            _furniId = _arg_2;
        }

        public function get furniId():int
        {
            return (_furniId);
        }


    }
}

