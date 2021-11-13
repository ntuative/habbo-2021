package com.sulake.habbo.room.object
{
    public class RoomFloorHole 
    {

        private var _x:int;
        private var _y:int;
        private var _width:int;
        private var _height:int;

        public function RoomFloorHole(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int)
        {
            _x = _arg_1;
            _y = _arg_2;
            _width = _arg_3;
            _height = _arg_4;
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