package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetPlayListModificationMessage extends RoomWidgetMessage 
    {

        public static const ADD_TO_PLAYLIST:String = "RWPLAM_ADD_TO_PLAYLIST";
        public static const REMOVE_FROM_PLAYLIST:String = "RWPLAM_REMOVE_FROM_PLAYLIST";

        private var _diskId:int;
        private var _slotNumber:int;

        public function RoomWidgetPlayListModificationMessage(_arg_1:String, _arg_2:int=-1, _arg_3:int=-1)
        {
            super(_arg_1);
            _slotNumber = _arg_2;
            _diskId = _arg_3;
        }

        public function get diskId():int
        {
            return (_diskId);
        }

        public function get slotNumber():int
        {
            return (_slotNumber);
        }


    }
}