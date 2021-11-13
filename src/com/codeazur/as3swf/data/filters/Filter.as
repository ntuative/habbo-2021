package com.codeazur.as3swf.data.filters
{
    import flash.filters.BitmapFilter;
    import com.codeazur.as3swf.SWFData;

    public class Filter implements IFilter 
    {

        protected var _SafeStr_698:uint;

        public function Filter(_arg_1:uint)
        {
            _SafeStr_698 = _arg_1;
        }

        public function get id():uint
        {
            return (_SafeStr_698);
        }

        public function get filter():BitmapFilter
        {
            throw (new Error("Implement in subclasses!"));
        }

        public function parse(_arg_1:SWFData):void
        {
            throw (new Error("Implement in subclasses!"));
        }

        public function publish(_arg_1:SWFData):void
        {
            throw (new Error("Implement in subclasses!"));
        }

        public function clone():IFilter
        {
            throw (new Error("Implement in subclasses!"));
        }

        public function toString(_arg_1:uint=0):String
        {
            return ("[Filter]");
        }


    }
}

