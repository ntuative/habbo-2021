package com.sulake.habbo.communication.messages.incoming.marketplace
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceCanMakeOfferResultParser;

        public class MarketplaceCanMakeOfferResult extends MessageEvent implements IMessageEvent 
    {

        public function MarketplaceCanMakeOfferResult(_arg_1:Function)
        {
            super(_arg_1, MarketplaceCanMakeOfferResultParser);
        }

        public function getParser():MarketplaceCanMakeOfferResultParser
        {
            return (_SafeStr_816 as MarketplaceCanMakeOfferResultParser);
        }


    }
}

