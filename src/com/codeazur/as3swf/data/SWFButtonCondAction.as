package com.codeazur.as3swf.data
{
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.data.actions.IAction;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.utils.StringUtils;

    public class SWFButtonCondAction 
    {

        public var _SafeStr_387:uint;
        public var _SafeStr_377:Boolean;
        public var _SafeStr_378:Boolean;
        public var _SafeStr_379:Boolean;
        public var _SafeStr_380:Boolean;
        public var _SafeStr_381:Boolean;
        public var _SafeStr_382:Boolean;
        public var _SafeStr_383:Boolean;
        public var _SafeStr_384:Boolean;
        public var _SafeStr_385:Boolean;
        public var _SafeStr_386:uint;
        protected var _SafeStr_701:Vector.<IAction>;

        public function SWFButtonCondAction(_arg_1:SWFData=null)
        {
            _SafeStr_701 = new Vector.<IAction>();
            if (_arg_1 != null)
            {
                parse(_arg_1);
            };
        }

        public function get actions():Vector.<IAction>
        {
            return (_SafeStr_701);
        }

        public function parse(_arg_1:SWFData):void
        {
            var _local_3:IAction;
            var _local_2:uint = ((_arg_1.readUI8() << 8) | _arg_1.readUI8());
            _SafeStr_377 = (!((_local_2 & 0x8000) == 0));
            _SafeStr_378 = (!((_local_2 & 0x4000) == 0));
            _SafeStr_379 = (!((_local_2 & 0x2000) == 0));
            _SafeStr_380 = (!((_local_2 & 0x1000) == 0));
            _SafeStr_381 = (!((_local_2 & 0x0800) == 0));
            _SafeStr_382 = (!((_local_2 & 0x0400) == 0));
            _SafeStr_383 = (!((_local_2 & 0x0200) == 0));
            _SafeStr_384 = (!((_local_2 & 0x0100) == 0));
            _SafeStr_385 = (!((_local_2 & 0x01) == 0));
            _SafeStr_386 = ((_local_2 & 0xFF) >> 1);
            while ((_local_3 = _arg_1.readACTIONRECORD()) != null)
            {
                _SafeStr_701.push(_local_3);
            };
        }

        public function publish(_arg_1:SWFData):void
        {
            var _local_4:uint;
            var _local_3:uint;
            if (_SafeStr_377)
            {
                _local_3 = (_local_3 | 0x80);
            };
            if (_SafeStr_378)
            {
                _local_3 = (_local_3 | 0x40);
            };
            if (_SafeStr_379)
            {
                _local_3 = (_local_3 | 0x20);
            };
            if (_SafeStr_380)
            {
                _local_3 = (_local_3 | 0x10);
            };
            if (_SafeStr_381)
            {
                _local_3 = (_local_3 | 0x08);
            };
            if (_SafeStr_382)
            {
                _local_3 = (_local_3 | 0x04);
            };
            if (_SafeStr_383)
            {
                _local_3 = (_local_3 | 0x02);
            };
            if (_SafeStr_384)
            {
                _local_3 = (_local_3 | 0x01);
            };
            _arg_1.writeUI8(_local_3);
            var _local_2:uint = (_SafeStr_386 << 1);
            if (_SafeStr_385)
            {
                _local_2 = (_local_2 | 0x01);
            };
            _arg_1.writeUI8(_local_2);
            _local_4 = 0;
            while (_local_4 < actions.length)
            {
                _arg_1.writeACTIONRECORD(actions[_local_4]);
                _local_4++;
            };
            _arg_1.writeUI8(0);
        }

        public function clone():SWFButtonCondAction
        {
            var _local_1:uint;
            var _local_2:SWFButtonCondAction = new SWFButtonCondAction();
            _local_2._SafeStr_387 = _SafeStr_387;
            _local_2._SafeStr_377 = _SafeStr_377;
            _local_2._SafeStr_378 = _SafeStr_378;
            _local_2._SafeStr_379 = _SafeStr_379;
            _local_2._SafeStr_380 = _SafeStr_380;
            _local_2._SafeStr_381 = _SafeStr_381;
            _local_2._SafeStr_382 = _SafeStr_382;
            _local_2._SafeStr_383 = _SafeStr_383;
            _local_2._SafeStr_384 = _SafeStr_384;
            _local_2._SafeStr_385 = _SafeStr_385;
            _local_2._SafeStr_386 = _SafeStr_386;
            _local_1 = 0;
            while (_local_1 < actions.length)
            {
                _local_2.actions.push(actions[_local_1].clone());
                _local_1++;
            };
            return (_local_2);
        }

        public function toString(_arg_1:uint=0):String
        {
            var _local_4:uint;
            var _local_3:Array = [];
            if (_SafeStr_377)
            {
                _local_3.push("idleToOverDown");
            };
            if (_SafeStr_378)
            {
                _local_3.push("outDownToIdle");
            };
            if (_SafeStr_379)
            {
                _local_3.push("outDownToOverDown");
            };
            if (_SafeStr_380)
            {
                _local_3.push("overDownToOutDown");
            };
            if (_SafeStr_381)
            {
                _local_3.push("overDownToOverUp");
            };
            if (_SafeStr_382)
            {
                _local_3.push("overUpToOverDown");
            };
            if (_SafeStr_383)
            {
                _local_3.push("overUpToIdle");
            };
            if (_SafeStr_384)
            {
                _local_3.push("idleToOverUp");
            };
            if (_SafeStr_385)
            {
                _local_3.push("overDownToIdle");
            };
            var _local_2:String = ((("Cond: (" + _local_3.join(",")) + "), KeyPress: ") + _SafeStr_386);
            _local_4 = 0;
            while (_local_4 < _SafeStr_701.length)
            {
                _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 2))) + "[") + _local_4) + "] ") + _SafeStr_701[_local_4].toString((_arg_1 + 2))));
                _local_4++;
            };
            return (_local_2);
        }


    }
}

