package com.sulake.habbo.ui.widget
{
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;

    public /*dynamic*/ interface IRoomWidgetMessageListener 
    {

        function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent;

    }
}