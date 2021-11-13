package com.sulake.habbo.communication.messages.parser.inventory.bots
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class BotInventoryEvent extends MessageEvent implements IMessageEvent 
    {

        public function BotInventoryEvent(_arg_1:Function)
        {
            super(_arg_1, BotInventoryMessageParser);
        }

        public function getParser():BotInventoryMessageParser
        {
            return (_SafeStr_816 as BotInventoryMessageParser);
        }


    }
}

