package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class RoomObjectRoomFloorHoleUpdateMessage extends RoomObjectUpdateMessage 
    {

        public static const ADD_HOLE:String = "RORPFHUM_ADD";
        public static const REMOVE_HOLE:String = "RORPFHUM_REMOVE";

        private var _type:String = "";
        private var _id:int;
        private var _x:int;
        private var _y:int;
        private var _width:int;
        private var _height:int;

        public function RoomObjectRoomFloorHoleUpdateMessage(_arg_1:String, _arg_2:int, _arg_3:int=0, _arg_4:int=0, _arg_5:int=0, _arg_6:int=0)
        {
            super(null, null);
            _type = _arg_1;
            _id = _arg_2;
            _x = _arg_3;
            _y = _arg_4;
            _width = _arg_5;
            _height = _arg_6;
        }

        public function get type():String
        {
            return (_type);
        }

        public function get id():int
        {
            return (_id);
        }

        public function get x():int
        {
            return (_x);
        }

        public function get y():int
        {
            return (_y);
        }

        public function get width():int
        {
            return (_width);
        }

        public function get height():int
        {
            return (_height);
        }


    }
}