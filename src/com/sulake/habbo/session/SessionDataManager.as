package com.sulake.habbo.session
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import flash.utils.Dictionary;
    import com.sulake.habbo.session.product.ProductDataParser;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.session.furniture.FurnitureDataParser;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import flash.utils.Timer;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import __AS3__.vec.Vector;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.availability.AvailabilityStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.avatar.FigureUpdateEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.NoobnessLevelMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.incoming.users.AccountSafetyLockStatusChangeMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.EmailStatusResultEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPublishedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;
    import com.sulake.habbo.communication.messages.parser.preferences.AccountPreferencesEvent;
    import com.sulake.habbo.communication.messages.incoming.users.UserNameChangedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.InClientLinkMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetRespectFailedEvent;
    import com.sulake.habbo.communication.messages.parser.mysterybox.MysteryBoxKeysMessageEvent;
    import com.sulake.habbo.session.furniture.IFurniDataListener;
    import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.communication.messages.parser.users.UserNameChangedMessageParser;
    import com.sulake.habbo.session.events.UserNameUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.avatar.ChangeUserNameResultMessageParser;
    import com.sulake.habbo.communication.messages.parser.mysterybox.MysteryBoxKeysMessageParser;
    import com.sulake.habbo.session.events.MysteryBoxKeysUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.preferences.AccountPreferencesParser;
    import com.sulake.habbo.session.events.SessionDataPreferencesEvent;
    import com.sulake.habbo.communication.messages.parser.users.EmailStatusParser;
    import com.sulake.habbo.communication.messages.parser.availability.AvailabilityStatusMessageParser;
    import com.sulake.habbo.communication.messages.parser.users.AccountSafetyLockStatusChangeMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.preferences.SetUIFlagsMessageComposer;
    import flash.display.BitmapData;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.GiveStarGemToUserMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.vault.CreditVaultStatusMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.vault.IncomeRewardStatusMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.vault.WithdrawCreditVaultMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.vault.IncomeRewardClaimMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.pets.RespectPetMessageComposer;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.window.utils._SafeStr_126;
    import com.sulake.habbo.session.product.IProductDataListener;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.room.chat.ChatMessageComposer;
    import flash.events.TimerEvent;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.iid.*;

    public class SessionDataManager extends Component implements ISessionDataManager
    {

        public static const _SafeStr_1416:uint = 1;

        private var _communication:IHabboCommunicationManager;
        private var _windowManager:IHabboWindowManager;
        private var _roomSessionManager:IRoomSessionManager;
        private var _SafeStr_497:PerkManager;
        private var _userId:int;
        private var _userName:String;
        private var _figure:String;
        private var _gender:String;
        private var _realName:String;
        private var _SafeStr_2025:int = 0;
        private var _respectLeft:int = 0;
        private var _petRespectLeft:int = 0;
        private var _nameChangeAllowed:Boolean = true;
        private var _SafeStr_3713:Array;
        private var _systemOpen:Boolean;
        private var _systemShutDown:Boolean;
        private var _isAuthenticHabbo:Boolean;
        private var _SafeStr_501:Dictionary;
        private var _SafeStr_499:ProductDataParser;
        private var _floorItems:Map;
        private var _wallItems:Map;
        private var _SafeStr_496:Map;
        private var _SafeStr_498:FurnitureDataParser;
        private var _SafeStr_500:BadgeImageManager;
        private var _SafeStr_508:HabboGroupInfoManager;
        private var _SafeStr_504:IgnoredUsersManager;
        private var _localization:IHabboLocalizationManager;
        private var _SafeStr_510:Boolean = false;
        private var _productDataListeners:Array;
        private var _furniDataListeners:Array;
        private var _clubLevel:int;
        private var _SafeStr_507:int;
        private var _topSecurityLevel:int = 0;
        private var _SafeStr_503:int = -1;
        private var _isAmbassador:Boolean;
        private var _isEmailVerified:Boolean;
        private var _isRoomCameraFollowDisabled:Boolean;
        private var _uiFlags:int;
        private var _SafeStr_509:Boolean = false;
        private var _mysteryBoxColor:String;
        private var _mysteryKeyColor:String;
        private var _SafeStr_506:Boolean = false;
        private var _SafeStr_502:Boolean = false;
        private var _SafeStr_511:Timer = null;
        private var _newFurniDataHash:String = null;

        public function SessionDataManager(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(), function (_arg_1:IHabboWindowManager):void
            {
                _windowManager = _arg_1;
            }, false), new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communication = _arg_1;
            }, ((flags & 0x01) == 0)), new ComponentDependency(new IIDHabboConfigurationManager(), null, true, [{
                "type":"complete",
                "callback":onConfigurationComplete
            }]), new ComponentDependency(new IIDHabboLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                _localization = _arg_1;
            }), new ComponentDependency(new IIDHabboRoomSessionManager(), function (_arg_1:IRoomSessionManager):void
            {
                _roomSessionManager = _arg_1;
            }, false)]));
        }

        private function onConfigurationComplete(_arg_1:Event):void
        {
            _SafeStr_501 = new Dictionary();
            _floorItems = new Map();
            _wallItems = new Map();
            _SafeStr_496 = new Map();
            initFurnitureData();
            initProductData();
            initBadgeImageManager();
        }

        override protected function initComponent():void
        {
            if (_communication)
            {
                _communication.addHabboConnectionMessageEvent((new RoomReadyMessageEvent(onRoomReady) as IMessageEvent));
                _communication.addHabboConnectionMessageEvent(new AvailabilityStatusMessageEvent(onAvailabilityStatus));
                _communication.addHabboConnectionMessageEvent(new UserRightsMessageEvent(onUserRights));
                _communication.addHabboConnectionMessageEvent(new ChangeUserNameResultMessageEvent(onChangeUserNameResult));
                _communication.addHabboConnectionMessageEvent(new FigureUpdateEvent(onFigureUpdate));
                _communication.addHabboConnectionMessageEvent(new NoobnessLevelMessageEvent(onNoobnessLevelEvent));
                _communication.addHabboConnectionMessageEvent(new UserObjectEvent(onUserObject));
                _communication.addHabboConnectionMessageEvent(new AccountSafetyLockStatusChangeMessageEvent(onAccountSafetyLockStatusChanged));
                _communication.addHabboConnectionMessageEvent(new EmailStatusResultEvent(onEmailStatus));
                _communication.addHabboConnectionMessageEvent(new CatalogPublishedMessageEvent(onCatalogPublished));
                _communication.addHabboConnectionMessageEvent(new UserChangeMessageEvent(onUserChange));
                _communication.addHabboConnectionMessageEvent(new AccountPreferencesEvent(onAccountPreferences));
                _communication.addHabboConnectionMessageEvent(new UserNameChangedMessageEvent(onUserNameChange));
                _communication.addHabboConnectionMessageEvent(new InClientLinkMessageEvent(onInClientLink));
                _communication.addHabboConnectionMessageEvent(new PetRespectFailedEvent(onPetRespectFailed));
                _communication.addHabboConnectionMessageEvent(new MysteryBoxKeysMessageEvent(onMysteryBoxKeys));
            };
            _SafeStr_3713 = [];
            _SafeStr_508 = new HabboGroupInfoManager(this);
            _SafeStr_504 = new IgnoredUsersManager(this);
            _SafeStr_497 = new PerkManager(this);
            _productDataListeners = [];
            _furniDataListeners = [];
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            if (_floorItems)
            {
                _floorItems.dispose();
                _floorItems = null;
            };
            if (_SafeStr_496)
            {
                _SafeStr_496.dispose();
                _SafeStr_496 = null;
            };
            if (_SafeStr_497)
            {
                _SafeStr_497.dispose();
                _SafeStr_497 = null;
            };
            _furniDataListeners = null;
            if (_SafeStr_498)
            {
                _SafeStr_498.removeEventListener("FDP_furniture_data_ready", onFurnitureReady);
                _SafeStr_498.dispose();
                _SafeStr_498 = null;
            };
            if (_SafeStr_499)
            {
                _SafeStr_499.removeEventListener("PDP_product_data_ready", onProductsReady);
                _SafeStr_499.dispose();
                _SafeStr_499 = null;
            };
            super.dispose();
        }

        private function initBadgeImageManager():void
        {
            if (_SafeStr_500 != null)
            {
                return;
            };
            _SafeStr_500 = new BadgeImageManager(assets, events, this);
        }

        private function initFurnitureData():void
        {
            var _local_2:String;
            var _local_3:int;
            var _local_1:String;
            if (_SafeStr_498)
            {
                _SafeStr_498.dispose();
                _SafeStr_498 = null;
            };
            _SafeStr_498 = new FurnitureDataParser(_floorItems, _wallItems, _SafeStr_496, _localization);
            _SafeStr_498.addEventListener("FDP_furniture_data_ready", onFurnitureReady);
            if (propertyExists("furnidata.load.url"))
            {
                _local_2 = getProperty("furnidata.load.url");
                if (_newFurniDataHash != null)
                {
                    _local_3 = _local_2.lastIndexOf("/");
                    _local_1 = _local_2.substring(0, _local_3);
                    _SafeStr_498.loadData(((_local_1 + "/") + _newFurniDataHash));
                }
                else
                {
                    if (((!(_localization)) || (!(_localization.getGameDataResources()))))
                    {
                        _SafeStr_498.loadData(_local_2);
                    }
                    else
                    {
                        _SafeStr_498.loadData(_local_2, _localization.getGameDataResources().getFurniDataHash(), _localization.getActiveEnvironmentId());
                    };
                };
            };
        }

        private function initProductData():void
        {
            if (_SafeStr_499)
            {
                _SafeStr_499.dispose();
                _SafeStr_499 = null;
            };
            var _local_1:String = getProperty("productdata.load.url");
            if (((!(_localization)) || (!(_localization.getGameDataResources()))))
            {
                _SafeStr_499 = new ProductDataParser(_local_1, _SafeStr_501);
            }
            else
            {
                _SafeStr_499 = new ProductDataParser(_local_1, _SafeStr_501, _localization.getGameDataResources().getProductDataHash(), _localization.getActiveEnvironmentId());
            };
            _SafeStr_499.addEventListener("PDP_product_data_ready", onProductsReady);
        }

        private function onFurnitureReady(_arg_1:Event=null):void
        {
            _SafeStr_498.removeEventListener("FDP_furniture_data_ready", onFurnitureReady);
            _SafeStr_506 = true;
            if (((isAuthenticHabbo) && (!(_SafeStr_502))))
            {
                _SafeStr_502 = true;
                for each (var _local_2:IFurniDataListener in _furniDataListeners)
                {
                    _local_2.furniDataReady();
                };
            };
        }

        private function onUserRights(_arg_1:IMessageEvent):void
        {
            var _local_2:UserRightsMessageEvent = UserRightsMessageEvent(_arg_1);
            _clubLevel = ((_local_2.clubLevel != 0) ? 2 : 0);
            _SafeStr_507 = _local_2.securityLevel;
            _topSecurityLevel = Math.max(_topSecurityLevel, _local_2.securityLevel);
            _isAmbassador = _local_2.isAmbassador;
        }

        private function onNoobnessLevelEvent(_arg_1:NoobnessLevelMessageEvent):void
        {
            _SafeStr_503 = _arg_1.noobnessLevel;
            if (_SafeStr_503 != 0)
            {
                context.configuration.setProperty("new.identity", "1");
            };
        }

        private function onUserObject(_arg_1:IMessageEvent):void
        {
            var _local_4:String;
            var _local_2:UserObjectEvent = (_arg_1 as UserObjectEvent);
            var _local_3:UserObjectMessageParser = _local_2.getParser();
            _userId = _local_3.id;
            _userName = _local_3.name;
            _SafeStr_2025 = _local_3.respectTotal;
            _respectLeft = _local_3.respectLeft;
            _petRespectLeft = _local_3.petRespectLeft;
            _figure = _local_3.figure;
            _gender = _local_3.sex;
            _realName = _local_3.realName;
            _nameChangeAllowed = _local_3.nameChangeAllowed;
            _SafeStr_509 = _local_3.accountSafetyLocked;
            try
            {
                if (((context.displayObjectContainer) && (propertyExists("environment.id"))))
                {
                    _local_4 = getProperty("environment.id");
                    _local_4 = _local_4.replace("pt", "br");
                    _local_4 = _local_4.replace("en", "com");
//                    context.displayObjectContainer.stage.nativeWindow.title = ((("Habbo " + _local_4.toUpperCase()) + " | ") + _userName);
                };
            }
            catch(e:Error)
            {
            };
            _SafeStr_504.initIgnoreList();
        }

        private function onUserChange(_arg_1:IMessageEvent):void
        {
            var _local_2:UserChangeMessageEvent = (_arg_1 as UserChangeMessageEvent);
            if (_local_2 == null)
            {
                return;
            };
            if (_local_2.id == -1)
            {
                _figure = _local_2.figure;
                _gender = _local_2.sex;
            };
        }

        private function onFigureUpdate(_arg_1:IMessageEvent):void
        {
            var _local_2:FigureUpdateEvent = (_arg_1 as FigureUpdateEvent);
            if (_local_2 == null)
            {
                return;
            };
            _figure = _local_2.figure;
            _gender = _local_2.gender;
            HabboWebTools.updateFigure(_figure);
        }

        private function onUserNameChange(_arg_1:IMessageEvent):void
        {
            var _local_2:UserNameChangedMessageEvent = (_arg_1 as UserNameChangedMessageEvent);
            if (((_local_2 == null) || (_local_2.getParser() == null)))
            {
                return;
            };
            var _local_3:UserNameChangedMessageParser = _local_2.getParser();
            if (_local_3.webId == _userId)
            {
                _userName = _local_3.newName;
                _nameChangeAllowed = false;
                events.dispatchEvent(new UserNameUpdateEvent(_userName));
            };
        }

        private function onChangeUserNameResult(_arg_1:ChangeUserNameResultMessageEvent):void
        {
            var _local_2:ChangeUserNameResultMessageParser = _arg_1.getParser();
            if (_local_2.resultCode == ChangeUserNameResultMessageEvent._SafeStr_505)
            {
                _nameChangeAllowed = false;
                events.dispatchEvent(new UserNameUpdateEvent(_local_2.name));
            };
        }

        private function onMysteryBoxKeys(_arg_1:MysteryBoxKeysMessageEvent):void
        {
            var _local_2:MysteryBoxKeysMessageParser = _arg_1.getParser();
            _mysteryBoxColor = _local_2.boxColor;
            _mysteryKeyColor = _local_2.keyColor;
            events.dispatchEvent(new MysteryBoxKeysUpdateEvent(_mysteryBoxColor, _mysteryKeyColor));
        }

        private function onInClientLink(_arg_1:InClientLinkMessageEvent):void
        {
            context.createLinkEvent(_arg_1.link);
        }

        private function onAccountPreferences(_arg_1:AccountPreferencesEvent):void
        {
            var _local_2:AccountPreferencesParser = (_arg_1.getParser() as AccountPreferencesParser);
            _isRoomCameraFollowDisabled = _local_2.roomCameraFollowDisabled;
            _uiFlags = _local_2.uiFlags;
            events.dispatchEvent(new SessionDataPreferencesEvent(_uiFlags));
        }

        private function onEmailStatus(_arg_1:EmailStatusResultEvent):void
        {
            var _local_2:EmailStatusParser = (_arg_1.getParser() as EmailStatusParser);
            _isEmailVerified = _local_2.isVerified;
        }

        private function onAvailabilityStatus(_arg_1:IMessageEvent):void
        {
            var _local_2:AvailabilityStatusMessageParser = (_arg_1 as AvailabilityStatusMessageEvent).getParser();
            if (_local_2 == null)
            {
                return;
            };
            _systemOpen = _local_2.isOpen;
            _systemShutDown = _local_2.onShutDown;
            _isAuthenticHabbo = _local_2.isAuthenticHabbo;
            if ((((isAuthenticHabbo) && (_SafeStr_506)) && (!(_SafeStr_502))))
            {
                _SafeStr_502 = true;
                for each (var _local_3:IFurniDataListener in _furniDataListeners)
                {
                    _local_3.furniDataReady();
                };
            };
        }

        private function onPetRespectFailed(_arg_1:PetRespectFailedEvent):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _petRespectLeft++;
        }

        private function onAccountSafetyLockStatusChanged(_arg_1:AccountSafetyLockStatusChangeMessageEvent):void
        {
            var _local_2:AccountSafetyLockStatusChangeMessageParser = _arg_1.getParser();
            _SafeStr_509 = (_local_2.status == 0);
        }

        public function get systemOpen():Boolean
        {
            return (_systemOpen);
        }

        public function get systemShutDown():Boolean
        {
            return (_systemShutDown);
        }

        public function get isAuthenticHabbo():Boolean
        {
            return (_isAuthenticHabbo);
        }

        public function hasSecurity(_arg_1:int):Boolean
        {
            return (_SafeStr_507 >= _arg_1);
        }

        public function get topSecurityLevel():int
        {
            return (_topSecurityLevel);
        }

        public function get clubLevel():int
        {
            return (_clubLevel);
        }

        public function get hasVip():Boolean
        {
            return (HabboClubLevelEnum.HasVip(_clubLevel));
        }

        public function get hasClub():Boolean
        {
            return (HabboClubLevelEnum.HasClub(_clubLevel));
        }

        public function get isNoob():Boolean
        {
            return (!(_SafeStr_503 == 0));
        }

        public function get isRealNoob():Boolean
        {
            return (_SafeStr_503 == 2);
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get userName():String
        {
            return (_userName);
        }

        public function get realName():String
        {
            return (_realName);
        }

        public function get figure():String
        {
            return (_figure);
        }

        public function get isAnyRoomController():Boolean
        {
            return (_SafeStr_507 >= 5);
        }

        public function get isAmbassador():Boolean
        {
            return (_isAmbassador);
        }

        public function get isEmailVerified():Boolean
        {
            return (_isEmailVerified);
        }

        public function setRoomCameraFollowDisabled(_arg_1:Boolean):void
        {
            _isRoomCameraFollowDisabled = _arg_1;
        }

        public function get isRoomCameraFollowDisabled():Boolean
        {
            return (_isRoomCameraFollowDisabled);
        }

        public function setFriendBarState(_arg_1:Boolean):void
        {
            setUIFlag(1, _arg_1);
        }

        public function setRoomToolsState(_arg_1:Boolean):void
        {
            setUIFlag(2, _arg_1);
        }

        public function get uiFlags():int
        {
            return (_uiFlags);
        }

        private function setUIFlag(_arg_1:int, _arg_2:Boolean):void
        {
            if (_arg_2)
            {
                if ((_uiFlags & _arg_1))
                {
                    return;
                };
                _uiFlags = (_uiFlags | _arg_1);
            }
            else
            {
                if (!(_uiFlags & _arg_1))
                {
                    return;
                };
                _uiFlags = (_uiFlags & (~(_arg_1)));
            };
            _communication.connection.send(new SetUIFlagsMessageComposer(_uiFlags));
        }

        public function getBadgeImage(_arg_1:String):BitmapData
        {
            return (_SafeStr_500.getBadgeImage(_arg_1));
        }

        public function getBadgeSmallImage(_arg_1:String):BitmapData
        {
            return (_SafeStr_500.getSmallBadgeImage(_arg_1));
        }

        public function getBadgeImageAssetName(_arg_1:String):String
        {
            return (_SafeStr_500.getBadgeImageAssetName(_arg_1));
        }

        public function getBadgeImageSmallAssetName(_arg_1:String):String
        {
            return (_SafeStr_500.getSmallScaleBadgeAssetName(_arg_1));
        }

        public function requestBadgeImage(_arg_1:String):BitmapData
        {
            return (_SafeStr_500.getBadgeImage(_arg_1, "normal_badge", false));
        }

        public function getBadgeImageWithInfo(_arg_1:String):BadgeInfo
        {
            return (_SafeStr_500.getBadgeImageWithInfo(_arg_1));
        }

        private function onAlertClose(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }

        public function getGroupBadgeId(_arg_1:int):String
        {
            return (_SafeStr_508.getBadgeId(_arg_1));
        }

        public function send(_arg_1:IMessageComposer):void
        {
            _communication.connection.send(_arg_1);
        }

        public function getGroupBadgeImage(_arg_1:String):BitmapData
        {
            return (_SafeStr_500.getBadgeImage(_arg_1, "group_badge"));
        }

        public function getGroupBadgeSmallImage(_arg_1:String):BitmapData
        {
            return (_SafeStr_500.getSmallBadgeImage(_arg_1, "group_badge"));
        }

        public function getGroupBadgeAssetName(_arg_1:String):String
        {
            return (_SafeStr_500.getBadgeImageAssetName(_arg_1, "group_badge"));
        }

        public function getGroupBadgeSmallAssetName(_arg_1:String):String
        {
            return (_SafeStr_500.getSmallScaleBadgeAssetName(_arg_1, "group_badge"));
        }

        public function isAccountSafetyLocked():Boolean
        {
            return (_SafeStr_509);
        }

        public function get communication():IHabboCommunicationManager
        {
            return (_communication);
        }

        public function isIgnored(_arg_1:String):Boolean
        {
            return (_SafeStr_504.isIgnored(_arg_1));
        }

        public function ignoreUser(_arg_1:String):void
        {
            _SafeStr_504.ignoreUser(_arg_1);
        }

        public function unignoreUser(_arg_1:String):void
        {
            _SafeStr_504.unignoreUser(_arg_1);
        }

        public function get respectLeft():int
        {
            return (_respectLeft);
        }

        public function get petRespectLeft():int
        {
            return (_petRespectLeft);
        }

        public function giveStarGem(_arg_1:int):void
        {
            if (_arg_1 >= 0)
            {
                send(new GiveStarGemToUserMessageComposer(_arg_1));
            };
        }

        public function giveRespectFailed():void
        {
            _respectLeft = (_respectLeft + 1);
        }

        public function getCreditVaultStatus():void
        {
            send(new CreditVaultStatusMessageComposer());
        }

        public function getIncomeRewardStatus():void
        {
            send(new IncomeRewardStatusMessageComposer());
        }

        public function withdrawCreditVault():void
        {
            send(new WithdrawCreditVaultMessageComposer());
        }

        public function claimReward(_arg_1:int):void
        {
            send(new IncomeRewardClaimMessageComposer(_arg_1));
        }

        public function givePetRespect(_arg_1:int):void
        {
            if (((_arg_1 >= 0) && (_petRespectLeft > 0)))
            {
                send(new RespectPetMessageComposer(_arg_1));
                _petRespectLeft = (_petRespectLeft - 1);
            };
        }

        public function getProductData(_arg_1:String):IProductData
        {
            if (!_SafeStr_510)
            {
                loadProductData();
            };
            return (_SafeStr_501[_arg_1]);
        }

        public function getFloorItemData(_arg_1:int):IFurnitureData
        {
            if (_floorItems == null)
            {
                return (null);
            };
            return (_floorItems.getValue(_arg_1.toString()));
        }

        public function getFloorItemsDataByCategory(_arg_1:int):Array
        {
            var _local_2:Array = [];
            if (_floorItems != null)
            {
                for each (var _local_3:IFurnitureData in _floorItems)
                {
                    if (_local_3.category == _arg_1)
                    {
                        _local_2.push(_local_3);
                    };
                };
            };
            return (_local_2);
        }

        public function getWallItemData(_arg_1:int):IFurnitureData
        {
            if (_wallItems == null)
            {
                return (null);
            };
            return (_wallItems.getValue(_arg_1.toString()));
        }

        public function getFloorItemDataByName(_arg_1:String, _arg_2:int=0):IFurnitureData
        {
            var _local_3:int;
            if (_SafeStr_496 == null)
            {
                return (null);
            };
            var _local_4:Array = _SafeStr_496.getValue(_arg_1);
            if (((!(_local_4 == null)) && (_arg_2 <= (_local_4.length - 1))))
            {
                _local_3 = _local_4[_arg_2];
                return (getFloorItemData(_local_3));
            };
            return (null);
        }

        public function getWallItemDataByName(_arg_1:String, _arg_2:int=0):IFurnitureData
        {
            var _local_3:int;
            if (_SafeStr_496 == null)
            {
                return (null);
            };
            var _local_4:Array = _SafeStr_496.getValue(_arg_1);
            if (((!(_local_4 == null)) && (_arg_2 <= (_local_4.length - 1))))
            {
                _local_3 = _local_4[_arg_2];
                return (getWallItemData(_local_3));
            };
            return (null);
        }

        public function openHabboHomePage(_arg_1:int, _arg_2:String):void
        {
            var _local_3:String;
            if (propertyExists("link.format.userpage"))
            {
                _local_3 = getProperty("link.format.userpage");
                _local_3 = _local_3.replace("%ID%", String(_arg_1));
                _local_3 = _local_3.replace("%username%", _arg_2);
                try
                {
                    HabboWebTools.navigateToURL(_local_3, "habboMain");
                }
                catch(e:Error)
                {
                    Logger.log("Error occurred!");
                };
            };
        }

        public function pickAllFurniture(_arg_1:int):void
        {
            var roomId:int = _arg_1;
            if (((_roomSessionManager == null) || (_windowManager == null)))
            {
                return;
            };
            var session:IRoomSession = _roomSessionManager.getSession(roomId);
            if (session == null)
            {
                return;
            };
            if ((((session.isRoomOwner) || (isAnyRoomController)) || (session.roomControllerLevel >= 1)))
            {
                _windowManager.confirm("${generic.alert.title}", "${room.confirm.pick_all}", 0, function (_arg_1:_SafeStr_126, _arg_2:WindowEvent):void
                {
                    _arg_1.dispose();
                    if (_arg_2.type == "WE_OK")
                    {
                        sendSpecialCommandMessage(":pickall");
                    };
                });
            };
        }

        public function ejectAllFurniture(_arg_1:int, _arg_2:String):void
        {
            var roomId:int = _arg_1;
            var message:String = _arg_2;
            if (((_roomSessionManager == null) || (_windowManager == null)))
            {
                return;
            };
            var session:IRoomSession = _roomSessionManager.getSession(roomId);
            if (session == null)
            {
                return;
            };
            if ((((session.isRoomOwner) || (isAnyRoomController)) || (session.roomControllerLevel >= 1)))
            {
                _windowManager.confirm("${generic.alert.title}", "${room.confirm.eject_all}", 0, function (_arg_1:_SafeStr_126, _arg_2:WindowEvent):void
                {
                    _arg_1.dispose();
                    if (_arg_2.type == "WE_OK")
                    {
                        sendSpecialCommandMessage(message);
                    };
                });
            };
        }

        public function ejectPets(_arg_1:int):void
        {
            if (((_roomSessionManager == null) || (_windowManager == null)))
            {
                return;
            };
            var _local_2:IRoomSession = _roomSessionManager.getSession(_arg_1);
            if (_local_2 == null)
            {
                return;
            };
            if (((_local_2.isRoomOwner) || (isAnyRoomController)))
            {
                sendSpecialCommandMessage(":ejectpets");
            };
        }

        public function pickAllBuilderFurniture(_arg_1:int):void
        {
            var roomId:int = _arg_1;
            if (((_roomSessionManager == null) || (_windowManager == null)))
            {
                return;
            };
            var session:IRoomSession = _roomSessionManager.getSession(roomId);
            if (session == null)
            {
                return;
            };
            if ((((session.isRoomOwner) || (isAnyRoomController)) || (session.roomControllerLevel >= 1)))
            {
                _windowManager.confirm("${generic.alert.title}", "${room.confirm.pick_all_bc}", 0, function (_arg_1:_SafeStr_126, _arg_2:WindowEvent):void
                {
                    _arg_1.dispose();
                    if (_arg_2.type == "WE_OK")
                    {
                        sendSpecialCommandMessage(":pickallbc");
                    };
                });
            };
        }

        public function loadProductData(_arg_1:IProductDataListener=null):Boolean
        {
            if (_SafeStr_510)
            {
                return (true);
            };
            if (((_arg_1) && (_productDataListeners.indexOf(_arg_1) == -1)))
            {
                _productDataListeners.push(_arg_1);
            };
            return (false);
        }

        public function addProductsReadyEventListener(_arg_1:IProductDataListener):void
        {
            if (_SafeStr_510)
            {
                _arg_1.productDataReady();
                return;
            };
            if (((_arg_1) && (_productDataListeners.indexOf(_arg_1) == -1)))
            {
                _productDataListeners.push(_arg_1);
            };
        }

        private function onProductsReady(_arg_1:Event):void
        {
            _SafeStr_499.removeEventListener("PDP_product_data_ready", onProductsReady);
            _SafeStr_510 = true;
            for each (var _local_2:IProductDataListener in _productDataListeners)
            {
                if (((!(_local_2 == null)) && (!(_local_2.disposed))))
                {
                    _local_2.productDataReady();
                };
            };
            _productDataListeners = [];
        }

        private function onRoomReady(_arg_1:IMessageEvent):void
        {
            var _local_3:RoomReadyMessageEvent = (_arg_1 as RoomReadyMessageEvent);
            if ((((_local_3 == null) || (_local_3.getParser() == null)) || (_arg_1.connection == null)))
            {
                return;
            };
            var _local_2:RoomReadyMessageParser = _local_3.getParser();
            HabboWebTools.roomVisited(_local_2.roomId);
        }

        public function sendSpecialCommandMessage(_arg_1:String):void
        {
            send(new ChatMessageComposer(_arg_1));
        }

        public function get roomSessionManager():IRoomSessionManager
        {
            return (_roomSessionManager);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get gender():String
        {
            return (_gender);
        }

        private function onCatalogPublished(_arg_1:IMessageEvent):void
        {
            var _local_2:int;
            var _local_4:int;
            var _local_5:int;
            var _local_3:CatalogPublishedMessageEvent = (_arg_1 as CatalogPublishedMessageEvent);
            if (_local_3.newFurniDataHash != null)
            {
                _newFurniDataHash = _local_3.newFurniDataHash;
            };
            if (_local_3.instantlyRefreshCatalogue)
            {
                refreshFurniData(null);
            }
            else
            {
                _local_2 = getInteger("catalogue.published.min.refresh.interval", 5);
                _local_4 = getInteger("catalogue.published.max.refresh.interval", 20);
                _local_5 = (Math.floor((Math.random() * ((_local_4 - _local_2) + 1))) + _local_2);
                if (_SafeStr_511 == null)
                {
                    _SafeStr_511 = new Timer((_local_5 * 3000));
                    _SafeStr_511.addEventListener("timer", refreshFurniData);
                    _SafeStr_511.start();
                };
            };
        }

        private function refreshFurniData(_arg_1:TimerEvent):void
        {
            if (_SafeStr_511 != null)
            {
                _SafeStr_511.removeEventListener("timer", refreshFurniData);
                _SafeStr_511 = null;
            };
            _floorItems = new Map();
            _wallItems = new Map();
            _SafeStr_496 = new Map();
            initFurnitureData();
        }

        public function removeFurniDataListener(_arg_1:IFurniDataListener):void
        {
            if (!_furniDataListeners)
            {
                return;
            };
            var _local_2:int = _furniDataListeners.indexOf(_arg_1);
            if (_local_2 > -1)
            {
                _furniDataListeners.splice(_local_2, 1);
            };
        }

        public function getFurniData(_arg_1:IFurniDataListener):Vector.<IFurnitureData>
        {
            if (((_floorItems == null) || (_floorItems.length == 0)))
            {
                if (_furniDataListeners.indexOf(_arg_1) == -1)
                {
                    _furniDataListeners.push(_arg_1);
                };
                return (null);
            };
            return (Vector.<IFurnitureData>(_floorItems.getValues().concat(_wallItems.getValues())));
        }

        public function getXmlWindow(_arg_1:String):IWindow
        {
            var _local_4:IAsset;
            var _local_2:XmlAsset;
            var _local_3:IWindow;
            try
            {
                _local_4 = assets.getAssetByName(_arg_1);
                _local_2 = XmlAsset(_local_4);
                _local_3 = _windowManager.buildFromXML(XML(_local_2.content));
            }
            catch(e:Error)
            {
            };
            return (_local_3);
        }

        public function getButtonImage(_arg_1:String):BitmapData
        {
            var _local_3:String = _arg_1;
            var _local_6:IAsset = assets.getAssetByName(_local_3);
            var _local_4:BitmapDataAsset = BitmapDataAsset(_local_6);
            var _local_2:BitmapData = BitmapData(_local_4.content);
            var _local_5:BitmapData = new BitmapData(_local_2.width, _local_2.height, true, 0);
            _local_5.draw(_local_2);
            return (_local_5);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (_localization);
        }

        public function get nameChangeAllowed():Boolean
        {
            return (_nameChangeAllowed);
        }

        public function get perksReady():Boolean
        {
            return ((!(_SafeStr_497 == null)) && (_SafeStr_497.isReady));
        }

        public function isPerkAllowed(_arg_1:String):Boolean
        {
            return (_SafeStr_497.isPerkAllowed(_arg_1));
        }

        public function getPerkErrorMessage(_arg_1:String):String
        {
            return (_SafeStr_497.getPerkErrorMessage(_arg_1));
        }

        public function get currentTalentTrack():String
        {
            return (((getBoolean("talent.track.citizenship.enabled")) && (!(isPerkAllowed("CITIZEN")))) ? "citizenship" : "helper");
        }

        public function get mysteryBoxColor():String
        {
            return (_mysteryBoxColor);
        }

        public function get mysteryKeyColor():String
        {
            return (_mysteryKeyColor);
        }


    }
}