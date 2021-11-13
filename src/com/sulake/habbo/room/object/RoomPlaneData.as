package com.sulake.habbo.room.object
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;

    public class RoomPlaneData 
    {

        public static const PLANE_UNDEFINED:int = 0;
        public static const PLANE_FLOOR:int = 1;
        public static const PLANE_WALL:int = 2;
        public static const PLANE_LANDSCAPE:int = 3;
        public static const PLANE_BILLBOARD:int = 4;

        private var _type:int = 0;
        private var _loc:Vector3d = null;
        private var _leftSide:Vector3d = null;
        private var _rightSide:Vector3d = null;
        private var _normal:Vector3d = null;
        private var _normalDirection:Vector3d = null;
        private var _secondaryNormals:Array = [];
        private var _SafeStr_3426:Array = [];

        public function RoomPlaneData(_arg_1:int, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:IVector3d, _arg_5:Array)
        {
            super();
            var _local_6:Number;
            var _local_7:Number;
            var _local_9:Number;
            var _local_12:Number;
            var _local_13:Number;
            var _local_10:int;
            var _local_11:IVector3d = null;
            var _local_8:Vector3d = null;
            _loc = new Vector3d();
            _loc.assign(_arg_2);
            _leftSide = new Vector3d();
            _leftSide.assign(_arg_3);
            _rightSide = new Vector3d();
            _rightSide.assign(_arg_4);
            _type = _arg_1;
            if (((!(_arg_3 == null)) && (!(_arg_4 == null))))
            {
                _normal = Vector3d.crossProduct(_arg_3, _arg_4);
                _local_6 = 0;
                _local_7 = 0;
                _local_9 = 0;
                _local_12 = 0;
                _local_13 = 0;
                if (((!(normal.x == 0)) || (!(normal.y == 0))))
                {
                    _local_12 = normal.x;
                    _local_13 = normal.y;
                    _local_6 = (360 + ((Math.atan2(_local_13, _local_12) / 3.14159265358979) * 180));
                    if (_local_6 >= 360)
                    {
                        _local_6 = (_local_6 - 360);
                    };
                    _local_12 = Math.sqrt(((normal.x * normal.x) + (normal.y * normal.y)));
                    _local_13 = normal.z;
                    _local_7 = (360 + ((Math.atan2(_local_13, _local_12) / 3.14159265358979) * 180));
                    if (_local_7 >= 360)
                    {
                        _local_7 = (_local_7 - 360);
                    };
                }
                else
                {
                    if (normal.z < 0)
                    {
                        _local_7 = 90;
                    }
                    else
                    {
                        _local_7 = 270;
                    };
                };
                _normalDirection = new Vector3d(_local_6, _local_7, _local_9);
            };
            if (((!(_arg_5 == null)) && (_arg_5.length > 0)))
            {
                _local_10 = 0;
                while (_local_10 < _arg_5.length)
                {
                    _local_11 = _arg_5[_local_10];
                    if (((!(_local_11 == null)) && (_local_11.length > 0)))
                    {
                        _local_8 = new Vector3d();
                        _local_8.assign(_local_11);
                        _local_8.mul((1 / _local_8.length));
                        _secondaryNormals.push(_local_8);
                    };
                    _local_10++;
                };
            };
        }

        public function get type():int
        {
            return (_type);
        }

        public function get loc():IVector3d
        {
            return (_loc);
        }

        public function get leftSide():IVector3d
        {
            return (_leftSide);
        }

        public function get rightSide():IVector3d
        {
            return (_rightSide);
        }

        public function get normal():IVector3d
        {
            return (_normal);
        }

        public function get normalDirection():IVector3d
        {
            return (_normalDirection);
        }

        public function get secondaryNormalCount():int
        {
            return (_secondaryNormals.length);
        }

        public function get maskCount():int
        {
            return (_SafeStr_3426.length);
        }

        public function getSecondaryNormal(_arg_1:int):IVector3d
        {
            if (((_arg_1 < 0) || (_arg_1 >= secondaryNormalCount)))
            {
                return (null);
            };
            var _local_2:Vector3d = new Vector3d();
            _local_2.assign((_secondaryNormals[_arg_1] as IVector3d));
            return (_local_2);
        }

        public function addMask(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):void
        {
            var _local_5:RoomPlaneMaskData = new RoomPlaneMaskData(_arg_1, _arg_2, _arg_3, _arg_4);
            _SafeStr_3426.push(_local_5);
        }

        private function getMask(_arg_1:int):RoomPlaneMaskData
        {
            if (((_arg_1 < 0) || (_arg_1 >= maskCount)))
            {
                return (null);
            };
            return (_SafeStr_3426[_arg_1]);
        }

        public function getMaskLeftSideLoc(_arg_1:int):Number
        {
            var _local_2:RoomPlaneMaskData = getMask(_arg_1);
            if (_local_2 != null)
            {
                return (_local_2.leftSideLoc);
            };
            return (-1);
        }

        public function getMaskRightSideLoc(_arg_1:int):Number
        {
            var _local_2:RoomPlaneMaskData = getMask(_arg_1);
            if (_local_2 != null)
            {
                return (_local_2.rightSideLoc);
            };
            return (-1);
        }

        public function getMaskLeftSideLength(_arg_1:int):Number
        {
            var _local_2:RoomPlaneMaskData = getMask(_arg_1);
            if (_local_2 != null)
            {
                return (_local_2.leftSideLength);
            };
            return (-1);
        }

        public function getMaskRightSideLength(_arg_1:int):Number
        {
            var _local_2:RoomPlaneMaskData = getMask(_arg_1);
            if (_local_2 != null)
            {
                return (_local_2.rightSideLength);
            };
            return (-1);
        }


    }
}

