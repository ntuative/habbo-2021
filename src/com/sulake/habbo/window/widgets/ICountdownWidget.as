package com.sulake.habbo.window.widgets
{
    import com.sulake.core.window.IWidget;

    public /*dynamic*/ interface ICountdownWidget extends IWidget 
    {

        function get colorStyle():int;
        function set colorStyle(_arg_1:int):void;
        function get running():Boolean;
        function set running(_arg_1:Boolean):void;
        function get digits():uint;
        function set digits(_arg_1:uint):void;
        function get seconds():int;
        function set seconds(_arg_1:int):void;

    }
}