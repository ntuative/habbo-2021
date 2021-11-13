package com.codeazur.as3swf.data
{
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.utils.ColorUtils;
    import com.codeazur.utils.StringUtils;

    public class SWFTextRecord 
    {

        public var type:uint;
        public var hasFont:Boolean;
        public var hasColor:Boolean;
        public var hasXOffset:Boolean;
        public var hasYOffset:Boolean;
        public var _SafeStr_341:uint;
        public var textColor:uint;
        public var textHeight:uint;
        public var xOffset:int;
        public var yOffset:int;
        protected var _SafeStr_715:Vector.<SWFGlyphEntry>;
        protected var _SafeStr_346:uint;

        public function SWFTextRecord(_arg_1:SWFData=null, _arg_2:uint=0, _arg_3:uint=0, _arg_4:SWFTextRecord=null, _arg_5:uint=1)
        {
            _SafeStr_715 = new Vector.<SWFGlyphEntry>();
            if (_arg_1 != null)
            {
                parse(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            };
        }

        public function get glyphEntries():Vector.<SWFGlyphEntry>
        {
            return (_SafeStr_715);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:SWFTextRecord=null, _arg_5:uint=1):void
        {
            var _local_6:uint;
            _SafeStr_346 = _arg_5;
            var _local_7:uint = _arg_1.readUI8();
            type = (_local_7 >> 7);
            hasFont = (!((_local_7 & 0x08) == 0));
            hasColor = (!((_local_7 & 0x04) == 0));
            hasYOffset = (!((_local_7 & 0x02) == 0));
            hasXOffset = (!((_local_7 & 0x01) == 0));
            if (hasFont)
            {
                _SafeStr_341 = _arg_1.readUI16();
            }
            else
            {
                if (_arg_4 != null)
                {
                    _SafeStr_341 = _arg_4._SafeStr_341;
                };
            };
            if (hasColor)
            {
                textColor = ((_arg_5 < 2) ? _arg_1.readRGB() : _arg_1.readRGBA());
            }
            else
            {
                if (_arg_4 != null)
                {
                    textColor = _arg_4.textColor;
                };
            };
            if (hasXOffset)
            {
                xOffset = _arg_1.readSI16();
            }
            else
            {
                if (_arg_4 != null)
                {
                    xOffset = _arg_4.xOffset;
                };
            };
            if (hasYOffset)
            {
                yOffset = _arg_1.readSI16();
            }
            else
            {
                if (_arg_4 != null)
                {
                    yOffset = _arg_4.yOffset;
                };
            };
            if (hasFont)
            {
                textHeight = _arg_1.readUI16();
            }
            else
            {
                if (_arg_4 != null)
                {
                    textHeight = _arg_4.textHeight;
                };
            };
            var _local_8:uint = _arg_1.readUI8();
            _local_6 = 0;
            while (_local_6 < _local_8)
            {
                _SafeStr_715.push(_arg_1.readGLYPHENTRY(_arg_2, _arg_3));
                _local_6++;
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:SWFTextRecord=null, _arg_5:uint=1):void
        {
            var _local_7:uint;
            var _local_6:uint = (type << 7);
            hasFont = (((_arg_4 == null) || (!(_arg_4._SafeStr_341 == _SafeStr_341))) || (!(_arg_4.textHeight == textHeight)));
            hasColor = ((_arg_4 == null) || (!(_arg_4.textColor == textColor)));
            hasXOffset = ((_arg_4 == null) || (!(_arg_4.xOffset == xOffset)));
            hasYOffset = ((_arg_4 == null) || (!(_arg_4.yOffset == yOffset)));
            if (hasFont)
            {
                _local_6 = (_local_6 | 0x08);
            };
            if (hasColor)
            {
                _local_6 = (_local_6 | 0x04);
            };
            if (hasYOffset)
            {
                _local_6 = (_local_6 | 0x02);
            };
            if (hasXOffset)
            {
                _local_6 = (_local_6 | 0x01);
            };
            _arg_1.writeUI8(_local_6);
            if (hasFont)
            {
                _arg_1.writeUI16(_SafeStr_341);
            };
            if (hasColor)
            {
                if (_arg_5 >= 2)
                {
                    _arg_1.writeRGBA(textColor);
                }
                else
                {
                    _arg_1.writeRGB(textColor);
                };
            };
            if (hasXOffset)
            {
                _arg_1.writeSI16(xOffset);
            };
            if (hasYOffset)
            {
                _arg_1.writeSI16(yOffset);
            };
            if (hasFont)
            {
                _arg_1.writeUI16(textHeight);
            };
            var _local_8:uint = _SafeStr_715.length;
            _arg_1.writeUI8(_local_8);
            _local_7 = 0;
            while (_local_7 < _local_8)
            {
                _arg_1.writeGLYPHENTRY(_SafeStr_715[_local_7], _arg_2, _arg_3);
                _local_7++;
            };
        }

        public function clone():SWFTextRecord
        {
            var _local_2:uint;
            var _local_1:SWFTextRecord = new SWFTextRecord();
            _local_1.type = type;
            _local_1.hasFont = hasFont;
            _local_1.hasColor = hasColor;
            _local_1.hasXOffset = hasXOffset;
            _local_1.hasYOffset = hasYOffset;
            _local_1._SafeStr_341 = _SafeStr_341;
            _local_1.textColor = textColor;
            _local_1.textHeight = textHeight;
            _local_1.xOffset = xOffset;
            _local_1.yOffset = yOffset;
            _local_2 = 0;
            while (_local_2 < _SafeStr_715.length)
            {
                _local_1.glyphEntries.push(_SafeStr_715[_local_2].clone());
                _local_2++;
            };
            return (_local_1);
        }

        public function toString(_arg_1:uint=0):String
        {
            var _local_3:uint;
            var _local_4:Array = [("Glyphs: " + _SafeStr_715.length.toString())];
            if (hasFont)
            {
                _local_4.push(("FontID: " + _SafeStr_341));
                _local_4.push(("Height: " + textHeight));
            };
            if (hasColor)
            {
                _local_4.push(("Color: " + ((_SafeStr_346 <= 2) ? ColorUtils.rgbToString(textColor) : ColorUtils.rgbaToString(textColor))));
            };
            if (hasXOffset)
            {
                _local_4.push(("XOffset: " + xOffset));
            };
            if (hasYOffset)
            {
                _local_4.push(("YOffset: " + yOffset));
            };
            var _local_2:String = _local_4.join(", ");
            _local_3 = 0;
            while (_local_3 < _SafeStr_715.length)
            {
                _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 2))) + "[") + _local_3) + "] ") + _SafeStr_715[_local_3].toString()));
                _local_3++;
            };
            return (_local_2);
        }


    }
}

