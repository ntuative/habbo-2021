package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class GamePlayerValueMessageEvent extends MessageEvent 
    {

        public function GamePlayerValueMessageEvent(_arg_1:Function)
        {
            super(_arg_1, GamePlayerValueMessageParser);
        }

        public function getParser():GamePlayerValueMessageParser
        {
            return (_SafeStr_816 as GamePlayerValueMessageParser);
        }


    }
}

