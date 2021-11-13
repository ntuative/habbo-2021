package com.hurlant.crypto.rsa
{
    import com.hurlant.math.BigInteger;
    import com.hurlant.crypto.prng.Random;
    import flash.utils.ByteArray;
    import flash.system.System;
    import com.hurlant.crypto.tls.TLSError;

    public class RSAKey 
    {

        public var e:int;
        public var n:BigInteger;
        public var d:BigInteger;
        public var p:BigInteger;
        public var q:BigInteger;
        public var dmp1:BigInteger;
        public var dmq1:BigInteger;
        public var _SafeStr_644:BigInteger;
        protected var canDecrypt:Boolean;
        protected var canEncrypt:Boolean;

        public function RSAKey(_arg_1:BigInteger, _arg_2:int, _arg_3:BigInteger=null, _arg_4:BigInteger=null, _arg_5:BigInteger=null, _arg_6:BigInteger=null, _arg_7:BigInteger=null, _arg_8:BigInteger=null)
        {
            this.n = _arg_1;
            this.e = _arg_2;
            this.d = _arg_3;
            this.p = _arg_4;
            this.q = _arg_5;
            this.dmp1 = _arg_6;
            this.dmq1 = _arg_7;
            this._SafeStr_644 = _arg_8;
            canEncrypt = ((!(n == null)) && (!(e == 0)));
            canDecrypt = ((canEncrypt) && (!(d == null)));
        }

        public static function parsePublicKey(_arg_1:String, _arg_2:String):RSAKey
        {
            return (new RSAKey(new BigInteger(_arg_1, 16, true), parseInt(_arg_2, 16)));
        }

        public static function parsePrivateKey(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String=null, _arg_5:String=null, _arg_6:String=null, _arg_7:String=null, _arg_8:String=null):RSAKey
        {
            if (_arg_4 == null)
            {
                return (new RSAKey(new BigInteger(_arg_1, 16, true), parseInt(_arg_2, 16), new BigInteger(_arg_3, 16, true)));
            };
            return (new RSAKey(new BigInteger(_arg_1, 16, true), parseInt(_arg_2, 16), new BigInteger(_arg_3, 16, true), new BigInteger(_arg_4, 16, true), new BigInteger(_arg_5, 16, true), new BigInteger(_arg_6, 16, true), new BigInteger(_arg_7, 16, true), new BigInteger(_arg_8, 16, true)));
        }

        public static function generate(_arg_1:uint, _arg_2:String):RSAKey
        {
            var _local_8:BigInteger;
            var _local_6:BigInteger;
            var _local_4:BigInteger;
            var _local_5:BigInteger;
            var _local_9:Random = new Random();
            var _local_7:uint = (_arg_1 >> 1);
            var _local_10:RSAKey = new RSAKey(null, 0, null);
            _local_10.e = parseInt(_arg_2, 16);
            var _local_3:BigInteger = new BigInteger(_arg_2, 16, true);
            while (true)
            {
                while (true)
                {
                    _local_10.p = bigRandom((_arg_1 - _local_7), _local_9);
                    if (((_local_10.p.subtract(BigInteger._SafeStr_269).gcd(_local_3).compareTo(BigInteger._SafeStr_269) == 0) && (_local_10.p.isProbablePrime(10)))) break;
                };
                while (true)
                {
                    _local_10.q = bigRandom(_local_7, _local_9);
                    if (((_local_10.q.subtract(BigInteger._SafeStr_269).gcd(_local_3).compareTo(BigInteger._SafeStr_269) == 0) && (_local_10.q.isProbablePrime(10)))) break;
                };
                if (_local_10.p.compareTo(_local_10.q) <= 0)
                {
                    _local_8 = _local_10.p;
                    _local_10.p = _local_10.q;
                    _local_10.q = _local_8;
                };
                _local_6 = _local_10.p.subtract(BigInteger._SafeStr_269);
                _local_4 = _local_10.q.subtract(BigInteger._SafeStr_269);
                _local_5 = _local_6.multiply(_local_4);
                if (_local_5.gcd(_local_3).compareTo(BigInteger._SafeStr_269) == 0)
                {
                    _local_10.n = _local_10.p.multiply(_local_10.q);
                    _local_10.d = _local_3.modInverse(_local_5);
                    _local_10.dmp1 = _local_10.d.mod(_local_6);
                    _local_10.dmq1 = _local_10.d.mod(_local_4);
                    _local_10._SafeStr_644 = _local_10.q.modInverse(_local_10.p);
                    break;
                };
            };
            _local_10.canEncrypt = ((!(_local_10.n == null)) && (!(_local_10.e == 0)));
            _local_10.canDecrypt = ((_local_10.canEncrypt) && (!(_local_10.d == null)));
            return (_local_10);
        }

        protected static function bigRandom(_arg_1:int, _arg_2:Random):BigInteger
        {
            if (_arg_1 < 2)
            {
                return (BigInteger.nbv(1));
            };
            var _local_4:ByteArray = new ByteArray();
            _arg_2.nextBytes(_local_4, (_arg_1 >> 3));
            _local_4.position = 0;
            var _local_3:BigInteger = new BigInteger(_local_4, 0, true);
            _local_3.primify(_arg_1, 1);
            return (_local_3);
        }


        public function getBlockSize():uint
        {
            return ((n.bitLength() + 7) / 8);
        }

        public function dispose():void
        {
            e = 0;
            n.dispose();
            n = null;
            System.pauseForGCIfCollectionImminent();
        }

        public function encrypt(_arg_1:ByteArray, _arg_2:ByteArray, _arg_3:uint, _arg_4:Function=null):void
        {
            _encrypt(doPublic, _arg_1, _arg_2, _arg_3, _arg_4, 2);
        }

        public function decrypt(_arg_1:ByteArray, _arg_2:ByteArray, _arg_3:uint, _arg_4:Function=null):void
        {
            _decrypt(doPrivate2, _arg_1, _arg_2, _arg_3, _arg_4, 2);
        }

        public function sign(_arg_1:ByteArray, _arg_2:ByteArray, _arg_3:uint, _arg_4:Function=null):void
        {
            _encrypt(doPrivate2, _arg_1, _arg_2, _arg_3, _arg_4, 1);
        }

        public function verify(_arg_1:ByteArray, _arg_2:ByteArray, _arg_3:uint, _arg_4:Function=null):void
        {
            _decrypt(doPublic, _arg_1, _arg_2, _arg_3, _arg_4, 1);
        }

        private function _encrypt(_arg_1:Function, _arg_2:ByteArray, _arg_3:ByteArray, _arg_4:uint, _arg_5:Function, _arg_6:int):void
        {
            var _local_11:BigInteger;
            var _local_8:BigInteger;
            var _local_7:uint;
            if (_arg_5 == null)
            {
                _arg_5 = pkcs1pad;
            };
            if (_arg_2.position >= _arg_2.length)
            {
                _arg_2.position = 0;
            };
            var _local_9:uint = getBlockSize();
            var _local_10:int = (_arg_2.position + _arg_4);
            while (_arg_2.position < _local_10)
            {
                _local_11 = new BigInteger(_arg_5(_arg_2, _local_10, _local_9, _arg_6), _local_9, true);
                _local_8 = _arg_1(_local_11);
                _local_7 = uint((_local_9 - Math.ceil((_local_8.bitLength() / 8))));
                while (_local_7 > 0)
                {
                    _arg_3.writeByte(0);
                    _local_7--;
                };
                _local_8.toArray(_arg_3);
            };
        }

        private function _decrypt(_arg_1:Function, _arg_2:ByteArray, _arg_3:ByteArray, _arg_4:uint, _arg_5:Function, _arg_6:int):void
        {
            var _local_11:BigInteger;
            var _local_8:BigInteger;
            var _local_7:ByteArray;
            if (_arg_5 == null)
            {
                _arg_5 = pkcs1unpad;
            };
            if (_arg_2.position >= _arg_2.length)
            {
                _arg_2.position = 0;
            };
            var _local_9:uint = getBlockSize();
            var _local_10:int = (_arg_2.position + _arg_4);
            while (_arg_2.position < _local_10)
            {
                _local_11 = new BigInteger(_arg_2, _local_9, true);
                _local_8 = _arg_1(_local_11);
                _local_7 = _arg_5(_local_8, _local_9, _arg_6);
                if (_local_7 == null)
                {
                    throw (new TLSError("Decrypt error - padding function returned null!", 50));
                };
                _arg_3.writeBytes(_local_7);
            };
        }

        private function pkcs1pad(_arg_1:ByteArray, _arg_2:int, _arg_3:uint, _arg_4:uint=2):ByteArray
        {
            var _local_8:Random;
            var _local_6:int;
            var _local_9:ByteArray = new ByteArray();
            var _local_5:uint = _arg_1.position;
            _arg_2 = Math.min(_arg_2, _arg_1.length, ((_local_5 + _arg_3) - 11));
            _arg_1.position = _arg_2;
            var _local_7:int = (_arg_2 - 1);
            while (((_local_7 >= _local_5) && (_arg_3 > 11)))
            {
                _local_9[--_arg_3] = _arg_1[_local_7--];
            };
            _local_9[--_arg_3] = 0;
            if (_arg_4 == 2)
            {
                _local_8 = new Random();
                _local_6 = 0;
                while (_arg_3 > 2)
                {
                    do 
                    {
                        _local_6 = _local_8.nextByte();
                    } while (_local_6 == 0);
                    _local_9[--_arg_3] = _local_6;
                };
            }
            else
            {
                while (_arg_3 > 2)
                {
                    _local_9[--_arg_3] = 0xFF;
                };
            };
            _local_9[--_arg_3] = _arg_4;
            _local_9[--_arg_3] = 0;
            return (_local_9);
        }

        private function pkcs1unpad(_arg_1:BigInteger, _arg_2:uint, _arg_3:uint=2):ByteArray
        {
            var _local_6:ByteArray = new ByteArray();
            var _local_4:ByteArray = new ByteArray();
            _arg_1.toArray(_local_4);
            _local_4.position = 0;
            var _local_5:int;
            while (((_local_5 < _local_4.length) && (_local_4[_local_5] == 0)))
            {
                _local_5++;
            };
            if (((!((_local_4.length - _local_5) == (_arg_2 - 1))) || (!(_local_4[_local_5] == _arg_3))))
            {
                (trace(((((("PKCS#1 unpad: i=" + _local_5) + ", expected b[i]==") + _arg_3) + ", got b[i]=") + _local_4[_local_5].toString(16))));
                return (null);
            };
            _local_5++;
            while (_local_4[_local_5] != 0)
            {
                if (++_local_5 >= _local_4.length)
                {
                    (trace((((("PKCS#1 unpad: i=" + _local_5) + ", b[i-1]!=0 (=") + _local_4[(_local_5 - 1)].toString(16)) + ")")));
                    return (null);
                };
            };
            while (++_local_5 < _local_4.length)
            {
                _local_6.writeByte(_local_4[_local_5]);
            };
            _local_6.position = 0;
            return (_local_6);
        }

        public function rawpad(_arg_1:ByteArray, _arg_2:int, _arg_3:uint, _arg_4:uint=0):ByteArray
        {
            return (_arg_1);
        }

        public function rawunpad(_arg_1:BigInteger, _arg_2:uint, _arg_3:uint=0):ByteArray
        {
            return (_arg_1.toByteArray());
        }

        public function toString():String
        {
            return ("rsa");
        }

        public function dump():String
        {
            var _local_1:String = ((((("N=" + n.toString(16)) + "\n") + "E=") + e.toString(16)) + "\n");
            if (canDecrypt)
            {
                _local_1 = (_local_1 + (("D=" + d.toString(16)) + "\n"));
                if (((!(p == null)) && (!(q == null))))
                {
                    _local_1 = (_local_1 + (("P=" + p.toString(16)) + "\n"));
                    _local_1 = (_local_1 + (("Q=" + q.toString(16)) + "\n"));
                    _local_1 = (_local_1 + (("DMP1=" + dmp1.toString(16)) + "\n"));
                    _local_1 = (_local_1 + (("DMQ1=" + dmq1.toString(16)) + "\n"));
                    _local_1 = (_local_1 + (("IQMP=" + _SafeStr_644.toString(16)) + "\n"));
                };
            };
            return (_local_1);
        }

        protected function doPublic(_arg_1:BigInteger):BigInteger
        {
            return (_arg_1.modPowInt(e, n));
        }

        protected function doPrivate2(_arg_1:BigInteger):BigInteger
        {
            if (((p == null) && (q == null)))
            {
                return (_arg_1.modPow(d, n));
            };
            var _local_3:BigInteger = _arg_1.mod(p).modPow(dmp1, p);
            var _local_4:BigInteger = _arg_1.mod(q).modPow(dmq1, q);
            while (_local_3.compareTo(_local_4) < 0)
            {
                _local_3 = _local_3.add(p);
            };
            return (_local_3.subtract(_local_4).multiply(_SafeStr_644).mod(p).multiply(q).add(_local_4));
        }

        protected function doPrivate(_arg_1:BigInteger):BigInteger
        {
            if (((p == null) || (q == null)))
            {
                return (_arg_1.modPow(d, n));
            };
            var _local_2:BigInteger = _arg_1.mod(p).modPow(dmp1, p);
            var _local_3:BigInteger = _arg_1.mod(q).modPow(dmq1, q);
            while (_local_2.compareTo(_local_3) < 0)
            {
                _local_2 = _local_2.add(p);
            };
            return (_local_2.subtract(_local_3).multiply(_SafeStr_644).mod(p).multiply(q).add(_local_3));
        }


    }
}

