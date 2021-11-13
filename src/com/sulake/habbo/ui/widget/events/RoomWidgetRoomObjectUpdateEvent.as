package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetRoomObjectUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const _SafeStr_4046:String = "RWROUE_OBJECT_SELECTED";
        public static const _SafeStr_4047:String = "RWROUE_OBJECT_DESELECTED";
        public static const USER_REMOVED:String = "RWROUE_USER_REMOVED";
        public static const _SafeStr_4048:String = "RWROUE_FURNI_REMOVED";
        public static const _SafeStr_4049:String = "RWROUE_FURNI_ADDED";
        public static const USER_ADDED:String = "RWROUE_USER_ADDED";
        public static const OBJECT_ROLL_OVER:String = "RWROUE_OBJECT_ROLL_OVER";
        public static const _SafeStr_4050:String = "RWROUE_OBJECT_ROLL_OUT";

        private var _id:int = 0;
        private var _category:int = 0;
        private var _roomId:int = 0;

        public function RoomWidgetRoomObjectUpdateEvent(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(_arg_1, _arg_5, _arg_6);
            _id = _arg_2;
            _category = _arg_3;
            _roomId = _arg_4;
        }

        public function get id():int
        {
            return (_id);
        }

        public function get category():int
        {
            return (_category);
        }

        public function get roomId():int
        {
            return (_roomId);
        }


    }
}

