package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetConfirmPetBreedingResultEvent extends RoomWidgetUpdateEvent 
    {

        public static const CONFIRM_PET_BREEDING_RESULT:String = "RWPPBE_CONFIRM_PET_BREEDING_RESULT";
        public static const SUCCESS:int = 0;
        public static const _SafeStr_4030:int = 1;
        public static const PETS_MISSING:int = 2;
        public static const INVALID_NAME:int = 3;

        private var _breedingNestStuffId:int;
        private var _result:int;

        public function RoomWidgetConfirmPetBreedingResultEvent(_arg_1:int, _arg_2:int, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super("RWPPBE_CONFIRM_PET_BREEDING_RESULT", _arg_3, _arg_4);
            _breedingNestStuffId = _arg_1;
            _result = _arg_2;
        }

        public function get breedingNestStuffId():int
        {
            return (_breedingNestStuffId);
        }

        public function get result():int
        {
            return (_result);
        }


    }
}

