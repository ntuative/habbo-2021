package com.sulake.habbo.room.object
{
    public class RoomPlaneMaskData 
    {

        private var _leftSideLoc:Number = 0;
        private var _rightSideLoc:Number = 0;
        private var _leftSideLength:Number = 0;
        private var _rightSideLength:Number = 0;

        public function RoomPlaneMaskData(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number)
        {
            _leftSideLoc = _arg_1;
            _rightSideLoc = _arg_2;
            _leftSideLength = _arg_3;
            _rightSideLength = _arg_4;
        }

        public function get leftSideLoc():Number
        {
            return (_leftSideLoc);
        }

        public function get rightSideLoc():Number
        {
            return (_rightSideLoc);
        }

        public function get leftSideLength():Number
        {
            return (_leftSideLength);
        }

        public function get rightSideLength():Number
        {
            return (_rightSideLength);
        }


    }
}