package com.sulake.habbo.ui.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetChatUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const WIDGET_UPDATE_EVENT_CHAT:String = "RWCUE_EVENT_CHAT";
        public static const CHAT_TYPE_SPEAK:int = 0;
        public static const CHAT_TYPE_WHISPER:int = 1;
        public static const CHAT_TYPE_SHOUT:int = 2;
        public static const CHAT_TYPE_RESPECT:int = 3;
        public static const CHAT_TYPE_PETRESPECT:int = 4;
        public static const CHAT_TYPE_NOTIFY:int = 5;
        public static const CHAT_TYPE_PETTREAT:int = 6;
        public static const CHAT_TYPE_PETREVIVE:int = 7;
        public static const CHAT_TYPE_PET_REBREED_FERTILIZE:int = 8;
        public static const CHAT_TYPE_PET_SPEED_FERTILIZE:int = 9;
        public static const CHAT_TYPE_BOT_SPEAK:int = 10;
        public static const CHAT_TYPE_BOT_SHOUT:int = 11;
        public static const CHAT_TYPE_BOT_WHISPER:int = 12;

        private var _userId:int = 0;
        private var _text:String = "";
        private var _chatType:int = 0;
        private var _userName:String;
        private var _links:Array;
        private var _userX:Number;
        private var _userY:Number;
        private var _userImage:BitmapData;
        private var _userColor:uint;
        private var _roomId:int;
        private var _userCategory:int;
        private var _userType:int;
        private var _petType:int;
        private var _styleId:int;

        public function RoomWidgetChatUpdateEvent(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:int, _arg_6:int, _arg_7:int, _arg_8:Number, _arg_9:Number, _arg_10:BitmapData, _arg_11:uint, _arg_12:int, _arg_13:int=0, _arg_14:int=0, _arg_15:Array=null, _arg_16:Boolean=false, _arg_17:Boolean=false)
        {
            super(_arg_1, _arg_16, _arg_17);
            _userId = _arg_2;
            _text = _arg_3;
            _chatType = _arg_13;
            _userName = _arg_4;
            _userCategory = _arg_5;
            _userType = _arg_6;
            _petType = _arg_7;
            _links = _arg_15;
            _userX = _arg_8;
            _userY = _arg_9;
            _userImage = _arg_10;
            _userColor = _arg_11;
            _roomId = _arg_12;
            _styleId = _arg_14;
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get text():String
        {
            return (_text);
        }

        public function get chatType():int
        {
            return (_chatType);
        }

        public function get userName():String
        {
            return (_userName);
        }

        public function get userCategory():int
        {
            return (_userCategory);
        }

        public function get userType():int
        {
            return (_userType);
        }

        public function get petType():int
        {
            return (_petType);
        }

        public function get links():Array
        {
            return (_links);
        }

        public function get userX():Number
        {
            return (_userX);
        }

        public function get userY():Number
        {
            return (_userY);
        }

        public function get userImage():BitmapData
        {
            return (_userImage);
        }

        public function get userColor():uint
        {
            return (_userColor);
        }

        public function get roomId():int
        {
            return (_roomId);
        }

        public function get styleId():int
        {
            return (_styleId);
        }


    }
}