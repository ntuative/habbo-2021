package com.sulake.habbo.inventory
{
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import flash.utils.Dictionary;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.communication.messages.incoming.notifications.UnseenItemsEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.UnseenItemsParser;
    import com.sulake.habbo.inventory.enum._SafeStr_102;
    import com.sulake.habbo.inventory.events.HabboUnseenItemsUpdatedEvent;
    import com.sulake.habbo.communication.messages.outgoing.notifications.ResetUnseenItemsComposer;
    import com.sulake.habbo.communication.messages.outgoing.notifications.ResetUnseenItemIdsComposer;

    public class UnseenItemTracker implements IUnseenItemTracker 
    {

        private var _communication:IHabboCommunicationManager;
        private var _inventory:HabboInventory;
        private var _unseenItems:Dictionary;
        private var _SafeStr_913:IEventDispatcher;

        public function UnseenItemTracker(_arg_1:IHabboCommunicationManager, _arg_2:IEventDispatcher, _arg_3:HabboInventory)
        {
            _communication = _arg_1;
            _inventory = _arg_3;
            _SafeStr_913 = _arg_2;
            _unseenItems = new Dictionary();
            _communication.addHabboConnectionMessageEvent(new UnseenItemsEvent(onUnseenItems));
        }

        public function dispose():void
        {
            _communication = null;
            _unseenItems = null;
        }

        public function resetCategory(_arg_1:int):Boolean
        {
            if (getCount(_arg_1) == 0)
            {
                return (false);
            };
            delete _unseenItems[_arg_1];
            sendResetCategoryMessage(_arg_1);
            sendUpdateEvent();
            return (true);
        }

        public function resetItems(_arg_1:int, _arg_2:Array):Boolean
        {
            if (getCount(_arg_1) == 0)
            {
                return (false);
            };
            var _local_4:Array = _unseenItems[_arg_1];
            for each (var _local_3:int in _arg_2)
            {
                _local_4.splice(_local_4.indexOf(_local_3), 1);
            };
            sendResetItemsMessage(_arg_1, _arg_2);
            sendUpdateEvent();
            return (true);
        }

        public function resetCategoryIfEmpty(_arg_1:int):Boolean
        {
            if (getCount(_arg_1) == 0)
            {
                delete _unseenItems[_arg_1];
                sendResetCategoryMessage(_arg_1);
                sendUpdateEvent();
                return (true);
            };
            return (false);
        }

        public function isUnseen(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_3:Array;
            if (_unseenItems[_arg_1] != null)
            {
                _local_3 = _unseenItems[_arg_1];
                return (_local_3.indexOf(_arg_2) >= 0);
            };
            return (false);
        }

        public function removeUnseen(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_3:Array;
            var _local_4:int;
            if (_unseenItems[_arg_1] != null)
            {
                _local_3 = _unseenItems[_arg_1];
                _local_4 = _local_3.indexOf(_arg_2);
                if (_local_4 >= 0)
                {
                    _local_3.splice(_local_4, 1);
                    sendUpdateEvent();
                    return (true);
                };
            };
            return (false);
        }

        public function getIds(_arg_1:int):Array
        {
            if (_unseenItems[_arg_1] != null)
            {
                return (_unseenItems[_arg_1]);
            };
            return ([]);
        }

        public function getCount(_arg_1:int):int
        {
            if (_unseenItems[_arg_1] != null)
            {
                return ((_unseenItems[_arg_1] as Array).length);
            };
            return (0);
        }

        private function onUnseenItems(_arg_1:UnseenItemsEvent):void
        {
            var _local_2:Boolean;
            var _local_5:Array;
            var _local_3:UnseenItemsParser = _arg_1.getParser();
            for each (var _local_4:int in _local_3.getCategories())
            {
                _local_5 = _local_3.getItemsByCategory(_local_4);
                addItems(_local_4, _local_5);
                if (_SafeStr_102.INVENTORY_CATEGORIES.indexOf(_local_4) >= 0)
                {
                    _local_2 = true;
                };
            };
            if (_inventory.isInitialized)
            {
                _inventory.updateUnseenItemCounts();
                _inventory.furniModel.updateUnseenItemsThumbs();
                _inventory.petsModel.updateView();
                _inventory.botsModel.updateView();
            };
            sendUpdateEvent();
        }

        private function sendUpdateEvent():void
        {
            var _local_2:int;
            var _local_1:HabboUnseenItemsUpdatedEvent = new HabboUnseenItemsUpdatedEvent();
            var _local_3:Array = _SafeStr_102.INVENTORY_CATEGORIES;
            for each (var _local_4:int in _local_3)
            {
                _local_2 = getCount(_local_4);
                _local_1.setCategoryCount(_local_4, _local_2);
                if (_SafeStr_102.INVENTORY_CATEGORIES.indexOf(_local_4) >= 0)
                {
                    _local_1.inventoryCount = (_local_1.inventoryCount + _local_2);
                };
            };
            _SafeStr_913.dispatchEvent(_local_1);
        }

        private function addItems(_arg_1:int, _arg_2:Array):void
        {
            var _local_3:Array;
            var _local_4:int;
            if (_arg_2 == null)
            {
                return;
            };
            if (_unseenItems[_arg_1] == null)
            {
                _local_3 = [];
                _unseenItems[_arg_1] = _local_3;
            };
            _local_3 = _unseenItems[_arg_1];
            for each (var _local_5:int in _arg_2)
            {
                _local_4 = _local_3.indexOf(_local_5);
                if (_local_4 == -1)
                {
                    _local_3.push(_local_5);
                };
            };
        }

        private function sendResetCategoryMessage(_arg_1:int):void
        {
            _communication.connection.send(new ResetUnseenItemsComposer(_arg_1));
        }

        private function sendResetItemsMessage(_arg_1:int, _arg_2:Array):void
        {
            _communication.connection.send(new ResetUnseenItemIdsComposer(_arg_1, _arg_2));
        }


    }
}

