package com.sulake.core.window.motion
{
    import com.sulake.core.window.IWindow;
    import flash.utils.getTimer;

    use namespace friend;

    public class Interval extends Motion 
    {

        private var _SafeStr_1142:int;
        private var _duration:int;

        public function Interval(_arg_1:IWindow, _arg_2:int)
        {
            super(_arg_1);
            _SafeStr_1139 = false;
            _duration = _arg_2;
        }

        public function get duration():int
        {
            return (_duration);
        }

        override friend function start():void
        {
            super.friend::start();
            _SafeStr_1139 = false;
            _SafeStr_1142 = getTimer();
        }

        final override friend function tick(_arg_1:int):void
        {
            var _local_2:Number = ((_arg_1 - _SafeStr_1142) / _duration);
            if (_local_2 < 1)
            {
                friend::update(_local_2);
            }
            else
            {
                friend::update(1);
                _SafeStr_1139 = true;
            };
        }


    }
}

