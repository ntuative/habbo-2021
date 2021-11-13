package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class AcceptFriendFailureData 
    {

        private var _SafeStr_1721:int;
        private var _SafeStr_776:int;

        public function AcceptFriendFailureData(_arg_1:IMessageDataWrapper)
        {
            this._SafeStr_1721 = _arg_1.readInteger();
            this._SafeStr_776 = _arg_1.readInteger();
        }

        public function get senderId():int
        {
            return (this._SafeStr_1721);
        }

        public function get errorCode():int
        {
            return (this._SafeStr_776);
        }


    }
}

