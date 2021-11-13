package com.sulake.habbo.navigator.view.search
{
    public class _SafeStr_205 
    {

        public static const DEFAULT:int = 0;
        public static const OWNER:int = 1;
        public static const ROOMNAME:int = 2;
        public static const TAG:int = 3;
        public static const GROUP:int = 4;
        public static const ANYTHING:int = 5;
        public static const FILTER_PREFIX:Array = ["", "owner:", "roomname:", "tag:", "group:", ""];


        public static function filterInInput(_arg_1:String):int
        {
            var _local_2:int;
            _local_2 = 1;
            while (_local_2 < FILTER_PREFIX.length)
            {
                if (_arg_1.indexOf(FILTER_PREFIX[_local_2]) == 0)
                {
                    return (_local_2);
                };
                _local_2++;
            };
            return (0);
        }


    }
}

