package com.sulake.habbo.communication.messages.parser.crafting
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class CraftingRecipeMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CraftingRecipeMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CraftingRecipeMessageParser);
        }

        public function getParser():CraftingRecipeMessageParser
        {
            return (_SafeStr_816 as CraftingRecipeMessageParser);
        }


    }
}

