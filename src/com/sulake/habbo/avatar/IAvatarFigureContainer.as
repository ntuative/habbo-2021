package com.sulake.habbo.avatar
{
    public /*dynamic*/ interface IAvatarFigureContainer 
    {

        function getPartTypeIds():Array;
        function hasPartType(_arg_1:String):Boolean;
        function getPartSetId(_arg_1:String):int;
        function getPartColorIds(_arg_1:String):Array;
        function updatePart(_arg_1:String, _arg_2:int, _arg_3:Array):void;
        function removePart(_arg_1:String):void;
        function getFigureString():String;

    }
}