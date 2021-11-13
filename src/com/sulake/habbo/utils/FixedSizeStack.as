package com.sulake.habbo.utils
{
    public class FixedSizeStack 
    {

        private var _SafeStr_690:Array = [];
        private var _SafeStr_4356:int = 0;
        private var _index:int = 0;

        public function FixedSizeStack(_arg_1:int)
        {
            _SafeStr_4356 = _arg_1;
        }

        public function reset():void
        {
            _SafeStr_690 = [];
            _index = 0;
        }

        public function addValue(_arg_1:int):void
        {
            if (_SafeStr_690.length < _SafeStr_4356)
            {
                _SafeStr_690.push(_arg_1);
            }
            else
            {
                _SafeStr_690[_index] = _arg_1;
            };
            _index = ((_index + 1) % _SafeStr_4356);
        }

        public function getMax():int
        {
            var _local_1:int;
            var _local_2:int = -2147483648;
            _local_1 = 0;
            while (_local_1 < _SafeStr_4356)
            {
                if (_SafeStr_690[_local_1] > _local_2)
                {
                    _local_2 = _SafeStr_690[_local_1];
                };
                _local_1++;
            };
            return (_local_2);
        }

        public function getMin():int
        {
            var _local_1:int;
            var _local_2:int = 2147483647;
            _local_1 = 0;
            while (_local_1 < _SafeStr_4356)
            {
                if (_SafeStr_690[_local_1] < _local_2)
                {
                    _local_2 = _SafeStr_690[_local_1];
                };
                _local_1++;
            };
            return (_local_2);
        }


    }
}

