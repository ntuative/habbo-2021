package com.sulake.habbo.communication.messages.parser.room.bots
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class BotErrorEvent extends MessageEvent implements IMessageEvent 
    {

        public function BotErrorEvent(_arg_1:Function)
        {
            super(_arg_1, BotErrorParser);
        }

        public function getParser():BotErrorParser
        {
            return (_SafeStr_816 as BotErrorParser);
        }


    }
}

