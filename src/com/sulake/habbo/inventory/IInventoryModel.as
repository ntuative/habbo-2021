package com.sulake.habbo.inventory
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;

    public /*dynamic*/ interface IInventoryModel extends IDisposable 
    {

        function getWindowContainer():IWindowContainer;
        function requestInitialization():void;
        function categorySwitch(_arg_1:String):void;
        function subCategorySwitch(_arg_1:String):void;
        function closingInventoryView():void;
        function updateView():void;
        function selectItemById(_arg_1:String):void;

    }
}