package com.sulake.habbo.friendlist
{
    public /*dynamic*/ interface ISearchView 
    {

        function refreshList():void;
        function setSearchStr(_arg_1:String):void;
        function focus():void;

    }
}