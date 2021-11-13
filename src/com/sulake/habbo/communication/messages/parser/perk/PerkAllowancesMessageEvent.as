package com.sulake.habbo.communication.messages.parser.perk
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class PerkAllowancesMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PerkAllowancesMessageEvent(_arg_1:Function)
        {
            super(_arg_1, PerkAllowancesMessageParser);
        }

        public function getParser():PerkAllowancesMessageParser
        {
            return (_SafeStr_816 as PerkAllowancesMessageParser);
        }


    }
}

