package com.sulake.habbo.navigator.roomsettings
{
    import com.sulake.habbo.communication.messages.incoming.roomsettings.IFlatUser;

    public class FriendEntryData implements IFlatUser 
    {

        private var _userId:int;
        private var _userName:String;

        public function FriendEntryData(_arg_1:int, _arg_2:String)
        {
            _userId = _arg_1;
            _userName = _arg_2;
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get userName():String
        {
            return (_userName);
        }


    }
}