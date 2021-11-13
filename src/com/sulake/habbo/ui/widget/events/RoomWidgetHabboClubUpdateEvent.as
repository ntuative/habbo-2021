package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetHabboClubUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const _SafeStr_3041:String = "RWBIUE_HABBO_CLUB";

        private var _daysLeft:int = 0;
        private var _periodsLeft:int = 0;
        private var _pastPeriods:int = 0;
        private var _allowClubDances:Boolean = false;
        private var _clubLevel:int;

        public function RoomWidgetHabboClubUpdateEvent(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Boolean, _arg_5:int, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super("RWBIUE_HABBO_CLUB", _arg_6, _arg_7);
            _daysLeft = _arg_1;
            _periodsLeft = _arg_2;
            _pastPeriods = _arg_3;
            _allowClubDances = _arg_4;
            _clubLevel = _arg_5;
        }

        public function get daysLeft():int
        {
            return (_daysLeft);
        }

        public function get periodsLeft():int
        {
            return (_periodsLeft);
        }

        public function get pastPeriods():int
        {
            return (_pastPeriods);
        }

        public function get allowClubDances():Boolean
        {
            return (_allowClubDances);
        }

        public function get clubLevel():int
        {
            return (_clubLevel);
        }


    }
}

