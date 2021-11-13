package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.PurchaseErrorMessageParser;

        public class PurchaseErrorMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PurchaseErrorMessageEvent(_arg_1:Function)
        {
            super(_arg_1, PurchaseErrorMessageParser);
        }

        public function getParser():PurchaseErrorMessageParser
        {
            return (this._SafeStr_816 as PurchaseErrorMessageParser);
        }


    }
}

