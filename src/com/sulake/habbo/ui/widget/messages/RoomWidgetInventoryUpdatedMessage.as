package com.sulake.habbo.ui.widget.messages
{
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;

    public class RoomWidgetInventoryUpdatedMessage extends RoomWidgetUpdateEvent 
    {

        public static const INVENTORY_UPDATED:String = "RWIUM_INVENTORY_UPDATED";

        public function RoomWidgetInventoryUpdatedMessage(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

    }
}