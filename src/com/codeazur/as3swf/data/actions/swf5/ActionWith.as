package com.codeazur.as3swf.data.actions.swf5
{
    import com.codeazur.as3swf.data.actions.Action;
    import com.codeazur.as3swf.data.actions.IAction;
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.utils.StringUtils;
    import com.codeazur.as3swf.data.actions.*;

    public class ActionWith extends Action implements IAction 
    {

        public static const CODE:uint = 148;

        public var _SafeStr_411:Vector.<IAction>;

        public function ActionWith(_arg_1:uint, _arg_2:uint)
        {
            super(_arg_1, _arg_2);
            _SafeStr_411 = new Vector.<IAction>();
        }

        override public function parse(_arg_1:SWFData):void
        {
            var _local_3:uint = _arg_1.readUI16();
            var _local_2:uint = (_arg_1.position + _local_3);
            while (_arg_1.position < _local_2)
            {
                _SafeStr_411.push(_arg_1.readACTIONRECORD());
            };
        }

        override public function publish(_arg_1:SWFData):void
        {
            var _local_2:uint;
            var _local_3:SWFData = new SWFData();
            var _local_4:SWFData = new SWFData();
            _local_2 = 0;
            while (_local_2 < _SafeStr_411.length)
            {
                _local_4.writeACTIONRECORD(_SafeStr_411[_local_2]);
                _local_2++;
            };
            _local_3.writeUI16(_local_4.length);
            _local_3.writeBytes(_local_4);
            write(_arg_1, _local_3);
        }

        override public function clone():IAction
        {
            var _local_2:uint;
            var _local_1:ActionWith = new ActionWith(code, length);
            _local_2 = 0;
            while (_local_2 < _SafeStr_411.length)
            {
                _local_1._SafeStr_411.push(_SafeStr_411[_local_2].clone());
                _local_2++;
            };
            return (_local_1);
        }

        override public function toString(_arg_1:uint=0):String
        {
            var _local_3:uint;
            var _local_2:String = "[ActionWith]";
            _local_3 = 0;
            while (_local_3 < _SafeStr_411.length)
            {
                _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 4))) + "[") + _local_3) + "] ") + _SafeStr_411[_local_3].toString((_arg_1 + 4))));
                _local_3++;
            };
            return (_local_2);
        }


    }
}

