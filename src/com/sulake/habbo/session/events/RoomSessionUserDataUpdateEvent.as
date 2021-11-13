package com.sulake.habbo.session.events
{
    import __AS3__.vec.Vector;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionUserDataUpdateEvent extends RoomSessionEvent 
    {

        public static const USER_DATA_UPDATED:String = "rsudue_user_data_updated";

        private var _addedUsers:Vector.<IUserData>;

        public function RoomSessionUserDataUpdateEvent(_arg_1:IRoomSession, _arg_2:Vector.<IUserData>, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super("rsudue_user_data_updated", _arg_1, _arg_3, _arg_4);
            _addedUsers = _arg_2;
        }

        public function get addedUsers():Vector.<IUserData>
        {
            return (_addedUsers);
        }


    }
}