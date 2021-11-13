package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemUpdateMessageParser;

        public class ItemUpdateMessageEvent extends MessageEvent 
    {

        public function ItemUpdateMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ItemUpdateMessageParser);
        }

        public function getParser():ItemUpdateMessageParser
        {
            return (_SafeStr_816 as ItemUpdateMessageParser);
        }


    }
}

