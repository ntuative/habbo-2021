package com.codeazur.as3swf.data.actions.swf3
{
    import com.codeazur.as3swf.data.actions.Action;
    import com.codeazur.as3swf.data.actions.IAction;

    public class ActionNextFrame extends Action implements IAction 
    {

        public static const CODE:uint = 4;

        public function ActionNextFrame(_arg_1:uint, _arg_2:uint)
        {
            super(_arg_1, _arg_2);
        }

        override public function toString(_arg_1:uint=0):String
        {
            return ("[ActionNextFrame]");
        }


    }
}