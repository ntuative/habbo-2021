package com.codeazur.as3swf.data
{
    import com.codeazur.as3swf.SWFData;

    public class SWFRegisterParam 
    {

        public var register:uint;
        public var name:String;

        public function SWFRegisterParam(_arg_1:SWFData=null)
        {
            if (_arg_1 != null)
            {
                parse(_arg_1);
            };
        }

        public function parse(_arg_1:SWFData):void
        {
            register = _arg_1.readUI8();
            name = _arg_1.readString();
        }

        public function publish(_arg_1:SWFData):void
        {
            _arg_1.writeUI8(register);
            _arg_1.writeString(name);
        }

        public function toString():String
        {
            return ((register + ":") + name);
        }


    }
}