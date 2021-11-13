package com.codeazur.as3swf.data
{
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.data.actions.IAction;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.utils.StringUtils;

    public class SWFClipActionRecord 
    {

        public var _SafeStr_338:SWFClipEventFlags;
        public var keyCode:uint;
        protected var _SafeStr_701:Vector.<IAction>;

        public function SWFClipActionRecord(_arg_1:SWFData=null, _arg_2:uint=0)
        {
            _SafeStr_701 = new Vector.<IAction>();
            if (_arg_1 != null)
            {
                parse(_arg_1, _arg_2);
            };
        }

        public function get actions():Vector.<IAction>
        {
            return (_SafeStr_701);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:IAction;
            _SafeStr_338 = _arg_1.readCLIPEVENTFLAGS(_arg_2);
            _arg_1.readUI32();
            if (_SafeStr_338._SafeStr_365)
            {
                keyCode = _arg_1.readUI8();
            };
            while ((_local_3 = _arg_1.readACTIONRECORD()) != null)
            {
                _SafeStr_701.push(_local_3);
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:uint;
            _arg_1.writeCLIPEVENTFLAGS(_SafeStr_338, _arg_2);
            var _local_4:SWFData = new SWFData();
            if (_SafeStr_338._SafeStr_365)
            {
                _local_4.writeUI8(keyCode);
            };
            _local_3 = 0;
            while (_local_3 < actions.length)
            {
                _local_4.writeACTIONRECORD(actions[_local_3]);
                _local_3++;
            };
            _local_4.writeUI8(0);
            _arg_1.writeUI32(_local_4.length);
            _arg_1.writeBytes(_local_4);
        }

        public function toString(_arg_1:uint=0):String
        {
            var _local_3:uint;
            var _local_2:String = (("ClipActionRecords (" + _SafeStr_338.toString()) + "):");
            if (keyCode > 0)
            {
                _local_2 = (_local_2 + (", KeyCode: " + keyCode));
            };
            _local_2 = (_local_2 + ":");
            _local_3 = 0;
            while (_local_3 < _SafeStr_701.length)
            {
                _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 2))) + "[") + _local_3) + "] ") + _SafeStr_701[_local_3].toString((_arg_1 + 2))));
                _local_3++;
            };
            return (_local_2);
        }


    }
}

