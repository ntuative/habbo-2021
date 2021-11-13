package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemsMessageParser;

        public class ItemsMessageEvent extends MessageEvent 
    {

        public function ItemsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ItemsMessageParser);
        }

        public function getParser():ItemsMessageParser
        {
            return (_SafeStr_816 as ItemsMessageParser);
        }


    }
}

