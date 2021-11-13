package com.sulake.habbo.session.events
{
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetBreedingResultData;
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionPetBreedingResultEvent extends RoomSessionEvent 
    {

        public static const PET_BREEDING_RESULT:String = "RSPFUE_PET_BREEDING_RESULT";

        private var _resultData:PetBreedingResultData;
        private var _otherResultData:PetBreedingResultData;

        public function RoomSessionPetBreedingResultEvent(_arg_1:IRoomSession, _arg_2:PetBreedingResultData, _arg_3:PetBreedingResultData, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super("RSPFUE_PET_BREEDING_RESULT", _arg_1, _arg_4, _arg_5);
            _resultData = _arg_2;
            _otherResultData = _arg_3;
        }

        public function get resultData():PetBreedingResultData
        {
            return (_resultData);
        }

        public function get otherResultData():PetBreedingResultData
        {
            return (_otherResultData);
        }


    }
}