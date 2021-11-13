package com.codeazur.as3swf.data.actions.swf3
{
    import com.codeazur.as3swf.data.actions.Action;
    import com.codeazur.as3swf.data.actions.IAction;
    import com.codeazur.as3swf.SWFData;

    public class ActionGotoFrame extends Action implements IAction 
    {

        public static const CODE:uint = 129;

        public var frame:uint;

        public function ActionGotoFrame(_arg_1:uint, _arg_2:uint)
        {
            super(_arg_1, _arg_2);
        }

        override public function parse(_arg_1:SWFData):void
        {
            frame = _arg_1.readUI16();
        }

        override public function publish(_arg_1:SWFData):void
        {
            var _local_2:SWFData = new SWFData();
            _local_2.writeUI16(frame);
            write(_arg_1, _local_2);
        }

        override public function clone():IAction
        {
            var _local_1:ActionGotoFrame = new ActionGotoFrame(code, length);
            _local_1.frame = frame;
            return (_local_1);
        }

        override public function toString(_arg_1:uint=0):String
        {
            return ("[ActionGotoFrame] Frame: " + frame);
        }


    }
}