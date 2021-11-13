package com.sulake.core.window.motion
{
    use namespace friend;

    public class Ease extends Interval 
    {

        protected var _SafeStr_1140:Interval;

        public function Ease(_arg_1:Interval)
        {
            super(_arg_1.target, _arg_1.duration);
            _SafeStr_1140 = _arg_1;
        }

        override friend function start():void
        {
            super.friend::start();
            _SafeStr_1140.friend::start();
        }

        override friend function update(_arg_1:Number):void
        {
            super.friend::update(_arg_1);
            _SafeStr_1140.friend::update(_arg_1);
        }

        override friend function stop():void
        {
            super.friend::stop();
            _SafeStr_1140.friend::stop();
        }


    }
}

