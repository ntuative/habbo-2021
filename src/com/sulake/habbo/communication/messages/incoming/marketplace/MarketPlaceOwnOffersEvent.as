package com.sulake.habbo.communication.messages.incoming.marketplace
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketPlaceOwnOffersParser;

        public class MarketPlaceOwnOffersEvent extends MessageEvent implements IMessageEvent 
    {

        public function MarketPlaceOwnOffersEvent(_arg_1:Function)
        {
            super(_arg_1, MarketPlaceOwnOffersParser);
        }

        public function getParser():MarketPlaceOwnOffersParser
        {
            return (_SafeStr_816 as MarketPlaceOwnOffersParser);
        }


    }
}

