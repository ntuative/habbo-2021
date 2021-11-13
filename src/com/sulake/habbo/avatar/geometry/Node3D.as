package com.sulake.habbo.avatar.geometry
{
    public class Node3D 
    {

        private var _location:Vector3D;
        private var _transformedLocation:Vector3D = new Vector3D();
        private var _needsTransformation:Boolean = false;

        public function Node3D(_arg_1:Number, _arg_2:Number, _arg_3:Number)
        {
            _location = new Vector3D(_arg_1, _arg_2, _arg_3);
            if ((((!(_arg_1 == 0)) || (!(_arg_2 == 0))) || (!(_arg_3 == 0))))
            {
                _needsTransformation = true;
            };
        }

        public function get location():Vector3D
        {
            return (_location);
        }

        public function get transformedLocation():Vector3D
        {
            return (_transformedLocation);
        }

        public function applyTransform(_arg_1:Matrix4x4):void
        {
            if (_needsTransformation)
            {
                _transformedLocation = _arg_1.vectorMultiplication(_location);
            };
        }


    }
}