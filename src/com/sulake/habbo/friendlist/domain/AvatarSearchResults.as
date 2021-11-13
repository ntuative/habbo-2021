package com.sulake.habbo.friendlist.domain
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.communication.messages.incoming.friendlist.HabboSearchResultData;

    public class AvatarSearchResults 
    {

        private var _SafeStr_2459:IAvatarSearchDeps;
        private var _friends:Array;
        private var _others:Array;
        private var _SafeStr_2460:Dictionary = new Dictionary();

        public function AvatarSearchResults(_arg_1:IAvatarSearchDeps)
        {
            _SafeStr_2459 = _arg_1;
        }

        public function getResult(_arg_1:int):HabboSearchResultData
        {
            for each (var _local_3:HabboSearchResultData in _friends)
            {
                if (_local_3.avatarId == _arg_1)
                {
                    return (_local_3);
                };
            };
            for each (var _local_2:HabboSearchResultData in _others)
            {
                if (_local_2.avatarId == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function searchReceived(_arg_1:Array, _arg_2:Array):void
        {
            _friends = _arg_1;
            _others = _arg_2;
            _SafeStr_2459.view.refreshList();
        }

        public function get friends():Array
        {
            return (_friends);
        }

        public function get others():Array
        {
            return (_others);
        }

        public function setFriendRequestSent(_arg_1:int):void
        {
            _SafeStr_2460[_arg_1] = "yes";
        }

        public function isFriendRequestSent(_arg_1:int):Boolean
        {
            return (!(_SafeStr_2460[_arg_1] == null));
        }


    }
}

