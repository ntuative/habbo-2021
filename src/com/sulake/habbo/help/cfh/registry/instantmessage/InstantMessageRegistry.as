package com.sulake.habbo.help.cfh.registry.instantmessage
{
    import com.sulake.core.utils.Map;
    import __AS3__.vec.Vector;

    public class InstantMessageRegistry 
    {

        private static const ITEMS_TO_PURGE:int = 5;
        private static const MAX_MESSAGES_TO_STORE:int = 20;

        private var _registry:Map;
        private var _SafeStr_2654:int = 0;
        private var _SafeStr_2656:int = 0;
        private var _SafeStr_2655:Boolean;

        public function InstantMessageRegistry()
        {
            _registry = new Map();
        }

        public function addItem(_arg_1:int, _arg_2:String, _arg_3:String):void
        {
            var _local_5:Vector.<InstantMessageRegistryItem> = undefined;
            var _local_4:Vector.<InstantMessageRegistryItem> = undefined;
            if (_registry.hasKey(_arg_1))
            {
                _local_5 = _registry.getValue(_arg_1);
                _local_5.push(new InstantMessageRegistryItem(_SafeStr_2654++, _arg_1, _arg_2, _arg_3));
                _registry.remove(_arg_1);
                _registry.add(_arg_1, _local_5);
            }
            else
            {
                _local_4 = new Vector.<InstantMessageRegistryItem>();
                _local_4.push(new InstantMessageRegistryItem(_SafeStr_2654++, _arg_1, _arg_2, _arg_3));
                _registry.add(_arg_1, _local_4);
            };
            _SafeStr_2656++;
            if ((_SafeStr_2656 % 3) == 0)
            {
                purgeRegistry();
            };
        }

        private function purgeRegistry():void
        {
            var _local_4:int;
            var _local_1:Vector.<InstantMessageRegistryItem> = undefined;
            var _local_3:Vector.<InstantMessageRegistryItem> = undefined;
            var _local_7:int;
            var _local_6:int;
            var _local_5:int;
            var _local_2:int;
            if (_SafeStr_2655)
            {
                return;
            };
            _local_4 = 0;
            while (_local_4 < _registry.length)
            {
                _local_1 = _registry.getWithIndex(_local_4);
                _local_3 = new Vector.<InstantMessageRegistryItem>(0);
                if (((_local_1) && (_local_1.length > 0)))
                {
                    _local_7 = _local_1[0].userId;
                    _local_6 = 0;
                    while (_local_6 < _local_1.length)
                    {
                        _local_5 = (new Date().time - _local_1[_local_6].chatTime.time);
                        _local_2 = int((_local_5 / 65500));
                        if (_local_2 <= 15)
                        {
                            _local_3.push(_local_1[_local_6]);
                        };
                        _local_6++;
                    };
                    if (_local_3.length > 20)
                    {
                        _local_3.splice(0, (_local_3.length - (20 - 5)));
                    };
                    _local_1.splice(0, _local_1.length);
                    _local_1 = _local_1.concat(_local_3);
                    _registry.remove(_local_7);
                    _registry.add(_local_7, _local_1);
                };
                _local_4++;
            };
        }

        public function set holdPurges(_arg_1:Boolean):void
        {
            _SafeStr_2655 = _arg_1;
        }

        public function getItemsByUser(_arg_1:int):Vector.<InstantMessageRegistryItem>
        {
            return (_registry.getValue(_arg_1));
        }

        public function hasUserChatted(_arg_1:int):Boolean
        {
            var _local_2:Vector.<InstantMessageRegistryItem> = getItemsByUser(_arg_1);
            if (_local_2)
            {
                return (getItemsByUser(_arg_1).length > 0);
            };
            return (false);
        }

        public function hasContent():Boolean
        {
            return (_registry.length > 0);
        }

        public function getItems():Map
        {
            return (_registry);
        }

        public function getItem(_arg_1:int, _arg_2:uint):InstantMessageRegistryItem
        {
            var _local_4:int;
            var _local_3:Vector.<InstantMessageRegistryItem> = getItemsByUser(_arg_1);
            _local_4 = 0;
            while (_local_4 < _local_3.length)
            {
                if (_local_3[_local_4].index == _arg_2)
                {
                    return (_local_3[_local_4]);
                };
                _local_4++;
            };
            return (null);
        }


    }
}

