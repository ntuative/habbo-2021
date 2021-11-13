package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFData;

    public class TagDefineFontName implements ITag 
    {

        public static const TYPE:uint = 88;

        public var _SafeStr_341:uint;
        public var fontName:String;
        public var fontCopyright:String;


        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            _SafeStr_341 = _arg_1.readUI16();
            fontName = _arg_1.readString();
            fontCopyright = _arg_1.readString();
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:SWFData = new SWFData();
            _local_3.writeUI16(_SafeStr_341);
            _local_3.writeString(fontName);
            _local_3.writeString(fontCopyright);
            _arg_1.writeTagHeader(type, _local_3.length);
            _arg_1.writeBytes(_local_3);
        }

        public function get type():uint
        {
            return (88);
        }

        public function get name():String
        {
            return ("DefineFontName");
        }

        public function get version():uint
        {
            return (9);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            return ((((((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "FontID: ") + _SafeStr_341) + ", ") + "Name: ") + fontName) + ", ") + "Copyright: ") + fontCopyright);
        }


    }
}

