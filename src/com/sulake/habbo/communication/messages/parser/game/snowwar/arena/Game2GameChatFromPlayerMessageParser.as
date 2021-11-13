package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class Game2GameChatFromPlayerMessageParser implements IMessageParser 
    {

        private var _userId:int;
        private var _chatMessage:String;


        public function flush():Boolean
        {
            _userId = -1;
            _chatMessage = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _userId = _arg_1.readInteger();
            _chatMessage = _arg_1.readString();
            return (true);
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get chatMessage():String
        {
            return (_chatMessage);
        }


    }
}