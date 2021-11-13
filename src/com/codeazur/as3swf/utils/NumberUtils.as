package com.codeazur.as3swf.utils
{
    public class NumberUtils 
    {


        public static function roundPixels20(_arg_1:Number):Number
        {
            return (Math.round((_arg_1 * 100)) / 100);
        }

        public static function roundPixels400(_arg_1:Number):Number
        {
            return (Math.round((_arg_1 * 10000)) / 10000);
        }


    }
}