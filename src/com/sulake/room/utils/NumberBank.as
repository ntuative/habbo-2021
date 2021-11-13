package com.sulake.room.utils
{
    public class NumberBank 
    {

        private var _SafeStr_3316:int = 0;
        private var _reservedNumbers:Array = [];
        private var _freeNumbers:Array = [];

        public function NumberBank(_arg_1:int)
        {
            var _local_2:int;
            super();
            if (_arg_1 < 0)
            {
                _arg_1 = 0;
            };
            _local_2 = 0;
            while (_local_2 < _arg_1)
            {
                _freeNumbers.push(_local_2);
                _local_2++;
            };
        }

        public function dispose():void
        {
            _reservedNumbers = null;
            _freeNumbers = null;
            _SafeStr_3316 = 0;
        }

        public function reserveNumber():int
        {
            var _local_1:int;
            if (_freeNumbers.length > 0)
            {
                _local_1 = (_freeNumbers.pop() as int);
                _reservedNumbers.push(_local_1);
                return (_local_1);
            };
            return (-1);
        }

        public function freeNumber(_arg_1:int):void
        {
            var _local_2:int = _reservedNumbers.indexOf(_arg_1);
            if (_local_2 >= 0)
            {
                _reservedNumbers.splice(_local_2, 1);
                _freeNumbers.push(_arg_1);
            };
        }


    }
}

