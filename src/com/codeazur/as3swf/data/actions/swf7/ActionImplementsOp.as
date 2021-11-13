package com.codeazur.as3swf.data.actions.swf7
{
    import com.codeazur.as3swf.data.actions.Action;
    import com.codeazur.as3swf.data.actions.IAction;

    public class ActionImplementsOp extends Action implements IAction 
    {

        public static const CODE:uint = 44;

        public function ActionImplementsOp(_arg_1:uint, _arg_2:uint)
        {
            super(_arg_1, _arg_2);
        }

        override public function toString(_arg_1:uint=0):String
        {
            return ("[ActionImplementsOp]");
        }


    }
}