package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class BannedUserData implements IFlatUser 
    {

        private var _userId:int;
        private var _userName:String;

        public function BannedUserData(_arg_1:IMessageDataWrapper)
        {
            _userId = _arg_1.readInteger();
            _userName = _arg_1.readString();
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