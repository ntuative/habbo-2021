package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.IsOfferGiftableMessageParser;

        public class IsOfferGiftableMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function IsOfferGiftableMessageEvent(_arg_1:Function)
        {
            super(_arg_1, IsOfferGiftableMessageParser);
        }

        public function getParser():IsOfferGiftableMessageParser
        {
            return (this._SafeStr_816 as IsOfferGiftableMessageParser);
        }


    }
}

