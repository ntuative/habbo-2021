package com.hurlant.crypto.hash
{
    import flash.utils.ByteArray;

    public class SHABase implements IHash 
    {

        public var pad_size:int = 40;


        public function getInputSize():uint
        {
            return (64);
        }

        public function getHashSize():uint
        {
            return (0);
        }

        public function getPadSize():int
        {
            return (pad_size);
        }

        public function hash(_arg_1:ByteArray):ByteArray
        {
            var _local_7:uint;
            var _local_6:uint = _arg_1.length;
            var _local_8:String = _arg_1.endian;
            _arg_1.endian = "bigEndian";
            var _local_3:uint = (_local_6 * 8);
            while ((_arg_1.length % 4) != 0)
            {
                _arg_1[_arg_1.length] = 0;
            };
            _arg_1.position = 0;
            var _local_2:Array = [];
            _local_7 = 0;
            while (_local_7 < _arg_1.length)
            {
                _local_2.push(_arg_1.readUnsignedInt());
                _local_7 = (_local_7 + 4);
            };
            var _local_4:Array = core(_local_2, _local_3);
            var _local_9:ByteArray = new ByteArray();
            var _local_5:uint = uint((getHashSize() / 4));
            _local_7 = 0;
            while (_local_7 < _local_5)
            {
                _local_9.writeUnsignedInt(_local_4[_local_7]);
                _local_7++;
            };
            _arg_1.length = _local_6;
            _arg_1.endian = _local_8;
            return (_local_9);
        }

        protected function core(_arg_1:Array, _arg_2:uint):Array
        {
            return (null);
        }

        public function toString():String
        {
            return ("sha");
        }


    }
}