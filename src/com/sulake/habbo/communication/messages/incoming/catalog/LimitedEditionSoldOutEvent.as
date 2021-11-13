package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.LimitedEditionSoldOutParser;

        public class LimitedEditionSoldOutEvent extends MessageEvent implements IMessageEvent 
    {

        public function LimitedEditionSoldOutEvent(_arg_1:Function)
        {
            super(_arg_1, LimitedEditionSoldOutParser);
        }

        public function getParser():LimitedEditionSoldOutParser
        {
            return (this._SafeStr_816 as LimitedEditionSoldOutParser);
        }


    }
}

