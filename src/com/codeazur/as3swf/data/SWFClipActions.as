package com.codeazur.as3swf.data
{
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.utils.StringUtils;

    public class SWFClipActions 
    {

        public var _SafeStr_338:SWFClipEventFlags;
        protected var _SafeStr_703:Vector.<SWFClipActionRecord>;

        public function SWFClipActions(_arg_1:SWFData=null, _arg_2:uint=0)
        {
            _SafeStr_703 = new Vector.<SWFClipActionRecord>();
            if (_arg_1 != null)
            {
                parse(_arg_1, _arg_2);
            };
        }

        public function get records():Vector.<SWFClipActionRecord>
        {
            return (_SafeStr_703);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:SWFClipActionRecord;
            _arg_1.readUI16();
            _SafeStr_338 = _arg_1.readCLIPEVENTFLAGS(_arg_2);
            while ((_local_3 = _arg_1.readCLIPACTIONRECORD(_arg_2)) != null)
            {
                _SafeStr_703.push(_local_3);
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:uint;
            _arg_1.writeUI16(0);
            _arg_1.writeCLIPEVENTFLAGS(_SafeStr_338, _arg_2);
            _local_3 = 0;
            while (_local_3 < records.length)
            {
                _arg_1.writeCLIPACTIONRECORD(records[_local_3], _arg_2);
                _local_3++;
            };
            if (_arg_2 >= 6)
            {
                _arg_1.writeUI32(0);
            }
            else
            {
                _arg_1.writeUI16(0);
            };
        }

        public function toString(_arg_1:uint=0):String
        {
            var _local_3:uint;
            var _local_2:String = (("ClipActions (" + _SafeStr_338.toString()) + "):");
            _local_3 = 0;
            while (_local_3 < _SafeStr_703.length)
            {
                _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 2))) + "[") + _local_3) + "] ") + _SafeStr_703[_local_3].toString((_arg_1 + 2))));
                _local_3++;
            };
            return (_local_2);
        }


    }
}

