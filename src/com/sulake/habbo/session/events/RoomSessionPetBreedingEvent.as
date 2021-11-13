package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionPetBreedingEvent extends RoomSessionEvent 
    {

        public static const PET_BREEDING:String = "RSPFUE_PET_BREEDING";

        private var _state:int;
        private var _ownPetId:int;
        private var _otherPetId:int;

        public function RoomSessionPetBreedingEvent(_arg_1:IRoomSession, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super("RSPFUE_PET_BREEDING", _arg_1, _arg_5, _arg_6);
            _state = _arg_2;
            _ownPetId = _arg_3;
            _otherPetId = _arg_4;
        }

        public function get state():int
        {
            return (_state);
        }

        public function get ownPetId():int
        {
            return (_ownPetId);
        }

        public function get otherPetId():int
        {
            return (_otherPetId);
        }


    }
}