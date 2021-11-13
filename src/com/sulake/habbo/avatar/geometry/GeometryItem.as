package com.sulake.habbo.avatar.geometry
{
    public class GeometryItem extends Node3D 
    {

        private var _id:String;
        private var _radius:Number;
        private var _normal:Vector3D;
        private var _isDoubleSided:Boolean = false;
        private var _isDynamic:Boolean = false;

        public function GeometryItem(_arg_1:XML, _arg_2:Boolean=false)
        {
            super(parseFloat(_arg_1.@x), parseFloat(_arg_1.@y), parseFloat(_arg_1.@z));
            _id = String(_arg_1.@id);
            _radius = parseFloat(_arg_1.@radius);
            _normal = new Vector3D(parseFloat(_arg_1.@nx), parseFloat(_arg_1.@ny), parseFloat(_arg_1.@nz));
            _isDoubleSided = (parseInt(_arg_1.@double) as Boolean);
            _isDynamic = _arg_2;
        }

        public function getDistance(_arg_1:Vector3D):Number
        {
            var _local_3:Number = Math.abs(((_arg_1.z - this.transformedLocation.z) - _radius));
            var _local_2:Number = Math.abs(((_arg_1.z - this.transformedLocation.z) + _radius));
            return (Math.min(_local_3, _local_2));
        }

        public function get id():String
        {
            return (_id);
        }

        public function get normal():Vector3D
        {
            return (_normal);
        }

        public function get isDoubleSided():Boolean
        {
            return (_isDoubleSided);
        }

        public function toString():String
        {
            return ((((_id + ": ") + this.location) + " - ") + this.transformedLocation);
        }

        public function get isDynamic():Boolean
        {
            return (_isDynamic);
        }


    }
}