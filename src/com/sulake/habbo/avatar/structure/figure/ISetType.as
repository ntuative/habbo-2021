package com.sulake.habbo.avatar.structure.figure
{
    import com.sulake.core.utils.Map;

    public /*dynamic*/ interface ISetType 
    {

        function getPartSet(_arg_1:int):IFigurePartSet;
        function isMandatory(_arg_1:String, _arg_2:int):Boolean;
        function optionalFromClubLevel(_arg_1:String):int;
        function get type():String;
        function get paletteID():int;
        function get partSets():Map;

    }
}