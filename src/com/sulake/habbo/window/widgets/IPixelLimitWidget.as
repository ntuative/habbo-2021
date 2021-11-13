package com.sulake.habbo.window.widgets
{
    import com.sulake.core.window.IWidget;
    import com.sulake.core.window.utils.IBitmapDataContainer;

    public /*dynamic*/ interface IPixelLimitWidget extends IWidget, IBitmapDataContainer 
    {

        function get limit():int;
        function set limit(_arg_1:int):void;

    }
}