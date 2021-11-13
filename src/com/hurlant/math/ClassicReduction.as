package com.hurlant.math
{
    import com.hurlant.math.BigInteger;
    import com.hurlant.math.bi_internal;

    use namespace bi_internal;

    internal class ClassicReduction implements IReduction 
    {

        private var m:BigInteger;

        public function ClassicReduction(_arg_1:BigInteger)
        {
            this.m = _arg_1;
        }

        public function convert(_arg_1:BigInteger):BigInteger
        {
            if (((_arg_1.s < 0) || (_arg_1.compareTo(m) >= 0)))
            {
                return (_arg_1.mod(m));
            };
            return (_arg_1);
        }

        public function revert(_arg_1:BigInteger):BigInteger
        {
            return (_arg_1);
        }

        public function reduce(_arg_1:BigInteger):void
        {
            _arg_1.divRemTo(m, null, _arg_1);
        }

        public function mulTo(_arg_1:BigInteger, _arg_2:BigInteger, _arg_3:BigInteger):void
        {
            _arg_1.multiplyTo(_arg_2, _arg_3);
            reduce(_arg_3);
        }

        public function sqrTo(_arg_1:BigInteger, _arg_2:BigInteger):void
        {
            _arg_1.squareTo(_arg_2);
            reduce(_arg_2);
        }


    }
}