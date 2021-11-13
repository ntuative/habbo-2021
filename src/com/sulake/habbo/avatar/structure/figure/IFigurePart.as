package com.sulake.habbo.avatar.structure.figure
{
    public /*dynamic*/ interface IFigurePart 
    {

        function get id():int;
        function get type():String;
        function get breed():int;
        function get colorLayerIndex():int;
        function get index():int;
        function get paletteMap():int;

    }
}