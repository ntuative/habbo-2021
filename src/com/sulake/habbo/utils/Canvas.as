package com.sulake.habbo.utils
{
    import flash.display.BitmapData;
    import flash.geom.Point;
    import __AS3__.vec.Vector;

    public class Canvas extends BitmapData
    {

        public function Canvas(_arg_1:int, _arg_2:int, _arg_3:Boolean=true, _arg_4:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        private static function sortByVerticalPosition(_arg_1:Point, _arg_2:Point):int
        {
            if (_arg_1.y > _arg_2.y)
            {
                return (1);
            };
            if (_arg_1.y < _arg_2.y)
            {
                return (-1);
            };
            return (0);
        }

        private static function sampleLeftWallTexture(_arg_1:BitmapData, _arg_2:Point, _arg_3:int, _arg_4:int, _arg_5:uint):uint
        {
            var _local_6:int;
            var _local_7:int;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:uint;
            if (_arg_1)
            {
                _local_6 = (_arg_3 - _arg_2.x);
                _local_7 = (_arg_4 - _arg_2.y);
                _local_8 = (_local_6 % _arg_1.width);
                _local_9 = ((_local_7 + (_local_6 / 2)) % _arg_1.height);
                _local_10 = _arg_1.getPixel32(_local_8, _local_9);
                return (colorize(_local_10, _arg_5));
            };
            return (_arg_5);
        }

        private static function sampleRightWallTexture(_arg_1:BitmapData, _arg_2:Point, _arg_3:int, _arg_4:int, _arg_5:uint):uint
        {
            var _local_6:int;
            var _local_7:int;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:uint;
            if (_arg_1)
            {
                _local_6 = (_arg_3 - _arg_2.x);
                _local_7 = (_arg_4 - _arg_2.y);
                _local_8 = (_local_6 % _arg_1.width);
                _local_9 = ((_local_7 - (_local_6 / 2)) % _arg_1.height);
                _local_10 = _arg_1.getPixel32(_local_8, _local_9);
                return (colorize(_local_10, _arg_5));
            };
            return (_arg_5);
        }

        private static function sampleFloorTexture(_arg_1:BitmapData, _arg_2:Point, _arg_3:int, _arg_4:int, _arg_5:uint):uint
        {
            var _local_6:int;
            var _local_7:int;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:uint;
            if (_arg_1)
            {
                _local_6 = (_arg_3 - _arg_2.x);
                _local_7 = (_arg_4 - _arg_2.y);
                _local_8 = ((_local_7 + (_local_6 / 2)) % _arg_1.width);
                _local_9 = ((_local_7 - (_local_6 / 2)) % _arg_1.height);
                _local_10 = _arg_1.getPixel32(_local_8, _local_9);
                return (colorize(_local_10, _arg_5));
            };
            return (_arg_5);
        }

        public static function colorize(_arg_1:uint, _arg_2:uint):uint
        {
            if (_arg_2 == 0xFFFFFFFF)
            {
                return (_arg_1);
            };
            var _local_3:uint = ((_arg_2 >> 16) & 0xFF);
            var _local_5:uint = ((_arg_2 >> 8) & 0xFF);
            var _local_4:uint = (_arg_2 & 0xFF);
            _local_3 = uint(((((_arg_1 >> 16) & 0xFF) * _local_3) / 0xFF));
            _local_5 = uint(((((_arg_1 >> 8) & 0xFF) * _local_5) / 0xFF));
            _local_4 = uint((((_arg_1 & 0xFF) * _local_4) / 0xFF));
            return (((((_arg_1) && (0xFF000000)) | (_local_3 << 16)) | (_local_5 << 8)) | _local_4);
        }

        public static function averageColor(_arg_1:BitmapData):uint
        {
            var _local_6:int;
            var _local_7:int;
            var _local_8:uint;
            if (_arg_1 == null)
            {
                return (0xFFFFFF);
            };
            var _local_2:Number = 0;
            var _local_4:Number = 0;
            var _local_5:Number = 0;
            var _local_3:int;
            _local_6 = 0;
            while (_local_6 < _arg_1.width)
            {
                _local_7 = 0;
                while (_local_7 < _arg_1.height)
                {
                    _local_8 = _arg_1.getPixel32(_local_6, _local_7);
                    if (((_local_8 >> 24) & 0xFF) > 0)
                    {
                        _local_2 = (_local_2 + ((_local_8 >> 16) & 0xFF));
                        _local_4 = (_local_4 + ((_local_8 >> 8) & 0xFF));
                        _local_5 = (_local_5 + (_local_8 & 0xFF));
                        _local_3++;
                    };
                    _local_7++;
                };
                _local_6++;
            };
            if (_local_3 == 0)
            {
                return (0xFFFFFF);
            };
            _local_2 = (_local_2 / _local_3);
            _local_4 = (_local_4 / _local_3);
            _local_5 = (_local_5 / _local_3);
            return (((_local_2 << 16) | (_local_4 << 8)) | _local_5);
        }


        public function drawQuad(_arg_1:Vector.<Point>, _arg_2:BitmapData, _arg_3:uint=0xFFFFFFFF):void
        {
            var _local_4:Point;
            var _local_5:Function;
            if (_arg_1.length != 4)
            {
                return;
            };
            if (_arg_1[1].x == _arg_1[3].x)
            {
                _local_4 = _arg_1[3];
                if (_arg_1[0].y < _arg_1[1].y)
                {
                    _local_5 = sampleLeftWallTexture;
                }
                else
                {
                    _local_5 = sampleRightWallTexture;
                };
            }
            else
            {
                _local_4 = _arg_1[3];
                _local_5 = sampleFloorTexture;
            };
            fillTriangle(_arg_1.slice(0, 3), _arg_2, _local_4, _local_5, _arg_3);
            fillTriangle(_arg_1.slice(1, 4), _arg_2, _local_4, _local_5, _arg_3);
        }

        public function fillTriangle(_arg_1:Vector.<Point>, _arg_2:BitmapData, _arg_3:Point, _arg_4:Function, _arg_5:uint):void
        {
            if (_arg_1.length != 3)
            {
                return;
            };
            var _local_12:Vector.<Point> = _arg_1.concat();
            _local_12.sort(sortByVerticalPosition);
            var _local_6:Point = new Point((_local_12[1].x - _local_12[0].x), (_local_12[1].y - _local_12[0].y));
            var _local_7:Point = new Point((_local_12[2].x - _local_12[0].x), (_local_12[2].y - _local_12[0].y));
            var _local_8:Point = new Point((_local_12[2].x - _local_12[1].x), (_local_12[2].y - _local_12[1].y));
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            if (((!(_local_6.y == 0)) && (!(_local_7.y == 0))))
            {
                _local_9 = 0;
                while (_local_9 < _local_6.y)
                {
                    _local_10 = int((_local_12[0].x + ((_local_6.x / _local_6.y) * _local_9)));
                    _local_11 = int((_local_12[0].x + ((_local_7.x / _local_7.y) * _local_9)));
                    drawHorizontalLine(_local_10, _local_11, (_local_12[0].y + _local_9), _arg_2, _arg_3, _arg_4, _arg_5);
                    _local_9++;
                };
            };
            if (((!(_local_7.y == 0)) && (!(_local_8.y == 0))))
            {
                _local_9 = 0;
                while (_local_9 < _local_8.y)
                {
                    _local_10 = int((_local_12[1].x + ((_local_8.x / _local_8.y) * _local_9)));
                    _local_11 = (_local_12[0].x + ((_local_7.x / _local_7.y) * (_local_6.y + _local_9)));
                    drawHorizontalLine(_local_10, _local_11, (_local_12[1].y + _local_9), _arg_2, _arg_3, _arg_4, _arg_5);
                    _local_9++;
                };
            };
        }

        private function drawHorizontalLine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:BitmapData, _arg_5:Point, _arg_6:Function, _arg_7:uint):void
        {
            var _local_8:int;
            if (_arg_1 < _arg_2)
            {
                _local_8 = _arg_1;
                while (_local_8 < _arg_2)
                {
                    setPixel(_local_8, _arg_3, _arg_6(_arg_4, _arg_5, _local_8, _arg_3, _arg_7));
                    _local_8++;
                };
            }
            else
            {
                _local_8 = _arg_2;
                while (_local_8 < _arg_1)
                {
                    setPixel(_local_8, _arg_3, _arg_6(_arg_4, _arg_5, _local_8, _arg_3, _arg_7));
                    _local_8++;
                };
            };
        }


    }
}
