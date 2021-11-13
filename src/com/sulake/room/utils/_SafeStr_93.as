package com.sulake.room.utils
{
    public class _SafeStr_93 
    {


        public static function checkRequiredAttributes(_arg_1:Object, _arg_2:Array):Boolean
        {
            var _local_3:XML;
            var _local_4:XMLList;
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return (false);
            };
            var _local_5:int;
            if ((_arg_1 is XML))
            {
                _local_3 = (_arg_1 as XML);
                _local_5 = 0;
                while (_local_5 < _arg_2.length)
                {
                    if (_local_3.attribute(_arg_2[_local_5]).length() == 0)
                    {
                        return (false);
                    };
                    _local_5++;
                };
            }
            else
            {
                if ((_arg_1 is XMLList))
                {
                    _local_4 = (_arg_1 as XMLList);
                    _local_5 = 0;
                    while (_local_5 < _arg_2.length)
                    {
                        if (_local_3.attribute(_arg_2[_local_5]).length() == 0)
                        {
                            return (false);
                        };
                        _local_5++;
                    };
                }
                else
                {
                    return (false);
                };
            };
            return (true);
        }


    }
}

