package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.CatalogIndexMessageParser;

        public class CatalogIndexMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CatalogIndexMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CatalogIndexMessageParser);
        }

        public function getParser():CatalogIndexMessageParser
        {
            return (this._SafeStr_816 as CatalogIndexMessageParser);
        }

        public function get root():NodeData
        {
            return (getParser().root);
        }

        public function get newAdditionsAvailable():Boolean
        {
            return (getParser().newAdditionsAvailable);
        }

        public function get catalogType():String
        {
            return (getParser().catalogType);
        }


    }
}

