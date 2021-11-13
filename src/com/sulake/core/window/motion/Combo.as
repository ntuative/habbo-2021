package com.sulake.core.window.motion
{
    import __AS3__.vec.Vector;

    use namespace friend;

    public class Combo extends Motion 
    {

        private var _SafeStr_1136:Vector.<Motion> = new Vector.<Motion>();
        private var _SafeStr_1137:Vector.<Motion> = new Vector.<Motion>();

        public function Combo(... _args)
        {
            for each (var _local_2:Motion in _args)
            {
                _SafeStr_1136.push(_local_2);
            };
            super(((_SafeStr_1136.length > 0) ? _SafeStr_1136[0].target : null));
        }

        override friend function start():void
        {
            super.friend::start();
            for each (var _local_1:Motion in _SafeStr_1136)
            {
                _local_1.friend::start();
            };
        }

        override friend function tick(_arg_1:int):void
        {
            var _local_2:Motion;
            super.friend::tick(_arg_1);
            while ((_local_2 = _SafeStr_1137.pop()) != null)
            {
                _SafeStr_1136.splice(_SafeStr_1137.indexOf(_local_2), 1);
                if (_local_2.running)
                {
                    _local_2.friend::stop();
                };
            };
            for each (_local_2 in _SafeStr_1136)
            {
                if (_local_2.running)
                {
                    _local_2.friend::tick(_arg_1);
                };
                if (_local_2.complete)
                {
                    _SafeStr_1137.push(_local_2);
                };
            };
            if (_SafeStr_1136.length > 0)
            {
                for each (_local_2 in _SafeStr_1136)
                {
                    _SafeStr_1138 = _local_2.target;
                    if (((_SafeStr_1138) && (!(_SafeStr_1138.disposed)))) break;
                };
                _SafeStr_1139 = false;
            }
            else
            {
                _SafeStr_1139 = true;
            };
        }


    }
}

