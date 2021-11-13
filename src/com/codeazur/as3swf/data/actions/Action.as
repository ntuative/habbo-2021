package com.codeazur.as3swf.data.actions
{
    import com.codeazur.as3swf.SWFData;

    public class Action implements IAction 
    {

        protected var _SafeStr_671:uint;
        protected var _length:uint;

        public function Action(_arg_1:uint, _arg_2:uint)
        {
            _SafeStr_671 = _arg_1;
            _length = _arg_2;
        }

        public function get code():uint
        {
            return (_SafeStr_671);
        }

        public function get length():uint
        {
            return (_length);
        }

        public function parse(_arg_1:SWFData):void
        {
        }

        public function publish(_arg_1:SWFData):void
        {
            write(_arg_1);
        }

        public function clone():IAction
        {
            return (new Action(code, length));
        }

        protected function write(_arg_1:SWFData, _arg_2:SWFData=null):void
        {
            _arg_1.writeUI8(code);
            if (code >= 128)
            {
                if (((!(_arg_2 == null)) && (_arg_2.length > 0)))
                {
                    _length = _arg_2.length;
                    _arg_1.writeUI16(_length);
                    _arg_1.writeBytes(_arg_2);
                }
                else
                {
                    _length = 0;
                    throw (new Error("Action body null or empty."));
                };
            }
            else
            {
                _length = 0;
            };
        }

        public function toString(_arg_1:uint=0):String
        {
            return ((("[Action] Code: " + _SafeStr_671.toString(16)) + ", Length: ") + _length);
        }


    }
}

