package com.sulake.habbo.inventory.purse
{
    import flash.utils.getTimer;

    public class Purse 
    {

        private var _clubIsExpiring:Boolean = false;
        private var _citizenshipVipIsExpiring:Boolean = false;
        private var _clubDays:int = 0;
        private var _clubPeriods:int = 0;
        private var _clubPastPeriods:int = 0;
        private var _clubHasEverBeenMember:Boolean = false;
        private var _isVIP:Boolean = false;
        private var _minutesUntilExpiration:int = 0;
        private var _minutesSinceLastModified:int = -1;
        private var _SafeStr_2771:int;


        public function get clubDays():int
        {
            return (_clubDays);
        }

        public function set clubDays(_arg_1:int):void
        {
            _SafeStr_2771 = getTimer();
            _clubDays = Math.max(0, _arg_1);
        }

        public function get clubPeriods():int
        {
            return (_clubPeriods);
        }

        public function set clubPeriods(_arg_1:int):void
        {
            _SafeStr_2771 = getTimer();
            _clubPeriods = Math.max(0, _arg_1);
        }

        public function get clubPastPeriods():int
        {
            return (_clubPastPeriods);
        }

        public function set clubPastPeriods(_arg_1:int):void
        {
            _SafeStr_2771 = getTimer();
            _clubPastPeriods = Math.max(0, _arg_1);
        }

        public function get clubHasEverBeenMember():Boolean
        {
            return (_clubHasEverBeenMember);
        }

        public function set clubHasEverBeenMember(_arg_1:Boolean):void
        {
            _SafeStr_2771 = getTimer();
            _clubHasEverBeenMember = _arg_1;
        }

        public function get isVIP():Boolean
        {
            return (_isVIP);
        }

        public function set isVIP(_arg_1:Boolean):void
        {
            _SafeStr_2771 = getTimer();
            _isVIP = _arg_1;
        }

        public function get minutesUntilExpiration():int
        {
            var _local_1:int = int(((getTimer() - _SafeStr_2771) / 60000));
            var _local_2:int = (_minutesUntilExpiration - _local_1);
            return ((_local_2 > 0) ? _local_2 : 0);
        }

        public function set minutesUntilExpiration(_arg_1:int):void
        {
            _SafeStr_2771 = getTimer();
            _minutesUntilExpiration = _arg_1;
        }

        public function get clubIsExpiring():Boolean
        {
            return (_clubIsExpiring);
        }

        public function set clubIsExpiring(_arg_1:Boolean):void
        {
            _clubIsExpiring = _arg_1;
        }

        public function get citizenshipVipIsExpiring():Boolean
        {
            return (_citizenshipVipIsExpiring);
        }

        public function set citizenshipVipIsExpiring(_arg_1:Boolean):void
        {
            _citizenshipVipIsExpiring = _arg_1;
        }

        public function get minutesSinceLastModified():int
        {
            return (_minutesSinceLastModified);
        }

        public function set minutesSinceLastModified(_arg_1:int):void
        {
            _SafeStr_2771 = getTimer();
            _minutesSinceLastModified = _arg_1;
        }


    }
}

