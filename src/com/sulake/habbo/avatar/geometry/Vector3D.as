package com.sulake.habbo.avatar.geometry
{
    public class Vector3D 
    {

        private var _x:Number;
        private var _y:Number;
        private var _z:Number;

        public function Vector3D(_arg_1:Number=0, _arg_2:Number=0, _arg_3:Number=0)
        {
            _x = _arg_1;
            _y = _arg_2;
            _z = _arg_3;
        }

        public static function dot(_arg_1:Vector3D, _arg_2:Vector3D):Number
        {
            return (((_arg_1.x * _arg_2.x) + (_arg_1.y * _arg_2.y)) + (_arg_1.z * _arg_2.z));
        }

        public static function cross(_arg_1:Vector3D, _arg_2:Vector3D):Vector3D
        {
            var _local_3:Vector3D = new Vector3D();
            _local_3.x = ((_arg_1.y * _arg_2.z) - (_arg_1.z * _arg_2.y));
            _local_3.y = ((_arg_1.z * _arg_2.x) - (_arg_1.x * _arg_2.z));
            _local_3.z = ((_arg_1.x * _arg_2.y) - (_arg_1.y * _arg_2.x));
            return (_local_3);
        }

        public static function subtract(_arg_1:Vector3D, _arg_2:Vector3D):Vector3D
        {
            return (new Vector3D((_arg_1.x - _arg_2.x), (_arg_1.y - _arg_2.y), (_arg_1.z - _arg_2.z)));
        }


        public function dot(_arg_1:Vector3D):Number
        {
            return (((_x * _arg_1.x) + (_y * _arg_1.y)) + (_z * _arg_1.z));
        }

        public function cross(_arg_1:Vector3D):Vector3D
        {
            var _local_2:Vector3D = new Vector3D();
            _local_2.x = ((_y * _arg_1.z) - (_z * _arg_1.y));
            _local_2.y = ((_z * _arg_1.x) - (_x * _arg_1.z));
            _local_2.z = ((_x * _arg_1.y) - (_y * _arg_1.x));
            return (_local_2);
        }

        public function subtract(_arg_1:Vector3D):void
        {
            _x = (_x - _arg_1.x);
            _y = (_y - _arg_1.y);
            _z = (_z - _arg_1.z);
        }

        public function add(_arg_1:Vector3D):void
        {
            _x = (_x + _arg_1.x);
            _y = (_y + _arg_1.y);
            _z = (_z + _arg_1.z);
        }

        public function normalize():void
        {
            var _local_1:Number = (1 / this.length());
            _x = (_x * _local_1);
            _y = (_y * _local_1);
            _z = (_z * _local_1);
        }

        public function length():Number
        {
            return (Math.sqrt((((_x * _x) + (_y * _y)) + (_z * _z))));
        }

        public function toString():String
        {
            return (((((("Vector3D: (" + _x) + ",") + _y) + ",") + _z) + ")");
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

        public function set x(_arg_1:Number):void
        {
            _x = _arg_1;
        }

        public function set y(_arg_1:Number):void
        {
            _y = _arg_1;
        }

        public function set z(_arg_1:Number):void
        {
            _z = _arg_1;
        }


    }
}