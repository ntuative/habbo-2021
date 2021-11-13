package com.sulake.habbo.room.events
{
    public class RoomEngineObjectPlacedEvent extends RoomEngineObjectEvent 
    {

        private var _wallLocation:String = "";
        private var _x:Number = 0;
        private var _y:Number = 0;
        private var _z:Number = 0;
        private var _direction:int = 0;
        private var _placedInRoom:Boolean = false;
        private var _placedOnFloor:Boolean = false;
        private var _placedOnWall:Boolean = false;
        private var _instanceData:String = null;

        public function RoomEngineObjectPlacedEvent(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:String, _arg_6:Number, _arg_7:Number, _arg_8:Number, _arg_9:int, _arg_10:Boolean, _arg_11:Boolean, _arg_12:Boolean, _arg_13:String, _arg_14:Boolean=false, _arg_15:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_14, _arg_15);
            _wallLocation = _arg_5;
            _x = _arg_6;
            _y = _arg_7;
            _z = _arg_8;
            _direction = _arg_9;
            _placedInRoom = _arg_10;
            _placedOnFloor = _arg_11;
            _placedOnWall = _arg_12;
            _instanceData = _arg_13;
        }

        public function get wallLocation():String
        {
            return (_wallLocation);
        }

        public function get x():Number
        {
            return (_x);
        }

        public function get y():Number
        {
            return (_y);
        }

        public function get z():Number
        {
            return (_z);
        }

        public function get direction():int
        {
            return (_direction);
        }

        public function get placedInRoom():Boolean
        {
            return (_placedInRoom);
        }

        public function get placedOnFloor():Boolean
        {
            return (_placedOnFloor);
        }

        public function get placedOnWall():Boolean
        {
            return (_placedOnWall);
        }

        public function get instanceData():String
        {
            return (_instanceData);
        }


    }
}