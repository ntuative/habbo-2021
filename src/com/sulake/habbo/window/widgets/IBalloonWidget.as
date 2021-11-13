package com.sulake.habbo.window.widgets
{
    import com.sulake.core.window.IWidget;

    public /*dynamic*/ interface IBalloonWidget extends IWidget 
    {

        function get arrowPivot():String;
        function set arrowPivot(_arg_1:String):void;
        function get arrowDisplacement():int;
        function set arrowDisplacement(_arg_1:int):void;

    }
}