package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetOpenCatalogMessage extends RoomWidgetMessage 
    {

        public static const _SafeStr_4197:String = "RWGOI_MESSAGE_OPEN_CATALOG";
        public static const CATALOG_CLUB:String = "RWOCM_CLUB_MAIN";
        public static const PIXELS:String = "RWOCM_PIXELS";
        public static const CREDITS:String = "RWOCM_CREDITS";
        public static const SHELLS:String = "RWOCM_SHELLS";

        private var _pageKey:String = "";

        public function RoomWidgetOpenCatalogMessage(_arg_1:String)
        {
            super("RWGOI_MESSAGE_OPEN_CATALOG");
            _pageKey = _arg_1;
        }

        public function get pageKey():String
        {
            return (_pageKey);
        }


    }
}

