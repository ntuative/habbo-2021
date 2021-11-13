package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.CatalogPageWithEarliestExpiryMessageParser;

        public class CatalogPageWithEarliestExpiryMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CatalogPageWithEarliestExpiryMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CatalogPageWithEarliestExpiryMessageParser);
        }

        public function getParser():CatalogPageWithEarliestExpiryMessageParser
        {
            return (this._SafeStr_816 as CatalogPageWithEarliestExpiryMessageParser);
        }


    }
}

