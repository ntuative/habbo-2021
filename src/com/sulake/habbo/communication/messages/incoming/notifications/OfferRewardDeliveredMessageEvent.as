package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.OfferRewardDeliveredMessageParser;

        public class OfferRewardDeliveredMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function OfferRewardDeliveredMessageEvent(_arg_1:Function)
        {
            super(_arg_1, OfferRewardDeliveredMessageParser);
        }

        public function getParser():OfferRewardDeliveredMessageParser
        {
            return (_SafeStr_816 as OfferRewardDeliveredMessageParser);
        }


    }
}

