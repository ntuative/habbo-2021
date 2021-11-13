package com.sulake.habbo.utils.animation
{
    import flash.events.EventDispatcher;
    import __AS3__.vec.Vector;
    import flash.events.Event;

    public class DelayedCall extends EventDispatcher implements IAnimatable 
    {

        private static var _SafeStr_4333:Vector.<DelayedCall> = new Vector.<DelayedCall>(0);

        private var _currentTime:Number;
        private var _totalTime:Number;
        private var _SafeStr_4334:Function;
        private var _SafeStr_4335:Array;
        private var _repeatCount:int;

        public function DelayedCall(_arg_1:Function, _arg_2:Number, _arg_3:Array=null)
        {
            reset(_arg_1, _arg_2, _arg_3);
        }

        internal static function fromPool(_arg_1:Function, _arg_2:Number, _arg_3:Array=null):DelayedCall
        {
            if (_SafeStr_4333.length)
            {
                return (_SafeStr_4333.pop().reset(_arg_1, _arg_2, _arg_3));
            };
            return (new DelayedCall(_arg_1, _arg_2, _arg_3));
        }

        internal static function toPool(_arg_1:DelayedCall):void
        {
            _arg_1._SafeStr_4334 = null;
            _arg_1._SafeStr_4335 = null;
            _arg_1.removeEventListeners();
            _SafeStr_4333.push(_arg_1);
        }


        public function reset(_arg_1:Function, _arg_2:Number, _arg_3:Array=null):DelayedCall
        {
            _currentTime = 0;
            _totalTime = Math.max(_arg_2, 0.0001);
            _SafeStr_4334 = _arg_1;
            _SafeStr_4335 = _arg_3;
            _repeatCount = 1;
            return (this);
        }

        public function advanceTime(_arg_1:Number):void
        {
            var _local_2:Function;
            var _local_3:Array;
            var _local_4:Number = _currentTime;
            _currentTime = (_currentTime + _arg_1);
            if (_currentTime > _totalTime)
            {
                _currentTime = _totalTime;
            };
            if (((_local_4 < _totalTime) && (_currentTime >= _totalTime)))
            {
                if (((_repeatCount == 0) || (_repeatCount > 1)))
                {
                    _SafeStr_4334.apply(null, _SafeStr_4335);
                    if (_repeatCount > 0)
                    {
                        _repeatCount = (_repeatCount - 1);
                    };
                    _currentTime = 0;
                    advanceTime(((_local_4 + _arg_1) - _totalTime));
                }
                else
                {
                    _local_2 = _SafeStr_4334;
                    _local_3 = _SafeStr_4335;
                    dispatchEvent(new Event("REMOVE_FROM_JUGGLER"));
                    _local_2.apply(null, _local_3);
                };
            };
        }

        public function complete():void
        {
            var _local_1:Number = (_totalTime - _currentTime);
            if (_local_1 > 0)
            {
                advanceTime(_local_1);
            };
        }

        public function get isComplete():Boolean
        {
            return ((_repeatCount == 1) && (_currentTime >= _totalTime));
        }

        public function get totalTime():Number
        {
            return (_totalTime);
        }

        public function get currentTime():Number
        {
            return (_currentTime);
        }

        public function get repeatCount():int
        {
            return (_repeatCount);
        }

        public function set repeatCount(_arg_1:int):void
        {
            _repeatCount = _arg_1;
        }

        private function removeEventListeners():void
        {
        }


    }
}

