package com.sulake.habbo.communication.messages.incoming.marketplace
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceItemStatsParser;

        public class MarketplaceItemStatsEvent extends MessageEvent implements IMessageEvent 
    {

        public function MarketplaceItemStatsEvent(_arg_1:Function)
        {
            super(_arg_1, MarketplaceItemStatsParser);
        }

        public function getParser():MarketplaceItemStatsParser
        {
            return (_SafeStr_816 as MarketplaceItemStatsParser);
        }


    }
}

