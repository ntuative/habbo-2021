package com.codeazur.as3swf.data.actions.swf4
{
    import com.codeazur.as3swf.data.actions.Action;
    import com.codeazur.as3swf.data.actions.IAction;
    import com.codeazur.as3swf.SWFData;

    public class ActionGetURL2 extends Action implements IAction 
    {

        public static const CODE:uint = 154;

        public var _SafeStr_408:uint;
        public var reserved:uint;
        public var _SafeStr_409:Boolean;
        public var _SafeStr_410:Boolean;

        public function ActionGetURL2(_arg_1:uint, _arg_2:uint)
        {
            super(_arg_1, _arg_2);
        }

        override public function parse(_arg_1:SWFData):void
        {
            _SafeStr_408 = _arg_1.readUB(2);
            reserved = _arg_1.readUB(4);
            _SafeStr_409 = (_arg_1.readUB(1) == 1);
            _SafeStr_410 = (_arg_1.readUB(1) == 1);
        }

        override public function publish(_arg_1:SWFData):void
        {
            var _local_2:SWFData = new SWFData();
            _local_2.writeUB(2, _SafeStr_408);
            _local_2.writeUB(4, reserved);
            _local_2.writeUB(1, ((_SafeStr_409) ? 1 : 0));
            _local_2.writeUB(1, ((_SafeStr_410) ? 1 : 0));
            write(_arg_1, _local_2);
        }

        override public function clone():IAction
        {
            var _local_1:ActionGetURL2 = new ActionGetURL2(code, length);
            _local_1._SafeStr_408 = _SafeStr_408;
            _local_1.reserved = reserved;
            _local_1._SafeStr_409 = _SafeStr_409;
            _local_1._SafeStr_410 = _SafeStr_410;
            return (_local_1);
        }

        override public function toString(_arg_1:uint=0):String
        {
            return (((((((((((("[ActionGetURL2] SendVarsMethod: " + _SafeStr_408) + " (") + sendVarsMethodToString()) + "), ") + "Reserved: ") + reserved) + ", ") + "LoadTargetFlag: ") + _SafeStr_409) + ", ") + "LoadVariablesFlag: ") + _SafeStr_410);
        }

        public function sendVarsMethodToString():String
        {
            if (!_SafeStr_408)
            {
                return ("None");
            };
            if (_SafeStr_408 == 1)
            {
                return ("GET");
            };
            if (_SafeStr_408 == 2)
            {
                return ("POST");
            };
            throw (new Error("sendVarsMethod is only defined for values of 0, 1, and 2."));
        }


    }
}

