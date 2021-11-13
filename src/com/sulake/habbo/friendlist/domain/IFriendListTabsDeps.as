package com.sulake.habbo.friendlist.domain
{
    import com.sulake.habbo.friendlist.HabboFriendList;

    public /*dynamic*/ interface IFriendListTabsDeps 
    {

        function getFriendList():HabboFriendList;
        function getWindowHeight():int;

    }
}