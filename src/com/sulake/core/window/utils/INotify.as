package com.sulake.core.window.utils
{
    import com.sulake.core.runtime.IDisposable;

    public /*dynamic*/ interface INotify extends IDisposable 
    {

        function set title(_arg_1:String):void;
        function get title():String;
        function set summary(_arg_1:String):void;
        function get summary():String;
        function set callback(_arg_1:Function):void;
        function get callback():Function;

    }
}