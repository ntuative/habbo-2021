package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IPetInfo;
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionPetInfoUpdateEvent extends RoomSessionEvent 
    {

        public static const PET_INFO:String = "RSPIUE_PET_INFO";

        private var _petInfo:IPetInfo;

        public function RoomSessionPetInfoUpdateEvent(_arg_1:IRoomSession, _arg_2:IPetInfo, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super("RSPIUE_PET_INFO", _arg_1, _arg_3, _arg_4);
            _petInfo = _arg_2;
        }

        public function get petInfo():IPetInfo
        {
            return (_petInfo);
        }


    }
}