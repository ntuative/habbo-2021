package com.sulake.habbo.friendlist.domain
{
    import com.sulake.habbo.friendlist.Util;

    public class FriendRequests 
    {

        private var _SafeStr_2459:IFriendRequestsDeps;
        private var _requests:Array = [];
        private var _limit:int;
        private var _clubLimit:int;

        public function FriendRequests(_arg_1:IFriendRequestsDeps, _arg_2:int, _arg_3:int)
        {
            _SafeStr_2459 = _arg_1;
            _limit = _arg_2;
            _clubLimit = _arg_3;
        }

        public function clearAndUpdateView(_arg_1:Boolean):void
        {
            var _local_3:Array = [];
            for each (var _local_2:FriendRequest in _requests)
            {
                if (((!(_arg_1)) || (!(_local_2.state == 1))))
                {
                    _local_3.push(_local_2);
                };
            };
            for each (var _local_4:FriendRequest in _local_3)
            {
                Util.remove(_requests, _local_4);
                if (_SafeStr_2459.view != null)
                {
                    _SafeStr_2459.view.removeRequest(_local_4);
                };
                _local_4.dispose();
            };
            refreshShading();
        }

        public function acceptFailed(_arg_1:int):void
        {
            var _local_2:FriendRequest = getRequestByRequesterId(_arg_1);
            if (_local_2 == null)
            {
                Logger.log((("Failed to accept friend request from " + _arg_1) + ", error retrieving the friendrequest."));
                return;
            };
            _local_2.state = 4;
            _SafeStr_2459.view.refreshRequestEntry(_local_2);
        }

        public function addRequest(_arg_1:FriendRequest):void
        {
            _requests.push(_arg_1);
        }

        public function addRequestAndUpdateView(_arg_1:FriendRequest):void
        {
            _requests.push(_arg_1);
            _SafeStr_2459.view.addRequest(_arg_1);
        }

        public function getRequest(_arg_1:int):FriendRequest
        {
            for each (var _local_2:FriendRequest in _requests)
            {
                if (_local_2.requestId == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function getRequestByRequesterId(_arg_1:int):FriendRequest
        {
            for each (var _local_2:FriendRequest in _requests)
            {
                if (_local_2.requesterUserId == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function refreshShading():void
        {
            var _local_1:Boolean = true;
            for each (var _local_2:FriendRequest in _requests)
            {
                _local_1 = (!(_local_1));
                _SafeStr_2459.view.refreshShading(_local_2, _local_1);
            };
        }

        public function getCountOfOpenRequests():int
        {
            var _local_1:int;
            for each (var _local_2:FriendRequest in requests)
            {
                if (_local_2.state == 1)
                {
                    _local_1++;
                };
            };
            return (_local_1);
        }

        public function get requests():Array
        {
            return (_requests);
        }

        public function get limit():int
        {
            return (_limit);
        }

        public function get clubLimit():int
        {
            return (_clubLimit);
        }

        public function set limit(_arg_1:int):void
        {
            _limit = _arg_1;
        }


    }
}

