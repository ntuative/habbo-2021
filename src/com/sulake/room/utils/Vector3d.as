package com.sulake.room.utils
{
    public class Vector3d implements IVector3d 
    {

        private var _x:Number;
        private var _y:Number;
        private var _z:Number;
        private var _length:Number = NaN;

        public function Vector3d(_arg_1:Number=0, _arg_2:Number=0, _arg_3:Number=0)
        {
            _x = _arg_1;
            _y = _arg_2;
            _z = _arg_3;
        }

        public static function sum(_arg_1:IVector3d, _arg_2:IVector3d):Vector3d
        {
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return (null);
            };
            return (new Vector3d((_arg_1.x + _arg_2.x), (_arg_1.y + _arg_2.y), (_arg_1.z + _arg_2.z)));
        }

        public static function dif(_arg_1:IVector3d, _arg_2:IVector3d):Vector3d
        {
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return (null);
            };
            return (new Vector3d((_arg_1.x - _arg_2.x), (_arg_1.y - _arg_2.y), (_arg_1.z - _arg_2.z)));
        }

        public static function product(_arg_1:IVector3d, _arg_2:Number):Vector3d
        {
            if (_arg_1 == null)
            {
                return (null);
            };
            return (new Vector3d((_arg_1.x * _arg_2), (_arg_1.y * _arg_2), (_arg_1.z * _arg_2)));
        }

        public static function dotProduct(_arg_1:IVector3d, _arg_2:IVector3d):Number
        {
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return (0);
            };
            return (((_arg_1.x * _arg_2.x) + (_arg_1.y * _arg_2.y)) + (_arg_1.z * _arg_2.z));
        }

        public static function crossProduct(_arg_1:IVector3d, _arg_2:IVector3d):Vector3d
        {
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return (null);
            };
            return (new Vector3d(((_arg_1.y * _arg_2.z) - (_arg_1.z * _arg_2.y)), ((_arg_1.z * _arg_2.x) - (_arg_1.x * _arg_2.z)), ((_arg_1.x * _arg_2.y) - (_arg_1.y * _arg_2.x))));
        }

        public static function scalarProjection(_arg_1:IVector3d, _arg_2:IVector3d):Number
        {
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return (-1);
            };
            var _local_3:Number = _arg_2.length;
            if (_local_3 > 0)
            {
                return ((((_arg_1.x * _arg_2.x) + (_arg_1.y * _arg_2.y)) + (_arg_1.z * _arg_2.z)) / _local_3);
            };
            return (-1);
        }

        public static function cosAngle(_arg_1:IVector3d, _arg_2:IVector3d):Number
        {
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return (0);
            };
            var _local_3:Number = (_arg_1.length * _arg_2.length);
            if (_local_3 == 0)
            {
                return (0);
            };
            return (Vector3d.dotProduct(_arg_1, _arg_2) / _local_3);
        }

        public static function isEqual(_arg_1:IVector3d, _arg_2:IVector3d):Boolean
        {
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return (false);
            };
            if ((((_arg_1.x == _arg_2.x) && (_arg_1.y == _arg_2.y)) && (_arg_1.z == _arg_2.z)))
            {
                return (true);
            };
            return (false);
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

        public function get length():Number
        {
            if (isNaN(_length))
            {
                _length = Math.sqrt((((_x * _x) + (_y * _y)) + (_z * _z)));
            };
            return (_length);
        }

        public function set x(_arg_1:Number):void
        {
            _x = _arg_1;
            _length = NaN;
        }

        public function set y(_arg_1:Number):void
        {
            _y = _arg_1;
            _length = NaN;
        }

        public function set z(_arg_1:Number):void
        {
            _z = _arg_1;
            _length = NaN;
        }

        public function negate():void
        {
            _x = -(_x);
            _y = -(_y);
            _z = -(_z);
        }

        public function add(_arg_1:IVector3d):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _x = (_x + _arg_1.x);
            _y = (_y + _arg_1.y);
            _z = (_z + _arg_1.z);
            _length = NaN;
        }

        public function sub(_arg_1:IVector3d):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _x = (_x - _arg_1.x);
            _y = (_y - _arg_1.y);
            _z = (_z - _arg_1.z);
            _length = NaN;
        }

        public function mul(_arg_1:Number):void
        {
            _x = (_x * _arg_1);
            _y = (_y * _arg_1);
            _z = (_z * _arg_1);
            _length = NaN;
        }

        public function div(_arg_1:Number):void
        {
            if (_arg_1 != 0)
            {
                _x = (_x / _arg_1);
                _y = (_y / _arg_1);
                _z = (_z / _arg_1);
                _length = NaN;
            };
        }

        public function assign(_arg_1:IVector3d):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _x = _arg_1.x;
            _y = _arg_1.y;
            _z = _arg_1.z;
            _length = NaN;
        }

        public function toString():String
        {
            return (("(" + [_x, _y, _z].join(",")) + ")");
        }


    }
}