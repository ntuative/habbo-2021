package com.codeazur.as3swf.data
{
    import com.codeazur.as3swf.SWFData;

    public class SWFKerningRecord 
    {

        public var code1:uint;
        public var code2:uint;
        public var _SafeStr_328:int;

        public function SWFKerningRecord(_arg_1:SWFData=null, _arg_2:Boolean=false)
        {
            if (_arg_1 != null)
            {
                parse(_arg_1, _arg_2);
            };
        }

        public function parse(_arg_1:SWFData, _arg_2:Boolean):void
        {
            code1 = ((_arg_2) ? _arg_1.readUI16() : _arg_1.readUI8());
            code2 = ((_arg_2) ? _arg_1.readUI16() : _arg_1.readUI8());
            _SafeStr_328 = _arg_1.readSI16();
        }

        public function publish(_arg_1:SWFData, _arg_2:Boolean):void
        {
            if (_arg_2)
            {
                _arg_1.writeUI16(code1);
            }
            else
            {
                _arg_1.writeUI8(code1);
            };
            if (_arg_2)
            {
                _arg_1.writeUI16(code2);
            }
            else
            {
                _arg_1.writeUI8(code2);
            };
            _arg_1.writeSI16(_SafeStr_328);
        }

        public function toString(_arg_1:uint=0):String
        {
            return ((((((("Code1: " + code1) + ", ") + "Code2: ") + code2) + ", ") + "Adjustment: ") + _SafeStr_328);
        }


    }
}

