package com.sulake.habbo.window.widgets
{
    import com.sulake.core.window.IWidget;

    public /*dynamic*/ interface IFurnitureImageWidget extends IWidget 
    {

        function get furnitureType():String;
        function set furnitureType(_arg_1:String):void;
        function get scale():int;
        function set scale(_arg_1:int):void;
        function get direction():int;
        function set direction(_arg_1:int):void;

    }
}