package com.sulake.core.window.utils
{
    import flash.utils.Dictionary;

    public class _SafeStr_168 
    {


        public static function fillTables(_arg_1:Dictionary, _arg_2:Dictionary=null):void
        {
            var _local_3:String;
            _arg_1["default"] = 0;
            _arg_1["active"] = 1;
            _arg_1["focused"] = 2;
            _arg_1["hovering"] = 4;
            _arg_1["selected"] = 8;
            _arg_1["pressed"] = 16;
            _arg_1["disabled"] = 32;
            _arg_1["locked"] = 64;
            if (_arg_2 != null)
            {
                for (_local_3 in _arg_1)
                {
                    _arg_2[_arg_1[_local_3]] = _local_3;
                };
            };
        }


    }
}

