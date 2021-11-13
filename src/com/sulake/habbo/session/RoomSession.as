package com.sulake.habbo.session
{
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomModerationSettings;
    import com.sulake.habbo.communication.messages.outgoing.room.session.OpenFlatConnectionMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.game.arena.Game2GameChatMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.chat.ChatMessageComposer;
    import flash.utils.getTimer;
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.ChangeMottoMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.chat.ShoutMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.chat.WhisperMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.chat._SafeStr_52;
    import com.sulake.habbo.communication.messages.outgoing.room.chat._SafeStr_45;
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.AvatarExpressionMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.SignMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.DanceMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.ChangePostureMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.CreditFurniRedeemMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.PresentOpenMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.OpenPetPackageMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture._SafeStr_37;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.RoomDimmerSavePresetMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture._SafeStr_34;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.poll.PollStartComposer;
    import com.sulake.habbo.communication.messages.outgoing.poll.PollRejectComposer;
    import com.sulake.habbo.communication.messages.outgoing.poll.PollAnswerComposer;
    import com.sulake.habbo.communication.messages.outgoing.userclassification.PeerUsersClassificationMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.userclassification.RoomUsersClassificationMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.VisitUserMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.AmbassadorAlertMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.KickUserMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.BanUserWithDurationMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.MuteUserMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.UnmuteUserMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.AssignRightsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.RemoveRightsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.LetUserInMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.RemovePetFromFlatMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.MountPetMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.TogglePetRidingPermissionMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.TogglePetBreedingPermissionMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.RemoveSaddleFromPetMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.HarvestPetMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.CompostPlantMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.GetPetCommandsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.pets.CustomizePetWithFurniComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.nux.NewUserExperienceScriptProceedComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.session._SafeStr_23;
    import com.sulake.habbo.communication.messages.outgoing.room.session.ChangeQueueMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.SetClothingChangeDataMessageComposer;

    public class RoomSession implements IRoomSession
    {

        private const CHAT_LAG_WARNING_LIMIT:int = 2500;

        private var _connection:IConnection;
        private var _roomId:int = 0;
        private var _roomPassword:String = "";
        private var _roomResources:String = "";
        private var _openConnectionComposer:IMessageComposer = null;
        private var _state:String = "RSE_CREATED";
        private var _SafeStr_3709:UserDataManager;
        private var _ownUserRoomId:int = -1;
        private var _areBotsAllowed:Boolean = false;
        private var _roomControllerLevel:int = 0;
        private var _tradeMode:int = 0;
        private var _isGuildRoom:Boolean = false;
        private var _isSpectatorMode:Boolean = false;
        private var _arePetsAllowed:Boolean = false;
        private var _SafeStr_3710:int;
        private var _SafeStr_3711:Map = new Map();
        private var _SafeStr_1920:int = 0;
        private var _habboTracking:IHabboTracking = null;
        private var _isUserDecorating:Boolean = false;
        private var _isGameSession:Boolean = false;
        private var _isNuxNotComplete:Boolean = false;
        private var _roomModerationSettings:RoomModerationSettings = null;

        public function RoomSession()
        {
            _SafeStr_3709 = new UserDataManager();
        }

        public function set connection(_arg_1:IConnection):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _connection = _arg_1;
            if (_SafeStr_3709 != null)
            {
                _SafeStr_3709.connection = _arg_1;
            };
        }

        public function dispose():void
        {
            _connection = null;
            if (_SafeStr_3709 != null)
            {
                _SafeStr_3709.dispose();
                _SafeStr_3709 = null;
            };
            if (_SafeStr_3711 != null)
            {
                _SafeStr_3711.dispose();
                _SafeStr_3711 = null;
            };
            if (_openConnectionComposer)
            {
                _openConnectionComposer.dispose();
                _openConnectionComposer = null;
            };
            if (_roomModerationSettings != null)
            {
                _roomModerationSettings = null;
            };
        }

        public function get roomId():int
        {
            return (_roomId);
        }

        public function set roomId(_arg_1:int):void
        {
            _roomId = _arg_1;
        }

        public function get roomPassword():String
        {
            return (_roomPassword);
        }

        public function set roomPassword(_arg_1:String):void
        {
            _roomPassword = _arg_1;
        }

        public function get roomResources():String
        {
            return (_roomResources);
        }

        public function set roomResources(_arg_1:String):void
        {
            _roomResources = _arg_1;
        }

        public function get openConnectionComposer():IMessageComposer
        {
            return (_openConnectionComposer);
        }

        public function set openConnectionComposer(_arg_1:IMessageComposer):void
        {
            _openConnectionComposer = _arg_1;
        }

        public function get state():String
        {
            return (_state);
        }

        public function get habboTracking():IHabboTracking
        {
            return (_habboTracking);
        }

        public function set habboTracking(_arg_1:IHabboTracking):void
        {
            _habboTracking = _arg_1;
        }

        public function get isGameSession():Boolean
        {
            return (_isGameSession);
        }

        public function set isGameSession(_arg_1:Boolean):void
        {
            _isGameSession = _arg_1;
        }

        public function get roomModerationSettings():RoomModerationSettings
        {
            return (_roomModerationSettings);
        }

        public function set roomModerationSettings(_arg_1:RoomModerationSettings):void
        {
            _roomModerationSettings = _arg_1;
        }

        public function trackEventLogOncePerSession(_arg_1:String, _arg_2:String, _arg_3:String):void
        {
            _habboTracking.trackEventLogOncePerSession(_arg_1, _arg_2, _arg_3);
        }

        public function start():Boolean
        {
            if (((_state == "RSE_CREATED") && (!(_connection == null))))
            {
                _state = "RSE_STARTED";
                if (_openConnectionComposer)
                {
                    return (sendPredefinedOpenConnection());
                };
                return (sendOpenFlatConnectionMessage());
            };
            return (false);
        }

        public function reset(_arg_1:int):void
        {
            if (_arg_1 != _roomId)
            {
                _roomId = _arg_1;
                _areBotsAllowed = false;
                _roomControllerLevel = 0;
                _tradeMode = 0;
                _isSpectatorMode = false;
            };
        }

        private function sendOpenFlatConnectionMessage():Boolean
        {
            if (_connection == null)
            {
                return (false);
            };
            _connection.send(new OpenFlatConnectionMessageComposer(_roomId, _roomPassword));
            return (true);
        }

        private function sendPredefinedOpenConnection():Boolean
        {
            if (_connection == null)
            {
                return (false);
            };
            _connection.send(_openConnectionComposer);
            _openConnectionComposer = null;
            return (true);
        }

        public function sendChatMessage(_arg_1:String, _arg_2:int=0):void
        {
            if (_isGameSession)
            {
                _connection.send(new Game2GameChatMessageComposer(_arg_1));
            }
            else
            {
                _arg_1 = _arg_1.replace(/&#[0-9]+;/g, "");
                _connection.send(new ChatMessageComposer(_arg_1, _arg_2, _SafeStr_1920));
                _SafeStr_3711.add(_SafeStr_1920, getTimer());
                _SafeStr_1920++;
            };
        }

        public function sendChangeMottoMessage(_arg_1:String):void
        {
            _connection.send(new ChangeMottoMessageComposer(_arg_1));
        }

        public function receivedChatWithTrackingId(_arg_1:int):void
        {
            var _local_3:int;
            var _local_2:Object = _SafeStr_3711.remove(_arg_1);
            if (_local_2 != null)
            {
                _local_3 = getTimer();
                if ((_local_3 - Number(_local_2)) > 2500)
                {
                    if (_habboTracking != null)
                    {
                        _habboTracking.chatLagDetected(_local_3);
                    };
                };
            };
        }

        public function sendShoutMessage(_arg_1:String, _arg_2:int=0):void
        {
            _connection.send(new ShoutMessageComposer(_arg_1, _arg_2));
        }

        public function sendWhisperMessage(_arg_1:String, _arg_2:String, _arg_3:int=0):void
        {
            _connection.send(new WhisperMessageComposer(_arg_1, _arg_2, _arg_3));
        }

        public function sendChatTypingMessage(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                _connection.send(new _SafeStr_52());
            }
            else
            {
                _connection.send(new _SafeStr_45());
            };
        }

        public function sendAvatarExpressionMessage(_arg_1:int):void
        {
            _connection.send(new AvatarExpressionMessageComposer(_arg_1));
        }

        public function sendSignMessage(_arg_1:int):void
        {
            if (((_arg_1 >= 0) && (_arg_1 <= 17)))
            {
                _connection.send(new SignMessageComposer(_arg_1));
            };
        }

        public function sendDanceMessage(_arg_1:int):void
        {
            _connection.send(new DanceMessageComposer(_arg_1));
        }

        public function sendChangePostureMessage(_arg_1:int):void
        {
            _connection.send(new ChangePostureMessageComposer(_arg_1));
        }

        public function sendCreditFurniRedeemMessage(_arg_1:int):void
        {
            _connection.send(new CreditFurniRedeemMessageComposer(_arg_1));
        }

        public function sendPresentOpenMessage(_arg_1:int):void
        {
            _connection.send(new PresentOpenMessageComposer(_arg_1));
        }

        public function sendOpenPetPackageMessage(_arg_1:int, _arg_2:String):void
        {
            _connection.send(new OpenPetPackageMessageComposer(_arg_1, _arg_2));
        }

        public function sendRoomDimmerGetPresetsMessage():void
        {
            _connection.send(new _SafeStr_37());
        }

        public function sendRoomDimmerSavePresetMessage(_arg_1:int, _arg_2:int, _arg_3:uint, _arg_4:int, _arg_5:Boolean):void
        {
            var _local_6:String = ("000000" + _arg_3.toString(16).toUpperCase());
            var _local_7:String = ("#" + _local_6.substr((_local_6.length - 6)));
            _connection.send(new RoomDimmerSavePresetMessageComposer(_arg_1, _arg_2, _local_7, _arg_4, _arg_5));
        }

        public function sendRoomDimmerChangeStateMessage():void
        {
            _connection.send(new _SafeStr_34());
        }

        public function sendConversionPoint(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String=null, _arg_5:int=0):void
        {
            _connection.send(new EventLogMessageComposer(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5));
        }

        public function sendPollStartMessage(_arg_1:int):void
        {
            _connection.send(new PollStartComposer(_arg_1));
        }

        public function sendPollRejectMessage(_arg_1:int):void
        {
            _connection.send(new PollRejectComposer(_arg_1));
        }

        public function sendPollAnswerMessage(_arg_1:int, _arg_2:int, _arg_3:Array):void
        {
            _connection.send(new PollAnswerComposer(_arg_1, _arg_2, _arg_3));
        }

        public function sendPeerUsersClassificationMessage(_arg_1:String):void
        {
            _connection.send(new PeerUsersClassificationMessageComposer(_arg_1));
        }

        public function sendRoomUsersClassificationMessage(_arg_1:String):void
        {
            _connection.send(new RoomUsersClassificationMessageComposer(_arg_1));
        }

        public function sendVisitFlatMessage(_arg_1:int):void
        {
            _connection.send(new OpenFlatConnectionMessageComposer(_arg_1));
        }

        public function sendVisitUserMessage(_arg_1:String):void
        {
            _connection.send(new VisitUserMessageComposer(_arg_1));
        }

        public function ambassadorAlert(_arg_1:int):void
        {
            _connection.send(new AmbassadorAlertMessageComposer(_arg_1));
        }

        public function kickUser(_arg_1:int):void
        {
            _connection.send(new KickUserMessageComposer(_arg_1));
        }

        public function banUserWithDuration(_arg_1:int, _arg_2:String):void
        {
            _connection.send(new BanUserWithDurationMessageComposer(_arg_1, _arg_2, roomId));
        }

        public function muteUser(_arg_1:int, _arg_2:int):void
        {
            _connection.send(new MuteUserMessageComposer(_arg_1, _arg_2, roomId));
        }

        public function unmuteUser(_arg_1:int):void
        {
            _connection.send(new UnmuteUserMessageComposer(_arg_1, roomId));
        }

        public function assignRights(_arg_1:int):void
        {
            _connection.send(new AssignRightsMessageComposer(_arg_1));
        }

        public function removeRights(_arg_1:int):void
        {
            var _local_3:Array = [];
            _local_3.push(_arg_1);
            var _local_2:RemoveRightsMessageComposer = new RemoveRightsMessageComposer(_local_3);
            _connection.send(_local_2);
        }

        public function letUserIn(_arg_1:String, _arg_2:Boolean):void
        {
            _connection.send(new LetUserInMessageComposer(_arg_1, _arg_2));
        }

        public function pickUpPet(_arg_1:int):void
        {
            _connection.send(new RemovePetFromFlatMessageComposer(_arg_1));
        }

        public function mountPet(_arg_1:int):void
        {
            _connection.send(new MountPetMessageComposer(_arg_1, true));
        }

        public function togglePetRidingPermission(_arg_1:int):void
        {
            _connection.send(new TogglePetRidingPermissionMessageComposer(_arg_1));
        }

        public function togglePetBreedingPermission(_arg_1:int):void
        {
            _connection.send(new TogglePetBreedingPermissionMessageComposer(_arg_1));
        }

        public function dismountPet(_arg_1:int):void
        {
            _connection.send(new MountPetMessageComposer(_arg_1, false));
        }

        public function removeSaddleFromPet(_arg_1:int):void
        {
            _connection.send(new RemoveSaddleFromPetMessageComposer(_arg_1));
        }

        public function harvestPet(_arg_1:int):void
        {
            _connection.send(new HarvestPetMessageComposer(_arg_1));
        }

        public function compostPlant(_arg_1:int):void
        {
            _connection.send(new CompostPlantMessageComposer(_arg_1));
        }

        public function requestPetCommands(_arg_1:int):void
        {
            _connection.send(new GetPetCommandsMessageComposer(_arg_1));
        }

        public function useProductForPet(_arg_1:int, _arg_2:int):void
        {
            _connection.send(new CustomizePetWithFurniComposer(_arg_1, _arg_2));
        }

        public function plantSeed(_arg_1:int):void
        {
            _connection.send(new UseFurnitureMessageComposer(_arg_1));
        }

        public function sendScriptProceed():void
        {
            _connection.send(new NewUserExperienceScriptProceedComposer());
        }

        public function quit():void
        {
            if (_connection != null)
            {
                _connection.send(new _SafeStr_23());
            };
        }

        public function changeQueue(_arg_1:int):void
        {
            if (_connection == null)
            {
                return;
            };
            _connection.send(new ChangeQueueMessageComposer(_arg_1));
        }

        public function sendUpdateClothingChangeFurniture(_arg_1:int, _arg_2:String, _arg_3:String):void
        {
            if (_connection == null)
            {
                return;
            };
            var _local_4:SetClothingChangeDataMessageComposer = new SetClothingChangeDataMessageComposer(_arg_1, _arg_2, _arg_3);
            _connection.send(_local_4);
            _local_4.dispose();
            _local_4 = null;
        }

        public function get userDataManager():IUserDataManager
        {
            return (_SafeStr_3709 as IUserDataManager);
        }

        public function get ownUserRoomId():int
        {
            return (_ownUserRoomId);
        }

        public function set ownUserRoomId(_arg_1:int):void
        {
            _ownUserRoomId = _arg_1;
        }

        public function set isRoomOwner(_arg_1:Boolean):void
        {
            _areBotsAllowed = _arg_1;
        }

        public function get isRoomOwner():Boolean
        {
            return (_areBotsAllowed);
        }

        public function set roomControllerLevel(_arg_1:int):void
        {
            if (((_arg_1 >= 0) && (_arg_1 <= 5)))
            {
                _roomControllerLevel = _arg_1;
            }
            else
            {
                Logger.log((("Invalid roomControllerLevel " + _arg_1) + ", setting to ROOM_CONTROL_LEVEL_NONE instead"));
                _roomControllerLevel = 0;
            };
        }

        public function get roomControllerLevel():int
        {
            return (_roomControllerLevel);
        }

        public function get tradeMode():int
        {
            return (_tradeMode);
        }

        public function get isPrivateRoom():Boolean
        {
            return (true);
        }

        public function set tradeMode(_arg_1:int):void
        {
            _tradeMode = _arg_1;
        }

        public function get isGuildRoom():Boolean
        {
            return (_isGuildRoom);
        }

        public function set isGuildRoom(_arg_1:Boolean):void
        {
            _isGuildRoom = _arg_1;
        }

        public function get isNoobRoom():Boolean
        {
            return (_SafeStr_3710 == 4);
        }

        public function set doorMode(_arg_1:int):void
        {
            _SafeStr_3710 = _arg_1;
        }

        public function get isSpectatorMode():Boolean
        {
            return (_isSpectatorMode);
        }

        public function set isSpectatorMode(_arg_1:Boolean):void
        {
            _isSpectatorMode = _arg_1;
        }

        public function get arePetsAllowed():Boolean
        {
            return (_arePetsAllowed);
        }

        public function set arePetsAllowed(_arg_1:Boolean):void
        {
            _arePetsAllowed = _arg_1;
        }

        public function get areBotsAllowed():Boolean
        {
            return (_areBotsAllowed);
        }

        public function get isUserDecorating():Boolean
        {
            return (_isUserDecorating);
        }

        public function set isUserDecorating(_arg_1:Boolean):void
        {
            _isUserDecorating = _arg_1;
        }

        public function get isNuxNotComplete():Boolean
        {
            return (_isNuxNotComplete);
        }

        public function set isNuxNotComplete(_arg_1:Boolean):void
        {
            _isNuxNotComplete = _arg_1;
        }


    }
}