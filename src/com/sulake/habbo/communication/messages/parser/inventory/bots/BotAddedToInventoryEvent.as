package com.sulake.habbo.communication.messages.parser.inventory.bots
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class BotAddedToInventoryEvent extends MessageEvent implements IMessageEvent 
    {

        public function BotAddedToInventoryEvent(_arg_1:Function)
        {
            super(_arg_1, BotAddedToInventoryParser);
        }

        public function getParser():BotAddedToInventoryParser
        {
            return (_SafeStr_816 as BotAddedToInventoryParser);
        }


    }
}

