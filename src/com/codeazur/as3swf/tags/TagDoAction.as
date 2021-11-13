package com.codeazur.as3swf.tags
{
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.data.actions.IAction;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.utils.StringUtils;

    public class TagDoAction implements ITag 
    {

        public static const TYPE:uint = 12;

        protected var _SafeStr_701:Vector.<IAction>;

        public function TagDoAction()
        {
            _SafeStr_701 = new Vector.<IAction>();
        }

        public function get actions():Vector.<IAction>
        {
            return (_SafeStr_701);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            var _local_5:IAction;
            while ((_local_5 = _arg_1.readACTIONRECORD()) != null)
            {
                _SafeStr_701.push(_local_5);
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:uint;
            var _local_4:SWFData = new SWFData();
            _local_3 = 0;
            while (_local_3 < _SafeStr_701.length)
            {
                _local_4.writeACTIONRECORD(_SafeStr_701[_local_3]);
                _local_3++;
            };
            _local_4.writeUI8(0);
            _arg_1.writeTagHeader(type, _local_4.length);
            _arg_1.writeBytes(_local_4);
        }

        public function get type():uint
        {
            return (12);
        }

        public function get name():String
        {
            return ("DoAction");
        }

        public function get version():uint
        {
            return (3);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            var _local_3:uint;
            var _local_2:String = _SafeStr_64.toStringCommon(type, name, _arg_1);
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

