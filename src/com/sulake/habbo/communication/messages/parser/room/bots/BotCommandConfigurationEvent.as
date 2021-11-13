package com.sulake.habbo.communication.messages.parser.room.bots
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class BotCommandConfigurationEvent extends MessageEvent implements IMessageEvent 
    {

        public function BotCommandConfigurationEvent(_arg_1:Function)
        {
            super(_arg_1, BotCommandConfigurationParser);
        }

        public function getParser():BotCommandConfigurationParser
        {
            return (_SafeStr_816 as BotCommandConfigurationParser);
        }


    }
}

