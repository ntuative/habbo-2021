package com.sulake.habbo.room.object.visualization.data
{
    import flash.utils.Dictionary;

    public class DirectionalOffsetData 
    {

        private var _offsetX:Dictionary = new Dictionary();
        private var _offsetY:Dictionary = new Dictionary();


        public function getOffsetX(_arg_1:int, _arg_2:int):int
        {
            if (_offsetX[_arg_1] == null)
            {
                return (_arg_2);
            };
            return (_offsetX[_arg_1]);
        }

        public function getOffsetY(_arg_1:int, _arg_2:int):int
        {
            if (_offsetY[_arg_1] == null)
            {
                return (_arg_2);
            };
            return (_offsetY[_arg_1]);
        }

        public function setOffset(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            _offsetX[_arg_1] = _arg_2;
            _offsetY[_arg_1] = _arg_3;
        }


    }
}