package com.codeazur.as3swf.data
{
    import com.codeazur.as3swf.SWFData;

    public class SWFFocalGradient extends SWFGradient 
    {

        public function SWFFocalGradient(_arg_1:SWFData=null, _arg_2:uint=1)
        {
            super(_arg_1, _arg_2);
        }

        override public function parse(_arg_1:SWFData, _arg_2:uint):void
        {
            super.parse(_arg_1, _arg_2);
            focalPoint = _arg_1.readFIXED8();
        }

        override public function publish(_arg_1:SWFData, _arg_2:uint=1):void
        {
            super.publish(_arg_1, _arg_2);
            _arg_1.writeFIXED8(focalPoint);
        }

        override public function toString():String
        {
            return (("(" + _SafeStr_703.join(",")) + ")");
        }


    }
}

