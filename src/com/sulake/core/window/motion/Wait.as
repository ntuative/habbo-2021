package com.sulake.core.window.motion
{
    import flash.utils.getTimer;

    use namespace friend;

    public class Wait extends Motion 
    {

        private var _SafeStr_1142:int;
        private var _SafeStr_1160:int;

        public function Wait(_arg_1:int)
        {
            super(null);
            _SafeStr_1160 = _arg_1;
        }

        override public function get running():Boolean
        {
            return (_SafeStr_801);
        }

        override friend function start():void
        {
            super.friend::start();
            _SafeStr_1139 = false;
            _SafeStr_1142 = getTimer();
        }

        override friend function tick(_arg_1:int):void
        {
            _SafeStr_1139 = ((_arg_1 - _SafeStr_1142) >= _SafeStr_1160);
            if (_SafeStr_1139)
            {
                friend::stop();
            };
            super.friend::tick(_arg_1);
        }


    }
}

