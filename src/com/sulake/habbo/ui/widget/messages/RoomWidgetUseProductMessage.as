package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetUseProductMessage extends RoomWidgetMessage 
    {

        public static const PET_PRODUCT:String = "RWUPM_PET_PRODUCT";
        public static const MONSTERPLANT_SEED:String = "RWUPM_MONSTERPLANT_SEED";

        private var _roomObjectId:int = 0;
        private var _petId:int = -1;

        public function RoomWidgetUseProductMessage(_arg_1:String, _arg_2:int, _arg_3:int=-1)
        {
            super(_arg_1);
            _roomObjectId = _arg_2;
            _petId = _arg_3;
        }

        public function get roomObjectId():int
        {
            return (_roomObjectId);
        }

        public function get petId():int
        {
            return (_petId);
        }


    }
}