package com.hurlant.math
{
    use namespace bi_internal;

    public class NullReduction implements IReduction 
    {


        public function revert(_arg_1:BigInteger):BigInteger
        {
            return (_arg_1);
        }

        public function mulTo(_arg_1:BigInteger, _arg_2:BigInteger, _arg_3:BigInteger):void
        {
            _arg_1.multiplyTo(_arg_2, _arg_3);
        }

        public function sqrTo(_arg_1:BigInteger, _arg_2:BigInteger):void
        {
            _arg_1.squareTo(_arg_2);
        }

        public function convert(_arg_1:BigInteger):BigInteger
        {
            return (_arg_1);
        }

        public function reduce(_arg_1:BigInteger):void
        {
        }


    }
}