package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindowContainer;

    public /*dynamic*/ interface IHeaderWindow extends IWindowContainer 
    {

        function get title():ILabelWindow;
        function get controls():IItemListWindow;

    }
}