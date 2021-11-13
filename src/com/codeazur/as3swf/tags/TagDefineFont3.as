package com.codeazur.as3swf.tags
{
    public class TagDefineFont3 extends TagDefineFont2 implements IDefinitionTag 
    {

        public static const TYPE:uint = 75;


        override public function get type():uint
        {
            return (75);
        }

        override public function get name():String
        {
            return ("DefineFont3");
        }

        override public function get version():uint
        {
            return (8);
        }

        override public function get level():uint
        {
            return (2);
        }

        override protected function get unitDivisor():Number
        {
            return (20);
        }

        override public function toString(_arg_1:uint=0):String
        {
            var _local_2:String = ((((((((((((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "ID: ") + characterId) + ", ") + "FontName: ") + fontName) + ", ") + "Italic: ") + italic) + ", ") + "Bold: ") + bold) + ", ") + "Glyphs: ") + _SafeStr_725.length);
            return (_local_2 + toStringCommon(_arg_1));
        }


    }
}

