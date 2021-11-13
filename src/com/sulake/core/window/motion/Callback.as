package com.sulake.core.window.motion
{
    use namespace friend;

    public class Callback extends Motion 
    {

        protected var _callback:Function;

        public function Callback(_arg_1:Function)
        {
            _callback = _arg_1;
            super(null);
        }

        override public function get running():Boolean
        {
            return ((_SafeStr_801) && (!(_callback == null)));
        }

        override friend function tick(_arg_1:int):void
        {
            super.friend::tick(_arg_1);
            if (_callback != null)
            {
                (_callback(this));
                _callback = null;
            };
        }


    }
}

