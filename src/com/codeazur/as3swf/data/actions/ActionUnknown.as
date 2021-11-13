package com.codeazur.as3swf.data.actions
{
    import com.codeazur.as3swf.SWFData;

    public class ActionUnknown extends Action implements IAction 
    {

        public function ActionUnknown(_arg_1:uint, _arg_2:uint)
        {
            super(_arg_1, _arg_2);
        }

        override public function parse(_arg_1:SWFData):void
        {
            if (_length > 0)
            {
                _arg_1.skipBytes(_length);
            };
        }

        override public function toString(_arg_1:uint=0):String
        {
            return ((("[????] Code: " + _SafeStr_671.toString(16)) + ", Length: ") + _length);
        }


    }
}

