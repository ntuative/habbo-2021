package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.data.consts.SoundCompression;
    import com.codeazur.as3swf.data.consts._SafeStr_77;
    import com.codeazur.as3swf.data.consts._SafeStr_79;
    import com.codeazur.as3swf.data.consts._SafeStr_82;

    public class TagSoundStreamHead implements ITag 
    {

        public static const TYPE:uint = 18;

        public var _SafeStr_294:uint;
        public var _SafeStr_295:uint;
        public var _SafeStr_296:uint;
        public var streamSoundCompression:uint;
        public var _SafeStr_274:uint;
        public var _SafeStr_276:uint;
        public var _SafeStr_277:uint;
        public var _SafeStr_297:uint;
        public var _SafeStr_298:uint;


        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            _arg_1.readUB(4);
            _SafeStr_294 = _arg_1.readUB(2);
            _SafeStr_295 = _arg_1.readUB(1);
            _SafeStr_296 = _arg_1.readUB(1);
            streamSoundCompression = _arg_1.readUB(4);
            _SafeStr_274 = _arg_1.readUB(2);
            _SafeStr_276 = _arg_1.readUB(1);
            _SafeStr_277 = _arg_1.readUB(1);
            _SafeStr_297 = _arg_1.readUI16();
            if (streamSoundCompression == 2)
            {
                _SafeStr_298 = _arg_1.readSI16();
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:SWFData = new SWFData();
            _local_3.writeUB(4, 0);
            _local_3.writeUB(2, _SafeStr_294);
            _local_3.writeUB(1, _SafeStr_295);
            _local_3.writeUB(1, _SafeStr_296);
            _local_3.writeUB(4, streamSoundCompression);
            _local_3.writeUB(2, _SafeStr_274);
            _local_3.writeUB(1, _SafeStr_276);
            _local_3.writeUB(1, _SafeStr_277);
            _local_3.writeUI16(_SafeStr_297);
            if (streamSoundCompression == 2)
            {
                _local_3.writeSI16(_SafeStr_298);
            };
            _arg_1.writeTagHeader(type, _local_3.length);
            _arg_1.writeBytes(_local_3);
        }

        public function get type():uint
        {
            return (18);
        }

        public function get name():String
        {
            return ("SoundStreamHead");
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
            var _local_2:String = _SafeStr_64.toStringCommon(type, name, _arg_1);
            if (_SafeStr_297 > 0)
            {
                _local_2 = (_local_2 + ((((((((((("Format: " + SoundCompression.toString(streamSoundCompression)) + ", ") + "Rate: ") + _SafeStr_77.toString(_SafeStr_274)) + ", ") + "Size: ") + _SafeStr_79.toString(_SafeStr_276)) + ", ") + "Type: ") + _SafeStr_82.toString(_SafeStr_277)) + ", "));
            };
            _local_2 = (_local_2 + (("Samples: " + _SafeStr_297) + ", "));
            return (_local_2 + ("LatencySeek: " + _SafeStr_298));
        }


    }
}

