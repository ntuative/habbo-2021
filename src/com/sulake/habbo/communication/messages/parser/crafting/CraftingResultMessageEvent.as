package com.sulake.habbo.communication.messages.parser.crafting
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class CraftingResultMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CraftingResultMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CraftingResultMessageParser);
        }

        public function getParser():CraftingResultMessageParser
        {
            return (_SafeStr_816 as CraftingResultMessageParser);
        }


    }
}

