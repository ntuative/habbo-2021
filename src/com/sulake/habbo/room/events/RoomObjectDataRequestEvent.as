package com.sulake.habbo.room.events
{
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.room.object.IRoomObject;

    public class RoomObjectDataRequestEvent extends RoomObjectEvent 
    {

        public static const CURRENT_USER_ID:String = "RODRE_CURRENT_USER_ID";
        public static const URL_PREFIX:String = "RODRE_URL_PREFIX";

        public function RoomObjectDataRequestEvent(_arg_1:String, _arg_2:IRoomObject, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }

    }
}