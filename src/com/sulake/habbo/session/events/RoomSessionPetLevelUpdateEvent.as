package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionPetLevelUpdateEvent extends RoomSessionEvent 
    {

        public static const PET_LEVEL_UPDATE:String = "RSPLUE_PET_LEVEL_UPDATE";

        private var _petId:int;
        private var _level:int;

        public function RoomSessionPetLevelUpdateEvent(_arg_1:IRoomSession, _arg_2:int, _arg_3:int, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super("RSPLUE_PET_LEVEL_UPDATE", _arg_1, _arg_4, _arg_5);
            _petId = _arg_2;
            _level = _arg_3;
        }

        public function get petId():int
        {
            return (_petId);
        }

        public function get level():int
        {
            return (_level);
        }


    }
}