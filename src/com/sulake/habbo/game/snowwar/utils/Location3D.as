package com.sulake.habbo.game.snowwar.utils
{
    import com.sulake.core.runtime.IDisposable;

    public class Location3D implements IDisposable 
    {

        private var _x:int;
        private var _y:int;
        private var _z:int;
        private var _disposed:Boolean = false;

        public function Location3D(_arg_1:int, _arg_2:int, _arg_3:int)
        {
            _x = _arg_1;
            _y = _arg_2;
            _z = _arg_3;
        }

        public static function isInDistanceStatic(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int):Boolean
        {
            var _local_7:int = (_arg_3 - _arg_1);
            if (_local_7 < 0)
            {
                _local_7 = -(_local_7);
            };
            var _local_6:int = (_arg_4 - _arg_2);
            if (_local_6 < 0)
            {
                _local_6 = -(_local_6);
            };
            if (((_local_6 > _arg_5) || (_local_7 > _arg_5)))
            {
                return (false);
            };
            if (((_local_7 * _local_7) + (_local_6 * _local_6)) < (_arg_5 * _arg_5))
            {
                return (true);
            };
            return (false);
        }


        public function dispose():void
        {
            _x = 0;
            _y = 0;
            _z = 0;
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get x():int
        {
            return (_x);
        }

        public function get y():int
        {
            return (_y);
        }

        public function get z():int
        {
            return (_z);
        }

        public function changeLocation(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            _x = _arg_1;
            _y = _arg_2;
            _z = _arg_3;
        }

        public function change2DLocation(_arg_1:int, _arg_2:int):void
        {
            _x = _arg_1;
            _y = _arg_2;
        }

        public function changeLocationToLocation(_arg_1:Location3D):void
        {
            _x = _arg_1._x;
            _y = _arg_1._y;
            _z = _arg_1._z;
        }

        public function distanceTo(_arg_1:Location3D):int
        {
            var _local_2:int = (_arg_1._x - _x);
            var _local_3:int = (_arg_1._y - _y);
            var _local_4:int = (_arg_1._z - _z);
            var _local_5:int = ((Math.abs(_local_2) + Math.abs(_local_3)) + Math.abs(_local_4));
            return (_local_5);
        }

        public function directionTo(_arg_1:Location3D):Direction8
        {
            if (((_arg_1._x == _x) && (_arg_1._y == _y)))
            {
                return (null);
            };
            var _local_3:int = (_arg_1._x - _x);
            var _local_2:int = (_arg_1._y - _y);
            var _local_4:int = Direction360.getAngleFromComponents(_local_3, _local_2);
            return (Direction360.direction360ValueToDirection8(_local_4));
        }

        public function equals(_arg_1:Object):Boolean
        {
            if (this == _arg_1)
            {
                return (true);
            };
            if (!(_arg_1 is Location3D))
            {
                return (false);
            };
            var _local_2:Location3D = Location3D(_arg_1);
            if (_x != _local_2._x)
            {
                return (false);
            };
            if (_y != _local_2._y)
            {
                return (false);
            };
            if (_z != _local_2._z)
            {
                return (false);
            };
            return (true);
        }

        public function hashCode():int
        {
            var _local_1:int;
            _local_1 = _x;
            _local_1 = ((29 * _local_1) + _y);
            return ((29 * _local_1) + _z);
        }

        public function toString():String
        {
            return ((((("_x:" + _x) + "yy:") + _y) + "_zz:") + _z);
        }

        public function isInDistance(_arg_1:Location3D, _arg_2:int):Boolean
        {
            return (isInDistanceStatic(_x, _y, _arg_1._x, _arg_1._y, _arg_2));
        }


    }
}