package com.codeazur.as3swf.data.actions.swf6
{
    import com.codeazur.as3swf.data.actions.Action;
    import com.codeazur.as3swf.data.actions.IAction;

    public class ActionEnumerate2 extends Action implements IAction 
    {

        public static const CODE:uint = 85;

        public function ActionEnumerate2(_arg_1:uint, _arg_2:uint)
        {
            super(_arg_1, _arg_2);
        }

        override public function toString(_arg_1:uint=0):String
        {
            return ("[ActionEnumerate2]");
        }


    }
}