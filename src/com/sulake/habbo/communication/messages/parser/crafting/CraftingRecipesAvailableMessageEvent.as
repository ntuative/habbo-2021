package com.sulake.habbo.communication.messages.parser.crafting
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class CraftingRecipesAvailableMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CraftingRecipesAvailableMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CraftingRecipesAvailableMessageParser);
        }

        public function getParser():CraftingRecipesAvailableMessageParser
        {
            return (_SafeStr_816 as CraftingRecipesAvailableMessageParser);
        }


    }
}

