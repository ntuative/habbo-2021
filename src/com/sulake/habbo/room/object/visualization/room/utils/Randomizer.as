package com.sulake.habbo.room.object.visualization.room.utils
{
    public class Randomizer 
    {

        public static const DEFAULT_SEED:int = 1;
        public static const DEFAULT_MODULUS:int = 0x1000000;

        private static var _SafeStr_3443:Randomizer = null;

        private var _SafeStr_3444:int = 1;
        private var _modulus:int = 0x1000000;
        private var _SafeStr_3445:int = 69069;
        private var _increment:int = 5;


        public static function setSeed(_arg_1:int=1):void
        {
            if (_SafeStr_3443 == null)
            {
                _SafeStr_3443 = new Randomizer();
            };
            _SafeStr_3443.seed = _arg_1;
        }

        public static function setModulus(_arg_1:int=0x1000000):void
        {
            if (_SafeStr_3443 == null)
            {
                _SafeStr_3443 = new Randomizer();
            };
            _SafeStr_3443.modulus = _arg_1;
        }

        public static function getValues(_arg_1:int, _arg_2:int, _arg_3:int):Array
        {
            if (_SafeStr_3443 == null)
            {
                _SafeStr_3443 = new Randomizer();
            };
            return (_SafeStr_3443.getRandomValues(_arg_1, _arg_2, _arg_3));
        }

        public static function getArray(_arg_1:int, _arg_2:int):Array
        {
            if (_SafeStr_3443 == null)
            {
                _SafeStr_3443 = new Randomizer();
            };
            return (_SafeStr_3443.getRandomArray(_arg_1, _arg_2));
        }


        public function set seed(_arg_1:int):void
        {
            _SafeStr_3444 = _arg_1;
        }

        public function set modulus(_arg_1:int):void
        {
            if (_arg_1 < 1)
            {
                _arg_1 = 1;
            };
            _modulus = _arg_1;
        }

        public function dispose():void
        {
        }

        public function getRandomValues(_arg_1:int, _arg_2:int, _arg_3:int):Array
        {
            var _local_4:int;
            var _local_5:Array = [];
            _local_4 = 0;
            while (_local_4 < _arg_1)
            {
                _local_5.push(iterateScaled(_arg_2, (_arg_3 - _arg_2)));
                _local_4++;
            };
            return (_local_5);
        }

        public function getRandomArray(_arg_1:int, _arg_2:int):Array
        {
            var _local_4:int;
            var _local_6:int;
            var _local_5:int;
            if (((_arg_1 > _arg_2) || (_arg_2 > 1000)))
            {
                return (null);
            };
            var _local_3:Array = [];
            _local_4 = 0;
            while (_local_4 <= _arg_2)
            {
                _local_3.push(_local_4);
                _local_4++;
            };
            var _local_7:Array = [];
            _local_6 = 0;
            while (_local_6 < _arg_1)
            {
                _local_5 = iterateScaled(0, (_local_3.length - 1));
                _local_7.push(_local_3[_local_5]);
                _local_3.splice(_local_5, 1);
                _local_6++;
            };
            return (_local_7);
        }

        private function iterate():int
        {
            var _local_1:int = ((_SafeStr_3445 * _SafeStr_3444) + _increment);
            if (_local_1 < 0)
            {
                _local_1 = -(_local_1);
            };
            _local_1 = (_local_1 % _modulus);
            _SafeStr_3444 = _local_1;
            return (_local_1);
        }

        private function iterateScaled(_arg_1:int, _arg_2:int):int
        {
            var _local_3:int = iterate();
            if (_arg_2 < 1)
            {
                return (_arg_1);
            };
            return (int((_arg_1 + ((_local_3 / _modulus) * _arg_2))));
        }


    }
}

