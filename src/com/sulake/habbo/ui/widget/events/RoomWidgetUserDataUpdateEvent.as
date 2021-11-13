package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetUserDataUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const USER_DATA_UPDATED:String = "rwudue_user_data_updated";

        public function RoomWidgetUserDataUpdateEvent(_arg_1:Boolean=false, _arg_2:Boolean=false)
        {
            super("rwudue_user_data_updated", _arg_1, _arg_2);
        }

    }
}