package com.sulake.habbo.room.object.visualization.room
{
    public class RoomPlaneBitmapMask 
    {

        private var _type:String = null;
        private var _leftSideLoc:Number = 0;
        private var _rightSideLoc:Number = 0;

        public function RoomPlaneBitmapMask(_arg_1:String, _arg_2:Number, _arg_3:Number)
        {
            _type = _arg_1;
            _leftSideLoc = _arg_2;
            _rightSideLoc = _arg_3;
        }

        public function get type():String
        {
            return (_type);
        }

        public function get leftSideLoc():Number
        {
            return (_leftSideLoc);
        }

        public function get rightSideLoc():Number
        {
            return (_rightSideLoc);
        }


    }
}