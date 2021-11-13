package com.sulake.habbo.communication.messages.parser.inventory.bots
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class BotReceivedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function BotReceivedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, BotReceivedMessageParser);
        }

        public function getParser():BotReceivedMessageParser
        {
            return (_SafeStr_816 as BotReceivedMessageParser);
        }


    }
}

