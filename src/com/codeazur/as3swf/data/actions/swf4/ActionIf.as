package com.codeazur.as3swf.data.actions.swf4
{
    import com.codeazur.as3swf.data.actions.Action;
    import com.codeazur.as3swf.data.actions.IAction;
    import com.codeazur.as3swf.SWFData;

    public class ActionIf extends Action implements IAction 
    {

        public static const CODE:uint = 157;

        public var branchOffset:int;

        public function ActionIf(_arg_1:uint, _arg_2:uint)
        {
            super(_arg_1, _arg_2);
        }

        override public function parse(_arg_1:SWFData):void
        {
            branchOffset = _arg_1.readSI16();
        }

        override public function publish(_arg_1:SWFData):void
        {
            var _local_2:SWFData = new SWFData();
            _local_2.writeSI16(branchOffset);
            write(_arg_1, _local_2);
        }

        override public function clone():IAction
        {
            var _local_1:ActionIf = new ActionIf(code, length);
            _local_1.branchOffset = branchOffset;
            return (_local_1);
        }

        override public function toString(_arg_1:uint=0):String
        {
            return ("[ActionIf] BranchOffset: " + branchOffset);
        }


    }
}