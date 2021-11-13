package com.sulake.core.window.services
{
    import com.sulake.core.window.IWindow;

    public /*dynamic*/ interface IMouseListenerService 
    {

        function get eventTypes():Array;
        function get areaLimit():uint;
        function set areaLimit(_arg_1:uint):void;
        function dispose():void;
        function begin(_arg_1:IWindow, _arg_2:uint=0):IWindow;
        function end(_arg_1:IWindow):IWindow;

    }
}