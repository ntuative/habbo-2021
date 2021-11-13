package com.sulake.habbo.quest.seasonalcalendar
{
    import com.sulake.core.runtime.IDisposable;
    import __AS3__.vec.Vector;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import flash.geom.Point;

    public class CalendarBackgroundRenderer implements IDisposable 
    {

        private var _SafeStr_1274:Vector.<BitmapData>;
        private var _disposed:Boolean;


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                _SafeStr_1274 = null;
            };
        }

        public function initializeImageChain(_arg_1:Vector.<BitmapData>):void
        {
            _SafeStr_1274 = _arg_1;
        }

        public function getSlice(_arg_1:int, _arg_2:int):BitmapData
        {
            var _local_5:int;
            var _local_7:int;
            var _local_6:BitmapData;
            var _local_4:int;
            if ((((_disposed) || (_SafeStr_1274 == null)) || (_SafeStr_1274.length == 0)))
            {
                return (new BitmapData(1, 1));
            };
            var _local_8:BitmapData = new BitmapData(_arg_2, _SafeStr_1274[0].height, false, 0);
            var _local_3:int;
            while (_local_3 < _arg_2)
            {
                _local_5 = (_arg_1 + _local_3);
                _local_7 = getImageIndexForOffset(_local_5);
                if (_local_7 < 0)
                {
                    _local_3 = (_local_3 + -(_arg_1));
                    if (_arg_1 >= 0)
                    {
                        return (new BitmapData(1, 1));
                    };
                }
                else
                {
                    _local_6 = _SafeStr_1274[_local_7];
                    _local_4 = getRelativeXForOffset(_local_5);
                    if (_local_6.width > ((_local_4 + _arg_2) - _local_3))
                    {
                        _local_8.copyPixels(_local_6, new Rectangle(_local_4, 0, (_arg_2 - _local_3), _local_6.height), new Point(_local_3, 0));
                        _local_3 = (_local_3 + (_arg_2 - _local_3));
                    }
                    else
                    {
                        _local_8.copyPixels(_local_6, new Rectangle(_local_4, 0, (_local_6.width - _local_4), _local_6.height), new Point(_local_3, 0));
                        _local_3 = (_local_3 + (_local_6.width - _local_4));
                    };
                };
            };
            return (_local_8);
        }

        public function getImageIndexForOffset(_arg_1:int):int
        {
            var _local_3:int;
            var _local_2:int;
            _local_3 = 0;
            while (_local_3 < _SafeStr_1274.length)
            {
                if (((_local_2 <= _arg_1) && (_arg_1 < (_local_2 + _SafeStr_1274[_local_3].width))))
                {
                    return (_local_3);
                };
                _local_2 = (_local_2 + _SafeStr_1274[_local_3].width);
                _local_3++;
            };
            return (-1);
        }

        private function getRelativeXForOffset(_arg_1:int):int
        {
            var _local_3:int;
            var _local_2:int;
            _local_3 = 0;
            while (_local_3 < _SafeStr_1274.length)
            {
                if (((_local_2 <= _arg_1) && (_arg_1 < (_local_2 + _SafeStr_1274[_local_3].width))))
                {
                    return (_arg_1 - _local_2);
                };
                _local_2 = (_local_2 + _SafeStr_1274[_local_3].width);
                _local_3++;
            };
            return (-1);
        }


    }
}

