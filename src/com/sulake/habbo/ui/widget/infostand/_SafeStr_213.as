package com.sulake.habbo.ui.widget.infostand
{
    public class _SafeStr_213 
    {


        public static function formatSeconds(_arg_1:Number):String
        {
            var _local_3:uint = Math.floor(_arg_1);
            var _local_4:uint = uint(Math.floor((_local_3 / 3600)));
            var _local_7:int = (_local_4 * 3600);
            var _local_6:uint = uint(((_local_3 - _local_7) / 60));
            var _local_5:uint = ((_local_3 - _local_7) - (_local_6 * 60));
            var _local_8:String = (_local_4 + ":");
            var _local_9:String = ((((_local_6 < 10) ? "0" : "") + _local_6) + ":");
            var _local_2:String = (((_local_5 < 10) ? "0" : "") + _local_5);
            return ((_local_8 + _local_9) + _local_2);
        }


    }
}

