package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.CatalogPageExpirationParser;

        public class CatalogPageExpirationEvent extends MessageEvent implements IMessageEvent 
    {

        public function CatalogPageExpirationEvent(_arg_1:Function)
        {
            super(_arg_1, CatalogPageExpirationParser);
        }

        public function getParser():CatalogPageExpirationParser
        {
            return (this._SafeStr_816 as CatalogPageExpirationParser);
        }


    }
}

