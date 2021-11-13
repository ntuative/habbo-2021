package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionDoorbellEvent extends RoomSessionEvent 
    {

        public static const DOORBELL:String = "RSDE_DOORBELL";
        public static const REJECTED:String = "RSDE_REJECTED";
        public static const ACCEPTED:String = "RSDE_ACCEPTED";

        private var _userName:String = "";

        public function RoomSessionDoorbellEvent(_arg_1:String, _arg_2:IRoomSession, _arg_3:String, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_4, _arg_5);
            _userName = _arg_3;
        }

        public function get userName():String
        {
            return (_userName);
        }


    }
}