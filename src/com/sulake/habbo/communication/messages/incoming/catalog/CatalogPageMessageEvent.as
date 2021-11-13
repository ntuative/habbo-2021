package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.CatalogPageMessageParser;

        public class CatalogPageMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CatalogPageMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CatalogPageMessageParser);
        }

        public function getParser():CatalogPageMessageParser
        {
            return (this._SafeStr_816 as CatalogPageMessageParser);
        }


    }
}

