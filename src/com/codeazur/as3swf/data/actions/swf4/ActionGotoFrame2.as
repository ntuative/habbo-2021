package com.codeazur.as3swf.data.actions.swf4
{
    import com.codeazur.as3swf.data.actions.Action;
    import com.codeazur.as3swf.data.actions.IAction;
    import com.codeazur.as3swf.SWFData;

    public class ActionGotoFrame2 extends Action implements IAction 
    {

        public static const CODE:uint = 159;

        public var _SafeStr_405:Boolean;
        public var _SafeStr_406:Boolean;
        public var _SafeStr_407:uint;

        public function ActionGotoFrame2(_arg_1:uint, _arg_2:uint)
        {
            super(_arg_1, _arg_2);
        }

        override public function parse(_arg_1:SWFData):void
        {
            var _local_2:uint = _arg_1.readUI8();
            _SafeStr_405 = (!((_local_2 & 0x02) == 0));
            _SafeStr_406 = (!((_local_2 & 0x01) == 0));
            if (_SafeStr_405)
            {
                _SafeStr_407 = _arg_1.readUI16();
            };
        }

        override public function publish(_arg_1:SWFData):void
        {
            var _local_3:SWFData = new SWFData();
            var _local_2:uint;
            if (_SafeStr_405)
            {
                _local_2 = (_local_2 | 0x02);
            };
            if (_SafeStr_406)
            {
                _local_2 = (_local_2 | 0x01);
            };
            _local_3.writeUI8(_local_2);
            if (_SafeStr_405)
            {
                _local_3.writeUI16(_SafeStr_407);
            };
            write(_arg_1, _local_3);
        }

        override public function clone():IAction
        {
            var _local_1:ActionGotoFrame2 = new ActionGotoFrame2(code, length);
            _local_1._SafeStr_405 = _SafeStr_405;
            _local_1._SafeStr_406 = _SafeStr_406;
            _local_1._SafeStr_407 = _SafeStr_407;
            return (_local_1);
        }

        override public function toString(_arg_1:uint=0):String
        {
            var _local_2:String = (("[ActionGotoFrame2] PlayFlag: " + _SafeStr_406) + ", ");
            ("SceneBiasFlag: " + _SafeStr_405);
            if (_SafeStr_405)
            {
                _local_2 = (_local_2 + (", " + _SafeStr_407));
            };
            return (_local_2);
        }


    }
}

