package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetFurniActionMessage extends RoomWidgetMessage 
    {

        public static const ROTATE:String = "RWFUAM_ROTATE";
        public static const MOVE:String = "RWFAM_MOVE";
        public static const _SafeStr_4190:String = "RWFAM_PICKUP";
        public static const _SafeStr_4191:String = "RWFAM_EJECT";
        public static const USE:String = "RWFAM_USE";
        public static const SAVE_STUFF_DATA:String = "RWFAM_SAVE_STUFF_DATA";

        private var _furniId:int = 0;
        private var _furniCategory:int = 0;
        private var _offerId:int;
        private var _objectData:String;

        public function RoomWidgetFurniActionMessage(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int=-1, _arg_5:String=null)
        {
            super(_arg_1);
            _furniId = _arg_2;
            _furniCategory = _arg_3;
            _offerId = _arg_4;
            _objectData = _arg_5;
        }

        public function get furniId():int
        {
            return (_furniId);
        }

        public function get furniCategory():int
        {
            return (_furniCategory);
        }

        public function get objectData():String
        {
            return (_objectData);
        }

        public function get offerId():int
        {
            return (_offerId);
        }


    }
}

