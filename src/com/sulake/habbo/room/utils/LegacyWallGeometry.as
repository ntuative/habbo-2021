package com.sulake.habbo.room.utils
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;

        public class LegacyWallGeometry implements IDisposable 
    {

        private static const _SafeStr_3608:String = "l";
        private static const DIRECTION_RIGHT:String = "r";

        private var _disposed:Boolean = false;
        private var _scale:int = 64;
        private var _SafeStr_2076:Array = [];
        private var _width:int = 0;
        private var _SafeStr_1113:int = 0;
        private var _floorHeight:int = 0;


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get scale():int
        {
            return (_scale);
        }

        public function set scale(_arg_1:int):void
        {
            _scale = _arg_1;
        }

        public function dispose():void
        {
            reset();
            _disposed = true;
        }

        public function initialize(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_6:int;
            var _local_4:Array;
            var _local_5:int;
            if (((_arg_1 <= _width) && (_arg_2 <= _SafeStr_1113)))
            {
                _width = _arg_1;
                _SafeStr_1113 = _arg_2;
                _floorHeight = _arg_3;
                return;
            };
            reset();
            _local_6 = 0;
            while (_local_6 < _arg_2)
            {
                _local_4 = [];
                _SafeStr_2076.push(_local_4);
                _local_5 = 0;
                while (_local_5 < _arg_1)
                {
                    _local_4.push(0);
                    _local_5++;
                };
                _local_6++;
            };
            _width = _arg_1;
            _SafeStr_1113 = _arg_2;
            _floorHeight = _arg_3;
        }

        private function reset():void
        {
            var _local_2:int;
            var _local_1:Array;
            if (_SafeStr_2076 != null)
            {
                _local_2 = 0;
                while (_local_2 < _SafeStr_2076.length)
                {
                    _local_1 = (_SafeStr_2076[_local_2] as Array);
                    _local_2++;
                };
                _SafeStr_2076 = [];
            };
        }

        public function setTileHeight(_arg_1:int, _arg_2:int, _arg_3:Number):Boolean
        {
            if (((((_arg_1 < 0) || (_arg_1 >= _width)) || (_arg_2 < 0)) || (_arg_2 >= _SafeStr_1113)))
            {
                return (false);
            };
            var _local_4:Array = (_SafeStr_2076[_arg_2] as Array);
            if (_local_4 != null)
            {
                _local_4[_arg_1] = _arg_3;
                return (true);
            };
            return (false);
        }

        public function getTileHeight(_arg_1:int, _arg_2:int):Number
        {
            if (((((_arg_1 < 0) || (_arg_1 >= _width)) || (_arg_2 < 0)) || (_arg_2 >= _SafeStr_1113)))
            {
                return (0);
            };
            var _local_3:Array = (_SafeStr_2076[_arg_2] as Array);
            if (_local_3 != null)
            {
                return (_local_3[_arg_1] as Number);
            };
            return (0);
        }

        public function getLocation(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:String):IVector3d
        {
            var _local_11:int;
            var _local_10:int;
            var _local_8:int;
            if (((_arg_1 == 0) && (_arg_2 == 0)))
            {
                _arg_1 = _width;
                _arg_2 = _SafeStr_1113;
                _local_11 = int(Math.round((scale / 10)));
                if (_arg_5 == "r")
                {
                    _local_8 = (_width - 1);
                    while (_local_8 >= 0)
                    {
                        _local_10 = 1;
                        while (_local_10 < _SafeStr_1113)
                        {
                            if (getTileHeight(_local_8, _local_10) <= _floorHeight)
                            {
                                if ((_local_10 - 1) < _arg_2)
                                {
                                    _arg_1 = _local_8;
                                    _arg_2 = (_local_10 - 1);
                                };
                                break;
                            };
                            _local_10++;
                        };
                        _local_8--;
                    };
                    _arg_4 = int((_arg_4 + ((scale / 4) - (_local_11 / 2))));
                    _arg_3 = int((_arg_3 + (scale / 2)));
                }
                else
                {
                    _local_10 = (_SafeStr_1113 - 1);
                    while (_local_10 >= 0)
                    {
                        _local_8 = 1;
                        while (_local_8 < _width)
                        {
                            if (getTileHeight(_local_8, _local_10) <= _floorHeight)
                            {
                                if ((_local_8 - 1) < _arg_1)
                                {
                                    _arg_1 = (_local_8 - 1);
                                    _arg_2 = _local_10;
                                };
                                break;
                            };
                            _local_8++;
                        };
                        _local_10--;
                    };
                    _arg_4 = int((_arg_4 + ((scale / 4) - (_local_11 / 2))));
                    _arg_3 = (_arg_3 - _local_11);
                };
            };
            var _local_7:Number = _arg_1;
            var _local_9:Number = _arg_2;
            var _local_12:Number = getTileHeight(_arg_1, _arg_2);
            if (_arg_5 == "r")
            {
                _local_7 = (_local_7 + ((_arg_3 / (_scale / 2)) - 0.5));
                _local_9 = (_local_9 + 0.5);
                _local_12 = (_local_12 - ((_arg_4 - (_arg_3 / 2)) / (_scale / 2)));
            }
            else
            {
                _local_9 = (_local_9 + ((((_scale / 2) - _arg_3) / (_scale / 2)) - 0.5));
                _local_7 = (_local_7 + 0.5);
                _local_12 = (_local_12 - ((_arg_4 - (((_scale / 2) - _arg_3) / 2)) / (_scale / 2)));
            };
            var _local_6:Vector3d = new Vector3d(_local_7, _local_9, _local_12);
            return (_local_6);
        }

        public function getLocationOldFormat(_arg_1:Number, _arg_2:Number, _arg_3:String):IVector3d
        {
            var _local_6:int;
            var _local_7:int;
            var _local_5:int = 0;
            var _local_4:int = 0;
            _local_7 = Math.ceil(_arg_1);
            _local_5 = (_local_7 - _arg_1);
            var _local_8:int;
            var _local_9:int;
            var _local_12:int;
            var _local_11:int;
            var _local_13:int = 0;
            _local_6 = 0;
            while (_local_6 < _width)
            {
                if (((_local_7 >= 0) && (_local_7 < _SafeStr_1113)))
                {
                    if (getTileHeight(_local_6, _local_7) <= _floorHeight)
                    {
                        _local_8 = (_local_6 - 1);
                        _local_9 = _local_7;
                        _local_4 = _local_6;
                        _arg_3 = "l";
                        break;
                    };
                    if (getTileHeight(_local_6, (_local_7 + 1)) <= _floorHeight)
                    {
                        _local_8 = _local_6;
                        _local_9 = _local_7;
                        _local_4 = (_local_9 - _arg_1);
                        _arg_3 = "r";
                        break;
                    };
                };
                _local_7++;
                _local_6++;
            };
            _local_12 = int(((scale / 2) * _local_5));
            var _local_10:Number = ((-(_local_4) * scale) / 2);
            _local_10 = (_local_10 + ((((-(_arg_2) * 18) / 32) * scale) / 2));
            _local_13 = getTileHeight(_local_8, _local_9);
            _local_11 = int((((_local_13 * scale) / 2) + _local_10));
            if (_arg_3 == "r")
            {
                _local_11 = int((_local_11 + ((_local_5 * scale) / 4)));
            }
            else
            {
                _local_11 = int((_local_11 + (((1 - _local_5) * scale) / 4)));
            };
            return (getLocation(_local_8, _local_9, _local_12, _local_11, _arg_3));
        }

        public function getOldLocation(_arg_1:IVector3d, _arg_2:Number):Array
        {
            if (_arg_1 == null)
            {
                return (null);
            };
            var _local_3:int = 0;
            var _local_4:int = 0;
            var _local_7:Number = 0;
            var _local_5:Number = 0;
            var _local_8:String = "";
            var _local_6:Number = 0;
            if (_arg_2 == 90)
            {
                _local_3 = Math.floor((_arg_1.x - 0.5));
                _local_4 = Math.floor((_arg_1.y + 0.5));
                _local_6 = getTileHeight(_local_3, _local_4);
                _local_7 = ((_scale / 2) - (((_arg_1.y - _local_4) + 0.5) * (_scale / 2)));
                _local_5 = (((_local_6 - _arg_1.z) * (_scale / 2)) + (((_scale / 2) - _local_7) / 2));
                _local_8 = "l";
            }
            else
            {
                if (_arg_2 == 180)
                {
                    _local_3 = Math.floor((_arg_1.x + 0.5));
                    _local_4 = Math.floor((_arg_1.y - 0.5));
                    _local_6 = getTileHeight(_local_3, _local_4);
                    _local_7 = (((_arg_1.x + 0.5) - _local_3) * (_scale / 2));
                    _local_5 = (((_local_6 - _arg_1.z) * (_scale / 2)) + (_local_7 / 2));
                    _local_8 = "r";
                }
                else
                {
                    return (null);
                };
            };
            return ([_local_3, _local_4, _local_7, _local_5, _local_8]);
        }

        public function getOldLocationString(_arg_1:IVector3d, _arg_2:Number):String
        {
            var _local_3:Array = getOldLocation(_arg_1, _arg_2);
            if (_local_3 == null)
            {
                return (null);
            };
            var _local_4:int = _local_3[0];
            var _local_5:int = _local_3[1];
            var _local_9:int = _local_3[2];
            var _local_6:int = _local_3[3];
            var _local_8:String = _local_3[4];
            var _local_7:String = (((((((((":w=" + _local_4) + ",") + _local_5) + " l=") + _local_9) + ",") + _local_6) + " ") + _local_8);
            return (_local_7);
        }

        public function getDirection(_arg_1:String):Number
        {
            if (_arg_1 == "r")
            {
                return (180);
            };
            return (90);
        }

        public function getFloorAltitude(_arg_1:int, _arg_2:int):Number
        {
            var _local_4:int = getTileHeight(_arg_1, _arg_2);
            var _local_3:int = (_local_4 + 1);
            return (_local_4 + (((((((((getTileHeight((_arg_1 - 1), (_arg_2 - 1)) == _local_3) || (getTileHeight(_arg_1, (_arg_2 - 1)) == _local_3)) || (getTileHeight((_arg_1 + 1), (_arg_2 - 1)) == _local_3)) || (getTileHeight((_arg_1 - 1), _arg_2) == _local_3)) || (getTileHeight((_arg_1 + 1), _arg_2) == _local_3)) || (getTileHeight((_arg_1 - 1), (_arg_2 + 1)) == _local_3)) || (getTileHeight(_arg_1, (_arg_2 + 1)) == _local_3)) || (getTileHeight((_arg_1 + 1), (_arg_2 + 1)) == _local_3)) ? 0.5 : 0));
        }

        public function isRoomTile(_arg_1:int, _arg_2:int):Boolean
        {
            return (((((_arg_1 >= 0) && (_arg_1 < _width)) && (_arg_2 >= 0)) && (_arg_2 < _SafeStr_1113)) && (_SafeStr_2076[_arg_2][_arg_1] >= 0));
        }


    }
}

