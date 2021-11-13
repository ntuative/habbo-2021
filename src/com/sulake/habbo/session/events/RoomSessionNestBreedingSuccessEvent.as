package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionNestBreedingSuccessEvent extends RoomSessionEvent 
    {

        public static const NEST_BREEDING_SUCCESS:String = "RSPFUE_NEST_BREEDING_SUCCESS";

        private var _rarityCategory:int;
        private var _petId:int;

        public function RoomSessionNestBreedingSuccessEvent(_arg_1:IRoomSession, _arg_2:int, _arg_3:int, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super("RSPFUE_NEST_BREEDING_SUCCESS", _arg_1, _arg_4, _arg_5);
            _petId = _arg_2;
            _rarityCategory = _arg_3;
        }

        public function get rarityCategory():int
        {
            return (_rarityCategory);
        }

        public function get petId():int
        {
            return (_petId);
        }


    }
}