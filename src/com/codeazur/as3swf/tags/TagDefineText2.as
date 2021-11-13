package com.codeazur.as3swf.tags
{
    import com.codeazur.utils.StringUtils;

    public class TagDefineText2 extends TagDefineText implements IDefinitionTag 
    {

        public static const TYPE:uint = 33;


        override public function get type():uint
        {
            return (33);
        }

        override public function get name():String
        {
            return ("DefineText2");
        }

        override public function get version():uint
        {
            return (3);
        }

        override public function get level():uint
        {
            return (2);
        }

        override public function toString(_arg_1:uint=0):String
        {
            var _local_3:uint;
            var _local_2:String = ((((((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "ID: ") + characterId) + ", ") + "Bounds: ") + _SafeStr_354) + ", ") + "Matrix: ") + _SafeStr_355);
            if (_SafeStr_703.length > 0)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "TextRecords:"));
                _local_3 = 0;
                while (_local_3 < _SafeStr_703.length)
                {
                    _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 4))) + "[") + _local_3) + "] ") + _SafeStr_703[_local_3].toString()));
                    _local_3++;
                };
            };
            return (_local_2);
        }


    }
}

