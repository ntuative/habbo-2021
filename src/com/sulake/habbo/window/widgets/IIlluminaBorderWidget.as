package com.sulake.habbo.window.widgets
{
    import com.sulake.core.window.IWidget;

    public /*dynamic*/ interface IIlluminaBorderWidget extends IWidget 
    {

        function get borderStyle():String;
        function set borderStyle(_arg_1:String):void;
        function get contentChild():String;
        function set contentChild(_arg_1:String):void;
        function get contentPadding():uint;
        function set contentPadding(_arg_1:uint):void;
        function get sidePadding():uint;
        function set sidePadding(_arg_1:uint):void;
        function get childMargin():uint;
        function set childMargin(_arg_1:uint):void;
        function get topLeftChild():String;
        function set topLeftChild(_arg_1:String):void;
        function get topCenterChild():String;
        function set topCenterChild(_arg_1:String):void;
        function get topRightChild():String;
        function set topRightChild(_arg_1:String):void;
        function get bottomLeftChild():String;
        function set bottomLeftChild(_arg_1:String):void;
        function get bottomCenterChild():String;
        function set bottomCenterChild(_arg_1:String):void;
        function get bottomRightChild():String;
        function set bottomRightChild(_arg_1:String):void;
        function get landingViewMode():Boolean;
        function set landingViewMode(_arg_1:Boolean):void;

    }
}