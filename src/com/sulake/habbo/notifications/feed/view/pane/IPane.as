package com.sulake.habbo.notifications.feed.view.pane
{
    import com.sulake.core.runtime.IDisposable;

    public /*dynamic*/ interface IPane extends IDisposable 
    {

        function get paneLevel():int;
        function set isVisible(_arg_1:Boolean):void;
        function get isVisible():Boolean;

    }
}