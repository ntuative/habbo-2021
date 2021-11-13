package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.utils.IIterable;
    import com.sulake.core.window.IWindowContainer;

    public /*dynamic*/ interface ITabContextWindow extends IWindow, IIterable 
    {

        function get selector():ISelectorListWindow;
        function get container():IWindowContainer;
        function get numTabItems():uint;
        function addTabItem(_arg_1:ITabButtonWindow):ITabButtonWindow;
        function addTabItemAt(_arg_1:ITabButtonWindow, _arg_2:uint):ITabButtonWindow;
        function removeTabItem(_arg_1:ITabButtonWindow):void;
        function getTabItemAt(_arg_1:uint):ITabButtonWindow;
        function getTabItemByName(_arg_1:String):ITabButtonWindow;
        function getTabItemByID(_arg_1:uint):ITabButtonWindow;
        function getTabItemIndex(_arg_1:ITabButtonWindow):uint;

    }
}