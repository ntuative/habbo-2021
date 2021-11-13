package com.codeazur.as3swf.data.actions.swf3
{
    import com.codeazur.as3swf.data.actions.Action;
    import com.codeazur.as3swf.data.actions.IAction;
    import com.codeazur.as3swf.SWFData;

    public class ActionWaitForFrame extends Action implements IAction 
    {

        public static const CODE:uint = 138;

        public var frame:uint;
        public var _SafeStr_394:uint;

        public function ActionWaitForFrame(_arg_1:uint, _arg_2:uint)
        {
            super(_arg_1, _arg_2);
        }

        override public function parse(_arg_1:SWFData):void
        {
            frame = _arg_1.readUI16();
            _SafeStr_394 = _arg_1.readUI8();
        }

        override public function publish(_arg_1:SWFData):void
        {
            var _local_2:SWFData = new SWFData();
            _local_2.writeUI16(frame);
            _local_2.writeUI8(_SafeStr_394);
            write(_arg_1, _local_2);
        }

        override public function clone():IAction
        {
            var _local_1:ActionWaitForFrame = new ActionWaitForFrame(code, length);
            _local_1.frame = frame;
            _local_1._SafeStr_394 = _SafeStr_394;
            return (_local_1);
        }

        override public function toString(_arg_1:uint=0):String
        {
            return ((("[ActionWaitForFrame] Frame: " + frame) + ", SkipCount: ") + _SafeStr_394);
        }


    }
}

