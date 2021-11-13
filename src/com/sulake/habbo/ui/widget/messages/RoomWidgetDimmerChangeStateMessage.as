package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetDimmerChangeStateMessage extends RoomWidgetMessage 
    {

        public static const CHANGE_STATE:String = "RWCDSM_CHANGE_STATE";

        public function RoomWidgetDimmerChangeStateMessage()
        {
            super("RWCDSM_CHANGE_STATE");
        }

    }
}