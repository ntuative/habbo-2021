package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetStoreSettingsMessage extends RoomWidgetMessage 
    {

        public static const STORE_ALL_SETTINGS:String = "RWSSM_STORE_SETTINGS";
        public static const STORE_SOUND_SETTING:String = "RWSSM_STORE_SOUND";
        public static const PREVIEW_SOUND_SETTING:String = "RWSSM_PREVIEW_SOUND";
        public static const STORE_CHAT_SETTINGS:String = "RWSSM_STORE_CHAT";

        private var _traxVolume:Number;
        private var _furniVolume:Number;
        private var _genericVolume:Number;
        private var _forceOldChat:Boolean;

        public function RoomWidgetStoreSettingsMessage(_arg_1:String)
        {
            super(_arg_1);
        }

        public function get traxVolume():Number
        {
            return (_traxVolume);
        }

        public function set traxVolume(_arg_1:Number):void
        {
            _traxVolume = _arg_1;
        }

        public function get furniVolume():Number
        {
            return (_furniVolume);
        }

        public function set furniVolume(_arg_1:Number):void
        {
            _furniVolume = _arg_1;
        }

        public function get genericVolume():Number
        {
            return (_genericVolume);
        }

        public function set genericVolume(_arg_1:Number):void
        {
            _genericVolume = _arg_1;
        }

        public function get forceOldChat():Boolean
        {
            return (_forceOldChat);
        }

        public function set forceOldChat(_arg_1:Boolean):void
        {
            _forceOldChat = _arg_1;
        }


    }
}