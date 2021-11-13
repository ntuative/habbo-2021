package com.sulake.habbo.communication.messages.parser.campaign
{
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CampaignCalendarData 
    {

        private var _campaignName:String;
        private var _campaignImage:String;
        private var _currentDay:int;
        private var _campaignDays:int;
        private var _openedDays:Vector.<int>;
        private var _missedDays:Vector.<int>;


        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_2:int;
            _campaignName = _arg_1.readString();
            _campaignImage = _arg_1.readString();
            _currentDay = _arg_1.readInteger();
            _campaignDays = _arg_1.readInteger();
            _openedDays = new Vector.<int>(0);
            _local_2 = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _openedDays.push(_arg_1.readInteger());
                _local_3++;
            };
            _missedDays = new Vector.<int>(0);
            _local_2 = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _missedDays.push(_arg_1.readInteger());
                _local_3++;
            };
            return (true);
        }

        public function clone():CampaignCalendarData
        {
            var _local_1:CampaignCalendarData = new CampaignCalendarData();
            _local_1.campaignDays = _campaignDays;
            _local_1.campaignImage = _campaignImage;
            _local_1.campaignName = _campaignName;
            _local_1.currentDay = _currentDay;
            _local_1.missedDays = _missedDays;
            _local_1.openedDays = _openedDays;
            return (_local_1);
        }

        public function get campaignName():String
        {
            return (_campaignName);
        }

        public function get campaignImage():String
        {
            return (_campaignImage);
        }

        public function get currentDay():int
        {
            return (_currentDay);
        }

        public function get campaignDays():int
        {
            return (_campaignDays);
        }

        public function get openedDays():Vector.<int>
        {
            return (_openedDays);
        }

        public function get missedDays():Vector.<int>
        {
            return (_missedDays);
        }

        public function set campaignName(_arg_1:String):void
        {
            _campaignName = _arg_1;
        }

        public function set campaignImage(_arg_1:String):void
        {
            _campaignImage = _arg_1;
        }

        public function set currentDay(_arg_1:int):void
        {
            _currentDay = _arg_1;
        }

        public function set campaignDays(_arg_1:int):void
        {
            _campaignDays = _arg_1;
        }

        public function set openedDays(_arg_1:Vector.<int>):void
        {
            _openedDays = _arg_1;
        }

        public function set missedDays(_arg_1:Vector.<int>):void
        {
            _missedDays = _arg_1;
        }


    }
}