package com.sulake.core.window.motion
{
    import __AS3__.vec.Vector;
    import flash.utils.Timer;
    import com.sulake.core.Core;
    import com.sulake.core.window.IWindow;
    import flash.utils.getTimer;
    import flash.events.TimerEvent;

    use namespace friend;

    public class Motions 
    {

        private static const _SafeStr_1149:Vector.<Motion> = new Vector.<Motion>();
        private static const _SafeStr_1150:Vector.<Motion> = new Vector.<Motion>();
        private static const _SafeStr_1151:Vector.<Motion> = new Vector.<Motion>();
        private static const _TIMER:Timer = new Timer((1000 / Core.instance.displayObjectContainer.stage.frameRate), 0);

        private static var _isUpdating:Boolean;


        public static function runMotion(_arg_1:Motion):Motion
        {
            if (((_SafeStr_1150.indexOf(_arg_1) == -1) && (_SafeStr_1149.indexOf(_arg_1) == -1)))
            {
                if (_isUpdating)
                {
                    _SafeStr_1149.push(_arg_1);
                }
                else
                {
                    _SafeStr_1150.push(_arg_1);
                    _arg_1.friend::start();
                };
                startTimer();
            };
            return (_arg_1);
        }

        public static function removeMotion(_arg_1:Motion):void
        {
            var _local_2:int = _SafeStr_1150.indexOf(_arg_1);
            if (_local_2 > -1)
            {
                if (_isUpdating)
                {
                    _local_2 = _SafeStr_1151.indexOf(_arg_1);
                    if (_local_2 == -1)
                    {
                        _SafeStr_1151.push(_arg_1);
                    };
                }
                else
                {
                    _SafeStr_1150.splice(_local_2, 1);
                    if (_arg_1.running)
                    {
                        _arg_1.friend::stop();
                    };
                    if (_SafeStr_1150.length == 0)
                    {
                        stopTimer();
                    };
                };
            }
            else
            {
                _local_2 = _SafeStr_1149.indexOf(_arg_1);
                if (_local_2 > -1)
                {
                    _SafeStr_1149.splice(_local_2, 1);
                };
            };
        }

        public static function getMotionByTag(_arg_1:String):Motion
        {
            var _local_2:Motion;
            for each (_local_2 in _SafeStr_1150)
            {
                if (_local_2.tag == _arg_1)
                {
                    return (_local_2);
                };
            };
            for each (_local_2 in _SafeStr_1149)
            {
                if (_local_2.tag == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public static function getMotionByTarget(_arg_1:IWindow):Motion
        {
            var _local_2:Motion;
            for each (_local_2 in _SafeStr_1150)
            {
                if (_local_2.target == _arg_1)
                {
                    return (_local_2);
                };
            };
            for each (_local_2 in _SafeStr_1149)
            {
                if (_local_2.target == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public static function getMotionByTagAndTarget(_arg_1:String, _arg_2:IWindow):Motion
        {
            var _local_3:Motion;
            for each (_local_3 in _SafeStr_1150)
            {
                if (((_local_3.tag == _arg_1) && (_local_3.target == _arg_2)))
                {
                    return (_local_3);
                };
            };
            for each (_local_3 in _SafeStr_1149)
            {
                if (((_local_3.tag == _arg_1) && (_local_3.target == _arg_2)))
                {
                    return (_local_3);
                };
            };
            return (null);
        }

        public static function get isRunning():Boolean
        {
            return ((_TIMER) ? _TIMER.running : false);
        }

        public static function get isUpdating():Boolean
        {
            return (_isUpdating);
        }

        private static function onTick(_arg_1:TimerEvent):void
        {
            var _local_2:Motion;
            _isUpdating = true;
            var _local_3:int = getTimer();
            while ((_local_2 = _SafeStr_1149.pop()) != null)
            {
                _SafeStr_1150.push(_local_2);
            };
            while ((_local_2 = _SafeStr_1151.pop()) != null)
            {
                _SafeStr_1150.splice(_SafeStr_1150.indexOf(_local_2), 1);
                if (_local_2.running)
                {
                    _local_2.friend::stop();
                };
            };
            for each (_local_2 in _SafeStr_1150)
            {
                if (_local_2.running)
                {
                    _local_2.friend::tick(_local_3);
                    if (_local_2.complete)
                    {
                        removeMotion(_local_2);
                    };
                }
                else
                {
                    removeMotion(_local_2);
                };
            };
            if (_SafeStr_1150.length == 0)
            {
                stopTimer();
            };
            _isUpdating = false;
        }

        private static function startTimer():void
        {
            if (!_TIMER.running)
            {
                _TIMER.addEventListener("timer", onTick);
                _TIMER.start();
            };
        }

        private static function stopTimer():void
        {
            if (_TIMER.running)
            {
                _TIMER.removeEventListener("timer", onTick);
                _TIMER.stop();
            };
        }


        public function getNumRunningMotions(_arg_1:IWindow):int
        {
            var _local_2:int;
            for each (var _local_3:Motion in _SafeStr_1150)
            {
                if (_local_3.target == _arg_1)
                {
                    _local_2++;
                };
            };
            return (_local_2);
        }


    }
}

