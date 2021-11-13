package com.codeazur.as3swf.data.actions.swf7
{
    import com.codeazur.as3swf.data.actions.Action;
    import com.codeazur.as3swf.data.actions.IAction;
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.data.SWFRegisterParam;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.utils.StringUtils;

    public class ActionDefineFunction2 extends Action implements IAction 
    {

        public static const CODE:uint = 142;

        public var functionName:String;
        public var functionParams:Vector.<SWFRegisterParam>;
        public var _SafeStr_398:Vector.<IAction>;
        public var _SafeStr_399:uint;
        public var preloadParent:Boolean;
        public var preloadRoot:Boolean;
        public var preloadSuper:Boolean;
        public var preloadArguments:Boolean;
        public var preloadThis:Boolean;
        public var preloadGlobal:Boolean;
        public var suppressSuper:Boolean;
        public var suppressArguments:Boolean;
        public var suppressThis:Boolean;

        public function ActionDefineFunction2(_arg_1:uint, _arg_2:uint)
        {
            super(_arg_1, _arg_2);
            functionParams = new Vector.<SWFRegisterParam>();
            _SafeStr_398 = new Vector.<IAction>();
        }

        override public function parse(_arg_1:SWFData):void
        {
            var _local_5:uint;
            functionName = _arg_1.readString();
            var _local_2:uint = _arg_1.readUI16();
            _SafeStr_399 = _arg_1.readUI8();
            var _local_4:uint = _arg_1.readUI8();
            preloadParent = (!((_local_4 & 0x80) == 0));
            preloadRoot = (!((_local_4 & 0x40) == 0));
            suppressSuper = (!((_local_4 & 0x20) == 0));
            preloadSuper = (!((_local_4 & 0x10) == 0));
            suppressArguments = (!((_local_4 & 0x08) == 0));
            preloadArguments = (!((_local_4 & 0x04) == 0));
            suppressThis = (!((_local_4 & 0x02) == 0));
            preloadThis = (!((_local_4 & 0x01) == 0));
            var _local_3:uint = _arg_1.readUI8();
            preloadGlobal = (!((_local_3 & 0x01) == 0));
            _local_5 = 0;
            while (_local_5 < _local_2)
            {
                functionParams.push(_arg_1.readREGISTERPARAM());
                _local_5++;
            };
            var _local_7:uint = _arg_1.readUI16();
            var _local_6:uint = (_arg_1.position + _local_7);
            while (_arg_1.position < _local_6)
            {
                _SafeStr_398.push(_arg_1.readACTIONRECORD());
            };
        }

        override public function publish(_arg_1:SWFData):void
        {
            var _local_4:uint;
            var _local_5:SWFData = new SWFData();
            _local_5.writeString(functionName);
            _local_5.writeUI16(functionParams.length);
            _local_5.writeUI8(_SafeStr_399);
            var _local_3:uint;
            if (preloadParent)
            {
                _local_3 = (_local_3 | 0x80);
            };
            if (preloadRoot)
            {
                _local_3 = (_local_3 | 0x40);
            };
            if (suppressSuper)
            {
                _local_3 = (_local_3 | 0x20);
            };
            if (preloadSuper)
            {
                _local_3 = (_local_3 | 0x10);
            };
            if (suppressArguments)
            {
                _local_3 = (_local_3 | 0x08);
            };
            if (preloadArguments)
            {
                _local_3 = (_local_3 | 0x04);
            };
            if (suppressThis)
            {
                _local_3 = (_local_3 | 0x02);
            };
            if (preloadThis)
            {
                _local_3 = (_local_3 | 0x01);
            };
            _local_5.writeUI8(_local_3);
            var _local_2:uint;
            if (preloadGlobal)
            {
                _local_2 = (_local_2 | 0x01);
            };
            _local_5.writeUI8(_local_2);
            _local_4 = 0;
            while (_local_4 < functionParams.length)
            {
                _local_5.writeREGISTERPARAM(functionParams[_local_4]);
                _local_4++;
            };
            var _local_6:SWFData = new SWFData();
            _local_4 = 0;
            while (_local_4 < _SafeStr_398.length)
            {
                _local_6.writeACTIONRECORD(_SafeStr_398[_local_4]);
                _local_4++;
            };
            _local_5.writeUI16(_local_6.length);
            write(_arg_1, _local_5);
            _arg_1.writeBytes(_local_6);
        }

        override public function clone():IAction
        {
            var _local_1:uint;
            var _local_2:ActionDefineFunction2 = new ActionDefineFunction2(code, length);
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
            _local_2._SafeStr_399 = _SafeStr_399;
            _local_2.preloadParent = preloadParent;
            _local_2.preloadRoot = preloadRoot;
            _local_2.preloadSuper = preloadSuper;
            _local_2.preloadArguments = preloadArguments;
            _local_2.preloadThis = preloadThis;
            _local_2.preloadGlobal = preloadGlobal;
            _local_2.suppressSuper = suppressSuper;
            _local_2.suppressArguments = suppressArguments;
            _local_2.suppressThis = suppressThis;
            return (_local_2);
        }

        override public function toString(_arg_1:uint=0):String
        {
            var _local_4:uint;
            var _local_2:String = (((("[ActionDefineFunction2] " + (((functionName == null) || (functionName.length == 0)) ? "<anonymous>" : functionName)) + "(") + functionParams.join(", ")) + "), ");
            var _local_3:Array = [];
            if (preloadParent)
            {
                _local_3.push("preloadParent");
            };
            if (preloadRoot)
            {
                _local_3.push("preloadRoot");
            };
            if (preloadSuper)
            {
                _local_3.push("preloadSuper");
            };
            if (preloadArguments)
            {
                _local_3.push("preloadArguments");
            };
            if (preloadThis)
            {
                _local_3.push("preloadThis");
            };
            if (preloadGlobal)
            {
                _local_3.push("preloadGlobal");
            };
            if (suppressSuper)
            {
                _local_3.push("suppressSuper");
            };
            if (suppressArguments)
            {
                _local_3.push("suppressArguments");
            };
            if (suppressThis)
            {
                _local_3.push("suppressThis");
            };
            if (_local_3.length == 0)
            {
                _local_3.push("none");
            };
            _local_2 = (_local_2 + ("Flags: " + _local_3.join(",")));
            _local_4 = 0;
            while (_local_4 < _SafeStr_398.length)
            {
                _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 4))) + "[") + _local_4) + "] ") + _SafeStr_398[_local_4].toString((_arg_1 + 4))));
                _local_4++;
            };
            return (_local_2);
        }


    }
}

