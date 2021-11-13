package com.sulake.habbo.help
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.events.ILinkEventTracker;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.help.cfh.registry.chat.ChatEventHandler;
    import com.sulake.habbo.help.cfh.registry.instantmessage.InstantMessageEventHandler;
    import com.sulake.habbo.help.cfh.registry.user.UserRegistry;
    import com.sulake.habbo.help.cfh.registry.chat.ChatRegistry;
    import com.sulake.habbo.help.cfh.registry.instantmessage.InstantMessageRegistry;
    import com.sulake.habbo.help.namechange.NameChangeController;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.callforhelp.CallForHelpCategoryData;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDHabboNavigator;
    import com.sulake.iid.IIDHabboTracking;
    import com.sulake.iid.IIDHabboSoundManager;
    import com.sulake.iid.IIDHabboFriendList;
    import com.sulake.habbo.communication.messages.incoming.callforhelp.CfhTopicsInitMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.GuideReportingStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
    import com.sulake.habbo.communication.messages.incoming.callforhelp.SanctionStatusEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UsersMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2StageStartingMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpPendingCallsDeletedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpDisabledNotifyMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpPendingCallsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageEvent;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.habbo.window.utils.IModalDialog;
    import com.sulake.habbo.communication.messages.outgoing.help.GetPendingCallsForHelpMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.talent._SafeStr_36;
    import com.sulake.habbo.communication.messages.outgoing.help.GetGuideReportingStatusMessageComposer;
    import com.sulake.habbo.communication.messages.parser.help.CallForHelpPendingCallsMessageParser;
    import com.sulake.habbo.communication.messages.parser.help.GuideReportingStatusMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.RemoveFriendMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.IgnoreUserIdMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserMessageData;
    import com.sulake.habbo.communication.messages.parser.room.engine.UsersMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.object.HumanGameObjectData;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2StageStartingMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.GetGuestRoomResultMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
    import com.sulake.habbo.communication.messages.parser.callforhelp.CfhTopicsInitMessageParser;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.communication.messages.outgoing.help.GetCfhStatusMessageComposer;
    import com.sulake.habbo.utils.StringUtil;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;

    public class HabboHelp extends Component implements IHabboHelp, ILinkEventTracker
    {

        public static const REPORT_TYPE_EMERGENCY:int = 1;
        public static const REPORT_TYPE_GUIDE:int = 2;
        public static const REPORT_TYPE_IM:int = 3;
        public static const REPORT_TYPE_ROOM:int = 4;
        public static const REPORT_TYPE_BULLY:int = 6;
        public static const REPORT_TYPE_THREAD:int = 7;
        public static const REPORT_TYPE_MESSAGE:int = 8;
        public static const REPORT_TYPE_PHOTO:int = 9;

        private var _toolbar:IHabboToolbar;
        private var _windowManager:IHabboWindowManager;
        private var _communicationManager:IHabboCommunicationManager;
        private var _localizationManager:IHabboLocalizationManager;
        private var _roomSessionManager:IRoomSessionManager;
        private var _sessionDataManager:ISessionDataManager;
        private var _navigator:IHabboNavigator;
        private var _tracking:IHabboTracking;
        private var _soundManager:IHabboSoundManager;
        private var _friendList:IHabboFriendList;
        private var _messageEvents:Vector.<IMessageEvent>;
        private var _SafeStr_472:ChatEventHandler;
        private var _SafeStr_2691:InstantMessageEventHandler;
        private var _guideHelpManager:GuideHelpManager;
        private var _userRegistry:UserRegistry = new UserRegistry();
        private var _chatRegistry:ChatRegistry = new ChatRegistry();
        private var _instantMessageRegistry:InstantMessageRegistry = new InstantMessageRegistry();
        private var _SafeStr_557:NameChangeController;
        private var _callForHelpManager:CallForHelpManager;
        private var _SafeStr_558:WelcomeScreenController;
        private var _SafeStr_559:HabboWayController;
        private var _SafeStr_561:HabboWayQuizController;
        private var _SafeStr_560:SafetyBookletController;
        private var _outsideRoom:Boolean;
        private var _SafeStr_562:int;
        private var _reportMessage:IMessageComposer;
        private var _SafeStr_2692:int = -1;
        private var _SafeStr_555:int;
        private var _callForHelpCategories:Vector.<CallForHelpCategoryData>;
        private var _SafeStr_556:TopicsFlowHelpController;
        private var _sanctionInfo:SanctionInfo;

        public function HabboHelp(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (_localizationManager);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get toolbar():IHabboToolbar
        {
            return (_toolbar);
        }

        public function get roomSessionManager():IRoomSessionManager
        {
            return (_roomSessionManager);
        }

        public function get sessionDataManager():ISessionDataManager
        {
            return (_sessionDataManager);
        }

        public function get communicationManager():IHabboCommunicationManager
        {
            return (_communicationManager);
        }

        public function get navigator():IHabboNavigator
        {
            return (_navigator);
        }

        public function get tracking():IHabboTracking
        {
            return (_tracking);
        }

        public function get soundManager():IHabboSoundManager
        {
            return (_soundManager);
        }

        public function get newUserTourEnabled():Boolean
        {
            return (getBoolean("guide.help.new.user.tour.enabled"));
        }

        public function get newIdentity():Boolean
        {
            return (getInteger("new.identity", 0) > 0);
        }

        public function get citizenshipEnabled():Boolean
        {
            return (getBoolean("talent.track.citizenship.enabled"));
        }

        public function get safetyQuizDisabled():Boolean
        {
            return (getBoolean("safety_quiz.disabled"));
        }

        public function requestGuide():void
        {
            if (getBoolean("guides.enabled"))
            {
                _guideHelpManager.createHelpRequest(0);
            };
        }

        public function reportBully(_arg_1:int):void
        {
            if (_callForHelpManager != null)
            {
                _callForHelpManager.reportBully(_arg_1, _SafeStr_555);
            };
        }

        public function startPhotoReportingInNewCfhFlow(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:int):void
        {
            if (_callForHelpManager != null)
            {
                _callForHelpManager.reportedRoomId = _SafeStr_555;
                _callForHelpManager.reportedUserId = _arg_1;
                _callForHelpManager.reportedUserName = _arg_2;
                _callForHelpManager.reportedRoomObjectId = _arg_4;
                _callForHelpManager.reportedExtraDataId = _arg_3;
                _SafeStr_556.openReportingContentReasonCategory(9);
            };
        }

        public function reportUser(_arg_1:int, _arg_2:int, _arg_3:String):void
        {
            _callForHelpManager.reportedUserId = _arg_1;
            _SafeStr_556.openReportingChatLineSelection();
        }

        public function reportUserName(_arg_1:int, _arg_2:String):void
        {
            _callForHelpManager.reportedUserId = _arg_1;
            _callForHelpManager.reportedUserName = _arg_2;
            _callForHelpManager.reportedRoomId = -1;
            _SafeStr_556.openReportingUserName();
        }

        public function reportUserFromIM(_arg_1:int):void
        {
            if (_callForHelpManager != null)
            {
                _callForHelpManager.reportedUserId = _arg_1;
                _SafeStr_556.openReportingIMSelection();
            };
        }

        public function reportRoom(_arg_1:int, _arg_2:String, _arg_3:String):void
        {
            if (_callForHelpManager != null)
            {
                _callForHelpManager.reportedRoomId = _arg_1;
                _callForHelpManager.reportedRoomName = _arg_2;
                _callForHelpManager.reportedUserId = -1;
                _callForHelpManager.reportedUserName = "";
                _SafeStr_556.openReportingContentReasonCategory(4);
            };
        }

        public function reportThread(_arg_1:int, _arg_2:int):void
        {
            if (_callForHelpManager != null)
            {
                _callForHelpManager.reportedGroupId = _arg_1;
                _callForHelpManager.reportedThreadId = _arg_2;
                _SafeStr_556.openReportingContentReasonCategory(7);
            };
        }

        public function reportSelfie(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:int):Boolean
        {
            if (_callForHelpManager != null)
            {
                if (_arg_2.length < getInteger("help.cfh.length.minimum", 15))
                {
                    windowManager.alert("${generic.alert.title}", "${help.cfh.error.msgtooshort}", 0, null);
                    return (false);
                };
                _callForHelpManager.reportSelfie(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
                return (true);
            };
            return (false);
        }

        public function reportPhoto(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int):Boolean
        {
            if (_callForHelpManager != null)
            {
                if (_arg_2 == 0)
                {
                    windowManager.alert("${generic.alert.title}", "${help.cfh.error.notopic}", 0, null);
                    return (false);
                };
                _callForHelpManager.reportPhoto(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
                return (true);
            };
            return (false);
        }

        public function reportMessage(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            if (_callForHelpManager != null)
            {
                _callForHelpManager.reportedGroupId = _arg_1;
                _callForHelpManager.reportedThreadId = _arg_2;
                _callForHelpManager.reportedMessageId = _arg_3;
                _SafeStr_556.openReportingContentReasonCategory(8);
            };
        }

        public function startNameChange():void
        {
            if (_SafeStr_557 != null)
            {
                _SafeStr_557.showView();
            };
        }

        public function startEmergencyRequest():void
        {
            if (_callForHelpManager != null)
            {
                _callForHelpManager.openEmergencyHelpRequest();
            };
        }

        public function showWelcomeScreen(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:String=null):void
        {
            if (((_SafeStr_558 == null) || (_SafeStr_558.disposed)))
            {
                _SafeStr_558 = new WelcomeScreenController(this);
            };
            _SafeStr_558.showWelcomeScreen(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        public function showHabboWay():void
        {
            if (!_SafeStr_559)
            {
                _SafeStr_559 = new HabboWayController(this);
            };
            _SafeStr_559.showHabboWay();
        }

        public function closeHabboWay():void
        {
            if (_SafeStr_559 != null)
            {
                _SafeStr_559.closeWindow();
            };
        }

        public function showSafetyBooklet():void
        {
            if (!_SafeStr_560)
            {
                _SafeStr_560 = new SafetyBookletController(this);
            };
            _SafeStr_560.openSafetyBooklet();
        }

        public function closeSafetyBooklet():void
        {
            if (_SafeStr_560 != null)
            {
                _SafeStr_560.closeWindow();
            };
        }

        public function showHabboWayQuiz():void
        {
            if (((_SafeStr_561 == null) || (_SafeStr_561.disposed)))
            {
                _SafeStr_561 = new HabboWayQuizController(this);
            };
            _SafeStr_561.showHabboWayQuiz();
        }

        public function showSafetyQuiz():void
        {
            if (((_SafeStr_561 == null) || (_SafeStr_561.disposed)))
            {
                _SafeStr_561 = new HabboWayQuizController(this);
            };
            _SafeStr_561.showSafetyQuiz();
        }

        public function showTourPopup():void
        {
            _guideHelpManager.openTourPopup();
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(), function (_arg_1:IHabboWindowManager):void
            {
                _windowManager = _arg_1;
            }), new ComponentDependency(new IIDSessionDataManager(), function (_arg_1:ISessionDataManager):void
            {
                _sessionDataManager = _arg_1;
            }, false), new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communicationManager = _arg_1;
            }), new ComponentDependency(new IIDHabboToolbar(), function (_arg_1:IHabboToolbar):void
            {
                _toolbar = _arg_1;
            }, true, [{
                "type":"HTE_TOOLBAR_CLICK",
                "callback":onHabboToolbarEvent
            }, {
                "type":"HTE_GROUP_ROOM_INFO_CLICK",
                "callback":onHabboToolbarEvent
            }, {
                "type":"HTE_RESIZED",
                "callback":onHabboToolbarEvent
            }]), new ComponentDependency(new IIDHabboLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                _localizationManager = _arg_1;
            }), new ComponentDependency(new IIDHabboRoomSessionManager(), function (_arg_1:IRoomSessionManager):void
            {
                _roomSessionManager = _arg_1;
            }, true), new ComponentDependency(new IIDHabboNavigator(), function (_arg_1:IHabboNavigator):void
            {
                _navigator = _arg_1;
            }, false), new ComponentDependency(new IIDHabboTracking(), function (_arg_1:IHabboTracking):void
            {
                _tracking = _arg_1;
            }, false), new ComponentDependency(new IIDHabboSoundManager(), function (_arg_1:IHabboSoundManager):void
            {
                _soundManager = _arg_1;
            }, false), new ComponentDependency(new IIDHabboFriendList(), function (_arg_1:IHabboFriendList):void
            {
                _friendList = _arg_1;
            }, false)]));
        }

        override protected function initComponent():void
        {
            _messageEvents = new Vector.<IMessageEvent>(0);
            addMessageEvent(new CfhTopicsInitMessageEvent(onCfhTopics));
            addMessageEvent(new GuideReportingStatusMessageEvent(onGuideReportingStatus));
            addMessageEvent(new GetGuestRoomResultEvent(onGuestRoomResult));
            addMessageEvent(new SanctionStatusEvent(onSanctionStatusEvent));
            addMessageEvent(new UsersMessageEvent(onUsers));
            addMessageEvent(new Game2StageStartingMessageEvent(onGameStageStarting));
            addMessageEvent(new CallForHelpPendingCallsDeletedMessageEvent(onPendingCallsForHelpDeleted));
            addMessageEvent(new CallForHelpDisabledNotifyMessageEvent(onCallForHelpDisabledNotify));
            addMessageEvent(new CallForHelpPendingCallsMessageEvent(onPendingCallsForHelp));
            addMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
            addMessageEvent(new RoomReadyMessageEvent(onRoomReady));
            _SafeStr_472 = new ChatEventHandler(this);
            _guideHelpManager = new GuideHelpManager(this);
            _callForHelpManager = new CallForHelpManager(this);
            _SafeStr_557 = new NameChangeController(this);
            _SafeStr_2691 = new InstantMessageEventHandler(this);
            _SafeStr_556 = new TopicsFlowHelpController(this);
            _sanctionInfo = new SanctionInfo(this);
            context.addLinkEventTracker(this);
            if (((getBoolean("show.sanction.info.on.login")) && (Math.random() < 0.2)))
            {
                requestSanctionInfo(true);
            };
        }

        public function addMessageEvent(_arg_1:IMessageEvent):void
        {
            _messageEvents.push(_communicationManager.addHabboConnectionMessageEvent(_arg_1));
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            if (((!(_messageEvents == null)) && (!(_communicationManager == null))))
            {
                for each (var _local_1:IMessageEvent in _messageEvents)
                {
                    _communicationManager.removeHabboConnectionMessageEvent(_local_1);
                };
            };
            if (_SafeStr_560 != null)
            {
                _SafeStr_560.dispose();
                _SafeStr_560 = null;
            };
            if (_SafeStr_559 != null)
            {
                _SafeStr_559.dispose();
                _SafeStr_559 = null;
            };
            if (_SafeStr_558 != null)
            {
                _SafeStr_558.dispose();
                _SafeStr_558 = null;
            };
            if (_SafeStr_557 != null)
            {
                _SafeStr_557.dispose();
                _SafeStr_557 = null;
            };
            if (_guideHelpManager)
            {
                _guideHelpManager.dispose();
                _guideHelpManager = null;
            };
            if (_callForHelpManager)
            {
                _callForHelpManager.dispose();
                _callForHelpManager = null;
            };
            if (_SafeStr_561)
            {
                _SafeStr_561.dispose();
                _SafeStr_561 = null;
            };
            if (_SafeStr_556)
            {
                _SafeStr_556.dispose();
                _SafeStr_556 = null;
            };
            if (_sanctionInfo)
            {
                _sanctionInfo.dispose();
                _sanctionInfo = null;
            };
            super.dispose();
        }

        public function getXmlWindow(_arg_1:String, _arg_2:uint=1):IWindow
        {
            var _local_5:IAsset;
            var _local_3:XmlAsset;
            var _local_4:IWindow;
            try
            {
                _local_5 = assets.getAssetByName((_arg_1 + "_xml"));
                _local_3 = XmlAsset(_local_5);
                _local_4 = _windowManager.buildFromXML(XML(_local_3.content), _arg_2);
            }
            catch(e:Error)
            {
                ErrorReportStorage.addDebugData("HabboNavigator", (((((("Failed to build window " + _arg_1) + "_xml, ") + _local_5) + ", ") + _windowManager) + "!"));
                throw (e);
            };
            return (_local_4);
        }

        public function getModalXmlWindow(_arg_1:String):IModalDialog
        {
            var _local_4:IAsset;
            var _local_2:XmlAsset;
            var _local_3:IModalDialog;
            try
            {
                _local_4 = assets.getAssetByName((_arg_1 + "_xml"));
                _local_2 = XmlAsset(_local_4);
                _local_3 = _windowManager.buildModalDialogFromXML(XML(_local_2.content));
            }
            catch(e:Error)
            {
                ErrorReportStorage.addDebugData("HabboNavigator", (((((("Failed to build window " + _arg_1) + "_xml, ") + _local_4) + ", ") + _windowManager) + "!"));
                throw (e);
            };
            return (_local_3);
        }

        public function trackGoogle(_arg_1:String, _arg_2:String, _arg_3:int=-1):void
        {
            if (_tracking)
            {
                _tracking.trackGoogle(_arg_1, _arg_2, _arg_3);
            };
        }

        public function setReportMessage(_arg_1:IMessageComposer):void
        {
            _reportMessage = _arg_1;
        }

        public function sendMessage(_arg_1:IMessageComposer):void
        {
            if (((!(_communicationManager == null)) && (!(_arg_1 == null))))
            {
                _communicationManager.connection.send(_arg_1);
            };
        }

        public function get ownUserName():String
        {
            return (_SafeStr_557.ownUserName);
        }

        public function get ownUserId():int
        {
            return (_SafeStr_557.ownUserId);
        }

        public function get outsideRoom():Boolean
        {
            return (_outsideRoom);
        }

        public function set outsideRoom(_arg_1:Boolean):void
        {
            _outsideRoom = _arg_1;
        }

        public function queryForPendingCallsForHelp(_arg_1:int):void
        {
            _SafeStr_562 = _arg_1;
            sendMessage(new GetPendingCallsForHelpMessageComposer());
        }

        public function queryForGuideReportingStatus(_arg_1:int):void
        {
            _SafeStr_2692 = _arg_1;
            sendMessage(new _SafeStr_36());
            sendMessage(new GetGuideReportingStatusMessageComposer());
        }

        private function onPendingCallsForHelp(_arg_1:IMessageEvent):void
        {
            var _local_4:String;
            var _local_3:int;
            var _local_2:CallForHelpPendingCallsMessageParser = CallForHelpPendingCallsMessageEvent(_arg_1).getParser();
            if (((_local_2.callCount == 0) || ((_SafeStr_562 == 9) && (_local_2.callCount < 3))))
            {
                proceedWithReporting();
            }
            else
            {
                _local_4 = "";
                _local_3 = 0;
                while (((_local_3 < _local_2.callArray.length) && (_local_3 < 10)))
                {
                    _local_4 = (_local_4 + _local_2.callArray[_local_3].message);
                    if (((_local_3 < (_local_2.callArray.length - 1)) && (_local_3 < 9)))
                    {
                        _local_4 = (_local_4 + "\n");
                    };
                    _local_3++;
                };
                _callForHelpManager.showPendingRequest(_local_4);
            };
        }

        private function onPendingCallsForHelpDeleted(_arg_1:IMessageEvent):void
        {
            _SafeStr_556.submitCallForHelp(false);
        }

        private function onGuideReportingStatus(_arg_1:GuideReportingStatusMessageEvent):void
        {
            var _local_2:GuideReportingStatusMessageParser = _arg_1.getParser();
            switch (_local_2.statusCode)
            {
                case 0:
                    toggleNewHelpWindow();
                    return;
                case 1:
                    _guideHelpManager.showPendingTicket(_local_2.pendingTicket);
                    return;
                default:
                    _guideHelpManager.showFeedback(_local_2.localizationCode);
            };
        }

        private function proceedWithReporting():void
        {
            switch (_SafeStr_562)
            {
                case 1:
                case 3:
                case 4:
                case 7:
                case 8:
                    _callForHelpManager.showEmergencyHelpRequest(_SafeStr_562);
                    break;
                case 2:
                    _guideHelpManager.openReportWindow();
                    break;
                case 9:
                    if (_reportMessage != null)
                    {
                        sendMessage(_reportMessage);
                        _reportMessage = null;
                    };
                default:
            };
            _SafeStr_562 = 0;
        }

        private function onCallForHelpDisabledNotify(_arg_1:CallForHelpDisabledNotifyMessageEvent):void
        {
            _windowManager.simpleAlert("${help.emergency.global_mute.caption}", "${help.emergency.global_mute.subtitle}", "${help.emergency.global_mute.message}", "${help.emergency.global_mute.link}", _arg_1.getParser().infoUrl);
        }

        public function get friendList():IHabboFriendList
        {
            return (_friendList);
        }

        public function ignoreAndUnfriendReportedUser():void
        {
            var _local_1:RemoveFriendMessageComposer;
            if (_callForHelpManager.reportedUserId > 0)
            {
                sendMessage(new IgnoreUserIdMessageComposer(_callForHelpManager.reportedUserId));
                if (_friendList.getFriend(_callForHelpManager.reportedUserId) != null)
                {
                    _local_1 = new RemoveFriendMessageComposer();
                    _local_1.addRemovedFriend(_callForHelpManager.reportedUserId);
                    sendMessage(_local_1);
                };
            };
        }

        private function onUsers(_arg_1:IMessageEvent):void
        {
            var _local_3:int;
            var _local_4:UserMessageData;
            var _local_2:UsersMessageParser = UsersMessageEvent(_arg_1).getParser();
            _local_3 = 0;
            while (_local_3 < _local_2.getUserCount())
            {
                _local_4 = _local_2.getUser(_local_3);
                if (((!(_local_4.webID == ownUserId)) && (_local_4.userType == 1)))
                {
                    _userRegistry.registerUser(_local_4.webID, _local_4.name, _local_4.figure);
                };
                _local_3++;
            };
        }

        private function onGameStageStarting(_arg_1:Game2StageStartingMessageEvent):void
        {
            var _local_6:HumanGameObjectData;
            var _local_2:Game2StageStartingMessageParser = _arg_1.getParser();
            var _local_5:Array = _local_2.gameObjects.gameObjects;
            var _local_4:int = _userRegistry.roomId;
            var _local_3:String = _userRegistry.roomName;
            _userRegistry.registerRoom(-1, "SnowStorm");
            for each (var _local_7:Object in _local_5)
            {
                _local_6 = (_local_7 as HumanGameObjectData);
                if (((!(_local_6 == null)) && (!(_local_6.userId == ownUserId))))
                {
                    _userRegistry.registerUser(_local_6.userId, _local_6.name, _local_6.figure);
                };
            };
            _userRegistry.registerRoom(_local_4, _local_3);
        }

        private function onRoomReady(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomReadyMessageParser = RoomReadyMessageEvent(_arg_1).getParser();
            _userRegistry.registerRoom(_local_2.roomId, "");
        }

        private function onGuestRoomResult(_arg_1:IMessageEvent):void
        {
            var _local_2:GetGuestRoomResultMessageParser = GetGuestRoomResultEvent(_arg_1).getParser();
            _userRegistry.registerRoom(_local_2.data.flatId, _local_2.data.roomName);
        }

        public function get userRegistry():UserRegistry
        {
            return (_userRegistry);
        }

        public function get chatRegistry():ChatRegistry
        {
            return (_chatRegistry);
        }

        public function get instantMessageRegistry():InstantMessageRegistry
        {
            return (_instantMessageRegistry);
        }

        private function onRoomEnter(_arg_1:RoomEntryInfoMessageEvent):void
        {
            var _local_2:RoomEntryInfoMessageParser = RoomEntryInfoMessageEvent(_arg_1).getParser();
            _SafeStr_555 = _local_2.guestRoomId;
        }

        private function onCfhTopics(_arg_1:CfhTopicsInitMessageEvent):void
        {
            var _local_2:CfhTopicsInitMessageParser = _arg_1.getParser();
            _callForHelpCategories = _local_2.callForHelpCategories;
        }

        public function get callForHelpCategories():Vector.<CallForHelpCategoryData>
        {
            return (_callForHelpCategories);
        }

        public function get guardiansEnabled():Boolean
        {
            return (getBoolean("guardians.enabled"));
        }

        public function get linkPattern():String
        {
            return ("help/");
        }

        public function get reportedUserId():int
        {
            return (_callForHelpManager.reportedUserId);
        }

        public function get reportedUserName():String
        {
            return (_callForHelpManager.reportedUserName);
        }

        public function get reportedRoomId():int
        {
            return (_callForHelpManager.reportedRoomId);
        }

        public function get reportedExtraDataId():String
        {
            return (_callForHelpManager.reportedExtraDataId);
        }

        public function get reportedRoomObjectId():int
        {
            return (_callForHelpManager.reportedRoomObjectId);
        }

        public function set reportedUserId(_arg_1:int):void
        {
            _callForHelpManager.reportedUserId = _arg_1;
        }

        public function set reportedRoomId(_arg_1:int):void
        {
            _callForHelpManager.reportedRoomId = _arg_1;
        }

        public function linkReceived(_arg_1:String):void
        {
            var _local_2:Array;
            var _local_3:int;
            var _local_4:String;
            if (_arg_1 == "help/tour")
            {
                requestGuide();
            };
            if (_arg_1.indexOf("help/report/room/") == 0)
            {
                _local_2 = _arg_1.split("/");
                if (_local_2.length >= 5)
                {
                    _local_3 = parseInt(_local_2[3]);
                    _local_4 = unescape(_local_2.splice(4).join("/"));
                    reportRoom(_local_3, _local_4, "");
                };
            };
        }

        private function onHabboToolbarEvent(_arg_1:HabboToolbarEvent):void
        {
            if (_SafeStr_558 != null)
            {
                _SafeStr_558.onHabboToolbarEvent(_arg_1);
            };
            if (_guideHelpManager != null)
            {
                _guideHelpManager.onHabboToolbarEvent(_arg_1);
            };
        }

        public function get callForHelpManager():CallForHelpManager
        {
            return (_callForHelpManager);
        }

        public function toggleNewHelpWindow():void
        {
            _SafeStr_556.toggleWindow();
        }

        public function requestSanctionInfo(_arg_1:Boolean):void
        {
            sendMessage(new GetCfhStatusMessageComposer(_arg_1));
        }

        private function onSanctionStatusEvent(_arg_1:SanctionStatusEvent):void
        {
            _sanctionInfo.openWindow(_arg_1);
        }

        public function openCfhFaq():void
        {
            var _local_1:String = context.configuration.getProperty("cfh.faq.url");
            if (!StringUtil.isEmpty(_local_1))
            {
                (navigateToURL(new URLRequest(_local_1)));
            };
        }

        public function get guideHelpManager():GuideHelpManager
        {
            return (_guideHelpManager);
        }


    }
}