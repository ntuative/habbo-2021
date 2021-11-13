package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFData;

    public class TagShowFrame implements _SafeStr_54 
    {

        public static const TYPE:uint = 1;


        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            _arg_1.writeTagHeader(type, 0);
        }

        public function get type():uint
        {
            return (1);
        }

        public function get name():String
        {
            return ("ShowFrame");
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
            return (_SafeStr_64.toStringCommon(type, name, _arg_1));
        }


    }
}

