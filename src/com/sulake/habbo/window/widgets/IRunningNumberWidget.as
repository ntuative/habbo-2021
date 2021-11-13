package com.sulake.habbo.window.widgets
{
    import com.sulake.core.window.IWidget;

    public /*dynamic*/ interface IRunningNumberWidget extends IWidget 
    {

        function get number():int;
        function set number(_arg_1:int):void;
        function set initialNumber(_arg_1:int):void;
        function get digits():uint;
        function set digits(_arg_1:uint):void;
        function get colorStyle():int;
        function set colorStyle(_arg_1:int):void;
        function get updateFrequency():int;
        function set updateFrequency(_arg_1:int):void;

    }
}