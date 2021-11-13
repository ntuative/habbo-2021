package com.codeazur.as3swf.timeline
{
    import flash.utils.ByteArray;

    public class SoundStream 
    {

        public var startFrame:uint;
        public var _SafeStr_278:uint;
        public var _SafeStr_279:uint;
        public var compression:uint;
        public var _SafeStr_275:uint;
        public var size:uint;
        public var type:uint;
        protected var _SafeStr_690:ByteArray;

        public function SoundStream()
        {
            _SafeStr_690 = new ByteArray();
        }

        public function get data():ByteArray
        {
            return (_SafeStr_690);
        }

        public function toString():String
        {
            return (((((((((("[SoundStream] StartFrame: " + startFrame) + ", ") + "Frames: ") + _SafeStr_278) + ", ") + "Samples: ") + _SafeStr_279) + ", ") + "Bytes: ") + data.length);
        }


    }
}

