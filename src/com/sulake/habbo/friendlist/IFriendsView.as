package com.sulake.habbo.friendlist
{
    public /*dynamic*/ interface IFriendsView 
    {

        function refreshList():void;
        function setNewMessageArrived():void;
        function refreshed():void;

    }
}