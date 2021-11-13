package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemAddMessageParser;

        public class ItemAddMessageEvent extends MessageEvent 
    {

        public function ItemAddMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ItemAddMessageParser);
        }

        public function getParser():ItemAddMessageParser
        {
            return (_SafeStr_816 as ItemAddMessageParser);
        }


    }
}

