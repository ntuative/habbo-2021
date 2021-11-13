package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetClothingChangeMessage extends RoomWidgetMessage 
    {

        public static const REQUEST_EDITOR:String = "RWCCM_REQUEST_EDITOR";

        private var _objectId:int = 0;
        private var _objectCategory:int = 0;
        private var _roomId:int = 0;
        private var _gender:String = "";

        public function RoomWidgetClothingChangeMessage(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:int)
        {
            super(_arg_1);
            _gender = _arg_2;
            _objectId = _arg_3;
            _objectCategory = _arg_4;
            _roomId = _arg_5;
        }

        public function get objectId():int
        {
            return (_objectId);
        }

        public function get objectCategory():int
        {
            return (_objectCategory);
        }

        public function get roomId():int
        {
            return (_roomId);
        }

        public function get gender():String
        {
            return (_gender);
        }


    }
}