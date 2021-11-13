package com.sulake.habbo.game.events
{
    import flash.events.Event;

    public class GameChatEvent extends Event 
    {

        public static const GAME_CHAT:String = "gce_game_chat";

        private var _userId:int;
        private var _message:String;
        private var _locX:int;
        private var _color:uint;
        private var _figure:String;
        private var _gender:String;
        private var _name:String;
        private var _teamId:int;
        private var _notify:Boolean;

        public function GameChatEvent(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:uint, _arg_6:String, _arg_7:String, _arg_8:String, _arg_9:int, _arg_10:Boolean, _arg_11:Boolean=false, _arg_12:Boolean=false)
        {
            super(_arg_1, _arg_11, _arg_12);
            _userId = _arg_2;
            _message = _arg_3;
            _locX = _arg_4;
            _color = _arg_5;
            _figure = _arg_6;
            _gender = _arg_7;
            _name = _arg_8;
            _teamId = _arg_9;
            _notify = _arg_10;
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get message():String
        {
            return (_message);
        }

        public function get locX():int
        {
            return (_locX);
        }

        public function get color():uint
        {
            return (_color);
        }

        public function get figure():String
        {
            return (_figure);
        }

        public function get gender():String
        {
            return (_gender);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get teamId():int
        {
            return (_teamId);
        }

        public function get notify():Boolean
        {
            return (_notify);
        }


    }
}