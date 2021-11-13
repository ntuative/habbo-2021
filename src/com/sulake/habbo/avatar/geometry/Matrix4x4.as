package com.sulake.habbo.avatar.geometry
{
    public class Matrix4x4 
    {

        public static const _SafeStr_650:Matrix4x4 = new Matrix4x4(1, 0, 0, 0, 1, 0, 0, 0, 1);
        private static const TOLERANS:Number = 1E-18;

        private var _data:Array;

        public function Matrix4x4(_arg_1:Number=0, _arg_2:Number=0, _arg_3:Number=0, _arg_4:Number=0, _arg_5:Number=0, _arg_6:Number=0, _arg_7:Number=0, _arg_8:Number=0, _arg_9:Number=0)
        {
            _data = [_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9];
        }

        public static function getXRotationMatrix(_arg_1:Number):Matrix4x4
        {
            var _local_5:Number = ((_arg_1 * 3.14159265358979) / 180);
            var _local_3:Number = Math.cos(_local_5);
            var _local_4:Number = Math.sin(_local_5);
            return (new Matrix4x4(1, 0, 0, 0, _local_3, -(_local_4), 0, _local_4, _local_3));
        }

        public static function getYRotationMatrix(_arg_1:Number):Matrix4x4
        {
            var _local_5:Number = ((_arg_1 * 3.14159265358979) / 180);
            var _local_3:Number = Math.cos(_local_5);
            var _local_4:Number = Math.sin(_local_5);
            return (new Matrix4x4(_local_3, 0, _local_4, 0, 1, 0, -(_local_4), 0, _local_3));
        }

        public static function getZRotationMatrix(_arg_1:Number):Matrix4x4
        {
            var _local_5:Number = ((_arg_1 * 3.14159265358979) / 180);
            var _local_3:Number = Math.cos(_local_5);
            var _local_4:Number = Math.sin(_local_5);
            return (new Matrix4x4(_local_3, -(_local_4), 0, _local_4, _local_3, 0, 0, 0, 1));
        }


        public function identity():Matrix4x4
        {
            _data = [1, 0, 0, 0, 1, 0, 0, 0, 1];
            return (this);
        }

        public function vectorMultiplication(_arg_1:Vector3D):Vector3D
        {
            var _local_2:Number = (((_arg_1.x * _data[0]) + (_arg_1.y * _data[3])) + (_arg_1.z * _data[6]));
            var _local_3:Number = (((_arg_1.x * _data[1]) + (_arg_1.y * _data[4])) + (_arg_1.z * _data[7]));
            var _local_4:Number = (((_arg_1.x * _data[2]) + (_arg_1.y * _data[5])) + (_arg_1.z * _data[8]));
            return (new Vector3D(_local_2, _local_3, _local_4));
        }

        public function multiply(_arg_1:Matrix4x4):Matrix4x4
        {
            var _local_2:Number = (((_data[0] * _arg_1.data[0]) + (_data[1] * _arg_1.data[3])) + (_data[2] * _arg_1.data[6]));
            var _local_3:Number = (((_data[0] * _arg_1.data[1]) + (_data[1] * _arg_1.data[4])) + (_data[2] * _arg_1.data[7]));
            var _local_4:Number = (((_data[0] * _arg_1.data[2]) + (_data[1] * _arg_1.data[5])) + (_data[2] * _arg_1.data[8]));
            var _local_5:Number = (((_data[3] * _arg_1.data[0]) + (_data[4] * _arg_1.data[3])) + (_data[5] * _arg_1.data[6]));
            var _local_6:Number = (((_data[3] * _arg_1.data[1]) + (_data[4] * _arg_1.data[4])) + (_data[5] * _arg_1.data[7]));
            var _local_7:Number = (((_data[3] * _arg_1.data[2]) + (_data[4] * _arg_1.data[5])) + (_data[5] * _arg_1.data[8]));
            var _local_8:Number = (((_data[6] * _arg_1.data[0]) + (_data[7] * _arg_1.data[3])) + (_data[8] * _arg_1.data[6]));
            var _local_9:Number = (((_data[6] * _arg_1.data[1]) + (_data[7] * _arg_1.data[4])) + (_data[8] * _arg_1.data[7]));
            var _local_10:Number = (((_data[6] * _arg_1.data[2]) + (_data[7] * _arg_1.data[5])) + (_data[8] * _arg_1.data[8]));
            return (new Matrix4x4(_local_2, _local_3, _local_4, _local_5, _local_6, _local_7, _local_8, _local_9, _local_10));
        }

        public function scalarMultiply(_arg_1:Number):void
        {
            var _local_2:int;
            _local_2 = 0;
            while (_local_2 < _data.length)
            {
                _data[_local_2] = (_data[_local_2] * _arg_1);
                _local_2++;
            };
        }

        public function rotateX(_arg_1:Number):Matrix4x4
        {
            var _local_5:Number = ((_arg_1 * 3.14159265358979) / 180);
            var _local_2:Number = Math.cos(_local_5);
            var _local_4:Number = Math.sin(_local_5);
            var _local_3:Matrix4x4 = new Matrix4x4(1, 0, 0, 0, _local_2, -(_local_4), 0, _local_4, _local_2);
            return (_local_3.multiply(this));
        }

        public function rotateY(_arg_1:Number):Matrix4x4
        {
            var _local_5:Number = ((_arg_1 * 3.14159265358979) / 180);
            var _local_2:Number = Math.cos(_local_5);
            var _local_4:Number = Math.sin(_local_5);
            var _local_3:Matrix4x4 = new Matrix4x4(_local_2, 0, _local_4, 0, 1, 0, -(_local_4), 0, _local_2);
            return (_local_3.multiply(this));
        }

        public function rotateZ(_arg_1:Number):Matrix4x4
        {
            var _local_5:Number = ((_arg_1 * 3.14159265358979) / 180);
            var _local_2:Number = Math.cos(_local_5);
            var _local_4:Number = Math.sin(_local_5);
            var _local_3:Matrix4x4 = new Matrix4x4(_local_2, -(_local_4), 0, _local_4, _local_2, 0, 0, 0, 1);
            return (_local_3.multiply(this));
        }

        public function skew():void
        {
        }

        public function transpose():Matrix4x4
        {
            return (new Matrix4x4(_data[0], _data[3], _data[6], _data[1], _data[4], _data[7], _data[2], _data[5], _data[8]));
        }

        public function equals(_arg_1:Matrix4x4):Boolean
        {
            return (false);
        }

        public function get data():Array
        {
            return (_data);
        }


    }
}

