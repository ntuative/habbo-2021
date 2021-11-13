package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionPetStatusUpdateEvent extends RoomSessionEvent 
    {

        public static const PET_STATUS_UPDATE:String = "RSPFUE_PET_STATUS_UPDATE";

        private var _petId:int;
        private var _canBreed:Boolean;
        private var _canHarvest:Boolean;
        private var _canRevive:Boolean;
        private var _hasBreedingPermission:Boolean;

        public function RoomSessionPetStatusUpdateEvent(_arg_1:IRoomSession, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean, _arg_5:Boolean, _arg_6:Boolean, _arg_7:Boolean=false, _arg_8:Boolean=false)
        {
            super("RSPFUE_PET_STATUS_UPDATE", _arg_1, _arg_7, _arg_8);
            _petId = _arg_2;
            _canBreed = _arg_3;
            _canHarvest = _arg_4;
            _canRevive = _arg_5;
            _hasBreedingPermission = _arg_6;
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