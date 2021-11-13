package com.hurlant.crypto.prng
{
    import com.hurlant.crypto.symmetric.IStreamCipher;
    import flash.utils.ByteArray;
    import com.hurlant.util._SafeStr_65;

    public class ARC4 implements IPRNG, IStreamCipher 
    {

        private const _SafeStr_755:uint = 0x0100;

        private var i:int = 0;
        private var j:int = 0;
        private var S:ByteArray;

        public function ARC4(_arg_1:ByteArray=null)
        {
            S = new ByteArray();
            if (_arg_1)
            {
                init(_arg_1);
            };
        }

        public function getPoolSize():uint
        {
            return (0x0100);
        }

        public function init(_arg_1:ByteArray):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_2:int;
            _local_3 = 0;
            while (_local_3 < 0x0100)
            {
                S[_local_3] = _local_3;
                _local_3++;
            };
            _local_4 = 0;
            _local_3 = 0;
            while (_local_3 < 0x0100)
            {
                _local_4 = (((_local_4 + S[_local_3]) + _arg_1[(_local_3 % _arg_1.length)]) & 0xFF);
                _local_2 = S[_local_3];
                S[_local_3] = S[_local_4];
                S[_local_4] = _local_2;
                _local_3++;
            };
            this.i = 0;
            this.j = 0;
        }

        public function next():uint
        {
            var _local_1:int;
            i = ((i + 1) & 0xFF);
            j = ((j + S[i]) & 0xFF);
            _local_1 = S[i];
            S[i] = S[j];
            S[j] = _local_1;
            return (S[((_local_1 + S[i]) & 0xFF)]);
        }

        public function getBlockSize():uint
        {
            return (1);
        }

        public function encrypt(_arg_1:ByteArray):void
        {
            var _local_2:uint;
            while (_local_2 < _arg_1.length)
            {
                var _local_3:* = _local_2++;
                var _local_4:* = (_arg_1[_local_3] ^ next());
                _arg_1[_local_3] = _local_4;
            };
        }

        public function decrypt(_arg_1:ByteArray):void
        {
            encrypt(_arg_1);
        }

        public function dispose():void
        {
            var _local_1:uint;
            if (S != null)
            {
                _local_1 = 0;
                while (_local_1 < S.length)
                {
                    S[_local_1] = (Math.random() * 0x0100);
                    _local_1++;
                };
                S.length = 0;
                S = null;
            };
            this.i = 0;
            this.j = 0;
            _SafeStr_65.gc();
        }

        public function toString():String
        {
            return ("rc4");
        }


    }
}

