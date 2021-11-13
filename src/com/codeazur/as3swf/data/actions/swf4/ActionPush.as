package com.codeazur.as3swf.data.actions.swf4
{
    import com.codeazur.as3swf.data.actions.Action;
    import com.codeazur.as3swf.data.actions.IAction;
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.data.SWFActionValue;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.data.actions.*;

    public class ActionPush extends Action implements IAction 
    {

        public static const CODE:uint = 150;

        public var values:Vector.<SWFActionValue>;

        public function ActionPush(_arg_1:uint, _arg_2:uint)
        {
            super(_arg_1, _arg_2);
            values = new Vector.<SWFActionValue>();
        }

        override public function parse(_arg_1:SWFData):void
        {
            var _local_2:uint = (_arg_1.position + length);
            while (_arg_1.position != _local_2)
            {
                values.push(_arg_1.readACTIONVALUE());
            };
        }

        override public function publish(_arg_1:SWFData):void
        {
            var _local_2:uint;
            var _local_3:SWFData = new SWFData();
            _local_2 = 0;
            while (_local_2 < values.length)
            {
                _local_3.writeACTIONVALUE(values[_local_2]);
                _local_2++;
            };
            write(_arg_1, _local_3);
        }

        override public function clone():IAction
        {
            var _local_2:uint;
            var _local_1:ActionPush = new ActionPush(code, length);
            _local_2 = 0;
            while (_local_2 < values.length)
            {
                _local_1.values.push(values[_local_2].clone());
                _local_2++;
            };
            return (_local_1);
        }

        override public function toString(_arg_1:uint=0):String
        {
            return ("[ActionPush] " + values.join(", "));
        }


    }
}