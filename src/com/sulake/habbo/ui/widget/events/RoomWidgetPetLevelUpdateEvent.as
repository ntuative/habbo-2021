package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetPetLevelUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const PET_LEVEL_UPDATE:String = "RWPLUE_PET_LEVEL_UPDATE";

        private var _petId:int;
        private var _level:int;

        public function RoomWidgetPetLevelUpdateEvent(_arg_1:int, _arg_2:int, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super("RWPLUE_PET_LEVEL_UPDATE", _arg_3, _arg_4);
            _petId = _arg_1;
            _level = _arg_2;
        }

        public function get petId():int
        {
            return (_petId);
        }

        public function get level():int
        {
            return (_level);
        }


    }
}