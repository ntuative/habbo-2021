package com.codeazur.as3swf.data.actions.swf3
{
    import com.codeazur.as3swf.data.actions.Action;
    import com.codeazur.as3swf.data.actions.IAction;
    import com.codeazur.as3swf.SWFData;

    public class ActionSetTarget extends Action implements IAction 
    {

        public static const CODE:uint = 139;

        public var targetName:String;

        public function ActionSetTarget(_arg_1:uint, _arg_2:uint)
        {
            super(_arg_1, _arg_2);
        }

        override public function parse(_arg_1:SWFData):void
        {
            targetName = _arg_1.readString();
        }

        override public function publish(_arg_1:SWFData):void
        {
            var _local_2:SWFData = new SWFData();
            _local_2.writeString(targetName);
            write(_arg_1, _local_2);
        }

        override public function clone():IAction
        {
            var _local_1:ActionSetTarget = new ActionSetTarget(code, length);
            _local_1.targetName = targetName;
            return (_local_1);
        }

        override public function toString(_arg_1:uint=0):String
        {
            return ("[ActionSetTarget] TargetName: " + targetName);
        }


    }
}