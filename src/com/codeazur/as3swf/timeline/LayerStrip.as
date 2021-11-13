package com.codeazur.as3swf.timeline
{
    public class LayerStrip 
    {

        public static const _SafeStr_744:uint = 0;
        public static const TYPE_SPACER:uint = 1;
        public static const TYPE_STATIC:uint = 2;
        public static const TYPE_MOTIONTWEEN:uint = 3;
        public static const TYPE_SHAPETWEEN:uint = 4;

        public var type:uint = 0;
        public var _SafeStr_289:uint = 0;
        public var endFrameIndex:uint = 0;

        public function LayerStrip(_arg_1:uint, _arg_2:uint, _arg_3:uint)
        {
            this.type = _arg_1;
            this._SafeStr_289 = _arg_2;
            this.endFrameIndex = _arg_3;
        }

        public function toString():String
        {
            var _local_1:String;
            if (_SafeStr_289 == endFrameIndex)
            {
                _local_1 = ("Frame: " + _SafeStr_289);
            }
            else
            {
                _local_1 = ((("Frames: " + _SafeStr_289) + "-") + endFrameIndex);
            };
            _local_1 = (_local_1 + ", Type: ");
            switch (type)
            {
                case 0:
                    _local_1 = (_local_1 + "EMPTY");
                    break;
                case 1:
                    _local_1 = (_local_1 + "SPACER");
                    break;
                case 2:
                    _local_1 = (_local_1 + "STATIC");
                    break;
                case 3:
                    _local_1 = (_local_1 + "MOTIONTWEEN");
                    break;
                case 4:
                    _local_1 = (_local_1 + "SHAPETWEEN");
                    break;
                default:
                    _local_1 = (_local_1 + "unknown");
            };
            return (_local_1);
        }


    }
}

