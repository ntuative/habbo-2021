package com.sulake.habbo.communication.messages.parser.campaign
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CampaignCalendarDataMessageParser implements IMessageParser 
    {

        private var _SafeStr_690:CampaignCalendarData;


        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _SafeStr_690 = new CampaignCalendarData();
            _SafeStr_690.parse(_arg_1);
            return (true);
        }

        public function flush():Boolean
        {
            _SafeStr_690 = null;
            return (true);
        }

        public function cloneData():CampaignCalendarData
        {
            return ((_SafeStr_690) ? _SafeStr_690.clone() : null);
        }


    }
}

