package com.sulake.habbo.avatar.geometry
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.IAvatarImage;

    public class GeometryBodyPart extends Node3D 
    {

        private var _id:String;
        private var _SafeStr_1332:Dictionary;
        private var _radius:Number;
        private var _SafeStr_1333:Dictionary;

        public function GeometryBodyPart(_arg_1:XML)
        {
            super(parseFloat(_arg_1.@x), parseFloat(_arg_1.@y), parseFloat(_arg_1.@z));
            var _local_2:GeometryItem = null;
            _radius = parseFloat(_arg_1.@radius);
            _id = String(_arg_1.@id);
            _SafeStr_1332 = new Dictionary();
            _SafeStr_1333 = new Dictionary(true);
            for each (var _local_3:XML in _arg_1..item)
            {
                _local_2 = new GeometryItem(_local_3);
                _SafeStr_1332[String(_local_3.@id)] = _local_2;
            };
        }

        public function getDynamicParts(_arg_1:IAvatarImage):Array
        {
            var _local_3:Array = [];
            if (_SafeStr_1333[_arg_1] !== undefined)
            {
                for each (var _local_2:GeometryItem in _SafeStr_1333[_arg_1])
                {
                    if (_local_2 != null)
                    {
                        _local_3.push(_local_2);
                    };
                };
            };
            return (_local_3);
        }

        public function getPartIds(_arg_1:IAvatarImage):Array
        {
            var _local_2:GeometryItem;
            var _local_3:Array = [];
            for each (_local_2 in _SafeStr_1332)
            {
                if (_local_2 != null)
                {
                    _local_3.push(_local_2.id);
                };
            };
            if (_SafeStr_1333[_arg_1] !== undefined)
            {
                for each (_local_2 in _SafeStr_1333[_arg_1])
                {
                    if (_local_2 != null)
                    {
                        _local_3.push(_local_2.id);
                    };
                };
            };
            return (_local_3);
        }

        public function removeDynamicParts(_arg_1:IAvatarImage):Boolean
        {
            if (_SafeStr_1333[_arg_1] !== undefined)
            {
                for (var _local_2:String in _SafeStr_1333[_arg_1])
                {
                    delete _SafeStr_1333[_arg_1][_local_2];
                };
                _SafeStr_1333[_arg_1] = null;
                delete _SafeStr_1333[_arg_1];
            };
            return (true);
        }

        public function addPart(_arg_1:XML, _arg_2:IAvatarImage):Boolean
        {
            var _local_3:String = String(_arg_1.@id);
            if (hasPart(_local_3, _arg_2))
            {
                return (false);
            };
            if (_SafeStr_1333[_arg_2] === undefined)
            {
                _SafeStr_1333[_arg_2] = new Dictionary();
            };
            _SafeStr_1333[_arg_2][_local_3] = new GeometryItem(_arg_1, true);
            return (true);
        }

        public function hasPart(_arg_1:String, _arg_2:IAvatarImage):Boolean
        {
            var _local_3:GeometryItem = _SafeStr_1332[_arg_1];
            if (((_local_3 == null) && (!(_SafeStr_1333[_arg_2] === undefined))))
            {
                _local_3 = _SafeStr_1333[_arg_2][_arg_1];
            };
            return (!(_local_3 == null));
        }

        public function getParts(_arg_1:Matrix4x4, _arg_2:Vector3D, _arg_3:Array, _arg_4:IAvatarImage):Array
        {
            var _local_6:Number;
            var _local_5:GeometryItem;
            var _local_9:Array = [];
            var _local_8:Array = [];
            for each (_local_5 in _SafeStr_1332)
            {
                if (_local_5 != null)
                {
                    _local_5.applyTransform(_arg_1);
                    _local_6 = _local_5.getDistance(_arg_2);
                    _local_9.push([_local_6, _local_5]);
                };
            };
            for each (_local_5 in _SafeStr_1333[_arg_4])
            {
                if (_local_5 != null)
                {
                    _local_5.applyTransform(_arg_1);
                    _local_6 = _local_5.getDistance(_arg_2);
                    _local_9.push([_local_6, _local_5]);
                };
            };
            _local_9.sort(orderParts);
            for each (var _local_7:Array in _local_9)
            {
                _local_5 = (_local_7[1] as GeometryItem);
                _local_8.push(_local_5.id);
            };
            return (_local_8);
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

        private function orderParts(_arg_1:Array, _arg_2:Array):Number
        {
            var _local_3:Number = (_arg_1[0] as Number);
            var _local_4:Number = (_arg_2[0] as Number);
            if (_local_3 < _local_4)
            {
                return (-1);
            };
            if (_local_3 > _local_4)
            {
                return (1);
            };
            return (0);
        }

        public function get radius():Number
        {
            return (_radius);
        }


    }
}

