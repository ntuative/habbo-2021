package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class RoomObjectRoomUpdateMessage extends RoomObjectUpdateMessage 
    {

        public static const ROOM_WALL_UPDATE:String = "RORUM_ROOM_WALL_UPDATE";
        public static const ROOM_FLOOR_UPDATE:String = "RORUM_ROOM_FLOOR_UPDATE";
        public static const ROOM_LANDSCAPE_UPDATE:String = "RORUM_ROOM_LANDSCAPE_UPDATE";

        private var _type:String = "";
        private var _value:String = "";

        public function RoomObjectRoomUpdateMessage(_arg_1:String, _arg_2:String)
        {
            super(null, null);
            _type = _arg_1;
            _value = _arg_2;
        }

        public function get type():String
        {
            return (_type);
        }

        public function get value():String
        {
            return (_value);
        }


    }
}