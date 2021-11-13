package com.codeazur.as3swf.tags
{
    import flash.utils.ByteArray;
    import com.codeazur.as3swf.SWFData;

    public class TagNameCharacter implements ITag 
    {

        public static const TYPE:uint = 40;

        protected var _SafeStr_720:uint;
        protected var _SafeStr_721:ByteArray;

        public function TagNameCharacter()
        {
            _SafeStr_721 = new ByteArray();
        }

        public function get characterId():uint
        {
            return (_SafeStr_720);
        }

        public function set characterId(_arg_1:uint):void
        {
            _SafeStr_720 = _arg_1;
        }

        public function get binaryData():ByteArray
        {
            return (_SafeStr_721);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            _SafeStr_720 = _arg_1.readUI16();
            if (_arg_2 > 2)
            {
                _arg_1.readBytes(_SafeStr_721, 0, (_arg_2 - 2));
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:SWFData = new SWFData();
            _local_3.writeUI16(_SafeStr_720);
            if (_SafeStr_721.length > 0)
            {
                _local_3.writeBytes(_SafeStr_721);
            };
            _arg_1.writeTagHeader(type, _local_3.length);
            _arg_1.writeBytes(_local_3);
        }

        public function clone():ITag
        {
            var _local_1:TagNameCharacter = new TagNameCharacter();
            _local_1.characterId = characterId;
            if (_SafeStr_721.length > 0)
            {
                _local_1.binaryData.writeBytes(_SafeStr_721);
            };
            return (_local_1);
        }

        public function get type():uint
        {
            return (40);
        }

        public function get name():String
        {
            return ("NameCharacter");
        }

        public function get version():uint
        {
            return (3);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            var _local_2:String = ((_SafeStr_64.toStringCommon(type, name, _arg_1) + "ID: ") + characterId);
            if (binaryData.length > 0)
            {
                binaryData.position = 0;
                _local_2 = (_local_2 + (", Name: " + binaryData.readUTFBytes((binaryData.length - 1))));
                binaryData.position = 0;
            };
            return (_local_2);
        }


    }
}

