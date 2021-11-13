package com.codeazur.as3swf.data.actions.swf7
{
    import com.codeazur.as3swf.data.actions.Action;
    import com.codeazur.as3swf.data.actions.IAction;
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.utils.StringUtils;
    import com.codeazur.as3swf.data.actions.*;

    public class ActionTry extends Action implements IAction 
    {

        public static const CODE:uint = 143;

        public var catchInRegisterFlag:Boolean;
        public var _SafeStr_396:Boolean;
        public var catchBlockFlag:Boolean;
        public var catchName:String;
        public var catchRegister:uint;
        public var tryBody:Vector.<IAction>;
        public var catchBody:Vector.<IAction>;
        public var _SafeStr_395:Vector.<IAction>;

        public function ActionTry(_arg_1:uint, _arg_2:uint)
        {
            super(_arg_1, _arg_2);
            tryBody = new Vector.<IAction>();
            catchBody = new Vector.<IAction>();
            _SafeStr_395 = new Vector.<IAction>();
        }

        override public function parse(_arg_1:SWFData):void
        {
            var _local_8:uint = _arg_1.readUI8();
            catchInRegisterFlag = (!((_local_8 & 0x04) == 0));
            _SafeStr_396 = (!((_local_8 & 0x02) == 0));
            catchBlockFlag = (!((_local_8 & 0x01) == 0));
            var _local_6:uint = _arg_1.readUI16();
            var _local_2:uint = _arg_1.readUI16();
            var _local_3:uint = _arg_1.readUI16();
            if (catchInRegisterFlag)
            {
                catchRegister = _arg_1.readUI8();
            }
            else
            {
                catchName = _arg_1.readString();
            };
            var _local_4:uint = (_arg_1.position + _local_6);
            while (_arg_1.position < _local_4)
            {
                tryBody.push(_arg_1.readACTIONRECORD());
            };
            var _local_5:uint = (_arg_1.position + _local_2);
            while (_arg_1.position < _local_5)
            {
                catchBody.push(_arg_1.readACTIONRECORD());
            };
            var _local_7:uint = (_arg_1.position + _local_3);
            while (_arg_1.position < _local_7)
            {
                _SafeStr_395.push(_arg_1.readACTIONRECORD());
            };
        }

        override public function publish(_arg_1:SWFData):void
        {
            var _local_4:uint;
            var _local_6:SWFData = new SWFData();
            var _local_3:uint;
            if (catchInRegisterFlag)
            {
                _local_3 = (_local_3 | 0x04);
            };
            if (_SafeStr_396)
            {
                _local_3 = (_local_3 | 0x02);
            };
            if (catchBlockFlag)
            {
                _local_3 = (_local_3 | 0x01);
            };
            _local_6.writeUI8(_local_3);
            var _local_5:SWFData = new SWFData();
            _local_4 = 0;
            while (_local_4 < tryBody.length)
            {
                _local_5.writeACTIONRECORD(tryBody[_local_4]);
                _local_4++;
            };
            var _local_2:SWFData = new SWFData();
            _local_4 = 0;
            while (_local_4 < catchBody.length)
            {
                _local_2.writeACTIONRECORD(catchBody[_local_4]);
                _local_4++;
            };
            var _local_7:SWFData = new SWFData();
            _local_4 = 0;
            while (_local_4 < _SafeStr_395.length)
            {
                _local_7.writeACTIONRECORD(_SafeStr_395[_local_4]);
                _local_4++;
            };
            _local_6.writeUI16(_local_5.length);
            _local_6.writeUI16(_local_2.length);
            _local_6.writeUI16(_local_7.length);
            if (catchInRegisterFlag)
            {
                _local_6.writeUI8(catchRegister);
            }
            else
            {
                _local_6.writeString(catchName);
            };
            _local_6.writeBytes(_local_5);
            _local_6.writeBytes(_local_2);
            _local_6.writeBytes(_local_7);
            write(_arg_1, _local_6);
        }

        override public function clone():IAction
        {
            var _local_1:uint;
            var _local_2:ActionTry = new ActionTry(code, length);
            _local_2.catchInRegisterFlag = catchInRegisterFlag;
            _local_2._SafeStr_396 = _SafeStr_396;
            _local_2.catchBlockFlag = catchBlockFlag;
            _local_2.catchName = catchName;
            _local_2.catchRegister = catchRegister;
            _local_1 = 0;
            while (_local_1 < tryBody.length)
            {
                _local_2.tryBody.push(tryBody[_local_1].clone());
                _local_1++;
            };
            _local_1 = 0;
            while (_local_1 < catchBody.length)
            {
                _local_2.catchBody.push(catchBody[_local_1].clone());
                _local_1++;
            };
            _local_1 = 0;
            while (_local_1 < _SafeStr_395.length)
            {
                _local_2._SafeStr_395.push(_SafeStr_395[_local_1].clone());
                _local_1++;
            };
            return (_local_2);
        }

        override public function toString(_arg_1:uint=0):String
        {
            var _local_3:uint;
            var _local_2:String = "[ActionTry] ";
            _local_2 = (_local_2 + ((catchInRegisterFlag) ? ("Register: " + catchRegister) : ("Name: " + catchName)));
            if (tryBody.length)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "Try:"));
                _local_3 = 0;
                while (_local_3 < tryBody.length)
                {
                    _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 4))) + "[") + _local_3) + "] ") + tryBody[_local_3].toString((_arg_1 + 4))));
                    _local_3++;
                };
            };
            if (catchBody.length)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "Catch:"));
                _local_3 = 0;
                while (_local_3 < catchBody.length)
                {
                    _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 4))) + "[") + _local_3) + "] ") + catchBody[_local_3].toString((_arg_1 + 4))));
                    _local_3++;
                };
            };
            if (_SafeStr_395.length)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "Finally:"));
                _local_3 = 0;
                while (_local_3 < _SafeStr_395.length)
                {
                    _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 4))) + "[") + _local_3) + "] ") + _SafeStr_395[_local_3].toString((_arg_1 + 4))));
                    _local_3++;
                };
            };
            return (_local_2);
        }


    }
}

