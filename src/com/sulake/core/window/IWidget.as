package com.sulake.core.window
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.utils.IIterable;

    public /*dynamic*/ interface IWidget extends IDisposable, IIterable 
    {

        function get properties():Array;
        function set properties(_arg_1:Array):void;

    }
}