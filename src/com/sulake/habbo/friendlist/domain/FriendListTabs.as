package com.sulake.habbo.friendlist.domain
{
    import com.sulake.habbo.friendlist.FriendsView;
    import com.sulake.habbo.friendlist.FriendRequestsView;
    import com.sulake.habbo.friendlist.SearchView;
    import com.sulake.habbo.friendlist.*;

    public class FriendListTabs 
    {

        private var _SafeStr_2459:IFriendListTabsDeps;
        private var _SafeStr_1459:Array = [];
        private var _SafeStr_2462:FriendListTab;
        private var _tabContentHeight:int = 200;
        private var _SafeStr_2463:int = 200;
        private var _windowWidth:int = 200;

        public function FriendListTabs(_arg_1:IFriendListTabsDeps)
        {
            _SafeStr_2459 = _arg_1;
            _SafeStr_1459.push(new FriendListTab(_SafeStr_2459.getFriendList(), 1, new FriendsView(), "${friendlist.friends}", "friends_footer", "hdr_friends"));
            _SafeStr_1459.push(new FriendListTab(_SafeStr_2459.getFriendList(), 2, new FriendRequestsView(), "${friendlist.tab.friendrequests}", "friend_requests_footer", "hdr_friend_requests"));
            _SafeStr_1459.push(new FriendListTab(_SafeStr_2459.getFriendList(), 3, new SearchView(), "${generic.search}", "search_footer", "hdr_search"));
            toggleSelected(null);
        }

        public function getTabs():Array
        {
            return (_SafeStr_1459);
        }

        public function findTab(_arg_1:int):FriendListTab
        {
            for each (var _local_2:FriendListTab in _SafeStr_1459)
            {
                if (_local_2.id == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function clearSelections():void
        {
            for each (var _local_1:FriendListTab in _SafeStr_1459)
            {
                _local_1.setSelected(false);
            };
        }

        public function findSelectedTab():FriendListTab
        {
            for each (var _local_1:FriendListTab in _SafeStr_1459)
            {
                if (_local_1.selected)
                {
                    return (_local_1);
                };
            };
            return (null);
        }

        public function toggleSelected(_arg_1:FriendListTab):void
        {
            var _local_2:FriendListTab = findSelectedTab();
            if (_local_2 == null)
            {
                _tabContentHeight = _SafeStr_2463;
                setSelected(determineDisplayedTab(_arg_1), true);
            }
            else
            {
                if (((_local_2 == _arg_1) || (_arg_1 == null)))
                {
                    _SafeStr_2463 = _tabContentHeight;
                    _tabContentHeight = 0;
                    clearSelections();
                }
                else
                {
                    setSelected(determineDisplayedTab(_arg_1), true);
                };
            };
        }

        private function setSelected(_arg_1:FriendListTab, _arg_2:Boolean):void
        {
            var _local_3:FriendListTab = findSelectedTab();
            clearSelections();
            _arg_1.setSelected(_arg_2);
            if (_arg_2)
            {
                _SafeStr_2462 = _arg_1;
            };
        }

        private function determineDisplayedTab(_arg_1:FriendListTab):FriendListTab
        {
            if (_arg_1 != null)
            {
                return (_arg_1);
            };
            if (_SafeStr_2462 != null)
            {
                return (_SafeStr_2462);
            };
            return (_SafeStr_1459[0]);
        }

        public function get tabContentHeight():int
        {
            return (_tabContentHeight);
        }

        public function get windowWidth():int
        {
            return (_windowWidth);
        }

        public function get tabContentWidth():int
        {
            return (_windowWidth - 2);
        }

        public function set tabContentHeight(_arg_1:int):void
        {
            _tabContentHeight = _arg_1;
        }

        public function set windowWidth(_arg_1:int):void
        {
            _windowWidth = _arg_1;
        }


    }
}

