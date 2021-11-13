package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class RoomObjectRoomPlanePropertyUpdateMessage extends RoomObjectUpdateMessage 
    {

        public static const WALL_THICKNESS:String = "RORPPUM_WALL_THICKNESS";
        public static const FLOOR_THICKNESS:String = "RORPVUM_FLOOR_THICKNESS";

        private var _type:String = "";
        private var _value:Number = 0;

        public function RoomObjectRoomPlanePropertyUpdateMessage(_arg_1:String, _arg_2:Number)
        {
            super(null, null);
            _type = _arg_1;
            _value = _arg_2;
        }

        public function get type():String
        {
            return (_type);
        }

        public function get value():Number
        {
            return (_value);
        }


    }
}