package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetPetStatusUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const PET_STATUS_UPDATE:String = "RWPIUE_PET_STATUS_UPDATE";

        private var _petId:int;
        private var _canBreed:Boolean;
        private var _canHarvest:Boolean;
        private var _canRevive:Boolean;
        private var _hasBreedingPermission:Boolean;

        public function RoomWidgetPetStatusUpdateEvent(_arg_1:int, _arg_2:Boolean, _arg_3:Boolean, _arg_4:Boolean, _arg_5:Boolean, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super("RWPIUE_PET_STATUS_UPDATE", _arg_6, _arg_7);
            _petId = _arg_1;
            _canBreed = _arg_2;
            _canHarvest = _arg_3;
            _canRevive = _arg_4;
            _hasBreedingPermission = _arg_5;
        }

        public function get petId():int
        {
            return (_petId);
        }

        public function get canBreed():Boolean
        {
            return (_canBreed);
        }

        public function get canHarvest():Boolean
        {
            return (_canHarvest);
        }

        public function get canRevive():Boolean
        {
            return (_canRevive);
        }

        public function get hasBreedingPermission():Boolean
        {
            return (_hasBreedingPermission);
        }


    }
}