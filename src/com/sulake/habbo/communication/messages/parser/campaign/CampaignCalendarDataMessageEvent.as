package com.sulake.habbo.communication.messages.parser.campaign
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class CampaignCalendarDataMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CampaignCalendarDataMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CampaignCalendarDataMessageParser);
        }

        public function getParser():CampaignCalendarDataMessageParser
        {
            return (_SafeStr_816 as CampaignCalendarDataMessageParser);
        }


    }
}

