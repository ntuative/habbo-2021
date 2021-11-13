package com.sulake.habbo.communication.messages.incoming.marketplace
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketPlaceOffersParser;

        public class MarketPlaceOffersEvent extends MessageEvent implements IMessageEvent 
    {

        public function MarketPlaceOffersEvent(_arg_1:Function)
        {
            super(_arg_1, MarketPlaceOffersParser);
        }

        public function getParser():MarketPlaceOffersParser
        {
            return (_SafeStr_816 as MarketPlaceOffersParser);
        }


    }
}

