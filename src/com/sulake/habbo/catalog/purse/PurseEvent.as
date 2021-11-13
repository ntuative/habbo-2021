package com.sulake.habbo.catalog.purse
{
    import flash.events.Event;

    public class PurseEvent extends Event 
    {

        public static const CREDIT_BALANCE:String = "catalog_purse_credit_balance";
        public static const ACTIVITY_POINT_BALANCE:String = "catalog_purse_activity_point_balance";

        private var _balance:int;
        private var _activityPointType:int;

        public function PurseEvent(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(_arg_1, _arg_4, _arg_5);
            _balance = _arg_2;
            _activityPointType = _arg_3;
        }

        public function get balance():int
        {
            return (_balance);
        }

        public function get activityPointType():int
        {
            return (_activityPointType);
        }


    }
}