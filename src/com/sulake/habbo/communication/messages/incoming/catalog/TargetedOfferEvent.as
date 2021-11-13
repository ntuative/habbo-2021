package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.TargetedOfferParser;

        public class TargetedOfferEvent extends MessageEvent implements IMessageEvent 
    {

        public function TargetedOfferEvent(_arg_1:Function)
        {
            super(_arg_1, TargetedOfferParser);
        }

        public function getParser():TargetedOfferParser
        {
            return (this._SafeStr_816 as TargetedOfferParser);
        }


    }
}

