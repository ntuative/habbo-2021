package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.DirectSMSClubBuyAvailableMessageParser;

        public class DirectSMSClubBuyAvailableMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function DirectSMSClubBuyAvailableMessageEvent(_arg_1:Function)
        {
            super(_arg_1, DirectSMSClubBuyAvailableMessageParser);
        }

        public function getParser():DirectSMSClubBuyAvailableMessageParser
        {
            return (this._SafeStr_816 as DirectSMSClubBuyAvailableMessageParser);
        }


    }
}

