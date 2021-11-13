package com.sulake.habbo.ui.widget.avatarinfo
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.ui.widget.contextmenu.IContextMenuParentWidget;
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.ICoreConfiguration;
    import flash.utils.Timer;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.handler.AvatarInfoWidgetHandler;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.habbo.ui.widget.events.UseProductItem;
    import com.sulake.habbo.inventory.events.HabboInventoryEffectsEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
    import com.sulake.habbo.ui.widget.avatarinfo.botskills.BotSkillConfigurationViewBase;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.events.RoomWidgetAvatarInfoEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetStatusUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetLevelUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetBreedingResultEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetBreedingEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetConfirmPetBreedingEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetConfirmPetBreedingResultEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotInfoUpdateEvent;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotSkillListUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotForceOpenContextMenuEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectNameEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.room.utils.RoomEnterEffect;
    import com.sulake.habbo.ui.widget.contextmenu.ContextInfoView;
    import flash.events.TimerEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserLocationUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetObjectLocationMessage;
    import com.sulake.habbo.ui.widget.memenu.IWidgetAvatarEffect;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.ui.widget.events.ConfirmPetBreedingPetData;
    import com.sulake.habbo.communication.messages.outgoing.room.pets.BreedPetsMessageComposer;
    import com.sulake.habbo.ui.widget.avatarinfo.botskills.BotChatterMarkovConfiguration;
    import com.sulake.habbo.ui.widget.avatarinfo.botskills.BotChangeNameConfiguration;
    import com.sulake.habbo.ui.widget.avatarinfo.botskills.BotSkillConfigurationView;
    import flash.geom.Point;
    import com.sulake.habbo.communication.messages.outgoing.inventory.pets.CancelPetBreedingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.pets.ConfirmPetBreedingComposer;
    import com.sulake.habbo.friendlist.IHabboFriendList;

    public class AvatarInfoWidget extends RoomWidgetBase implements IUpdateReceiver, IContextMenuParentWidget 
    {

        private static const EFFECT_TYPE_RIDE:int = 77;
        private static const EFFECT_TYPE_DEEP_WATER:int = 29;
        private static const EFFECT_TYPE_SHALLOW_WATER:int = 30;
        private static const _SafeStr_3886:int = 185;
        private static const AVATAR_HIGHLIGHT_DURATION_MSEC:int = 5000;
        private static const _SafeStr_3887:String = "avatar";
        private static const _SafeStr_3888:String = "use_minimized_own_avatar_menu";

        private var _component:Component;
        private var _configuration:ICoreConfiguration;
        private var _SafeStr_570:AvatarContextInfoButtonView;
        private var _SafeStr_3889:DecorateModeView;
        private var _SafeStr_573:Boolean = false;
        private var _SafeStr_3029:Boolean = false;
        private var _SafeStr_3890:Boolean = false;
        private var _SafeStr_3891:Timer;
        private var _SafeStr_3892:AvatarInfoData;
        private var _SafeStr_3893:RentableBotInfoData;
        private var _SafeStr_3894:PetInfoData;
        private var _SafeStr_3895:int = -1;
        private var _SafeStr_3896:Boolean = false;
        private var _SafeStr_3897:AvatarContextInfoButtonView;
        private var _cachedOwnAvatarMenu:OwnAvatarMenuView;
        private var _SafeStr_3898:AvatarMenuView;
        private var _SafeStr_3899:RentableBotMenuView;
        private var _SafeStr_3900:OwnPetMenuView;
        private var _SafeStr_3901:PetMenuView;
        private var _SafeStr_3902:NewUserHelpView;
        private var _SafeStr_3903:Map;
        private var _SafeStr_3904:Map;
        private var _SafeStr_3905:Map;
        private var _SafeStr_3906:UseProductConfirmationView;
        private var _SafeStr_3907:BreedMonsterPlantsConfirmationView;
        private var _SafeStr_3908:ConfirmPetBreedingView;
        private var _SafeStr_3909:BreedPetsResultView;
        private var _breedingConfirmationAlert:IAlertDialog;
        private var _SafeStr_3910:int = -1;
        private var _SafeStr_3911:int = -1;
        private var _isDancing:Boolean = false;
        private var _handlePetInfo:Boolean = true;
        private var _catalog:IHabboCatalog;
        private var _SafeStr_3912:Map = new Map();
        private var _SafeStr_3913:Map = new Map();
        private var _SafeStr_3914:NestBreedingSuccessView;

        public function AvatarInfoWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:ICoreConfiguration, _arg_5:IHabboLocalizationManager, _arg_6:Component, _arg_7:IHabboCatalog)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_5);
            _component = _arg_6;
            _catalog = _arg_7;
            _configuration = _arg_4;
            _SafeStr_3892 = new AvatarInfoData();
            _SafeStr_3894 = new PetInfoData();
            _SafeStr_3893 = null;
            _SafeStr_3903 = new Map();
            _SafeStr_3904 = new Map();
            _SafeStr_3905 = new Map();
            this.handler.roomEngine.events.addEventListener("REOE_ADDED", onRoomObjectAdded);
            this.handler.roomEngine.events.addEventListener("REOE_REMOVED", onRoomObjectRemoved);
            this.handler.container.inventory.events.addEventListener("HIEE_EFFECTS_CHANGED", onEffectsChanged);
            this.handler.widget = this;
        }

        public function get component():Component
        {
            return (_component);
        }

        public function get handler():AvatarInfoWidgetHandler
        {
            return (_SafeStr_3915 as AvatarInfoWidgetHandler);
        }

        public function get configuration():ICoreConfiguration
        {
            return (_configuration);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (_SafeStr_819);
        }

        public function set handlePetInfo(_arg_1:Boolean):void
        {
            _handlePetInfo = _arg_1;
        }

        private function onRoomObjectAdded(_arg_1:RoomEngineObjectEvent):void
        {
            var _local_2:IUserData;
            if (_arg_1.category == 100)
            {
                _local_2 = handler.roomSession.userDataManager.getUserDataByIndex(_arg_1.objectId);
                if (_local_2)
                {
                    if (handler.friendList.getFriendNames().indexOf(_local_2.name) > -1)
                    {
                        showUserName(_local_2, _arg_1.objectId);
                    };
                };
            };
        }

        private function onRoomObjectRemoved(_arg_1:RoomEngineObjectEvent):void
        {
            var _local_6:int;
            var _local_4:Array;
            var _local_5:int;
            var _local_3:Array;
            if (_arg_1.category == 100)
            {
                for each (var _local_2:UserNameView in _SafeStr_3903)
                {
                    if (_local_2.objectId == _arg_1.objectId)
                    {
                        removeView(_local_2, false);
                    };
                };
                _local_4 = [];
                for each (var _local_8:BreedPetView in _SafeStr_3905)
                {
                    _local_6 = _local_8.requestRoomObjectId;
                    if (_local_6 == _local_5)
                    {
                        _local_4.push(_local_8);
                    };
                };
                for each (_local_8 in _local_4)
                {
                    removeView(_local_8, false);
                };
                if (_SafeStr_3907 != null)
                {
                    if (((_arg_1.objectId == _SafeStr_3907.requestRoomObjectId) || (_arg_1.objectId == _SafeStr_3907.targetRoomObjectId)))
                    {
                        removeBreedMonsterPlantsConfirmationView();
                    };
                };
                if (_SafeStr_3908 != null)
                {
                    if (((_arg_1.objectId == _SafeStr_3908.requestRoomObjectId) || (_arg_1.objectId == _SafeStr_3908.targetRoomObjectId)))
                    {
                        removeConfirmPetBreedingView();
                    };
                };
                if (_SafeStr_3906 != null)
                {
                    if (((_arg_1.objectId == _SafeStr_3906.requestObjectId) || (_arg_1.objectId == _SafeStr_3906.targetRoomObjectId)))
                    {
                        removeUseProductConfirmationView();
                    };
                };
            };
            if (_arg_1.category == 10)
            {
                _local_5 = _arg_1.objectId;
                if (_SafeStr_3906 != null)
                {
                    if (_SafeStr_3906.requestObjectId == _local_5)
                    {
                        removeUseProductConfirmationView();
                    };
                };
                if (_SafeStr_3909 != null)
                {
                    _SafeStr_3909.roomObjectRemoved(_local_5);
                };
                _local_3 = [];
                for each (var _local_7:UseProductView in _SafeStr_3904)
                {
                    _local_6 = _local_7.requestRoomObjectId;
                    if (_local_6 == _local_5)
                    {
                        _local_3.push(_local_7);
                    };
                };
                for each (_local_7 in _local_3)
                {
                    removeView(_local_7, false);
                };
            };
        }

        public function showUseProductMenuForItems(_arg_1:Array):void
        {
            var _local_3:IUserData;
            removeUseProductViews();
            removeUseProductConfirmationView();
            removeBreedMonsterPlantsConfirmationView();
            for each (var _local_2:UseProductItem in _arg_1)
            {
                _local_3 = handler.roomSession.userDataManager.getUserDataByIndex(_local_2.id);
                showUseProductMenu(_local_3, _local_2);
            };
        }

        public function showBreedPetMenuForItems(_arg_1:Array):void
        {
            var _local_3:IUserData;
            removeBreedPetViews();
            removeUseProductConfirmationView();
            removeBreedMonsterPlantsConfirmationView();
            for each (var _local_2:UseProductItem in _arg_1)
            {
                _local_3 = handler.roomSession.userDataManager.getUserDataByIndex(_local_2.id);
                showBreedPetMenu(_local_3, _local_2);
            };
        }

        private function onEffectsChanged(_arg_1:HabboInventoryEffectsEvent):void
        {
            if ((_SafeStr_570 is OwnAvatarMenuView))
            {
                (_SafeStr_570 as OwnAvatarMenuView).updateButtons();
            };
        }

        private function getOwnCharacterInfo():void
        {
            messageListener.processWidgetMessage(new RoomWidgetRoomObjectMessage("RWROM_GET_OWN_CHARACTER_INFO", 0, 0));
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            removeAvatarHighlightTimer();
            for each (var _local_1:UserNameView in _SafeStr_3903)
            {
                _local_1.dispose();
            };
            _SafeStr_3903 = null;
            for each (var _local_2:UseProductView in _SafeStr_3904)
            {
                _local_2.dispose();
            };
            _SafeStr_3904 = null;
            for each (var _local_4:BreedPetView in _SafeStr_3905)
            {
                _local_4.dispose();
            };
            _SafeStr_3905 = null;
            if (_component)
            {
                _component.removeUpdateReceiver(this);
                _component = null;
            };
            if (_SafeStr_3897)
            {
                _SafeStr_3897.dispose();
                _SafeStr_3897 = null;
            };
            if (_SafeStr_3898)
            {
                _SafeStr_3898.dispose();
                _SafeStr_3898 = null;
            };
            if (_cachedOwnAvatarMenu)
            {
                _cachedOwnAvatarMenu.dispose();
                _cachedOwnAvatarMenu = null;
            };
            if (_SafeStr_3899)
            {
                _SafeStr_3899.dispose();
                _SafeStr_3899 = null;
            };
            if (_SafeStr_3901)
            {
                _SafeStr_3901.dispose();
                _SafeStr_3901 = null;
            };
            if (_SafeStr_570)
            {
                if (!_SafeStr_570.disposed)
                {
                    _SafeStr_570.dispose();
                    _SafeStr_570 = null;
                };
            };
            if (_SafeStr_3889)
            {
                _SafeStr_3889.dispose();
                _SafeStr_3889 = null;
            };
            if (_SafeStr_3906)
            {
                _SafeStr_3906.dispose();
                _SafeStr_3906 = null;
            };
            removeBreedMonsterPlantsConfirmationView();
            removeConfirmPetBreedingView();
            if (_SafeStr_3909)
            {
                _SafeStr_3909.dispose();
                _SafeStr_3909 = null;
            };
            if (_breedingConfirmationAlert)
            {
                _breedingConfirmationAlert.dispose();
                _breedingConfirmationAlert = null;
            };
            if (_SafeStr_3912)
            {
                for each (var _local_3:int in _SafeStr_3912.getKeys())
                {
                    BotSkillConfigurationViewBase(_SafeStr_3912.getValue(_local_3)).dispose();
                };
                _SafeStr_3912.dispose();
                _SafeStr_3912 = null;
            };
            if (((_SafeStr_3913) && (_SafeStr_3913.length > 0)))
            {
                _SafeStr_3913.dispose();
                _SafeStr_3913 = null;
            };
            handler.roomEngine.events.removeEventListener("REOE_ADDED", onRoomObjectAdded);
            handler.roomEngine.events.removeEventListener("REOE_REMOVED", onRoomObjectRemoved);
            handler.container.inventory.events.removeEventListener("HIEE_EFFECTS_CHANGED", onEffectsChanged);
            _SafeStr_570 = null;
            _configuration = null;
            super.dispose();
        }

        public function close():void
        {
            removeView(_SafeStr_570, false);
        }

        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (!_arg_1)
            {
                return;
            };
            _arg_1.addEventListener("RWRBFOCME_OPEN", updateEventHandler);
            _arg_1.addEventListener("RWRBSLUE_SKILL_LIST", updateEventHandler);
            _arg_1.addEventListener("RWRBIUE_RENTABLE_BOT", updateEventHandler);
            _arg_1.addEventListener("RWAIE_AVATAR_INFO", updateEventHandler);
            _arg_1.addEventListener("RWUIUE_OWN_USER", updateEventHandler);
            _arg_1.addEventListener("RWUIUE_PEER", updateEventHandler);
            _arg_1.addEventListener("RWROUE_FURNI_ADDED", updateEventHandler);
            _arg_1.addEventListener("RWROUE_OBJECT_SELECTED", updateEventHandler);
            _arg_1.addEventListener("RWROUE_OBJECT_DESELECTED", updateEventHandler);
            _arg_1.addEventListener("RWFIUE_FURNI", updateEventHandler);
            _arg_1.addEventListener("RWUIUE_BOT", updateEventHandler);
            _arg_1.addEventListener("RWPIUE_PET_INFO", updateEventHandler);
            _arg_1.addEventListener("rwudue_user_data_updated", updateEventHandler);
            _arg_1.addEventListener("RWROUE_USER_REMOVED", updateEventHandler);
            _arg_1.addEventListener("RWREUE_NORMAL_MODE", updateEventHandler);
            _arg_1.addEventListener("RWREUE_GAME_MODE", updateEventHandler);
            _arg_1.addEventListener("RWONE_TYPE", updateEventHandler);
            _arg_1.addEventListener("RWROUE_OBJECT_ROLL_OVER", updateEventHandler);
            _arg_1.addEventListener("RWROUE_OBJECT_ROLL_OUT", updateEventHandler);
            _arg_1.addEventListener("RWPIUE_PET_STATUS_UPDATE", updateEventHandler);
            _arg_1.addEventListener("RWPLUE_PET_LEVEL_UPDATE", updateEventHandler);
            _arg_1.addEventListener("RWPBRE_PET_BREEDING_RESULT", updateEventHandler);
            _arg_1.addEventListener("RWPPBE_PET_BREEDING_", updateEventHandler);
            _arg_1.addEventListener("RWIUM_INVENTORY_UPDATED", updateEventHandler);
            _arg_1.addEventListener("RWPPBE_CONFIRM_PET_BREEDING_", updateEventHandler);
            _arg_1.addEventListener("RWPPBE_CONFIRM_PET_BREEDING_RESULT", updateEventHandler);
            super.registerUpdateEvents(_arg_1);
        }

        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.removeEventListener("RWRBFOCME_OPEN", updateEventHandler);
            _arg_1.removeEventListener("RWRBSLUE_SKILL_LIST", updateEventHandler);
            _arg_1.removeEventListener("RWRBIUE_RENTABLE_BOT", updateEventHandler);
            _arg_1.removeEventListener("RWAIE_AVATAR_INFO", updateEventHandler);
            _arg_1.removeEventListener("RWUIUE_OWN_USER", updateEventHandler);
            _arg_1.removeEventListener("RWUIUE_PEER", updateEventHandler);
            _arg_1.removeEventListener("RWROUE_FURNI_ADDED", updateEventHandler);
            _arg_1.removeEventListener("RWROUE_OBJECT_SELECTED", updateEventHandler);
            _arg_1.removeEventListener("RWROUE_OBJECT_DESELECTED", updateEventHandler);
            _arg_1.removeEventListener("RWFIUE_FURNI", updateEventHandler);
            _arg_1.removeEventListener("RWUIUE_BOT", updateEventHandler);
            _arg_1.removeEventListener("RWPIUE_PET_INFO", updateEventHandler);
            _arg_1.removeEventListener("rwudue_user_data_updated", updateEventHandler);
            _arg_1.removeEventListener("RWROUE_USER_REMOVED", updateEventHandler);
            _arg_1.removeEventListener("RWREUE_NORMAL_MODE", updateEventHandler);
            _arg_1.removeEventListener("RWREUE_GAME_MODE", updateEventHandler);
            _arg_1.removeEventListener("RWONE_TYPE", updateEventHandler);
            _arg_1.removeEventListener("RWROUE_OBJECT_ROLL_OUT", updateEventHandler);
            _arg_1.removeEventListener("RWROUE_OBJECT_ROLL_OUT", updateEventHandler);
            _arg_1.removeEventListener("RWPIUE_PET_STATUS_UPDATE", updateEventHandler);
            _arg_1.removeEventListener("RWPLUE_PET_LEVEL_UPDATE", updateEventHandler);
            _arg_1.removeEventListener("RWPBRE_PET_BREEDING_RESULT", updateEventHandler);
            _arg_1.removeEventListener("RWPPBE_PET_BREEDING_", updateEventHandler);
            _arg_1.removeEventListener("RWIUM_INVENTORY_UPDATED", updateEventHandler);
            _arg_1.removeEventListener("RWPPBE_CONFIRM_PET_BREEDING_", updateEventHandler);
            _arg_1.removeEventListener("RWPPBE_CONFIRM_PET_BREEDING_RESULT", updateEventHandler);
        }

        private function updateEventHandler(_arg_1:RoomWidgetUpdateEvent):void
        {
            var _local_12:RoomWidgetAvatarInfoEvent;
            var _local_8:RoomWidgetPetStatusUpdateEvent;
            var _local_3:IUserData;
            var _local_22:RoomWidgetPetLevelUpdateEvent;
            var _local_27:IUserData;
            var _local_2:RoomWidgetPetBreedingResultEvent;
            var _local_4:BreedPetsResultData;
            var _local_14:BreedPetsResultData;
            var _local_20:RoomWidgetPetBreedingEvent;
            var _local_7:int;
            var _local_25:int;
            var _local_16:RoomWidgetConfirmPetBreedingEvent;
            var _local_15:RoomWidgetConfirmPetBreedingResultEvent;
            var _local_9:RoomWidgetUserInfoUpdateEvent;
            var _local_11:AvatarInfoData;
            var _local_13:RoomWidgetRentableBotInfoUpdateEvent;
            var _local_5:IRoomSession;
            var _local_26:IUserData;
            var _local_23:RoomWidgetRentableBotSkillListUpdateEvent;
            var _local_18:RoomWidgetRentableBotForceOpenContextMenuEvent;
            var _local_21:int;
            var _local_17:IUserData;
            var _local_6:RoomWidgetUserInfoUpdateEvent;
            var _local_24:RoomWidgetPetInfoUpdateEvent;
            var _local_19:RoomWidgetRoomObjectUpdateEvent;
            switch (_arg_1.type)
            {
                case "RWAIE_AVATAR_INFO":
                    _local_12 = (_arg_1 as RoomWidgetAvatarInfoEvent);
                    _SafeStr_3890 = (((!(_SafeStr_573)) && (!(handler.container.roomSession == null))) && (_local_12.roomIndex == handler.container.roomSession.ownUserRoomId));
                    if (_local_12.allowNameChange)
                    {
                        useMinimizedOwnAvatarMenu = true;
                        selectOwnAvatar();
                    }
                    else
                    {
                        updateUserView(_local_12.userId, _local_12.userName, _local_12.userType, _local_12.roomIndex, _local_12.allowNameChange, null);
                    };
                    _SafeStr_573 = true;
                    break;
                case "RWONE_TYPE":
                    if (RoomWidgetRoomObjectNameEvent(_arg_1).category == 100)
                    {
                        updateUserView(RoomWidgetRoomObjectNameEvent(_arg_1).userId, RoomWidgetRoomObjectNameEvent(_arg_1).userName, RoomWidgetRoomObjectNameEvent(_arg_1).userType, RoomWidgetRoomObjectNameEvent(_arg_1).roomIndex, false, null);
                    };
                    break;
                case "RWROUE_FURNI_ADDED":
                    if (RoomWidgetRoomObjectUpdateEvent(_arg_1).category == 10)
                    {
                        if (_SafeStr_3909 != null)
                        {
                            _SafeStr_3909.roomObjectAdded(RoomWidgetRoomObjectUpdateEvent(_arg_1).id);
                        };
                    };
                    break;
                case "RWROUE_OBJECT_SELECTED":
                    if (RoomWidgetRoomObjectUpdateEvent(_arg_1).category == 100)
                    {
                        _handlePetInfo = true;
                    };
                    removeBreedPetViews();
                    break;
                case "RWROUE_OBJECT_DESELECTED":
                    if (((_SafeStr_570) && (!(_SafeStr_570 is NewUserHelpView))))
                    {
                        removeView(_SafeStr_570, false);
                    };
                    removeUseProductViews();
                    removeBreedPetViews();
                    break;
                case "RWFIUE_FURNI":
                    if (_SafeStr_570)
                    {
                        removeView(_SafeStr_570, false);
                    };
                    removeUseProductViews();
                    removeBreedPetViews();
                    break;
                case "RWROUE_OBJECT_ROLL_OVER":
                    if (_SafeStr_3890)
                    {
                        return;
                    };
                    if (!(((((_SafeStr_570 is AvatarMenuView) || (_SafeStr_570 is OwnAvatarMenuView)) || (_SafeStr_570 is OwnPetMenuView)) || (_SafeStr_570 is NewUserHelpView)) || (_SafeStr_570 is RentableBotMenuView)))
                    {
                        _SafeStr_3895 = RoomWidgetRoomObjectUpdateEvent(_arg_1).id;
                        messageListener.processWidgetMessage(new RoomWidgetRoomObjectMessage("RWROM_GET_OBJECT_NAME", RoomWidgetRoomObjectUpdateEvent(_arg_1).id, RoomWidgetRoomObjectUpdateEvent(_arg_1).category));
                    };
                    break;
                case "RWROUE_OBJECT_ROLL_OUT":
                    if (_SafeStr_3890)
                    {
                        return;
                    };
                    if (!(((((_SafeStr_570 is AvatarMenuView) || (_SafeStr_570 is OwnAvatarMenuView)) || (_SafeStr_570 is OwnPetMenuView)) || (_SafeStr_570 is NewUserHelpView)) || (_SafeStr_570 is RentableBotMenuView)))
                    {
                        if (RoomWidgetRoomObjectUpdateEvent(_arg_1).id == _SafeStr_3895)
                        {
                            if (((_SafeStr_570) && (!(_SafeStr_570.allowNameChange))))
                            {
                                removeView(_SafeStr_570, false);
                                _SafeStr_3895 = -1;
                            };
                        };
                    };
                    break;
                case "RWPIUE_PET_STATUS_UPDATE":
                    _local_8 = (_arg_1 as RoomWidgetPetStatusUpdateEvent);
                    if (((_SafeStr_570) && (_SafeStr_570 is OwnPetMenuView)))
                    {
                        if (((!(_local_8 == null)) && (!(_SafeStr_3894 == null))))
                        {
                            _local_3 = handler.roomSession.userDataManager.getUserDataByIndex(_local_8.petId);
                            if (((!(_local_3 == null)) && (_local_3.webID == _SafeStr_3894.id)))
                            {
                                removeView(_SafeStr_570, true);
                            };
                        };
                    };
                    if (_local_8 != null)
                    {
                        removeBreedPetViewsWithId(_local_8.petId);
                    };
                    break;
                case "RWPLUE_PET_LEVEL_UPDATE":
                    _local_22 = (_arg_1 as RoomWidgetPetLevelUpdateEvent);
                    if (((_SafeStr_570) && (_SafeStr_570 is OwnPetMenuView)))
                    {
                        if (((!(_local_22 == null)) && (!(_SafeStr_3894 == null))))
                        {
                            _local_27 = handler.roomSession.userDataManager.getUserDataByIndex(_local_22.petId);
                            if (((!(_local_27 == null)) && (_local_27.webID == _SafeStr_3894.id)))
                            {
                                removeView(_SafeStr_570, true);
                            };
                        };
                    };
                    if (_local_22 != null)
                    {
                        removeBreedPetViewsWithId(_local_22.petId);
                    };
                    break;
                case "RWPBRE_PET_BREEDING_RESULT":
                    _local_2 = (_arg_1 as RoomWidgetPetBreedingResultEvent);
                    _local_4 = new BreedPetsResultData();
                    _local_4.stuffId = _local_2.resultData.stuffId;
                    _local_4.classId = _local_2.resultData.classId;
                    _local_4.productCode = _local_2.resultData.productCode;
                    _local_4.userId = _local_2.resultData.userId;
                    _local_4.userName = _local_2.resultData.userName;
                    _local_4.rarityLevel = _local_2.resultData.rarityLevel;
                    _local_4.hasMutation = _local_2.resultData.hasMutation;
                    _local_14 = new BreedPetsResultData();
                    _local_14.stuffId = _local_2.resultData2.stuffId;
                    _local_14.classId = _local_2.resultData2.classId;
                    _local_14.productCode = _local_2.resultData2.productCode;
                    _local_14.userId = _local_2.resultData2.userId;
                    _local_14.userName = _local_2.resultData2.userName;
                    _local_14.rarityLevel = _local_2.resultData2.rarityLevel;
                    _local_14.hasMutation = _local_2.resultData2.hasMutation;
                    showBreedPetsResultView(_local_4, _local_14);
                    break;
                case "RWPPBE_PET_BREEDING_":
                    _local_20 = (_arg_1 as RoomWidgetPetBreedingEvent);
                    _local_7 = findPetRoomObjectIdByWebId(_local_20.ownPetId);
                    _local_25 = findPetRoomObjectIdByWebId(_local_20.otherPetId);
                    switch (_local_20.state)
                    {
                        case 0:
                            showBreedMonsterPlantsConfirmationView(_local_7, _local_25, false);
                            break;
                        case 1:
                            cancelBreedingPets(_local_7, _local_25);
                            break;
                        case 2:
                            acceptBreedingPets(_local_7, _local_25);
                            break;
                        case 3:
                            showBreedMonsterPlantsConfirmationView(_local_7, _local_25, true);
                        default:
                    };
                    break;
                case "RWIUM_INVENTORY_UPDATED":
                    if (_SafeStr_3909 != null)
                    {
                        _SafeStr_3909.updatePlacingButtons();
                    };
                    break;
                case "RWPPBE_CONFIRM_PET_BREEDING_":
                    _local_16 = (_arg_1 as RoomWidgetConfirmPetBreedingEvent);
                    showConfirmPetBreedingView(_local_16.pet1, _local_16.pet2, _local_16.nestId, _local_16.rarityCategories, _local_16.resultPetTypeId);
                    break;
                case "RWPPBE_CONFIRM_PET_BREEDING_RESULT":
                    _local_15 = (_arg_1 as RoomWidgetConfirmPetBreedingResultEvent);
                    switch (_local_15.result)
                    {
                        case 0:
                            removeConfirmPetBreedingView();
                            break;
                        case 3:
                            windowManager.simpleAlert("${breedpets.confirmation.alert.title}", "${breedpets.confirmation.alert.name.invalid.head}", "${breedpets.confirmation.alert.name.invalid.desc}");
                            if (_SafeStr_3908)
                            {
                                _SafeStr_3908.enable();
                            };
                            break;
                        case 1:
                            windowManager.simpleAlert("${breedpets.confirmation.alert.title}", "${breedpets.confirmation.alert.nonest.head}", "${breedpets.confirmation.alert.nonest.desc}");
                            removeConfirmPetBreedingView();
                            break;
                        case 2:
                            windowManager.simpleAlert("${breedpets.confirmation.alert.title}", "${breedpets.confirmation.alert.petsmissing.head}", "${breedpets.confirmation.alert.petsmissing.desc}");
                            removeConfirmPetBreedingView();
                        default:
                    };
                    break;
                case "RWUIUE_OWN_USER":
                case "RWUIUE_PEER":
                    _local_9 = (_arg_1 as RoomWidgetUserInfoUpdateEvent);
                    _SafeStr_3892.populate(_local_9);
                    _local_11 = ((_local_9.isSpectatorMode) ? null : _SafeStr_3892);
                    updateUserView(_local_9.webID, _local_9.name, _local_9.userType, _local_9.userRoomId, _SafeStr_3892.allowNameChange, _local_11);
                    break;
                case "RWRBIUE_RENTABLE_BOT":
                    _local_13 = (_arg_1 as RoomWidgetRentableBotInfoUpdateEvent);
                    if (!_SafeStr_3893)
                    {
                        _SafeStr_3893 = new RentableBotInfoData();
                    };
                    _SafeStr_3893.populate(_local_13);
                    _local_5 = handler.container.roomSessionManager.getSession(_local_21);
                    if (!_local_5)
                    {
                        return;
                    };
                    _local_26 = _local_5.userDataManager.getRentableBotUserData(_local_13.webID);
                    if (!_local_26)
                    {
                        return;
                    };
                    _SafeStr_3913[_local_13.webID.toString()] = _local_26.botSkillData;
                    if (((_SafeStr_3893) && (_local_26.botSkillData)))
                    {
                        _SafeStr_3893.cloneAndSetSkillsWithCommands(_local_26.botSkillData);
                    };
                    updateRentableBotView(_local_13.webID, _local_13.name, _local_13.userRoomId, _SafeStr_3893);
                    break;
                case "RWRBSLUE_SKILL_LIST":
                    _local_23 = (_arg_1 as RoomWidgetRentableBotSkillListUpdateEvent);
                    _SafeStr_3913[_local_23.botId.toString()] = _local_23.botSkillsWithCommands;
                    if (_SafeStr_3893)
                    {
                        _SafeStr_3893.cloneAndSetSkillsWithCommands(_local_23.botSkillsWithCommands);
                        updateRentableBotView(_SafeStr_3893.id, _SafeStr_3893.name, _SafeStr_3893.roomIndex, _SafeStr_3893, true);
                    };
                    break;
                case "RWRBFOCME_OPEN":
                    _local_18 = (_arg_1 as RoomWidgetRentableBotForceOpenContextMenuEvent);
                    if (_SafeStr_3893)
                    {
                        updateRentableBotView(_SafeStr_3893.id, _SafeStr_3893.name, _SafeStr_3893.roomIndex, _SafeStr_3893, false, true);
                    }
                    else
                    {
                        _local_21 = handler.container.roomEngine.activeRoomId;
                        _local_17 = handler.container.roomSessionManager.getSession(_local_21).userDataManager.getUserDataByType(_local_18.botId, 4);
                        messageListener.processWidgetMessage(new RoomWidgetRoomObjectMessage("RWROM_GET_OBJECT_INFO", _local_17.roomObjectId, 100));
                        handler.container.roomEngine.selectAvatar(_local_21, _local_17.roomObjectId);
                    };
                    break;
                case "RWUIUE_BOT":
                    _local_6 = (_arg_1 as RoomWidgetUserInfoUpdateEvent);
                    updateUserView(_local_6.webID, _local_6.name, _local_6.userType, _local_6.userRoomId, false, null);
                    break;
                case "RWPIUE_PET_INFO":
                    if (_handlePetInfo)
                    {
                        _local_24 = (_arg_1 as RoomWidgetPetInfoUpdateEvent);
                        _SafeStr_3894.populate(_local_24);
                        updatePetView(_local_24.id, _local_24.name, _local_24.roomIndex, _SafeStr_3894);
                    };
                    break;
                case "rwudue_user_data_updated":
                    if (!_SafeStr_573)
                    {
                        getOwnCharacterInfo();
                    };
                    break;
                case "RWROUE_USER_REMOVED":
                    _local_19 = (_arg_1 as RoomWidgetRoomObjectUpdateEvent);
                    if (((_SafeStr_570) && (_SafeStr_570.roomIndex == _local_19.id)))
                    {
                        removeView(_SafeStr_570, false);
                    };
                    for each (var _local_10:UserNameView in _SafeStr_3903)
                    {
                        if (_local_10.objectId == _local_19.id)
                        {
                            removeView(_local_10, false);
                            break;
                        };
                    };
                    removeBreedPetViewsWithId(_local_19.id);
                    break;
                case "RWREUE_NORMAL_MODE":
                    _SafeStr_3029 = false;
                    break;
                case "RWREUE_GAME_MODE":
                    _SafeStr_3029 = true;
            };
            checkUpdateNeed();
        }

        private function findPetRoomObjectIdByWebId(_arg_1:int):int
        {
            var _local_4:int;
            var _local_2:IRoomObject;
            var _local_6:IUserData;
            var _local_5:int = handler.container.roomSession.roomId;
            var _local_3:int = handler.container.roomEngine.getRoomObjectCount(_local_5, 100);
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_2 = handler.container.roomEngine.getRoomObjectWithIndex(_local_5, _local_4, 100);
                _local_6 = handler.container.roomSession.userDataManager.getUserDataByIndex(_local_2.getId());
                if (!((_local_6 == null) || (!(_local_6.type == 2))))
                {
                    if (_local_6.webID == _arg_1)
                    {
                        return (_local_2.getId());
                    };
                };
                _local_4++;
            };
            return (-1);
        }

        private function removeBreedPetViewsWithId(_arg_1:int):void
        {
            var _local_3:Array = [];
            for each (var _local_2:BreedPetView in _SafeStr_3905)
            {
                if (((_local_2.objectId == _arg_1) || (_local_2.requestRoomObjectId == _arg_1)))
                {
                    if (_local_3.indexOf(_local_2) == -1)
                    {
                        _local_3.push(_local_2);
                    };
                };
            };
            for each (var _local_4:BreedPetView in _local_3)
            {
                removeView(_local_4, false);
            };
        }

        public function selectOwnAvatar():void
        {
            var _local_2:RoomWidgetRoomObjectMessage;
            if ((((!(handler)) || (!(handler.container))) || (!(handler.roomSession))))
            {
                return;
            };
            var _local_3:int = handler.container.sessionDataManager.userId;
            var _local_1:IUserData = handler.roomSession.userDataManager.getUserData(_local_3);
            if (!_local_1)
            {
                return;
            };
            _local_2 = new RoomWidgetRoomObjectMessage("RWROM_SELECT_OBJECT", _local_1.roomObjectId, 100);
            handler.container.processWidgetMessage(_local_2);
        }

        public function get ownAvatarPosture():String
        {
            var _local_2:IRoomObjectModel;
            var _local_1:IRoomObject = findCurrentUserRoomObject();
            if (_local_1 != null)
            {
                _local_2 = _local_1.getModel();
                if (_local_2 != null)
                {
                    return (_local_2.getString("figure_posture"));
                };
            };
            return ("std");
        }

        public function get canStandUp():Boolean
        {
            var _local_2:IRoomObjectModel;
            var _local_1:IRoomObject = findCurrentUserRoomObject();
            if (_local_1 != null)
            {
                _local_2 = _local_1.getModel();
                if (_local_2 != null)
                {
                    return (_local_2.getNumber("figure_can_stand_up") > 0);
                };
            };
            return (false);
        }

        public function get isSwimming():Boolean
        {
            var _local_3:IRoomObjectModel;
            var _local_2:Number;
            var _local_1:IRoomObject = findCurrentUserRoomObject();
            if (_local_1 != null)
            {
                _local_3 = _local_1.getModel();
                if (_local_3 != null)
                {
                    _local_2 = _local_3.getNumber("figure_effect");
                    return (((_local_2 == 29) || (_local_2 == 30)) || (_local_2 == 185));
                };
            };
            return (false);
        }

        private function updateRentableBotView(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:RentableBotInfoData, _arg_5:Boolean=false, _arg_6:Boolean=false):void
        {
            if (!_arg_4)
            {
                return;
            };
            var _local_8:Boolean = _configuration.getBoolean("menu.bot.enabled");
            var _local_7:Boolean = ((_arg_5) && (!(_SafeStr_570)));
            if (_arg_6)
            {
                _local_7 = false;
            };
            if ((((_local_8) && (_SafeStr_570)) && (!(((((_SafeStr_570 is AvatarMenuView) || (_SafeStr_570 is OwnAvatarMenuView)) || (_SafeStr_570 is PetMenuView)) || (_SafeStr_570 is OwnPetMenuView)) || (_SafeStr_570 is RentableBotMenuView)))))
            {
                removeView(_SafeStr_570, false);
            };
            removeUseProductViews();
            if ((((((((_arg_6) || (((!(_SafeStr_570 == null)) && (_SafeStr_570.userId == _arg_1)) && (!(_arg_5)))) || (_SafeStr_570 == null)) || (!(_SafeStr_570.userId == _arg_1))) || (!(_SafeStr_570.userName == _arg_2))) || (!(_SafeStr_570.roomIndex == _arg_3))) || (!(_SafeStr_570.userType == 4))))
            {
                if (_SafeStr_570)
                {
                    removeView(_SafeStr_570, false);
                };
                if (!_SafeStr_3029)
                {
                    if (!_SafeStr_3899)
                    {
                        _SafeStr_3899 = new RentableBotMenuView(this);
                    };
                    if (!_local_7)
                    {
                        _SafeStr_570 = _SafeStr_3899;
                        RentableBotMenuView.setup((_SafeStr_570 as RentableBotMenuView), _arg_1, _arg_2, _arg_3, 4, _arg_4);
                    };
                };
            }
            else
            {
                if ((_SafeStr_570 is RentableBotMenuView))
                {
                    if (_SafeStr_570.userName == _arg_2)
                    {
                        removeView(_SafeStr_570, false);
                    };
                };
            };
        }

        private function updatePetView(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:PetInfoData):void
        {
            if (!_arg_4)
            {
                return;
            };
            if (((_SafeStr_570) && (!(((((_SafeStr_570 is AvatarMenuView) || (_SafeStr_570 is OwnAvatarMenuView)) || (_SafeStr_570 is PetMenuView)) || (_SafeStr_570 is OwnPetMenuView)) || (_SafeStr_570 is RentableBotMenuView)))))
            {
                removeView(_SafeStr_570, false);
            };
            removeUseProductViews();
            if ((((((_SafeStr_570 == null) || (!(_SafeStr_570.userId == _arg_1))) || (!(_SafeStr_570.userName == _arg_2))) || (!(_SafeStr_570.roomIndex == _arg_3))) || (!(_SafeStr_570.userType == 2))))
            {
                if (_SafeStr_570)
                {
                    removeView(_SafeStr_570, false);
                };
                if (!_SafeStr_3029)
                {
                    if (_arg_4.isOwnPet)
                    {
                        if (!_SafeStr_3900)
                        {
                            _SafeStr_3900 = new OwnPetMenuView(this, _catalog);
                        };
                        _SafeStr_570 = _SafeStr_3900;
                        OwnPetMenuView.setup((_SafeStr_570 as OwnPetMenuView), _arg_1, _arg_2, _arg_3, 2, _arg_4);
                    }
                    else
                    {
                        if (!_SafeStr_3901)
                        {
                            _SafeStr_3901 = new PetMenuView(this);
                        };
                        _SafeStr_570 = _SafeStr_3901;
                        PetMenuView.setup((_SafeStr_570 as PetMenuView), _arg_1, _arg_2, _arg_3, 2, _arg_4);
                    };
                };
            }
            else
            {
                if (((_SafeStr_570 is AvatarMenuView) || (_SafeStr_570 is OwnAvatarMenuView)))
                {
                    if (_SafeStr_570.userName == _arg_2)
                    {
                        removeView(_SafeStr_570, false);
                    };
                };
            };
        }

        private function updateUserView(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:Boolean, _arg_6:AvatarInfoData):void
        {
            var _local_7:Boolean = (!(_arg_6 == null));
            if ((((_local_7) && (_SafeStr_570)) && (!(((((_SafeStr_570 is AvatarMenuView) || (_SafeStr_570 is OwnAvatarMenuView)) || (_SafeStr_570 is PetMenuView)) || (_SafeStr_570 is OwnPetMenuView)) || (_SafeStr_570 is RentableBotMenuView)))))
            {
                removeView(_SafeStr_570, false);
            };
            removeUseProductViews();
            if (((((((_SafeStr_570 == null) || (!(_SafeStr_570.userId == _arg_1))) || (!(_SafeStr_570.userName == _arg_2))) || (!(_SafeStr_570.roomIndex == _arg_4))) || (!(_SafeStr_570.userType == 1))) || (_arg_5)))
            {
                if (_SafeStr_570)
                {
                    removeView(_SafeStr_570, false);
                };
                if (!_SafeStr_3029)
                {
                    if (_local_7)
                    {
                        if (_arg_6.isOwnUser)
                        {
                            if (isUserDecorating)
                            {
                                return;
                            };
                            if (RoomEnterEffect.isRunning())
                            {
                                if (!_SafeStr_3902)
                                {
                                    _SafeStr_3902 = new NewUserHelpView(this);
                                };
                                _SafeStr_570 = _SafeStr_3902;
                                NewUserHelpView.setup((_SafeStr_570 as NewUserHelpView), _arg_1, _arg_2, _arg_4, 1);
                            }
                            else
                            {
                                if (!_cachedOwnAvatarMenu)
                                {
                                    _cachedOwnAvatarMenu = new OwnAvatarMenuView(this);
                                };
                                _SafeStr_570 = _cachedOwnAvatarMenu;
                                OwnAvatarMenuView.setup((_SafeStr_570 as OwnAvatarMenuView), _arg_1, _arg_2, _arg_4, 1, _arg_6);
                            };
                        }
                        else
                        {
                            if (!_SafeStr_3898)
                            {
                                _SafeStr_3898 = new AvatarMenuView(this);
                            };
                            _SafeStr_570 = _SafeStr_3898;
                            AvatarMenuView.setup((_SafeStr_570 as AvatarMenuView), _arg_1, _arg_2, _arg_4, _arg_3, _arg_6);
                            for each (var _local_8:UserNameView in _SafeStr_3903)
                            {
                                if (_local_8.userId == _arg_1)
                                {
                                    removeView(_local_8, false);
                                    break;
                                };
                            };
                        };
                    }
                    else
                    {
                        if (!handler.roomEngine.isDecorateMode)
                        {
                            if (!_SafeStr_3897)
                            {
                                _SafeStr_3897 = new AvatarContextInfoButtonView(this);
                            };
                            _SafeStr_570 = _SafeStr_3897;
                            if (handler.container.sessionDataManager.userId == _arg_1)
                            {
                                AvatarContextInfoButtonView.setup(_SafeStr_570, _arg_1, _arg_2, _arg_4, _arg_3, _arg_5);
                                if (_SafeStr_3890)
                                {
                                    _catalog.windowManager.registerHintWindow("avatar", _SafeStr_570.window);
                                    _catalog.windowManager.showHint("avatar");
                                    if (!handler.container.sessionDataManager.isNoob)
                                    {
                                        setAvatarHightlightTimer();
                                    };
                                };
                            }
                            else
                            {
                                AvatarContextInfoButtonView.setup(_SafeStr_570, _arg_1, _arg_2, _arg_4, _arg_3, _arg_5, true);
                            };
                        };
                    };
                };
            }
            else
            {
                if (((_SafeStr_570 is AvatarMenuView) || (_SafeStr_570 is OwnAvatarMenuView)))
                {
                    if (_SafeStr_570.userName == _arg_2)
                    {
                        removeView(_SafeStr_570, false);
                    };
                };
            };
        }

        public function removeView(_arg_1:ContextInfoView, _arg_2:Boolean):void
        {
            _SafeStr_3890 = false;
            removeAvatarHighlightTimer();
            if (_arg_1)
            {
                if (_SafeStr_3896)
                {
                    _arg_1.hide(_arg_2);
                }
                else
                {
                    _arg_1.dispose();
                    _SafeStr_3897 = null;
                    _SafeStr_3898 = null;
                    _cachedOwnAvatarMenu = null;
                    _SafeStr_3900 = null;
                    _SafeStr_3899 = null;
                    _SafeStr_3901 = null;
                    _SafeStr_3902 = null;
                };
                if (_arg_1 == _SafeStr_570)
                {
                    _SafeStr_570 = null;
                };
                if ((_arg_1 is UserNameView))
                {
                    _SafeStr_3903.remove((_arg_1 as UserNameView).userName);
                    _arg_1.dispose();
                    checkUpdateNeed();
                };
                if ((_arg_1 is UseProductView))
                {
                    _SafeStr_3904.remove((_arg_1 as UseProductView).userId);
                    _arg_1.dispose();
                    checkUpdateNeed();
                };
                if ((_arg_1 is BreedPetView))
                {
                    _SafeStr_3905.remove((_arg_1 as BreedPetView).userId);
                    _arg_1.dispose();
                    checkUpdateNeed();
                };
            };
        }

        public function removeUseProductViews():void
        {
            for each (var _local_1:UseProductView in _SafeStr_3904)
            {
                _local_1.dispose();
            };
            _SafeStr_3904.reset();
            checkUpdateNeed();
        }

        public function removeBreedPetViews():void
        {
            for each (var _local_1:BreedPetView in _SafeStr_3905)
            {
                _local_1.dispose();
            };
            _SafeStr_3905.reset();
            checkUpdateNeed();
        }

        public function showUserName(_arg_1:IUserData, _arg_2:int):void
        {
            var _local_3:UserNameView;
            if (_SafeStr_3903[_arg_1.name] == null)
            {
                _local_3 = new UserNameView(this);
                UserNameView.setup(_local_3, _arg_1.webID, _arg_1.name, -1, 1, _arg_2);
                _SafeStr_3903[_arg_1.name] = _local_3;
                checkUpdateNeed();
            };
        }

        public function showGamePlayerName(_arg_1:int, _arg_2:String, _arg_3:uint, _arg_4:int):void
        {
            var _local_5:UserNameView;
            if (_SafeStr_3903[_arg_2] == null)
            {
                _local_5 = new UserNameView(this, true);
                UserNameView.setup(_local_5, _arg_1, _arg_2, _arg_1, 1, _arg_1, _arg_3, _arg_4);
                _SafeStr_3903[_arg_2] = _local_5;
                checkUpdateNeed();
            };
        }

        private function showUseProductMenu(_arg_1:IUserData, _arg_2:UseProductItem):void
        {
            var _local_3:UseProductView;
            if (_SafeStr_3904[_arg_1.webID.toString()] == null)
            {
                _local_3 = new UseProductView(this);
                UseProductView.setup(_local_3, _arg_1.webID, _arg_1.name, -1, 2, _arg_2);
                _SafeStr_3904[_arg_1.webID.toString()] = _local_3;
                checkUpdateNeed();
            };
        }

        private function showBreedPetMenu(_arg_1:IUserData, _arg_2:UseProductItem):void
        {
            var _local_3:BreedPetView;
            if (_SafeStr_3905[_arg_1.webID.toString()] == null)
            {
                _local_3 = new BreedPetView(this);
                BreedPetView.setup(_local_3, _arg_1.webID, _arg_1.name, -1, 2, _arg_2, _arg_1.canBreed);
                _SafeStr_3905[_arg_1.webID.toString()] = _local_3;
                checkUpdateNeed();
            };
        }

        private function setAvatarHightlightTimer():void
        {
            _SafeStr_3891 = new Timer(5000);
            _SafeStr_3891.addEventListener("timer", onAvatarHighlightTimerEvent);
            _SafeStr_3891.start();
        }

        private function removeAvatarHighlightTimer():void
        {
            _SafeStr_3890 = false;
            _catalog.windowManager.unregisterHintWindow("avatar");
            if (!_SafeStr_3891)
            {
                return;
            };
            _SafeStr_3891.stop();
            _SafeStr_3891 = null;
        }

        private function onAvatarHighlightTimerEvent(_arg_1:TimerEvent):void
        {
            removeAvatarHighlightTimer();
        }

        public function checkUpdateNeed():void
        {
            if (!_component)
            {
                return;
            };
            if ((((((_SafeStr_570) || (_SafeStr_3903.length > 0)) || (_SafeStr_3904.length > 0)) || (_SafeStr_3905.length > 0)) || ((_SafeStr_3889) && (_SafeStr_3889.isVisible))))
            {
                _component.registerUpdateReceiver(this, 10);
            }
            else
            {
                _component.removeUpdateReceiver(this);
            };
        }

        public function update(_arg_1:uint):void
        {
            var _local_3:RoomWidgetUserLocationUpdateEvent;
            if (_SafeStr_570)
            {
                _local_3 = (messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION", _SafeStr_570.userId, _SafeStr_570.userType)) as RoomWidgetUserLocationUpdateEvent);
                if (!_local_3)
                {
                    return;
                };
                _SafeStr_570.update(_local_3.rectangle, _local_3.screenLocation, _arg_1);
            };
            if (((_SafeStr_3889) && (_SafeStr_3889.isVisible())))
            {
                _local_3 = (messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION", _SafeStr_3889.userId, _SafeStr_3889.userType)) as RoomWidgetUserLocationUpdateEvent);
                if (!_local_3)
                {
                    return;
                };
                _SafeStr_3889.update(_local_3.rectangle, _local_3.screenLocation, _arg_1);
            };
            for each (var _local_2:UserNameView in _SafeStr_3903)
            {
                if (_local_2.isGameRoomMode)
                {
                    _local_3 = (messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_GAME_OBJECT_LOCATION", _local_2.userId, _local_2.userType)) as RoomWidgetUserLocationUpdateEvent);
                }
                else
                {
                    _local_3 = (messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION", _local_2.userId, _local_2.userType)) as RoomWidgetUserLocationUpdateEvent);
                };
                if (_local_3)
                {
                    _local_2.update(_local_3.rectangle, _local_3.screenLocation, _arg_1);
                };
            };
            for each (var _local_4:UseProductView in _SafeStr_3904)
            {
                _local_3 = (messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION", _local_4.userId, _local_4.userType)) as RoomWidgetUserLocationUpdateEvent);
                if (_local_3)
                {
                    _local_4.update(_local_3.rectangle, _local_3.screenLocation, _arg_1);
                };
            };
            for each (var _local_5:BreedPetView in _SafeStr_3905)
            {
                _local_3 = (messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION", _local_5.userId, _local_5.userType)) as RoomWidgetUserLocationUpdateEvent);
                if (_local_3)
                {
                    _local_5.update(_local_3.rectangle, _local_3.screenLocation, _arg_1);
                };
            };
        }

        public function openAvatarEditor():void
        {
            handler.container.avatarEditor.openEditor(0, null, null, true);
            handler.container.avatarEditor.loadOwnAvatarInEditor(0);
        }

        public function get hasClub():Boolean
        {
            return (handler.container.sessionDataManager.hasClub);
        }

        public function get hasVip():Boolean
        {
            return (handler.container.sessionDataManager.hasVip);
        }

        public function get hasEffectOn():Boolean
        {
            var _local_1:Array = handler.container.inventory.getActivatedAvatarEffects();
            for each (var _local_2:IWidgetAvatarEffect in _local_1)
            {
                if (_local_2.isInUse)
                {
                    return (true);
                };
            };
            return (false);
        }

        public function set isDancing(_arg_1:Boolean):void
        {
            _isDancing = _arg_1;
        }

        public function get isDancing():Boolean
        {
            return (_isDancing);
        }

        public function get hasFreeSaddle():Boolean
        {
            if (_SafeStr_3894 != null)
            {
                return (_SafeStr_3894.hasFreeSaddle);
            };
            return (false);
        }

        public function get isRiding():Boolean
        {
            if (_SafeStr_3894 != null)
            {
                return (_SafeStr_3894.isRiding);
            };
            return (false);
        }

        public function get isCurrentUserRiding():Boolean
        {
            var _local_3:IRoomObjectModel;
            var _local_2:Number;
            var _local_1:IRoomObject = findCurrentUserRoomObject();
            if (_local_1 != null)
            {
                _local_3 = _local_1.getModel();
                if (_local_3 != null)
                {
                    _local_2 = _local_3.getNumber("figure_effect");
                    if (_local_2 == 77)
                    {
                        return (true);
                    };
                };
            };
            return (false);
        }

        public function openTrainingView():void
        {
            handler.container.events.dispatchEvent(new RoomWidgetUpdateEvent("RWPCUE_OPEN_PET_TRAINING"));
        }

        public function closeTrainingView():void
        {
            handler.container.events.dispatchEvent(new RoomWidgetUpdateEvent("RWPCUE_CLOSE_PET_TRAINING"));
        }

        public function get useMinimizedOwnAvatarMenu():Boolean
        {
            return (handler.container.config.getBoolean("use_minimized_own_avatar_menu"));
        }

        public function set useMinimizedOwnAvatarMenu(_arg_1:Boolean):void
        {
            handler.container.config.setProperty("use_minimized_own_avatar_menu", ((_arg_1) ? "1" : "0"));
        }

        public function sendSignRequest(_arg_1:int):void
        {
            handler.container.roomSession.sendSignMessage(_arg_1);
        }

        public function showUseProductConfirmation(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            if (!_SafeStr_3906)
            {
                _SafeStr_3906 = new UseProductConfirmationView(this);
            };
            _SafeStr_3906.open(_arg_1, _arg_2, _arg_3);
        }

        private function removeUseProductConfirmationView():void
        {
            if (_SafeStr_3906)
            {
                _SafeStr_3906.dispose();
                _SafeStr_3906 = null;
            };
        }

        public function showBreedingPetsWaitingConfirmationAlert(_arg_1:int, _arg_2:int):void
        {
            removeBreedingPetsWaitingConfirmationAlert();
            _breedingConfirmationAlert = windowManager.confirm("${breedpets.confirmation.notification.title}", "${breedpets.confirmation.notification.text}", 0, onWaitingConfirmationAlert);
            _SafeStr_3910 = _arg_1;
            _SafeStr_3911 = _arg_2;
        }

        public function onWaitingConfirmationAlert(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            if (_arg_2.type == "WE_OK")
            {
            };
            if (_arg_2.type == "WE_CANCEL")
            {
                if (((!(_SafeStr_3911 == -1)) && (!(_SafeStr_3911 == -1))))
                {
                    cancelBreedPets(_SafeStr_3910, _SafeStr_3911);
                };
            };
            removeBreedingPetsWaitingConfirmationAlert();
        }

        private function removeBreedingPetsWaitingConfirmationAlert():void
        {
            if (_breedingConfirmationAlert != null)
            {
                _breedingConfirmationAlert.dispose();
                _breedingConfirmationAlert = null;
                _SafeStr_3910 = -1;
                _SafeStr_3911 = -1;
            };
        }

        public function acceptBreedingPets(_arg_1:int, _arg_2:int):void
        {
            if (_SafeStr_3907 != null)
            {
                if (((_SafeStr_3907.requestRoomObjectId == _arg_1) && (_SafeStr_3907.targetRoomObjectId == _arg_2)))
                {
                    removeBreedMonsterPlantsConfirmationView();
                };
            };
            if (_breedingConfirmationAlert != null)
            {
                _breedingConfirmationAlert.dispose();
            };
        }

        public function cancelBreedingPets(_arg_1:int, _arg_2:int):void
        {
            if (_SafeStr_3907 != null)
            {
                if (((_SafeStr_3907.requestRoomObjectId == _arg_1) && (_SafeStr_3907.targetRoomObjectId == _arg_2)))
                {
                    removeBreedMonsterPlantsConfirmationView();
                };
            };
            removeBreedingPetsWaitingConfirmationAlert();
            windowManager.alert("${breedpets.cancel.notification.title}", "${breedpets.cancel.notification.text}", 0, onBreedingAlert);
        }

        public function onBreedingAlert(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            if (((_arg_2.type == "WE_OK") || (_arg_2.type == "WE_CANCEL")))
            {
                _arg_1.dispose();
            };
        }

        public function showBreedMonsterPlantsConfirmationView(_arg_1:int, _arg_2:int, _arg_3:Boolean):void
        {
            if (!_SafeStr_3907)
            {
                _SafeStr_3907 = new BreedMonsterPlantsConfirmationView(this);
            };
            _SafeStr_3907.open(_arg_1, _arg_2, _arg_3);
        }

        public function showConfirmPetBreedingView(_arg_1:ConfirmPetBreedingPetData, _arg_2:ConfirmPetBreedingPetData, _arg_3:int, _arg_4:Array, _arg_5:int):void
        {
            if (!_SafeStr_3908)
            {
                _SafeStr_3908 = new ConfirmPetBreedingView(this);
            };
            var _local_6:int = findPetRoomObjectIdByWebId(_arg_1.webId);
            var _local_7:int = findPetRoomObjectIdByWebId(_arg_2.webId);
            _SafeStr_3908.open(_local_6, _local_7, _arg_3, _arg_4, _arg_5, _arg_1.level, _arg_2.level);
        }

        private function removeBreedMonsterPlantsConfirmationView():void
        {
            if (_SafeStr_3907)
            {
                _SafeStr_3907.dispose();
                _SafeStr_3907 = null;
            };
        }

        private function removeConfirmPetBreedingView():void
        {
            if (_SafeStr_3908)
            {
                _SafeStr_3908.dispose();
                _SafeStr_3908 = null;
            };
        }

        public function showBreedPetsResultView(_arg_1:BreedPetsResultData, _arg_2:BreedPetsResultData):void
        {
            if (!_SafeStr_3909)
            {
                _SafeStr_3909 = new BreedPetsResultView(this);
            };
            _SafeStr_3909.open(_arg_1, _arg_2);
        }

        public function removeBreedPetsResultView(_arg_1:BreedPetsResultView):void
        {
            if (_arg_1 != null)
            {
                if (_arg_1 == _SafeStr_3909)
                {
                    _SafeStr_3909.dispose();
                    _SafeStr_3909 = null;
                }
                else
                {
                    _arg_1.dispose();
                };
            };
        }

        private function findCurrentUserRoomObject():IRoomObject
        {
            var _local_4:int;
            var _local_2:IRoomObject;
            var _local_1:IUserData;
            var _local_5:int = handler.container.sessionDataManager.userId;
            var _local_6:int = handler.roomEngine.activeRoomId;
            var _local_7:int = 100;
            var _local_3:int = handler.roomEngine.getRoomObjectCount(_local_6, _local_7);
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_2 = handler.roomEngine.getRoomObjectWithIndex(_local_6, _local_4, 100);
                if (_local_2 != null)
                {
                    _local_1 = handler.roomSession.userDataManager.getUserDataByIndex(_local_2.getId());
                    if (_local_1 != null)
                    {
                        if (_local_1.webID == _local_5)
                        {
                            return (_local_2);
                        };
                    };
                };
                _local_4++;
            };
            return (null);
        }

        internal function get isUserDecorating():Boolean
        {
            return (handler.roomSession.isUserDecorating);
        }

        internal function set isUserDecorating(_arg_1:Boolean):void
        {
            var _local_5:int;
            var _local_4:String;
            var _local_2:int;
            var _local_3:RoomWidgetUserLocationUpdateEvent;
            handler.roomSession.isUserDecorating = _arg_1;
            if (_arg_1)
            {
                _local_5 = handler.container.sessionDataManager.userId;
                if (!_SafeStr_3889)
                {
                    _local_4 = handler.container.sessionDataManager.userName;
                    _local_2 = handler.container.roomSession.ownUserRoomId;
                    _SafeStr_3889 = new DecorateModeView(this, _local_5, _local_4, _local_2);
                };
                _SafeStr_3889.show();
                _local_3 = (messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION", _local_5, 1)) as RoomWidgetUserLocationUpdateEvent);
                if (_local_3)
                {
                    _SafeStr_3889.update(_local_3.rectangle, _local_3.screenLocation, 0);
                };
            }
            else
            {
                if (_SafeStr_3889)
                {
                    _SafeStr_3889.hide(false);
                };
            };
        }

        public function get catalog():IHabboCatalog
        {
            return (_catalog);
        }

        public function isMonsterPlant():Boolean
        {
            if (_SafeStr_3894 != null)
            {
                return (_SafeStr_3894.petType == 16);
            };
            return (false);
        }

        public function cancelBreedPets(_arg_1:int, _arg_2:int):void
        {
            var _local_3:IUserData = handler.container.roomSession.userDataManager.getUserDataByIndex(_arg_1);
            var _local_4:IUserData = handler.container.roomSession.userDataManager.getUserDataByIndex(_arg_2);
            if (((_local_3) && (_local_4)))
            {
                handler.container.connection.send(new BreedPetsMessageComposer(1, _local_3.webID, _local_4.webID));
            };
        }

        public function acceptBreedPets(_arg_1:int, _arg_2:int):void
        {
            var _local_3:IUserData = handler.container.roomSession.userDataManager.getUserDataByIndex(_arg_1);
            var _local_4:IUserData = handler.container.roomSession.userDataManager.getUserDataByIndex(_arg_2);
            if (((_local_3) && (_local_4)))
            {
                handler.container.connection.send(new BreedPetsMessageComposer(2, _local_3.webID, _local_4.webID));
            };
        }

        public function breedPets(_arg_1:int, _arg_2:int):void
        {
            var _local_3:IUserData = handler.container.roomSession.userDataManager.getUserDataByIndex(_arg_1);
            var _local_4:IUserData = handler.container.roomSession.userDataManager.getUserDataByIndex(_arg_2);
            if (((_local_3) && (_local_4)))
            {
                handler.container.connection.send(new BreedPetsMessageComposer(0, _local_3.webID, _local_4.webID));
            };
        }

        public function openBotSkillConfigurationView(_arg_1:int, _arg_2:int, _arg_3:Point=null):void
        {
            if (!_SafeStr_3912.hasKey(_arg_2))
            {
                switch (_arg_2)
                {
                    case 2:
                        _SafeStr_3912.add(2, new BotChatterMarkovConfiguration(this));
                        break;
                    case 5:
                        _SafeStr_3912.add(5, new BotChangeNameConfiguration(this));
                        break;
                    default:
                        return;
                };
            };
            var _local_4:BotSkillConfigurationView = _SafeStr_3912.getValue(_arg_2);
            _local_4.open(_arg_1, _arg_3);
        }

        public function cancelPetBreeding(_arg_1:int):void
        {
            handler.container.connection.send(new CancelPetBreedingComposer(_arg_1));
        }

        public function confirmPetBreeding(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:int):void
        {
            handler.container.connection.send(new ConfirmPetBreedingComposer(_arg_1, _arg_2, _arg_3, _arg_4));
        }

        public function showNestBreedingSuccess(_arg_1:int, _arg_2:int):void
        {
            if (_SafeStr_3914 == null)
            {
                _SafeStr_3914 = new NestBreedingSuccessView(this);
            };
            var _local_3:int = findPetRoomObjectIdByWebId(_arg_1);
            (trace(_arg_1, _arg_2));
            _SafeStr_3914.open(_local_3, _arg_2);
        }

        public function get friendList():IHabboFriendList
        {
            return (handler.friendList);
        }


    }
}

