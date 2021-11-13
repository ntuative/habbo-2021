package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetPetBreedingResultEvent extends RoomWidgetUpdateEvent 
    {

        public static const PET_BREEDING_RESULT:String = "RWPBRE_PET_BREEDING_RESULT";

        private var _resultData:PetBreedingResultEventData;
        private var _resultData2:PetBreedingResultEventData;

        public function RoomWidgetPetBreedingResultEvent(_arg_1:PetBreedingResultEventData, _arg_2:PetBreedingResultEventData, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super("RWPBRE_PET_BREEDING_RESULT", _arg_3, _arg_4);
            _resultData = _arg_1;
            _resultData2 = _arg_2;
        }

        public function get resultData():PetBreedingResultEventData
        {
            return (_resultData);
        }

        public function get resultData2():PetBreedingResultEventData
        {
            return (_resultData2);
        }


    }
}