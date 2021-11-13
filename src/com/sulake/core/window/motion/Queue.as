package com.sulake.core.window.motion
{
    import __AS3__.vec.Vector;

    use namespace friend;

    public class Queue extends Motion 
    {

        private var _motion:Motion;
        private var _SafeStr_800:Vector.<Motion> = new Vector.<Motion>();

        public function Queue(... _args)
        {
            super(((_args) ? Motion(_args[0]).target : null));
            for each (var _local_2:Motion in _args)
            {
                _SafeStr_800.push(_local_2);
            };
            _motion = _args[0];
            _SafeStr_1139 = (_motion == null);
        }

        override public function get running():Boolean
        {
            return (((_SafeStr_801) && (_motion)) ? _motion.running : false);
        }

        override friend function start():void
        {
            super.friend::start();
            _motion.friend::start();
        }

        override friend function update(_arg_1:Number):void
        {
            super.friend::update(_arg_1);
            if (_motion.running)
            {
                _motion.friend::update(_arg_1);
            };
        }

        override friend function stop():void
        {
            super.friend::stop();
            _motion.friend::stop();
        }

        override friend function tick(_arg_1:int):void
        {
            var _local_2:int;
            super.friend::tick(_arg_1);
            _motion.friend::tick(_arg_1);
            if (_motion.complete)
            {
                _motion.friend::stop();
                _local_2 = _SafeStr_800.indexOf(_motion);
                if (_local_2 < (_SafeStr_800.length - 1))
                {
                    _motion = _SafeStr_800[(_local_2 + 1)];
                    _SafeStr_1138 = _motion.target;
                    _motion.friend::start();
                }
                else
                {
                    _SafeStr_1139 = true;
                };
            };
        }


    }
}

