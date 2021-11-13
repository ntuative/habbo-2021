package com.sulake.habbo.friendlist.domain
{
    import com.sulake.habbo.friendlist.IFriendRequestsView;

    public /*dynamic*/ interface IFriendRequestsDeps 
    {

        function get view():IFriendRequestsView;

    }
}