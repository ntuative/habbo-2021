package com.sulake.habbo.communication.messages.incoming.marketplace
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceBuyOfferResultParser;

        public class MarketplaceBuyOfferResultEvent extends MessageEvent implements IMessageEvent 
    {

        public function MarketplaceBuyOfferResultEvent(_arg_1:Function)
        {
            super(_arg_1, MarketplaceBuyOfferResultParser);
        }

        public function getParser():MarketplaceBuyOfferResultParser
        {
            return (_SafeStr_816 as MarketplaceBuyOfferResultParser);
        }


    }
}

