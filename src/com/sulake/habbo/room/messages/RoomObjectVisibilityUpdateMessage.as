package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class RoomObjectVisibilityUpdateMessage extends RoomObjectUpdateMessage 
    {

        public static const _SafeStr_3174:String = "ROVUM_ENABLED";
        public static const _SafeStr_3175:String = "ROVUM_DISABLED";

        private var _type:String;

        public function RoomObjectVisibilityUpdateMessage(_arg_1:String)
        {
            super(null, null);
            _type = _arg_1;
        }

        public function get type():String
        {
            return (_type);
        }


    }
}

