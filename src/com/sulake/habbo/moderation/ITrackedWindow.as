package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;

    public /*dynamic*/ interface ITrackedWindow extends IDisposable 
    {

        function getType():int;
        function getId():String;
        function getFrame():IFrameWindow;
        function show():void;

    }
}