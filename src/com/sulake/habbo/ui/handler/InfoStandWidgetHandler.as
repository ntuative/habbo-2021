package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.sound.IHabboMusicController;
    import com.sulake.habbo.ui.widget.infostand.InfoStandWidget;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.RelationshipStatusInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsData;
    import flash.display.BitmapData;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.ui.widget.events.RoomWidgetChatInputContentUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomTagSearchMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetBadgeDetailsMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetBadgeImageMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPetCommandMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChangeMottoMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPresentOpenMessage;
    import com.sulake.habbo.ui.widget.infostand.InfoStandFurniData;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniActionMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.PassCarryItemMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.PassCarryItemToPetMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.GiveSupplementToPetMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.pets.RespectPetMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.DropCarryItemMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.utils.FurniId;
    import com.sulake.habbo.window.utils._SafeStr_126;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectNameEvent;
    import com.sulake.habbo.communication.messages.outgoing.room.pets.PetSelectedMessageComposer;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotInfoUpdateEvent;
    import com.sulake.habbo.friendlist.IFriend;
    import com.sulake.habbo.communication.messages.outgoing.users.GetRelationshipStatusInfoMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomModerationSettings;
    import com.sulake.habbo.sound.IPlayListController;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.room.object.data._SafeStr_80;
    import com.sulake.habbo.room.IStuffData;
    import flash.utils.getTimer;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.room._SafeStr_147;
    import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
    import com.sulake.habbo.ui.widget.events.RoomWidgetSongUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionUserBadgesEvent;
    import flash.events.Event;
    import com.sulake.habbo.session.events.RoomSessionUserFigureUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.IPetInfo;
    import com.sulake.habbo.session.events.RoomSessionPetInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetFigureUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionPetFigureUpdateEvent;
    import com.sulake.habbo.ui.widget.events.PetBreedingResultEventData;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetBreedingResultEvent;
    import com.sulake.habbo.session.events.RoomSessionPetBreedingResultEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetBreedingEvent;
    import com.sulake.habbo.session.events.RoomSessionPetBreedingEvent;
    import com.sulake.habbo.ui.widget.events.ConfirmPetBreedingPetData;
    import com.sulake.habbo.ui.widget.events.BreedingRarityCategoryData;
    import com.sulake.habbo.ui.widget.events.RoomWidgetConfirmPetBreedingEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.RarityCategoryData;
    import com.sulake.habbo.session.events.RoomSessionConfirmPetBreedingEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetConfirmPetBreedingResultEvent;
    import com.sulake.habbo.session.events.RoomSessionConfirmPetBreedingResultEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetCommandsUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionPetCommandsUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionFavouriteGroupUpdateEvent;
    import com.sulake.habbo.avatar.pets.PetFigureData;
    import com.sulake.habbo.sound.events.NowPlayingEvent;
    import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.SetObjectDataMessageComposer;

    public class InfoStandWidgetHandler implements IRoomWidgetHandler
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _SafeStr_3871:Map = new Map();
        private var _SafeStr_3735:IHabboMusicController;
        private var _SafeStr_1324:InfoStandWidget;
        private var _SafeStr_3872:IMessageEvent;
        private var _SafeStr_3873:IMessageEvent;

        public function InfoStandWidgetHandler(_arg_1:IHabboMusicController)
        {
            _SafeStr_3735 = _arg_1;
            if (_SafeStr_3735 != null)
            {
                _SafeStr_3735.events.addEventListener("NPE_SONG_CHANGED", onNowPlayingChanged);
                _SafeStr_3735.events.addEventListener("SIR_TRAX_SONG_INFO_RECEIVED", onSongInfoReceivedEvent);
            };
        }

        public function set widget(_arg_1:InfoStandWidget):void
        {
            _SafeStr_1324 = _arg_1;
        }

        public function get container():IRoomWidgetHandlerContainer
        {
            return (_container);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get type():String
        {
            return ("RWE_INFOSTAND");
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            if (_container != null)
            {
                if (_container.roomSessionManager != null)
                {
                    _container.roomSessionManager.events.removeEventListener("RSUBE_FIGURE", onFigureUpdate);
                    _container.roomSessionManager.events.removeEventListener("RSPIUE_PET_INFO", onPetInfo);
                    _container.roomSessionManager.events.removeEventListener("RSPIUE_ENABLED_PET_COMMANDS", onPetCommands);
                    _container.roomSessionManager.events.removeEventListener("rsfgue_favourite_group_update", onFavouriteGroupUpdated);
                    _container.roomSessionManager.events.removeEventListener("RSPFUE_PET_FIGURE_UPDATE", onPetFigureUpdate);
                    _container.roomSessionManager.events.removeEventListener("RSPFUE_PET_BREEDING_RESULT", onPetBreedingResult);
                    _container.roomSessionManager.events.removeEventListener("RSPFUE_PET_BREEDING", onPetBreedingEvent);
                    _container.roomSessionManager.events.removeEventListener("RSPFUE_CONFIRM_PET_BREEDING", onConfirmPetBreedingEvent);
                    _container.roomSessionManager.events.removeEventListener("RSPFUE_CONFIRM_PET_BREEDING_RESULT", onConfirmPetBreedingResultEvent);
                };
                if (_container.connection != null)
                {
                    if (_SafeStr_3872 != null)
                    {
                        _container.connection.removeMessageEvent(_SafeStr_3872);
                        _SafeStr_3872.dispose();
                        _SafeStr_3872 = null;
                    };
                    if (_SafeStr_3873 != null)
                    {
                        _container.connection.removeMessageEvent(_SafeStr_3873);
                        _SafeStr_3873.dispose();
                        _SafeStr_3873 = null;
                    };
                };
            };
            _container = _arg_1;
            if (_arg_1 == null)
            {
                return;
            };
            if (_container.roomSessionManager != null)
            {
                _container.roomSessionManager.events.addEventListener("RSUBE_FIGURE", onFigureUpdate);
                _container.roomSessionManager.events.addEventListener("RSPIUE_PET_INFO", onPetInfo);
                _container.roomSessionManager.events.addEventListener("RSPIUE_ENABLED_PET_COMMANDS", onPetCommands);
                _container.roomSessionManager.events.addEventListener("rsfgue_favourite_group_update", onFavouriteGroupUpdated);
                _container.roomSessionManager.events.addEventListener("RSPFUE_PET_FIGURE_UPDATE", onPetFigureUpdate);
                _container.roomSessionManager.events.addEventListener("RSPFUE_PET_BREEDING_RESULT", onPetBreedingResult);
                _container.roomSessionManager.events.addEventListener("RSPFUE_PET_BREEDING", onPetBreedingEvent);
                _container.roomSessionManager.events.addEventListener("RSPFUE_CONFIRM_PET_BREEDING", onConfirmPetBreedingEvent);
                _container.roomSessionManager.events.addEventListener("RSPFUE_CONFIRM_PET_BREEDING_RESULT", onConfirmPetBreedingResultEvent);
            };
            if (_container.connection)
            {
                _SafeStr_3872 = new HabboGroupDetailsMessageEvent(onGroupDetails);
                _container.connection.addMessageEvent(_SafeStr_3872);
                _SafeStr_3873 = new RelationshipStatusInfoEvent(onRelationshipStatusEvent);
                _container.connection.addMessageEvent(_SafeStr_3873);
            };
        }

        private function onGroupDetails(_arg_1:HabboGroupDetailsMessageEvent):void
        {
            var _local_2:HabboGroupDetailsData = _arg_1.data;
            if (_SafeStr_1324.furniData.groupId == _local_2.groupId)
            {
                _SafeStr_1324.furniView.groupBadgeId = _local_2.badgeCode;
                _SafeStr_1324.furniView.groupName = _local_2.groupName;
            };
        }

        public function dispose():void
        {
            var _local_1:int;
            var _local_2:BitmapData;
            if (_SafeStr_3871 != null)
            {
                _local_1 = (_SafeStr_3871.length - 1);
                while (_local_1 >= 0)
                {
                    _local_2 = _SafeStr_3871.getWithIndex(_local_1);
                    if (_local_2)
                    {
                        _local_2.dispose();
                    };
                    _local_2 = null;
                    _local_1--;
                };
                _SafeStr_3871.dispose();
                _SafeStr_3871 = null;
            };
            if (_SafeStr_3735 != null)
            {
                _SafeStr_3735.events.removeEventListener("NPE_SONG_CHANGED", onNowPlayingChanged);
                _SafeStr_3735.events.removeEventListener("SIR_TRAX_SONG_INFO_RECEIVED", onSongInfoReceivedEvent);
                _SafeStr_3735 = null;
            };
            _disposed = true;
            container = null;
        }

        public function getWidgetMessages():Array
        {
            var _local_1:Array = [];
            _local_1.push("RWROM_GET_OBJECT_INFO");
            _local_1.push("RWROM_GET_OBJECT_NAME");
            _local_1.push("RWUAM_SEND_FRIEND_REQUEST");
            _local_1.push("RWUAM_GIVE_STAR_GEM_TO_USER");
            _local_1.push("RWUAM_WHISPER_USER");
            _local_1.push("RWUAM_IGNORE_USER");
            _local_1.push("RWUAM_UNIGNORE_USER");
            _local_1.push("RWUAM_KICK_USER");
            _local_1.push("RWUAM_BAN_USER_DAY");
            _local_1.push("RWUAM_BAN_USER_HOUR");
            _local_1.push("RWUAM_BAN_USER_PERM");
            _local_1.push("RWUAM_MUTE_USER_2MIN");
            _local_1.push("RWUAM_MUTE_USER_5MIN");
            _local_1.push("RWUAM_MUTE_USER_10MIN");
            _local_1.push("RWUAM_GIVE_RIGHTS");
            _local_1.push("RWUAM_TAKE_RIGHTS");
            _local_1.push("RWUAM_START_TRADING");
            _local_1.push("RWUAM_OPEN_HOME_PAGE");
            _local_1.push("RWUAM_PASS_CARRY_ITEM");
            _local_1.push("RWUAM_GIVE_CARRY_ITEM_TO_PET");
            _local_1.push("RWUAM_DROP_CARRY_ITEM");
            _local_1.push("RWFAM_MOVE");
            _local_1.push("RWFUAM_ROTATE");
            _local_1.push("RWFAM_PICKUP");
            _local_1.push("RWFAM_EJECT");
            _local_1.push("RWFAM_USE");
            _local_1.push("RWFAM_SAVE_STUFF_DATA");
            _local_1.push("RWRTSM_ROOM_TAG_SEARCH");
            _local_1.push("RWGOI_MESSAGE_GET_BADGE_DETAILS");
            _local_1.push("RWGOI_MESSAGE_GET_BADGE_IMAGE");
            _local_1.push("RWUAM_REPORT");
            _local_1.push("RWUAM_PICKUP_PET");
            _local_1.push("RWUAM_MOUNT_PET");
            _local_1.push("RWUAM_TOGGLE_PET_RIDING_PERMISSION");
            _local_1.push("RWUAM_TOGGLE_PET_BREEDING_PERMISSION");
            _local_1.push("RWUAM_DISMOUNT_PET");
            _local_1.push("RWUAM_SADDLE_OFF");
            _local_1.push("RWUAM_TRAIN_PET");
            _local_1.push("RWPCM_PET_COMMAND");
            _local_1.push("RWPCM_REQUEST_PET_COMMANDS");
            _local_1.push(" RWUAM_RESPECT_PET");
            _local_1.push("RWUAM_REQUEST_PET_UPDATE");
            _local_1.push("RWVM_CHANGE_MOTTO_MESSAGE");
            _local_1.push("RWOPEM_OPEN_USER_PROFILE");
            _local_1.push("RWPOM_OPEN_PRESENT");
            _local_1.push("RWUAM_GIVE_LIGHT_TO_PET");
            _local_1.push("RWUAM_GIVE_WATER_TO_PET");
            _local_1.push("RWUAM_TREAT_PET");
            _local_1.push("RWUAM_REPORT_CFH_OTHER");
            _local_1.push("RWUAM_AMBASSADOR_ALERT_USER");
            _local_1.push("RWUAM_AMBASSADOR_KICK_USER");
            _local_1.push("RWUAM_AMBASSADOR_MUTE_2MIN");
            _local_1.push("RWUAM_AMBASSADOR_MUTE_10MIN");
            _local_1.push("RWUAM_AMBASSADOR_MUTE_15MIN");
            _local_1.push("RWUAM_AMBASSADOR_MUTE_60MIN");
            _local_1.push("RWUAM_AMBASSADOR_MUTE_18HOUR");
            _local_1.push("RWUAM_AMBASSADOR_MUTE_36HOUR");
            _local_1.push("RWUAM_AMBASSADOR_MUTE_72HOUR");
            _local_1.push("RWUAM_AMBASSADOR_UNMUTE");
            return (_local_1);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:IUserData;
            var _local_6:RoomWidgetChatInputContentUpdateEvent;
            var _local_3:IUserData;
            var _local_7:String;
            var _local_22:Map;
            var _local_4:Array;
            var _local_5:Array;
            var _local_12:String;
            var _local_11:String;
            var _local_25:RoomWidgetRoomTagSearchMessage;
            var _local_19:RoomWidgetGetBadgeDetailsMessage;
            var _local_15:RoomWidgetGetBadgeImageMessage;
            var _local_21:RoomWidgetPetCommandMessage;
            var _local_8:RoomWidgetPetCommandMessage;
            var _local_23:RoomWidgetChangeMottoMessage;
            var _local_16:RoomWidgetOpenProfileMessage;
            var _local_9:RoomWidgetPresentOpenMessage;
            var _local_10:InfoStandFurniData;
            if (_arg_1 == null)
            {
                return (null);
            };
            if (_container == null)
            {
                return (null);
            };
            var _local_20:int;
            var _local_14:RoomWidgetUserActionMessage = (_arg_1 as RoomWidgetUserActionMessage);
            if (_local_14 != null)
            {
                _local_20 = _local_14.userId;
                if (((((((((((((_arg_1.type == "RWUAM_REQUEST_PET_UPDATE") || (_arg_1.type == " RWUAM_RESPECT_PET")) || (_arg_1.type == "RWUAM_PICKUP_PET")) || (_arg_1.type == "RWUAM_MOUNT_PET")) || (_arg_1.type == "RWUAM_TOGGLE_PET_RIDING_PERMISSION")) || (_arg_1.type == "RWUAM_TOGGLE_PET_BREEDING_PERMISSION")) || (_arg_1.type == "RWUAM_DISMOUNT_PET")) || (_arg_1.type == "RWUAM_SADDLE_OFF")) || (_arg_1.type == "RWUAM_GIVE_CARRY_ITEM_TO_PET")) || (_arg_1.type == "RWUAM_GIVE_WATER_TO_PET")) || (_arg_1.type == "RWUAM_GIVE_LIGHT_TO_PET")) || (_arg_1.type == "RWUAM_TREAT_PET")))
                {
                    _local_2 = _container.roomSession.userDataManager.getPetUserData(_local_20);
                }
                else
                {
                    _local_2 = _container.roomSession.userDataManager.getUserData(_local_20);
                };
                if (_local_2 == null)
                {
                    return (null);
                };
            };
            var _local_17:int;
            var _local_18:int;
            var _local_24:RoomWidgetFurniActionMessage = (_arg_1 as RoomWidgetFurniActionMessage);
            if (_local_24 != null)
            {
                _local_17 = _local_24.furniId;
                _local_18 = _local_24.furniCategory;
            };
            switch (_arg_1.type)
            {
                case "RWROM_GET_OBJECT_INFO":
                    return (handleGetObjectInfoMessage((_arg_1 as RoomWidgetRoomObjectMessage)));
                case "RWROM_GET_OBJECT_NAME":
                    return (handleGetObjectNameMessage((_arg_1 as RoomWidgetRoomObjectMessage)));
                case "RWUAM_SEND_FRIEND_REQUEST":
                    _container.friendList.askForAFriend(_local_20, _local_2.name);
                    break;
                case "RWUAM_GIVE_STAR_GEM_TO_USER":
                    _container.sessionDataManager.giveStarGem(_local_20);
                    break;
                case " RWUAM_RESPECT_PET":
                    _container.sessionDataManager.givePetRespect(_local_20);
                    break;
                case "RWUAM_WHISPER_USER":
                    _local_6 = new RoomWidgetChatInputContentUpdateEvent("whisper", _local_2.name);
                    _container.events.dispatchEvent(_local_6);
                    break;
                case "RWUAM_IGNORE_USER":
                    _container.sessionDataManager.ignoreUser(_local_2.name);
                    break;
                case "RWUAM_UNIGNORE_USER":
                    _container.sessionDataManager.unignoreUser(_local_2.name);
                    break;
                case "RWUAM_KICK_USER":
                    _container.roomSession.kickUser(_local_2.webID);
                    break;
                case "RWUAM_BAN_USER_DAY":
                case "RWUAM_BAN_USER_HOUR":
                case "RWUAM_BAN_USER_PERM":
                    _container.roomSession.banUserWithDuration(_local_2.webID, _arg_1.type);
                    break;
                case "RWUAM_MUTE_USER_2MIN":
                    _container.roomSession.muteUser(_local_2.webID, 2);
                    break;
                case "RWUAM_MUTE_USER_5MIN":
                    _container.roomSession.muteUser(_local_2.webID, 5);
                    break;
                case "RWUAM_MUTE_USER_10MIN":
                    _container.roomSession.muteUser(_local_2.webID, 10);
                    break;
                case "RWUAM_GIVE_RIGHTS":
                    _container.roomSession.assignRights(_local_2.webID);
                    break;
                case "RWUAM_TAKE_RIGHTS":
                    _container.roomSession.removeRights(_local_2.webID);
                    break;
                case "RWUAM_START_TRADING":
                    _local_3 = _container.roomSession.userDataManager.getUserData(_local_14.userId);
                    _container.inventory.setupTrading(_local_3.roomObjectId, _local_3.name);
                    break;
                case "RWUAM_OPEN_HOME_PAGE":
                    _container.sessionDataManager.openHabboHomePage(_local_2.webID, _local_2.name);
                    break;
                case "RWUAM_PICKUP_PET":
                    _container.roomSession.pickUpPet(_local_20);
                    break;
                case "RWUAM_MOUNT_PET":
                    _container.roomSession.mountPet(_local_20);
                    break;
                case "RWUAM_TOGGLE_PET_RIDING_PERMISSION":
                    _container.roomSession.togglePetRidingPermission(_local_20);
                    break;
                case "RWUAM_TOGGLE_PET_BREEDING_PERMISSION":
                    _container.roomSession.togglePetBreedingPermission(_local_20);
                    break;
                case "RWUAM_DISMOUNT_PET":
                    _container.roomSession.dismountPet(_local_20);
                    break;
                case "RWUAM_SADDLE_OFF":
                    _container.roomSession.removeSaddleFromPet(_local_20);
                    break;
                case "RWUAM_PASS_CARRY_ITEM":
                    _container.connection.send(new PassCarryItemMessageComposer(_local_20));
                    break;
                case "RWUAM_GIVE_CARRY_ITEM_TO_PET":
                    _container.connection.send(new PassCarryItemToPetMessageComposer(_local_20));
                    break;
                case "RWUAM_GIVE_WATER_TO_PET":
                    _container.connection.send(new GiveSupplementToPetMessageComposer(_local_20, 0));
                    break;
                case "RWUAM_GIVE_LIGHT_TO_PET":
                    _container.connection.send(new GiveSupplementToPetMessageComposer(_local_20, 1));
                    break;
                case "RWUAM_TREAT_PET":
                    _container.connection.send(new RespectPetMessageComposer(_local_20));
                    break;
                case "RWUAM_DROP_CARRY_ITEM":
                    _container.connection.send(new DropCarryItemMessageComposer());
                    break;
                case "RWFUAM_ROTATE":
                    _container.roomEngine.modifyRoomObject(_local_17, _local_18, "OBJECT_ROTATE_POSITIVE");
                    break;
                case "RWFAM_MOVE":
                    _container.roomEngine.modifyRoomObject(_local_17, _local_18, "OBJECT_MOVE");
                    break;
                case "RWFAM_PICKUP":
                    pickupObjectWithConfirmation(_local_17, _local_18);
                    break;
                case "RWFAM_EJECT":
                    _container.roomEngine.modifyRoomObject(_local_17, _local_18, "OBJECT_EJECT");
                    break;
                case "RWFAM_USE":
                    _container.roomEngine.useRoomObjectInActiveRoom(_local_17, _local_18);
                    break;
                case "RWFAM_SAVE_STUFF_DATA":
                    _local_7 = _local_24.objectData;
                    if (_local_7 != null)
                    {
                        _local_22 = new Map();
                        _local_4 = _local_7.split("\t");
                        if (_local_4 != null)
                        {
                            for each (var _local_13:String in _local_4)
                            {
                                _local_5 = _local_13.split("=", 2);
                                if (((!(_local_5 == null)) && (_local_5.length == 2)))
                                {
                                    _local_12 = _local_5[0];
                                    _local_11 = _local_5[1];
                                    _local_22.add(_local_12, _local_11);
                                };
                            };
                        };
                        _container.roomEngine.modifyRoomObjectDataWithMap(_local_17, _local_18, "OBJECT_SAVE_STUFF_DATA", _local_22);
                        if (!_local_22.disposed)
                        {
                            _local_22.dispose();
                        };
                    };
                    break;
                case "RWUAM_REQUEST_PET_UPDATE":
                    if (((!(_container.roomSession == null)) && (!(_container.roomSession.userDataManager == null))))
                    {
                        _container.roomSession.userDataManager.requestPetInfo(_local_20);
                    };
                    break;
                case "RWRTSM_ROOM_TAG_SEARCH":
                    _local_25 = (_arg_1 as RoomWidgetRoomTagSearchMessage);
                    if (_local_25 == null)
                    {
                        return (null);
                    };
                    _container.navigator.performTagSearch(_local_25.tag);
                    break;
                case "RWGOI_MESSAGE_GET_BADGE_DETAILS":
                    _local_19 = (_arg_1 as RoomWidgetGetBadgeDetailsMessage);
                    if (_local_19 == null)
                    {
                        return (null);
                    };
                    _container.habboGroupsManager.showGroupBadgeInfo(_local_19.own, _local_19.groupId);
                    break;
                case "RWGOI_MESSAGE_GET_BADGE_IMAGE":
                    _local_15 = (_arg_1 as RoomWidgetGetBadgeImageMessage);
                    if (_local_15 == null)
                    {
                        return (null);
                    };
                    if (_SafeStr_1324 != null)
                    {
                        _SafeStr_1324.refreshBadge(_local_15.badgeId);
                    };
                    break;
                case "RWUAM_REPORT":
                    if (((_container == null) || (_container.habboHelp == null))) break;
                    if (_local_2 == null) break;
                    _container.habboHelp.reportUser(_local_20, -1, null);
                    break;
                case "RWUAM_REPORT_CFH_OTHER":
                    _container.habboHelp.reportUser(_local_20, 124, null);
                    break;
                case "RWPCM_REQUEST_PET_COMMANDS":
                    _local_21 = (_arg_1 as RoomWidgetPetCommandMessage);
                    _container.roomSession.requestPetCommands(_local_21.petId);
                    break;
                case "RWPCM_PET_COMMAND":
                    _local_8 = (_arg_1 as RoomWidgetPetCommandMessage);
                    _container.roomSession.sendChatMessage(_local_8.value);
                    break;
                case "RWVM_CHANGE_MOTTO_MESSAGE":
                    _local_23 = (_arg_1 as RoomWidgetChangeMottoMessage);
                    _container.roomSession.sendChangeMottoMessage(_local_23.motto);
                    break;
                case "RWOPEM_OPEN_USER_PROFILE":
                    _local_16 = (_arg_1 as RoomWidgetOpenProfileMessage);
                    if (_container.habboTracking)
                    {
                        _container.habboTracking.trackGoogle("extendedProfile", _local_16.trackingLocation);
                    };
                    _container.connection.send(new GetExtendedProfileMessageComposer(_local_16.userId));
                    break;
                case "RWPOM_OPEN_PRESENT":
                    _local_9 = (_arg_1 as RoomWidgetPresentOpenMessage);
                    if (((!(_local_9 == null)) && (!(_SafeStr_1324 == null))))
                    {
                        _local_10 = _SafeStr_1324.furniData;
                        if (((!(_local_10 == null)) && (_local_10.id == _local_9.objectId)))
                        {
                            if (_SafeStr_1324.isFurniViewVisible())
                            {
                                _SafeStr_1324.close();
                            };
                        };
                    };
                    break;
                case "RWUAM_AMBASSADOR_ALERT_USER":
                    _container.roomSession.ambassadorAlert(_local_2.webID);
                    break;
                case "RWUAM_AMBASSADOR_KICK_USER":
                    _container.roomSession.kickUser(_local_2.webID);
                    break;
                case "RWUAM_AMBASSADOR_MUTE_2MIN":
                    _container.roomSession.muteUser(_local_2.webID, 2);
                    break;
                case "RWUAM_AMBASSADOR_MUTE_10MIN":
                    _container.roomSession.muteUser(_local_2.webID, 10);
                    break;
                case "RWUAM_AMBASSADOR_MUTE_15MIN":
                    _container.roomSession.muteUser(_local_2.webID, 15);
                    break;
                case "RWUAM_AMBASSADOR_MUTE_60MIN":
                    _container.roomSession.muteUser(_local_2.webID, 60);
                    break;
                case "RWUAM_AMBASSADOR_MUTE_18HOUR":
                    _container.roomSession.muteUser(_local_2.webID, 1080);
                    break;
                case "RWUAM_AMBASSADOR_MUTE_36HOUR":
                    _container.roomSession.muteUser(_local_2.webID, 2160);
                    break;
                case "RWUAM_AMBASSADOR_MUTE_72HOUR":
                    _container.roomSession.muteUser(_local_2.webID, 4320);
                    break;
                case "RWUAM_AMBASSADOR_UNMUTE":
                    _container.roomSession.unmuteUser(_local_2.webID);
            };
            return (null);
        }

        private function pickupObjectWithConfirmation(_arg_1:int, _arg_2:int):void
        {
            var furniId:int = _arg_1;
            var furniCategory:int = _arg_2;
            if (_container != null)
            {
                if (((FurniId.isBuilderClubId(furniId)) && (_container.catalog.buildersClubEnabled)))
                {
                    if (_SafeStr_1324.furniData.availableForBuildersClub)
                    {
                        _container.roomEngine.modifyRoomObject(furniId, furniCategory, "OBJECT_PICKUP");
                    }
                    else
                    {
                        _container.windowManager.confirm("${generic.alert.title}", "${room.confirm.not_in_warehouse}", 0, function (_arg_1:_SafeStr_126, _arg_2:WindowEvent):void
                        {
                            _arg_1.dispose();
                            if (_arg_2.type == "WE_OK")
                            {
                                _container.roomEngine.modifyRoomObject(furniId, furniCategory, "OBJECT_PICKUP");
                            };
                        });
                    };
                }
                else
                {
                    _container.roomEngine.modifyRoomObject(furniId, furniCategory, "OBJECT_PICKUP");
                };
            };
        }

        private function handleGetObjectNameMessage(_arg_1:RoomWidgetRoomObjectMessage):RoomWidgetUpdateEvent
        {
            var _local_8:int;
            var _local_6:int;
            var _local_9:int;
            var _local_3:IRoomObject;
            var _local_4:String;
            var _local_12:int;
            var _local_10:int;
            var _local_7:IFurnitureData;
            var _local_2:IUserData;
            var _local_11:int = _container.roomSession.roomId;
            var _local_5:String;
            switch (_arg_1.category)
            {
                case 10:
                case 20:
                    if (((_container.events == null) || (_container.roomEngine == null)))
                    {
                        return (null);
                    };
                    _local_3 = _container.roomEngine.getRoomObject(_local_11, _arg_1.id, _arg_1.category);
                    _local_4 = _local_3.getType();
                    if (_local_4.indexOf("poster") == 0)
                    {
                        _local_12 = int(_local_4.replace("poster", ""));
                        _local_5 = (("${poster_" + _local_12) + "_name}");
                        _local_6 = _local_3.getId();
                        _local_9 = -1;
                    }
                    else
                    {
                        _local_10 = _local_3.getModel().getNumber("furniture_type_id");
                        if (_arg_1.category == 10)
                        {
                            _local_7 = _container.sessionDataManager.getFloorItemData(_local_10);
                        }
                        else
                        {
                            if (_arg_1.category == 20)
                            {
                                _local_7 = _container.sessionDataManager.getWallItemData(_local_10);
                            };
                        };
                        if (_local_7 == null)
                        {
                            return (null);
                        };
                        _local_5 = _local_7.localizedName;
                        _local_6 = _local_3.getId();
                        _local_9 = _local_7.id;
                    };
                    break;
                case 100:
                    if ((((((_container.roomSession == null) || (_container.sessionDataManager == null)) || (_container.events == null)) || (_container.roomEngine == null)) || (_container.friendList == null)))
                    {
                        return (null);
                    };
                    _local_2 = _container.roomSession.userDataManager.getUserDataByIndex(_arg_1.id);
                    if (_local_2 == null)
                    {
                        return (null);
                    };
                    _local_5 = _local_2.name;
                    _local_8 = _local_2.type;
                    _local_6 = _local_2.roomObjectId;
                    _local_9 = _local_2.webID;
            };
            if (_local_5 != null)
            {
                _container.events.dispatchEvent(new RoomWidgetRoomObjectNameEvent(_local_9, _arg_1.category, _local_5, _local_8, _local_6));
            };
            return (null);
        }

        private function handleGetObjectInfoMessage(_arg_1:RoomWidgetRoomObjectMessage):RoomWidgetUpdateEvent
        {
            var _local_2:IUserData;
            var _local_3:int = _container.roomSession.roomId;
            switch (_arg_1.category)
            {
                case 10:
                case 20:
                    handleGetFurniInfoMessage(_arg_1, _local_3);
                    break;
                case 100:
                    if ((((((_container.roomSession == null) || (_container.sessionDataManager == null)) || (_container.events == null)) || (_container.roomEngine == null)) || (_container.friendList == null)))
                    {
                        return (null);
                    };
                    _local_2 = _container.roomSession.userDataManager.getUserDataByIndex(_arg_1.id);
                    if (_local_2 == null)
                    {
                        return (null);
                    };
                    switch (_local_2.type)
                    {
                        case 2:
                            handleGetPetInfoMessage(_local_2.webID);
                            break;
                        case 1:
                            handleGetUserInfoMessage(_local_3, _arg_1.id, _arg_1.category, _local_2);
                            break;
                        case 3:
                            handleGetBotInfoMessage(_local_3, _arg_1.id, _arg_1.category, _local_2);
                            break;
                        case 4:
                            handleGetRentableBotInfoMessage(_local_3, _arg_1.id, _arg_1.category, _local_2);
                        default:
                    };
            };
            return (null);
        }

        private function handleGetPetInfoMessage(_arg_1:int):void
        {
            var _local_2:Boolean = container.config.getBoolean("petSelect.enabled");
            if (_local_2)
            {
                _container.connection.send(new PetSelectedMessageComposer(_arg_1));
            };
            _container.roomSession.userDataManager.requestPetInfo(_arg_1);
        }

        private function handleGetBotInfoMessage(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:IUserData):void
        {
            var _local_7:String = "RWUIUE_BOT";
            var _local_6:RoomWidgetUserInfoUpdateEvent = new RoomWidgetUserInfoUpdateEvent(_local_7);
            _local_6.name = _arg_4.name;
            _local_6.motto = _arg_4.custom;
            _local_6.webID = _arg_4.webID;
            _local_6.userRoomId = _arg_2;
            _local_6.userType = _arg_4.type;
            var _local_8:IRoomObject = _container.roomEngine.getRoomObject(_arg_1, _arg_2, _arg_3);
            if (_local_8 != null)
            {
                _local_6.carryItem = _local_8.getModel().getNumber("figure_carry_object");
            };
            _local_6.amIOwner = _container.roomSession.isRoomOwner;
            _local_6.isGuildRoom = _container.roomSession.isGuildRoom;
            _local_6.myRoomControllerLevel = _container.roomSession.roomControllerLevel;
            _local_6.amIAnyRoomController = _container.sessionDataManager.isAnyRoomController;
            _local_6.canBeKicked = _container.roomSession.isRoomOwner;
            var _local_5:Array = [];
            _local_5.push("BOT");
            _local_6.badges = _local_5;
            _local_6.figure = _arg_4.figure;
            _container.events.dispatchEvent(_local_6);
        }

        private function handleGetRentableBotInfoMessage(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:IUserData):void
        {
            var _local_6:RoomWidgetRentableBotInfoUpdateEvent = new RoomWidgetRentableBotInfoUpdateEvent();
            _local_6.name = _arg_4.name;
            _local_6.motto = _arg_4.custom;
            _local_6.webID = _arg_4.webID;
            _local_6.userRoomId = _arg_2;
            _local_6.ownerId = _arg_4.ownerId;
            _local_6.ownerName = _arg_4.ownerName;
            _local_6.botSkills = _arg_4.botSkills;
            var _local_7:IRoomObject = _container.roomEngine.getRoomObject(_arg_1, _arg_2, _arg_3);
            if (_local_7 != null)
            {
                _local_6.carryItem = _local_7.getModel().getNumber("figure_carry_object");
            };
            _local_6.amIOwner = _container.roomSession.isRoomOwner;
            _local_6.myRoomControllerLevel = _container.roomSession.roomControllerLevel;
            _local_6.amIAnyRoomController = _container.sessionDataManager.isAnyRoomController;
            var _local_5:Array = [];
            _local_5.push("BOT");
            _local_6.badges = _local_5;
            _local_6.figure = _arg_4.figure;
            _container.events.dispatchEvent(_local_6);
        }

        private function handleGetUserInfoMessage(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:IUserData):void
        {
            var _local_7:String;
            var _local_5:RoomWidgetUserInfoUpdateEvent;
            var _local_6:IFriend;
            var _local_10:Number;
            var _local_11:Boolean;
            var _local_12:int;
            var _local_8:Boolean;
            var _local_9:Boolean;
            _local_7 = "RWUIUE_OWN_USER";
            if (_arg_4.webID != _container.sessionDataManager.userId)
            {
                _local_7 = "RWUIUE_PEER";
            };
            _local_5 = new RoomWidgetUserInfoUpdateEvent(_local_7);
            _local_5.isSpectatorMode = _container.roomSession.isSpectatorMode;
            _local_5.name = _arg_4.name;
            _local_5.motto = _arg_4.custom;
            if (isActivityDisplayEnabled)
            {
                _local_5.achievementScore = _arg_4.achievementScore;
            };
            _local_5.webID = _arg_4.webID;
            _local_5.userRoomId = _arg_2;
            _local_5.userType = 1;
            var _local_13:IRoomObject = _container.roomEngine.getRoomObject(_arg_1, _arg_2, _arg_3);
            if (_local_13 != null)
            {
                _local_5.carryItem = _local_13.getModel().getNumber("figure_carry_object");
            };
            if (_local_7 == "RWUIUE_OWN_USER")
            {
                _local_5.realName = _container.sessionDataManager.realName;
                _local_5.allowNameChange = _container.sessionDataManager.nameChangeAllowed;
            };
            _local_5.amIOwner = _container.roomSession.isRoomOwner;
            _local_5.isGuildRoom = _container.roomSession.isGuildRoom;
            _local_5.myRoomControllerLevel = _container.roomSession.roomControllerLevel;
            _local_5.amIAnyRoomController = _container.sessionDataManager.isAnyRoomController;
            _local_5.amIAnAmbassador = _container.sessionDataManager.isAmbassador;
            if (_local_7 == "RWUIUE_PEER")
            {
                _local_5.canBeAskedAsFriend = _container.friendList.canBeAskedForAFriend(_arg_4.webID);
                _local_6 = _container.friendList.getFriend(_arg_4.webID);
                if (_local_6 != null)
                {
                    _local_5.realName = _local_6.realName;
                    _local_5.isFriend = true;
                };
                if (_local_13 != null)
                {
                    _local_10 = _local_13.getModel().getNumber("figure_flat_control");
                    if (!isNaN(_local_10))
                    {
                        _local_5.targetRoomControllerLevel = _local_10;
                    };
                    _local_5.canBeMuted = determineCanBeMuted(_local_5);
                    _local_5.canBeKicked = determineCanBeKicked(_local_5);
                    _local_5.canBeBanned = determineCanBeBanned(_local_5);
                    Logger.log(((((((("Set moderation levels to " + _local_5.name) + "Muted: ") + _local_5.canBeMuted) + ", Kicked: ") + _local_5.canBeKicked) + ", Banned: ") + _local_5.canBeBanned));
                };
                _local_5.isIgnored = _container.sessionDataManager.isIgnored(_arg_4.name);
                _local_5.respectLeft = _container.sessionDataManager.respectLeft;
                _local_11 = (!(_container.sessionDataManager.systemShutDown));
                _local_12 = _container.roomSession.tradeMode;
                if (!_local_11)
                {
                    _local_5.canTrade = false;
                }
                else
                {
                    switch (_local_12)
                    {
                        default:
                            _local_5.canTrade = false;
                            break;
                        case 1:
                            _local_8 = ((!(_local_5.myRoomControllerLevel == 0)) && (!(_local_5.myRoomControllerLevel == 2)));
                            _local_9 = ((!(_local_5.targetRoomControllerLevel == 0)) && (!(_local_5.targetRoomControllerLevel == 2)));
                            _local_5.canTrade = ((_local_8) || (_local_9));
                            break;
                        case 2:
                            _local_5.canTrade = true;
                    };
                };
                _local_5.canTradeReason = 0;
                if (!_local_11)
                {
                    _local_5.canTradeReason = 2;
                };
                if (_local_12 != 2)
                {
                    _local_5.canTradeReason = 3;
                };
            };
            _local_5.groupId = int(_arg_4.groupID);
            _local_5.groupBadgeId = _container.sessionDataManager.getGroupBadgeId(int(_arg_4.groupID));
            _local_5.groupName = _arg_4.groupName;
            _local_5.badges = _container.roomSession.userDataManager.getUserBadges(_arg_4.webID);
            _local_5.figure = _arg_4.figure;
            _container.events.dispatchEvent(_local_5);
            _container.habboGroupsManager.updateVisibleExtendedProfile(_arg_4.webID);
            _container.connection.send(new GetRelationshipStatusInfoMessageComposer(_arg_4.webID));
        }

        private function determineCanBeMuted(_arg_1:RoomWidgetUserInfoUpdateEvent):Boolean
        {
            var userInfo:RoomWidgetUserInfoUpdateEvent = _arg_1;
            var settingsFunction:Function = function (_arg_1:RoomWidgetUserInfoUpdateEvent, _arg_2:RoomModerationSettings):Boolean
            {
                return (checkUserWithRightsModerationLevel(_arg_1, _arg_2.whoCanMute));
            };
            return (determineModerationLevel(userInfo, settingsFunction));
        }

        private function determineCanBeKicked(_arg_1:RoomWidgetUserInfoUpdateEvent):Boolean
        {
            var userInfo:RoomWidgetUserInfoUpdateEvent = _arg_1;
            var settingsFunction:Function = function (_arg_1:RoomWidgetUserInfoUpdateEvent, _arg_2:RoomModerationSettings):Boolean
            {
                if (_arg_2.whoCanKick == 2)
                {
                    return (true);
                };
                return (checkUserWithRightsModerationLevel(_arg_1, _arg_2.whoCanKick));
            };
            return (determineModerationLevel(userInfo, settingsFunction));
        }

        private function determineCanBeBanned(_arg_1:RoomWidgetUserInfoUpdateEvent):Boolean
        {
            var userInfo:RoomWidgetUserInfoUpdateEvent = _arg_1;
            var settingsFunction:Function = function (_arg_1:RoomWidgetUserInfoUpdateEvent, _arg_2:RoomModerationSettings):Boolean
            {
                return (checkUserWithRightsModerationLevel(_arg_1, _arg_2.whoCanBan));
            };
            return (determineModerationLevel(userInfo, settingsFunction));
        }

        private function checkUserWithRightsModerationLevel(_arg_1:RoomWidgetUserInfoUpdateEvent, _arg_2:int):Boolean
        {
            var _local_3:Boolean = ((_arg_1.myRoomControllerLevel == 1) || (_arg_1.myRoomControllerLevel >= 4));
            var _local_4:Boolean = ((_arg_1.isGuildRoom) && (_arg_1.myRoomControllerLevel >= 3));
            switch (_arg_2)
            {
                case 4:
                    return (_local_4);
                case 1:
                    return (_local_3);
                case 5:
                    return ((_local_3) || (_local_4));
                default:
                    return (_arg_1.myRoomControllerLevel >= 4);
            };
        }

        private function determineModerationLevel(_arg_1:RoomWidgetUserInfoUpdateEvent, _arg_2:Function):Boolean
        {
            if (!_container.roomSession.isPrivateRoom)
            {
                return (false);
            };
            var _local_4:Boolean;
            var _local_3:RoomModerationSettings = _container.roomSession.roomModerationSettings;
            if (_local_3 != null)
            {
                _local_4 = _arg_2(_arg_1, _local_3);
            };
            return ((_local_4) && (_arg_1.targetRoomControllerLevel < 4));
        }

        private function handleGetFurniInfoMessage(_arg_1:RoomWidgetRoomObjectMessage, _arg_2:int):void
        {
            var _local_8:int;
            var _local_15:int;
            var _local_12:IFurnitureData;
            var _local_17:int;
            var _local_4:String;
            var _local_22:String;
            var _local_7:String;
            var _local_5:IPlayListController;
            var _local_19:String;
            var _local_18:ISongInfo;
            if (((_container.events == null) || (_container.roomEngine == null)))
            {
                return;
            };
            if (_arg_1.id < 0)
            {
                return;
            };
            var _local_20:RoomWidgetFurniInfoUpdateEvent = new RoomWidgetFurniInfoUpdateEvent("RWFIUE_FURNI");
            _local_20.id = _arg_1.id;
            _local_20.category = _arg_1.category;
            var _local_9:IRoomObject = _container.roomEngine.getRoomObject(_arg_2, _arg_1.id, _arg_1.category);
            if (!_local_9)
            {
                return;
            };
            var _local_14:IRoomObjectModel = _local_9.getModel();
            if (_local_14.getString("RWEIEP_INFOSTAND_EXTRA_PARAM") != null)
            {
                _local_20.extraParam = _local_14.getString("RWEIEP_INFOSTAND_EXTRA_PARAM");
            };
            var _local_16:int = _local_14.getNumber("furniture_data_format");
            var _local_10:IStuffData = _SafeStr_80.getStuffDataWrapperForType(_local_16);
            _local_10.initializeFromRoomObjectModel(_local_14);
            _local_20.stuffData = _local_10;
            var _local_11:String = _local_9.getType();
            if (_local_11.indexOf("poster") == 0)
            {
                _local_8 = int(_local_11.replace("poster", ""));
                _local_20.name = (("${poster_" + _local_8) + "_name}");
                _local_20.description = (("${poster_" + _local_8) + "_desc}");
            }
            else
            {
                _local_15 = _local_14.getNumber("furniture_type_id");
                if (_arg_1.category == 10)
                {
                    _local_12 = _container.sessionDataManager.getFloorItemData(_local_15);
                }
                else
                {
                    if (_arg_1.category == 20)
                    {
                        _local_12 = _container.sessionDataManager.getWallItemData(_local_15);
                    };
                };
                if (_local_12 != null)
                {
                    _local_20.name = _local_12.localizedName;
                    _local_20.description = _local_12.description;
                    _local_20.purchaseOfferId = _local_12.purchaseOfferId;
                    _local_20.purchaseCouldBeUsedForBuyout = _local_12.purchaseCouldBeUsedForBuyout;
                    _local_20.rentOfferId = _local_12.rentOfferId;
                    _local_20.rentCouldBeUsedForBuyout = _local_12.rentCouldBeUsedForBuyout;
                    _local_20.availableForBuildersClub = _local_12.availableForBuildersClub;
                    if (((!(_container.userDefinedRoomEvents == null)) && (_arg_1.category == 10)))
                    {
                        _container.userDefinedRoomEvents.stuffSelected(_local_9.getId(), _local_12.localizedName);
                    };
                };
            };
            if (_local_11.indexOf("post_it") > -1)
            {
                _local_20.isStickie = true;
            };
            var _local_3:int = _local_14.getNumber("furniture_expiry_time");
            var _local_21:int = _local_14.getNumber("furniture_expirty_timestamp");
            _local_20.expiration = ((_local_3 < 0) ? _local_3 : Math.max(0, (_local_3 - ((getTimer() - _local_21) / 1000))));
            var _local_13:_SafeStr_147 = _container.roomEngine.getRoomObjectImage(_arg_2, _arg_1.id, _arg_1.category, new Vector3d(180), 64, null);
            if ((((_local_13.data == null) || (_local_13.data.width > 140)) || (_local_13.data.height > 200)))
            {
                _local_13 = _container.roomEngine.getRoomObjectImage(_arg_2, _arg_1.id, _arg_1.category, new Vector3d(180), 1, null);
            };
            _local_20.image = _local_13.data;
            _local_20.isWallItem = (_arg_1.category == 20);
            _local_20.isRoomOwner = _container.roomSession.isRoomOwner;
            _local_20.roomControllerLevel = _container.roomSession.roomControllerLevel;
            _local_20.isAnyRoomController = _container.sessionDataManager.isAnyRoomController;
            _local_20.ownerId = _local_14.getNumber("furniture_owner_id");
            _local_20.ownerName = _local_14.getString("furniture_owner_name");
            _local_20.usagePolicy = _local_14.getNumber("furniture_usage_policy");
            var _local_6:int = _local_14.getNumber("furniture_guild_customized_guild_id");
            if (_local_6 != 0)
            {
                _local_20.groupId = _local_6;
                container.connection.send(new GetHabboGroupDetailsMessageComposer(_local_6, false));
            };
            if (_container.isOwnerOfFurniture(_local_9))
            {
                _local_20.isOwner = true;
            };
            _container.events.dispatchEvent(_local_20);
            if (((!(_local_20.extraParam == null)) && (_local_20.extraParam.length > 0)))
            {
                _local_17 = -1;
                _local_4 = "";
                _local_22 = "";
                _local_7 = "";
                if (_local_20.extraParam == "RWEIEP_JUKEBOX")
                {
                    _local_5 = _SafeStr_3735.getRoomItemPlaylist();
                    if (_local_5 != null)
                    {
                        _local_17 = _local_5.nowPlayingSongId;
                        _local_7 = "RWSUE_PLAYING_CHANGED";
                    };
                }
                else
                {
                    if (_local_20.extraParam.indexOf("RWEIEP_SONGDISK") == 0)
                    {
                        _local_19 = _local_20.extraParam.substr("RWEIEP_SONGDISK".length);
                        _local_17 = parseInt(_local_19);
                        _local_7 = "RWSUE_DATA_RECEIVED";
                    };
                };
                if (_local_17 != -1)
                {
                    _local_18 = _SafeStr_3735.getSongInfo(_local_17);
                    if (_local_18 != null)
                    {
                        _local_4 = _local_18.name;
                        _local_22 = _local_18.creator;
                    };
                    _container.events.dispatchEvent(new RoomWidgetSongUpdateEvent(_local_7, _local_17, _local_4, _local_22));
                };
            };
        }

        public function getProcessedEvents():Array
        {
            return (["RSUBE_BADGES"]);
        }

        public function processEvent(_arg_1:Event):void
        {
            var _local_2:RoomSessionUserBadgesEvent;
            switch (_arg_1.type)
            {
                case "RSUBE_BADGES":
                    _local_2 = (_arg_1 as RoomSessionUserBadgesEvent);
                    if (((!(_local_2 == null)) && (!(_SafeStr_1324 == null))))
                    {
                        _SafeStr_1324.refreshBadges(_local_2.userId, _local_2.badges);
                    };
                    return;
            };
        }

        private function onFigureUpdate(_arg_1:RoomSessionUserFigureUpdateEvent):void
        {
            if (_container == null)
            {
                return;
            };
            if (_arg_1 == null)
            {
                return;
            };
            if (_arg_1.userId < 0)
            {
                return;
            };
            var _local_2:IUserData = _container.roomSession.userDataManager.getUserDataByIndex(_arg_1.userId);
            if (_local_2 == null)
            {
                return;
            };
            var _local_5:int = _local_2.webID;
            var _local_3:BitmapData;
            var _local_4:Boolean = (_local_5 == _container.sessionDataManager.userId);
            _SafeStr_1324.updateUserData(_local_5, _arg_1.figure, _arg_1.achievementScore, _arg_1.customInfo, _local_4);
        }

        private function onPetInfo(_arg_1:RoomSessionPetInfoUpdateEvent):void
        {
            var _local_4:Boolean;
            var _local_6:RoomWidgetPetInfoUpdateEvent;
            var _local_12:IRoomSession;
            var _local_5:IPetInfo = _arg_1.petInfo;
            if (_local_5 == null)
            {
                return;
            };
            var _local_10:IUserData = _container.roomSession.userDataManager.getPetUserData(_local_5.petId);
            if (_local_10 == null)
            {
                return;
            };
            var _local_2:String = _local_10.figure;
            var _local_8:int = getPetType(_local_2);
            var _local_9:int = getPetRace(_local_2);
            var _local_7:String;
            if (_local_8 == 16)
            {
                if (_local_5.level >= _local_5.adultLevel)
                {
                    _local_7 = "std";
                }
                else
                {
                    _local_7 = ("grw" + _local_5.level);
                };
            };
            var _local_3:String = (_local_2 + ((_local_7 != null) ? ("/posture=" + _local_7) : ""));
            var _local_11:BitmapData = (_SafeStr_3871.getValue(_local_3) as BitmapData);
            if (_local_11 == null)
            {
                _local_11 = getPetImage(_local_2, _local_7);
                _SafeStr_3871.add(_local_3, _local_11);
            };
            if (((!(_container == null)) && (!(_container.events == null))))
            {
                _local_4 = (_local_5.ownerId == _container.sessionDataManager.userId);
                _local_6 = new RoomWidgetPetInfoUpdateEvent(_local_8, _local_9, _local_10.name, _local_5.petId, _local_11, _local_4, _local_5.ownerId, _local_5.ownerName, _local_10.roomObjectId, _local_5.breedId);
                _local_6.level = _local_5.level;
                _local_6.levelMax = _local_5.levelMax;
                _local_6.experience = _local_5.experience;
                _local_6.experienceMax = _local_5.experienceMax;
                _local_6.energy = _local_5.energy;
                _local_6.energyMax = _local_5.energyMax;
                _local_6.nutrition = _local_5.nutrition;
                _local_6.nutritionMax = _local_5.nutritionMax;
                _local_6.petRespect = _local_5.respect;
                _local_6.petRespectLeft = _container.sessionDataManager.petRespectLeft;
                _local_6.age = _local_5.age;
                _local_6.hasFreeSaddle = _local_5.hasFreeSaddle;
                _local_6.isRiding = _local_5.isRiding;
                _local_6.canBreed = _local_5.canBreed;
                _local_6.canHarvest = _local_5.canHarvest;
                _local_6.canRevive = _local_5.canRevive;
                _local_6.rarityLevel = _local_5.rarityLevel;
                _local_6.skillTresholds = _local_5.skillTresholds;
                _local_6.canRemovePet = false;
                _local_6.accessRights = _local_5.accessRights;
                _local_6.maxWellBeingSeconds = _local_5.maxWellBeingSeconds;
                _local_6.remainingWellBeingSeconds = _local_5.remainingWellBeingSeconds;
                _local_6.remainingGrowingSeconds = _local_5.remainingGrowingSeconds;
                _local_6.hasBreedingPermission = _local_5.hasBreedingPermission;
                _local_12 = _container.roomSession;
                if (_local_4)
                {
                    _local_6.canRemovePet = true;
                }
                else
                {
                    if ((((_local_12.isRoomOwner) || (_container.sessionDataManager.isAnyRoomController)) || (_local_12.roomControllerLevel >= 1)))
                    {
                        _local_6.canRemovePet = true;
                    };
                };
                _container.events.dispatchEvent(_local_6);
            };
        }

        private function onPetFigureUpdate(_arg_1:RoomSessionPetFigureUpdateEvent):void
        {
            var _local_3:RoomWidgetPetFigureUpdateEvent;
            var _local_2:String = _arg_1.figure;
            var _local_4:BitmapData = (_SafeStr_3871.getValue(_local_2) as BitmapData);
            if (_local_4 == null)
            {
                _local_4 = getPetImage(_local_2);
                _SafeStr_3871.add(_local_2, _local_4);
            };
            if (((!(_container == null)) && (!(_container.events == null))))
            {
                _local_3 = new RoomWidgetPetFigureUpdateEvent(_arg_1.petId, _local_4);
                _container.events.dispatchEvent(_local_3);
            };
        }

        private function onPetBreedingResult(_arg_1:RoomSessionPetBreedingResultEvent):void
        {
            var _local_3:PetBreedingResultEventData;
            var _local_4:PetBreedingResultEventData;
            var _local_2:RoomWidgetPetBreedingResultEvent;
            if (((!(_container == null)) && (!(_container.events == null))))
            {
                _local_3 = new PetBreedingResultEventData();
                _local_3.stuffId = _arg_1.resultData.stuffId;
                _local_3.classId = _arg_1.resultData.classId;
                _local_3.productCode = _arg_1.resultData.productCode;
                _local_3.userId = _arg_1.resultData.userId;
                _local_3.userName = _arg_1.resultData.userName;
                _local_3.rarityLevel = _arg_1.resultData.rarityLevel;
                _local_3.hasMutation = _arg_1.resultData.hasMutation;
                _local_4 = new PetBreedingResultEventData();
                _local_4.stuffId = _arg_1.otherResultData.stuffId;
                _local_4.classId = _arg_1.otherResultData.classId;
                _local_4.productCode = _arg_1.otherResultData.productCode;
                _local_4.userId = _arg_1.otherResultData.userId;
                _local_4.userName = _arg_1.otherResultData.userName;
                _local_4.rarityLevel = _arg_1.otherResultData.rarityLevel;
                _local_4.hasMutation = _arg_1.otherResultData.hasMutation;
                _local_2 = new RoomWidgetPetBreedingResultEvent(_local_3, _local_4);
                _container.events.dispatchEvent(_local_2);
            };
        }

        private function onPetBreedingEvent(_arg_1:RoomSessionPetBreedingEvent):void
        {
            var _local_2:RoomWidgetPetBreedingEvent;
            if (((!(_container == null)) && (!(_container.events == null))))
            {
                _local_2 = new RoomWidgetPetBreedingEvent();
                _local_2.state = _arg_1.state;
                _local_2.ownPetId = _arg_1.ownPetId;
                _local_2.otherPetId = _arg_1.otherPetId;
                _container.events.dispatchEvent(_local_2);
            };
        }

        private function onConfirmPetBreedingEvent(_arg_1:RoomSessionConfirmPetBreedingEvent):void
        {
            var _local_4:ConfirmPetBreedingPetData;
            var _local_3:ConfirmPetBreedingPetData;
            var _local_6:Array;
            var _local_5:BreedingRarityCategoryData;
            var _local_7:RoomWidgetConfirmPetBreedingEvent;
            if (((!(_container == null)) && (!(_container.events == null))))
            {
                _local_4 = new ConfirmPetBreedingPetData();
                _local_4.webId = _arg_1.pet1.webId;
                _local_4.name = _arg_1.pet1.name;
                _local_4.level = _arg_1.pet1.level;
                _local_4.figure = _arg_1.pet1.figure;
                _local_4.owner = _arg_1.pet1.owner;
                _local_3 = new ConfirmPetBreedingPetData();
                _local_3.webId = _arg_1.pet2.webId;
                _local_3.name = _arg_1.pet2.name;
                _local_3.level = _arg_1.pet2.level;
                _local_3.figure = _arg_1.pet2.figure;
                _local_3.owner = _arg_1.pet2.owner;
                _local_6 = [];
                for each (var _local_2:RarityCategoryData in _arg_1.rarityCategories)
                {
                    _local_5 = new BreedingRarityCategoryData();
                    _local_5.chance = _local_2.chance;
                    _local_5.breeds = _local_2.breeds.concat();
                    _local_6.push(_local_5);
                };
                _local_7 = new RoomWidgetConfirmPetBreedingEvent(_arg_1.nestId, _local_4, _local_3, _local_6, _arg_1.resultPetTypeId);
                _container.events.dispatchEvent(_local_7);
            };
        }

        private function onConfirmPetBreedingResultEvent(_arg_1:RoomSessionConfirmPetBreedingResultEvent):void
        {
            var _local_2:RoomWidgetConfirmPetBreedingResultEvent;
            if (((!(_container == null)) && (!(_container.events == null))))
            {
                _local_2 = new RoomWidgetConfirmPetBreedingResultEvent(_arg_1.breedingNestStuffId, _arg_1.result);
                _container.events.dispatchEvent(_local_2);
            };
        }

        private function onPetCommands(_arg_1:RoomSessionPetCommandsUpdateEvent):void
        {
            var _local_2:RoomWidgetPetCommandsUpdateEvent;
            if (((!(_container == null)) && (!(_container.events == null))))
            {
                _local_2 = new RoomWidgetPetCommandsUpdateEvent(_arg_1.petId, _arg_1.allCommands, _arg_1.enabledCommands);
                _container.events.dispatchEvent(_local_2);
            };
        }

        private function onFavouriteGroupUpdated(_arg_1:RoomSessionFavouriteGroupUpdateEvent):void
        {
            if (_SafeStr_1324)
            {
                _SafeStr_1324.favouriteGroupUpdated(_arg_1.roomIndex, _arg_1.habboGroupId, _arg_1.status, _arg_1.habboGroupName);
            };
        }

        public function update():void
        {
        }

        private function getPetImage(_arg_1:String, _arg_2:String=null):BitmapData
        {
            var _local_4:BitmapData;
            var _local_3:PetFigureData = new PetFigureData(_arg_1);
            var _local_5:uint;
            var _local_6:_SafeStr_147 = _container.roomEngine.getPetImage(_local_3.typeId, _local_3.paletteId, _local_3.color, new Vector3d(90), 64, null, true, _local_5, _local_3.customParts, _arg_2);
            if (_local_6 != null)
            {
                _local_4 = _local_6.data;
            };
            if (_local_4 == null)
            {
                _local_4 = new BitmapData(30, 30, false, 4289374890);
            };
            return (_local_4);
        }

        private function getPetType(_arg_1:String):int
        {
            return (getSpaceSeparatedInteger(_arg_1, 0));
        }

        private function getPetRace(_arg_1:String):int
        {
            return (getSpaceSeparatedInteger(_arg_1, 1));
        }

        private function getPetColor(_arg_1:String):int
        {
            var _local_2:Array = _arg_1.split(" ");
            if (_local_2.length > 2)
            {
                return (parseInt(_local_2[2], 16));
            };
            return (0xFFFFFF);
        }

        private function getSpaceSeparatedInteger(_arg_1:String, _arg_2:int):int
        {
            var _local_3:Array;
            if (_arg_1 != null)
            {
                _local_3 = _arg_1.split(" ");
                if (_local_3.length > _arg_2)
                {
                    return (_local_3[_arg_2]);
                };
            };
            return (-1);
        }

        private function onNowPlayingChanged(_arg_1:NowPlayingEvent):void
        {
            var _local_3:int;
            var _local_2:String;
            var _local_5:String;
            var _local_4:ISongInfo;
            if (_SafeStr_3735 != null)
            {
                _local_3 = _arg_1.id;
                _local_2 = "";
                _local_5 = "";
                if (_local_3 != -1)
                {
                    _local_4 = _SafeStr_3735.getSongInfo(_local_3);
                    if (_local_4 != null)
                    {
                        _local_2 = _local_4.name;
                        _local_5 = _local_4.creator;
                    };
                };
                _container.events.dispatchEvent(new RoomWidgetSongUpdateEvent("RWSUE_PLAYING_CHANGED", _local_3, _local_2, _local_5));
            };
        }

        private function onSongInfoReceivedEvent(_arg_1:SongInfoReceivedEvent):void
        {
            var _local_2:ISongInfo;
            if (_SafeStr_3735 != null)
            {
                _local_2 = _SafeStr_3735.getSongInfo(_arg_1.id);
                if (_local_2 != null)
                {
                    _container.events.dispatchEvent(new RoomWidgetSongUpdateEvent("RWSUE_DATA_RECEIVED", _arg_1.id, _local_2.name, _local_2.creator));
                };
            };
        }

        private function onRelationshipStatusEvent(_arg_1:RelationshipStatusInfoEvent):void
        {
            if (((_SafeStr_1324) && (_SafeStr_1324.mainWindow.visible)))
            {
                _SafeStr_1324.setRelationshipStatus(_arg_1.userId, _arg_1.relationshipStatusMap);
            };
        }

        public function get isActivityDisplayEnabled():Boolean
        {
            return (((!(_container == null)) && (_container.config)) && (_container.config.getBoolean("activity.point.display.enabled")));
        }

        public function setObjectData(_arg_1:Map):void
        {
            if (_container.sessionDataManager.hasSecurity(5))
            {
                _container.connection.send(new SetObjectDataMessageComposer(_SafeStr_1324.furniData.id, _arg_1));
            };
        }


    }
}