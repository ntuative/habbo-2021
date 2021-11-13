package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.FurnitureAliasesMessageParser;

        public class FurnitureAliasesMessageEvent extends MessageEvent 
    {

        public function FurnitureAliasesMessageEvent(_arg_1:Function)
        {
            super(_arg_1, FurnitureAliasesMessageParser);
        }

        public function getParser():FurnitureAliasesMessageParser
        {
            return (_SafeStr_816 as FurnitureAliasesMessageParser);
        }


    }
}

