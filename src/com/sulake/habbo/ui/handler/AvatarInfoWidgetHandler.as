package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.avatarinfo.AvatarInfoWidget;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListAddOrUpdateEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.CustomUserNotificationMessageEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetInventoryUpdatedMessage;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.session.events.UserNameUpdateEvent;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetStatusUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionPetStatusUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetLevelUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionPetLevelUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetAvatarInfoEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUseProductMessage;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.window.utils._SafeStr_126;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionDanceEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserDataUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionUserDataUpdateEvent;
    import com.sulake.habbo.room.events.RoomEngineUseProductEvent;
    import flash.events.Event;
    import com.sulake.habbo.session.events.RoomSessionNestBreedingSuccessEvent;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.ui.widget.events.UseProductItem;

    public class AvatarInfoWidgetHandler implements IRoomWidgetHandler
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _SafeStr_1324:AvatarInfoWidget;
        private var _SafeStr_3844:IMessageEvent;
        private var _SafeStr_3845:IMessageEvent;


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function set widget(_arg_1:AvatarInfoWidget):void
        {
            _SafeStr_1324 = _arg_1;
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (((_SafeStr_3845) && (_container.connection)))
                {
                    _container.connection.removeMessageEvent(_SafeStr_3845);
                };
                container = null;
                _SafeStr_1324 = null;
                if (_SafeStr_3844 != null)
                {
                    _SafeStr_3844.dispose();
                    _SafeStr_3844 = null;
                };
                _SafeStr_3845 = null;
                _disposed = true;
            };
        }

        public function get type():String
        {
            return ("RWE_AVATAR_INFO");
        }

        public function get container():IRoomWidgetHandlerContainer
        {
            return (_container);
        }

        public function get roomEngine():IRoomEngine
        {
            return ((_container) ? _container.roomEngine : null);
        }

        public function get roomSession():IRoomSession
        {
            return ((_container) ? _container.roomSession : null);
        }

        public function get friendList():IHabboFriendList
        {
            return ((_container) ? _container.friendList : null);
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            if ((((_container) && (_container.toolbar)) && (_container.toolbar.events)))
            {
                _container.toolbar.events.removeEventListener("HTE_TOOLBAR_CLICK", onToolbarClicked);
            };
            if ((((_container) && (_container.sessionDataManager)) && (_container.sessionDataManager.events)))
            {
                _container.sessionDataManager.events.removeEventListener("unue_name_updated", onUserNameUpdate);
            };
            if ((((_container) && (_container.roomSessionManager)) && (_container.roomSessionManager.events)))
            {
                _container.roomSessionManager.events.removeEventListener("RSPFUE_PET_STATUS_UPDATE", onPetStatusUpdate);
                _container.roomSessionManager.events.removeEventListener("RSPLUE_PET_LEVEL_UPDATE", onPetLevelUpdate);
                _container.roomSessionManager.events.removeEventListener("RSPFUE_NEST_BREEDING_SUCCESS", onNestBreedingSuccessEvent);
            };
            if (((_container) && (_container.connection)))
            {
                _container.connection.removeMessageEvent(_SafeStr_3844);
            };
            if ((((_container) && (_container.connection)) && (_SafeStr_3845)))
            {
                _container.connection.removeMessageEvent(_SafeStr_3845);
            };
            _container = _arg_1;
            if (_arg_1 == null)
            {
                return;
            };
            if (_SafeStr_3844 == null)
            {
                _SafeStr_3844 = new FurniListAddOrUpdateEvent(onFurniListUpdated);
            };
            if (((!(_SafeStr_3845)) && (_container.connection)))
            {
                _SafeStr_3845 = new CustomUserNotificationMessageEvent(onCustomUserNotificationMessage);
                _container.connection.addMessageEvent(_SafeStr_3845);
            };
            if ((((_container) && (_container.toolbar)) && (_container.toolbar.events)))
            {
                _container.toolbar.events.addEventListener("HTE_TOOLBAR_CLICK", onToolbarClicked);
            };
            if ((((_container) && (_container.sessionDataManager)) && (_container.sessionDataManager.events)))
            {
                _container.sessionDataManager.events.addEventListener("unue_name_updated", onUserNameUpdate);
            };
            if ((((_container) && (_container.roomSessionManager)) && (_container.roomSessionManager.events)))
            {
                _container.roomSessionManager.events.addEventListener("RSPFUE_PET_STATUS_UPDATE", onPetStatusUpdate);
                _container.roomSessionManager.events.addEventListener("RSPFUE_NEST_BREEDING_SUCCESS", onNestBreedingSuccessEvent);
                _container.roomSessionManager.events.addEventListener("RSPLUE_PET_LEVEL_UPDATE", onPetLevelUpdate);
            };
            if (((_container) && (_container.connection)))
            {
                _container.connection.addMessageEvent(_SafeStr_3844);
            };
        }

        private function onFurniListUpdated(_arg_1:IMessageEvent):void
        {
            if (_container != null)
            {
                if (_container.events != null)
                {
                    _container.events.dispatchEvent(new RoomWidgetInventoryUpdatedMessage("RWIUM_INVENTORY_UPDATED"));
                };
            };
        }

        private function onToolbarClicked(_arg_1:HabboToolbarEvent):void
        {
            if (_arg_1.iconId == "HTIE_ICON_MEMENU")
            {
                if (container.config.getBoolean("simple.memenu.enabled"))
                {
                    _SafeStr_1324.selectOwnAvatar();
                }
                else
                {
                    dispatchOwnAvatarInfo();
                };
            };
        }

        private function onUserNameUpdate(_arg_1:UserNameUpdateEvent):void
        {
            _SafeStr_1324.close();
        }

        private function onPetStatusUpdate(_arg_1:RoomSessionPetStatusUpdateEvent):void
        {
            var _local_4:Boolean;
            var _local_2:Boolean;
            var _local_6:Boolean;
            var _local_3:Boolean;
            var _local_7:IUserData;
            var _local_5:RoomWidgetPetStatusUpdateEvent;
            if (((!(_container == null)) && (!(_container.events == null))))
            {
                _local_4 = _arg_1.canBreed;
                _local_2 = _arg_1.canHarvest;
                _local_6 = _arg_1.canRevive;
                _local_3 = _arg_1.hasBreedingPermission;
                _local_7 = findPetWithWebId(_arg_1.petId);
                if (_local_7 == null)
                {
                    Logger.log((("Could not find pet with the id: " + _arg_1.petId) + " given by petStatusUpdate"));
                    return;
                };
                _local_5 = new RoomWidgetPetStatusUpdateEvent(_local_7.roomObjectId, _local_4, _local_2, _local_6, _local_3);
                _container.events.dispatchEvent(_local_5);
            };
        }

        private function onPetLevelUpdate(_arg_1:RoomSessionPetLevelUpdateEvent):void
        {
            var _local_3:int;
            var _local_4:IUserData;
            var _local_2:RoomWidgetPetLevelUpdateEvent;
            if (((!(_container == null)) && (!(_container.events == null))))
            {
                _local_3 = _arg_1.level;
                _local_4 = findPetWithWebId(_arg_1.petId);
                _local_2 = new RoomWidgetPetLevelUpdateEvent(_local_4.roomObjectId, _local_3);
                _container.events.dispatchEvent(_local_2);
            };
        }

        private function dispatchOwnAvatarInfo():void
        {
            var _local_4:int = _container.sessionDataManager.userId;
            var _local_3:String = _container.sessionDataManager.userName;
            var _local_2:Boolean = _container.sessionDataManager.nameChangeAllowed;
            var _local_1:IUserData = _container.roomSession.userDataManager.getUserData(_local_4);
            if (_local_1)
            {
                _container.events.dispatchEvent(new RoomWidgetAvatarInfoEvent(_local_4, _local_3, _local_1.type, _local_1.roomObjectId, _local_2));
            };
        }

        public function getWidgetMessages():Array
        {
            var _local_1:Array = [];
            _local_1.push("RWROM_GET_OWN_CHARACTER_INFO");
            _local_1.push("RWUAM_START_NAME_CHANGE");
            _local_1.push("RWUAM_REQUEST_PET_UPDATE");
            _local_1.push("RWUPM_PET_PRODUCT");
            _local_1.push("RWUAM_REQUEST_BREED_PET");
            _local_1.push("RWUAM_HARVEST_PET");
            _local_1.push("RWUAM_REVIVE_PET");
            _local_1.push("RWUAM_COMPOST_PLANT");
            return (_local_1);
        }

        public function getProcessedEvents():Array
        {
            var _local_1:Array = [];
            _local_1.push("rsudue_user_data_updated");
            _local_1.push("RSDE_DANCE");
            _local_1.push("ROSM_USE_PRODUCT_FROM_INVENTORY");
            _local_1.push("ROSM_USE_PRODUCT_FROM_ROOM");
            return (_local_1);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var userData:IUserData;
            var message:RoomWidgetMessage = _arg_1;
            if (!message)
            {
                return (null);
            };
            var userId:int;
            var userAction:RoomWidgetUserActionMessage = (message as RoomWidgetUserActionMessage);
            if (userAction != null)
            {
                userId = userAction.userId;
            };
            switch (message.type)
            {
                case "RWROM_GET_OWN_CHARACTER_INFO":
                    dispatchOwnAvatarInfo();
                    break;
                case "RWUAM_START_NAME_CHANGE":
                    _container.habboHelp.startNameChange();
                    break;
                case "RWUAM_REQUEST_PET_UPDATE":
                    _SafeStr_1324.handlePetInfo = false;
                    break;
                case "RWUPM_PET_PRODUCT":
                    var useProductMessage:RoomWidgetUseProductMessage = (message as RoomWidgetUseProductMessage);
                    if (useProductMessage)
                    {
                        _container.roomSession.useProductForPet(useProductMessage.roomObjectId, useProductMessage.petId);
                    };
                    break;
                case "RWUAM_HARVEST_PET":
                    _container.roomSession.harvestPet(userId);
                    break;
                case "RWUAM_REVIVE_PET":
                    break;
                case "RWUAM_COMPOST_PLANT":
                    var localization:IHabboLocalizationManager = _SafeStr_1324.catalog.localization;
                    _SafeStr_1324.windowManager.confirm(localization.getLocalization("monsterplant.confirm.title.compost"), localization.getLocalization("monsterplant.confirm.desc.compost"), 0, (function ():Function
                    {
                        var onCompostConfirmed:Function = function (_arg_1:_SafeStr_126, _arg_2:WindowEvent):void
                        {
                            _arg_1.dispose();
                            if (_arg_2.type == "WE_OK")
                            {
                                _container.roomSession.compostPlant(userId);
                            };
                        };
                        return (onCompostConfirmed);
                    })());
                    break;
                case "RWUAM_REQUEST_BREED_PET":
                    requestBreedMenu(userId);
                    break;
                case "RWIUM_INVENTORY_UPDATED":
            };
            return (null);
        }

        public function processEvent(_arg_1:Event):void
        {
            var _local_2:RoomSessionDanceEvent;
            var _local_4:IUserData;
            switch (_arg_1.type)
            {
                case "rsudue_user_data_updated":
                    _container.events.dispatchEvent(new RoomWidgetUserDataUpdateEvent());
                    for each (var _local_3:IUserData in RoomSessionUserDataUpdateEvent(_arg_1).addedUsers)
                    {
                        if (friendList.getFriendNames().indexOf(_local_3.name) > -1)
                        {
                            _SafeStr_1324.showUserName(_local_3, _local_3.roomObjectId);
                        };
                    };
                    return;
                case "RSDE_DANCE":
                    _local_2 = (_arg_1 as RoomSessionDanceEvent);
                    if ((((((_local_2) && (_SafeStr_1324)) && (container)) && (container.roomSession)) && (container.roomSession.userDataManager)))
                    {
                        _local_4 = container.roomSession.userDataManager.getUserData(container.sessionDataManager.userId);
                        if (((_local_4) && (_local_2.userId == _local_4.roomObjectId)))
                        {
                            _SafeStr_1324.isDancing = (!(_local_2.danceStyle == 0));
                        };
                    };
                    return;
                case "ROSM_USE_PRODUCT_FROM_INVENTORY":
                    handleUseProductMenuRequestInventoryItem((_arg_1 as RoomEngineUseProductEvent).inventoryStripId, (_arg_1 as RoomEngineUseProductEvent).furnitureTypeId);
                    return;
                case "ROSM_USE_PRODUCT_FROM_ROOM":
                    handleUseProductMenuRequestRoomObject((_arg_1 as RoomEngineUseProductEvent).objectId);
                    return;
            };
        }

        private function requestBreedMenu(_arg_1:int):void
        {
            Logger.log(("Show breed menu. finally: " + _arg_1));
            if ((((_container == null) || (_container.roomSession == null)) || (_container.roomEngine == null)))
            {
                return;
            };
            if (_container.roomSession.userDataManager == null)
            {
                return;
            };
            var _local_5:int = _container.roomSession.roomId;
            var _local_3:int = _container.sessionDataManager.userId;
            var _local_6:IUserData = _container.roomSession.userDataManager.getUserDataByType(_arg_1, 2);
            if (_local_6 == null)
            {
                return;
            };
            var _local_2:Array = _local_6.figure.split(" ");
            var _local_4:int = ((_local_2.length > 0) ? _local_2[0] : -1);
            activateBreedMenuForPets(_local_5, _arg_1, _local_4, _local_6.roomObjectId, _local_3);
        }

        public function update():void
        {
        }

        private function onNestBreedingSuccessEvent(_arg_1:RoomSessionNestBreedingSuccessEvent):void
        {
            if (((!(_container == null)) && (!(_container.events == null))))
            {
                _SafeStr_1324.showNestBreedingSuccess(_arg_1.petId, _arg_1.rarityCategory);
            };
        }

        public function getFurniData(_arg_1:IRoomObject):IFurnitureData
        {
            var _local_2:IFurnitureData;
            var _local_3:int;
            if (_arg_1)
            {
                _local_3 = _arg_1.getModel().getNumber("furniture_type_id");
                _local_2 = _container.sessionDataManager.getFloorItemData(_local_3);
            };
            return (_local_2);
        }

        private function handleUseProductMenuRequestInventoryItem(_arg_1:int, _arg_2:int):void
        {
            if ((((_container == null) || (_container.roomSession == null)) || (_container.roomEngine == null)))
            {
                return;
            };
            if (_container.roomSession.userDataManager == null)
            {
                return;
            };
            var _local_6:int = _container.roomSession.roomId;
            var _local_3:int = _container.sessionDataManager.userId;
            var _local_5:IFurnitureData = _container.sessionDataManager.getFloorItemData(_arg_2);
            if (!_local_5)
            {
                return;
            };
            var _local_4:Array = _local_5.customParams.split(" ");
            var _local_7:int = ((_local_4.length > 0) ? parseInt(_local_4[0]) : -1);
            if (_local_7 == -1)
            {
                return;
            };
            activateUseProductMenuForPets(_local_6, _arg_2, _local_7, _local_5.category, _local_3, _arg_1);
        }

        private function handleUseProductMenuRequestRoomObject(_arg_1:int):void
        {
            if ((((_container == null) || (_container.roomSession == null)) || (_container.roomEngine == null)))
            {
                return;
            };
            if (_container.roomSession.userDataManager == null)
            {
                return;
            };
            var _local_6:int = _container.roomSession.roomId;
            var _local_7:IRoomObject = _container.roomEngine.getRoomObject(_local_6, _arg_1, 10);
            var _local_2:Boolean = _container.isOwnerOfFurniture(_local_7);
            if (!_local_2)
            {
                return;
            };
            var _local_3:int = _container.getFurnitureOwnerId(_local_7);
            var _local_5:IFurnitureData = getFurniData(_local_7);
            var _local_4:Array = _local_5.customParams.split(" ");
            var _local_8:int = ((_local_4.length > 0) ? parseInt(_local_4[0]) : -1);
            if (_local_8 == -1)
            {
                return;
            };
            activateUseProductMenuForPets(_local_6, _arg_1, _local_8, _local_5.category, _local_3);
        }

        private function activateUseProductMenuForPets(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int=-1):void
        {
            var _local_12:IRoomObject;
            var _local_10:int;
            var _local_15:IUserData;
            var _local_9:Boolean;
            var _local_11:Array;
            var _local_7:int;
            var _local_13:Array = [];
            var _local_8:int = _container.roomEngine.getRoomObjectCount(_arg_1, 100);
            var _local_14:int = 7;
            _local_10 = 0;
            for (;_local_10 < _local_8;_local_10++)
            {
                _local_12 = _container.roomEngine.getRoomObjectWithIndex(_arg_1, _local_10, 100);
                _local_15 = _container.roomSession.userDataManager.getUserDataByIndex(_local_12.getId());
                _local_9 = false;
                if (!((_local_15 == null) || (!(_local_15.type == 2))))
                {
                    if (_local_15.ownerId == _arg_5)
                    {
                        if (((_local_15.hasSaddle) && (_arg_4 == 16)))
                        {
                            _local_9 = true;
                        };
                        _local_11 = _local_15.figure.split(" ");
                        _local_7 = ((_local_11.length > 0) ? _local_11[0] : -1);
                        if (_local_7 == _arg_3)
                        {
                            if (_arg_4 == 20)
                            {
                                if (!_local_15.canRevive) continue;
                            };
                            if (_arg_4 == 21)
                            {
                                if ((((_local_15.petLevel < _local_14) || (_local_15.canRevive)) || (_local_15.canBreed))) continue;
                            };
                            if (_arg_4 == 22)
                            {
                                if (((_local_15.petLevel >= _local_14) || (_local_15.canRevive))) continue;
                            };
                            _local_13.push(new UseProductItem(_local_15.roomObjectId, 100, _local_15.name, _arg_2, _local_12.getId(), _arg_6, _local_9));
                        };
                    };
                };
            };
            _SafeStr_1324.showUseProductMenuForItems(_local_13);
        }

        private function activateBreedMenuForPets(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int):void
        {
            var _local_10:IRoomObject;
            var _local_8:int;
            var _local_13:IUserData;
            var _local_12:IUserData;
            var _local_9:Array;
            var _local_6:int;
            var _local_11:Array = [];
            var _local_7:int = _container.roomEngine.getRoomObjectCount(_arg_1, 100);
            _local_8 = 0;
            while (_local_8 < _local_7)
            {
                _local_10 = _container.roomEngine.getRoomObjectWithIndex(_arg_1, _local_8, 100);
                _local_13 = _container.roomSession.userDataManager.getUserDataByIndex(_local_10.getId());
                if (!((_local_13 == null) || (!(_local_13.type == 2))))
                {
                    if (_local_13.canBreed)
                    {
                        if (!((!(_local_13.hasBreedingPermission)) && (!(_local_13.ownerId == _arg_5))))
                        {
                            _local_12 = _container.roomSession.userDataManager.getUserData(_local_13.ownerId);
                            if (_local_12 != null)
                            {
                                _local_9 = _local_13.figure.split(" ");
                                _local_6 = ((_local_9.length > 0) ? _local_9[0] : -1);
                                if (((_local_6 == _arg_3) && (!(_local_13.roomObjectId == _arg_4))))
                                {
                                    _local_11.push(new UseProductItem(_local_13.roomObjectId, 100, _local_13.name, _arg_4, _local_10.getId()));
                                };
                            };
                        };
                    };
                };
                _local_8++;
            };
            _SafeStr_1324.showBreedPetMenuForItems(_local_11);
        }

        private function findPetWithWebId(_arg_1:int):IUserData
        {
            var _local_4:int;
            var _local_2:IRoomObject;
            var _local_6:IUserData;
            var _local_5:int = _container.roomSession.roomId;
            var _local_3:int = _container.roomEngine.getRoomObjectCount(_local_5, 100);
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_2 = _container.roomEngine.getRoomObjectWithIndex(_local_5, _local_4, 100);
                _local_6 = _container.roomSession.userDataManager.getUserDataByIndex(_local_2.getId());
                if (!((_local_6 == null) || (!(_local_6.type == 2))))
                {
                    if (_local_6.webID == _arg_1)
                    {
                        return (_local_6);
                    };
                };
                _local_4++;
            };
            return (null);
        }

        public function onCustomUserNotificationMessage(_arg_1:CustomUserNotificationMessageEvent):void
        {
            var _local_2:int = _arg_1.getParser().code;
            switch (_local_2)
            {
                case 4:
                case 5:
                    _container.sessionDataManager.giveRespectFailed();
                default:
                    return;
            };
        }


    }
}