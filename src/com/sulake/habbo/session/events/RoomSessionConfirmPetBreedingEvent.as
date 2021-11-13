package com.sulake.habbo.session.events
{
    import com.sulake.habbo.communication.messages.incoming.room.pets.BreedingPetInfo;
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionConfirmPetBreedingEvent extends RoomSessionEvent 
    {

        public static const CONFIRM_PET_BREEDING:String = "RSPFUE_CONFIRM_PET_BREEDING";

        private var _nestId:int;
        private var _pet1:BreedingPetInfo;
        private var _pet2:BreedingPetInfo;
        private var _rarityCategories:Array;
        private var _resultPetTypeId:int;

        public function RoomSessionConfirmPetBreedingEvent(_arg_1:IRoomSession, _arg_2:int, _arg_3:BreedingPetInfo, _arg_4:BreedingPetInfo, _arg_5:Array, _arg_6:int, _arg_7:Boolean=false, _arg_8:Boolean=false)
        {
            super("RSPFUE_CONFIRM_PET_BREEDING", _arg_1, _arg_7, _arg_8);
            _nestId = _arg_2;
            _pet1 = _arg_3;
            _pet2 = _arg_4;
            _rarityCategories = _arg_5;
            _resultPetTypeId = _arg_6;
        }

        public function get rarityCategories():Array
        {
            return (_rarityCategories);
        }

        public function get nestId():int
        {
            return (_nestId);
        }

        public function get pet1():BreedingPetInfo
        {
            return (_pet1);
        }

        public function get pet2():BreedingPetInfo
        {
            return (_pet2);
        }

        public function get resultPetTypeId():int
        {
            return (_resultPetTypeId);
        }


    }
}