package com.hurlant.math
{
    import com.hurlant.math.BigInteger;
    import com.hurlant.math.bi_internal;

    use namespace bi_internal;

    internal class BarrettReduction implements IReduction 
    {

        private var m:BigInteger;
        private var r2:BigInteger;
        private var q3:BigInteger;
        private var _SafeStr_765:BigInteger;

        public function BarrettReduction(_arg_1:BigInteger)
        {
            r2 = new BigInteger();
            q3 = new BigInteger();
            BigInteger._SafeStr_269.dlShiftTo((2 * _arg_1.t), r2);
            _SafeStr_765 = r2.divide(_arg_1);
            this.m = _arg_1;
        }

        public function revert(_arg_1:BigInteger):BigInteger
        {
            return (_arg_1);
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

        public function convert(_arg_1:BigInteger):BigInteger
        {
            var _local_2:BigInteger;
            if (((_arg_1.s < 0) || (_arg_1.t > (2 * m.t))))
            {
                return (_arg_1.mod(m));
            };
            if (_arg_1.compareTo(m) < 0)
            {
                return (_arg_1);
            };
            _local_2 = new BigInteger();
            _arg_1.copyTo(_local_2);
            reduce(_local_2);
            return (_local_2);
        }

        public function reduce(_arg_1:BigInteger):void
        {
            var _local_2:BigInteger = (_arg_1 as BigInteger);
            _local_2.drShiftTo((m.t - 1), r2);
            if (_local_2.t > (m.t + 1))
            {
                _local_2.t = (m.t + 1);
                _local_2.clamp();
            };
            _SafeStr_765.multiplyUpperTo(r2, (m.t + 1), q3);
            m.multiplyLowerTo(q3, (m.t + 1), r2);
            while (_local_2.compareTo(r2) < 0)
            {
                _local_2.dAddOffset(1, (m.t + 1));
            };
            _local_2.subTo(r2, _local_2);
            while (_local_2.compareTo(m) >= 0)
            {
                _local_2.subTo(m, _local_2);
            };
        }


    }
}

