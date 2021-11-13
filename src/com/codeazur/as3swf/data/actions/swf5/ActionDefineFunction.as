package com.codeazur.as3swf.data.actions.swf5
{
    import com.codeazur.as3swf.data.actions.Action;
    import com.codeazur.as3swf.data.actions.IAction;
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.utils.StringUtils;

    public class ActionDefineFunction extends Action implements IAction 
    {

        public static const CODE:uint = 155;

        public var functionName:String;
        public var functionParams:Vector.<String>;
        public var _SafeStr_398:Vector.<IAction>;

        public function ActionDefineFunction(_arg_1:uint, _arg_2:uint)
        {
            super(_arg_1, _arg_2);
            functionParams = new Vector.<String>();
            _SafeStr_398 = new Vector.<IAction>();
        }

        override public function parse(_arg_1:SWFData):void
        {
            var _local_3:uint;
            functionName = _arg_1.readString();
            var _local_2:uint = _arg_1.readUI16();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                functionParams.push(_arg_1.readString());
                _local_3++;
            };
            var _local_5:uint = _arg_1.readUI16();
            var _local_4:uint = (_arg_1.position + _local_5);
            while (_arg_1.position < _local_4)
            {
                _SafeStr_398.push(_arg_1.readACTIONRECORD());
            };
        }

        override public function publish(_arg_1:SWFData):void
        {
            var _local_2:uint;
            var _local_3:SWFData = new SWFData();
            _local_3.writeString(functionName);
            _local_3.writeUI16(functionParams.length);
            _local_2 = 0;
            while (_local_2 < functionParams.length)
            {
                _local_3.writeString(functionParams[_local_2]);
                _local_2++;
            };
            var _local_4:SWFData = new SWFData();
            _local_2 = 0;
            while (_local_2 < _SafeStr_398.length)
            {
                _local_4.writeACTIONRECORD(_SafeStr_398[_local_2]);
                _local_2++;
            };
            _local_3.writeUI16(_local_4.length);
            write(_arg_1, _local_3);
            _arg_1.writeBytes(_local_4);
        }

        override public function clone():IAction
        {
            var _local_1:uint;
            var _local_2:ActionDefineFunction = new ActionDefineFunction(code, length);
            _local_2.functionName = functionName;
            _local_1 = 0;
            while (_local_1 < functionParams.length)
            {
                _local_2.functionParams.push(functionParams[_local_1]);
                _local_1++;
            };
            _local_1 = 0;
            while (_local_1 < _SafeStr_398.length)
            {
                _local_2._SafeStr_398.push(_SafeStr_398[_local_1].clone());
                _local_1++;
            };
            return (_local_2);
        }

        override public function toString(_arg_1:uint=0):String
        {
            var _local_3:uint;
            var _local_2:String = (((("[ActionDefineFunction] " + (((functionName == null) || (functionName.length == 0)) ? "<anonymous>" : functionName)) + "(") + functionParams.join(", ")) + ")");
            _local_3 = 0;
            while (_local_3 < _SafeStr_398.length)
            {
                if (_SafeStr_398[_local_3])
                {
                    _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 4))) + "[") + _local_3) + "] ") + _SafeStr_398[_local_3].toString((_arg_1 + 4))));
                };
                _local_3++;
            };
            return (_local_2);
        }


    }
}

