package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Point;
    import flash.display.BitmapData;

    public class Twinkle implements AnimationObject, IDisposable 
    {

        private static const FRAME_DURATION_IN_MSECS:int = 100;
        private static const FRAME_SEQUENCE:Array = [1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1];
        private static const FRAME_NOT_STARTED:int = -1;
        private static const FRAME_FINISHED:int = -2;
        private static const _SafeStr_3153:Point = new Point(44, 44);

        private var _SafeStr_601:TwinkleImages;
        private var _SafeStr_3154:int;
        private var _position:Point;

        public function Twinkle(_arg_1:TwinkleImages, _arg_2:int)
        {
            _SafeStr_601 = _arg_1;
            _SafeStr_3154 = _arg_2;
        }

        public function dispose():void
        {
            _SafeStr_601 = null;
            _position = null;
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_601 == null);
        }

        public function onAnimationStart():void
        {
            _position = new Point(Math.round((Math.random() * _SafeStr_3153.x)), Math.round((Math.random() * _SafeStr_3153.y)));
        }

        public function getPosition(_arg_1:int):Point
        {
            return (_position);
        }

        public function isFinished(_arg_1:int):Boolean
        {
            return (getFrame(_arg_1) == -2);
        }

        public function getBitmap(_arg_1:int):BitmapData
        {
            var _local_3:int = getFrame(_arg_1);
            return (_SafeStr_601.getImage(FRAME_SEQUENCE[_local_3]));
        }

        private function getFrame(_arg_1:int):int
        {
            var _local_2:int = (_arg_1 - _SafeStr_3154);
            if (_local_2 < 0)
            {
                return (-1);
            };
            var _local_3:int = int(Math.floor((_local_2 / 100)));
            if (_local_3 >= FRAME_SEQUENCE.length)
            {
                return (-2);
            };
            return (_local_3);
        }


    }
}

