package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.BonusRareInfoMessageParser;

        public class BonusRareInfoMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function BonusRareInfoMessageEvent(_arg_1:Function)
        {
            super(_arg_1, BonusRareInfoMessageParser);
        }

        public function getParser():BonusRareInfoMessageParser
        {
            return (this._SafeStr_816 as BonusRareInfoMessageParser);
        }


    }
}

