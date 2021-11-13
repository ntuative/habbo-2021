package com.sulake.core.window.events
{
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.Dictionary;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.runtime.events.EventListenerStruct;

    public class WindowEventDispatcher implements IDisposable 
    {

        private static const _SafeStr_829:uint = 0;
        private static const _SafeStr_830:uint = 1;
        private static const _SafeStr_831:uint = 2;

        protected var _disposed:Boolean = false;
        private var _SafeStr_833:Dictionary = new Dictionary();
        private var _SafeStr_834:uint;
        private var _error:Error;

        public function WindowEventDispatcher(_arg_1:IWindow)
        {
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get error():Error
        {
            return (_error);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:int=0):void
        {
            var _local_6:Array = _SafeStr_833[_arg_1];
            var _local_4:EventListenerStruct = new EventListenerStruct(_arg_2, false, _arg_3);
            if (!_local_6)
            {
                _local_6 = [_local_4];
                _SafeStr_833[_arg_1] = _local_6;
            }
            else
            {
                for each (var _local_5:EventListenerStruct in _local_6)
                {
                    if (_local_5.callback == _arg_2)
                    {
                        return;
                    };
                    if (_arg_3 > _local_5.priority)
                    {
                        _local_6.splice(_local_6.indexOf(_local_5), 0, _local_4);
                        return;
                    };
                };
                _local_6.push(_local_4);
            };
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function):void
        {
            var _local_4:Array;
            var _local_5:uint;
            if (!_disposed)
            {
                _local_4 = _SafeStr_833[_arg_1];
                if (_local_4)
                {
                    _local_5 = 0;
                    for each (var _local_3:EventListenerStruct in _local_4)
                    {
                        if (_local_3.callback == _arg_2)
                        {
                            _local_4.splice(_local_5, 1);
                            _local_3.callback = null;
                            if (_local_4.length == 0)
                            {
                                delete _SafeStr_833[_arg_1];
                            };
                            return;
                        };
                        _local_5++;
                    };
                };
            };
        }

        public function dispatchEvent(_arg_1:WindowEvent):Boolean
        {
            var _local_3:Array;
            var _local_4:Function;
            var _local_5:Array;
            if (!_disposed)
            {
                _SafeStr_834 = 0;
                _local_3 = _SafeStr_833[_arg_1.type];
                if (_local_3)
                {
                    _local_5 = [];
                    for each (var _local_2:EventListenerStruct in _local_3)
                    {
                        _local_5.push(_local_2.callback);
                    };
                    while (_local_5.length > 0)
                    {
                        _local_4 = _local_5.shift();
                        (_local_4(_arg_1));
                    };
                };
                _SafeStr_834 = ((_arg_1.isDefaultPrevented()) ? 1 : 0);
                return (_SafeStr_834 == 0);
            };
            return (false);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return ((_disposed) ? false : (!(_SafeStr_833[_arg_1] == null)));
        }

        public function dispose():void
        {
            var _local_2:Array;
            if (!_disposed)
            {
                for (var _local_3:Object in _SafeStr_833)
                {
                    _local_2 = (_SafeStr_833[_local_3] as Array);
                    for each (var _local_1:EventListenerStruct in _local_2)
                    {
                        _local_1.callback = null;
                    };
                    delete _SafeStr_833[_local_3];
                };
                _SafeStr_833 = null;
                _disposed = true;
            };
        }


    }
}

