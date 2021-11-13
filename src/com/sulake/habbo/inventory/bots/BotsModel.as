package com.sulake.habbo.inventory.bots
{
    import com.sulake.habbo.inventory.IInventoryModel;
    import com.sulake.habbo.inventory.HabboInventory;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.outgoing.inventory.bots.GetBotInventoryComposer;
    import com.sulake.habbo.communication.messages.parser.inventory.bots.BotData;
    import flash.events.Event;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.PlaceBotMessageComposer;
    import com.sulake.habbo.session.IRoomSession;

    public class BotsModel implements IInventoryModel 
    {

        private var _controller:HabboInventory;
        private var _SafeStr_570:BotsView;
        private var _assets:IAssetLibrary;
        private var _communication:IHabboCommunicationManager;
        private var _roomEngine:IRoomEngine;
        private var _catalog:IHabboCatalog;
        private var _items:Map;
        private var _SafeStr_2725:Boolean = false;
        private var _disposed:Boolean = false;
        private var _SafeStr_2726:Boolean;

        public function BotsModel(_arg_1:HabboInventory, _arg_2:IHabboWindowManager, _arg_3:IHabboCommunicationManager, _arg_4:IAssetLibrary, _arg_5:IRoomEngine, _arg_6:IHabboCatalog, _arg_7:IAvatarRenderManager)
        {
            _controller = _arg_1;
            _assets = _arg_4;
            _communication = _arg_3;
            _roomEngine = _arg_5;
            _roomEngine.events.addEventListener("REOE_PLACED", onObjectPlaced);
            _catalog = _arg_6;
            _items = new Map();
            _SafeStr_570 = new BotsView(this, _arg_2, _arg_4, _arg_5, _arg_7);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_SafeStr_570)
                {
                    _SafeStr_570.dispose();
                    _SafeStr_570 = null;
                };
                if (_roomEngine)
                {
                    if (_roomEngine.events)
                    {
                        _roomEngine.events.removeEventListener("REOE_PLACED", onObjectPlaced);
                    };
                    _roomEngine = null;
                };
                if (_items)
                {
                    _items.dispose();
                    _items = null;
                };
                _controller = null;
                _catalog = null;
                _assets = null;
                _communication = null;
                _disposed = true;
            };
        }

        public function get controller():HabboInventory
        {
            return (_controller);
        }

        public function isListInitialized():Boolean
        {
            return (_SafeStr_2726);
        }

        public function setListInitialized():void
        {
            _SafeStr_2726 = true;
            _SafeStr_570.updateState();
        }

        public function requestInventory():void
        {
            if (_communication == null)
            {
                return;
            };
            var _local_1:IConnection = _communication.connection;
            if (_local_1 == null)
            {
                return;
            };
            _local_1.send(new GetBotInventoryComposer());
        }

        public function get items():Map
        {
            return (_items);
        }

        public function addItem(_arg_1:BotData):void
        {
            if (_items.add(_arg_1.id, _arg_1))
            {
                _SafeStr_570.addItem(_arg_1);
            };
            _SafeStr_570.updateState();
        }

        public function updateItems(_arg_1:Map):void
        {
            var _local_3:int;
            var _local_2:Array = _arg_1.getKeys();
            var _local_4:Array = _items.getKeys();
            for each (_local_3 in _local_4)
            {
                if (_local_2.indexOf(_local_3) == -1)
                {
                    _items.remove(_local_3);
                    _SafeStr_570.removeItem(_local_3);
                };
            };
            for each (_local_3 in _local_2)
            {
                if (_local_4.indexOf(_local_3) == -1)
                {
                    _items.add(_local_3, _arg_1.getValue(_local_3));
                    _SafeStr_570.addItem(_arg_1.getValue(_local_3));
                };
            };
        }

        public function removeItem(_arg_1:int):void
        {
            _items.remove(_arg_1);
            _SafeStr_570.removeItem(_arg_1);
            _SafeStr_570.updateState();
        }

        public function requestInitialization():void
        {
            requestInventory();
        }

        public function categorySwitch(_arg_1:String):void
        {
            if (((_arg_1 == "bots") && (_controller.isVisible)))
            {
                _controller.events.dispatchEvent(new Event("HABBO_INVENTORY_TRACKING_EVENT_BOTS"));
            };
        }

        public function getWindowContainer():IWindowContainer
        {
            return (_SafeStr_570.getWindowContainer());
        }

        public function closingInventoryView():void
        {
            if (_SafeStr_570.isVisible)
            {
                resetUnseenItems();
            };
        }

        public function subCategorySwitch(_arg_1:String):void
        {
        }

        public function placeItemToRoom(_arg_1:int, _arg_2:Boolean=false):Boolean
        {
            var _local_4:int;
            var _local_3:BotData = getItemById(_arg_1);
            if (_local_3 == null)
            {
                return (false);
            };
            if (!_controller.roomSession.areBotsAllowed)
            {
                return (false);
            };
            if (_controller.roomSession.isRoomOwner)
            {
                _local_4 = (_local_3.id * -1);
                _SafeStr_2725 = _roomEngine.initializeRoomObjectInsert("inventory", _local_4, 100, 4, _local_3.figure);
                _controller.closeView();
                return (_SafeStr_2725);
            };
            if (!_arg_2)
            {
                _communication.connection.send(new PlaceBotMessageComposer(_local_3.id, 0, 0));
            };
            return (true);
        }

        public function updateView():void
        {
            if (_SafeStr_570 == null)
            {
                return;
            };
            _SafeStr_570.update();
        }

        private function getItemById(_arg_1:int):BotData
        {
            for each (var _local_2:BotData in _items)
            {
                if (_local_2.id == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function onObjectPlaced(_arg_1:Event):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            if (((_SafeStr_2725) && (_arg_1.type == "REOE_PLACED")))
            {
                _controller.showView();
                _SafeStr_2725 = false;
            };
        }

        public function get roomSession():IRoomSession
        {
            return (_controller.roomSession);
        }

        public function resetUnseenItems():void
        {
            _controller.unseenItemTracker.resetCategory(5);
            _controller.updateUnseenItemCounts();
            _SafeStr_570.update();
        }

        public function isUnseen(_arg_1:int):Boolean
        {
            return (_controller.unseenItemTracker.isUnseen(5, _arg_1));
        }

        public function selectItemById(_arg_1:String):void
        {
            _SafeStr_570.selectById(int(_arg_1));
        }


    }
}

