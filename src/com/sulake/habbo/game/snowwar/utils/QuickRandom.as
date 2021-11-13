package com.sulake.habbo.game.snowwar.utils
{
    public class QuickRandom 
    {


        public static function iterateSeed(_arg_1:int):int
        {
            var _local_2:int;
            if (_arg_1 == 0)
            {
                _arg_1 = -1;
            };
            _local_2 = (_arg_1 << 13);
            _arg_1 = (_arg_1 ^ _local_2);
            _local_2 = (_arg_1 >> 17);
            _arg_1 = (_arg_1 ^ _local_2);
            _local_2 = (_arg_1 << 5);
            return (_arg_1 ^ _local_2);
        }

        public static function getRandomNumber(_arg_1:int, _arg_2:int):int
        {
            if (_arg_2 == 0)
            {
                return (0);
            };
            return (((_arg_1 < 0) ? (_arg_1 * -1) : _arg_1) % _arg_2);
        }

        protected static function bitPrint(_arg_1:int):String
        {
            var _local_2:int;
            var _local_3:String = "";
            _local_2 = 31;
            while (_local_2 >= 0)
            {
                _local_3 = (_local_3 + (((_arg_1 & (1 << _local_2)) > 0) ? "1" : "0"));
                _local_2--;
            };
            return (_local_3);
        }


    }
}