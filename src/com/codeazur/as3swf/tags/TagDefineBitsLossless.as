package com.codeazur.as3swf.tags
{
    import flash.utils.ByteArray;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.data.consts._SafeStr_60;

    public class TagDefineBitsLossless implements IDefinitionTag 
    {

        public static const TYPE:uint = 20;

        public var _SafeStr_281:uint;
        public var bitmapWidth:uint;
        public var _SafeStr_267:uint;
        public var _SafeStr_282:uint;
        protected var _SafeStr_720:uint;
        protected var _SafeStr_723:ByteArray;

        public function TagDefineBitsLossless()
        {
            _SafeStr_723 = new ByteArray();
        }

        public function get characterId():uint
        {
            return (_SafeStr_720);
        }

        public function set characterId(_arg_1:uint):void
        {
            _SafeStr_720 = _arg_1;
        }

        public function get zlibBitmapData():ByteArray
        {
            return (_SafeStr_723);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            _SafeStr_720 = _arg_1.readUI16();
            _SafeStr_281 = _arg_1.readUI8();
            bitmapWidth = _arg_1.readUI16();
            _SafeStr_267 = _arg_1.readUI16();
            if (_SafeStr_281 == 3)
            {
                _SafeStr_282 = _arg_1.readUI8();
            };
            _arg_1.readBytes(zlibBitmapData, 0, (_arg_2 - ((_SafeStr_281 == 3) ? 8 : 7)));
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:SWFData = new SWFData();
            _local_3.writeUI16(_SafeStr_720);
            _local_3.writeUI8(_SafeStr_281);
            _local_3.writeUI16(bitmapWidth);
            _local_3.writeUI16(_SafeStr_267);
            if (_SafeStr_281 == 3)
            {
                _local_3.writeUI8(_SafeStr_282);
            };
            if (_SafeStr_723.length > 0)
            {
                _local_3.writeBytes(_SafeStr_723);
            };
            _arg_1.writeTagHeader(type, _local_3.length, true);
            _arg_1.writeBytes(_local_3);
        }

        public function clone():IDefinitionTag
        {
            var _local_1:TagDefineBitsLossless = new TagDefineBitsLossless();
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

        public function get type():uint
        {
            return (20);
        }

        public function get name():String
        {
            return ("DefineBitsLossless");
        }

        public function get version():uint
        {
            return (2);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            return (((((((((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "ID: ") + characterId) + ", ") + "Format: ") + _SafeStr_60.toString(_SafeStr_281)) + ", ") + "Size: (") + bitmapWidth) + ",") + _SafeStr_267) + ")");
        }


    }
}

