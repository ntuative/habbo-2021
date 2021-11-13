package com.sulake.habbo.freeflowchat.data
{
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.session.events.RoomSessionChatEvent;

    public class ChatItem 
    {

        private var _timeStamp:int = 0;
        private var _userId:int = 0;
        private var _roomId:int = 0;
        private var _text:String = "";
        private var _chatType:int = 0;
        private var _links:Array;
        private var _style:int;
        private var _userLocation:IVector3d;
        private var _forcedColor:*;
        private var _forcedScreenLocation:*;
        private var _forcedFigure:String;
        private var _forcedUserName:String;
        private var _extraParam:int;

        public function ChatItem(_arg_1:RoomSessionChatEvent, _arg_2:int, _arg_3:IVector3d=null, _arg_4:int=0, _arg_5:*=null, _arg_6:*=null, _arg_7:String=null, _arg_8:String=null)
        {
            _timeStamp = _arg_2;
            _userLocation = _arg_3;
            _userId = _arg_1.userId;
            if (_arg_1.session)
            {
                _roomId = _arg_1.session.roomId;
            }
            else
            {
                _roomId = 1;
            };
            _text = _arg_1.text;
            _chatType = _arg_1.chatType;
            _style = _arg_1.style;
            _links = new Array(_arg_1.links);
            _forcedColor = _arg_6;
            _forcedScreenLocation = _arg_5;
            _forcedFigure = _arg_7;
            _forcedUserName = _arg_8;
            _extraParam = _arg_4;
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get roomId():int
        {
            return (_roomId);
        }

        public function get text():String
        {
            return (_text);
        }

        public function get chatType():int
        {
            return (_chatType);
        }

        public function get links():Array
        {
            return (_links);
        }

        public function get style():int
        {
            return (_style);
        }

        public function get timeStamp():uint
        {
            return (_timeStamp);
        }

        public function get userLocation():IVector3d
        {
            return (_userLocation);
        }

        public function get forcedColor():*
        {
            return (_forcedColor);
        }

        public function get forcedScreenLocation():*
        {
            return (_forcedScreenLocation);
        }

        public function get forcedFigure():String
        {
            return (_forcedFigure);
        }

        public function get forcedUserName():String
        {
            return (_forcedUserName);
        }

        public function get extraParam():int
        {
            return (_extraParam);
        }

        public function set text(_arg_1:String):void
        {
            _text = _arg_1;
        }


    }
}