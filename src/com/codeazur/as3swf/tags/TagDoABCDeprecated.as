package com.codeazur.as3swf.tags
{
    import flash.utils.ByteArray;
    import com.codeazur.as3swf.SWFData;

    public class TagDoABCDeprecated implements ITag 
    {

        public static const TYPE:uint = 72;

        protected var _SafeStr_736:ByteArray;

        public function TagDoABCDeprecated()
        {
            _SafeStr_736 = new ByteArray();
        }

        public static function create(_arg_1:ByteArray=null):TagDoABCDeprecated
        {
            var _local_2:TagDoABCDeprecated = new TagDoABCDeprecated();
            if (((!(_arg_1 == null)) && (_arg_1.length > 0)))
            {
                _local_2.bytes.writeBytes(_arg_1);
            };
            return (_local_2);
        }


        public function get bytes():ByteArray
        {
            return (_SafeStr_736);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            var _local_5:uint = _arg_1.position;
            _arg_1.readBytes(bytes, 0, (_arg_2 - (_arg_1.position - _local_5)));
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:SWFData = new SWFData();
            if (_SafeStr_736.length > 0)
            {
                _local_3.writeBytes(_SafeStr_736);
            };
            _arg_1.writeTagHeader(type, _local_3.length);
            _arg_1.writeBytes(_local_3);
        }

        public function get type():uint
        {
            return (72);
        }

        public function get name():String
        {
            return ("DoABCDeprecated");
        }

        public function get version():uint
        {
            return (9);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            return ((_SafeStr_64.toStringCommon(type, name, _arg_1) + "Length: ") + _SafeStr_736.length);
        }


    }
}

