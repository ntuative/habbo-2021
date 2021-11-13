package com.codeazur.as3swf.data
{
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.SWFData;

    public class SWFGradient 
    {

        public var _SafeStr_313:uint;
        public var interpolationMode:uint;
        public var focalPoint:Number = 0;
        protected var _SafeStr_703:Vector.<SWFGradientRecord>;

        public function SWFGradient(_arg_1:SWFData=null, _arg_2:uint=1)
        {
            _SafeStr_703 = new Vector.<SWFGradientRecord>();
            if (_arg_1 != null)
            {
                parse(_arg_1, _arg_2);
            };
        }

        public function get records():Vector.<SWFGradientRecord>
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
                _SafeStr_703.push(_arg_1.readGRADIENTRECORD(_arg_2));
                _local_4++;
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint=1):void
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
                _arg_1.writeGRADIENTRECORD(records[_local_4], _arg_2);
                _local_4++;
            };
        }

        public function clone():SWFGradient
        {
            var _local_2:uint;
            var _local_1:SWFGradient = new SWFGradient();
            _local_1._SafeStr_313 = _SafeStr_313;
            _local_1.interpolationMode = interpolationMode;
            _local_1.focalPoint = focalPoint;
            _local_2 = 0;
            while (_local_2 < records.length)
            {
                _local_1.records.push(records[_local_2].clone());
                _local_2++;
            };
            return (_local_1);
        }

        public function toString():String
        {
            return ((((("(" + _SafeStr_703.join(",")) + "), SpreadMode: ") + _SafeStr_313) + ", InterpolationMode: ") + interpolationMode);
        }


    }
}

