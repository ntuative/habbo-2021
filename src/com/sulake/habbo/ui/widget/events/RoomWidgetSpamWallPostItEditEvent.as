package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetSpamWallPostItEditEvent extends RoomWidgetUpdateEvent 
    {

        public static const _SafeStr_4054:String = "RWSWPUE_OPEN_EDITOR";

        private var _objectId:int;
        private var _location:String;
        private var _objectType:String;

        public function RoomWidgetSpamWallPostItEditEvent(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(_arg_1, _arg_5, _arg_6);
            _objectId = _arg_2;
            _location = _arg_3;
            _objectType = _arg_4;
        }

        public function get location():String
        {
            return (_location);
        }

        public function get objectId():int
        {
            return (_objectId);
        }

        public function get objectType():String
        {
            return (_objectType);
        }


    }
}

