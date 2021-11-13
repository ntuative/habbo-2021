package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionPropertyUpdateEvent extends RoomSessionEvent 
    {

        public static const ALLOW_PETS:String = "RSDUE_ALLOW_PETS";

        public function RoomSessionPropertyUpdateEvent(_arg_1:String, _arg_2:IRoomSession, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }

    }
}