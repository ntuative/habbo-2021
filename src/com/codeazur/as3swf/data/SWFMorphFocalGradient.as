package com.codeazur.as3swf.data
{
    import com.codeazur.as3swf.SWFData;

    public class SWFMorphFocalGradient extends SWFMorphGradient 
    {

        public function SWFMorphFocalGradient(_arg_1:SWFData=null, _arg_2:uint=1)
        {
            super(_arg_1, _arg_2);
        }

        override public function parse(_arg_1:SWFData, _arg_2:uint):void
        {
            super.parse(_arg_1, _arg_2);
            startFocalPoint = _arg_1.readFIXED8();
            endFocalPoint = _arg_1.readFIXED8();
        }

        override public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            super.publish(_arg_1, _arg_2);
            _arg_1.writeFIXED8(startFocalPoint);
            _arg_1.writeFIXED8(endFocalPoint);
        }

        override public function getMorphedGradient(_arg_1:Number=0):SWFGradient
        {
            var _local_3:uint;
            var _local_2:SWFGradient = new SWFGradient();
            _local_3 = 0;
            while (_local_3 < records.length)
            {
                _local_2.records.push(records[_local_3].getMorphedGradientRecord(_arg_1));
                _local_3++;
            };
            return (_local_2);
        }

        override public function toString():String
        {
            return (((((("FocalPoint: " + startFocalPoint) + ",") + endFocalPoint) + " (") + _SafeStr_703.join(",")) + ")");
        }


    }
}

