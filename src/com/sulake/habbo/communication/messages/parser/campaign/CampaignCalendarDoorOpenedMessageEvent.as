package com.sulake.habbo.communication.messages.parser.campaign
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class CampaignCalendarDoorOpenedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CampaignCalendarDoorOpenedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CampaignCalendarDoorOpenedMessageParser);
        }

        public function getParser():CampaignCalendarDoorOpenedMessageParser
        {
            return (_SafeStr_816 as CampaignCalendarDoorOpenedMessageParser);
        }


    }
}

