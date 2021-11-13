package com.sulake.habbo.communication.messages.parser.perk
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class CitizenshipVipOfferPromoEnabledEvent extends MessageEvent implements IMessageEvent 
    {

        public function CitizenshipVipOfferPromoEnabledEvent(_arg_1:Function)
        {
            super(_arg_1, CitizenshipVipOfferPromoEnabledMessageParser);
        }

        public function getParser():CitizenshipVipOfferPromoEnabledMessageParser
        {
            return (_SafeStr_816 as CitizenshipVipOfferPromoEnabledMessageParser);
        }


    }
}

