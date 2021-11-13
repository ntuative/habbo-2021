package com.codeazur.as3swf.data.actions.swf3
{
    import com.codeazur.as3swf.data.actions.Action;
    import com.codeazur.as3swf.data.actions.IAction;
    import com.codeazur.as3swf.SWFData;

    public class ActionGotoLabel extends Action implements IAction 
    {

        public static const CODE:uint = 140;

        public var label:String;

        public function ActionGotoLabel(_arg_1:uint, _arg_2:uint)
        {
            super(_arg_1, _arg_2);
        }

        override public function parse(_arg_1:SWFData):void
        {
            label = _arg_1.readString();
        }

        override public function publish(_arg_1:SWFData):void
        {
            var _local_2:SWFData = new SWFData();
            _local_2.writeString(label);
            write(_arg_1, _local_2);
        }

        override public function clone():IAction
        {
            var _local_1:ActionGotoLabel = new ActionGotoLabel(code, length);
            _local_1.label = label;
            return (_local_1);
        }

        override public function toString(_arg_1:uint=0):String
        {
            return ("[ActionGotoLabel] Label: " + label);
        }


    }
}