package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class NewFriendRequestMessageParser implements IMessageParser 
    {

        private var _SafeStr_1983:FriendRequestData;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._SafeStr_1983 = new FriendRequestData(_arg_1);
            return (true);
        }

        public function get req():FriendRequestData
        {
            return (this._SafeStr_1983);
        }


    }
}

