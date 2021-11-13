package com.codeazur.as3swf.data.actions.swf4
{
    import com.codeazur.as3swf.data.actions.Action;
    import com.codeazur.as3swf.data.actions.IAction;

    public class ActionMBCharToAscii extends Action implements IAction 
    {

        public static const CODE:uint = 54;

        public function ActionMBCharToAscii(_arg_1:uint, _arg_2:uint)
        {
            super(_arg_1, _arg_2);
        }

        override public function toString(_arg_1:uint=0):String
        {
            return ("[ActionMBCharToAscii]");
        }


    }
}