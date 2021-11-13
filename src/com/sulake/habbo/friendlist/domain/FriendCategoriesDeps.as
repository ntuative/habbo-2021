package com.sulake.habbo.friendlist.domain
{
    import com.sulake.habbo.friendlist.HabboFriendList;
    import com.sulake.habbo.friendlist.IFriendsView;
    import com.sulake.habbo.messenger.IHabboMessenger;
    import com.sulake.habbo.notifications.IHabboNotifications;

    public class FriendCategoriesDeps implements IFriendCategoriesDeps 
    {

        private var _friendList:HabboFriendList;

        public function FriendCategoriesDeps(_arg_1:HabboFriendList)
        {
            this._friendList = _arg_1;
        }

        public function get view():IFriendsView
        {
            return (_friendList.tabs.findTab(1).tabView as IFriendsView);
        }

        public function get messenger():IHabboMessenger
        {
            return (this._friendList.messenger);
        }

        public function get notifications():IHabboNotifications
        {
            return (this._friendList.notifications);
        }


    }
}