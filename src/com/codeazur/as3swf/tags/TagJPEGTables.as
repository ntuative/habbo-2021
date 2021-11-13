package com.codeazur.as3swf.tags
{
    import flash.utils.ByteArray;
    import com.codeazur.as3swf.SWFData;

    public class TagJPEGTables implements ITag 
    {

        public static const TYPE:uint = 8;

        protected var _SafeStr_738:ByteArray;

        public function TagJPEGTables()
        {
            _SafeStr_738 = new ByteArray();
        }

        public function get jpegTables():ByteArray
        {
            return (_SafeStr_738);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            if (_arg_2 > 0)
            {
                _arg_1.readBytes(_SafeStr_738, 0, _arg_2);
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            _arg_1.writeTagHeader(type, _SafeStr_738.length);
            if (jpegTables.length > 0)
            {
                _arg_1.writeBytes(jpegTables);
            };
        }

        public function get type():uint
        {
            return (8);
        }

        public function get name():String
        {
            return ("JPEGTables");
        }

        public function get version():uint
        {
            return (1);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            return ((_SafeStr_64.toStringCommon(type, name, _arg_1) + "Length: ") + _SafeStr_738.length);
        }


    }
}

