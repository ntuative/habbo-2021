package com.sulake.habbo.friendlist
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;

    public /*dynamic*/ interface ITabView 
    {

        function init(_arg_1:HabboFriendList):void;
        function fillFooter(_arg_1:IWindowContainer):void;
        function fillList(_arg_1:IItemListWindow):void;
        function getEntryCount():int;
        function tabClicked(_arg_1:int):void;

    }
}