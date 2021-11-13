package com.codeazur.as3swf.tags
{
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import com.codeazur.as3swf.SWFData;

    public class TagDefineFontInfo implements ITag 
    {

        public static const TYPE:uint = 13;

        public var _SafeStr_341:uint;
        public var fontName:String;
        public var smallText:Boolean;
        public var shiftJIS:Boolean;
        public var _SafeStr_344:Boolean;
        public var italic:Boolean;
        public var bold:Boolean;
        public var _SafeStr_345:Boolean;
        public var _SafeStr_371:uint = 0;
        protected var _SafeStr_726:Vector.<uint>;
        protected var langCodeLength:uint = 0;

        public function TagDefineFontInfo()
        {
            _SafeStr_726 = new Vector.<uint>();
        }

        public function get codeTable():Vector.<uint>
        {
            return (_SafeStr_726);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            var _local_8:uint;
            _SafeStr_341 = _arg_1.readUI16();
            var _local_7:uint = _arg_1.readUI8();
            var _local_9:ByteArray = new ByteArray();
            _arg_1.readBytes(_local_9, 0, _local_7);
            fontName = _local_9.readUTFBytes(_local_7);
            var _local_6:uint = _arg_1.readUI8();
            smallText = (!((_local_6 & 0x20) == 0));
            shiftJIS = (!((_local_6 & 0x10) == 0));
            _SafeStr_344 = (!((_local_6 & 0x08) == 0));
            italic = (!((_local_6 & 0x04) == 0));
            bold = (!((_local_6 & 0x02) == 0));
            _SafeStr_345 = (!((_local_6 & 0x01) == 0));
            parseLangCode(_arg_1);
            var _local_5:uint = (((_arg_2 - _local_7) - langCodeLength) - 4);
            _local_8 = 0;
            while (_local_8 < _local_5)
            {
                _SafeStr_726.push(((_SafeStr_345) ? _arg_1.readUI16() : _arg_1.readUI8()));
                _local_8++;
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_5:uint;
            var _local_6:SWFData = new SWFData();
            _local_6.writeUI16(_SafeStr_341);
            var _local_7:ByteArray = new ByteArray();
            _local_7.writeUTFBytes(fontName);
            _local_6.writeUI8(_local_7.length);
            _local_6.writeBytes(_local_7);
            var _local_4:uint;
            if (smallText)
            {
                _local_4 = (_local_4 | 0x20);
            };
            if (shiftJIS)
            {
                _local_4 = (_local_4 | 0x10);
            };
            if (_SafeStr_344)
            {
                _local_4 = (_local_4 | 0x08);
            };
            if (italic)
            {
                _local_4 = (_local_4 | 0x04);
            };
            if (bold)
            {
                _local_4 = (_local_4 | 0x02);
            };
            if (_SafeStr_345)
            {
                _local_4 = (_local_4 | 0x01);
            };
            _local_6.writeUI8(_local_4);
            publishLangCode(_local_6);
            var _local_3:uint = _SafeStr_726.length;
            _local_5 = 0;
            while (_local_5 < _local_3)
            {
                if (_SafeStr_345)
                {
                    _local_6.writeUI16(_SafeStr_726[_local_5]);
                }
                else
                {
                    _local_6.writeUI8(_SafeStr_726[_local_5]);
                };
                _local_5++;
            };
            _arg_1.writeTagHeader(type, _local_6.length);
            _arg_1.writeBytes(_local_6);
        }

        protected function parseLangCode(_arg_1:SWFData):void
        {
        }

        protected function publishLangCode(_arg_1:SWFData):void
        {
        }

        public function get type():uint
        {
            return (13);
        }

        public function get name():String
        {
            return ("DefineFontInfo");
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
            return ((((((((((((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "FontID: ") + _SafeStr_341) + ", ") + "FontName: ") + fontName) + ", ") + "Italic: ") + italic) + ", ") + "Bold: ") + bold) + ", ") + "Codes: ") + _SafeStr_726.length);
        }


    }
}

