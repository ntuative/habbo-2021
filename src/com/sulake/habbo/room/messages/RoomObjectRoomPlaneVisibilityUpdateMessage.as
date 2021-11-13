package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class RoomObjectRoomPlaneVisibilityUpdateMessage extends RoomObjectUpdateMessage 
    {

        public static const _SafeStr_3172:String = "RORPVUM_WALL_VISIBILITY";
        public static const _SafeStr_3173:String = "RORPVUM_FLOOR_VISIBILITY";

        private var _type:String = "";
        private var _visible:Boolean = false;

        public function RoomObjectRoomPlaneVisibilityUpdateMessage(_arg_1:String, _arg_2:Boolean)
        {
            super(null, null);
            _type = _arg_1;
            _visible = _arg_2;
        }

        public function get type():String
        {
            return (_type);
        }

        public function get visible():Boolean
        {
            return (_visible);
        }


    }
}

