package com.sulake.room.utils
{
    import com.sulake.core.utils.Map;
    import flash.geom.Point;

    public class RoomGeometry implements IRoomGeometry 
    {

        public static const SCALE_ZOOMED_IN:Number = 64;
        public static const SCALE_ZOOMED_OUT:Number = 32;

        private var _updateId:int = 0;
        private var _SafeStr_954:Vector3d;
        private var _SafeStr_955:Vector3d;
        private var _SafeStr_4517:Vector3d;
        private var _directionAxis:Vector3d;
        private var _location:Vector3d;
        private var _direction:Vector3d;
        private var _depth:Vector3d;
        private var _SafeStr_1266:Number = 1;
        private var _SafeStr_4518:Number = 1;
        private var _SafeStr_4519:Number = 1;
        private var _SafeStr_4520:Number = 1;
        private var _x_scale_internal:Number = 1;
        private var _y_scale_internal:Number = 1;
        private var _z_scale_internal:Number = 1;
        private var _SafeStr_3181:Vector3d;
        private var _SafeStr_1925:Vector3d;
        private var _SafeStr_4521:Number = -500;
        private var _SafeStr_4522:Number = 500;
        private var _SafeStr_4523:Map = null;

        public function RoomGeometry(_arg_1:Number, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:IVector3d=null)
        {
            this.scale = _arg_1;
            _SafeStr_954 = new Vector3d();
            _SafeStr_955 = new Vector3d();
            _SafeStr_4517 = new Vector3d();
            _directionAxis = new Vector3d();
            _location = new Vector3d();
            _direction = new Vector3d();
            _depth = new Vector3d();
            _x_scale_internal = 1;
            _y_scale_internal = 1;
            x_scale = 1;
            y_scale = 1;
            _z_scale_internal = (Math.sqrt(0.5) / Math.sqrt(0.75));
            z_scale = 1;
            location = new Vector3d(_arg_3.x, _arg_3.y, _arg_3.z);
            direction = new Vector3d(_arg_2.x, _arg_2.y, _arg_2.z);
            if (_arg_4 != null)
            {
                setDepthVector(_arg_4);
            }
            else
            {
                setDepthVector(_arg_2);
            };
            _SafeStr_4523 = new Map();
        }

        public static function getIntersectionVector(_arg_1:IVector3d, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:IVector3d):IVector3d
        {
            var _local_6:Number = Vector3d.dotProduct(_arg_2, _arg_4);
            if (Math.abs(_local_6) < 1E-5)
            {
                return (null);
            };
            var _local_8:Vector3d = Vector3d.dif(_arg_1, _arg_3);
            var _local_5:Number = (-(Vector3d.dotProduct(_arg_4, _local_8)) / _local_6);
            var _local_7:Vector3d = Vector3d.sum(_arg_1, Vector3d.product(_arg_2, _local_5));
            return (_local_7);
        }


        public function get updateId():int
        {
            return (_updateId);
        }

        public function get scale():Number
        {
            return (_SafeStr_1266 / Math.sqrt(0.5));
        }

        public function get directionAxis():IVector3d
        {
            return (_directionAxis);
        }

        public function get location():IVector3d
        {
            _location.assign(_SafeStr_3181);
            _location.x = (_location.x * _SafeStr_4518);
            _location.y = (_location.y * _SafeStr_4519);
            _location.z = (_location.z * _SafeStr_4520);
            return (_location);
        }

        public function get direction():IVector3d
        {
            return (_direction);
        }

        public function set x_scale(_arg_1:Number):void
        {
            if (_SafeStr_4518 != (_arg_1 * _x_scale_internal))
            {
                _SafeStr_4518 = (_arg_1 * _x_scale_internal);
                _updateId++;
            };
        }

        public function set y_scale(_arg_1:Number):void
        {
            if (_SafeStr_4519 != (_arg_1 * _y_scale_internal))
            {
                _SafeStr_4519 = (_arg_1 * _y_scale_internal);
                _updateId++;
            };
        }

        public function set z_scale(_arg_1:Number):void
        {
            if (_SafeStr_4520 != (_arg_1 * _z_scale_internal))
            {
                _SafeStr_4520 = (_arg_1 * _z_scale_internal);
                _updateId++;
            };
        }

        public function set scale(_arg_1:Number):void
        {
            if (_arg_1 <= 1)
            {
                _arg_1 = 1;
            };
            _arg_1 = (_arg_1 * Math.sqrt(0.5));
            if (_arg_1 != _SafeStr_1266)
            {
                _SafeStr_1266 = _arg_1;
                _updateId++;
            };
        }

        public function set location(_arg_1:IVector3d):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            if (_SafeStr_3181 == null)
            {
                _SafeStr_3181 = new Vector3d();
            };
            var _local_2:Number = _SafeStr_3181.x;
            var _local_3:Number = _SafeStr_3181.y;
            var _local_4:Number = _SafeStr_3181.z;
            _SafeStr_3181.assign(_arg_1);
            _SafeStr_3181.x = (_SafeStr_3181.x / _SafeStr_4518);
            _SafeStr_3181.y = (_SafeStr_3181.y / _SafeStr_4519);
            _SafeStr_3181.z = (_SafeStr_3181.z / _SafeStr_4520);
            if ((((!(_SafeStr_3181.x == _local_2)) || (!(_SafeStr_3181.y == _local_3))) || (!(_SafeStr_3181.z == _local_4))))
            {
                _updateId++;
            };
        }

        public function set direction(_arg_1:IVector3d):void
        {
            var _local_4:Number;
            var _local_21:Number;
            var _local_19:Vector3d;
            var _local_14:Vector3d;
            var _local_2:Vector3d;
            if (_arg_1 == null)
            {
                return;
            };
            if (_SafeStr_1925 == null)
            {
                _SafeStr_1925 = new Vector3d();
            };
            var _local_7:Number = _SafeStr_1925.x;
            var _local_8:Number = _SafeStr_1925.y;
            var _local_9:Number = _SafeStr_1925.z;
            _SafeStr_1925.assign(_arg_1);
            _direction.assign(_arg_1);
            if ((((!(_SafeStr_1925.x == _local_7)) || (!(_SafeStr_1925.y == _local_8))) || (!(_SafeStr_1925.z == _local_9))))
            {
                _updateId++;
            };
            var _local_18:Vector3d = new Vector3d(0, 1, 0);
            var _local_20:Vector3d = new Vector3d(0, 0, 1);
            var _local_22:Vector3d = new Vector3d(1, 0, 0);
            var _local_10:Number = ((_arg_1.x / 180) * 3.14159265358979);
            var _local_11:Number = ((_arg_1.y / 180) * 3.14159265358979);
            var _local_12:Number = ((_arg_1.z / 180) * 3.14159265358979);
            var _local_6:Number = Math.cos(_local_10);
            var _local_25:Number = Math.sin(_local_10);
            var _local_16:Vector3d = Vector3d.sum(Vector3d.product(_local_18, _local_6), Vector3d.product(_local_22, -(_local_25)));
            var _local_15:Vector3d = new Vector3d(_local_20.x, _local_20.y, _local_20.z);
            var _local_17:Vector3d = Vector3d.sum(Vector3d.product(_local_18, _local_25), Vector3d.product(_local_22, _local_6));
            var _local_5:Number = Math.cos(_local_11);
            var _local_24:Number = Math.sin(_local_11);
            var _local_13:Vector3d = new Vector3d(_local_16.x, _local_16.y, _local_16.z);
            var _local_23:Vector3d = Vector3d.sum(Vector3d.product(_local_15, _local_5), Vector3d.product(_local_17, _local_24));
            var _local_3:Vector3d = Vector3d.sum(Vector3d.product(_local_15, -(_local_24)), Vector3d.product(_local_17, _local_5));
            if (_local_12 != 0)
            {
                _local_4 = Math.cos(_local_12);
                _local_21 = Math.sin(_local_12);
                _local_19 = Vector3d.sum(Vector3d.product(_local_13, _local_4), Vector3d.product(_local_23, _local_21));
                _local_14 = Vector3d.sum(Vector3d.product(_local_13, -(_local_21)), Vector3d.product(_local_23, _local_4));
                _local_2 = new Vector3d(_local_3.x, _local_3.y, _local_3.z);
                _SafeStr_954.assign(_local_19);
                _SafeStr_955.assign(_local_14);
                _SafeStr_4517.assign(_local_2);
                _directionAxis.assign(_SafeStr_4517);
            }
            else
            {
                _SafeStr_954.assign(_local_13);
                _SafeStr_955.assign(_local_23);
                _SafeStr_4517.assign(_local_3);
                _directionAxis.assign(_SafeStr_4517);
            };
        }

        public function dispose():void
        {
            _SafeStr_954 = null;
            _SafeStr_955 = null;
            _SafeStr_4517 = null;
            _SafeStr_3181 = null;
            _SafeStr_1925 = null;
            _directionAxis = null;
            _location = null;
            if (_SafeStr_4523 != null)
            {
                _SafeStr_4523.dispose();
                _SafeStr_4523 = null;
            };
        }

        public function setDisplacement(_arg_1:IVector3d, _arg_2:IVector3d):void
        {
            var _local_4:String;
            var _local_3:Vector3d;
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return;
            };
            if (_SafeStr_4523 != null)
            {
                _local_4 = ((((Math.round(_arg_1.x) + "_") + Math.round(_arg_1.y)) + "_") + Math.round(_arg_1.z));
                _SafeStr_4523.remove(_local_4);
                _local_3 = new Vector3d();
                _local_3.assign(_arg_2);
                _SafeStr_4523.add(_local_4, _local_3);
                _updateId++;
            };
        }

        private function getDisplacenent(_arg_1:IVector3d):IVector3d
        {
            var _local_2:String;
            if (_SafeStr_4523 != null)
            {
                _local_2 = ((((Math.round(_arg_1.x) + "_") + Math.round(_arg_1.y)) + "_") + Math.round(_arg_1.z));
                return (_SafeStr_4523.getValue(_local_2));
            };
            return (null);
        }

        public function setDepthVector(_arg_1:IVector3d):void
        {
            var _local_9:Number;
            var _local_18:Number;
            var _local_16:Vector3d;
            var _local_7:Vector3d;
            var _local_4:Vector3d;
            var _local_15:Vector3d = new Vector3d(0, 1, 0);
            var _local_17:Vector3d = new Vector3d(0, 0, 1);
            var _local_19:Vector3d = new Vector3d(1, 0, 0);
            var _local_2:Number = ((_arg_1.x / 180) * 3.14159265358979);
            var _local_3:Number = ((_arg_1.y / 180) * 3.14159265358979);
            var _local_5:Number = ((_arg_1.z / 180) * 3.14159265358979);
            var _local_11:Number = Math.cos(_local_2);
            var _local_22:Number = Math.sin(_local_2);
            var _local_13:Vector3d = Vector3d.sum(Vector3d.product(_local_15, _local_11), Vector3d.product(_local_19, -(_local_22)));
            var _local_12:Vector3d = new Vector3d(_local_17.x, _local_17.y, _local_17.z);
            var _local_14:Vector3d = Vector3d.sum(Vector3d.product(_local_15, _local_22), Vector3d.product(_local_19, _local_11));
            var _local_10:Number = Math.cos(_local_3);
            var _local_21:Number = Math.sin(_local_3);
            var _local_6:Vector3d = new Vector3d(_local_13.x, _local_13.y, _local_13.z);
            var _local_20:Vector3d = Vector3d.sum(Vector3d.product(_local_12, _local_10), Vector3d.product(_local_14, _local_21));
            var _local_8:Vector3d = Vector3d.sum(Vector3d.product(_local_12, -(_local_21)), Vector3d.product(_local_14, _local_10));
            if (_local_5 != 0)
            {
                _local_9 = Math.cos(_local_5);
                _local_18 = Math.sin(_local_5);
                _local_16 = Vector3d.sum(Vector3d.product(_local_6, _local_9), Vector3d.product(_local_20, _local_18));
                _local_7 = Vector3d.sum(Vector3d.product(_local_6, -(_local_18)), Vector3d.product(_local_20, _local_9));
                _local_4 = new Vector3d(_local_8.x, _local_8.y, _local_8.z);
                _depth.assign(_local_4);
            }
            else
            {
                _depth.assign(_local_8);
            };
            _updateId++;
        }

        public function adjustLocation(_arg_1:IVector3d, _arg_2:Number):void
        {
            if (((_arg_1 == null) || (_SafeStr_4517 == null)))
            {
                return;
            };
            var _local_4:Vector3d = Vector3d.product(_SafeStr_4517, -(_arg_2));
            var _local_3:Vector3d = new Vector3d((_arg_1.x + _local_4.x), (_arg_1.y + _local_4.y), (_arg_1.z + _local_4.z));
            location = _local_3;
        }

        public function getCoordinatePosition(_arg_1:IVector3d):IVector3d
        {
            if (_arg_1 == null)
            {
                return (null);
            };
            var _local_3:Number = Vector3d.scalarProjection(_arg_1, _SafeStr_954);
            var _local_4:Number = Vector3d.scalarProjection(_arg_1, _SafeStr_955);
            var _local_5:Number = Vector3d.scalarProjection(_arg_1, _SafeStr_4517);
            return (new Vector3d(_local_3, _local_4, _local_5));
        }

        public function getScreenPosition(_arg_1:IVector3d):IVector3d
        {
            var _local_2:Vector3d = Vector3d.dif(_arg_1, _SafeStr_3181);
            _local_2.x = (_local_2.x * _SafeStr_4518);
            _local_2.y = (_local_2.y * _SafeStr_4519);
            _local_2.z = (_local_2.z * _SafeStr_4520);
            var _local_5:Number = Vector3d.scalarProjection(_local_2, _depth);
            if (((_local_5 < _SafeStr_4521) || (_local_5 > _SafeStr_4522)))
            {
                return (null);
            };
            var _local_3:Number = Vector3d.scalarProjection(_local_2, _SafeStr_954);
            var _local_4:Number = -(Vector3d.scalarProjection(_local_2, _SafeStr_955));
            _local_3 = (_local_3 * _SafeStr_1266);
            _local_4 = (_local_4 * _SafeStr_1266);
            var _local_6:IVector3d = getDisplacenent(_arg_1);
            if (_local_6 != null)
            {
                _local_2 = Vector3d.dif(_arg_1, _SafeStr_3181);
                _local_2.add(_local_6);
                _local_2.x = (_local_2.x * _SafeStr_4518);
                _local_2.y = (_local_2.y * _SafeStr_4519);
                _local_2.z = (_local_2.z * _SafeStr_4520);
                _local_5 = Vector3d.scalarProjection(_local_2, _depth);
            };
            _local_2.x = _local_3;
            _local_2.y = _local_4;
            _local_2.z = _local_5;
            return (_local_2);
        }

        public function getScreenPoint(_arg_1:IVector3d):Point
        {
            var _local_2:IVector3d = getScreenPosition(_arg_1);
            if (_local_2 == null)
            {
                return (null);
            };
            return (new Point(_local_2.x, _local_2.y));
        }

        public function getPlanePosition(_arg_1:Point, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:IVector3d):Point
        {
            var _local_10:Number;
            var _local_12:Number;
            var _local_14:Number = (_arg_1.x / _SafeStr_1266);
            var _local_16:Number = (-(_arg_1.y) / _SafeStr_1266);
            var _local_6:Vector3d = Vector3d.product(_SafeStr_954, _local_14);
            _local_6.add(Vector3d.product(_SafeStr_955, _local_16));
            var _local_8:Vector3d = new Vector3d((_SafeStr_3181.x * _SafeStr_4518), (_SafeStr_3181.y * _SafeStr_4519), (_SafeStr_3181.z * _SafeStr_4520));
            _local_8.add(_local_6);
            var _local_15:IVector3d = _SafeStr_4517;
            var _local_5:Vector3d = new Vector3d((_arg_2.x * _SafeStr_4518), (_arg_2.y * _SafeStr_4519), (_arg_2.z * _SafeStr_4520));
            var _local_13:Vector3d = new Vector3d((_arg_3.x * _SafeStr_4518), (_arg_3.y * _SafeStr_4519), (_arg_3.z * _SafeStr_4520));
            var _local_7:Vector3d = new Vector3d((_arg_4.x * _SafeStr_4518), (_arg_4.y * _SafeStr_4519), (_arg_4.z * _SafeStr_4520));
            var _local_11:IVector3d = Vector3d.crossProduct(_local_13, _local_7);
            var _local_9:Vector3d = new Vector3d();
            _local_9.assign(RoomGeometry.getIntersectionVector(_local_8, _local_15, _local_5, _local_11));
            if (_local_9 != null)
            {
                _local_9.sub(_local_5);
                _local_10 = ((Vector3d.scalarProjection(_local_9, _arg_3) / _local_13.length) * _arg_3.length);
                _local_12 = ((Vector3d.scalarProjection(_local_9, _arg_4) / _local_7.length) * _arg_4.length);
                return (new Point(_local_10, _local_12));
            };
            return (null);
        }

        public function performZoom():void
        {
            if (isZoomedIn())
            {
                scale = 32;
            }
            else
            {
                scale = 64;
            };
        }

        public function isZoomedIn():Boolean
        {
            return (scale == 64);
        }

        public function performZoomOut():void
        {
            scale = 32;
        }

        public function performZoomIn():void
        {
            scale = 64;
        }


    }
}

