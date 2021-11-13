package com.codeazur.as3swf.data
{
    import com.codeazur.as3swf.SWFData;

    public class SWFColorTransformWithAlpha extends SWFColorTransform 
    {

        public function SWFColorTransformWithAlpha(_arg_1:SWFData=null)
        {
            super(_arg_1);
        }

        override public function parse(_arg_1:SWFData):void
        {
            _arg_1.resetBitsPending();
            hasAddTerms = (_arg_1.readUB(1) == 1);
            hasMultTerms = (_arg_1.readUB(1) == 1);
            var _local_2:uint = _arg_1.readUB(4);
            _SafeStr_320 = 1;
            _SafeStr_321 = 1;
            _SafeStr_322 = 1;
            _SafeStr_323 = 1;
            if (hasMultTerms)
            {
                _SafeStr_320 = _arg_1.readSB(_local_2);
                _SafeStr_321 = _arg_1.readSB(_local_2);
                _SafeStr_322 = _arg_1.readSB(_local_2);
                _SafeStr_323 = _arg_1.readSB(_local_2);
            };
            _SafeStr_324 = 0;
            _SafeStr_325 = 0;
            _SafeStr_326 = 0;
            _SafeStr_327 = 0;
            if (hasAddTerms)
            {
                _SafeStr_324 = _arg_1.readSB(_local_2);
                _SafeStr_325 = _arg_1.readSB(_local_2);
                _SafeStr_326 = _arg_1.readSB(_local_2);
                _SafeStr_327 = _arg_1.readSB(_local_2);
            };
        }

        override public function publish(_arg_1:SWFData):void
        {
            _arg_1.resetBitsPending();
            _arg_1.writeUB(1, ((hasAddTerms) ? 1 : 0));
            _arg_1.writeUB(1, ((hasMultTerms) ? 1 : 0));
            var _local_2:Array = [];
            if (hasMultTerms)
            {
                _local_2.push(_SafeStr_320, _SafeStr_321, _SafeStr_322, _SafeStr_323);
            };
            if (hasAddTerms)
            {
                _local_2.push(_SafeStr_324, _SafeStr_325, _SafeStr_326, _SafeStr_327);
            };
            var _local_3:uint = (((hasMultTerms) || (hasAddTerms)) ? _arg_1.calculateMaxBits(true, _local_2) : 1);
            _arg_1.writeUB(4, _local_3);
            if (hasMultTerms)
            {
                _arg_1.writeSB(_local_3, _SafeStr_320);
                _arg_1.writeSB(_local_3, _SafeStr_321);
                _arg_1.writeSB(_local_3, _SafeStr_322);
                _arg_1.writeSB(_local_3, _SafeStr_323);
            };
            if (hasAddTerms)
            {
                _arg_1.writeSB(_local_3, _SafeStr_324);
                _arg_1.writeSB(_local_3, _SafeStr_325);
                _arg_1.writeSB(_local_3, _SafeStr_326);
                _arg_1.writeSB(_local_3, _SafeStr_327);
            };
        }

        override public function clone():SWFColorTransform
        {
            var _local_1:SWFColorTransformWithAlpha = new SWFColorTransformWithAlpha();
            _local_1.hasAddTerms = hasAddTerms;
            _local_1.hasMultTerms = hasMultTerms;
            _local_1._SafeStr_320 = _SafeStr_320;
            _local_1._SafeStr_321 = _SafeStr_321;
            _local_1._SafeStr_322 = _SafeStr_322;
            _local_1._SafeStr_323 = _SafeStr_323;
            _local_1._SafeStr_324 = _SafeStr_324;
            _local_1._SafeStr_325 = _SafeStr_325;
            _local_1._SafeStr_326 = _SafeStr_326;
            _local_1._SafeStr_327 = _SafeStr_327;
            return (_local_1);
        }

        override public function toString():String
        {
            return ((((((((((((((_SafeStr_320 + ",") + _SafeStr_321) + ",") + _SafeStr_322) + ",") + _SafeStr_323) + ",") + _SafeStr_324) + ",") + _SafeStr_325) + ",") + _SafeStr_326) + ",") + _SafeStr_327);
        }


    }
}

