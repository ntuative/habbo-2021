package com.sulake.habbo.room.utils
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;

        public class RoomCamera 
    {

        private static const MOVE_SPEED_DENOMINATOR:Number = 12;

        private var _targetId:int = -1;
        private var _targetCategory:int = -2;
        private var _SafeStr_2712:Vector3d = null;
        private var _SafeStr_3609:Number = 0;
        private var _SafeStr_3610:Number = 0;
        private var _SafeStr_3611:Boolean = false;
        private var _location:Vector3d = null;
        private var _targetObjectLoc:Vector3d = new Vector3d();
        private var _limitedLocationX:Boolean = false;
        private var _limitedLocationY:Boolean = false;
        private var _centeredLocX:Boolean = false;
        private var _centeredLocY:Boolean = false;
        private var _screenWd:int = 0;
        private var _screenHt:int = 0;
        private var _scale:int = 0;
        private var _roomWd:int = 0;
        private var _roomHt:int = 0;
        private var _geometryUpdateId:int = -1;
        private var _SafeStr_3612:Boolean = false;
        private var _followDuration:int;


        public function get location():IVector3d
        {
            return (_location);
        }

        public function get targetId():int
        {
            return (_targetId);
        }

        public function get targetCategory():int
        {
            return (_targetCategory);
        }

        public function get targetObjectLoc():IVector3d
        {
            return (_targetObjectLoc);
        }

        public function get limitedLocationX():Boolean
        {
            return (_limitedLocationX);
        }

        public function get limitedLocationY():Boolean
        {
            return (_limitedLocationY);
        }

        public function get centeredLocX():Boolean
        {
            return (_centeredLocX);
        }

        public function get centeredLocY():Boolean
        {
            return (_centeredLocY);
        }

        public function get screenWd():int
        {
            return (_screenWd);
        }

        public function get screenHt():int
        {
            return (_screenHt);
        }

        public function get scale():int
        {
            return (_scale);
        }

        public function get roomWd():int
        {
            return (_roomWd);
        }

        public function get roomHt():int
        {
            return (_roomHt);
        }

        public function get geometryUpdateId():int
        {
            return (_geometryUpdateId);
        }

        public function get isMoving():Boolean
        {
            if (((!(_SafeStr_2712 == null)) && (!(_location == null))))
            {
                return (true);
            };
            return (false);
        }

        public function set targetId(_arg_1:int):void
        {
            _targetId = _arg_1;
        }

        public function set targetObjectLoc(_arg_1:IVector3d):void
        {
            _targetObjectLoc.assign(_arg_1);
        }

        public function set targetCategory(_arg_1:int):void
        {
            _targetCategory = _arg_1;
        }

        public function set limitedLocationX(_arg_1:Boolean):void
        {
            _limitedLocationX = _arg_1;
        }

        public function set limitedLocationY(_arg_1:Boolean):void
        {
            _limitedLocationY = _arg_1;
        }

        public function set centeredLocX(_arg_1:Boolean):void
        {
            _centeredLocX = _arg_1;
        }

        public function set centeredLocY(_arg_1:Boolean):void
        {
            _centeredLocY = _arg_1;
        }

        public function set screenWd(_arg_1:int):void
        {
            _screenWd = _arg_1;
        }

        public function set screenHt(_arg_1:int):void
        {
            _screenHt = _arg_1;
        }

        public function set scale(_arg_1:int):void
        {
            if (_scale != _arg_1)
            {
                _scale = _arg_1;
                _SafeStr_3612 = true;
            };
        }

        public function set roomWd(_arg_1:int):void
        {
            _roomWd = _arg_1;
        }

        public function set roomHt(_arg_1:int):void
        {
            _roomHt = _arg_1;
        }

        public function set geometryUpdateId(_arg_1:int):void
        {
            _geometryUpdateId = _arg_1;
        }

        public function set target(_arg_1:IVector3d):void
        {
            var _local_2:Vector3d;
            if (_SafeStr_2712 == null)
            {
                _SafeStr_2712 = new Vector3d();
            };
            if ((((!(_SafeStr_2712.x == _arg_1.x)) || (!(_SafeStr_2712.y == _arg_1.y))) || (!(_SafeStr_2712.z == _arg_1.z))))
            {
                _SafeStr_2712.assign(_arg_1);
                _local_2 = Vector3d.dif(_SafeStr_2712, _location);
                _SafeStr_3609 = _local_2.length;
                _SafeStr_3611 = true;
            };
        }

        public function dispose():void
        {
            _SafeStr_2712 = null;
            _location = null;
        }

        public function initializeLocation(_arg_1:IVector3d):void
        {
            if (_location != null)
            {
                return;
            };
            _location = new Vector3d();
            _location.assign(_arg_1);
        }

        public function resetLocation(_arg_1:IVector3d):void
        {
            if (_location == null)
            {
                _location = new Vector3d();
            };
            _location.assign(_arg_1);
        }

        public function update(_arg_1:uint, _arg_2:Number):void
        {
            var _local_4:Vector3d;
            var _local_5:Number;
            var _local_6:Number;
            var _local_3:Number;
            var _local_7:Number;
            if ((((_followDuration > 0) && (!(_SafeStr_2712 == null))) && (!(_location == null))))
            {
                if (_SafeStr_3612)
                {
                    _SafeStr_3612 = false;
                    _location = _SafeStr_2712;
                    _SafeStr_2712 = null;
                    return;
                };
                _local_4 = Vector3d.dif(_SafeStr_2712, _location);
                if (_local_4.length > _SafeStr_3609)
                {
                    _SafeStr_3609 = _local_4.length;
                };
                if (_local_4.length <= _arg_2)
                {
                    _location = _SafeStr_2712;
                    _SafeStr_2712 = null;
                    _SafeStr_3610 = 0;
                }
                else
                {
                    _local_5 = Math.sin(((3.14159265358979 * _local_4.length) / _SafeStr_3609));
                    _local_6 = (_arg_2 * 0.5);
                    _local_3 = (_SafeStr_3609 / 12);
                    _local_7 = (_local_6 + ((_local_3 - _local_6) * _local_5));
                    if (_SafeStr_3611)
                    {
                        if (_local_7 < _SafeStr_3610)
                        {
                            _local_7 = _SafeStr_3610;
                            if (_local_7 > _local_4.length)
                            {
                                _local_7 = _local_4.length;
                            };
                        }
                        else
                        {
                            _SafeStr_3611 = false;
                        };
                    };
                    _SafeStr_3610 = _local_7;
                    _local_4.div(_local_4.length);
                    _local_4.mul(_local_7);
                    _location = Vector3d.sum(_location, _local_4);
                };
            };
        }

        public function reset():void
        {
            _geometryUpdateId = -1;
        }

        public function activateFollowing(_arg_1:int):void
        {
            _followDuration = _arg_1;
        }


    }
}

