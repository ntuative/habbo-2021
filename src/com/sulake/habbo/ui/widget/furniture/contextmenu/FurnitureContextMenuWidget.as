package com.sulake.habbo.ui.widget.furniture.contextmenu
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.habbo.ui.widget.contextmenu.IContextMenuParentWidget;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.runtime.Component;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.ui.widget.furniture.guildfurnicontextmenu.GuildFurnitureContextMenuView;
    import com.sulake.habbo.ui.widget.furniture.effectbox.EffectBoxOpenDialogView;
    import com.sulake.habbo.ui.widget.furniture.mysterybox.MysteryBoxContextMenuView;
    import com.sulake.habbo.ui.widget.furniture.mysterytrophy.MysteryTrophyOpenDialogView;
    import com.sulake.habbo.ui.widget.furniture.mysterybox.MysteryBoxOpenDialogView;
    import com.sulake.habbo.ui.widget.furniture.friendfurni.FriendFurniContextMenuView;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.groups.IHabboGroupsManager;
    import com.sulake.habbo.ui.handler.FurnitureContextMenuWidgetHandler;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.ui.widget.contextmenu.ContextInfoView;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.habbo.friendlist.IHabboFriendList;

    public class FurnitureContextMenuWidget extends RoomWidgetBase implements IContextMenuParentWidget, IUpdateReceiver 
    {

        private var _SafeStr_659:Component;
        private var _SafeStr_570:FurnitureContextInfoView;
        private var _selectedObject:IRoomObject = null;
        private var _SafeStr_4066:GuildFurnitureContextMenuView;
        private var _SafeStr_4067:RandomTeleportContextMenuView;
        private var _SafeStr_4068:MonsterPlantSeedContextMenuView;
        private var _SafeStr_4069:MonsterPlantSeedConfirmationView;
        private var _SafeStr_4070:EffectBoxOpenDialogView;
        private var _SafeStr_4071:MysteryBoxContextMenuView;
        private var _SafeStr_4072:MysteryTrophyOpenDialogView;
        private var _SafeStr_4073:MysteryBoxOpenDialogView;
        private var _SafeStr_4074:FriendFurniContextMenuView;
        private var _SafeStr_4075:GenericUsableFurnitureContextMenuView;
        private var _catalog:IHabboCatalog;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _SafeStr_4076:PurchasableClothingConfirmationView;

        public function FurnitureContextMenuWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:ICoreConfiguration, _arg_5:IHabboLocalizationManager, _arg_6:Component, _arg_7:IHabboGroupsManager, _arg_8:IHabboCatalog)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_5);
            _SafeStr_659 = _arg_6;
            _SafeStr_4066 = new GuildFurnitureContextMenuView(this, _arg_7, _arg_2);
            _SafeStr_4067 = new RandomTeleportContextMenuView(this);
            _SafeStr_4068 = new MonsterPlantSeedContextMenuView(this);
            _SafeStr_4071 = new MysteryBoxContextMenuView(this);
            _SafeStr_4074 = new FriendFurniContextMenuView(this);
            _SafeStr_4075 = new GenericUsableFurnitureContextMenuView(this);
            _SafeStr_4069 = new MonsterPlantSeedConfirmationView(this);
            _SafeStr_4073 = new MysteryBoxOpenDialogView(this);
            _SafeStr_4070 = new EffectBoxOpenDialogView(this);
            _SafeStr_4072 = new MysteryTrophyOpenDialogView(this);
            _SafeStr_4076 = new PurchasableClothingConfirmationView(this);
            _catalog = _arg_8;
            this.handler.widget = this;
            this.handler.roomEngine.events.addEventListener("REOE_REMOVED", onRoomObjectRemoved);
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            _SafeStr_659.removeUpdateReceiver(this);
            removeView(_SafeStr_570, false);
            _SafeStr_4066.dispose();
            _SafeStr_4066 = null;
            _SafeStr_4067.dispose();
            _SafeStr_4067 = null;
            _SafeStr_4068.dispose();
            _SafeStr_4068 = null;
            _SafeStr_4069.dispose();
            _SafeStr_4069 = null;
            _SafeStr_4071.dispose();
            _SafeStr_4071 = null;
            _SafeStr_4073.dispose();
            _SafeStr_4073 = null;
            _SafeStr_4074.dispose();
            _SafeStr_4074 = null;
            _SafeStr_4075.dispose();
            _SafeStr_4075 = null;
            _SafeStr_4070.dispose();
            _SafeStr_4070 = null;
            _SafeStr_4072.dispose();
            _SafeStr_4072 = null;
            _SafeStr_4076.dispose();
            _SafeStr_4076 = null;
            _catalog = null;
            super.dispose();
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            _container = _arg_1;
        }

        public function get container():IRoomWidgetHandlerContainer
        {
            return (_container);
        }

        public function get handler():FurnitureContextMenuWidgetHandler
        {
            return (_SafeStr_3915 as FurnitureContextMenuWidgetHandler);
        }

        public function get roomEngine():IRoomEngine
        {
            return ((_container) ? _container.roomEngine : null);
        }

        public function hideContextMenu(_arg_1:IRoomObject):void
        {
            if (((!(_selectedObject == null)) && (_selectedObject.getId() == _arg_1.getId())))
            {
                removeView(_SafeStr_570, false);
                _SafeStr_659.removeUpdateReceiver(this);
                _selectedObject = null;
            };
        }

        public function showGuildFurnitureContextMenu(_arg_1:IRoomObject, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:Boolean, _arg_6:Boolean):void
        {
            _selectedObject = _arg_1;
            _SafeStr_4066._SafeStr_618 = _arg_2;
            _SafeStr_4066._SafeStr_619 = _arg_4;
            _SafeStr_4066._SafeStr_620 = _arg_5;
            _SafeStr_4066._SafeStr_621 = _arg_6;
            if (_SafeStr_570 != null)
            {
                removeView(_SafeStr_570, false);
            };
            _SafeStr_570 = _SafeStr_4066;
            FurnitureContextInfoView.setup(_SafeStr_570, _arg_1, _arg_3);
            _SafeStr_659.registerUpdateReceiver(this, 10);
        }

        public function showRandomTeleportContextMenu(_arg_1:IRoomObject, _arg_2:int):void
        {
            _selectedObject = _arg_1;
            if (_SafeStr_570 != null)
            {
                removeView(_SafeStr_570, false);
            };
            _SafeStr_4067.objectCategory = _arg_2;
            _SafeStr_570 = _SafeStr_4067;
            FurnitureContextInfoView.setup(_SafeStr_570, _arg_1);
            _SafeStr_659.registerUpdateReceiver(this, 10);
        }

        public function showMonsterPlantSeedContextMenu(_arg_1:IRoomObject, _arg_2:int):void
        {
            _selectedObject = _arg_1;
            if (_SafeStr_570 != null)
            {
                removeView(_SafeStr_570, false);
            };
            _SafeStr_4068.objectCategory = _arg_2;
            _SafeStr_570 = _SafeStr_4068;
            FurnitureContextInfoView.setup(_SafeStr_570, _arg_1);
            _SafeStr_659.registerUpdateReceiver(this, 10);
        }

        public function showPlantSeedConfirmationDialog(_arg_1:IRoomObject):void
        {
            _selectedObject = _arg_1;
            if (_SafeStr_570 != null)
            {
                removeView(_SafeStr_570, false);
            };
            if (!_SafeStr_4069)
            {
                _SafeStr_4069 = new MonsterPlantSeedConfirmationView(this);
            };
            _SafeStr_4069.open(_arg_1.getId());
        }

        public function showPurchasableClothingConfirmationDialog(_arg_1:IRoomObject):void
        {
            _selectedObject = _arg_1;
            if (_SafeStr_570 != null)
            {
                removeView(_SafeStr_570, false);
            };
            if (!_SafeStr_4076)
            {
                _SafeStr_4076 = new PurchasableClothingConfirmationView(this);
            };
            _SafeStr_4076.open(_arg_1.getId());
        }

        public function showEffectBoxOpenDialog(_arg_1:IRoomObject):void
        {
            _selectedObject = _arg_1;
            if (_SafeStr_570 != null)
            {
                removeView(_SafeStr_570, false);
            };
            if (!_SafeStr_4070)
            {
                _SafeStr_4070 = new EffectBoxOpenDialogView(this);
            };
            _SafeStr_4070.open(_arg_1.getId());
        }

        public function showMysteryTrophyOpenDialog(_arg_1:IRoomObject):void
        {
            _selectedObject = _arg_1;
            if (_SafeStr_570 != null)
            {
                removeView(_SafeStr_570, false);
            };
            if (!_SafeStr_4072)
            {
                _SafeStr_4072 = new MysteryTrophyOpenDialogView(this);
            };
            _SafeStr_4072.open(_arg_1.getId());
        }

        private function removePlantSeedConfirmationView():void
        {
            if (_SafeStr_4069 != null)
            {
                _SafeStr_4069.close();
            };
        }

        public function showMysteryBoxContextMenu(_arg_1:IRoomObject):void
        {
            _selectedObject = _arg_1;
            if (_SafeStr_570 != null)
            {
                removeView(_SafeStr_570, false);
            };
            if (_SafeStr_4071 == null)
            {
                _SafeStr_4071 = new MysteryBoxContextMenuView(this);
            };
            _SafeStr_4071.isOwnerMode = handler.container.isOwnerOfFurniture(_arg_1);
            _SafeStr_4071.show();
            _SafeStr_570 = _SafeStr_4071;
            FurnitureContextInfoView.setup(_SafeStr_570, _arg_1);
            _SafeStr_659.registerUpdateReceiver(this, 10);
        }

        public function showFriendFurnitureContextMenu(_arg_1:IRoomObject):void
        {
            _selectedObject = _arg_1;
            if (_SafeStr_570 != null)
            {
                removeView(_SafeStr_570, false);
            };
            if (_SafeStr_4074 == null)
            {
                _SafeStr_4074 = new FriendFurniContextMenuView(this);
            };
            _SafeStr_4074.show();
            _SafeStr_570 = _SafeStr_4074;
            FurnitureContextInfoView.setup(_SafeStr_570, _arg_1);
            _SafeStr_659.registerUpdateReceiver(this, 10);
        }

        public function showUsableFurnitureContextMenu(_arg_1:IRoomObject, _arg_2:int):void
        {
            _selectedObject = _arg_1;
            if (_SafeStr_570 != null)
            {
                removeView(_SafeStr_570, false);
            };
            if (_SafeStr_4075 == null)
            {
                _SafeStr_4075 = new GenericUsableFurnitureContextMenuView(this);
            };
            _SafeStr_4075.show();
            _SafeStr_4075.objectCategory = _arg_2;
            _SafeStr_570 = _SafeStr_4075;
            FurnitureContextInfoView.setup(_SafeStr_570, _arg_1);
            _SafeStr_659.registerUpdateReceiver(this, 10);
        }

        public function showMysteryBoxOpenDialog(_arg_1:IRoomObject):void
        {
            _selectedObject = _arg_1;
            if (_SafeStr_570 != null)
            {
                removeView(_SafeStr_570, false);
            };
            _SafeStr_4073.startOpenFlow(_arg_1);
        }

        public function removeView(_arg_1:ContextInfoView, _arg_2:Boolean):void
        {
            if (_arg_1)
            {
                _arg_1.hide(false);
                if (_arg_1 == _SafeStr_570)
                {
                    _SafeStr_570 = null;
                };
            };
        }

        public function update(_arg_1:uint):void
        {
            if (((_SafeStr_570) && (_selectedObject)))
            {
                _SafeStr_570.update(this.handler.getObjectRectangle(_selectedObject.getId()), this.handler.getObjectScreenLocation(_selectedObject.getId()), _arg_1);
            };
        }

        public function get catalog():IHabboCatalog
        {
            return (_catalog);
        }

        private function onRoomObjectRemoved(_arg_1:RoomEngineObjectEvent):void
        {
            var _local_2:int;
            if (_arg_1.category == 10)
            {
                _local_2 = _arg_1.objectId;
                if (((!(_selectedObject == null)) && (_selectedObject.getId() == _local_2)))
                {
                    removeView(_SafeStr_570, false);
                    removePlantSeedConfirmationView();
                    _SafeStr_659.removeUpdateReceiver(this);
                    _selectedObject = null;
                };
            };
        }

        public function get friendList():IHabboFriendList
        {
            return (null);
        }


    }
}

