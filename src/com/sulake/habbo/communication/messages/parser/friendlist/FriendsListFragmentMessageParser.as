package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FriendsListFragmentMessageParser implements IMessageParser 
    {

        protected var _SafeStr_1976:int;
        protected var _SafeStr_1977:int;
        private var _friendFragment:Array;


        public function get totalFragments():int
        {
            return (_SafeStr_1976);
        }

        public function get fragmentNo():int
        {
            return (_SafeStr_1977);
        }

        public function get friendFragment():Array
        {
            return (_friendFragment);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _SafeStr_1976 = _arg_1.readInteger();
            _SafeStr_1977 = _arg_1.readInteger();
            _friendFragment = [];
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                this._friendFragment.push(new FriendData(_arg_1));
                _local_3++;
            };
            return (true);
        }

        public function flush():Boolean
        {
            _friendFragment = [];
            return (true);
        }


    }
}

