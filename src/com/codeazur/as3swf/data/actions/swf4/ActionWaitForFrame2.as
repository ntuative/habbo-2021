package com.codeazur.as3swf.data.actions.swf4
{
    import com.codeazur.as3swf.data.actions.Action;
    import com.codeazur.as3swf.data.actions.IAction;
    import com.codeazur.as3swf.SWFData;

    public class ActionWaitForFrame2 extends Action implements IAction 
    {

        public static const CODE:uint = 141;

        public var _SafeStr_394:uint;

        public function ActionWaitForFrame2(_arg_1:uint, _arg_2:uint)
        {
            super(_arg_1, _arg_2);
        }

        override public function parse(_arg_1:SWFData):void
        {
            _SafeStr_394 = _arg_1.readUI8();
        }

        override public function publish(_arg_1:SWFData):void
        {
            var _local_2:SWFData = new SWFData();
            _local_2.writeUI8(_SafeStr_394);
            write(_arg_1, _local_2);
        }

        override public function clone():IAction
        {
            var _local_1:ActionWaitForFrame2 = new ActionWaitForFrame2(code, length);
            _local_1._SafeStr_394 = _SafeStr_394;
            return (_local_1);
        }

        override public function toString(_arg_1:uint=0):String
        {
            return ("[ActionWaitForFrame2] SkipCount: " + _SafeStr_394);
        }


    }
}

