package com.sulake.habbo.communication.messages.parser.crafting
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class CraftableProductsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CraftableProductsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CraftableProductsMessageParser);
        }

        public function getParser():CraftableProductsMessageParser
        {
            return (_SafeStr_816 as CraftableProductsMessageParser);
        }


    }
}

