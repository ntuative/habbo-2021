package com.codeazur.as3swf.tags
{
    import flash.utils.ByteArray;
    import com.codeazur.as3swf.SWFData;

    public class TagSoundStreamBlock implements ITag 
    {

        public static const TYPE:uint = 19;

        protected var _SafeStr_735:ByteArray;

        public function TagSoundStreamBlock()
        {
            _SafeStr_735 = new ByteArray();
        }

        public function get soundData():ByteArray
        {
            return (_SafeStr_735);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            _arg_1.readBytes(_SafeStr_735, 0, _arg_2);
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            _arg_1.writeTagHeader(type, _SafeStr_735.length, true);
            if (_SafeStr_735.length > 0)
            {
                _arg_1.writeBytes(_SafeStr_735);
            };
        }

        public function get type():uint
        {
            return (19);
        }

        public function get name():String
        {
            return ("SoundStreamBlock");
        }

        public function get version():uint
        {
            return (1);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            return ((_SafeStr_64.toStringCommon(type, name, _arg_1) + "Length: ") + _SafeStr_735.length);
        }


    }
}

