package com.sulake.core.runtime.events
{
    public /*dynamic*/ interface ILinkEventTracker 
    {

        function get linkPattern():String;
        function linkReceived(_arg_1:String):void;

    }
}