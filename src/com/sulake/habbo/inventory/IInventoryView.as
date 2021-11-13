package com.sulake.habbo.inventory
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;

    public /*dynamic*/ interface IInventoryView extends IDisposable 
    {

        function getWindowContainer():IWindowContainer;

    }
}