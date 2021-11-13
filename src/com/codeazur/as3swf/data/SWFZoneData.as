package com.codeazur.as3swf.data
{
    import com.codeazur.as3swf.SWFData;

    public class SWFZoneData 
    {

        public var _SafeStr_374:Number;
        public var range:Number;

        public function SWFZoneData(_arg_1:SWFData=null)
        {
            if (_arg_1 != null)
            {
                parse(_arg_1);
            };
        }

        public function parse(_arg_1:SWFData):void
        {
            _SafeStr_374 = _arg_1.readFLOAT16();
            range = _arg_1.readFLOAT16();
        }

        public function publish(_arg_1:SWFData):void
        {
            _arg_1.writeFLOAT16(_SafeStr_374);
            _arg_1.writeFLOAT16(range);
        }

        public function toString():String
        {
            return (((("(" + _SafeStr_374) + ",") + range) + ")");
        }


    }
}

