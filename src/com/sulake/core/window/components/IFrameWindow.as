package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.utils.IMargins;

    public /*dynamic*/ interface IFrameWindow extends IWindowContainer 
    {

        function get title():ILabelWindow;
        function get header():IHeaderWindow;
        function get content():IWindowContainer;
        function get margins():IMargins;
        function get scaler():IScalerWindow;
        function resizeToFitContent():void;
        function set helpButtonAction(_arg_1:Function):void;
        function get helpPage():String;
        function set helpPage(_arg_1:String):void;

    }
}