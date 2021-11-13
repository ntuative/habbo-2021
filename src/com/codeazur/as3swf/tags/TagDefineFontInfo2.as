package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFData;

    public class TagDefineFontInfo2 extends TagDefineFontInfo implements ITag 
    {

        public static const TYPE:uint = 62;


        override protected function parseLangCode(_arg_1:SWFData):void
        {
            _SafeStr_371 = _arg_1.readUI8();
            langCodeLength = 1;
        }

        override protected function publishLangCode(_arg_1:SWFData):void
        {
            _arg_1.writeUI8(_SafeStr_371);
        }

        override public function get type():uint
        {
            return (62);
        }

        override public function get name():String
        {
            return ("DefineFontInfo2");
        }

        override public function get version():uint
        {
            return (6);
        }

        override public function get level():uint
        {
            return (2);
        }

        override public function toString(_arg_1:uint=0):String
        {
            return (((((((((((((((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "FontID: ") + _SafeStr_341) + ", ") + "FontName: ") + fontName) + ", ") + "Italic: ") + italic) + ", ") + "Bold: ") + bold) + ", ") + "LanguageCode: ") + _SafeStr_371) + ", ") + "Codes: ") + _SafeStr_726.length);
        }


    }
}

