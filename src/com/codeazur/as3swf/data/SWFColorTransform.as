package com.codeazur.as3swf.data
{
    import com.codeazur.as3swf.SWFData;
    import flash.geom.ColorTransform;

    public class SWFColorTransform 
    {

        public var _SafeStr_320:int = 1;
        public var _SafeStr_321:int = 1;
        public var _SafeStr_322:int = 1;
        public var _SafeStr_324:int = 0;
        public var _SafeStr_325:int = 0;
        public var _SafeStr_326:int = 0;
        public var _SafeStr_323:int = 1;
        public var _SafeStr_327:int = 0;
        public var hasMultTerms:Boolean;
        public var hasAddTerms:Boolean;

        public function SWFColorTransform(_arg_1:SWFData=null)
        {
            if (_arg_1 != null)
            {
                parse(_arg_1);
            };
        }

        public function get colorTransform():ColorTransform
        {
            return (new ColorTransform(_SafeStr_320, _SafeStr_321, _SafeStr_322, _SafeStr_323, _SafeStr_324, _SafeStr_325, _SafeStr_326, _SafeStr_327));
        }

        public function parse(_arg_1:SWFData):void
        {
            _arg_1.resetBitsPending();
            hasAddTerms = (_arg_1.readUB(1) == 1);
            hasMultTerms = (_arg_1.readUB(1) == 1);
            var _local_2:uint = _arg_1.readUB(4);
            _SafeStr_320 = 1;
            _SafeStr_321 = 1;
            _SafeStr_322 = 1;
            if (hasMultTerms)
            {
                _SafeStr_320 = _arg_1.readSB(_local_2);
                _SafeStr_321 = _arg_1.readSB(_local_2);
                _SafeStr_322 = _arg_1.readSB(_local_2);
            };
            _SafeStr_324 = 0;
            _SafeStr_325 = 0;
            _SafeStr_326 = 0;
            if (hasAddTerms)
            {
                _SafeStr_324 = _arg_1.readSB(_local_2);
                _SafeStr_325 = _arg_1.readSB(_local_2);
                _SafeStr_326 = _arg_1.readSB(_local_2);
            };
        }

        public function publish(_arg_1:SWFData):void
        {
            _arg_1.resetBitsPending();
            _arg_1.writeUB(1, ((hasAddTerms) ? 1 : 0));
            _arg_1.writeUB(1, ((hasMultTerms) ? 1 : 0));
            var _local_2:Array = [];
            if (hasMultTerms)
            {
                _local_2.push(_SafeStr_320, _SafeStr_321, _SafeStr_322);
            };
            if (hasAddTerms)
            {
                _local_2.push(_SafeStr_324, _SafeStr_325, _SafeStr_326);
            };
            var _local_3:uint = _arg_1.calculateMaxBits(true, _local_2);
            _arg_1.writeUB(4, _local_3);
            if (hasMultTerms)
            {
                _arg_1.writeSB(_local_3, _SafeStr_320);
                _arg_1.writeSB(_local_3, _SafeStr_321);
                _arg_1.writeSB(_local_3, _SafeStr_322);
            };
            if (hasAddTerms)
            {
                _arg_1.writeSB(_local_3, _SafeStr_324);
                _arg_1.writeSB(_local_3, _SafeStr_325);
                _arg_1.writeSB(_local_3, _SafeStr_326);
            };
        }

        public function clone():SWFColorTransform
        {
            var _local_1:SWFColorTransform = new SWFColorTransform();
            _local_1.hasAddTerms = hasAddTerms;
            _local_1.hasMultTerms = hasMultTerms;
            _local_1._SafeStr_320 = _SafeStr_320;
            _local_1._SafeStr_321 = _SafeStr_321;
            _local_1._SafeStr_322 = _SafeStr_322;
            _local_1._SafeStr_324 = _SafeStr_324;
            _local_1._SafeStr_325 = _SafeStr_325;
            _local_1._SafeStr_326 = _SafeStr_326;
            return (_local_1);
        }

        public function isIdentity():Boolean
        {
            return (((((_SafeStr_320 == 1) && (_SafeStr_321 == 1)) && (_SafeStr_322 == 1)) && (_SafeStr_323 == 1)) && ((((_SafeStr_324 == 0) && (_SafeStr_325 == 0)) && (_SafeStr_326 == 0)) && (_SafeStr_327 == 0)));
        }

        public function toString():String
        {
            return ((((((((((_SafeStr_320 + ",") + _SafeStr_321) + ",") + _SafeStr_322) + ",") + _SafeStr_324) + ",") + _SafeStr_325) + ",") + _SafeStr_326);
        }


    }
}

