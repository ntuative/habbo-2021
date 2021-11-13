package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.room.engine.UsersMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserRemoveMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HabboUserBadgesMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.DoorbellMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.UserNameChangedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetCommandsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetPlacingErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetFigureUpdateEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetBreedingResultEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetBreedingEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetStatusUpdateEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetLevelUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.ConfirmBreedingRequestEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.ConfirmBreedingResultEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.NestBreedingSuccessEvent;
    import com.sulake.habbo.communication.messages.parser.room.bots.BotErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.NewFriendRequestEvent;
    import com.sulake.habbo.communication.messages.parser.room.action.DanceMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.FavoriteMembershipUpdateMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.session.events.RoomSessionFavouriteGroupUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.FavouriteMembershipUpdateMessageParser;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserMessageData;
    import com.sulake.habbo.session.UserData;
    import com.sulake.habbo.communication.messages.parser.room.engine.UsersMessageParser;
    import __AS3__.vec.Vector;
    import com.sulake.room.utils.RoomShakingEffect;
    import com.sulake.habbo.session.events.RoomSessionUserDataUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.UserRemoveMessageParser;
    import com.sulake.habbo.session.events.RoomSessionUserBadgesEvent;
    import com.sulake.habbo.session.events.RoomSessionDoorbellEvent;
    import com.sulake.habbo.session.events.RoomSessionUserFigureUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.users.UserNameChangedMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetInfoMessageParser;
    import com.sulake.habbo.session.PetInfo;
    import com.sulake.habbo.session.events.RoomSessionPetInfoUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetFigureUpdateMessageParser;
    import com.sulake.habbo.session.events.RoomSessionPetFigureUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetBreedingResultMessageParser;
    import com.sulake.habbo.session.events.RoomSessionPetBreedingResultEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.ConfirmBreedingRequestParser;
    import com.sulake.habbo.session.events.RoomSessionConfirmPetBreedingEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.ConfirmBreedingResultParser;
    import com.sulake.habbo.session.events.RoomSessionConfirmPetBreedingResultEvent;
    import com.sulake.habbo.session.events.RoomSessionNestBreedingSuccessEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetBreedingMessageParser;
    import com.sulake.habbo.session.events.RoomSessionPetBreedingEvent;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetStatusUpdateMessageParser;
    import com.sulake.habbo.session.events.RoomSessionPetStatusUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetLevelUpdateMessageParser;
    import com.sulake.habbo.session.events.RoomSessionPetLevelUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetCommandsMessageParser;
    import com.sulake.habbo.session.events.RoomSessionPetCommandsUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionErrorMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.NewFriendRequestMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;
    import com.sulake.habbo.session.events.RoomSessionFriendRequestEvent;
    import com.sulake.habbo.communication.messages.parser.room.action.DanceMessageParser;
    import com.sulake.habbo.session.events.RoomSessionDanceEvent;

    public class RoomUsersHandler extends BaseHandler 
    {

        public function RoomUsersHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addMessageEvent(new UsersMessageEvent(onUsers));
            _arg_1.addMessageEvent(new UserRemoveMessageEvent(onUserRemove));
            _arg_1.addMessageEvent(new HabboUserBadgesMessageEvent(onUserBadges));
            _arg_1.addMessageEvent(new DoorbellMessageEvent(onDoorbell));
            _arg_1.addMessageEvent(new UserChangeMessageEvent(onUserChange));
            _arg_1.addMessageEvent(new UserNameChangedMessageEvent(onUserNameChange));
            _arg_1.addMessageEvent(new PetInfoMessageEvent(onPetInfo));
            _arg_1.addMessageEvent(new PetCommandsMessageEvent(onEnabledPetCommands));
            _arg_1.addMessageEvent(new PetPlacingErrorEvent(onPetPlacingError));
            _arg_1.addMessageEvent(new PetFigureUpdateEvent(onPetFigureUpdate));
            _arg_1.addMessageEvent(new PetBreedingResultEvent(onPetBreedingResult));
            _arg_1.addMessageEvent(new PetBreedingEvent(onPetBreedingEvent));
            _arg_1.addMessageEvent(new PetStatusUpdateEvent(onPetStatusUpdate));
            _arg_1.addMessageEvent(new PetLevelUpdateEvent(onPetLevelUpdate));
            _arg_1.addMessageEvent(new ConfirmBreedingRequestEvent(onConfirmPetBreeding));
            _arg_1.addMessageEvent(new ConfirmBreedingResultEvent(onConfirmPetBreedingResult));
            _arg_1.addMessageEvent(new NestBreedingSuccessEvent(onNestBreedingSuccess));
            _arg_1.addMessageEvent(new BotErrorEvent(onBotError));
            _arg_1.addMessageEvent(new NewFriendRequestEvent(onFriendRequest));
            _arg_1.addMessageEvent(new DanceMessageEvent(onDance));
            _arg_1.addMessageEvent(new FavoriteMembershipUpdateMessageEvent(onFavoriteMembershipUpdate));
        }

        private function onFavoriteMembershipUpdate(_arg_1:IMessageEvent):void
        {
            var _local_5:RoomSessionFavouriteGroupUpdateEvent;
            var _local_3:FavouriteMembershipUpdateMessageParser = FavoriteMembershipUpdateMessageEvent(_arg_1).getParser();
            var _local_4:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_4 == null)
            {
                return;
            };
            var _local_2:IUserData = _local_4.userDataManager.getUserDataByIndex(_local_3.roomIndex);
            if (_local_2 == null)
            {
                return;
            };
            _local_2.groupID = ("" + _local_3.habboGroupId);
            _local_2.groupName = _local_3.habboGroupName;
            if (((listener) && (listener.events)))
            {
                _local_5 = new RoomSessionFavouriteGroupUpdateEvent(_local_4, _local_3.roomIndex, _local_3.habboGroupId, _local_3.status, _local_3.habboGroupName);
                listener.events.dispatchEvent(_local_5);
            };
        }

        private function onUsers(_arg_1:IMessageEvent):void
        {
            var _local_4:int;
            var _local_8:UserMessageData;
            var _local_2:UserData;
            var _local_9:UsersMessageEvent = (_arg_1 as UsersMessageEvent);
            if (_local_9 == null)
            {
                return;
            };
            var _local_3:UsersMessageParser = _local_9.getParser();
            var _local_5:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_5 == null)
            {
                return;
            };
            var _local_6:Boolean;
            var _local_7:Vector.<IUserData> = new Vector.<IUserData>(0);
            _local_4 = 0;
            while (_local_4 < _local_3.getUserCount())
            {
                _local_8 = _local_3.getUser(_local_4);
                _local_2 = new UserData(_local_8.roomIndex);
                _local_2.name = _local_8.name;
                _local_2.custom = _local_8.custom;
                _local_2.achievementScore = _local_8.achievementScore;
                _local_2.figure = _local_8.figure;
                _local_2.type = _local_8.userType;
                _local_2.webID = _local_8.webID;
                _local_2.groupID = _local_8.groupID;
                _local_2.groupName = _local_8.groupName;
                _local_2.groupStatus = _local_8.groupStatus;
                _local_2.sex = _local_8.sex;
                _local_2.ownerId = _local_8.ownerId;
                _local_2.ownerName = _local_8.ownerName;
                _local_2.rarityLevel = _local_8.rarityLevel;
                _local_2.hasSaddle = _local_8.hasSaddle;
                _local_2.isRiding = _local_8.isRiding;
                _local_2.canBreed = _local_8.canBreed;
                _local_2.canHarvest = _local_8.canHarvest;
                _local_2.canRevive = _local_8.canRevive;
                _local_2.hasBreedingPermission = _local_8.hasBreedingPermission;
                _local_2.petLevel = _local_8.petLevel;
                _local_2.botSkills = _local_8.botSkills;
                _local_2.isModerator = _local_8.isModerator;
                if ((((_local_8.userType == 4) && (_local_8.ownerId == -1)) && (_local_8.name == "Macklebee")))
                {
                    _local_6 = true;
                };
                if (_local_5.userDataManager.getUserData(_local_8.roomIndex) == null)
                {
                    _local_7.push(_local_2);
                };
                _local_5.userDataManager.setUserData(_local_2);
                _local_4++;
            };
            if (_local_6)
            {
                RoomShakingEffect.init(250, 5000);
                RoomShakingEffect.turnVisualizationOn();
            };
            listener.events.dispatchEvent(new RoomSessionUserDataUpdateEvent(_local_5, _local_7));
        }

        private function onUserRemove(_arg_1:IMessageEvent):void
        {
            var _local_4:UserRemoveMessageEvent = (_arg_1 as UserRemoveMessageEvent);
            if (_local_4 == null)
            {
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:int = (_local_4.getParser() as UserRemoveMessageParser).id;
            _local_3.userDataManager.removeUserDataByRoomIndex(_local_2);
        }

        private function onUserBadges(_arg_1:IMessageEvent):void
        {
            var _local_2:HabboUserBadgesMessageEvent = (_arg_1 as HabboUserBadgesMessageEvent);
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_3 == null)
            {
                return;
            };
            _local_3.userDataManager.setUserBadges(_local_2.userId, _local_2.badges);
            listener.events.dispatchEvent(new RoomSessionUserBadgesEvent(_local_3, _local_2.userId, _local_2.badges));
        }

        private function onDoorbell(_arg_1:IMessageEvent):void
        {
            var _local_2:DoorbellMessageEvent = (_arg_1 as DoorbellMessageEvent);
            if (_local_2 == null)
            {
                return;
            };
            if (_local_2.userName == "")
            {
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_3 == null)
            {
                return;
            };
            listener.events.dispatchEvent(new RoomSessionDoorbellEvent("RSDE_DOORBELL", _local_3, _local_2.userName));
        }

        private function onUserChange(_arg_1:IMessageEvent):void
        {
            var _local_3:UserChangeMessageEvent = (_arg_1 as UserChangeMessageEvent);
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_2 == null)
            {
                return;
            };
            if (_local_3.id >= 0)
            {
                _local_2.userDataManager.updateFigure(_local_3.id, _local_3.figure, _local_3.sex, false, false);
                _local_2.userDataManager.updateCustom(_local_3.id, _local_3.customInfo);
                _local_2.userDataManager.updateAchievementScore(_local_3.id, _local_3.achievementScore);
                listener.events.dispatchEvent(new RoomSessionUserFigureUpdateEvent(_local_2, _local_3.id, _local_3.figure, _local_3.sex, _local_3.customInfo, _local_3.achievementScore));
            };
        }

        private function onUserNameChange(_arg_1:IMessageEvent):void
        {
            var _local_2:UserNameChangedMessageEvent = (_arg_1 as UserNameChangedMessageEvent);
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:UserNameChangedMessageParser = _local_2.getParser();
            var _local_4:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_4 == null)
            {
                return;
            };
            _local_4.userDataManager.updateNameByIndex(_local_3.id, _local_3.newName);
        }

        private function onPetInfo(_arg_1:IMessageEvent):void
        {
            var _local_5:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_5 == null)
            {
                return;
            };
            var _local_3:PetInfoMessageEvent = (_arg_1 as PetInfoMessageEvent);
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:PetInfoMessageParser = _local_3.getParser();
            var _local_4:PetInfo = new PetInfo();
            _local_4.petId = _local_2.petId;
            _local_4.level = _local_2.level;
            _local_4.levelMax = _local_2.maxLevel;
            _local_4.experience = _local_2.experience;
            _local_4.experienceMax = _local_2.experienceRequiredToLevel;
            _local_4.energy = _local_2.energy;
            _local_4.energyMax = _local_2.maxEnergy;
            _local_4.nutrition = _local_2.nutrition;
            _local_4.nutritionMax = _local_2.maxNutrition;
            _local_4.ownerId = _local_2.ownerId;
            _local_4.ownerName = _local_2.ownerName;
            _local_4.respect = _local_2.respect;
            _local_4.age = _local_2.age;
            _local_4.breedId = _local_2.breedId;
            _local_4.hasFreeSaddle = _local_2.hasFreeSaddle;
            _local_4.isRiding = _local_2.isRiding;
            _local_4.canBreed = _local_2.canBreed;
            _local_4.canHarvest = _local_2.canHarvest;
            _local_4.rarityLevel = _local_2.rarityLevel;
            _local_4.canRevive = _local_2.canRevive;
            _local_4.skillTresholds = _local_2.skillTresholds;
            _local_4.accessRights = _local_2.accessRights;
            _local_4.maxWellBeingSeconds = _local_2.maxWellBeingSeconds;
            _local_4.remainingWellBeingSeconds = _local_2.remainingWellBeingSeconds;
            _local_4.remainingGrowingSeconds = _local_2.remainingGrowingSeconds;
            _local_4.hasBreedingPermission = _local_2.hasBreedingPermission;
            listener.events.dispatchEvent(new RoomSessionPetInfoUpdateEvent(_local_5, _local_4));
        }

        private function onPetFigureUpdate(_arg_1:IMessageEvent):void
        {
            var _local_7:PetFigureUpdateEvent = (_arg_1 as PetFigureUpdateEvent);
            if (_local_7 == null)
            {
                return;
            };
            var _local_5:PetFigureUpdateMessageParser = _local_7.getParser();
            var _local_6:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_6 == null)
            {
                return;
            };
            var _local_8:String = _local_5.figureData.figureString;
            var _local_9:int = _local_5.roomIndex;
            var _local_3:int = _local_5.petId;
            var _local_2:Boolean = _local_5.hasSaddle;
            var _local_4:Boolean = _local_5.isRiding;
            _local_6.userDataManager.updateFigure(_local_9, _local_8, "", _local_2, _local_4);
            listener.events.dispatchEvent(new RoomSessionPetFigureUpdateEvent(_local_6, _local_3, _local_8));
        }

        private function onPetBreedingResult(_arg_1:IMessageEvent):void
        {
            var _local_2:PetBreedingResultEvent = (_arg_1 as PetBreedingResultEvent);
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:PetBreedingResultMessageParser = _local_2.getParser();
            var _local_4:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_4 == null)
            {
                return;
            };
            listener.events.dispatchEvent(new RoomSessionPetBreedingResultEvent(_local_4, _local_3.resultData, _local_3.otherResultData));
        }

        private function onConfirmPetBreeding(_arg_1:ConfirmBreedingRequestEvent):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            var _local_2:ConfirmBreedingRequestParser = (_arg_1.parser as ConfirmBreedingRequestParser);
            var _local_3:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_3 == null)
            {
                return;
            };
            listener.events.dispatchEvent(new RoomSessionConfirmPetBreedingEvent(_local_3, _local_2.nestId, _local_2.pet1, _local_2.pet2, _local_2.rarityCategories, _local_2.resultPetType));
        }

        private function onConfirmPetBreedingResult(_arg_1:ConfirmBreedingResultEvent):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            var _local_2:ConfirmBreedingResultParser = (_arg_1.parser as ConfirmBreedingResultParser);
            var _local_3:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_3 == null)
            {
                return;
            };
            listener.events.dispatchEvent(new RoomSessionConfirmPetBreedingResultEvent(_local_3, _local_2.breedingNestStuffId, _local_2.result));
        }

        private function onNestBreedingSuccess(_arg_1:NestBreedingSuccessEvent):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            var _local_2:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_2 == null)
            {
                return;
            };
            listener.events.dispatchEvent(new RoomSessionNestBreedingSuccessEvent(_local_2, _arg_1.getParser().petId, _arg_1.getParser().rarityCategory));
        }

        private function onPetBreedingEvent(_arg_1:IMessageEvent):void
        {
            var _local_4:PetBreedingEvent = (_arg_1 as PetBreedingEvent);
            if (_local_4 == null)
            {
                return;
            };
            var _local_2:PetBreedingMessageParser = _local_4.getParser();
            var _local_3:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_3 == null)
            {
                return;
            };
            listener.events.dispatchEvent(new RoomSessionPetBreedingEvent(_local_3, _local_2.state, _local_2.ownPetId, _local_2.otherPetId));
        }

        private function onPetStatusUpdate(_arg_1:IMessageEvent):void
        {
            var _local_8:PetStatusUpdateEvent = (_arg_1 as PetStatusUpdateEvent);
            if (_local_8 == null)
            {
                return;
            };
            var _local_4:PetStatusUpdateMessageParser = _local_8.getParser();
            var _local_5:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_5 == null)
            {
                return;
            };
            var _local_9:int = _local_4.roomIndex;
            var _local_2:int = _local_4.petId;
            var _local_3:Boolean = _local_4.canHarvest;
            var _local_10:Boolean = _local_4.canRevive;
            var _local_7:Boolean = _local_4.canBreed;
            var _local_6:Boolean = _local_4.hasBreedingPermission;
            _local_5.userDataManager.updatePetBreedingStatus(_local_9, _local_7, _local_3, _local_10, _local_6);
            listener.events.dispatchEvent(new RoomSessionPetStatusUpdateEvent(_local_5, _local_2, _local_7, _local_3, _local_10, _local_6));
        }

        private function onPetLevelUpdate(_arg_1:IMessageEvent):void
        {
            var _local_2:PetLevelUpdateEvent = (_arg_1 as PetLevelUpdateEvent);
            if (_local_2 == null)
            {
                return;
            };
            var _local_4:PetLevelUpdateMessageParser = _local_2.getParser();
            var _local_6:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_6 == null)
            {
                return;
            };
            var _local_7:int = _local_4.roomIndex;
            var _local_3:int = _local_4.petId;
            var _local_5:int = _local_4.level;
            _local_6.userDataManager.updatePetLevel(_local_7, _local_5);
            listener.events.dispatchEvent(new RoomSessionPetLevelUpdateEvent(_local_6, _local_3, _local_5));
        }

        private function onEnabledPetCommands(_arg_1:IMessageEvent):void
        {
            var _local_4:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_4 == null)
            {
                return;
            };
            var _local_2:PetCommandsMessageEvent = (_arg_1 as PetCommandsMessageEvent);
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:PetCommandsMessageParser = _local_2.getParser();
            if (_local_3 != null)
            {
                listener.events.dispatchEvent(new RoomSessionPetCommandsUpdateEvent(_local_4, _local_3.petId, _local_3.allCommands, _local_3.enabledCommands));
            };
        }

        private function onPetPlacingError(_arg_1:PetPlacingErrorEvent):void
        {
            var _local_3:String;
            if (((_arg_1 == null) || (_arg_1.getParser() == null)))
            {
                return;
            };
            var _local_2:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_2 == null)
            {
                return;
            };
            switch (_arg_1.getParser().errorCode)
            {
                case 0:
                    _local_3 = "RSEME_PETS_FORBIDDEN_IN_HOTEL";
                    break;
                case 1:
                    _local_3 = "RSEME_PETS_FORBIDDEN_IN_FLAT";
                    break;
                case 2:
                    _local_3 = "RSEME_MAX_PETS";
                    break;
                case 3:
                    _local_3 = "RSEME_NO_FREE_TILES_FOR_PET";
                    break;
                case 4:
                    _local_3 = "RSEME_SELECTED_TILE_NOT_FREE_FOR_PET";
                    break;
                case 5:
                    _local_3 = "RSEME_MAX_NUMBER_OF_OWN_PETS";
                default:
            };
            if (_local_3 != null)
            {
                listener.events.dispatchEvent(new RoomSessionErrorMessageEvent(_local_3, _local_2));
            };
        }

        private function onBotError(_arg_1:BotErrorEvent):void
        {
            var _local_3:String;
            if (((_arg_1 == null) || (_arg_1.getParser() == null)))
            {
                return;
            };
            var _local_2:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_2 == null)
            {
                return;
            };
            switch (_arg_1.getParser().errorCode)
            {
                case 0:
                    _local_3 = "RSEME_BOTS_FORBIDDEN_IN_HOTEL";
                    break;
                case 1:
                    _local_3 = "RSEME_BOTS_FORBIDDEN_IN_FLAT";
                    break;
                case 2:
                    _local_3 = "RSEME_BOT_LIMIT_REACHED";
                    break;
                case 3:
                    _local_3 = "RSEME_SELECTED_TILE_NOT_FREE_FOR_BOT";
                    break;
                case 4:
                    _local_3 = "RSEME_BOT_NAME_NOT_ACCEPTED";
                default:
            };
            if (_local_3 != null)
            {
                listener.events.dispatchEvent(new RoomSessionErrorMessageEvent(_local_3, _local_2));
            };
        }

        private function onFriendRequest(_arg_1:NewFriendRequestEvent):void
        {
            if ((((!(_arg_1)) || (!(listener))) || (!(listener.events))))
            {
                return;
            };
            var _local_2:NewFriendRequestMessageParser = _arg_1.getParser();
            if (!_local_2)
            {
                return;
            };
            var _local_4:IRoomSession = listener.getSession(_SafeStr_586);
            if (!_local_4)
            {
                return;
            };
            var _local_3:FriendRequestData = _local_2.req;
            if (!_local_3)
            {
                return;
            };
            listener.events.dispatchEvent(new RoomSessionFriendRequestEvent(_local_4, _local_3.requestId, _local_3.requestId, _local_3.requesterName));
        }

        private function onDance(_arg_1:DanceMessageEvent):void
        {
            var _local_2:DanceMessageParser = _arg_1.getParser();
            var _local_3:IRoomSession = listener.getSession(_SafeStr_586);
            listener.events.dispatchEvent(new RoomSessionDanceEvent(_local_3, _local_2.userId, _local_2.danceStyle));
        }


    }
}

