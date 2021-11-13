package com.sulake.habbo.communication.encryption
{
    import com.sulake.core.communication.handshake.IKeyExchange;
    import com.hurlant.math.BigInteger;

    public class DiffieHellman implements IKeyExchange 
    {

        private var _privateKey:BigInteger;
        private var _publicKey:BigInteger;
        private var _serverPublicKey:BigInteger;
        private var _sharedKey:BigInteger;
        private var _prime:BigInteger;
        private var _SafeStr_1681:BigInteger;
        private var _minimumPublicKey:BigInteger = BigInteger.nbv(2);
        private var _SafeStr_1682:BigInteger = BigInteger.nbv(2);

        public function DiffieHellman(_arg_1:BigInteger, _arg_2:BigInteger)
        {
            _prime = _arg_1;
            _SafeStr_1681 = _arg_2;
        }

        public function init(_arg_1:String, _arg_2:uint=16):Boolean
        {
            _privateKey = new BigInteger();
            _privateKey.fromRadix(_arg_1, _arg_2);
            _publicKey = _SafeStr_1681.modPow(_privateKey, _prime);
            return (true);
        }

        public function generateSharedKey(_arg_1:String, _arg_2:uint=16):String
        {
            _serverPublicKey = new BigInteger();
            _serverPublicKey.fromRadix(_arg_1, _arg_2);
            _sharedKey = _serverPublicKey.modPow(_privateKey, _prime);
            return (getSharedKey(_arg_2));
        }

        public function getPublicKey(_arg_1:uint=16):String
        {
            return (_publicKey.toRadix(_arg_1));
        }

        public function getSharedKey(_arg_1:uint=16):String
        {
            return (_sharedKey.toRadix(_arg_1));
        }

        public function isValidServerPublicKey():Boolean
        {
            return (_serverPublicKey.compareTo(_minimumPublicKey) >= 0);
        }

        public function isValidSharedKey():Boolean
        {
            return (_sharedKey.compareTo(_SafeStr_1682) >= 0);
        }


    }
}

