package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.data.SWFRectangle;
    import com.codeazur.as3swf.data.SWFMatrix;
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.data.SWFTextRecord;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.data.SWFGlyphEntry;
    import com.codeazur.utils.StringUtils;

    public class TagDefineText implements IDefinitionTag 
    {

        public static const TYPE:uint = 11;

        public var _SafeStr_354:SWFRectangle;
        public var _SafeStr_355:SWFMatrix;
        protected var _SafeStr_720:uint;
        protected var _SafeStr_703:Vector.<SWFTextRecord>;

        public function TagDefineText()
        {
            _SafeStr_703 = new Vector.<SWFTextRecord>();
        }

        public function get characterId():uint
        {
            return (_SafeStr_720);
        }

        public function set characterId(_arg_1:uint):void
        {
            _SafeStr_720 = _arg_1;
        }

        public function get records():Vector.<SWFTextRecord>
        {
            return (_SafeStr_703);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            var _local_6:SWFTextRecord;
            _SafeStr_720 = _arg_1.readUI16();
            _SafeStr_354 = _arg_1.readRECT();
            _SafeStr_355 = _arg_1.readMATRIX();
            var _local_5:uint = _arg_1.readUI8();
            var _local_7:uint = _arg_1.readUI8();
            while ((_local_6 = _arg_1.readTEXTRECORD(_local_5, _local_7, _local_6, level)) != null)
            {
                _SafeStr_703.push(_local_6);
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_5:uint;
            var _local_7:uint;
            var _local_12:SWFTextRecord;
            var _local_9:uint;
            var _local_10:SWFGlyphEntry;
            var _local_8:SWFData = new SWFData();
            _local_8.writeUI16(characterId);
            _local_8.writeRECT(_SafeStr_354);
            _local_8.writeMATRIX(_SafeStr_355);
            var _local_13:Array = [];
            var _local_11:Array = [];
            var _local_4:uint = _SafeStr_703.length;
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_12 = _SafeStr_703[_local_5];
                _local_9 = _local_12.glyphEntries.length;
                _local_7 = 0;
                while (_local_7 < _local_9)
                {
                    _local_10 = _local_12.glyphEntries[_local_7];
                    _local_13.push(_local_10.index);
                    _local_11.push(_local_10._SafeStr_356);
                    _local_7++;
                };
                _local_5++;
            };
            var _local_3:uint = _local_8.calculateMaxBits(false, _local_13);
            var _local_6:uint = _local_8.calculateMaxBits(true, _local_11);
            _local_8.writeUI8(_local_3);
            _local_8.writeUI8(_local_6);
            _local_12 = null;
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_8.writeTEXTRECORD(_SafeStr_703[_local_5], _local_3, _local_6, _local_12, level);
                _local_12 = _SafeStr_703[_local_5];
                _local_5++;
            };
            _local_8.writeUI8(0);
            _arg_1.writeTagHeader(type, _local_8.length);
            _arg_1.writeBytes(_local_8);
        }

        public function clone():IDefinitionTag
        {
            var _local_1:uint;
            var _local_2:TagDefineText = new TagDefineText();
            _local_2.characterId = characterId;
            _local_2._SafeStr_354 = _SafeStr_354.clone();
            _local_2._SafeStr_355 = _SafeStr_355.clone();
            _local_1 = 0;
            while (_local_1 < _SafeStr_703.length)
            {
                _local_2.records.push(_SafeStr_703[_local_1].clone());
                _local_1++;
            };
            return (_local_2);
        }

        public function get type():uint
        {
            return (11);
        }

        public function get name():String
        {
            return ("DefineText");
        }

        public function get version():uint
        {
            return (1);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            var _local_3:uint;
            var _local_2:String = ((((((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "ID: ") + characterId) + ", ") + "Bounds: ") + _SafeStr_354) + ", ") + "Matrix: ") + _SafeStr_355);
            if (_SafeStr_703.length > 0)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "TextRecords:"));
                _local_3 = 0;
                while (_local_3 < _SafeStr_703.length)
                {
                    _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 4))) + "[") + _local_3) + "] ") + _SafeStr_703[_local_3].toString((_arg_1 + 4))));
                    _local_3++;
                };
            };
            return (_local_2);
        }


    }
}

