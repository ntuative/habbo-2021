package com.sulake.habbo.inventory
{
    public /*dynamic*/ interface IUnseenItemTracker 
    {

        function resetCategory(_arg_1:int):Boolean;
        function resetItems(_arg_1:int, _arg_2:Array):Boolean;
        function resetCategoryIfEmpty(_arg_1:int):Boolean;
        function isUnseen(_arg_1:int, _arg_2:int):Boolean;
        function removeUnseen(_arg_1:int, _arg_2:int):Boolean;
        function getIds(_arg_1:int):Array;
        function getCount(_arg_1:int):int;

    }
}