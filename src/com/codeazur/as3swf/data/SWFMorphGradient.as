package com.codeazur.as3swf.data
{
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.SWFData;

    public class SWFMorphGradient 
    {

        public var _SafeStr_313:uint;
        public var interpolationMode:uint;
        public var startFocalPoint:Number = 0;
        public var endFocalPoint:Number = 0;
        protected var _SafeStr_703:Vector.<SWFMorphGradientRecord>;

        public function SWFMorphGradient(_arg_1:SWFData=null, _arg_2:uint=1)
        {
            _SafeStr_703 = new Vector.<SWFMorphGradientRecord>();
            if (_arg_1 != null)
            {
                parse(_arg_1, _arg_2);
            };
        }

        public function get records():Vector.<SWFMorphGradientRecord>
        {
            return (_SafeStr_703);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_4:uint;
            _arg_1.resetBitsPending();
            _SafeStr_313 = _arg_1.readUB(2);
            interpolationMode = _arg_1.readUB(2);
            var _local_3:uint = _arg_1.readUB(4);
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _SafeStr_703.push(_arg_1.readMORPHGRADIENTRECORD());
                _local_4++;
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_4:uint;
            var _local_3:uint = records.length;
            _arg_1.resetBitsPending();
            _arg_1.writeUB(2, _SafeStr_313);
            _arg_1.writeUB(2, interpolationMode);
            _arg_1.writeUB(4, _local_3);
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _arg_1.writeMORPHGRADIENTRECORD(_SafeStr_703[_local_4]);
                _local_4++;
            };
        }

        public function getMorphedGradient(_arg_1:Number=0):SWFGradient
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

        public function toString():String
        {
            return ((((("(" + _SafeStr_703.join(",")) + "), spread:") + _SafeStr_313) + ", interpolation:") + interpolationMode);
        }


    }
}

