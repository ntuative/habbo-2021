package com.sulake.core.window.components
{
    public /*dynamic*/ interface IDragBarWindow extends IInteractiveWindow 
    {

        function get scrollbarOffsetX():Number;
        function get scrollbarOffsetY():Number;
        function set scrollbarOffsetX(_arg_1:Number):void;
        function set scrollbarOffsetY(_arg_1:Number):void;

    }
}