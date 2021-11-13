package com.sulake.habbo.catalog.viewer
{
    public /*dynamic*/ interface IItemGrid 
    {

        function select(_arg_1:IGridItem, _arg_2:Boolean):void;
        function startDragAndDrop(_arg_1:IGridItem):Boolean;
        function dispose():void;

    }
}