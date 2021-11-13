package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.data.SWFRectangle;
    import com.codeazur.as3swf.SWFData;

    public class TagDefineEditText implements IDefinitionTag 
    {

        public static const TYPE:uint = 37;

        public var _SafeStr_368:SWFRectangle;
        public var variableName:String;
        public var hasText:Boolean;
        public var wordWrap:Boolean;
        public var multiline:Boolean;
        public var password:Boolean;
        public var readOnly:Boolean;
        public var hasTextColor:Boolean;
        public var hasMaxLength:Boolean;
        public var hasFont:Boolean;
        public var hasFontClass:Boolean;
        public var autoSize:Boolean;
        public var hasLayout:Boolean;
        public var noSelect:Boolean;
        public var border:Boolean;
        public var wasStatic:Boolean;
        public var html:Boolean;
        public var useOutlines:Boolean;
        public var _SafeStr_341:uint;
        public var _SafeStr_369:String;
        public var _SafeStr_370:uint;
        public var textColor:uint;
        public var maxLength:uint;
        public var align:uint;
        public var leftMargin:uint;
        public var rightMargin:uint;
        public var indent:uint;
        public var leading:int;
        public var initialText:String;
        protected var _SafeStr_720:uint;


        public function get characterId():uint
        {
            return (_SafeStr_720);
        }

        public function set characterId(_arg_1:uint):void
        {
            _SafeStr_720 = _arg_1;
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            _SafeStr_720 = _arg_1.readUI16();
            _SafeStr_368 = _arg_1.readRECT();
            var _local_6:uint = _arg_1.readUI8();
            hasText = (!((_local_6 & 0x80) == 0));
            wordWrap = (!((_local_6 & 0x40) == 0));
            multiline = (!((_local_6 & 0x20) == 0));
            password = (!((_local_6 & 0x10) == 0));
            readOnly = (!((_local_6 & 0x08) == 0));
            hasTextColor = (!((_local_6 & 0x04) == 0));
            hasMaxLength = (!((_local_6 & 0x02) == 0));
            hasFont = (!((_local_6 & 0x01) == 0));
            var _local_5:uint = _arg_1.readUI8();
            hasFontClass = (!((_local_5 & 0x80) == 0));
            autoSize = (!((_local_5 & 0x40) == 0));
            hasLayout = (!((_local_5 & 0x20) == 0));
            noSelect = (!((_local_5 & 0x10) == 0));
            border = (!((_local_5 & 0x08) == 0));
            wasStatic = (!((_local_5 & 0x04) == 0));
            html = (!((_local_5 & 0x02) == 0));
            useOutlines = (!((_local_5 & 0x01) == 0));
            if (hasFont)
            {
                _SafeStr_341 = _arg_1.readUI16();
            };
            if (hasFontClass)
            {
                _SafeStr_369 = _arg_1.readString();
            };
            if (hasFont)
            {
                _SafeStr_370 = _arg_1.readUI16();
            };
            if (hasTextColor)
            {
                textColor = _arg_1.readRGBA();
            };
            if (hasMaxLength)
            {
                maxLength = _arg_1.readUI16();
            };
            if (hasLayout)
            {
                align = _arg_1.readUI8();
                leftMargin = _arg_1.readUI16();
                rightMargin = _arg_1.readUI16();
                indent = _arg_1.readUI16();
                leading = _arg_1.readSI16();
            };
            variableName = _arg_1.readString();
            if (hasText)
            {
                initialText = _arg_1.readString();
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_5:SWFData = new SWFData();
            _local_5.writeUI16(characterId);
            _local_5.writeRECT(_SafeStr_368);
            var _local_4:uint;
            if (hasText)
            {
                _local_4 = (_local_4 | 0x80);
            };
            if (wordWrap)
            {
                _local_4 = (_local_4 | 0x40);
            };
            if (multiline)
            {
                _local_4 = (_local_4 | 0x20);
            };
            if (password)
            {
                _local_4 = (_local_4 | 0x10);
            };
            if (readOnly)
            {
                _local_4 = (_local_4 | 0x08);
            };
            if (hasTextColor)
            {
                _local_4 = (_local_4 | 0x04);
            };
            if (hasMaxLength)
            {
                _local_4 = (_local_4 | 0x02);
            };
            if (hasFont)
            {
                _local_4 = (_local_4 | 0x01);
            };
            _local_5.writeUI8(_local_4);
            var _local_3:uint;
            if (hasFontClass)
            {
                _local_3 = (_local_3 | 0x80);
            };
            if (autoSize)
            {
                _local_3 = (_local_3 | 0x40);
            };
            if (hasLayout)
            {
                _local_3 = (_local_3 | 0x20);
            };
            if (noSelect)
            {
                _local_3 = (_local_3 | 0x10);
            };
            if (border)
            {
                _local_3 = (_local_3 | 0x08);
            };
            if (wasStatic)
            {
                _local_3 = (_local_3 | 0x04);
            };
            if (html)
            {
                _local_3 = (_local_3 | 0x02);
            };
            if (useOutlines)
            {
                _local_3 = (_local_3 | 0x01);
            };
            _local_5.writeUI8(_local_3);
            if (hasFont)
            {
                _local_5.writeUI16(_SafeStr_341);
            };
            if (hasFontClass)
            {
                _local_5.writeString(_SafeStr_369);
            };
            if (hasFont)
            {
                _local_5.writeUI16(_SafeStr_370);
            };
            if (hasTextColor)
            {
                _local_5.writeRGBA(textColor);
            };
            if (hasMaxLength)
            {
                _local_5.writeUI16(maxLength);
            };
            if (hasLayout)
            {
                _local_5.writeUI8(align);
                _local_5.writeUI16(leftMargin);
                _local_5.writeUI16(rightMargin);
                _local_5.writeUI16(indent);
                _local_5.writeSI16(leading);
            };
            _local_5.writeString(variableName);
            if (hasText)
            {
                _local_5.writeString(initialText);
            };
            _arg_1.writeTagHeader(type, _local_5.length);
            _arg_1.writeBytes(_local_5);
        }

        public function clone():IDefinitionTag
        {
            var _local_1:TagDefineEditText = new TagDefineEditText();
            _local_1.characterId = characterId;
            _local_1._SafeStr_368 = _SafeStr_368.clone();
            _local_1.variableName = variableName;
            _local_1.hasText = hasText;
            _local_1.wordWrap = wordWrap;
            _local_1.multiline = multiline;
            _local_1.password = password;
            _local_1.readOnly = readOnly;
            _local_1.hasTextColor = hasTextColor;
            _local_1.hasMaxLength = hasMaxLength;
            _local_1.hasFont = hasFont;
            _local_1.hasFontClass = hasFontClass;
            _local_1.autoSize = autoSize;
            _local_1.hasLayout = hasLayout;
            _local_1.noSelect = noSelect;
            _local_1.border = border;
            _local_1.wasStatic = wasStatic;
            _local_1.html = html;
            _local_1.useOutlines = useOutlines;
            _local_1._SafeStr_341 = _SafeStr_341;
            _local_1._SafeStr_369 = _SafeStr_369;
            _local_1._SafeStr_370 = _SafeStr_370;
            _local_1.textColor = textColor;
            _local_1.maxLength = maxLength;
            _local_1.align = align;
            _local_1.leftMargin = leftMargin;
            _local_1.rightMargin = rightMargin;
            _local_1.indent = indent;
            _local_1.leading = leading;
            _local_1.initialText = initialText;
            return (_local_1);
        }

        public function get type():uint
        {
            return (37);
        }

        public function get name():String
        {
            return ("DefineEditText");
        }

        public function get version():uint
        {
            return (4);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            return (((((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "ID: ") + characterId) + ", ") + (((hasText) && (initialText.length > 0)) ? (("Text: " + initialText) + ", ") : "")) + ((variableName.length > 0) ? (("VariableName: " + variableName) + ", ") : "")) + "Bounds: ") + _SafeStr_368);
        }


    }
}

