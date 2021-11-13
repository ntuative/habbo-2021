package com.codeazur.as3swf.tags
{
    import com.codeazur.utils.StringUtils;

    public class _SafeStr_64 
    {


        public static function toStringCommon(_arg_1:uint, _arg_2:String, _arg_3:uint=0):String
        {
            return (((((StringUtils.repeat(_arg_3) + "[") + StringUtils.printf("%02d", _arg_1)) + ":") + _arg_2) + "] ");
        }


    }
}

