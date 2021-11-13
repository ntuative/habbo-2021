package com.codeazur.as3swf.tags
{
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.data.SWFRectangle;
    import com.codeazur.as3swf.data.SWFKerningRecord;
    import flash.utils.ByteArray;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.utils.StringUtils;

    public class TagDefineFont2 extends TagDefineFont implements IDefinitionTag 
    {

        public static const TYPE:uint = 48;

        public var hasLayout:Boolean;
        public var shiftJIS:Boolean;
        public var smallText:Boolean;
        public var _SafeStr_344:Boolean;
        public var _SafeStr_391:Boolean;
        public var _SafeStr_345:Boolean;
        public var italic:Boolean;
        public var bold:Boolean;
        public var languageCode:uint;
        public var fontName:String;
        public var _SafeStr_392:uint;
        public var _SafeStr_393:uint;
        public var leading:int;
        protected var _SafeStr_726:Vector.<uint>;
        protected var _SafeStr_727:Vector.<int>;
        protected var _SafeStr_728:Vector.<SWFRectangle>;
        protected var _SafeStr_729:Vector.<SWFKerningRecord>;

        public function TagDefineFont2()
        {
            _SafeStr_726 = new Vector.<uint>();
            _SafeStr_727 = new Vector.<int>();
            _SafeStr_728 = new Vector.<SWFRectangle>();
            _SafeStr_729 = new Vector.<SWFKerningRecord>();
        }

        public function get codeTable():Vector.<uint>
        {
            return (_SafeStr_726);
        }

        public function get fontAdvanceTable():Vector.<int>
        {
            return (_SafeStr_727);
        }

        public function get fontBoundsTable():Vector.<SWFRectangle>
        {
            return (_SafeStr_728);
        }

        public function get fontKerningTable():Vector.<SWFKerningRecord>
        {
            return (_SafeStr_729);
        }

        override public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            var _local_9:uint;
            var _local_5:uint;
            _SafeStr_720 = _arg_1.readUI16();
            var _local_7:uint = _arg_1.readUI8();
            hasLayout = (!((_local_7 & 0x80) == 0));
            shiftJIS = (!((_local_7 & 0x40) == 0));
            smallText = (!((_local_7 & 0x20) == 0));
            _SafeStr_344 = (!((_local_7 & 0x10) == 0));
            _SafeStr_391 = (!((_local_7 & 0x08) == 0));
            _SafeStr_345 = (!((_local_7 & 0x04) == 0));
            italic = (!((_local_7 & 0x02) == 0));
            bold = (!((_local_7 & 0x01) == 0));
            languageCode = _arg_1.readLANGCODE();
            var _local_8:uint = _arg_1.readUI8();
            var _local_10:ByteArray = new ByteArray();
            _arg_1.readBytes(_local_10, 0, _local_8);
            fontName = _local_10.readUTFBytes(_local_8);
            var _local_6:uint = _arg_1.readUI16();
            _arg_1.skipBytes((_local_6 << ((_SafeStr_391) ? 2 : 1)));
            var _local_11:uint = ((_SafeStr_391) ? _arg_1.readUI32() : _arg_1.readUI16());
            _local_9 = 0;
            while (_local_9 < _local_6)
            {
                _SafeStr_725.push(_arg_1.readSHAPE());
                _local_9++;
            };
            _local_9 = 0;
            while (_local_9 < _local_6)
            {
                _SafeStr_726.push(((_SafeStr_345) ? _arg_1.readUI16() : _arg_1.readUI8()));
                _local_9++;
            };
            if (hasLayout)
            {
                _SafeStr_392 = _arg_1.readUI16();
                _SafeStr_393 = _arg_1.readUI16();
                leading = _arg_1.readSI16();
                _local_9 = 0;
                while (_local_9 < _local_6)
                {
                    _SafeStr_727.push(_arg_1.readSI16());
                    _local_9++;
                };
                _local_9 = 0;
                while (_local_9 < _local_6)
                {
                    _SafeStr_728.push(_arg_1.readRECT());
                    _local_9++;
                };
                _local_5 = _arg_1.readUI16();
                _local_9 = 0;
                while (_local_9 < _local_5)
                {
                    _SafeStr_729.push(_arg_1.readKERNINGRECORD(_SafeStr_345));
                    _local_9++;
                };
            };
        }

        override public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_8:uint;
            var _local_4:uint;
            var _local_9:SWFData = new SWFData();
            var _local_5:uint = glyphShapeTable.length;
            _local_9.writeUI16(characterId);
            var _local_7:uint;
            if (hasLayout)
            {
                _local_7 = (_local_7 | 0x80);
            };
            if (shiftJIS)
            {
                _local_7 = (_local_7 | 0x40);
            };
            if (smallText)
            {
                _local_7 = (_local_7 | 0x20);
            };
            if (_SafeStr_344)
            {
                _local_7 = (_local_7 | 0x10);
            };
            if (_SafeStr_391)
            {
                _local_7 = (_local_7 | 0x08);
            };
            if (_SafeStr_345)
            {
                _local_7 = (_local_7 | 0x04);
            };
            if (italic)
            {
                _local_7 = (_local_7 | 0x02);
            };
            if (bold)
            {
                _local_7 = (_local_7 | 0x01);
            };
            _local_9.writeUI8(_local_7);
            _local_9.writeLANGCODE(languageCode);
            var _local_10:ByteArray = new ByteArray();
            _local_10.writeUTFBytes(fontName);
            _local_9.writeUI8(_local_10.length);
            _local_9.writeBytes(_local_10);
            _local_9.writeUI16(_local_5);
            var _local_13:uint = (_local_5 << ((_SafeStr_391) ? 2 : 1));
            var _local_12:uint = ((_SafeStr_391) ? 4 : 2);
            var _local_6:uint = ((_SafeStr_391) ? (_local_5 << 1) : _local_5);
            var _local_3:uint = (_local_13 + _local_12);
            var _local_11:SWFData = new SWFData();
            _local_8 = 0;
            while (_local_8 < _local_5)
            {
                if (_SafeStr_391)
                {
                    _local_9.writeUI32((_local_3 + _local_11.position));
                }
                else
                {
                    _local_9.writeUI16((_local_3 + _local_11.position));
                };
                _local_11.writeSHAPE(glyphShapeTable[_local_8]);
                _local_8++;
            };
            if (_SafeStr_391)
            {
                _local_9.writeUI32((_local_3 + _local_11.length));
            }
            else
            {
                _local_9.writeUI16((_local_3 + _local_11.length));
            };
            _local_9.writeBytes(_local_11);
            _local_8 = 0;
            while (_local_8 < _local_5)
            {
                if (_SafeStr_345)
                {
                    _local_9.writeUI16(codeTable[_local_8]);
                }
                else
                {
                    _local_9.writeUI8(codeTable[_local_8]);
                };
                _local_8++;
            };
            if (hasLayout)
            {
                _local_9.writeUI16(_SafeStr_392);
                _local_9.writeUI16(_SafeStr_393);
                _local_9.writeSI16(leading);
                _local_8 = 0;
                while (_local_8 < _local_5)
                {
                    _local_9.writeSI16(fontAdvanceTable[_local_8]);
                    _local_8++;
                };
                _local_8 = 0;
                while (_local_8 < _local_5)
                {
                    _local_9.writeRECT(fontBoundsTable[_local_8]);
                    _local_8++;
                };
                _local_4 = fontKerningTable.length;
                _local_9.writeUI16(_local_4);
                _local_8 = 0;
                while (_local_8 < _local_4)
                {
                    _local_9.writeKERNINGRECORD(fontKerningTable[_local_8], _SafeStr_345);
                    _local_8++;
                };
            };
            _arg_1.writeTagHeader(type, _local_9.length);
            _arg_1.writeBytes(_local_9);
        }

        override public function get type():uint
        {
            return (48);
        }

        override public function get name():String
        {
            return ("DefineFont2");
        }

        override public function get version():uint
        {
            return (3);
        }

        override public function get level():uint
        {
            return (2);
        }

        override public function toString(_arg_1:uint=0):String
        {
            var _local_2:String = ((((((((((((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "ID: ") + characterId) + ", ") + "FontName: ") + fontName) + ", ") + "Italic: ") + italic) + ", ") + "Bold: ") + bold) + ", ") + "Glyphs: ") + _SafeStr_725.length);
            return (_local_2 + toStringCommon(_arg_1));
        }

        override protected function toStringCommon(_arg_1:uint):String
        {
            var _local_5:uint;
            var _local_4:Boolean;
            var _local_3:SWFRectangle;
            var _local_2:String = super.toStringCommon(_arg_1);
            if (hasLayout)
            {
                _local_2 = (_local_2 + ((("\n" + StringUtils.repeat((_arg_1 + 2))) + "Ascent: ") + _SafeStr_392));
                _local_2 = (_local_2 + ((("\n" + StringUtils.repeat((_arg_1 + 2))) + "Descent: ") + _SafeStr_393));
                _local_2 = (_local_2 + ((("\n" + StringUtils.repeat((_arg_1 + 2))) + "Leading: ") + leading));
            };
            if (_SafeStr_726.length > 0)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "CodeTable:"));
                _local_5 = 0;
                while (_local_5 < _SafeStr_726.length)
                {
                    if ((_local_5 & 0x0F) == 0)
                    {
                        _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 4))) + _SafeStr_726[_local_5].toString()));
                    }
                    else
                    {
                        _local_2 = (_local_2 + (", " + _SafeStr_726[_local_5].toString()));
                    };
                    _local_5++;
                };
            };
            if (_SafeStr_727.length > 0)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "FontAdvanceTable:"));
                _local_5 = 0;
                while (_local_5 < _SafeStr_727.length)
                {
                    if ((_local_5 & 0x07) == 0)
                    {
                        _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 4))) + _SafeStr_727[_local_5].toString()));
                    }
                    else
                    {
                        _local_2 = (_local_2 + (", " + _SafeStr_727[_local_5].toString()));
                    };
                    _local_5++;
                };
            };
            if (_SafeStr_728.length > 0)
            {
                _local_4 = false;
                _local_5 = 0;
                while (_local_5 < _SafeStr_728.length)
                {
                    _local_3 = _SafeStr_728[_local_5];
                    if (((((!(_local_3.xmin == 0)) || (!(_local_3._SafeStr_284 == 0))) || (!(_local_3.ymin == 0))) || (!(_local_3._SafeStr_285 == 0))))
                    {
                        _local_4 = true;
                        break;
                    };
                    _local_5++;
                };
                if (_local_4)
                {
                    _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "FontBoundsTable:"));
                    _local_5 = 0;
                    while (_local_5 < _SafeStr_728.length)
                    {
                        _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 4))) + "[") + _local_5) + "] ") + _SafeStr_728[_local_5].toString()));
                        _local_5++;
                    };
                };
            };
            if (_SafeStr_729.length > 0)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "KerningTable:"));
                _local_5 = 0;
                while (_local_5 < _SafeStr_729.length)
                {
                    _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 4))) + "[") + _local_5) + "] ") + _SafeStr_729[_local_5].toString()));
                    _local_5++;
                };
            };
            return (_local_2);
        }


    }
}

