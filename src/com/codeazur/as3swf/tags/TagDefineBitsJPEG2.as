package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.data.consts._SafeStr_95;

    public class TagDefineBitsJPEG2 extends TagDefineBits implements IDefinitionTag 
    {

        public static const TYPE:uint = 21;


        override public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            super.parse(_arg_1, _arg_2, _arg_3);
            if (((bitmapData[0] == 0xFF) && ((bitmapData[1] == 216) || (bitmapData[1] == 217))))
            {
                _SafeStr_334 = 1;
            }
            else
            {
                if (((((((((bitmapData[0] == 137) && (bitmapData[1] == 80)) && (bitmapData[2] == 78)) && (bitmapData[3] == 71)) && (bitmapData[4] == 13)) && (bitmapData[5] == 10)) && (bitmapData[6] == 26)) && (bitmapData[7] == 10)))
                {
                    _SafeStr_334 = 3;
                }
                else
                {
                    if (((((((bitmapData[0] == 71) && (bitmapData[1] == 73)) && (bitmapData[2] == 70)) && (bitmapData[3] == 56)) && (bitmapData[4] == 57)) && (bitmapData[5] == 97)))
                    {
                        _SafeStr_334 = 2;
                    };
                };
            };
        }

        override public function clone():IDefinitionTag
        {
            var _local_1:TagDefineBitsJPEG2 = new TagDefineBitsJPEG2();
            _local_1.characterId = characterId;
            _local_1._SafeStr_334 = _SafeStr_334;
            if (_bitmapData.length > 0)
            {
                _local_1.bitmapData.writeBytes(_bitmapData);
            };
            return (_local_1);
        }

        override public function get type():uint
        {
            return (21);
        }

        override public function get name():String
        {
            return ("DefineBitsJPEG2");
        }

        override public function get version():uint
        {
            return ((_SafeStr_334 == 1) ? 2 : 8);
        }

        override public function get level():uint
        {
            return (2);
        }

        override public function toString(_arg_1:uint=0):String
        {
            return ((((((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "ID: ") + characterId) + ", ") + "Type: ") + _SafeStr_95.toString(_SafeStr_334)) + ", ") + "BitmapLength: ") + bitmapData.length);
        }


    }
}

