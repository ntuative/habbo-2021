package com.sulake.habbo.communication.messages.parser.inventory.bots
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class BotRemovedFromInventoryEvent extends MessageEvent implements IMessageEvent 
    {

        public function BotRemovedFromInventoryEvent(_arg_1:Function)
        {
            super(_arg_1, BotRemovedFromInventoryParser);
        }

        public function getParser():BotRemovedFromInventoryParser
        {
            return (_SafeStr_816 as BotRemovedFromInventoryParser);
        }


    }
}

