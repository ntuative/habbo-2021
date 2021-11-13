package com.sulake.habbo.catalog.purse
{
    import flash.utils.Dictionary;
    import flash.utils.getTimer;

    public class Purse implements IPurse 
    {

        private var _credits:int = 0;
        private var _activityPoints:Dictionary = new Dictionary();
        private var _clubDays:int = 0;
        private var _clubPeriods:int = 0;
        private var _isVIP:Boolean = false;
        private var _pastClubDays:int = 0;
        private var _pastVipDays:int = 0;
        private var _isExpiring:Boolean = false;
        private var _minutesUntilExpiration:int = 0;
        private var _minutesSinceLastModified:int;
        private var _lastUpdated:int;


        public function get credits():int
        {
            return (_credits);
        }

        public function set credits(_arg_1:int):void
        {
            _lastUpdated = getTimer();
            _credits = _arg_1;
        }

        public function get clubDays():int
        {
            return (_clubDays);
        }

        public function set clubDays(_arg_1:int):void
        {
            _lastUpdated = getTimer();
            _clubDays = _arg_1;
        }

        public function get clubPeriods():int
        {
            return (_clubPeriods);
        }

        public function set clubPeriods(_arg_1:int):void
        {
            _lastUpdated = getTimer();
            _clubPeriods = _arg_1;
        }

        public function get hasClubLeft():Boolean
        {
            return ((_clubDays > 0) || (_clubPeriods > 0));
        }

        public function get isVIP():Boolean
        {
            return (_isVIP);
        }

        public function get isExpiring():Boolean
        {
            return (_isExpiring);
        }

        public function set isExpiring(_arg_1:Boolean):void
        {
            _isExpiring = _arg_1;
        }

        public function set isVIP(_arg_1:Boolean):void
        {
            _isVIP = _arg_1;
        }

        public function get pastClubDays():int
        {
            return (_pastClubDays);
        }

        public function set pastClubDays(_arg_1:int):void
        {
            _lastUpdated = getTimer();
            _pastClubDays = _arg_1;
        }

        public function get pastVipDays():int
        {
            return (_pastVipDays);
        }

        public function set pastVipDays(_arg_1:int):void
        {
            _lastUpdated = getTimer();
            _pastVipDays = _arg_1;
        }

        public function get activityPoints():Dictionary
        {
            return (_activityPoints);
        }

        public function set activityPoints(_arg_1:Dictionary):void
        {
            _lastUpdated = getTimer();
            _activityPoints = _arg_1;
        }

        public function getActivityPointsForType(_arg_1:int):int
        {
            return (_activityPoints[_arg_1]);
        }

        public function set minutesUntilExpiration(_arg_1:int):void
        {
            _lastUpdated = getTimer();
            _minutesUntilExpiration = _arg_1;
        }

        public function get minutesUntilExpiration():int
        {
            var _local_1:int = int(((getTimer() - _lastUpdated) / 60000));
            var _local_2:int = (_minutesUntilExpiration - _local_1);
            return ((_local_2 > 0) ? _local_2 : 0);
        }

        public function set minutesSinceLastModified(_arg_1:int):void
        {
            _lastUpdated = getTimer();
            _minutesSinceLastModified = _arg_1;
        }

        public function get minutesSinceLastModified():int
        {
            return (_minutesSinceLastModified);
        }

        public function get lastUpdated():int
        {
            return (_lastUpdated);
        }


    }
}