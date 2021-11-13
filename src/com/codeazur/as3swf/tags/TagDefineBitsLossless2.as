package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.data.consts._SafeStr_60;

    public class TagDefineBitsLossless2 extends TagDefineBitsLossless implements IDefinitionTag 
    {

        public static const TYPE:uint = 36;


        override public function clone():IDefinitionTag
        {
            var _local_1:TagDefineBitsLossless2 = new TagDefineBitsLossless2();
            _local_1.characterId = characterId;
            _local_1._SafeStr_281 = _SafeStr_281;
            _local_1.bitmapWidth = bitmapWidth;
            _local_1._SafeStr_267 = _SafeStr_267;
            if (_SafeStr_723.length > 0)
            {
                _local_1.zlibBitmapData.writeBytes(_SafeStr_723);
            };
            return (_local_1);
        }

        override public function get type():uint
        {
            return (36);
        }

        override public function get name():String
        {
            return ("DefineBitsLossless2");
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
            return (((((((((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "ID: ") + characterId) + ", ") + "Format: ") + _SafeStr_60.toString(_SafeStr_281)) + ", ") + "Size: (") + bitmapWidth) + ",") + _SafeStr_267) + ")");
        }


    }
}

