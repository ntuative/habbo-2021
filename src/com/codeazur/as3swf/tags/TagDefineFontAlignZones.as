package com.codeazur.as3swf.tags
{
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.data.SWFZoneRecord;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.data.consts.CSMTableHint;
    import com.codeazur.utils.StringUtils;

    public class TagDefineFontAlignZones implements ITag 
    {

        public static const TYPE:uint = 73;

        public var _SafeStr_341:uint;
        public var csmTableHint:uint;
        protected var _SafeStr_731:Vector.<SWFZoneRecord>;

        public function TagDefineFontAlignZones()
        {
            _SafeStr_731 = new Vector.<SWFZoneRecord>();
        }

        public function get zoneTable():Vector.<SWFZoneRecord>
        {
            return (_SafeStr_731);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            _SafeStr_341 = _arg_1.readUI16();
            csmTableHint = (_arg_1.readUI8() >> 6);
            var _local_5:uint = ((_arg_1.position + _arg_2) - 3);
            while (_arg_1.position < _local_5)
            {
                _SafeStr_731.push(_arg_1.readZONERECORD());
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:uint;
            var _local_4:SWFData = new SWFData();
            _local_4.writeUI16(_SafeStr_341);
            _local_4.writeUI8((csmTableHint << 6));
            _local_3 = 0;
            while (_local_3 < _SafeStr_731.length)
            {
                _local_4.writeZONERECORD(_SafeStr_731[_local_3]);
                _local_3++;
            };
            _arg_1.writeTagHeader(type, _local_4.length);
            _arg_1.writeBytes(_local_4);
        }

        public function get type():uint
        {
            return (73);
        }

        public function get name():String
        {
            return ("DefineFontAlignZones");
        }

        public function get version():uint
        {
            return (8);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            var _local_3:uint;
            var _local_2:String = ((((((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "FontID: ") + _SafeStr_341) + ", ") + "CSMTableHint: ") + CSMTableHint.toString(csmTableHint)) + ", ") + "Records: ") + _SafeStr_731.length);
            _local_3 = 0;
            while (_local_3 < _SafeStr_731.length)
            {
                _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 2))) + "[") + _local_3) + "] ") + _SafeStr_731[_local_3].toString((_arg_1 + 2))));
                _local_3++;
            };
            return (_local_2);
        }


    }
}

