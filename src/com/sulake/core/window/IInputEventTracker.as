package com.sulake.core.window
{
    import com.sulake.core.window.events.WindowEvent;

    public /*dynamic*/ interface IInputEventTracker 
    {

        function eventReceived(_arg_1:WindowEvent, _arg_2:IWindow):void;

    }
}