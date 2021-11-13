package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetAchievementResolutionTrophyDataUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const UPDATE_TROPHY_DATA:String = "RWARTDUE_TROPHY_DATA";

        private var _color:Number;
        private var _name:String;
        private var _date:String;
        private var _message:String;
        private var _viewType:int;

        public function RoomWidgetAchievementResolutionTrophyDataUpdateEvent(_arg_1:String, _arg_2:Number, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:int, _arg_7:Boolean=false, _arg_8:Boolean=false)
        {
            super(_arg_1, _arg_7, _arg_8);
            _color = _arg_2;
            _name = _arg_3;
            _date = _arg_4;
            _message = _arg_5;
            _viewType = _arg_6;
        }

        public function get color():Number
        {
            return (_color);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get date():String
        {
            return (_date);
        }

        public function get message():String
        {
            return (_message);
        }

        public function get viewType():int
        {
            return (_viewType);
        }


    }
}