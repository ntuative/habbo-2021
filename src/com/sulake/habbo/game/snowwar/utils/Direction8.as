package com.sulake.habbo.game.snowwar.utils
{
    public class Direction8 
    {

        public static var ALL_DIRECTIONS:Array = [];
        public static const N:Direction8 = new Direction8(0, "N", 0, -1);
        public static const NE:Direction8 = new Direction8(1, "NE", 1, -1);
        public static const E:Direction8 = new Direction8(2, "E", 1, 0);
        public static const SE:Direction8 = new Direction8(3, "SE", 1, 1);
        public static const S:Direction8 = new Direction8(4, "S", 0, 1);
        public static const SW:Direction8 = new Direction8(5, "SW", -1, 1);
        public static const W:Direction8 = new Direction8(6, "W", -1, 0);
        public static const NW:Direction8 = new Direction8(7, "NW", -1, -1);
        public static const DEFAULT_ITEM_DIRECTION_8:Direction8 = S;
        public static const DEFAULT_AVATAR_DIRECTION_8:Direction8 = SW;
        private static var componentToAngleArray:Array = [0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 8, 9, 9, 9, 9, 10, 10, 10, 10, 10, 11, 11, 11, 11, 12, 12, 12, 12, 12, 13, 13, 13, 13, 13, 14, 14, 14, 14, 15, 15, 15, 15, 15, 16, 16, 16, 16, 16, 17, 17, 17, 17, 17, 18, 18, 18, 18, 18, 19, 19, 19, 19, 19, 20, 20, 20, 20, 20, 21, 21, 21, 21, 21, 22, 22, 22, 22, 22, 23, 23, 23, 23, 23, 24, 24, 24, 24, 24, 24, 25, 25, 25, 25, 25, 26, 26, 26, 26, 26, 26, 27, 27, 27, 27, 27, 28, 28, 28, 28, 28, 28, 29, 29, 29, 29, 29, 29, 30, 30, 30, 30, 30, 30, 31, 31, 31, 31, 31, 31, 32, 32, 32, 32, 32, 32, 33, 33, 33, 33, 33, 33, 34, 34, 34, 34, 34, 34, 34, 35, 35, 35, 35, 35, 35, 36, 36, 36, 36, 36, 36, 36, 37, 37, 37, 37, 37, 37, 37, 38, 38, 38, 38, 38, 38, 38, 39, 39, 39, 39, 39, 39, 39, 39, 40, 40, 40, 40, 40, 40, 40, 41, 41, 41, 41, 41, 41, 41, 41, 42, 42, 42, 42, 42, 42, 42, 42, 43, 43, 43, 43, 43, 43, 43, 43, 44, 44, 44, 44, 44, 44, 44, 44, 44, 45, 45, 45, 45, 45];

        private var _direction:int;
        private var _SafeStr_2570:int;
        private var _SafeStr_2571:int;
        private var _SafeStr_2572:String;

        public function Direction8(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:int)
        {
            this._direction = _arg_1;
            this._SafeStr_2572 = _arg_2;
            this._SafeStr_2570 = _arg_3;
            this._SafeStr_2571 = _arg_4;
            ALL_DIRECTIONS[_arg_1] = this;
        }

        public static function getDirection8(_arg_1:int):Direction8
        {
            if (((_arg_1 < 0) || (_arg_1 > 7)))
            {
                return (null);
            };
            return (ALL_DIRECTIONS[_arg_1]);
        }

        public static function validateDirection8Value(_arg_1:int):int
        {
            return (_arg_1 & 0x07);
        }

        public static function compatibleCalculateDirectionTo(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):Direction8
        {
            var _local_5:int = (_arg_3 - _arg_1);
            var _local_6:int = (_arg_4 - _arg_2);
            if (((_local_5 == 0) && (_local_6 < 0)))
            {
                return (N);
            };
            if (((_local_5 == 0) && (_local_6 > 0)))
            {
                return (S);
            };
            if (((_local_5 > 0) && (_local_6 < 0)))
            {
                return (NE);
            };
            if (((_local_5 > 0) && (_local_6 == 0)))
            {
                return (E);
            };
            if (((_local_5 > 0) && (_local_6 > 0)))
            {
                return (SE);
            };
            if (((_local_5 < 0) && (_local_6 < 0)))
            {
                return (NW);
            };
            if (((_local_5 < 0) && (_local_6 == 0)))
            {
                return (W);
            };
            if (((_local_5 < 0) && (_local_6 > 0)))
            {
                return (SW);
            };
            return (null);
        }

        private static function validateDirection360Value(_arg_1:int):int
        {
            if (_arg_1 > 359)
            {
                _arg_1 = (_arg_1 % 360);
            }
            else
            {
                if (_arg_1 < 0)
                {
                    _arg_1 = (360 + (_arg_1 % 360));
                };
            };
            return (_arg_1);
        }

        private static function getAngleFromComponents(_arg_1:int, _arg_2:int):int
        {
            var _local_3:int;
            if (Math.abs(_arg_1) <= Math.abs(_arg_2))
            {
                if (_arg_2 == 0)
                {
                    _arg_2 = 1;
                };
                _arg_1 = (_arg_1 * 0x0100);
                _local_3 = int(_SafeStr_206.javaDiv((_arg_1 / _arg_2)));
                if (_local_3 < 0)
                {
                    _local_3 = -(_local_3);
                };
                if (_local_3 > 0xFF)
                {
                    _local_3 = 0xFF;
                };
                if (_arg_2 < 0)
                {
                    if (_arg_1 > 0)
                    {
                        return (componentToAngleArray[_local_3]);
                    };
                    return (360 - componentToAngleArray[_local_3]);
                };
                if (_arg_1 > 0)
                {
                    return (180 - componentToAngleArray[_local_3]);
                };
                return (180 + componentToAngleArray[_local_3]);
            };
            if (_arg_1 == 0)
            {
                _arg_1 = 1;
            };
            _arg_2 = (_arg_2 * 0x0100);
            _local_3 = int(_SafeStr_206.javaDiv((_arg_2 / _arg_1)));
            if (_local_3 < 0)
            {
                _local_3 = -(_local_3);
            };
            if (_local_3 > 0xFF)
            {
                _local_3 = 0xFF;
            };
            if (_arg_2 < 0)
            {
                if (_arg_1 > 0)
                {
                    return (90 - componentToAngleArray[_local_3]);
                };
                return (270 + componentToAngleArray[_local_3]);
            };
            if (_arg_1 > 0)
            {
                return (90 + componentToAngleArray[_local_3]);
            };
            return (270 - componentToAngleArray[_local_3]);
        }


        public function intValue():int
        {
            return (_direction);
        }

        public function oppositeDirection():Direction8
        {
            return (rotateDirection(4));
        }

        public function rotateDirection45Degrees(_arg_1:Boolean):Direction8
        {
            return (rotateDirection(((_arg_1) ? 1 : -1)));
        }

        public function rotateDirection90Degrees(_arg_1:Boolean):Direction8
        {
            return (rotateDirection(((_arg_1) ? 2 : -2)));
        }

        public function isDiagonal():Boolean
        {
            return ((_direction % 2) == 0);
        }

        public function hashCode():int
        {
            return (_direction);
        }

        public function rotateDirection(_arg_1:int):Direction8
        {
            var _local_2:int = (_direction + _arg_1);
            _local_2 = validateDirection8Value(_local_2);
            return (ALL_DIRECTIONS[_local_2]);
        }

        public function toString():String
        {
            return (((_SafeStr_2572 + "(") + _direction.toString()) + ")");
        }

        public function directionString():String
        {
            return (_SafeStr_2572);
        }

        public function getUnitVectorXcomponent():int
        {
            return (_SafeStr_2570);
        }

        public function getUnitVectorYcomponent():int
        {
            return (_SafeStr_2571);
        }


    }
}

