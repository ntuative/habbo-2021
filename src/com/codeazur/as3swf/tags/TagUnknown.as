package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFData;

    public class TagUnknown implements ITag 
    {

        protected var _SafeStr_741:uint;

        public function TagUnknown(_arg_1:uint=0)
        {
            _SafeStr_741 = _arg_1;
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            _arg_1.skipBytes(_arg_2);
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            throw (new Error("No raw tag data available."));
        }

        public function get type():uint
        {
            return (_SafeStr_741);
        }

        public function get name():String
        {
            return ("????");
        }

        public function get version():uint
        {
            return (0);
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

