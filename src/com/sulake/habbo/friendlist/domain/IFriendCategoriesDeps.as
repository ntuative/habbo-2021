package com.sulake.habbo.friendlist.domain
{
    import com.sulake.habbo.friendlist.IFriendsView;
    import com.sulake.habbo.messenger.IHabboMessenger;
    import com.sulake.habbo.notifications.IHabboNotifications;

    public /*dynamic*/ interface IFriendCategoriesDeps 
    {

        function get view():IFriendsView;
        function get messenger():IHabboMessenger;
        function get notifications():IHabboNotifications;

    }
}