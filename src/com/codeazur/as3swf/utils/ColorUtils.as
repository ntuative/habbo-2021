package com.codeazur.as3swf.utils
{
    import com.codeazur.utils.StringUtils;

    public class ColorUtils 
    {


        public static function alpha(_arg_1:uint):Number
        {
            return ((_arg_1 >>> 24) / 0xFF);
        }

        public static function rgb(_arg_1:uint):uint
        {
            return (_arg_1 & 0xFFFFFF);
        }

        public static function r(_arg_1:uint):Number
        {
            return (((rgb(_arg_1) >> 16) & 0xFF) / 0xFF);
        }

        public static function g(_arg_1:uint):Number
        {
            return (((rgb(_arg_1) >> 8) & 0xFF) / 0xFF);
        }

        public static function b(_arg_1:uint):Number
        {
            return ((rgb(_arg_1) & 0xFF) / 0xFF);
        }

        public static function interpolate(_arg_1:uint, _arg_2:uint, _arg_3:Number):uint
        {
            var _local_9:Number = r(_arg_1);
            var _local_8:Number = g(_arg_1);
            var _local_10:Number = b(_arg_1);
            var _local_11:Number = alpha(_arg_1);
            var _local_5:uint = ((_local_9 + ((r(_arg_2) - _local_9) * _arg_3)) * 0xFF);
            var _local_4:uint = ((_local_8 + ((g(_arg_2) - _local_8) * _arg_3)) * 0xFF);
            var _local_6:uint = ((_local_10 + ((b(_arg_2) - _local_10) * _arg_3)) * 0xFF);
            var _local_7:uint = ((_local_11 + ((alpha(_arg_2) - _local_11) * _arg_3)) * 0xFF);
            return (((_local_6 | (_local_4 << 8)) | (_local_5 << 16)) | (_local_7 << 24));
        }

        public static function rgbToString(_arg_1:uint):String
        {
            return (StringUtils.printf("#%06x", (_arg_1 & 0xFFFFFF)));
        }

        public static function rgbaToString(_arg_1:uint):String
        {
            return (StringUtils.printf("#%06x(%02x)", (_arg_1 & 0xFFFFFF), (_arg_1 >>> 24)));
        }

        public static function argbToString(_arg_1:uint):String
        {
            return (StringUtils.printf("#(%02x)%06x", (_arg_1 >>> 24), (_arg_1 & 0xFFFFFF)));
        }


    }
}