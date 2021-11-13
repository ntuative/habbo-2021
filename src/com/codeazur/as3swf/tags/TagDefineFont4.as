package com.codeazur.as3swf.tags
{
    import flash.utils.ByteArray;
    import com.codeazur.as3swf.SWFData;

    public class TagDefineFont4 implements IDefinitionTag 
    {

        public static const TYPE:uint = 91;

        public var hasFontData:Boolean;
        public var italic:Boolean;
        public var bold:Boolean;
        public var fontName:String;
        protected var _SafeStr_720:uint;
        protected var _SafeStr_730:ByteArray;

        public function TagDefineFont4()
        {
            _SafeStr_730 = new ByteArray();
        }

        public function get characterId():uint
        {
            return (_SafeStr_720);
        }

        public function set characterId(_arg_1:uint):void
        {
            _SafeStr_720 = _arg_1;
        }

        public function get fontData():ByteArray
        {
            return (_SafeStr_730);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            var _local_5:uint = _arg_1.position;
            _SafeStr_720 = _arg_1.readUI16();
            var _local_6:uint = _arg_1.readUI8();
            hasFontData = (!((_local_6 & 0x04) == 0));
            italic = (!((_local_6 & 0x02) == 0));
            bold = (!((_local_6 & 0x01) == 0));
            fontName = _arg_1.readString();
            if (((hasFontData) && (_arg_2 > (_arg_1.position - _local_5))))
            {
                _arg_1.readBytes(_SafeStr_730, 0, (_arg_2 - (_arg_1.position - _local_5)));
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_4:SWFData = new SWFData();
            _local_4.writeUI16(characterId);
            var _local_3:uint;
            if (hasFontData)
            {
                _local_3 = (_local_3 | 0x04);
            };
            if (italic)
            {
                _local_3 = (_local_3 | 0x02);
            };
            if (bold)
            {
                _local_3 = (_local_3 | 0x01);
            };
            _local_4.writeUI8(_local_3);
            _local_4.writeString(fontName);
            if (((hasFontData) && (_SafeStr_730.length > 0)))
            {
                _local_4.writeBytes(_SafeStr_730);
            };
            _arg_1.writeTagHeader(type, _local_4.length);
            _arg_1.writeBytes(_local_4);
        }

        public function clone():IDefinitionTag
        {
            var _local_1:TagDefineFont4 = new TagDefineFont4();
            _local_1.characterId = characterId;
            _local_1.hasFontData = hasFontData;
            _local_1.italic = italic;
            _local_1.bold = bold;
            _local_1.fontName = fontName;
            if (_SafeStr_730.length > 0)
            {
                _local_1.fontData.writeBytes(_SafeStr_730);
            };
            return (_local_1);
        }

        public function get type():uint
        {
            return (91);
        }

        public function get name():String
        {
            return ("DefineFont4");
        }

        public function get version():uint
        {
            return (10);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            return ((((((((((((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "ID: ") + characterId) + ", ") + "FontName: ") + fontName) + ", ") + "HasFontData: ") + hasFontData) + ", ") + "Italic: ") + italic) + ", ") + "Bold: ") + bold);
        }


    }
}

