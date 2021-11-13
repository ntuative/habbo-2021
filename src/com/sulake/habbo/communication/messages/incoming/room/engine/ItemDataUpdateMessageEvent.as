package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemDataUpdateMessageParser;

        public class ItemDataUpdateMessageEvent extends MessageEvent 
    {

        public function ItemDataUpdateMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ItemDataUpdateMessageParser);
        }

        public function getParser():ItemDataUpdateMessageParser
        {
            return (_SafeStr_816 as ItemDataUpdateMessageParser);
        }


    }
}

