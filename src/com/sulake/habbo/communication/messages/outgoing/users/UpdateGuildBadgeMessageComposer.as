package com.sulake.habbo.communication.messages.outgoing.users
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class UpdateGuildBadgeMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_690:Array = [];

        public function UpdateGuildBadgeMessageComposer(_arg_1:int, _arg_2:Array)
        {
            var _local_3:int;
            super();
            _SafeStr_690.push(_arg_1);
            _SafeStr_690.push(_arg_2.length);
            _local_3 = 0;
            while (_local_3 < _arg_2.length)
            {
                _SafeStr_690.push(_arg_2[_local_3]);
                _local_3++;
            };
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_690);
        }

        public function dispose():void
        {
            _SafeStr_690 = null;
        }


    }
}

