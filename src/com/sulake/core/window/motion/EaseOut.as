package com.sulake.core.window.motion
{
    use namespace friend;

    public class EaseOut extends EaseRate 
    {

        public function EaseOut(_arg_1:Interval, _arg_2:Number)
        {
            super(_arg_1, _arg_2);
        }

        override friend function update(_arg_1:Number):void
        {
            _SafeStr_1140.friend::update(Math.pow(_arg_1, (1 / _SafeStr_1141)));
        }


    }
}

