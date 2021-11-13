package com.codeazur.as3swf.data
{
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.SWFData;

    public class SWFZoneRecord 
    {

        public var maskX:Boolean;
        public var maskY:Boolean;
        protected var _SafeStr_716:Vector.<SWFZoneData>;

        public function SWFZoneRecord(_arg_1:SWFData=null)
        {
            _SafeStr_716 = new Vector.<SWFZoneData>();
            if (_arg_1 != null)
            {
                parse(_arg_1);
            };
        }

        public function get zoneData():Vector.<SWFZoneData>
        {
            return (_SafeStr_716);
        }

        public function parse(_arg_1:SWFData):void
        {
            var _local_3:uint;
            var _local_2:uint = _arg_1.readUI8();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _SafeStr_716.push(_arg_1.readZONEDATA());
                _local_3++;
            };
            var _local_4:uint = _arg_1.readUI8();
            maskX = (!((_local_4 & 0x01) == 0));
            maskY = (!((_local_4 & 0x02) == 0));
        }

        public function publish(_arg_1:SWFData):void
        {
            var _local_3:uint;
            var _local_2:uint = _SafeStr_716.length;
            _arg_1.writeUI8(_local_2);
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _arg_1.writeZONEDATA(_SafeStr_716[_local_3]);
                _local_3++;
            };
            var _local_4:uint;
            if (maskX)
            {
                _local_4 = (_local_4 | 0x01);
            };
            if (maskY)
            {
                _local_4 = (_local_4 | 0x02);
            };
            _arg_1.writeUI8(_local_4);
        }

        public function toString(_arg_1:uint=0):String
        {
            var _local_3:uint;
            var _local_2:String = ((("MaskY: " + maskY) + ", MaskX: ") + maskX);
            _local_3 = 0;
            while (_local_3 < _SafeStr_716.length)
            {
                _local_2 = (_local_2 + (((", " + _local_3) + ": ") + _SafeStr_716[_local_3].toString()));
                _local_3++;
            };
            return (_local_2);
        }


    }
}

