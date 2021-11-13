package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetConfirmPetBreedingEvent extends RoomWidgetUpdateEvent 
    {

        public static const CONFIRM_PET_BREEDING:String = "RWPPBE_CONFIRM_PET_BREEDING_";

        private var _nestId:int;
        private var _pet1:ConfirmPetBreedingPetData;
        private var _pet2:ConfirmPetBreedingPetData;
        private var _rarityCategories:Array;
        private var _resultPetTypeId:int;

        public function RoomWidgetConfirmPetBreedingEvent(_arg_1:int, _arg_2:ConfirmPetBreedingPetData, _arg_3:ConfirmPetBreedingPetData, _arg_4:Array, _arg_5:int, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super("RWPPBE_CONFIRM_PET_BREEDING_", _arg_6, _arg_7);
            _nestId = _arg_1;
            _pet1 = _arg_2;
            _pet2 = _arg_3;
            _rarityCategories = _arg_4;
            _resultPetTypeId = _arg_5;
        }

        public function get rarityCategories():Array
        {
            return (_rarityCategories);
        }

        public function get nestId():int
        {
            return (_nestId);
        }

        public function get pet1():ConfirmPetBreedingPetData
        {
            return (_pet1);
        }

        public function get pet2():ConfirmPetBreedingPetData
        {
            return (_pet2);
        }

        public function get resultPetTypeId():int
        {
            return (_resultPetTypeId);
        }


    }
}