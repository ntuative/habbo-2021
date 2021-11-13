package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class CatalogWidgetRoomChangedEvent extends Event 
    {

        public function CatalogWidgetRoomChangedEvent(_arg_1:Boolean=false, _arg_2:Boolean=false)
        {
            super("CWE_ROOM_CHANGED", _arg_1, _arg_2);
        }

    }
}