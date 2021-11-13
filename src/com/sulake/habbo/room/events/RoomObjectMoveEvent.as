package com.sulake.habbo.room.events
{
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.room.object.IRoomObject;

    public class RoomObjectMoveEvent extends RoomObjectEvent 
    {

        public static const _SafeStr_3166:String = "ROME_POSITION_CHANGED";
        public static const _SafeStr_3167:String = "ROME_OBJECT_REMOVED";

        public function RoomObjectMoveEvent(_arg_1:String, _arg_2:IRoomObject, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }

    }
}

