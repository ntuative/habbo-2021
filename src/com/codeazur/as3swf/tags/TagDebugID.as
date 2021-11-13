package com.codeazur.as3swf.tags
{
    import flash.utils.ByteArray;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.utils.StringUtils;

    public class TagDebugID implements ITag 
    {

        public static const TYPE:uint = 63;

        protected var _SafeStr_719:ByteArray;

        public function TagDebugID()
        {
            _SafeStr_719 = new ByteArray();
        }

        public function get uuid():ByteArray
        {
            return (_SafeStr_719);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            if (_arg_2 > 0)
            {
                _arg_1.readBytes(_SafeStr_719, 0, _arg_2);
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            _arg_1.writeTagHeader(type, _SafeStr_719.length);
            if (_SafeStr_719.length > 0)
            {
                _arg_1.writeBytes(_SafeStr_719);
            };
        }

        public function get type():uint
        {
            return (63);
        }

        public function get name():String
        {
            return ("DebugID");
        }

        public function get version():uint
        {
            return (6);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            var _local_2:String = (_SafeStr_64.toStringCommon(type, name, _arg_1) + "UUID: ");
            if (_SafeStr_719.length == 16)
            {
                _local_2 = (_local_2 + StringUtils.printf("%02x%02x%02x%02x-", _SafeStr_719[0], _SafeStr_719[1], _SafeStr_719[2], _SafeStr_719[3]));
                _local_2 = (_local_2 + StringUtils.printf("%02x%02x-", _SafeStr_719[4], _SafeStr_719[5]));
                _local_2 = (_local_2 + StringUtils.printf("%02x%02x-", _SafeStr_719[6], _SafeStr_719[7]));
                _local_2 = (_local_2 + StringUtils.printf("%02x%02x-", _SafeStr_719[8], _SafeStr_719[9]));
                _local_2 = (_local_2 + StringUtils.printf("%02x%02x%02x%02x%02x%02x", _SafeStr_719[10], _SafeStr_719[11], _SafeStr_719[12], _SafeStr_719[13], _SafeStr_719[14], _SafeStr_719[15]));
            }
            else
            {
                _local_2 = (_local_2 + (("(invalid length: " + _SafeStr_719.length) + ")"));
            };
            return (_local_2);
        }


    }
}

