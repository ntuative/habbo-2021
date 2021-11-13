package com.sulake.habbo.communication.messages.outgoing.inventory.badges
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class SetActivatedBadgesComposer implements IMessageComposer 
    {

        private const _SafeStr_1897:int = 5;

        private var _SafeStr_1896:Array;

        public function SetActivatedBadgesComposer()
        {
            _SafeStr_1896 = [];
        }

        public function addActivatedBadge(_arg_1:String):void
        {
            if (_SafeStr_1896.length >= 5)
            {
                return;
            };
            _SafeStr_1896.push(_arg_1);
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            var _local_2:int;
            var _local_1:Array = [];
            _local_2 = 1;
            while (_local_2 <= 5)
            {
                if (_local_2 <= _SafeStr_1896.length)
                {
                    _local_1.push(_local_2);
                    _local_1.push(_SafeStr_1896[(_local_2 - 1)]);
                }
                else
                {
                    _local_1.push(_local_2);
                    _local_1.push("");
                };
                _local_2++;
            };
            return (_local_1);
        }


    }
}

