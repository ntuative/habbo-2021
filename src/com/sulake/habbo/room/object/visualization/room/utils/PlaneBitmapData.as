package com.sulake.habbo.room.object.visualization.room.utils
{
    import flash.display.BitmapData;

    public class PlaneBitmapData 
    {

        private var _bitmap:BitmapData = null;
        private var _timeStamp:int = 0;

        public function PlaneBitmapData(_arg_1:BitmapData, _arg_2:int)
        {
            _bitmap = _arg_1;
            _timeStamp = _arg_2;
        }

        public function get bitmap():BitmapData
        {
            return (_bitmap);
        }

        public function get timeStamp():int
        {
            return (_timeStamp);
        }

        public function dispose():void
        {
            _bitmap = null;
        }


    }
}