package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.CatalogPublishedMessageParser;

        public class CatalogPublishedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CatalogPublishedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CatalogPublishedMessageParser);
        }

        public function getParser():CatalogPublishedMessageParser
        {
            return (this._SafeStr_816 as CatalogPublishedMessageParser);
        }

        public function get instantlyRefreshCatalogue():Boolean
        {
            return (getParser().instantlyRefreshCatalogue);
        }

        public function get newFurniDataHash():String
        {
            return (getParser().newFurniDataHash);
        }


    }
}

