package com.codeazur.as3swf.tags
{
    import flash.utils.ByteArray;
    import com.codeazur.as3swf.SWFData;

    public class TagProtect implements ITag 
    {

        public static const TYPE:uint = 24;

        protected var _SafeStr_600:ByteArray;

        public function TagProtect()
        {
            _SafeStr_600 = new ByteArray();
        }

        public function get password():ByteArray
        {
            return (_SafeStr_600);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            if (_arg_2 > 0)
            {
                _arg_1.readBytes(_SafeStr_600, 0, _arg_2);
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            _arg_1.writeTagHeader(type, _SafeStr_600.length);
            if (_SafeStr_600.length > 0)
            {
                _arg_1.writeBytes(_SafeStr_600);
            };
        }

        public function get type():uint
        {
            return (24);
        }

        public function get name():String
        {
            return ("Protect");
        }

        public function get version():uint
        {
            return (2);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            return (_SafeStr_64.toStringCommon(type, name, _arg_1));
        }


    }
}

