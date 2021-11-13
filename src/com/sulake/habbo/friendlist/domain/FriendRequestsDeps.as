package com.sulake.habbo.friendlist.domain
{
    import com.sulake.habbo.friendlist.HabboFriendList;
    import com.sulake.habbo.friendlist.IFriendRequestsView;

    public class FriendRequestsDeps implements IFriendRequestsDeps 
    {

        private var _friendList:HabboFriendList;

        public function FriendRequestsDeps(_arg_1:HabboFriendList)
        {
            _friendList = _arg_1;
        }

        public function get view():IFriendRequestsView
        {
            return (_friendList.tabs.findTab(2).tabView as IFriendRequestsView);
        }


    }
}