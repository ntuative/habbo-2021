package com.codeazur.as3swf.data
{
    import com.codeazur.as3swf.SWFData;

    public class SWFGlyphEntry 
    {

        public var index:uint;
        public var _SafeStr_356:int;

        public function SWFGlyphEntry(_arg_1:SWFData=null, _arg_2:uint=0, _arg_3:uint=0)
        {
            if (_arg_1 != null)
            {
                parse(_arg_1, _arg_2, _arg_3);
            };
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint):void
        {
            index = _arg_1.readUB(_arg_2);
            _SafeStr_356 = _arg_1.readSB(_arg_3);
        }

        public function publish(_arg_1:SWFData, _arg_2:uint, _arg_3:uint):void
        {
            _arg_1.writeUB(_arg_2, index);
            _arg_1.writeSB(_arg_3, _SafeStr_356);
        }

        public function clone():SWFGlyphEntry
        {
            var _local_1:SWFGlyphEntry = new SWFGlyphEntry();
            _local_1.index = index;
            _local_1._SafeStr_356 = _SafeStr_356;
            return (_local_1);
        }

        public function toString():String
        {
            return ((("[SWFGlyphEntry] Index: " + index.toString()) + ", Advance: ") + _SafeStr_356.toString());
        }


    }
}

