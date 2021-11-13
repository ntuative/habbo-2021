package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class RoomObjectRoomColorUpdateMessage extends RoomObjectUpdateMessage 
    {

        public static const BACKGROUND_COLOR:String = "RORCUM_BACKGROUND_COLOR";

        private var _type:String = "";
        private var _color:uint = 0;
        private var _light:int = 0;
        private var _bgOnly:Boolean = true;

        public function RoomObjectRoomColorUpdateMessage(_arg_1:String, _arg_2:uint, _arg_3:int, _arg_4:Boolean)
        {
            super(null, null);
            _type = _arg_1;
            _color = _arg_2;
            _light = _arg_3;
            _bgOnly = _arg_4;
        }

        public function get type():String
        {
            return (_type);
        }

        public function get color():uint
        {
            return (_color);
        }

        public function get light():uint
        {
            return (_light);
        }

        public function get bgOnly():Boolean
        {
            return (_bgOnly);
        }


    }
}