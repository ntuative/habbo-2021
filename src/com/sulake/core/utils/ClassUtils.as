package com.sulake.core.utils
{
    import flash.utils.describeType;
    import flash.utils.getQualifiedClassName;

    public class ClassUtils 
    {


        public static function implementsInterface(_arg_1:Class, _arg_2:Class):Boolean
        {
            return (describeType(_arg_1).factory.implementsInterface.(@type == getQualifiedClassName(_arg_2)).length() > 0);
        }

        public static function getSimpleQualifiedClassName(_arg_1:*):String
        {
            var _local_3:String = getQualifiedClassName(_arg_1);
            var _local_2:int = _local_3.indexOf("::");
            if (_local_2 > 0)
            {
                return (_local_3.substr((_local_2 + 2), _local_3.length));
            };
            return (_local_3);
        }


    }
}