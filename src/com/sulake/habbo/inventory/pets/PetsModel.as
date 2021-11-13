package com.sulake.habbo.inventory.pets
{
    import com.sulake.habbo.inventory.IInventoryModel;
    import com.sulake.habbo.inventory.HabboInventory;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.outgoing.inventory.pets.GetPetInventoryComposer;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetData;
    import flash.events.Event;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.PlacePetMessageComposer;
    import com.sulake.habbo.session.IRoomSession;

    public class PetsModel implements IInventoryModel 
    {

        private var _controller:HabboInventory;
        private var _SafeStr_570:PetsView;
        private var _assets:IAssetLibrary;
        private var _communication:IHabboCommunicationManager;
        private var _roomEngine:IRoomEngine;
        private var _catalog:IHabboCatalog;
        private var _pets:Map;
        private var _SafeStr_2725:Boolean = false;
        private var _disposed:Boolean = false;
        private var _SafeStr_2726:Boolean;

        public function PetsModel(_arg_1:HabboInventory, _arg_2:IHabboWindowManager, _arg_3:IHabboCommunicationManager, _arg_4:IAssetLibrary, _arg_5:IRoomEngine, _arg_6:IHabboCatalog)
        {
            _controller = _arg_1;
            _assets = _arg_4;
            _communication = _arg_3;
            _roomEngine = _arg_5;
            _roomEngine.events.addEventListener("REOE_PLACED", onObjectPlaced);
            _catalog = _arg_6;
            _pets = new Map();
            _SafeStr_570 = new PetsView(this, _arg_2, _arg_4, _arg_5);
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
                if (_pets)
                {
                    _pets.dispose();
                    _pets = null;
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

        public function requestPetInventory():void
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
            _local_1.send(new GetPetInventoryComposer());
        }

        public function get pets():Map
        {
            return (_pets);
        }

        public function addPet(_arg_1:PetData):void
        {
            if (_pets.add(_arg_1.id, _arg_1))
            {
                _SafeStr_570.addPet(_arg_1);
            };
            _SafeStr_570.updateState();
        }

        public function updatePets(_arg_1:Map):void
        {
            var _local_3:int;
            var _local_2:Array = _arg_1.getKeys();
            var _local_4:Array = _pets.getKeys();
            _controller.setInventoryCategoryInit("pets");
            for each (_local_3 in _local_4)
            {
                if (_local_2.indexOf(_local_3) == -1)
                {
                    _pets.remove(_local_3);
                    _SafeStr_570.removePet(_local_3);
                };
            };
            for each (_local_3 in _local_2)
            {
                if (_local_4.indexOf(_local_3) == -1)
                {
                    _pets.add(_local_3, _arg_1.getValue(_local_3));
                    _SafeStr_570.addPet(_arg_1.getValue(_local_3));
                };
            };
            setListInitialized();
        }

        public function removePet(_arg_1:int):void
        {
            _pets.remove(_arg_1);
            _SafeStr_570.removePet(_arg_1);
            _SafeStr_570.updateState();
        }

        public function requestInitialization():void
        {
            requestPetInventory();
        }

        public function categorySwitch(_arg_1:String):void
        {
            if (((_arg_1 == "pets") && (_controller.isVisible)))
            {
                _controller.events.dispatchEvent(new Event("HABBO_INVENTORY_TRACKING_EVENT_PETS"));
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

        public function placePetToRoom(_arg_1:int, _arg_2:Boolean=false):Boolean
        {
            var _local_4:int;
            var _local_5:PetData = getPetById(_arg_1);
            if (_local_5 == null)
            {
                return (false);
            };
            var _local_3:String;
            if (_local_5.typeId == 16)
            {
                if (_local_5.level >= 7)
                {
                    _local_3 = "std";
                }
                else
                {
                    _local_3 = ("grw" + _local_5.level);
                };
            };
            if (_controller.roomSession.isRoomOwner)
            {
                _local_4 = (_local_5.id * -1);
                _SafeStr_2725 = _roomEngine.initializeRoomObjectInsert("inventory", _local_4, 100, 2, _local_5.figureString, null, -1, -1, _local_3);
                _controller.closeView();
                return (_SafeStr_2725);
            };
            if (!_controller.roomSession.arePetsAllowed)
            {
                return (false);
            };
            if (!_arg_2)
            {
                _communication.connection.send(new PlacePetMessageComposer(_local_5.id, 0, 0));
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

        private function getPetById(_arg_1:int):PetData
        {
            for each (var _local_2:PetData in _pets)
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

        public function updatePetsAllowed():void
        {
            _SafeStr_570.update();
        }

        public function resetUnseenItems():void
        {
            _controller.unseenItemTracker.resetCategory(3);
            _controller.updateUnseenItemCounts();
            _SafeStr_570.update();
        }

        public function isUnseen(_arg_1:int):Boolean
        {
            return (_controller.unseenItemTracker.isUnseen(3, _arg_1));
        }

        public function removeUnseenFurniCounter(_arg_1:int):Boolean
        {
            var _local_2:Boolean;
            if (isUnseen(_arg_1))
            {
                _local_2 = _controller.unseenItemTracker.removeUnseen(3, _arg_1);
                if (_local_2)
                {
                    _controller.unseenItemTracker.resetCategoryIfEmpty(3);
                };
            };
            return (_local_2);
        }

        public function selectItemById(_arg_1:String):void
        {
            _SafeStr_570.selectById(int(_arg_1));
        }


    }
}

