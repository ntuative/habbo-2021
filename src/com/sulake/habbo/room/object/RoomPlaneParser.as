package com.sulake.habbo.room.object
{
    import com.sulake.core.utils.Map;
    import flash.geom.Point;
    import __AS3__.vec.Vector;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.utils._SafeStr_93;

    public class RoomPlaneParser 
    {

        private static const FLOOR_THICKNESS:Number = 0.25;
        private static const WALL_THICKNESS:Number = 0.25;
        private static const MAX_WALL_ADDITIONAL_HEIGHT:Number = 20;
        public static const _SafeStr_3585:int = -110;
        public static const _SafeStr_3586:int = -100;

        private var _SafeStr_3587:Array = [];
        private var _SafeStr_3588:Array = [];
        private var _tileMapWidth:int = 0;
        private var _tileMapHeight:int = 0;
        private var _minX:int = 0;
        private var _maxX:int = 0;
        private var _minY:int = 0;
        private var _maxY:int = 0;
        private var _SafeStr_3301:Array = [];
        private var _SafeStr_3589:Number = 0;
        private var _wallThicknessMultiplier:Number = 1;
        private var _floorThicknessMultiplier:Number = 1;
        private var _SafeStr_3590:int = -1;
        private var _floorHeight:Number = 0;
        private var _SafeStr_3591:Map = null;
        private var _SafeStr_3592:Array = [];

        public function RoomPlaneParser()
        {
            _SafeStr_3589 = 3.6;
            _wallThicknessMultiplier = 1;
            _floorThicknessMultiplier = 1;
            _SafeStr_3591 = new Map();
        }

        private static function getFloorHeight(_arg_1:Array):Number
        {
            var _local_6:int;
            var _local_4:int;
            var _local_5:int;
            var _local_2:Array;
            var _local_8:int = _arg_1.length;
            var _local_3:int;
            if (_local_8 == 0)
            {
                return (0);
            };
            var _local_7:int = 0;
            _local_5 = 0;
            while (_local_5 < _local_8)
            {
                _local_2 = (_arg_1[_local_5] as Array);
                _local_4 = 0;
                while (_local_4 < _local_2.length)
                {
                    _local_6 = _local_2[_local_4];
                    if (_local_6 > _local_7)
                    {
                        _local_7 = _local_6;
                    };
                    _local_4++;
                };
                _local_5++;
            };
            return (_local_7);
        }

        private static function findEntranceTile(_arg_1:Array):Point
        {
            if (_arg_1 == null)
            {
                return (null);
            };
            var _local_3:int;
            var _local_4:int;
            var _local_2:Array;
            var _local_6:int = _arg_1.length;
            if (_local_6 == 0)
            {
                return (null);
            };
            var _local_5:Array = [];
            _local_4 = 0;
            while (_local_4 < _local_6)
            {
                _local_2 = (_arg_1[_local_4] as Array);
                if (((_local_2 == null) || (_local_2.length == 0)))
                {
                    return (null);
                };
                _local_3 = 0;
                while (_local_3 < _local_2.length)
                {
                    if (_local_2[_local_3] >= 0)
                    {
                        _local_5.push(_local_3);
                        break;
                    };
                    _local_3++;
                };
                if (_local_5.length < (_local_4 + 1))
                {
                    _local_5.push((_local_2.length + 1));
                };
                _local_4++;
            };
            _local_4 = 1;
            while (_local_4 < (_local_5.length - 1))
            {
                if (((_local_5[_local_4] <= (_local_5[(_local_4 - 1)] - 1)) && (_local_5[_local_4] <= (_local_5[(_local_4 + 1)] - 1))))
                {
                    return (new Point(_local_5[_local_4], _local_4));
                };
                _local_4++;
            };
            return (null);
        }

        private static function expandFloorTiles(_arg_1:Vector.<Vector.<int>>):Vector.<Vector.<int>>
        {
            var _local_12:int;
            var _local_13:int;
            var _local_3:int;
            var _local_4:int;
            var _local_6:int;
            var _local_11:int;
            var _local_17:int;
            var _local_14:int;
            var _local_9:int;
            var _local_15:int;
            var _local_10:int;
            var _local_2:int;
            var _local_5:uint = _arg_1.length;
            var _local_16:uint = _arg_1[0].length;
            var _local_7:Vector.<Vector.<int>> = new Vector.<Vector.<int>>((_local_5 * 4));
            _local_13 = 0;
            while (_local_13 < (_local_5 * 4))
            {
                _local_7[_local_13] = new Vector.<int>((_local_16 * 4));
                _local_13++;
            };
            var _local_8:int;
            _local_13 = 0;
            while (_local_13 < _local_5)
            {
                _local_6 = 0;
                _local_12 = 0;
                while (_local_12 < _local_16)
                {
                    _local_11 = _arg_1[_local_13][_local_12];
                    if (((_local_11 < 0) || (_local_11 <= 0xFF)))
                    {
                        _local_4 = 0;
                        while (_local_4 < 4)
                        {
                            _local_3 = 0;
                            while (_local_3 < 4)
                            {
                                _local_7[(_local_8 + _local_4)][(_local_6 + _local_3)] = ((_local_11 < 0) ? _local_11 : (_local_11 * 4));
                                _local_3++;
                            };
                            _local_4++;
                        };
                    }
                    else
                    {
                        _local_17 = ((_local_11 & 0xFF) * 4);
                        _local_14 = (_local_17 + (((_local_11 >> 11) & 0x01) * 3));
                        _local_9 = (_local_17 + (((_local_11 >> 10) & 0x01) * 3));
                        _local_15 = (_local_17 + (((_local_11 >> 9) & 0x01) * 3));
                        _local_10 = (_local_17 + (((_local_11 >> 8) & 0x01) * 3));
                        _local_3 = 0;
                        while (_local_3 < 3)
                        {
                            _local_2 = (_local_3 + 1);
                            _local_7[_local_8][(_local_6 + _local_3)] = (((_local_14 * (3 - _local_3)) + (_local_9 * _local_3)) / 3);
                            _local_7[(_local_8 + 3)][(_local_6 + _local_2)] = (((_local_15 * (3 - _local_2)) + (_local_10 * _local_2)) / 3);
                            _local_7[(_local_8 + _local_2)][_local_6] = (((_local_14 * (3 - _local_2)) + (_local_15 * _local_2)) / 3);
                            _local_7[(_local_8 + _local_3)][(_local_6 + 3)] = (((_local_9 * (3 - _local_3)) + (_local_10 * _local_3)) / 3);
                            _local_3++;
                        };
                        _local_7[(_local_8 + 1)][(_local_6 + 1)] = ((_local_14 > _local_17) ? (_local_17 + 2) : (_local_17 + 1));
                        _local_7[(_local_8 + 1)][(_local_6 + 2)] = ((_local_9 > _local_17) ? (_local_17 + 2) : (_local_17 + 1));
                        _local_7[(_local_8 + 2)][(_local_6 + 1)] = ((_local_15 > _local_17) ? (_local_17 + 2) : (_local_17 + 1));
                        _local_7[(_local_8 + 2)][(_local_6 + 2)] = ((_local_10 > _local_17) ? (_local_17 + 2) : (_local_17 + 1));
                    };
                    _local_6 = (_local_6 + 4);
                    _local_12++;
                };
                _local_8 = (_local_8 + 4);
                _local_13++;
            };
            return (_local_7);
        }

        private static function addTileTypes(_arg_1:Vector.<Vector.<int>>):void
        {
            var _local_14:int;
            var _local_15:int;
            var _local_17:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_11:int;
            var _local_12:int;
            var _local_3:int;
            var _local_2:int;
            var _local_13:int;
            var _local_10:uint = (_arg_1.length - 1);
            var _local_16:uint = (_arg_1[0].length - 1);
            _local_15 = 1;
            while (_local_15 < _local_10)
            {
                _local_14 = 1;
                while (_local_14 < _local_16)
                {
                    _local_17 = _arg_1[_local_15][_local_14];
                    if (_local_17 >= 0)
                    {
                        _local_4 = (_arg_1[(_local_15 - 1)][(_local_14 - 1)] & 0xFF);
                        _local_5 = (_arg_1[(_local_15 - 1)][_local_14] & 0xFF);
                        _local_6 = (_arg_1[(_local_15 - 1)][(_local_14 + 1)] & 0xFF);
                        _local_7 = (_arg_1[_local_15][(_local_14 - 1)] & 0xFF);
                        _local_8 = (_arg_1[_local_15][(_local_14 + 1)] & 0xFF);
                        _local_9 = (_arg_1[(_local_15 + 1)][(_local_14 - 1)] & 0xFF);
                        _local_11 = (_arg_1[(_local_15 + 1)][_local_14] & 0xFF);
                        _local_12 = (_arg_1[(_local_15 + 1)][(_local_14 + 1)] & 0xFF);
                        _local_3 = (_local_17 + 1);
                        _local_2 = (_local_17 - 1);
                        _local_13 = (((((((_local_4 == _local_3) || (_local_5 == _local_3)) || (_local_7 == _local_3)) ? 8 : 0) | ((((_local_6 == _local_3) || (_local_5 == _local_3)) || (_local_8 == _local_3)) ? 4 : 0)) | ((((_local_9 == _local_3) || (_local_11 == _local_3)) || (_local_7 == _local_3)) ? 2 : 0)) | ((((_local_12 == _local_3) || (_local_11 == _local_3)) || (_local_8 == _local_3)) ? 1 : 0));
                        if (_local_13 == 15)
                        {
                            _local_13 = 0;
                        };
                        _arg_1[_local_15][_local_14] = (_local_17 | (_local_13 << 8));
                    };
                    _local_14++;
                };
                _local_15++;
            };
        }

        private static function unpadHeightMap(_arg_1:Vector.<Vector.<int>>):void
        {
            _arg_1.shift();
            _arg_1.pop();
            for each (var _local_2:Vector.<int> in _arg_1)
            {
                _local_2.shift();
                _local_2.pop();
            };
        }

        private static function padHeightMap(_arg_1:Vector.<Vector.<int>>):void
        {
            var _local_2:Vector.<int> = new Vector.<int>(0);
            var _local_3:Vector.<int> = new Vector.<int>(0);
            for each (var _local_5:Vector.<int> in _arg_1)
            {
                _local_5.push(-110);
                _local_5.unshift(-110);
            };
            for each (var _local_4:int in _arg_1[0])
            {
                _local_2.push(-110);
                _local_3.push(-110);
            };
            _arg_1.push(_local_3);
            _arg_1.unshift(_local_2);
        }


        public function get minX():int
        {
            return (_minX);
        }

        public function get maxX():int
        {
            return (_maxX);
        }

        public function get minY():int
        {
            return (_minY);
        }

        public function get maxY():int
        {
            return (_maxY);
        }

        public function get tileMapWidth():int
        {
            return (_tileMapWidth);
        }

        public function get tileMapHeight():int
        {
            return (_tileMapHeight);
        }

        public function get planeCount():int
        {
            return (_SafeStr_3301.length);
        }

        public function get floorHeight():Number
        {
            if (_SafeStr_3590 != -1)
            {
                return (_SafeStr_3590);
            };
            return (_floorHeight);
        }

        public function get wallHeight():Number
        {
            if (_SafeStr_3590 != -1)
            {
                return (_SafeStr_3590 + 3.6);
            };
            return (_SafeStr_3589);
        }

        public function set wallHeight(_arg_1:Number):void
        {
            if (_arg_1 < 0)
            {
                _arg_1 = 0;
            };
            _SafeStr_3589 = _arg_1;
        }

        public function get wallThicknessMultiplier():Number
        {
            return (_wallThicknessMultiplier);
        }

        public function set wallThicknessMultiplier(_arg_1:Number):void
        {
            if (_arg_1 < 0)
            {
                _arg_1 = 0;
            };
            _wallThicknessMultiplier = _arg_1;
        }

        public function get floorThicknessMultiplier():Number
        {
            return (_floorThicknessMultiplier);
        }

        public function set floorThicknessMultiplier(_arg_1:Number):void
        {
            if (_arg_1 < 0)
            {
                _arg_1 = 0;
            };
            _floorThicknessMultiplier = _arg_1;
        }

        public function dispose():void
        {
            _SafeStr_3301 = null;
            _SafeStr_3587 = null;
            _SafeStr_3588 = null;
            _SafeStr_3592 = null;
            if (_SafeStr_3591 != null)
            {
                _SafeStr_3591.dispose();
                _SafeStr_3591 = null;
            };
        }

        public function reset():void
        {
            _SafeStr_3301 = [];
            _SafeStr_3587 = [];
            _SafeStr_3588 = [];
            _SafeStr_3587 = [];
            _SafeStr_3588 = [];
            _tileMapWidth = 0;
            _tileMapHeight = 0;
            _minX = 0;
            _maxX = 0;
            _minY = 0;
            _maxY = 0;
            _floorHeight = 0;
            _SafeStr_3592 = [];
        }

        public function initializeTileMap(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_4:int;
            var _local_7:Array;
            var _local_3:Array;
            var _local_5:Array;
            var _local_6:int;
            if (_arg_1 < 0)
            {
                _arg_1 = 0;
            };
            if (_arg_2 < 0)
            {
                _arg_2 = 0;
            };
            _SafeStr_3587 = [];
            _SafeStr_3588 = [];
            _SafeStr_3592 = [];
            _local_4 = 0;
            while (_local_4 < _arg_2)
            {
                _local_7 = [];
                _local_3 = [];
                _local_5 = [];
                _local_6 = 0;
                while (_local_6 < _arg_1)
                {
                    _local_7[_local_6] = -110;
                    _local_3[_local_6] = -110;
                    _local_5[_local_6] = false;
                    _local_6++;
                };
                _SafeStr_3587.push(_local_7);
                _SafeStr_3588.push(_local_3);
                _SafeStr_3592.push(_local_5);
                _local_4++;
            };
            _tileMapWidth = _arg_1;
            _tileMapHeight = _arg_2;
            _minX = _tileMapWidth;
            _maxX = -1;
            _minY = _tileMapHeight;
            _maxY = -1;
            return (true);
        }

        public function setTileHeight(_arg_1:int, _arg_2:int, _arg_3:Number):Boolean
        {
            var _local_8:Array;
            var _local_5:Boolean;
            var _local_7:int;
            var _local_4:Boolean;
            var _local_6:int;
            if (((((_arg_1 >= 0) && (_arg_1 < _tileMapWidth)) && (_arg_2 >= 0)) && (_arg_2 < _tileMapHeight)))
            {
                _local_8 = (_SafeStr_3587[_arg_2] as Array);
                _local_8[_arg_1] = _arg_3;
                if (_arg_3 >= 0)
                {
                    if (_arg_1 < _minX)
                    {
                        _minX = _arg_1;
                    };
                    if (_arg_1 > _maxX)
                    {
                        _maxX = _arg_1;
                    };
                    if (_arg_2 < _minY)
                    {
                        _minY = _arg_2;
                    };
                    if (_arg_2 > _maxY)
                    {
                        _maxY = _arg_2;
                    };
                }
                else
                {
                    if (((_arg_1 == _minX) || (_arg_1 == _maxX)))
                    {
                        _local_5 = false;
                        _local_7 = _minY;
                        while (_local_7 < _maxY)
                        {
                            if (getTileHeightInternal(_arg_1, _local_7) >= 0)
                            {
                                _local_5 = true;
                                break;
                            };
                            _local_7++;
                        };
                        if (!_local_5)
                        {
                            if (_arg_1 == _minX)
                            {
                                _minX++;
                            };
                            if (_arg_1 == _maxX)
                            {
                                _maxX--;
                            };
                        };
                    };
                    if (((_arg_2 == _minY) || (_arg_2 == _maxY)))
                    {
                        _local_4 = false;
                        _local_6 = _minX;
                        while (_local_6 < _maxX)
                        {
                            if (getTileHeight(_local_6, _arg_2) >= 0)
                            {
                                _local_4 = true;
                                break;
                            };
                            _local_6++;
                        };
                        if (!_local_4)
                        {
                            if (_arg_2 == _minY)
                            {
                                _minY++;
                            };
                            if (_arg_2 == _maxY)
                            {
                                _maxY--;
                            };
                        };
                    };
                };
                return (true);
            };
            return (false);
        }

        public function getTileHeight(_arg_1:int, _arg_2:int):Number
        {
            if (((((_arg_1 < 0) || (_arg_1 >= _tileMapWidth)) || (_arg_2 < 0)) || (_arg_2 >= _tileMapHeight)))
            {
                return (-110);
            };
            var _local_3:Array = (_SafeStr_3587[_arg_2] as Array);
            return (Math.abs((_local_3[_arg_1] as Number)));
        }

        private function getTileHeightOriginal(_arg_1:int, _arg_2:int):Number
        {
            if (((((_arg_1 < 0) || (_arg_1 >= _tileMapWidth)) || (_arg_2 < 0)) || (_arg_2 >= _tileMapHeight)))
            {
                return (-110);
            };
            if (_SafeStr_3592[_arg_2][_arg_1])
            {
                return (-100);
            };
            var _local_3:Array = (_SafeStr_3588[_arg_2] as Array);
            return (_local_3[_arg_1] as Number);
        }

        private function getTileHeightInternal(_arg_1:int, _arg_2:int):Number
        {
            if (((((_arg_1 < 0) || (_arg_1 >= _tileMapWidth)) || (_arg_2 < 0)) || (_arg_2 >= _tileMapHeight)))
            {
                return (-110);
            };
            var _local_3:Array = (_SafeStr_3587[_arg_2] as Array);
            return (_local_3[_arg_1] as Number);
        }

        public function initializeFromTileData(_arg_1:int=-1):Boolean
        {
            var _local_2:int;
            var _local_3:int;
            _SafeStr_3590 = _arg_1;
            _local_3 = 0;
            while (_local_3 < _tileMapHeight)
            {
                _local_2 = 0;
                while (_local_2 < _tileMapWidth)
                {
                    _SafeStr_3588[_local_3][_local_2] = _SafeStr_3587[_local_3][_local_2];
                    _local_2++;
                };
                _local_3++;
            };
            var _local_4:Point = findEntranceTile(_SafeStr_3587);
            _local_3 = 0;
            while (_local_3 < _tileMapHeight)
            {
                _local_2 = 0;
                while (_local_2 < _tileMapWidth)
                {
                    if (_SafeStr_3592[_local_3][_local_2])
                    {
                        setTileHeight(_local_2, _local_3, -100);
                    };
                    _local_2++;
                };
                _local_3++;
            };
            return (initialize(_local_4));
        }

        private function initialize(_arg_1:Point):Boolean
        {
            var _local_5:int;
            if (_arg_1 != null)
            {
                _local_5 = getTileHeight(_arg_1.x, _arg_1.y);
                setTileHeight(_arg_1.x, _arg_1.y, -110);
            };
            _floorHeight = getFloorHeight(_SafeStr_3587);
            createWallPlanes();
            var _local_3:Vector.<Vector.<int>> = new Vector.<Vector.<int>>(0);
            for each (var _local_4:Array in _SafeStr_3587)
            {
                _local_3.push(Vector.<int>(_local_4));
            };
            padHeightMap(_local_3);
            addTileTypes(_local_3);
            unpadHeightMap(_local_3);
            var _local_2:Vector.<Vector.<int>> = expandFloorTiles(_local_3);
            extractPlanes(_local_2);
            if (_arg_1 != null)
            {
                setTileHeight(_arg_1.x, _arg_1.y, _local_5);
                addFloor(new Vector3d((_arg_1.x + 0.5), (_arg_1.y + 0.5), _local_5), new Vector3d(-1, 0, 0), new Vector3d(0, -1, 0), false, false, false, false);
            };
            return (true);
        }

        private function generateWallData(_arg_1:Point, _arg_2:Boolean):RoomWallData
        {
            var _local_3:Boolean;
            var _local_9:Boolean;
            var _local_12:int;
            var _local_11:Point;
            var _local_8:int;
            var _local_4:RoomWallData = new RoomWallData();
            var _local_5:Array = [extractTopWall, extractRightWall, extractBottomWall, extractLeftWall];
            var _local_6:int;
            var _local_10:Point = new Point(_arg_1.x, _arg_1.y);
            var _local_7:int;
            while (_local_7++ < 1000)
            {
                _local_3 = false;
                _local_9 = false;
                _local_12 = _local_6;
                if (((((_local_10.x < minX) || (_local_10.x > maxX)) || (_local_10.y < minY)) || (_local_10.y > maxY)))
                {
                    _local_3 = true;
                };
                _local_11 = _local_5[_local_6](_local_10, _arg_2);
                if (_local_11 == null)
                {
                    return (null);
                };
                _local_8 = (Math.abs((_local_11.x - _local_10.x)) + Math.abs((_local_11.y - _local_10.y)));
                if (((_local_10.x == _local_11.x) || (_local_10.y == _local_11.y)))
                {
                    _local_6 = (((_local_6 - 1) + _local_5.length) % _local_5.length);
                    _local_8 = (_local_8 + 1);
                    _local_9 = true;
                }
                else
                {
                    _local_6 = ((_local_6 + 1) % _local_5.length);
                    _local_8 = (_local_8 - 1);
                };
                _local_4.addWall(_local_10, _local_12, _local_8, _local_3, _local_9);
                if ((((_local_11.x == _arg_1.x) && (_local_11.y == _arg_1.y)) && ((!(_local_11.x == _local_10.x)) || (!(_local_11.y == _local_10.y))))) break;
                _local_10 = _local_11;
            };
            if (_local_4.count == 0)
            {
                return (null);
            };
            return (_local_4);
        }

        private function hidePeninsulaWallChains(_arg_1:RoomWallData):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_8:int;
            var _local_6:Boolean;
            var _local_7:int;
            var _local_5:int;
            var _local_4:int = _arg_1.count;
            while (_local_5 < _local_4)
            {
                _local_2 = _local_5;
                _local_3 = _local_5;
                _local_8 = 0;
                _local_6 = false;
                while (((!(_arg_1.getBorder(_local_5))) && (_local_5 < _local_4)))
                {
                    if (_arg_1.getLeftTurn(_local_5))
                    {
                        _local_8++;
                    }
                    else
                    {
                        if (_local_8 > 0)
                        {
                            _local_8--;
                        };
                    };
                    if (_local_8 > 1)
                    {
                        _local_6 = true;
                    };
                    _local_3 = _local_5;
                    _local_5++;
                };
                if (_local_6)
                {
                    _local_7 = _local_2;
                    while (_local_7 <= _local_3)
                    {
                        _arg_1.setHideWall(_local_7, true);
                        _local_7++;
                    };
                };
                _local_5++;
            };
        }

        private function updateWallsNextToHoles(_arg_1:RoomWallData):void
        {
            var _local_8:int;
            var _local_4:Point;
            var _local_10:int;
            var _local_7:int;
            var _local_5:IVector3d;
            var _local_3:IVector3d;
            var _local_2:int;
            var _local_9:int;
            var _local_6:int = _arg_1.count;
            _local_8 = 0;
            while (_local_8 < _local_6)
            {
                if (!_arg_1.getHideWall(_local_8))
                {
                    _local_4 = _arg_1.getCorner(_local_8);
                    _local_10 = _arg_1.getDirection(_local_8);
                    _local_7 = _arg_1.getLength(_local_8);
                    _local_5 = RoomWallData.WALL_DIRECTION_VECTORS[_local_10];
                    _local_3 = RoomWallData.WALL_NORMAL_VECTORS[_local_10];
                    _local_2 = 0;
                    _local_9 = 0;
                    while (_local_9 < _local_7)
                    {
                        if (getTileHeightInternal(((_local_4.x + (_local_9 * _local_5.x)) - _local_3.x), ((_local_4.y + (_local_9 * _local_5.y)) - _local_3.y)) == -100)
                        {
                            if (((_local_9 > 0) && (_local_2 == 0)))
                            {
                                _arg_1.setLength(_local_8, _local_9);
                                break;
                            };
                            _local_2++;
                        }
                        else
                        {
                            if (_local_2 > 0)
                            {
                                _arg_1.moveCorner(_local_8, _local_2);
                                break;
                            };
                        };
                        _local_9++;
                    };
                    if (_local_2 == _local_7)
                    {
                        _arg_1.setHideWall(_local_8, true);
                    };
                };
                _local_8++;
            };
        }

        private function resolveOriginalWallIndex(_arg_1:Point, _arg_2:Point, _arg_3:RoomWallData):int
        {
            var _local_7:int;
            var _local_14:Point;
            var _local_10:Point;
            var _local_11:int;
            var _local_8:int;
            var _local_15:int;
            var _local_9:int;
            var _local_12:int = Math.min(_arg_1.y, _arg_2.y);
            var _local_4:int = Math.max(_arg_1.y, _arg_2.y);
            var _local_13:int = Math.min(_arg_1.x, _arg_2.x);
            var _local_5:int = Math.max(_arg_1.x, _arg_2.x);
            var _local_6:int = _arg_3.count;
            _local_7 = 0;
            while (_local_7 < _local_6)
            {
                _local_14 = _arg_3.getCorner(_local_7);
                _local_10 = _arg_3.getEndPoint(_local_7);
                if (_arg_1.x == _arg_2.x)
                {
                    if (((_local_14.x == _arg_1.x) && (_local_10.x == _arg_1.x)))
                    {
                        _local_11 = Math.min(_local_14.y, _local_10.y);
                        _local_8 = Math.max(_local_14.y, _local_10.y);
                        if (((_local_11 <= _local_12) && (_local_4 <= _local_8)))
                        {
                            return (_local_7);
                        };
                    };
                }
                else
                {
                    if (_arg_1.y == _arg_2.y)
                    {
                        if (((_local_14.y == _arg_1.y) && (_local_10.y == _arg_1.y)))
                        {
                            _local_15 = Math.min(_local_14.x, _local_10.x);
                            _local_9 = Math.max(_local_14.x, _local_10.x);
                            if (((_local_15 <= _local_13) && (_local_5 <= _local_9)))
                            {
                                return (_local_7);
                            };
                        };
                    };
                };
                _local_7++;
            };
            return (-1);
        }

        private function hideOriginallyHiddenWalls(_arg_1:RoomWallData, _arg_2:RoomWallData):void
        {
            var _local_8:int;
            var _local_6:Point;
            var _local_3:Point;
            var _local_4:IVector3d;
            var _local_7:int;
            var _local_9:int;
            var _local_5:int = _arg_1.count;
            _local_8 = 0;
            while (_local_8 < _local_5)
            {
                if (!_arg_1.getHideWall(_local_8))
                {
                    _local_6 = _arg_1.getCorner(_local_8);
                    _local_3 = new Point(_local_6.x, _local_6.y);
                    _local_4 = RoomWallData.WALL_DIRECTION_VECTORS[_arg_1.getDirection(_local_8)];
                    _local_7 = _arg_1.getLength(_local_8);
                    _local_3.x = (_local_3.x + (_local_4.x * _local_7));
                    _local_3.y = (_local_3.y + (_local_4.y * _local_7));
                    _local_9 = resolveOriginalWallIndex(_local_6, _local_3, _arg_2);
                    if (_local_9 >= 0)
                    {
                        if (_arg_2.getHideWall(_local_9))
                        {
                            _arg_1.setHideWall(_local_8, true);
                        };
                    }
                    else
                    {
                        _arg_1.setHideWall(_local_8, true);
                    };
                };
                _local_8++;
            };
        }

        private function checkWallHiding(_arg_1:RoomWallData, _arg_2:RoomWallData):void
        {
            hidePeninsulaWallChains(_arg_2);
            updateWallsNextToHoles(_arg_1);
            hideOriginallyHiddenWalls(_arg_1, _arg_2);
        }

        private function addWalls(_arg_1:RoomWallData, _arg_2:RoomWallData):void
        {
            var _local_25:int;
            var _local_14:int;
            var _local_17:int;
            var _local_10:Point;
            var _local_13:int;
            var _local_16:int;
            var _local_11:IVector3d;
            var _local_6:IVector3d;
            var _local_20:Number;
            var _local_18:int;
            var _local_27:Number;
            var _local_24:Number;
            var _local_3:Vector3d;
            var _local_4:Number;
            var _local_9:Vector3d;
            var _local_19:Vector3d;
            var _local_12:int;
            var _local_8:Vector3d;
            var _local_21:Boolean;
            var _local_7:Boolean;
            var _local_26:Boolean;
            var _local_5:Boolean;
            var _local_22:Boolean;
            var _local_15:int = _arg_1.count;
            var _local_23:int = _arg_2.count;
            _local_17 = 0;
            while (_local_17 < _local_15)
            {
                if (!_arg_1.getHideWall(_local_17))
                {
                    _local_10 = _arg_1.getCorner(_local_17);
                    _local_13 = _arg_1.getDirection(_local_17);
                    _local_16 = _arg_1.getLength(_local_17);
                    _local_11 = RoomWallData.WALL_DIRECTION_VECTORS[_local_13];
                    _local_6 = RoomWallData.WALL_NORMAL_VECTORS[_local_13];
                    _local_20 = -1;
                    _local_18 = 0;
                    while (_local_18 < _local_16)
                    {
                        _local_27 = getTileHeightInternal(((_local_10.x + (_local_18 * _local_11.x)) + _local_6.x), ((_local_10.y + (_local_18 * _local_11.y)) + _local_6.y));
                        if (((_local_27 >= 0) && ((_local_27 < _local_20) || (_local_20 < 0))))
                        {
                            _local_20 = _local_27;
                        };
                        _local_18++;
                    };
                    _local_24 = _local_20;
                    _local_3 = new Vector3d(_local_10.x, _local_10.y, _local_24);
                    _local_3 = Vector3d.sum(_local_3, Vector3d.product(_local_6, 0.5));
                    _local_3 = Vector3d.sum(_local_3, Vector3d.product(_local_11, -0.5));
                    _local_4 = ((wallHeight + Math.min(20, floorHeight)) - _local_20);
                    _local_9 = Vector3d.product(_local_11, -(_local_16));
                    _local_19 = new Vector3d(0, 0, _local_4);
                    _local_3 = Vector3d.dif(_local_3, _local_9);
                    _local_12 = resolveOriginalWallIndex(_local_10, _arg_1.getEndPoint(_local_17), _arg_2);
                    if (_local_12 >= 0)
                    {
                        _local_25 = _arg_2.getDirection(((_local_12 + 1) % _local_23));
                        _local_14 = _arg_2.getDirection((((_local_12 - 1) + _local_23) % _local_23));
                    }
                    else
                    {
                        _local_25 = _arg_1.getDirection(((_local_17 + 1) % _local_15));
                        _local_14 = _arg_1.getDirection((((_local_17 - 1) + _local_15) % _local_15));
                    };
                    _local_8 = null;
                    if ((((_local_25 - _local_13) + 4) % 4) == 3)
                    {
                        _local_8 = RoomWallData.WALL_NORMAL_VECTORS[_local_25];
                    }
                    else
                    {
                        if ((((_local_13 - _local_14) + 4) % 4) == 3)
                        {
                            _local_8 = RoomWallData.WALL_NORMAL_VECTORS[_local_14];
                        };
                    };
                    _local_21 = _arg_1.getLeftTurn(_local_17);
                    _local_7 = _arg_1.getLeftTurn((((_local_17 - 1) + _local_15) % _local_15));
                    _local_26 = _arg_1.getHideWall(((_local_17 + 1) % _local_15));
                    _local_5 = _arg_1.getManuallyLeftCut(_local_17);
                    _local_22 = _arg_1.getManuallyRightCut(_local_17);
                    addWall(_local_3, _local_9, _local_19, _local_8, ((!(_local_7)) || (_local_5)), ((!(_local_21)) || (_local_22)), (!(_local_26)));
                };
                _local_17++;
            };
        }

        private function createWallPlanes():Boolean
        {
            var _local_3:int;
            var _local_11:int;
            var _local_6:Array = _SafeStr_3587;
            if (_local_6 == null)
            {
                return (false);
            };
            var _local_4:int;
            var _local_5:int;
            var _local_1:Array;
            var _local_14:int = _local_6.length;
            var _local_8:int;
            if (_local_14 == 0)
            {
                return (false);
            };
            _local_4 = 0;
            while (_local_4 < _local_14)
            {
                _local_1 = (_local_6[_local_4] as Array);
                if (((_local_1 == null) || (_local_1.length == 0)))
                {
                    return (false);
                };
                if (_local_8 > 0)
                {
                    _local_8 = Math.min(_local_8, _local_1.length);
                }
                else
                {
                    _local_8 = _local_1.length;
                };
                _local_4++;
            };
            var _local_13:Number = Math.min(20, ((_SafeStr_3590 != -1) ? _SafeStr_3590 : getFloorHeight(_local_6)));
            var _local_9:int = minX;
            var _local_10:int = minY;
            _local_10 = minY;
            while (_local_10 <= maxY)
            {
                if (getTileHeightInternal(_local_9, _local_10) > -100)
                {
                    _local_10--;
                    break;
                };
                _local_10++;
            };
            if (_local_10 > maxY)
            {
                return (false);
            };
            var _local_2:Point = new Point(_local_9, _local_10);
            var _local_7:RoomWallData = generateWallData(_local_2, true);
            var _local_12:RoomWallData = generateWallData(_local_2, false);
            if (_local_7 != null)
            {
                _local_3 = _local_7.count;
                _local_11 = _local_12.count;
                checkWallHiding(_local_7, _local_12);
                addWalls(_local_7, _local_12);
            };
            _local_5 = 0;
            while (_local_5 < tileMapHeight)
            {
                _local_4 = 0;
                while (_local_4 < tileMapWidth)
                {
                    if (getTileHeightInternal(_local_4, _local_5) < 0)
                    {
                        setTileHeight(_local_4, _local_5, -(_local_13 + wallHeight));
                    };
                    _local_4++;
                };
                _local_5++;
            };
            return (true);
        }

        private function extractTopWall(_arg_1:Point, _arg_2:Boolean):Point
        {
            if (_arg_1 == null)
            {
                return (null);
            };
            var _local_3:int = 1;
            var _local_4:int = -100;
            if (!_arg_2)
            {
                _local_4 = -110;
            };
            while (_local_3 < 1000)
            {
                if (getTileHeightInternal((_arg_1.x + _local_3), _arg_1.y) > _local_4)
                {
                    return (new Point(((_arg_1.x + _local_3) - 1), _arg_1.y));
                };
                if (getTileHeightInternal((_arg_1.x + _local_3), (_arg_1.y + 1)) <= _local_4)
                {
                    return (new Point((_arg_1.x + _local_3), (_arg_1.y + 1)));
                };
                _local_3++;
            };
            return (null);
        }

        private function extractRightWall(_arg_1:Point, _arg_2:Boolean):Point
        {
            if (_arg_1 == null)
            {
                return (null);
            };
            var _local_3:int = 1;
            var _local_4:int = -100;
            if (!_arg_2)
            {
                _local_4 = -110;
            };
            while (_local_3 < 1000)
            {
                if (getTileHeightInternal(_arg_1.x, (_arg_1.y + _local_3)) > _local_4)
                {
                    return (new Point(_arg_1.x, (_arg_1.y + (_local_3 - 1))));
                };
                if (getTileHeightInternal((_arg_1.x - 1), (_arg_1.y + _local_3)) <= _local_4)
                {
                    return (new Point((_arg_1.x - 1), (_arg_1.y + _local_3)));
                };
                _local_3++;
            };
            return (null);
        }

        private function extractBottomWall(_arg_1:Point, _arg_2:Boolean):Point
        {
            if (_arg_1 == null)
            {
                return (null);
            };
            var _local_3:int = 1;
            var _local_4:int = -100;
            if (!_arg_2)
            {
                _local_4 = -110;
            };
            while (_local_3 < 1000)
            {
                if (getTileHeightInternal((_arg_1.x - _local_3), _arg_1.y) > _local_4)
                {
                    return (new Point((_arg_1.x - (_local_3 - 1)), _arg_1.y));
                };
                if (getTileHeightInternal((_arg_1.x - _local_3), (_arg_1.y - 1)) <= _local_4)
                {
                    return (new Point((_arg_1.x - _local_3), (_arg_1.y - 1)));
                };
                _local_3++;
            };
            return (null);
        }

        private function extractLeftWall(_arg_1:Point, _arg_2:Boolean):Point
        {
            if (_arg_1 == null)
            {
                return (null);
            };
            var _local_3:int = 1;
            var _local_4:int = -100;
            if (!_arg_2)
            {
                _local_4 = -110;
            };
            while (_local_3 < 1000)
            {
                if (getTileHeightInternal(_arg_1.x, (_arg_1.y - _local_3)) > _local_4)
                {
                    return (new Point(_arg_1.x, (_arg_1.y - (_local_3 - 1))));
                };
                if (getTileHeightInternal((_arg_1.x + 1), (_arg_1.y - _local_3)) <= _local_4)
                {
                    return (new Point((_arg_1.x + 1), (_arg_1.y - _local_3)));
                };
                _local_3++;
            };
            return (null);
        }

        private function addWall(_arg_1:IVector3d, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:IVector3d, _arg_5:Boolean, _arg_6:Boolean, _arg_7:Boolean):void
        {
            var _local_12:Vector3d;
            addPlane(2, _arg_1, _arg_2, _arg_3, [_arg_4]);
            addPlane(3, _arg_1, _arg_2, _arg_3, [_arg_4]);
            var _local_10:Number = (0.25 * _wallThicknessMultiplier);
            var _local_8:Number = (0.25 * _floorThicknessMultiplier);
            var _local_11:Vector3d = Vector3d.crossProduct(_arg_2, _arg_3);
            var _local_9:Vector3d = Vector3d.product(_local_11, ((1 / _local_11.length) * -(_local_10)));
            addPlane(2, Vector3d.sum(_arg_1, _arg_3), _arg_2, _local_9, [_local_11, _arg_4]);
            if (_arg_5)
            {
                addPlane(2, Vector3d.sum(Vector3d.sum(_arg_1, _arg_2), _arg_3), Vector3d.product(_arg_3, (-(_arg_3.length + _local_8) / _arg_3.length)), _local_9, [_local_11, _arg_4]);
            };
            if (_arg_6)
            {
                addPlane(2, Vector3d.sum(_arg_1, Vector3d.product(_arg_3, (-(_local_8) / _arg_3.length))), Vector3d.product(_arg_3, ((_arg_3.length + _local_8) / _arg_3.length)), _local_9, [_local_11, _arg_4]);
                if (_arg_7)
                {
                    _local_12 = Vector3d.product(_arg_2, (_local_10 / _arg_2.length));
                    addPlane(2, Vector3d.sum(Vector3d.sum(_arg_1, _arg_3), Vector3d.product(_local_12, -1)), _local_12, _local_9, [_local_11, _arg_2, _arg_4]);
                };
            };
        }

        private function addFloor(_arg_1:IVector3d, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:Boolean, _arg_5:Boolean, _arg_6:Boolean, _arg_7:Boolean):void
        {
            var _local_10:Number;
            var _local_9:Vector3d;
            var _local_8:Vector3d;
            var _local_11:RoomPlaneData = addPlane(1, _arg_1, _arg_2, _arg_3);
            if (_local_11 != null)
            {
                _local_10 = (0.25 * _floorThicknessMultiplier);
                _local_9 = new Vector3d(0, 0, _local_10);
                _local_8 = Vector3d.dif(_arg_1, _local_9);
                if (_arg_6)
                {
                    addPlane(1, _local_8, _arg_2, _local_9);
                };
                if (_arg_7)
                {
                    addPlane(1, Vector3d.sum(_local_8, Vector3d.sum(_arg_2, _arg_3)), Vector3d.product(_arg_2, -1), _local_9);
                };
                if (_arg_4)
                {
                    addPlane(1, Vector3d.sum(_local_8, _arg_3), Vector3d.product(_arg_3, -1), _local_9);
                };
                if (_arg_5)
                {
                    addPlane(1, Vector3d.sum(_local_8, _arg_2), _arg_3, _local_9);
                };
            };
        }

        public function initializeFromXML(_arg_1:XML):Boolean
        {
            var _local_4:int;
            var _local_13:XML;
            var _local_12:XMLList;
            var _local_3:int;
            var _local_10:XML;
            var _local_16:Number;
            var _local_6:XML;
            var _local_8:XMLList;
            var _local_5:int;
            var _local_7:XML;
            if (_arg_1 == null)
            {
                return (false);
            };
            reset();
            resetFloorHoles();
            if (!_SafeStr_93.checkRequiredAttributes(_arg_1.tileMap[0], ["width", "height", "wallHeight"]))
            {
                return (false);
            };
            var _local_9:int = parseInt(_arg_1.tileMap.@width);
            var _local_15:int = parseInt(_arg_1.tileMap.@height);
            var _local_14:Number = parseFloat(_arg_1.tileMap.@wallHeight);
            var _local_2:int = parseInt(_arg_1.tileMap.@fixedWallsHeight);
            initializeTileMap(_local_9, _local_15);
            var _local_11:XMLList = _arg_1.tileMap.tileRow;
            _local_4 = 0;
            while (_local_4 < _local_11.length())
            {
                _local_13 = _local_11[_local_4];
                _local_12 = _local_13.tile;
                _local_3 = 0;
                while (_local_3 < _local_12.length())
                {
                    _local_10 = _local_12[_local_3];
                    _local_16 = parseFloat(_local_10.@height);
                    setTileHeight(_local_3, _local_4, _local_16);
                    _local_3++;
                };
                _local_4++;
            };
            if (_arg_1.holeMap.length() > 0)
            {
                _local_6 = _arg_1.holeMap[0];
                _local_8 = _local_6.hole;
                _local_5 = 0;
                while (_local_5 < _local_8.length())
                {
                    _local_7 = _local_8[_local_5];
                    if (_SafeStr_93.checkRequiredAttributes(_local_7, ["id", "x", "y", "width", "height"]))
                    {
                        addFloorHole(_local_7.@id, _local_7.@x, _local_7.@y, _local_7.@width, _local_7.@height);
                    };
                    _local_5++;
                };
                initializeHoleMap();
            };
            this.wallHeight = _local_14;
            initializeFromTileData(_local_2);
            return (true);
        }

        private function addPlane(_arg_1:int, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:IVector3d, _arg_5:Array=null):RoomPlaneData
        {
            if (((_arg_3.length == 0) || (_arg_4.length == 0)))
            {
                return (null);
            };
            var _local_6:RoomPlaneData = new RoomPlaneData(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            _SafeStr_3301.push(_local_6);
            return (_local_6);
        }

        public function getXML():XML
        {
            var _local_5:int;
            var _local_1:XML;
            var _local_12:Array;
            var _local_3:int;
            var _local_14:Number;
            var _local_4:XML;
            var _local_7:int;
            var _local_8:RoomFloorHole;
            var _local_13:int;
            var _local_2:XML;
            var _local_9:XML = new XML((((((((("<tileMap width=" + (('"' + _tileMapWidth) + '"')) + " height=") + (('"' + _tileMapHeight) + '"')) + " wallHeight=") + (('"' + _SafeStr_3589) + '"')) + " fixedWallsHeight=") + (('"' + _SafeStr_3590) + '"')) + "/>\r\n\t\t\t"));
            _local_5 = 0;
            while (_local_5 < _tileMapHeight)
            {
                _local_1 = <tileRow/>
				
                ;
                _local_12 = _SafeStr_3588[_local_5];
                _local_3 = 0;
                while (_local_3 < _tileMapWidth)
                {
                    _local_14 = _local_12[_local_3];
                    _local_4 = new XML((("<tile height=" + (('"' + _local_14) + '"')) + "/>\r\n\t\t\t\t\t"));
                    _local_1.appendChild(_local_4);
                    _local_3++;
                };
                _local_9.appendChild(_local_1);
                _local_5++;
            };
            var _local_11:XML = <holeMap/>
			
            ;
            _local_7 = 0;
            while (_local_7 < _SafeStr_3591.length)
            {
                _local_8 = _SafeStr_3591.getWithIndex(_local_7);
                if (_local_8 != null)
                {
                    _local_13 = _SafeStr_3591.getKey(_local_7);
                    _local_2 = new XML((((((((((("<hole id=" + (('"' + _local_13) + '"')) + " x=") + (('"' + _local_8.x) + '"')) + " y=") + (('"' + _local_8.y) + '"')) + " width=") + (('"' + _local_8.width) + '"')) + " height=") + (('"' + _local_8.height) + '"')) + "/>\r\n\t\t\t\t\t"));
                    _local_11.appendChild(_local_2);
                };
                _local_7++;
            };
            var _local_10:XML = <roomData/>
			
            ;
            _local_10.appendChild(_local_9);
            _local_10.appendChild(_local_11);
            var _local_6:XML = new XML((((((((("<dimensions minX=" + (('"' + minX) + '"')) + " maxX=") + (('"' + maxX) + '"')) + " minY=") + (('"' + minY) + '"')) + " maxY=") + (('"' + maxY) + '"')) + " />\r\n\t\t\t"));
            _local_10.appendChild(_local_6);
            return (_local_10);
        }

        public function getPlaneLocation(_arg_1:int):IVector3d
        {
            if (((_arg_1 < 0) || (_arg_1 >= planeCount)))
            {
                return (null);
            };
            var _local_2:RoomPlaneData = (_SafeStr_3301[_arg_1] as RoomPlaneData);
            if (_local_2 != null)
            {
                return (_local_2.loc);
            };
            return (null);
        }

        public function getPlaneNormal(_arg_1:int):IVector3d
        {
            if (((_arg_1 < 0) || (_arg_1 >= planeCount)))
            {
                return (null);
            };
            var _local_2:RoomPlaneData = (_SafeStr_3301[_arg_1] as RoomPlaneData);
            if (_local_2 != null)
            {
                return (_local_2.normal);
            };
            return (null);
        }

        public function getPlaneLeftSide(_arg_1:int):IVector3d
        {
            if (((_arg_1 < 0) || (_arg_1 >= planeCount)))
            {
                return (null);
            };
            var _local_2:RoomPlaneData = (_SafeStr_3301[_arg_1] as RoomPlaneData);
            if (_local_2 != null)
            {
                return (_local_2.leftSide);
            };
            return (null);
        }

        public function getPlaneRightSide(_arg_1:int):IVector3d
        {
            if (((_arg_1 < 0) || (_arg_1 >= planeCount)))
            {
                return (null);
            };
            var _local_2:RoomPlaneData = (_SafeStr_3301[_arg_1] as RoomPlaneData);
            if (_local_2 != null)
            {
                return (_local_2.rightSide);
            };
            return (null);
        }

        public function getPlaneNormalDirection(_arg_1:int):IVector3d
        {
            if (((_arg_1 < 0) || (_arg_1 >= planeCount)))
            {
                return (null);
            };
            var _local_2:RoomPlaneData = (_SafeStr_3301[_arg_1] as RoomPlaneData);
            if (_local_2 != null)
            {
                return (_local_2.normalDirection);
            };
            return (null);
        }

        public function getPlaneSecondaryNormals(_arg_1:int):Array
        {
            var _local_3:Array;
            var _local_4:int;
            if (((_arg_1 < 0) || (_arg_1 >= planeCount)))
            {
                return (null);
            };
            var _local_2:RoomPlaneData = (_SafeStr_3301[_arg_1] as RoomPlaneData);
            if (_local_2 != null)
            {
                _local_3 = [];
                _local_4 = 0;
                while (_local_4 < _local_2.secondaryNormalCount)
                {
                    _local_3.push(_local_2.getSecondaryNormal(_local_4));
                    _local_4++;
                };
                return (_local_3);
            };
            return (null);
        }

        public function getPlaneType(_arg_1:int):int
        {
            if (((_arg_1 < 0) || (_arg_1 >= planeCount)))
            {
                return (0);
            };
            var _local_2:RoomPlaneData = (_SafeStr_3301[_arg_1] as RoomPlaneData);
            if (_local_2 != null)
            {
                return (_local_2.type);
            };
            return (0);
        }

        public function getPlaneMaskCount(_arg_1:int):int
        {
            if (((_arg_1 < 0) || (_arg_1 >= planeCount)))
            {
                return (0);
            };
            var _local_2:RoomPlaneData = (_SafeStr_3301[_arg_1] as RoomPlaneData);
            if (_local_2 != null)
            {
                return (_local_2.maskCount);
            };
            return (0);
        }

        public function getPlaneMaskLeftSideLoc(_arg_1:int, _arg_2:int):Number
        {
            if (((_arg_1 < 0) || (_arg_1 >= planeCount)))
            {
                return (-1);
            };
            var _local_3:RoomPlaneData = (_SafeStr_3301[_arg_1] as RoomPlaneData);
            if (_local_3 != null)
            {
                return (_local_3.getMaskLeftSideLoc(_arg_2));
            };
            return (-1);
        }

        public function getPlaneMaskRightSideLoc(_arg_1:int, _arg_2:int):Number
        {
            if (((_arg_1 < 0) || (_arg_1 >= planeCount)))
            {
                return (-1);
            };
            var _local_3:RoomPlaneData = (_SafeStr_3301[_arg_1] as RoomPlaneData);
            if (_local_3 != null)
            {
                return (_local_3.getMaskRightSideLoc(_arg_2));
            };
            return (-1);
        }

        public function getPlaneMaskLeftSideLength(_arg_1:int, _arg_2:int):Number
        {
            if (((_arg_1 < 0) || (_arg_1 >= planeCount)))
            {
                return (-1);
            };
            var _local_3:RoomPlaneData = (_SafeStr_3301[_arg_1] as RoomPlaneData);
            if (_local_3 != null)
            {
                return (_local_3.getMaskLeftSideLength(_arg_2));
            };
            return (-1);
        }

        public function getPlaneMaskRightSideLength(_arg_1:int, _arg_2:int):Number
        {
            if (((_arg_1 < 0) || (_arg_1 >= planeCount)))
            {
                return (-1);
            };
            var _local_3:RoomPlaneData = (_SafeStr_3301[_arg_1] as RoomPlaneData);
            if (_local_3 != null)
            {
                return (_local_3.getMaskRightSideLength(_arg_2));
            };
            return (-1);
        }

        public function addFloorHole(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int):void
        {
            removeFloorHole(_arg_1);
            var _local_6:RoomFloorHole = new RoomFloorHole(_arg_2, _arg_3, _arg_4, _arg_5);
            _SafeStr_3591.add(_arg_1, _local_6);
        }

        public function removeFloorHole(_arg_1:int):void
        {
            _SafeStr_3591.remove(_arg_1);
        }

        public function resetFloorHoles():void
        {
            _SafeStr_3591.reset();
        }

        private function initializeHoleMap():void
        {
            var _local_5:int;
            var _local_6:int;
            var _local_8:Array;
            var _local_7:int;
            var _local_1:RoomFloorHole;
            var _local_3:int;
            var _local_9:int;
            var _local_2:int;
            var _local_4:int;
            _local_6 = 0;
            while (_local_6 < _tileMapHeight)
            {
                _local_8 = _SafeStr_3592[_local_6];
                _local_5 = 0;
                while (_local_5 < _tileMapWidth)
                {
                    _local_8[_local_5] = false;
                    _local_5++;
                };
                _local_6++;
            };
            _local_7 = 0;
            while (_local_7 < _SafeStr_3591.length)
            {
                _local_1 = _SafeStr_3591.getWithIndex(_local_7);
                if (_local_1 != null)
                {
                    _local_3 = _local_1.x;
                    _local_9 = ((_local_1.x + _local_1.width) - 1);
                    _local_2 = _local_1.y;
                    _local_4 = ((_local_1.y + _local_1.height) - 1);
                    _local_3 = ((_local_3 < 0) ? 0 : _local_3);
                    _local_9 = ((_local_9 >= _tileMapWidth) ? (_tileMapWidth - 1) : _local_9);
                    _local_2 = ((_local_2 < 0) ? 0 : _local_2);
                    _local_4 = ((_local_4 >= _tileMapHeight) ? (_tileMapHeight - 1) : _local_4);
                    _local_6 = _local_2;
                    while (_local_6 <= _local_4)
                    {
                        _local_8 = _SafeStr_3592[_local_6];
                        _local_5 = _local_3;
                        while (_local_5 <= _local_9)
                        {
                            _local_8[_local_5] = true;
                            _local_5++;
                        };
                        _local_6++;
                    };
                };
                _local_7++;
            };
        }

        private function extractPlanes(_arg_1:Vector.<Vector.<int>>):void
        {
            var _local_3:int;
            var _local_17:int;
            var _local_18:int;
            var _local_6:int;
            var _local_12:int;
            var _local_8:int;
            var _local_9:Boolean;
            var _local_4:Boolean;
            var _local_14:Boolean;
            var _local_20:Boolean;
            var _local_15:int;
            var _local_16:int;
            var _local_13:Boolean;
            var _local_7:Number;
            var _local_10:Number;
            var _local_11:Number;
            var _local_21:Number;
            var _local_5:uint = _arg_1.length;
            var _local_19:uint = _arg_1[0].length;
            var _local_2:Vector.<Vector.<Boolean>> = new Vector.<Vector.<Boolean>>(_local_5);
            _local_3 = 0;
            while (_local_3 < _local_5)
            {
                _local_2[_local_3] = new Vector.<Boolean>(_local_19);
                _local_3++;
            };
            _local_17 = 0;
            while (_local_17 < _local_5)
            {
                _local_18 = 0;
                while (_local_18 < _local_19)
                {
                    _local_6 = _arg_1[_local_17][_local_18];
                    if (!((_local_6 < 0) || (_local_2[_local_17][_local_18])))
                    {
                        _local_9 = ((_local_18 == 0) || (!(_arg_1[_local_17][(_local_18 - 1)] == _local_6)));
                        _local_4 = ((_local_17 == 0) || (!(_arg_1[(_local_17 - 1)][_local_18] == _local_6)));
                        _local_12 = (_local_18 + 1);
                        while (_local_12 < _local_19)
                        {
                            if ((((!(_arg_1[_local_17][_local_12] == _local_6)) || (_local_2[_local_17][_local_12])) || ((_local_17 > 0) && ((_arg_1[(_local_17 - 1)][_local_12] == _local_6) == _local_4)))) break;
                            _local_12++;
                        };
                        _local_14 = ((_local_12 == _local_19) || (!(_arg_1[_local_17][_local_12] == _local_6)));
                        _local_13 = false;
                        _local_8 = (_local_17 + 1);
                        while (((_local_8 < _local_5) && (!(_local_13))))
                        {
                            _local_20 = (!(_arg_1[_local_8][_local_18] == _local_6));
                            _local_13 = (((_local_20) || ((_local_18 > 0) && ((_arg_1[_local_8][(_local_18 - 1)] == _local_6) == _local_9))) || ((_local_12 < _local_19) && ((_arg_1[_local_8][_local_12] == _local_6) == _local_14)));
                            _local_15 = _local_18;
                            while (_local_15 < _local_12)
                            {
                                if ((_arg_1[_local_8][_local_15] == _local_6) == _local_20)
                                {
                                    _local_13 = true;
                                    _local_12 = _local_15;
                                    break;
                                };
                                _local_15++;
                            };
                            if (_local_13) break;
                            _local_8++;
                        };
                        if (!_local_20)
                        {
                            _local_20 = (_local_8 == _local_5);
                        };
                        _local_14 = ((_local_12 == _local_19) || (!(_arg_1[_local_17][_local_12] == _local_6)));
                        _local_16 = _local_17;
                        while (_local_16 < _local_8)
                        {
                            _local_15 = _local_18;
                            while (_local_15 < _local_12)
                            {
                                _local_2[_local_16][_local_15] = true;
                                _local_15++;
                            };
                            _local_16++;
                        };
                        _local_7 = ((_local_18 / 4) - 0.5);
                        _local_10 = ((_local_17 / 4) - 0.5);
                        _local_11 = ((_local_12 - _local_18) / 4);
                        _local_21 = ((_local_8 - _local_17) / 4);
                        addFloor(new Vector3d((_local_7 + _local_11), (_local_10 + _local_21), (_local_6 / 4)), new Vector3d(-(_local_11), 0, 0), new Vector3d(0, -(_local_21), 0), _local_14, _local_9, _local_20, _local_4);
                    };
                    _local_18++;
                };
                _local_17++;
            };
        }


    }
}

