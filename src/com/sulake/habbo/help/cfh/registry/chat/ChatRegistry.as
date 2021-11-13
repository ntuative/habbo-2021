package com.sulake.habbo.help.cfh.registry.chat
{
    import __AS3__.vec.Vector;

    public class ChatRegistry 
    {

        private static const MAX_ITEMS_TO_STORE:int = 120;
        private static const ITEMS_TO_PURGE:int = 20;

        private var _registry:Vector.<ChatRegistryItem> = new Vector.<ChatRegistryItem>(0);
        private var _SafeStr_2654:uint = 0;
        private var _SafeStr_2655:Boolean;


        public function hasContent():Boolean
        {
            return (_registry.length > 0);
        }

        public function hasContentWithoutChatFromUser(_arg_1:int):Boolean
        {
            return (getItemsNotByUser(_arg_1).length > 0);
        }

        public function getItems():Vector.<ChatRegistryItem>
        {
            return (_registry);
        }

        public function addItem(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:String, _arg_5:String):void
        {
            _registry.push(new ChatRegistryItem(_SafeStr_2654++, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5));
            purgeRegistry();
        }

        public function set holdPurges(_arg_1:Boolean):void
        {
            _SafeStr_2655 = _arg_1;
        }

        private function purgeRegistry():void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_2:int;
            if (_SafeStr_2655)
            {
                return;
            };
            var _local_1:Vector.<ChatRegistryItem> = new Vector.<ChatRegistryItem>(0);
            _local_3 = 0;
            while (_local_3 < _registry.length)
            {
                _local_4 = (new Date().time - _registry[_local_3].chatTime.time);
                _local_2 = int((_local_4 / 65500));
                if (_local_2 <= 15)
                {
                    _local_1.push(_registry[_local_3]);
                };
                _local_3++;
            };
            if (_local_1.length > 120)
            {
                _local_1.splice(0, (_local_1.length - (120 - 20)));
            };
            _registry.splice(0, _registry.length);
            _registry = _registry.concat(_local_1);
        }

        public function getItem(_arg_1:uint):ChatRegistryItem
        {
            var _local_2:int;
            _local_2 = 0;
            while (_local_2 < _registry.length)
            {
                if (_registry[_local_2].index == _arg_1)
                {
                    return (_registry[_local_2]);
                };
                _local_2++;
            };
            return (null);
        }

        public function getItemsByUser(_arg_1:int):Vector.<ChatRegistryItem>
        {
            var _local_3:int;
            var _local_2:Vector.<ChatRegistryItem> = new Vector.<ChatRegistryItem>(0);
            _local_3 = 0;
            while (_local_3 < _registry.length)
            {
                if (_registry[_local_3].userId == _arg_1)
                {
                    _local_2.push(_registry[_local_3]);
                };
                _local_3++;
            };
            return (_local_2);
        }

        private function getItemsNotByUser(_arg_1:int):Vector.<ChatRegistryItem>
        {
            var _local_3:int;
            var _local_2:Vector.<ChatRegistryItem> = new Vector.<ChatRegistryItem>(0);
            _local_3 = 0;
            while (_local_3 < _registry.length)
            {
                if (_registry[_local_3].userId != _arg_1)
                {
                    _local_2.push(_registry[_local_3]);
                };
                _local_3++;
            };
            return (_local_2);
        }


    }
}

