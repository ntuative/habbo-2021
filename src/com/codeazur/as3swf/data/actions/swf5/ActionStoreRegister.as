package com.codeazur.as3swf.data.actions.swf5
{
    import com.codeazur.as3swf.data.actions.Action;
    import com.codeazur.as3swf.data.actions.IAction;
    import com.codeazur.as3swf.SWFData;

    public class ActionStoreRegister extends Action implements IAction 
    {

        public static const CODE:uint = 135;

        public var registerNumber:uint;

        public function ActionStoreRegister(_arg_1:uint, _arg_2:uint)
        {
            super(_arg_1, _arg_2);
        }

        override public function parse(_arg_1:SWFData):void
        {
            registerNumber = _arg_1.readUI8();
        }

        override public function publish(_arg_1:SWFData):void
        {
            var _local_2:SWFData = new SWFData();
            _local_2.writeUI8(registerNumber);
            write(_arg_1, _local_2);
        }

        override public function clone():IAction
        {
            var _local_1:ActionStoreRegister = new ActionStoreRegister(code, length);
            _local_1.registerNumber = registerNumber;
            return (_local_1);
        }

        override public function toString(_arg_1:uint=0):String
        {
            return ("[ActionStoreRegister] RegisterNumber: " + registerNumber);
        }


    }
}