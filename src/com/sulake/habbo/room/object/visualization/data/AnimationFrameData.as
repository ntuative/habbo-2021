package com.sulake.habbo.room.object.visualization.data
{
    public class AnimationFrameData 
    {

        private var _id:int = 0;
        private var _y:int = 0;
        private var _SafeStr_955:int = 0;
        private var _randomX:int = 0;
        private var _randomY:int = 0;
        private var _repeats:int = 1;

        public function AnimationFrameData(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int)
        {
            _id = _arg_1;
            _y = _arg_2;
            _SafeStr_955 = _arg_3;
            _randomX = _arg_4;
            _randomY = _arg_5;
            _repeats = _arg_6;
        }

        public function get id():int
        {
            return (_id);
        }

        public function hasDirectionalOffsets():Boolean
        {
            return (false);
        }

        public function getX(_arg_1:int):int
        {
            return (_y);
        }

        public function getY(_arg_1:int):int
        {
            return (_SafeStr_955);
        }

        public function get x():int
        {
            return (_y);
        }

        public function get y():int
        {
            return (_y);
        }

        public function get randomX():int
        {
            return (_randomX);
        }

        public function get randomY():int
        {
            return (_randomY);
        }

        public function get repeats():int
        {
            return (_repeats);
        }


    }
}

