package com.sulake.core.runtime.events
{
    import flash.utils.Dictionary;

    public class EventListenerStruct 
    {

        private var _SafeStr_747:Dictionary;
        public var useCapture:Boolean;
        public var priority:int;
        public var useWeakReference:Boolean;

        public function EventListenerStruct(_arg_1:Function, _arg_2:Boolean=false, _arg_3:int=0, _arg_4:Boolean=false)
        {
            _SafeStr_747 = new Dictionary(_arg_4);
            this.callback = _arg_1;
            this.useCapture = _arg_2;
            this.priority = _arg_3;
            this.useWeakReference = _arg_4;
        }

        public function set callback(_arg_1:Function):void
        {
            for (var _local_2:Object in _SafeStr_747)
            {
                delete _SafeStr_747[_local_2];
            };
            _SafeStr_747[_arg_1] = null;
        }

        public function get callback():Function
        {
            for (var _local_1:Object in _SafeStr_747)
            {
                return (_local_1 as Function);
            };
            return (null);
        }


    }
}

