package com.sulake.core.runtime.events
{
    import flash.events.IEventDispatcher;
    import com.sulake.core.runtime.IDisposable;
    import flash.events.EventDispatcher;
    import flash.utils.Dictionary;
    import com.sulake.core.Core;
    import flash.utils.getQualifiedClassName;
    import flash.events.Event;

        public class EventDispatcherWrapper implements IEventDispatcher, IDisposable 
    {

        private static const _SafeStr_829:uint = 0;
        private static const _SafeStr_830:uint = 1;
        private static const _SafeStr_831:uint = 2;

        protected var _disposed:Boolean = false;
        private var _SafeStr_832:EventDispatcher;
        private var _SafeStr_833:Dictionary = new Dictionary();
        private var _SafeStr_834:uint;
        private var _error:Error;

        public function EventDispatcherWrapper(_arg_1:IEventDispatcher=null)
        {
            _SafeStr_832 = new EventDispatcher(((_arg_1) ? _arg_1 : this));
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get error():Error
        {
            return (_error);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            var _local_8:Array = _SafeStr_833[_arg_1];
            var _local_6:EventListenerStruct = new EventListenerStruct(_arg_2, _arg_3, _arg_4, _arg_5);
            if (!_local_8)
            {
                _local_8 = [_local_6];
                _SafeStr_833[_arg_1] = _local_8;
                _SafeStr_832.addEventListener(_arg_1, eventProcessor);
            }
            else
            {
                for each (var _local_7:EventListenerStruct in _local_8)
                {
                    if (((_local_7.callback == _arg_2) && (_local_7.useCapture == _arg_3)))
                    {
                        return;
                    };
                    if (_arg_4 > _local_7.priority)
                    {
                        _local_8.splice(_local_8.indexOf(_local_7), 0, _local_6);
                        return;
                    };
                };
                _local_8.push(_local_6);
            };
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            var _local_5:Array;
            var _local_6:uint;
            if (!_disposed)
            {
                _local_5 = _SafeStr_833[_arg_1];
                if (_local_5)
                {
                    _local_6 = 0;
                    for each (var _local_4:EventListenerStruct in _local_5)
                    {
                        if (((_local_4.callback == _arg_2) && (_local_4.useCapture == _arg_3)))
                        {
                            _local_5.splice(_local_6, 1);
                            _local_4.callback = null;
                            if (_local_5.length == 0)
                            {
                                delete _SafeStr_833[_arg_1];
                                _SafeStr_832.removeEventListener(_arg_1, eventProcessor);
                            };
                            return;
                        };
                        _local_6++;
                    };
                };
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            if (!_disposed)
            {
                _SafeStr_834 = 0;
                _SafeStr_832.dispatchEvent(_arg_1);
                if (_SafeStr_834 == 2)
                {
                    if (_error != null)
                    {
                        Core.crash(((("Error caught when handling " + getQualifiedClassName(_arg_1)) + ": ") + _error.message), _error.errorID, _error);
                    }
                    else
                    {
                        Core.crash((("Error caught when handling " + getQualifiedClassName(_arg_1)) + ". No error data available!"), 0, _error);
                    };
                };
                return (_SafeStr_834 == 0);
            };
            return (false);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return ((_disposed) ? false : (!(_SafeStr_833[_arg_1] == null)));
        }

        public function callEventListeners(_arg_1:String):void
        {
            var _local_3:Array = _SafeStr_833[_arg_1];
            if (_local_3)
            {
                for each (var _local_2:EventListenerStruct in _local_3)
                {
                    _local_2.callback(null);
                };
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return ((_disposed) ? false : (!(_SafeStr_833[_arg_1] == null)));
        }

        private function eventProcessor(_arg_1:Event):void
        {
            var _local_4:Function;
            var _local_5:Array;
            var _local_3:Array = _SafeStr_833[_arg_1.type];
            if (_local_3)
            {
                _local_5 = [];
                for each (var _local_2:EventListenerStruct in _local_3)
                {
                    _local_5.push(_local_2.callback);
                };
                while (_local_5.length > 0)
                {
                    try
                    {
                        _local_4 = _local_5.shift();
                        (_local_4(_arg_1));
                    }
                    catch(e:Error)
                    {
                        Logger.log(e.getStackTrace());
                        _SafeStr_834 = 2;
                        _error = e;
                        return;
                    };
                };
            };
            _SafeStr_834 = ((_arg_1.isDefaultPrevented()) ? 1 : 0);
        }

        public function dispose():void
        {
            var _local_2:Array;
            if (!_disposed)
            {
                for (var _local_3:String in _SafeStr_833)
                {
                    _local_2 = (_SafeStr_833[_local_3] as Array);
                    for each (var _local_1:EventListenerStruct in _local_2)
                    {
                        _local_1.callback = null;
                    };
                    delete _SafeStr_833[_local_3];
                    _SafeStr_832.removeEventListener(_local_3, eventProcessor);
                };
                _SafeStr_833 = null;
                _SafeStr_832 = null;
                _disposed = true;
            };
        }


    }
}

