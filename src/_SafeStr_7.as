package 
{
    import flash.display.Sprite;
    import flash.utils.ByteArray;
    import flash.utils.Endian;

    public class _SafeStr_7 extends Sprite 
    {

        private static var _SafeStr_252:Class = _SafeStr_9;
        private static var _SafeStr_253:Class;
        private static var _SafeStr_254:Class;
        private static var _SafeStr_258:Array;
        private static var _SafeStr_257:Array;
        private static var _SafeStr_260:Boolean = false;
        private static var _SafeStr_262:int;

        {
            while ((_SafeStr_253 = _SafeStr_11), (_SafeStr_254 = _SafeStr_8), (_SafeStr_258 = new Array()), true)
            {
                _SafeStr_257 = new Array();
                break;
            };
        }


        private static function _SafeStr_261():void
        {
            var _local_1:ByteArray = (new _SafeStr_252() as ByteArray);
            var _local_2:ByteArray = (new _SafeStr_253() as ByteArray);
            var _local_3:ByteArray = (new _SafeStr_254() as ByteArray);
            _local_3.endian = Endian.LITTLE_ENDIAN;
            _SafeStr_262 = _local_3.readInt();
            var _local_4:int = _local_2.readByte();
            var _local_5:int;
            while (_local_5 < _local_4)
            {
                _SafeStr_255(_local_2);
                _local_5++;
            };
            _local_4 = _local_1.readInt();
            var _local_6:int;
            while (_local_6 < _local_4)
            {
                while (_SafeStr_256(_local_1, _SafeStr_257[(_local_6 % _SafeStr_257.length)]), true)
                {
                    _local_6++;
                    break;
                };
            };
            _SafeStr_260 = true;
        }

        private static function _SafeStr_256(_arg_1:ByteArray, _arg_2:ByteArray):void
        {
            var _local_3:int = _arg_1.readInt();
            var _local_4:ByteArray = new ByteArray();
            _arg_1.readBytes(_local_4, 0, _local_3);
            var _local_5:_SafeStr_10 = new _SafeStr_10(_arg_2);
            _local_5._SafeStr_259(_local_4);
            _local_4.position = 0;
            _SafeStr_258.push(_local_4.readUTFBytes(_local_4.length));
        }

        private static function _SafeStr_255(_arg_1:ByteArray):void
        {
            var _local_2:ByteArray = new ByteArray();
            _arg_1.readBytes(_local_2, 0, 16);
            _local_2.position = 0;
            _SafeStr_257.push(_local_2);
        }

        public static function _SafeStr_251(_arg_1:int):String
        {
            if (!_SafeStr_260)
            {
                _SafeStr_261();
            };
            return (_SafeStr_258[(_arg_1 ^ _SafeStr_262)]);
        }


    }
}

