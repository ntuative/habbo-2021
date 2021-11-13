package com.sulake.habbo.friendlist
{
    import com.sulake.habbo.friendlist.domain.FriendRequest;

    public /*dynamic*/ interface IFriendRequestsView 
    {

        function refreshShading(_arg_1:FriendRequest, _arg_2:Boolean):void;
        function refreshRequestEntry(_arg_1:FriendRequest):void;
        function addRequest(_arg_1:FriendRequest):void;
        function removeRequest(_arg_1:FriendRequest):void;
        function acceptRequest(_arg_1:int):void;
        function acceptAllRequests():void;
        function declineRequest(_arg_1:int):void;
        function declineAllRequests():void;

    }
}