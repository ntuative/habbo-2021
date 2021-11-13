package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.data.consts._SafeStr_95;

    public class TagDefineBitsJPEG4 extends TagDefineBitsJPEG3 implements IDefinitionTag 
    {

        public static const TYPE:uint = 90;

        public var _SafeStr_335:Number;


        override public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            _SafeStr_720 = _arg_1.readUI16();
            var _local_5:uint = _arg_1.readUI32();
            _SafeStr_335 = _arg_1.readFIXED8();
            _arg_1.readBytes(_bitmapData, 0, _local_5);
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
            var _local_6:uint = ((_arg_2 - _local_5) - 6);
            if (_local_6 > 0)
            {
                _arg_1.readBytes(_SafeStr_722, 0, _local_6);
            };
        }

        override public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            _arg_1.writeTagHeader(type, ((_bitmapData.length + _SafeStr_722.length) + 6), true);
            _arg_1.writeUI16(characterId);
            _arg_1.writeUI32(_bitmapData.length);
            _arg_1.writeFIXED8(_SafeStr_335);
            if (_bitmapData.length > 0)
            {
                _arg_1.writeBytes(_bitmapData);
            };
            if (_SafeStr_722.length > 0)
            {
                _arg_1.writeBytes(_SafeStr_722);
            };
        }

        override public function clone():IDefinitionTag
        {
            var _local_1:TagDefineBitsJPEG4 = new TagDefineBitsJPEG4();
            _local_1.characterId = characterId;
            _local_1._SafeStr_334 = _SafeStr_334;
            _local_1._SafeStr_335 = _SafeStr_335;
            if (_bitmapData.length > 0)
            {
                _local_1.bitmapData.writeBytes(_bitmapData);
            };
            if (_SafeStr_722.length > 0)
            {
                _local_1.bitmapAlphaData.writeBytes(_SafeStr_722);
            };
            return (_local_1);
        }

        override public function get type():uint
        {
            return (90);
        }

        override public function get name():String
        {
            return ("DefineBitsJPEG4");
        }

        override public function get version():uint
        {
            return (10);
        }

        override public function get level():uint
        {
            return (4);
        }

        override public function toString(_arg_1:uint=0):String
        {
            return (((((((((((((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "ID: ") + characterId) + ", ") + "Type: ") + _SafeStr_95.toString(_SafeStr_334)) + ", ") + "DeblockParam: ") + _SafeStr_335) + ", ") + "HasAlphaData: ") + (_SafeStr_722.length > 0)) + ", ") + ((_SafeStr_722.length > 0) ? (("BitmapAlphaLength: " + _SafeStr_722.length) + ", ") : "")) + "BitmapLength: ") + _bitmapData.length);
        }


    }
}

