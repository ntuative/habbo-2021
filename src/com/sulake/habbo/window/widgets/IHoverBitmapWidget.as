package com.sulake.habbo.window.widgets
{
    import com.sulake.core.window.IWidget;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;

    public /*dynamic*/ interface IHoverBitmapWidget extends IWidget 
    {

        function get bitmapWrapper():IStaticBitmapWrapperWindow;
        function get normalAsset():String;
        function set normalAsset(_arg_1:String):void;
        function get hoverAsset():String;
        function set hoverAsset(_arg_1:String):void;

    }
}