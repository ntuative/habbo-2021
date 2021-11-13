package com.sulake.habbo.avatar.geometry
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.structure.AvatarCanvas;
    import com.sulake.habbo.avatar.IAvatarImage;

    public class AvatarModelGeometry 
    {

        private var _SafeStr_1328:AvatarSet;
        private var _SafeStr_1326:Dictionary;
        private var _SafeStr_1327:Dictionary;
        private var _transformation:Matrix4x4;
        private var _camera:Vector3D = new Vector3D(0, 0, 10);
        private var _SafeStr_1325:Dictionary;

        public function AvatarModelGeometry(_arg_1:XML)
        {
            super();
            var _local_12:Number;
            var _local_13:Number;
            var _local_14:Number;
            var _local_2:XML = null;
            var _local_10:XML = null;
            var _local_11:AvatarCanvas = null;
            var _local_6:String = null;
            var _local_4:Dictionary = null;
            var _local_15:XML = null;
            var _local_7:Dictionary = null;
            var _local_5:Dictionary = null;
            var _local_3:XML = null;
            var _local_9:GeometryBodyPart = null;
            _transformation = new Matrix4x4();
            _SafeStr_1326 = new Dictionary();
            _SafeStr_1327 = new Dictionary();
            _SafeStr_1328 = new AvatarSet(_arg_1.avatarset[0]);
            _SafeStr_1325 = new Dictionary();
            var _local_8:XML = _arg_1.camera[0];
            if (_local_8 != null)
            {
                _local_12 = parseFloat(_local_8.x.text());
                _local_13 = parseFloat(_local_8.y.text());
                _local_14 = parseFloat(_local_8.z.text());
                _camera.x = _local_12;
                _camera.y = _local_13;
                _camera.z = _local_14;
            };
            for each (_local_2 in _arg_1.canvas)
            {
                _local_6 = String(_local_2.@scale);
                _local_4 = new Dictionary();
                for each (_local_10 in _local_2.geometry)
                {
                    _local_11 = new AvatarCanvas(_local_10, _local_6);
                    _local_4[String(_local_10.@id)] = _local_11;
                };
                _SafeStr_1325[_local_6] = _local_4;
            };
            for each (_local_15 in _arg_1.type)
            {
                _local_7 = new Dictionary();
                _local_5 = new Dictionary();
                for each (_local_3 in _local_15.bodypart)
                {
                    _local_9 = new GeometryBodyPart(_local_3);
                    _local_7[String(_local_3.@id)] = _local_9;
                    for each (var _local_16:String in _local_9.getPartIds(null))
                    {
                        _local_5[_local_16] = _local_9;
                    };
                };
                _SafeStr_1326[String(_local_15.@id)] = _local_7;
                _SafeStr_1327[String(_local_15.@id)] = _local_5;
            };
        }

        public function removeDynamicItems(_arg_1:IAvatarImage):void
        {
            var _local_2:Dictionary;
            var _local_3:GeometryBodyPart;
            for each (_local_2 in _SafeStr_1326)
            {
                for each (_local_3 in _local_2)
                {
                    _local_3.removeDynamicParts(_arg_1);
                };
            };
        }

        public function getBodyPartIdsInAvatarSet(_arg_1:String):Array
        {
            var _local_3:Array = [];
            var _local_2:AvatarSet = _SafeStr_1328.findAvatarSet(_arg_1);
            if (_local_2 != null)
            {
                _local_3 = _local_2.getBodyParts();
            };
            return (_local_3);
        }

        public function isMainAvatarSet(_arg_1:String):Boolean
        {
            var _local_2:AvatarSet = _SafeStr_1328.findAvatarSet(_arg_1);
            if (_local_2 != null)
            {
                return (_local_2.isMain);
            };
            return (false);
        }

        public function getCanvas(_arg_1:String, _arg_2:String):AvatarCanvas
        {
            var _local_4:AvatarCanvas;
            var _local_3:Dictionary = _SafeStr_1325[_arg_1];
            if (_local_3 != null)
            {
                _local_4 = (_local_3[_arg_2] as AvatarCanvas);
            };
            return (_local_4);
        }

        private function typeExists(_arg_1:String):Boolean
        {
            return (!(_SafeStr_1326[_arg_1] == null));
        }

        private function hasBodyPart(_arg_1:String, _arg_2:String):Boolean
        {
            var _local_3:Dictionary;
            if (typeExists(_arg_1))
            {
                _local_3 = (_SafeStr_1326[_arg_1] as Dictionary);
                return (!(_local_3[_arg_2] == null));
            };
            return (false);
        }

        private function getBodyPartIDs(_arg_1:String):Array
        {
            var _local_4:Dictionary = getBodyPartsOfType(_arg_1);
            var _local_2:Array = [];
            for (var _local_3:String in _SafeStr_1326)
            {
                _local_2.push(_local_3);
            };
            return (_local_2);
        }

        private function getBodyPartsOfType(_arg_1:String):Dictionary
        {
            if (typeExists(_arg_1))
            {
                return (_SafeStr_1326[_arg_1] as Dictionary);
            };
            return (new Dictionary());
        }

        public function getBodyPart(_arg_1:String, _arg_2:String):GeometryBodyPart
        {
            var _local_3:Dictionary = getBodyPartsOfType(_arg_1);
            return (_local_3[_arg_2]);
        }

        public function getBodyPartOfItem(_arg_1:String, _arg_2:String, _arg_3:IAvatarImage):GeometryBodyPart
        {
            var _local_6:GeometryBodyPart;
            var _local_5:Dictionary;
            var _local_4:Dictionary = _SafeStr_1327[_arg_1];
            if (_local_4 != null)
            {
                _local_6 = _local_4[_arg_2];
                if (_local_6 != null)
                {
                    return (_local_6);
                };
                _local_5 = getBodyPartsOfType(_arg_1);
                for each (_local_6 in _local_5)
                {
                    if (_local_6.hasPart(_arg_2, _arg_3))
                    {
                        return (_local_6);
                    };
                };
            };
            return (null);
        }

        private function getBodyPartsInAvatarSet(_arg_1:Dictionary, _arg_2:String):Array
        {
            var _local_6:GeometryBodyPart;
            var _local_4:String;
            var _local_5:Array = [];
            var _local_3:Array = this.getBodyPartIdsInAvatarSet(_arg_2);
            for each (_local_4 in _local_3)
            {
                _local_6 = _arg_1[_local_4];
                if (_local_6 != null)
                {
                    _local_5.push(_local_6);
                };
            };
            return (_local_5);
        }

        public function getBodyPartsAtAngle(_arg_1:String, _arg_2:uint, _arg_3:String):Array
        {
            var _local_10:GeometryBodyPart;
            var _local_7:Number;
            var _local_8:Array;
            if (_arg_3 == null)
            {
                Logger.log("[AvatarModelGeometry] ERROR: Geometry ID not found for action: ");
                return ([]);
            };
            var _local_4:Dictionary = getBodyPartsOfType(_arg_3);
            var _local_6:Array = getBodyPartsInAvatarSet(_local_4, _arg_1);
            var _local_9:Array = [];
            var _local_5:Array = [];
            _transformation = Matrix4x4.getYRotationMatrix(_arg_2);
            for each (_local_10 in _local_6)
            {
                _local_10.applyTransform(_transformation);
                _local_7 = _local_10.getDistance(_camera);
                _local_9.push([_local_7, _local_10]);
            };
            _local_9.sort(orderByDistance);
            for each (_local_8 in _local_9)
            {
                _local_10 = (_local_8[1] as GeometryBodyPart);
                _local_5.push(_local_10.id);
            };
            return (_local_5);
        }

        public function getParts(_arg_1:String, _arg_2:String, _arg_3:uint, _arg_4:Array, _arg_5:IAvatarImage):Array
        {
            var _local_6:GeometryBodyPart;
            if (hasBodyPart(_arg_1, _arg_2))
            {
                _local_6 = (getBodyPartsOfType(_arg_1)[_arg_2] as GeometryBodyPart);
                _transformation = Matrix4x4.getYRotationMatrix(_arg_3);
                return (_local_6.getParts(_transformation, _camera, _arg_4, _arg_5));
            };
            return ([]);
        }

        private function orderByDistance(_arg_1:Array, _arg_2:Array):Number
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


    }
}

