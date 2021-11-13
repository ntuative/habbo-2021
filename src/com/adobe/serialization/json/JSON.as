package com.adobe.serialization.json
{
    public final class JSON
    {


        public static function encode(_arg_1:Object):String
        {
            return (new JSONEncoder(_arg_1).getString());
        }

        public static function decode(_arg_1:String, _arg_2:Boolean=true):*
        {
            return (new JSONDecoder(_arg_1, _arg_2).getValue());
        }


    }
}
