package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetPetBreedingEvent extends RoomWidgetUpdateEvent 
    {

        public static const _SafeStr_4038:int = 0;
        public static const _SafeStr_4039:int = 1;
        public static const TYPE_ACCEPT:int = 2;
        public static const TYPE_REQUEST:int = 3;
        public static const PET_BREEDING:String = "RWPPBE_PET_BREEDING_";

        private var _state:int;
        private var _ownPetId:int;
        private var _otherPetId:int;

        public function RoomWidgetPetBreedingEvent(_arg_1:Boolean=false, _arg_2:Boolean=false)
        {
            super("RWPPBE_PET_BREEDING_", _arg_1, _arg_2);
        }

        public function get state():int
        {
            return (_state);
        }

        public function set state(_arg_1:int):void
        {
            _state = _arg_1;
        }

        public function get ownPetId():int
        {
            return (_ownPetId);
        }

        public function set ownPetId(_arg_1:int):void
        {
            _ownPetId = _arg_1;
        }

        public function get otherPetId():int
        {
            return (_otherPetId);
        }

        public function set otherPetId(_arg_1:int):void
        {
            _otherPetId = _arg_1;
        }


    }
}

