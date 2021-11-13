package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemRemoveMessageParser;

        public class ItemRemoveMessageEvent extends MessageEvent 
    {

        public function ItemRemoveMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ItemRemoveMessageParser);
        }

        public function getParser():ItemRemoveMessageParser
        {
            return (_SafeStr_816 as ItemRemoveMessageParser);
        }


    }
}

