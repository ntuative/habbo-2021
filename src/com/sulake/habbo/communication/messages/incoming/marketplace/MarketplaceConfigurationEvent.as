package com.sulake.habbo.communication.messages.incoming.marketplace
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceConfigurationParser;

        public class MarketplaceConfigurationEvent extends MessageEvent implements IMessageEvent 
    {

        public function MarketplaceConfigurationEvent(_arg_1:Function)
        {
            super(_arg_1, MarketplaceConfigurationParser);
        }

        public function getParser():MarketplaceConfigurationParser
        {
            return (_SafeStr_816 as MarketplaceConfigurationParser);
        }


    }
}

