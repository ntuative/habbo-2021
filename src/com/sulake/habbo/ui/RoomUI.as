package com.sulake.habbo.ui
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.navigator.IHabboNewNavigator;
    import com.sulake.habbo.groups.IHabboGroupsManager;
    import com.sulake.habbo.avatar.IHabboAvatarEditor;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.advertisement.IAdManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.habbo.messenger.IHabboMessenger;
    import com.sulake.habbo.moderation.IHabboModeration;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.habbo.game.IHabboGameManager;
    import com.sulake.habbo.friendbar.IHabboFriendBar;
    import com.sulake.habbo.friendbar.view.IHabboFriendBarView;
    import com.sulake.habbo.friendbar.IHabboLandingView;
    import com.sulake.habbo.quest.IHabboQuestEngine;
    import com.sulake.habbo.freeflowchat.IHabboFreeFlowChat;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.ui.widget.RoomWidgetFactory;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboFriendList;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboInventory;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDHabboNavigator;
    import com.sulake.iid.IIDHabboNewNavigator;
    import com.sulake.iid.IIDHabboGroupsManager;
    import com.sulake.iid.IIDHabboAvatarEditor;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDHabboAdManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboHelp;
    import com.sulake.iid.IIDHabboModeration;
    import com.sulake.iid.IIDHabboSoundManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboUserDefinedRoomEvents;
    import com.sulake.iid.IIDHabboTracking;
    import com.sulake.iid.IIDHabboGameManager;
    import com.sulake.iid.IIDHabboFriendBar;
    import com.sulake.iid.IIDHabboFriendBarView;
    import com.sulake.iid.IIDHabboLandingView;
    import com.sulake.iid.IIDHabboQuestEngine;
    import com.sulake.iid.IIDHabboMessenger;
    import com.sulake.iid.IIDHabboFreeFlowChat;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.parser.perk.PerkAllowancesMessageEvent;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.advertisement.events.InterstitialEvent;
    import com.sulake.habbo.friendbar.events.FriendBarResizeEvent;
    import com.sulake.habbo.communication.messages.outgoing.advertisement.InterstitialShownMessageComposer;
    import com.sulake.habbo.advertisement.events.AdEvent;
    import flash.utils.Timer;
    import com.sulake.habbo.ui.widget.events.RoomDesktopMouseZoomEnableEvent;
    import flash.events.TimerEvent;
    import com.sulake.habbo.ui.widget.enums.AvatarExpressionEnum;
    import com.sulake.habbo.room.events.RoomEngineEvent;
    import com.sulake.habbo.room.events.RoomEngineRoomColorEvent;
    import com.sulake.habbo.room.events.RoomEngineZoomEvent;
    import com.sulake.habbo.room.events.RoomEngineHSLColorEnableEvent;
    import com.sulake.room.utils.RoomId;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import flash.events.Event;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import com.sulake.habbo.ui.widget.events.HideRoomWidgetEvent;
    import flash.events.MouseEvent;
    import com.sulake.habbo.freeflowchat.style.IChatStyleLibrary;

    public class RoomUI extends Component implements IRoomUI, IUpdateReceiver
    {

        private var _windowManager:IHabboWindowManager;
        private var _roomEngine:IRoomEngine;
        private var _roomSessionManager:IRoomSessionManager;
        private var _SafeStr_587:IRoomWidgetFactory;
        private var _sessionDataManager:ISessionDataManager;
        private var _friendList:IHabboFriendList;
        private var _avatarRenderManager:IAvatarRenderManager;
        private var _inventory:IHabboInventory;
        private var _toolbar:IHabboToolbar;
        private var _navigator:IHabboNavigator;
        private var _newNavigator:IHabboNewNavigator;
        private var _habboGroupsManager:IHabboGroupsManager;
        private var _avatarEditor:IHabboAvatarEditor;
        private var _catalog:IHabboCatalog;
        private var _adManager:IAdManager;
        private var _localization:IHabboLocalizationManager;
        private var _habboHelp:IHabboHelp;
        private var _messenger:IHabboMessenger;
        private var _moderation:IHabboModeration;
        private var _soundManager:IHabboSoundManager;
        private var _gameManager:IHabboGameManager;
        private var _friendBar:IHabboFriendBar;
        private var _friendBarView:IHabboFriendBarView;
        private var _landingView:IHabboLandingView;
        private var _questEngine:IHabboQuestEngine;
        private var _freeFlowChat:IHabboFreeFlowChat;
        private var _communication:IHabboCommunicationManager;
        private var _SafeStr_588:Map;
        private var _SafeStr_593:int = -1;
        private var _SafeStr_591:Boolean;
        private var _SafeStr_589:int;
        private var _habboTracking:IHabboTracking;
        private var _userDefinedRoomEvents:IHabboUserDefinedRoomEvents;
        private var _SafeStr_590:Boolean = false;
        private var _isInRoom:Boolean = false;
        private var _perkAllowancesMessageEvent:IMessageEvent;

        public function RoomUI(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            _SafeStr_587 = new RoomWidgetFactory(this);
            _SafeStr_588 = new Map();
            registerUpdateReceiver(this, 0);
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(), function (_arg_1:IHabboWindowManager):void
            {
                _windowManager = _arg_1;
            }), new ComponentDependency(new IIDRoomEngine(), function (_arg_1:IRoomEngine):void
            {
                _roomEngine = _arg_1;
            }, true, [{
                "type":"REE_ENGINE_INITIALIZED",
                "callback":roomEngineEventHandler
            }, {
                "type":"REE_INITIALIZED",
                "callback":roomEventHandler
            }, {
                "type":"REE_OBJECTS_INITIALIZED",
                "callback":roomEngineEventHandler
            }, {
                "type":"REE_DISPOSED",
                "callback":roomEventHandler
            }, {
                "type":"REE_NORMAL_MODE",
                "callback":roomEngineEventHandler
            }, {
                "type":"REE_GAME_MODE",
                "callback":roomEngineEventHandler
            }, {
                "type":"REDSE_ROOM_COLOR",
                "callback":roomEventHandler
            }, {
                "type":"REE_ROOM_COLOR",
                "callback":roomEventHandler
            }, {
                "type":"REE_ROOM_ZOOM",
                "callback":roomEventHandler
            }, {
                "type":"ROHSLCEE_ROOM_BACKGROUND_COLOR",
                "callback":roomEventHandler
            }, {
                "type":"REOE_SELECTED",
                "callback":roomObjectEventHandler
            }, {
                "type":"REOE_DESELECTED",
                "callback":roomObjectEventHandler
            }, {
                "type":"REOE_ADDED",
                "callback":roomObjectEventHandler
            }, {
                "type":"REOE_REMOVED",
                "callback":roomObjectEventHandler
            }, {
                "type":"REOE_PLACED",
                "callback":roomObjectEventHandler
            }, {
                "type":"REOE_REQUEST_MOVE",
                "callback":roomObjectEventHandler
            }, {
                "type":"REOE_REQUEST_ROTATE",
                "callback":roomObjectEventHandler
            }, {
                "type":"REOE_MOUSE_ENTER",
                "callback":roomObjectEventHandler
            }, {
                "type":"REOE_MOUSE_LEAVE",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_OPEN_WIDGET",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_CLOSE_WIDGET",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_OPEN_FURNI_CONTEXT_MENU",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_CLOSE_FURNI_CONTEXT_MENU",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_REQUEST_CREDITFURNI",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_REQUEST_STICKIE",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_REQUEST_PRESENT",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_REQUEST_TROPHY",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_REQUEST_TEASER",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_REQUEST_ECOTRONBOX",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_REQUEST_PLACEHOLDER",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_REQUEST_DIMMER",
                "callback":roomObjectEventHandler
            }, {
                "type":"RERAE_FURNI_CLICK",
                "callback":roomObjectEventHandler
            }, {
                "type":"RERAE_FURNI_DOUBLE_CLICK",
                "callback":roomObjectEventHandler
            }, {
                "type":"RERAE_TOOLTIP_SHOW",
                "callback":roomObjectEventHandler
            }, {
                "type":"RERAE_TOOLTIP_HIDE",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_REMOVE_DIMMER",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_REQUEST_CLOTHING_CHANGE",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_REQUEST_PLAYLIST_EDITOR",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_REQUEST_MANNEQUIN",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_REQUEST_BACKGROUND_COLOR",
                "callback":roomObjectEventHandler
            }, {
                "type":"ROSM_USE_PRODUCT_FROM_INVENTORY",
                "callback":roomObjectEventHandler
            }, {
                "type":"ROSM_USE_PRODUCT_FROM_ROOM",
                "callback":roomObjectEventHandler
            }, {
                "type":"ROSM_JUKEBOX_DISPOSE",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_REQUEST_BADGE_DISPLAY_ENGRAVING",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_REQUEST_ACHIEVEMENT_RESOLUTION_FAILED",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_REQUEST_FRIEND_FURNITURE_ENGRAVING",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_REQUEST_HIGH_SCORE_DISPLAY",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_REQUEST_HIDE_HIGH_SCORE_DISPLAY",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_REQUEST_INTERNAL_LINK",
                "callback":roomObjectEventHandler
            }, {
                "type":"RETWE_REQUEST_ROOM_LINK",
                "callback":roomObjectEventHandler
            }]), new ComponentDependency(new IIDHabboRoomSessionManager(), function (_arg_1:IRoomSessionManager):void
            {
                _roomSessionManager = _arg_1;
            }, true, [{
                "type":"RSE_CREATED",
                "callback":roomSessionStateEventHandler
            }, {
                "type":"RSE_STARTED",
                "callback":roomSessionStateEventHandler
            }, {
                "type":"RSE_ENDED",
                "callback":roomSessionStateEventHandler
            }, {
                "type":"RSE_ROOM_DATA",
                "callback":roomSessionStateEventHandler
            }, {
                "type":"RSCE_CHAT_EVENT",
                "callback":roomSessionEventHandler
            }, {
                "type":"RSCE_FLOOD_EVENT",
                "callback":roomSessionEventHandler
            }, {
                "type":"RSUBE_BADGES",
                "callback":roomSessionEventHandler
            }, {
                "type":"RSDE_DOORBELL",
                "callback":roomSessionEventHandler
            }, {
                "type":"RSDE_REJECTED",
                "callback":roomSessionEventHandler
            }, {
                "type":"RSDE_ACCEPTED",
                "callback":roomSessionEventHandler
            }, {
                "type":"RSPE_PRESENT_OPENED",
                "callback":roomSessionEventHandler
            }, {
                "type":"RSOPPE_OPEN_PET_PACKAGE_REQUESTED",
                "callback":roomSessionEventHandler
            }, {
                "type":"RSOPPE_OPEN_PET_PACKAGE_RESULT",
                "callback":roomSessionEventHandler
            }, {
                "type":"RSEME_KICKED",
                "callback":roomSessionDialogEventHandler
            }, {
                "type":"RSEME_PETS_FORBIDDEN_IN_HOTEL",
                "callback":roomSessionDialogEventHandler
            }, {
                "type":"RSEME_PETS_FORBIDDEN_IN_FLAT",
                "callback":roomSessionDialogEventHandler
            }, {
                "type":"RSEME_MAX_PETS",
                "callback":roomSessionDialogEventHandler
            }, {
                "type":"RSEME_MAX_NUMBER_OF_OWN_PETS",
                "callback":roomSessionDialogEventHandler
            }, {
                "type":"RSEME_NO_FREE_TILES_FOR_PET",
                "callback":roomSessionDialogEventHandler
            }, {
                "type":"RSEME_SELECTED_TILE_NOT_FREE_FOR_PET",
                "callback":roomSessionDialogEventHandler
            }, {
                "type":"RSEME_BOTS_FORBIDDEN_IN_HOTEL",
                "callback":roomSessionDialogEventHandler
            }, {
                "type":"RSEME_BOTS_FORBIDDEN_IN_FLAT",
                "callback":roomSessionDialogEventHandler
            }, {
                "type":"RSEME_BOT_LIMIT_REACHED",
                "callback":roomSessionDialogEventHandler
            }, {
                "type":"RSEME_SELECTED_TILE_NOT_FREE_FOR_BOT",
                "callback":roomSessionDialogEventHandler
            }, {
                "type":"RSEME_BOT_NAME_NOT_ACCEPTED",
                "callback":roomSessionDialogEventHandler
            }, {
                "type":"RSQE_QUEUE_STATUS",
                "callback":roomSessionEventHandler
            }, {
                "type":"RSPE_POLL_CONTENT",
                "callback":roomSessionEventHandler
            }, {
                "type":"RSPE_POLL_ERROR",
                "callback":roomSessionEventHandler
            }, {
                "type":"RSPE_POLL_OFFER",
                "callback":roomSessionEventHandler
            }, {
                "type":"RWPUW_QUESTION_ANSWERED",
                "callback":roomSessionEventHandler
            }, {
                "type":"RWPUW_QUESION_FINSIHED",
                "callback":roomSessionEventHandler
            }, {
                "type":"RWPUW_NEW_QUESTION",
                "callback":roomSessionEventHandler
            }, {
                "type":"RSDPE_PRESETS",
                "callback":roomSessionEventHandler
            }, {
                "type":"RSFRE_FRIEND_REQUEST",
                "callback":roomSessionEventHandler
            }, {
                "type":"rsudue_user_data_updated",
                "callback":roomSessionEventHandler
            }, {
                "type":"RSDE_DANCE",
                "callback":roomSessionEventHandler
            }]), new ComponentDependency(new IIDSessionDataManager(), function (_arg_1:ISessionDataManager):void
            {
                _sessionDataManager = _arg_1;
            }), new ComponentDependency(new IIDHabboFriendList(), function (_arg_1:IHabboFriendList):void
            {
                _friendList = _arg_1;
            }), new ComponentDependency(new IIDAvatarRenderManager(), function (_arg_1:IAvatarRenderManager):void
            {
                _avatarRenderManager = _arg_1;
            }), new ComponentDependency(new IIDHabboInventory(), function (_arg_1:IHabboInventory):void
            {
                _inventory = _arg_1;
            }), new ComponentDependency(new IIDHabboToolbar(), function (_arg_1:IHabboToolbar):void
            {
                _toolbar = _arg_1;
            }), new ComponentDependency(new IIDHabboNavigator(), function (_arg_1:IHabboNavigator):void
            {
                _navigator = _arg_1;
            }), new ComponentDependency(new IIDHabboNewNavigator(), function (_arg_1:IHabboNewNavigator):void
            {
                _newNavigator = _arg_1;
            }), new ComponentDependency(new IIDHabboGroupsManager(), function (_arg_1:IHabboGroupsManager):void
            {
                _habboGroupsManager = _arg_1;
            }), new ComponentDependency(new IIDHabboAvatarEditor(), function (_arg_1:IHabboAvatarEditor):void
            {
                _avatarEditor = _arg_1;
            }), new ComponentDependency(new IIDHabboCatalog(), function (_arg_1:IHabboCatalog):void
            {
                _catalog = _arg_1;
            }), new ComponentDependency(new IIDHabboAdManager(), function (_arg_1:IAdManager):void
            {
                _adManager = _arg_1;
            }, true, [{
                "type":"AE_INTERSTITIAL_NOT_SHOWN",
                "callback":interstitialNotAvailableEventHandler
            }, {
                "type":"AE_INTERSTITIAL_COMPLETE",
                "callback":interstitialCompleteEventHandler
            }, {
                "type":"AE_INTERSTITIAL_SHOW",
                "callback":interstitialShowEventHandler
            }, {
                "type":"AE_ROOM_AD_SHOW",
                "callback":adEventHandler
            }]), new ComponentDependency(new IIDHabboLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                _localization = _arg_1;
            }), new ComponentDependency(new IIDHabboHelp(), function (_arg_1:IHabboHelp):void
            {
                _habboHelp = _arg_1;
            }), new ComponentDependency(new IIDHabboModeration(), function (_arg_1:IHabboModeration):void
            {
                _moderation = _arg_1;
            }), new ComponentDependency(new IIDHabboSoundManager(), function (_arg_1:IHabboSoundManager):void
            {
                _soundManager = _arg_1;
            }), new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communication = _arg_1;
            }), new ComponentDependency(new IIDHabboUserDefinedRoomEvents(), function (_arg_1:IHabboUserDefinedRoomEvents):void
            {
                _userDefinedRoomEvents = _arg_1;
            }), new ComponentDependency(new IIDHabboTracking(), function (_arg_1:IHabboTracking):void
            {
                _habboTracking = _arg_1;
            }), new ComponentDependency(new IIDHabboGameManager(), function (_arg_1:IHabboGameManager):void
            {
                _gameManager = _arg_1;
            }, true, [{
                "type":"gce_game_chat",
                "callback":gameEventHandler
            }]), new ComponentDependency(new IIDHabboFriendBar(), function (_arg_1:IHabboFriendBar):void
            {
                _friendBar = _arg_1;
            }), new ComponentDependency(new IIDHabboFriendBarView(), function (_arg_1:IHabboFriendBarView):void
            {
                _friendBarView = _arg_1;
            }, true, [{
                "type":"FBE_BAR_RESIZE_EVENT",
                "callback":bottomBarResizeHandler
            }]), new ComponentDependency(new IIDHabboLandingView(), function (_arg_1:IHabboLandingView):void
            {
                _landingView = _arg_1;
            }), new ComponentDependency(new IIDHabboQuestEngine(), function (_arg_1:IHabboQuestEngine):void
            {
                _questEngine = _arg_1;
            }), new ComponentDependency(new IIDHabboMessenger(), function (_arg_1:IHabboMessenger):void
            {
                _messenger = _arg_1;
            }), new ComponentDependency(new IIDHabboFreeFlowChat(), function (_arg_1:IHabboFreeFlowChat):void
            {
                _freeFlowChat = _arg_1;
            })]));
        }

        override protected function initComponent():void
        {
            _perkAllowancesMessageEvent = _communication.addHabboConnectionMessageEvent(new PerkAllowancesMessageEvent(onPerkAllowances));
        }

        override public function dispose():void
        {
            var _local_2:String;
            var _local_1:RoomDesktop;
            if (disposed)
            {
                return;
            };
            if (_SafeStr_587 != null)
            {
                _SafeStr_587.dispose();
                _SafeStr_587 = null;
            };
            if (_communication != null)
            {
                _communication.removeHabboConnectionMessageEvent(_perkAllowancesMessageEvent);
                _perkAllowancesMessageEvent = null;
            };
            if (_SafeStr_588 != null)
            {
                while (_SafeStr_588.length > 0)
                {
                    _local_2 = (_SafeStr_588.getKey(0) as String);
                    _local_1 = (_SafeStr_588.remove(_local_2) as RoomDesktop);
                    if (_local_1 != null)
                    {
                        _local_1.dispose();
                    };
                };
                _SafeStr_588.dispose();
                _SafeStr_588 = null;
            };
            removeUpdateReceiver(this);
            super.dispose();
        }

        private function roomSessionStateEventHandler(_arg_1:RoomSessionEvent):void
        {
            if (_roomEngine == null)
            {
                return;
            };
            switch (_arg_1.type)
            {
                case "RSE_CREATED":
                    createDesktop(_arg_1.session);
                    if (_arg_1.session.isGameSession)
                    {
                        if (_toolbar)
                        {
                            _toolbar.setToolbarState("HTE_STATE_HIDDEN");
                        };
                        if (_friendBar)
                        {
                            _friendBar.visible = false;
                        };
                        if (_landingView)
                        {
                            _landingView.disable();
                        };
                    };
                    return;
                case "RSE_STARTED":
                    if (_toolbar)
                    {
                        defineToolbarState(_arg_1.session);
                    };
                    if (_landingView)
                    {
                        _landingView.disable();
                    };
                    return;
                case "RSE_ROOM_DATA":
                    defineToolbarState(_arg_1.session);
                    return;
                case "RSE_ENDED":
                    if (_arg_1.session != null)
                    {
                        disposeDesktop(getRoomIdentifier(_arg_1.session.roomId));
                        if (_arg_1.session.isGameSession)
                        {
                            _friendBar.visible = true;
                            if (_gameManager)
                            {
                                _gameManager.onSnowWarArenaSessionEnded();
                            };
                        }
                        else
                        {
                            if (_arg_1.openLandingPage)
                            {
                                if (((getBoolean("nux.lobbies.enabled")) && (_sessionDataManager.isRealNoob)))
                                {
                                    if (((_navigator.enteredGuestRoomData) && (_navigator.enteredGuestRoomData.doorMode == 4)))
                                    {
                                        _navigator.goToHomeRoom();
                                    }
                                    else
                                    {
                                        context.createLinkEvent("navigator/goto/predefined_noob_lobby");
                                    };
                                }
                                else
                                {
                                    if (_landingView)
                                    {
                                        _landingView.activate();
                                    };
                                };
                            };
                        };
                    };
                    return;
            };
        }

        private function defineToolbarState(_arg_1:IRoomSession):void
        {
            if (((getBoolean("nux.lobbies.enabled")) && (_sessionDataManager.isRealNoob)))
            {
                if (((_arg_1) && (_arg_1.isNoobRoom)))
                {
                    _toolbar.setToolbarState("HTE_STATE_NOOB_NOT_HOME");
                }
                else
                {
                    _toolbar.setToolbarState("HETE_STATE_NOOB_HOME");
                };
            }
            else
            {
                _toolbar.setToolbarState("HTE_STATE_ROOM_VIEW");
            };
        }

        private function roomSessionEventHandler(_arg_1:RoomSessionEvent):void
        {
            var _local_2:String;
            var _local_3:IRoomDesktop;
            if (_roomEngine == null)
            {
                return;
            };
            if (_arg_1.session != null)
            {
                _local_2 = getRoomIdentifier(_arg_1.session.roomId);
                _local_3 = getDesktop(_local_2);
                if (_local_3 != null)
                {
                    _local_3.processEvent(_arg_1);
                };
            };
        }

        private function roomSessionDialogEventHandler(_arg_1:RoomSessionEvent):void
        {
            var event:RoomSessionEvent = _arg_1;
            var errorTitle:String = "${error.title}";
            switch (event.type)
            {
                case "RSEME_MAX_PETS":
                    var errorMessage:String = "${room.error.max_pets}";
                    break;
                case "RSEME_MAX_NUMBER_OF_OWN_PETS":
                    errorMessage = "${room.error.max_own_pets}";
                    break;
                case "RSEME_KICKED":
                    errorMessage = "${room.error.kicked}";
                    errorTitle = "${generic.alert.title}";
                    break;
                case "RSEME_PETS_FORBIDDEN_IN_HOTEL":
                    errorMessage = "${room.error.pets.forbidden_in_hotel}";
                    break;
                case "RSEME_PETS_FORBIDDEN_IN_FLAT":
                    errorMessage = "${room.error.pets.forbidden_in_flat}";
                    break;
                case "RSEME_NO_FREE_TILES_FOR_PET":
                    errorMessage = "${room.error.pets.no_free_tiles}";
                    break;
                case "RSEME_SELECTED_TILE_NOT_FREE_FOR_PET":
                    errorMessage = "${room.error.pets.selected_tile_not_free}";
                    break;
                case "RSEME_BOTS_FORBIDDEN_IN_HOTEL":
                    errorMessage = "${room.error.bots.forbidden_in_hotel}";
                    break;
                case "RSEME_BOTS_FORBIDDEN_IN_FLAT":
                    errorMessage = "${room.error.bots.forbidden_in_flat}";
                    break;
                case "RSEME_BOT_LIMIT_REACHED":
                    errorMessage = "${room.error.max_bots}";
                    break;
                case "RSEME_SELECTED_TILE_NOT_FREE_FOR_BOT":
                    errorMessage = "${room.error.bots.selected_tile_not_free}";
                    break;
                case "RSEME_BOT_NAME_NOT_ACCEPTED":
                    errorMessage = "${room.error.bots.name.not.accepted}";
                    break;
                default:
                    return;
            };
            _windowManager.alert(errorTitle, errorMessage, 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
            {
                _arg_1.dispose();
            });
        }

        private function interstitialShowEventHandler(_arg_1:InterstitialEvent):void
        {
            var _local_2:String = getRoomIdentifier(_SafeStr_589);
            var _local_3:RoomDesktop = (getDesktop(_local_2) as RoomDesktop);
            if (_local_3 != null)
            {
                _local_3.processEvent(_arg_1);
            };
            _SafeStr_591 = true;
        }

        public function triggerbottomBarResize():void
        {
            bottomBarResizeHandler(new FriendBarResizeEvent());
        }

        private function bottomBarResizeHandler(_arg_1:FriendBarResizeEvent):void
        {
            var _local_2:String = getRoomIdentifier(_roomEngine.activeRoomId);
            var _local_3:RoomDesktop = (getDesktop(_local_2) as RoomDesktop);
            if (_local_3 != null)
            {
                _local_3.processEvent(_arg_1);
            };
        }

        private function interstitialNotAvailableEventHandler(_arg_1:InterstitialEvent):void
        {
            _SafeStr_591 = false;
        }

        private function interstitialCompleteEventHandler(_arg_1:InterstitialEvent):void
        {
            var _local_4:IRoomSession;
            _SafeStr_591 = false;
            if (_arg_1.status == "complete")
            {
                _communication.connection.send(new InterstitialShownMessageComposer());
            };
            var _local_2:String = getRoomIdentifier(_SafeStr_589);
            var _local_3:RoomDesktop = (getDesktop(_local_2) as RoomDesktop);
            if (_local_3 != null)
            {
                _local_3.processEvent(_arg_1);
                _local_4 = _roomSessionManager.getSession(_roomEngine.activeRoomId);
                if (_local_4 != null)
                {
                    _local_4.sendChangePostureMessage(0);
                };
            };
        }

        private function adEventHandler(_arg_1:AdEvent):void
        {
            var _local_2:String = getRoomIdentifier(_arg_1.roomId);
            var _local_3:RoomDesktop = (getDesktop(_local_2) as RoomDesktop);
            if (_local_3 != null)
            {
                _local_3.processEvent(_arg_1);
            };
        }

        private function onPerkAllowances(_arg_1:PerkAllowancesMessageEvent):void
        {
            var _local_3:Timer;
            var _local_2:String;
            var _local_4:RoomDesktop;
            if (((((_freeFlowChat) && (!(_freeFlowChat.isDisabledInPreferences))) && (_isInRoom)) && (!(_SafeStr_590))))
            {
                _local_3 = new Timer(250, 1);
                _local_3.addEventListener("timerComplete", delayedAddToStageFreeFlowChat);
                _local_3.start();
            };
            if (_isInRoom)
            {
                _local_2 = getRoomIdentifier(_roomEngine.activeRoomId);
                _local_4 = (getDesktop(_local_2) as RoomDesktop);
                if (_local_4 != null)
                {
                    _local_4.processEvent(new RoomDesktopMouseZoomEnableEvent(_arg_1.getParser().isPerkAllowed("MOUSE_ZOOM")));
                };
            };
        }

        private function delayedAddToStageFreeFlowChat(_arg_1:TimerEvent):void
        {
            var _local_2:RoomDesktop = (getDesktop(getRoomIdentifier(_roomEngine.activeRoomId)) as RoomDesktop);
            if (((_local_2) && (_freeFlowChat.displayObject)))
            {
                _local_2.layoutManager.getChatContainer().setDisplayObject(_freeFlowChat.displayObject);
                _SafeStr_590 = true;
            };
        }

        private function roomEngineEventHandler(_arg_1:RoomEngineEvent):void
        {
            var _local_2:String;
            var _local_3:RoomDesktop;
            var _local_4:IRoomSession;
            if (((_arg_1.type == "REE_GAME_MODE") || (_arg_1.type == "REE_NORMAL_MODE")))
            {
                _local_2 = getRoomIdentifier(_arg_1.roomId);
                _local_3 = (getDesktop(_local_2) as RoomDesktop);
                if (_local_3 != null)
                {
                    _local_3.roomEngineEventHandler(_arg_1);
                };
            };
            if (_arg_1.roomId == _SafeStr_589)
            {
                if (_arg_1.type == "REE_OBJECTS_INITIALIZED")
                {
                    if (_SafeStr_591 == true)
                    {
                        _local_4 = _roomSessionManager.getSession(_SafeStr_589);
                        if (_local_4 != null)
                        {
                            _local_4.sendAvatarExpressionMessage(AvatarExpressionEnum._SafeStr_592.ordinal);
                        };
                    };
                    _SafeStr_591 = false;
                }
                else
                {
                    if (_arg_1.type == "REE_DISPOSED")
                    {
                        _SafeStr_591 = false;
                    };
                };
            };
        }

        private function roomEventHandler(_arg_1:RoomEngineEvent):void
        {
            var _local_5:IRoomSession;
            var _local_6:RoomEngineRoomColorEvent;
            var _local_3:RoomEngineZoomEvent;
            var _local_7:RoomEngineHSLColorEnableEvent;
            if (_roomEngine == null)
            {
                return;
            };
            var _local_2:String = getRoomIdentifier(_arg_1.roomId);
            var _local_4:RoomDesktop = (getDesktop(_local_2) as RoomDesktop);
            if (_local_4 == null)
            {
                if (_roomSessionManager == null)
                {
                    return;
                };
                _local_5 = _roomSessionManager.getSession(_arg_1.roomId);
                if (_local_5 != null)
                {
                    _local_4 = (createDesktop(_local_5) as RoomDesktop);
                };
            };
            if (_local_4 == null)
            {
                return;
            };
            switch (_arg_1.type)
            {
                case "REE_INITIALIZED":
                    _local_4.createRoomView(getActiveCanvasId(_arg_1.roomId));
                    if (((!(_roomEngine == null)) && (!(RoomId.isRoomPreviewerId(_arg_1.roomId)))))
                    {
                        _roomEngine.setActiveRoom(_arg_1.roomId);
                    };
                    _local_4.disposeWidget("RWE_ROOM_QUEUE");
                    _local_4.createWidget("RWE_CHAT_WIDGET");
                    if (((_freeFlowChat) && (!(_freeFlowChat.isDisabledInPreferences))))
                    {
                        _SafeStr_590 = true;
                        if (_freeFlowChat.displayObject != null)
                        {
                            _local_4.layoutManager.getChatContainer().setDisplayObject(_freeFlowChat.displayObject);
                        };
                    };
                    _local_4.createWidget("RWE_INFOSTAND");
                    _local_4.createWidget("RWE_LOCATION_WIDGET");
                    _local_4.createWidget("RWE_ROOM_TOOLS");
                    if (!_local_4.session.isSpectatorMode)
                    {
                        _local_4.createWidget("RWE_ME_MENU");
                        _local_4.createWidget("RWE_CHAT_INPUT_WIDGET");
                        _local_4.createWidget("RWE_FRIEND_REQUEST");
                        if (getBoolean("avatar.widget.enabled"))
                        {
                            _local_4.createWidget("RWE_AVATAR_INFO");
                        };
                    };
                    _local_4.createWidget("RWE_FURNI_PLACEHOLDER");
                    _local_4.createWidget("RWE_FURNI_CREDIT_WIDGET");
                    _local_4.createWidget("RWE_FURNI_STICKIE_WIDGET");
                    _local_4.createWidget("RWE_FURNI_PRESENT_WIDGET");
                    _local_4.createWidget("RWE_FURNI_TROPHY_WIDGET");
                    _local_4.createWidget("RWE_FURNI_ECOTRONBOX_WIDGET");
                    _local_4.createWidget("RWE_FURNI_PET_PACKAGE_WIDGET");
                    _local_4.createWidget("RWE_DOORBELL");
                    _local_4.createWidget("RWE_ROOM_POLL");
                    _local_4.createWidget("RWE_ROOM_DIMMER");
                    _local_4.createWidget("RWE_CLOTHING_CHANGE");
                    _local_4.createWidget("RWE_CONVERSION_TRACKING");
                    if (!getBoolean("memenu.effects.widget.disabled"))
                    {
                        _local_4.createWidget("RWE_EFFECTS");
                    };
                    _local_4.createWidget("RWE_MANNEQUIN");
                    _local_4.createWidget("RWE_ROOM_BACKGROUND_COLOR");
                    _local_4.createWidget("RWE_CUSTOM_USER_NOTIFICATION");
                    _local_4.createWidget("RWE_FURNI_CHOOSER");
                    _local_4.createWidget("RWE_USER_CHOOSER");
                    if (_SafeStr_593 != -1)
                    {
                        _local_4.initializeWidget("RWE_USER_CHOOSER", _SafeStr_593);
                    };
                    _local_4.createWidget("RWE_PLAYLIST_EDITOR_WIDGET");
                    _local_4.createWidget("RWE_SPAMWALL_POSTIT_WIDGET");
                    _local_4.createWidget("RWE_FURNITURE_CONTEXT_MENU");
                    _local_4.createWidget("RWE_CAMERA");
                    _local_4.createWidget("RWE_FURNI_ACHIEVEMENT_RESOLUTION_ENGRAVING");
                    _local_4.createWidget("RWE_FRIEND_FURNI_CONFIRM");
                    _local_4.createWidget("RWE_FRIEND_FURNI_ENGRAVING");
                    _local_4.createWidget("RWE_HIGH_SCORE_DISPLAY");
                    _local_4.createWidget("RWE_INTERNAL_LINK");
                    _local_4.createWidget("RWE_CUSTOM_STACK_HEIGHT");
                    _local_4.createWidget("RWE_YOUTUBE");
                    _local_4.createWidget("RWE_RENTABLESPACE");
                    _local_4.createWidget("RWE_VIMEO");
                    _local_4.createWidget("RWE_EXTERNAL_IMAGE");
                    _local_4.createWidget("RWE_UI_HELP_BUBBLE");
                    _local_4.createWidget("RWE_WORD_QUIZZ");
                    _local_4.createWidget("RWE_ROOM_THUMBNAIL_CAMERA");
                    _local_4.createWidget("RWE_ROOM_LINK");
                    _local_4.createWidget("RWE_CRAFTING");
                    _isInRoom = true;
                    return;
                case "REE_DISPOSED":
                    disposeDesktop(_local_2);
                    _isInRoom = false;
                    return;
                case "REE_ROOM_COLOR":
                    _local_6 = (_arg_1 as RoomEngineRoomColorEvent);
                    if (_local_6 == null) break;
                    if (_local_6.bgOnly)
                    {
                        _local_4.setRoomViewColor(0xFFFFFF, 0xFF);
                    }
                    else
                    {
                        _local_4.setRoomViewColor(_local_6.color, _local_6.brightness);
                    };
                    return;
                case "REE_ROOM_ZOOM":
                    _local_3 = (_arg_1 as RoomEngineZoomEvent);
                    if (_local_3 == null) break;
                    _roomEngine.setRoomCanvasScale(_roomEngine.activeRoomId, getActiveCanvasId(_roomEngine.activeRoomId), ((_local_3.level < 1) ? 0.5 : (1 << (Math.floor(_local_3.level) - 1))), null, null, _local_3.isFlipForced);
                    return;
                case "REDSE_ROOM_COLOR":
                    _local_4.processEvent(_arg_1);
                    return;
                case "ROHSLCEE_ROOM_BACKGROUND_COLOR":
                    _local_7 = RoomEngineHSLColorEnableEvent(_arg_1);
                    if (!_local_7.enable)
                    {
                        _local_4.setRoomBackgroundColor(0, 0, 0);
                    }
                    else
                    {
                        _local_4.setRoomBackgroundColor(_local_7.hue, _local_7.saturation, _local_7.lightness);
                    };
                    return;
            };
        }

        private function roomObjectEventHandler(_arg_1:RoomEngineObjectEvent):void
        {
            if (_roomEngine == null)
            {
                return;
            };
            var _local_2:String = getRoomIdentifier(_arg_1.roomId);
            var _local_3:RoomDesktop = (getDesktop(_local_2) as RoomDesktop);
            if (_local_3 != null)
            {
                _local_3.roomObjectEventHandler(_arg_1);
            };
        }

        private function gameEventHandler(_arg_1:Event):void
        {
            var _local_2:RoomDesktop = (getDesktop(getRoomIdentifier(0)) as RoomDesktop);
            if (_local_2)
            {
                _local_2.processEvent(_arg_1);
            };
        }

        public function createDesktop(_arg_1:IRoomSession):IRoomDesktop
        {
            if (_arg_1 == null)
            {
                return (null);
            };
            if (_roomEngine == null)
            {
                return (null);
            };
            var _local_3:String = getRoomIdentifier(_arg_1.roomId);
            var _local_2:RoomDesktop = (getDesktop(_local_3) as RoomDesktop);
            if (_local_2 != null)
            {
                return (_local_2);
            };
            _local_2 = new RoomDesktop(_arg_1, assets, _communication.connection);
            _local_2.roomEngine = _roomEngine;
            _local_2.windowManager = _windowManager;
            _local_2.roomWidgetFactory = _SafeStr_587;
            _local_2.sessionDataManager = _sessionDataManager;
            _local_2.roomSessionManager = _roomSessionManager;
            _local_2.communicationManager = _communication;
            _local_2.friendList = _friendList;
            _local_2.avatarRenderManager = _avatarRenderManager;
            _local_2.inventory = _inventory;
            _local_2.messenger = _messenger;
            _local_2.toolbar = _toolbar;
            _local_2.navigator = _newNavigator.legacyNavigator;
            _local_2.habboGroupsManager = _habboGroupsManager;
            _local_2.avatarEditor = _avatarEditor;
            _local_2.catalog = _catalog;
            _local_2.adManager = _adManager;
            _local_2.localization = _localization;
            _local_2.habboHelp = _habboHelp;
            _local_2.moderation = _moderation;
            _local_2.config = this;
            _local_2.soundManager = _soundManager;
            _local_2.habboTracking = _habboTracking;
            _local_2.userDefinedRoomEvents = _userDefinedRoomEvents;
            _local_2.gameManager = _gameManager;
            _local_2.questEngine = _questEngine;
            _local_2.freeFlowChat = _freeFlowChat;
            var _local_4:XmlAsset = (assets.getAssetByName("room_desktop_layout_xml") as XmlAsset);
            if (_local_4 != null)
            {
                _local_2.layout = (_local_4.content as XML);
            };
            _local_2.createWidget("RWE_LOADINGBAR");
            _local_2.createWidget("RWE_ROOM_QUEUE");
            _local_2.init();
            _local_2.requestInterstitial();
            _SafeStr_591 = false;
            _SafeStr_589 = _arg_1.roomId;
            _SafeStr_588.add(_local_3, _local_2);
            return (_local_2);
        }

        public function get chatContainer():IDisplayObjectWrapper
        {
            var _local_1:RoomDesktop = (getDesktop(getRoomIdentifier(_roomEngine.activeRoomId)) as RoomDesktop);
            if (((!(_local_1)) || (!(_local_1.layoutManager))))
            {
                return (null);
            };
            return (_local_1.layoutManager.getChatContainer());
        }

        public function disposeDesktop(_arg_1:String):void
        {
            var _local_2:int;
            var _local_3:RoomDesktop = (_SafeStr_588.remove(_arg_1) as RoomDesktop);
            if (_local_3 != null)
            {
                _local_2 = _local_3.getWidgetState("RWE_USER_CHOOSER");
                if (_local_2 != -1)
                {
                    _SafeStr_593 = _local_2;
                };
                _local_3.dispose();
                _SafeStr_591 = false;
            };
        }

        public function getDesktop(_arg_1:String):IRoomDesktop
        {
            return (_SafeStr_588.getValue(_arg_1) as RoomDesktop);
        }

        public function getActiveCanvasId(_arg_1:int):int
        {
            return (1);
        }

        public function update(_arg_1:uint):void
        {
            var _local_3:int;
            var _local_2:RoomDesktop;
            _local_3 = 0;
            while (_local_3 < _SafeStr_588.length)
            {
                _local_2 = (_SafeStr_588.getWithIndex(_local_3) as RoomDesktop);
                if (_local_2 != null)
                {
                    _local_2.update();
                };
                _local_3++;
            };
        }

        private function getRoomIdentifier(_arg_1:int):String
        {
            return ("hard_coded_room_id");
        }

        public function set visible(_arg_1:Boolean):void
        {
            var _local_2:RoomDesktop = _SafeStr_588.getValue(getRoomIdentifier(_roomEngine.activeRoomId));
            if (_local_2 != null)
            {
                _local_2.visible = _arg_1;
            };
        }

        public function hideWidget(_arg_1:String):void
        {
            var _local_2:RoomDesktop = _SafeStr_588.getValue(getRoomIdentifier(_roomEngine.activeRoomId));
            if (_local_2 != null)
            {
                _local_2.processEvent(new HideRoomWidgetEvent(_arg_1));
            };
        }

        public function showGamePlayerName(_arg_1:int, _arg_2:String, _arg_3:uint, _arg_4:int):void
        {
            var _local_5:RoomDesktop = _SafeStr_588.getValue(getRoomIdentifier(_roomEngine.activeRoomId));
            if (_local_5 != null)
            {
                _local_5.showGamePlayerName(_arg_1, _arg_2, _arg_3, _arg_4);
            };
        }

        public function mouseEventPositionHasContextMenu(_arg_1:MouseEvent):Boolean
        {
            var _local_2:RoomDesktop = _SafeStr_588.getValue(getRoomIdentifier(_roomEngine.activeRoomId));
            if (_local_2 != null)
            {
                return (_local_2.mouseEventPositionHasInputEventWindow(_arg_1, 0));
            };
            return (false);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (_localization);
        }

        public function get catalog():IHabboCatalog
        {
            return (_catalog);
        }

        public function get inventory():IHabboInventory
        {
            return (_inventory);
        }

        public function get roomEngine():IRoomEngine
        {
            return (_roomEngine);
        }

        public function get soundManager():IHabboSoundManager
        {
            return (_soundManager);
        }

        public function get habboTracking():IHabboTracking
        {
            return (_habboTracking);
        }

        public function get habboGroupsManager():IHabboGroupsManager
        {
            return (_habboGroupsManager);
        }

        public function get friendBarView():IHabboFriendBarView
        {
            return (_friendBarView);
        }

        public function get toolbar():IHabboToolbar
        {
            return (_toolbar);
        }

        public function get chatStyleLibrary():IChatStyleLibrary
        {
            if (_freeFlowChat)
            {
                return (_freeFlowChat.chatStyleLibrary);
            };
            return (null);
        }

        public function get freeFlowChat():IHabboFreeFlowChat
        {
            return (_freeFlowChat);
        }

        public function get habboHelp():IHabboHelp
        {
            return (_habboHelp);
        }


    }
}