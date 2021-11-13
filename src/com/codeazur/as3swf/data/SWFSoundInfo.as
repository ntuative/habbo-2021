package com.codeazur.as3swf.data
{
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.SWFData;

    public class SWFSoundInfo 
    {

        public var syncStop:Boolean;
        public var syncNoMultiple:Boolean;
        public var hasEnvelope:Boolean;
        public var hasLoops:Boolean;
        public var hasOutPoint:Boolean;
        public var hasInPoint:Boolean;
        public var outPoint:uint;
        public var inPoint:uint;
        public var loopCount:uint;
        protected var _SafeStr_714:Vector.<SWFSoundEnvelope>;

        public function SWFSoundInfo(_arg_1:SWFData=null)
        {
            _SafeStr_714 = new Vector.<SWFSoundEnvelope>();
            if (_arg_1 != null)
            {
                parse(_arg_1);
            };
        }

        public function get envelopeRecords():Vector.<SWFSoundEnvelope>
        {
            return (_SafeStr_714);
        }

        public function parse(_arg_1:SWFData):void
        {
            var _local_2:uint;
            var _local_4:uint;
            var _local_3:uint = _arg_1.readUI8();
            syncStop = (!((_local_3 & 0x20) == 0));
            syncNoMultiple = (!((_local_3 & 0x10) == 0));
            hasEnvelope = (!((_local_3 & 0x08) == 0));
            hasLoops = (!((_local_3 & 0x04) == 0));
            hasOutPoint = (!((_local_3 & 0x02) == 0));
            hasInPoint = (!((_local_3 & 0x01) == 0));
            if (hasInPoint)
            {
                inPoint = _arg_1.readUI32();
            };
            if (hasOutPoint)
            {
                outPoint = _arg_1.readUI32();
            };
            if (hasLoops)
            {
                loopCount = _arg_1.readUI16();
            };
            if (hasEnvelope)
            {
                _local_2 = _arg_1.readUI8();
                _local_4 = 0;
                while (_local_4 < _local_2)
                {
                    _SafeStr_714.push(_arg_1.readSOUNDENVELOPE());
                    _local_4++;
                };
            };
        }

        public function publish(_arg_1:SWFData):void
        {
            var _local_2:uint;
            var _local_4:uint;
            var _local_3:uint;
            if (syncStop)
            {
                _local_3 = (_local_3 | 0x20);
            };
            if (syncNoMultiple)
            {
                _local_3 = (_local_3 | 0x10);
            };
            if (hasEnvelope)
            {
                _local_3 = (_local_3 | 0x08);
            };
            if (hasLoops)
            {
                _local_3 = (_local_3 | 0x04);
            };
            if (hasOutPoint)
            {
                _local_3 = (_local_3 | 0x02);
            };
            if (hasInPoint)
            {
                _local_3 = (_local_3 | 0x01);
            };
            _arg_1.writeUI8(_local_3);
            if (hasInPoint)
            {
                _arg_1.writeUI32(inPoint);
            };
            if (hasOutPoint)
            {
                _arg_1.writeUI32(outPoint);
            };
            if (hasLoops)
            {
                _arg_1.writeUI16(loopCount);
            };
            if (hasEnvelope)
            {
                _local_2 = _SafeStr_714.length;
                _arg_1.writeUI8(_local_2);
                _local_4 = 0;
                while (_local_4 < _local_2)
                {
                    _arg_1.writeSOUNDENVELOPE(_SafeStr_714[_local_4]);
                    _local_4++;
                };
            };
        }

        public function clone():SWFSoundInfo
        {
            var _local_1:uint;
            var _local_2:SWFSoundInfo = new SWFSoundInfo();
            _local_2.syncStop = syncStop;
            _local_2.syncNoMultiple = syncNoMultiple;
            _local_2.hasEnvelope = hasEnvelope;
            _local_2.hasLoops = hasLoops;
            _local_2.hasOutPoint = hasOutPoint;
            _local_2.hasInPoint = hasInPoint;
            _local_2.outPoint = outPoint;
            _local_2.inPoint = inPoint;
            _local_2.loopCount = loopCount;
            _local_1 = 0;
            while (_local_1 < _SafeStr_714.length)
            {
                _local_2.envelopeRecords.push(_SafeStr_714[_local_1].clone());
                _local_1++;
            };
            return (_local_2);
        }

        public function toString():String
        {
            return ("[SWFSoundInfo]");
        }


    }
}

