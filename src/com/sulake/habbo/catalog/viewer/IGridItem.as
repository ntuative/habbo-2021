package com.sulake.habbo.catalog.viewer
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;

    public /*dynamic*/ interface IGridItem extends IDisposable 
    {

        function get view():IWindowContainer;
        function set view(_arg_1:IWindowContainer):void;
        function set grid(_arg_1:IItemGrid):void;
        function setDraggable(_arg_1:Boolean):void;
        function activate():void;
        function deactivate():void;

    }
}