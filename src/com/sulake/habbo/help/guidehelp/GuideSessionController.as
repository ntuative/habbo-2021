package com.sulake.habbo.help.guidehelp
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.window.widgets.IIlluminaInputHandler;
    import com.sulake.habbo.help.HabboHelp;
    import com.sulake.habbo.help.GuideHelpManager;
    import com.sulake.core.window.IWindowContainer;
    import flash.geom.Point;
    import com.sulake.core.window.components.IWidgetWindow;
    import flash.utils.Timer;
    import __AS3__.vec.Vector;
    import flash.utils.getTimer;
    import com.sulake.habbo.communication.messages.incoming.help.ChatReviewSessionVotingStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionRequesterRoomMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionAttachedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.ChatReviewSessionOfferedToGuideMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.ChatReviewSessionStartedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionStartedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionDetachedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionInvitedToGuideRoomMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionMessageMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionEndedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.ChatReviewSessionResultsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionErrorMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.ChatReviewSessionDetachedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionPartnerIsTypingMessageEvent;
    import com.sulake.habbo.communication.messages.parser.perk.PerkAllowancesMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.GuideOnDutyStatusMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionCreateMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionOnDutyUpdateMessageComposer;
    import com.sulake.habbo.communication.messages.parser.help.GuideOnDutyStatusMessageParser;
    import com.sulake.habbo.communication.messages.parser.help.GuideSessionAttachedMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.GuideSessionStartedMessageParser;
    import com.sulake.habbo.communication.messages.parser.help.GuideSessionEndedMessageParser;
    import com.sulake.habbo.communication.messages.parser.help.GuideSessionErrorMessageParser;
    import com.sulake.habbo.communication.messages.parser.help.GuideSessionMessageMessageParser;
    import com.sulake.habbo.communication.messages.parser.help.GuideSessionRequesterRoomMessageParser;
    import com.sulake.habbo.communication.messages.parser.help.GuideSessionInvitedToGuideRoomMessageParser;
    import com.sulake.habbo.communication.messages.parser.help.GuideSessionPartnerIsTypingMessageParser;
    import com.sulake.habbo.communication.messages.parser.perk.PerkAllowancesMessageParser;
    import com.sulake.habbo.communication.messages.parser.help.ChatReviewSessionStartedMessageParser;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.communication.messages.parser.help.ChatReviewSessionResultsMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.components._SafeStr_108;
    import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.window.widgets.ICountdownWidget;
    import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionGuideDecidesMessageComposer;
    import com.sulake.habbo.window.widgets.IIlluminaInputWidget;
    import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionGetRequesterRoomMessageComposer;
    import com.sulake.habbo.window.utils._SafeStr_126;
    import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionInviteRequesterMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionResolvedMessageComposer;
    import com.sulake.habbo.window.widgets.IAvatarImageWidget;
    import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionFeedbackMessageComposer;
    import mx.utils.StringUtil;
    import com.sulake.habbo.utils.FriendlyTime;
    import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionRequesterCancelsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.help.ChatReviewGuideDecidesOnOfferMessageComposer;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.habbo.communication.messages.outgoing.help.ChatReviewGuideDetachedMessageComposer;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.communication.messages.outgoing.help.ChatReviewGuideVoteMessageComposer;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionReportMessageComposer;
    import com.sulake.habbo.window.widgets.IIlluminaChatBubbleWidget;
    import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionMessageMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionIsTypingMessageComposer;
    import flash.events.TimerEvent;
    import flash.events.MouseEvent;

    public class GuideSessionController implements IDisposable, IIlluminaInputHandler
    {

        private static const SYSTEM_MSG_CHAT:int = 0;
        private static const SYSTEM_MSG_NOTIFICATION:int = 1;
        private static const SYSTEM_MSG_REMINDER:int = 2;
        private static const CHAT_MSG_DEFAULT:int = 0;
        private static const CHAT_MSG_INVITE:int = 1;
        private static const CHAT_MSG_SYSTEM:int = 2;
        private static const CHAT_REVIEW_VOTE_NONE:int = -1;
        private static const CHAT_REVIEW_VOTE_OK:int = 0;
        private static const CHAT_REVIEW_VOTE_BAD:int = 1;
        private static const CHAT_REVIEW_VOTE_VERY_BAD:int = 2;
        private static const _SafeStr_2663:int = 3000;
        private static const _SafeStr_2664:int = 500;
        private static const STATUS_KEYS:Array = ["waiting", "ok", "bad", "very_bad", "refused", "searching"];
        private static const RESULT_KEYS:Array = ["waiting", "ok", "bad", "very_bad", "inconclusive", "searching"];
        private static const STATUS_KEY_PREFIX:String = "${guide.bully.request.guide.results.outcome.";
        private static const STATUS_ICON_PREFIX:String = "help_chat_review_decision_";

        private var _habboHelp:HabboHelp;
        private var _guideHelp:GuideHelpManager;
        private var _window:IWindowContainer;
        private var _SafeStr_2665:IWindowContainer;
        private var _sessionData:GuideSessionData;
        private var _windowPosition:Point = new Point(120, 80);
        private var _onDuty:Boolean = false;
        private var _SafeStr_2666:Boolean;
        private var _SafeStr_2667:Boolean;
        private var _SafeStr_2668:Boolean;
        private var _resubmitDescription:Boolean = false;
        private var _chatMsg:IWidgetWindow;
        private var _chatMsgNotification:IWindowContainer;
        private var _SafeStr_2669:IWindowContainer;
        private var _disposed:Boolean = false;
        private var _SafeStr_2670:Timer;
        private var _lastMessageTypedLength:int;
        private var _lastTypingInfo:Boolean;
        private var _SafeStr_2661:Timer;
        private var _SafeStr_2671:Vector.<AnimationData>;
        private var _SafeStr_2662:Timer;
        private var _SafeStr_2672:int;

        public function GuideSessionController(_arg_1:GuideHelpManager)
        {
            _habboHelp = _arg_1.habboHelp;
            _guideHelp = _arg_1;
            _sessionData = new GuideSessionData();
            _chatMsg = IWidgetWindow(_habboHelp.getXmlWindow("chat_msg"));
            _chatMsgNotification = IWindowContainer(_habboHelp.getXmlWindow("chat_msg_notification"));
            _SafeStr_2669 = IWindowContainer(_habboHelp.getXmlWindow("chat_msg_reminder"));
            _SafeStr_2666 = _habboHelp.getBoolean("guidetool.handle.help_requests");
            _SafeStr_2667 = _habboHelp.getBoolean("guidetool.handle.chat_reviews");
            _SafeStr_2668 = _habboHelp.getBoolean("guidetool.handle.tour_requests");
            _habboHelp.context.displayObjectContainer.stage.addEventListener("mouseMove", onStageMouseMove);
            _SafeStr_2671 = new Vector.<AnimationData>();
            _SafeStr_2661 = new Timer(500);
            _SafeStr_2661.addEventListener("timer", onWaitingAnimationTimer);
            _SafeStr_2661.start();
            _SafeStr_2672 = getTimer();
            _SafeStr_2662 = new Timer(5000);
            _SafeStr_2662.addEventListener("timer", onIdleCheckTimer);
            _SafeStr_2662.start();
            _habboHelp.communicationManager.addHabboConnectionMessageEvent(new ChatReviewSessionVotingStatusMessageEvent(onChatReviewSessionVotingStatus));
            _habboHelp.communicationManager.addHabboConnectionMessageEvent(new GuideSessionRequesterRoomMessageEvent(onGuideSessionRequesterRoom));
            _habboHelp.communicationManager.addHabboConnectionMessageEvent(new GuideSessionAttachedMessageEvent(onGuideSessionAttached));
            _habboHelp.communicationManager.addHabboConnectionMessageEvent(new ChatReviewSessionOfferedToGuideMessageEvent(onChatReviewSessionOfferedToGuide));
            _habboHelp.communicationManager.addHabboConnectionMessageEvent(new ChatReviewSessionStartedMessageEvent(onChatReviewSessionStarted));
            _habboHelp.communicationManager.addHabboConnectionMessageEvent(new GuideSessionStartedMessageEvent(onGuideSessionStarted));
            _habboHelp.communicationManager.addHabboConnectionMessageEvent(new GuideSessionDetachedMessageEvent(onGuideSessionDetached));
            _habboHelp.communicationManager.addHabboConnectionMessageEvent(new GuideSessionInvitedToGuideRoomMessageEvent(onGuideSessionInvitedToGuideRoom));
            _habboHelp.communicationManager.addHabboConnectionMessageEvent(new GuideSessionMessageMessageEvent(onGuideSessionMessage));
            _habboHelp.communicationManager.addHabboConnectionMessageEvent(new GuideSessionEndedMessageEvent(onGuideSessionEnded));
            _habboHelp.communicationManager.addHabboConnectionMessageEvent(new ChatReviewSessionResultsMessageEvent(onChatReviewSessionResults));
            _habboHelp.communicationManager.addHabboConnectionMessageEvent(new GuideSessionErrorMessageEvent(onGuideSessionError));
            _habboHelp.communicationManager.addHabboConnectionMessageEvent(new ChatReviewSessionDetachedMessageEvent(onChatReviewSessionDetached));
            _habboHelp.communicationManager.addHabboConnectionMessageEvent(new GuideSessionPartnerIsTypingMessageEvent(onGuideSessionPartnerIsTyping));
            _habboHelp.communicationManager.addHabboConnectionMessageEvent(new PerkAllowancesMessageEvent(onPerkAllowances));
            _habboHelp.communicationManager.addHabboConnectionMessageEvent(new GuideOnDutyStatusMessageEvent(onGuideOnDutyStatus));
        }

        private static function statusFromVote(_arg_1:int):int
        {
            var _local_2:int;
            switch (_arg_1)
            {
                case 0:
                    _local_2 = 1;
                    break;
                case 1:
                    _local_2 = 2;
                    break;
                case 2:
                    _local_2 = 3;
                    break;
                case -1:
                    _local_2 = 4;
                default:
            };
            return (_local_2);
        }


        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            if (_SafeStr_2662 != null)
            {
                _SafeStr_2662.stop();
                _SafeStr_2662.removeEventListener("timer", onIdleCheckTimer);
                _SafeStr_2662 = null;
            };
            if (_SafeStr_2661 != null)
            {
                _SafeStr_2661.stop();
                _SafeStr_2661.removeEventListener("timer", onWaitingAnimationTimer);
                _SafeStr_2661 = null;
            };
            _SafeStr_2671 = null;
            if (_chatMsg)
            {
                _chatMsg.dispose();
                _chatMsg = null;
            };
            if (_chatMsgNotification)
            {
                _chatMsgNotification.dispose();
                _chatMsgNotification = null;
            };
            closeWindow();
            _sessionData = null;
            _windowPosition = null;
            _guideHelp = null;
            if ((((_habboHelp) && (_habboHelp.context)) && (_habboHelp.context.displayObjectContainer)))
            {
                _habboHelp.context.displayObjectContainer.stage.removeEventListener("mouseMove", onStageMouseMove);
            };
            _habboHelp = null;
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function createHelpRequest(_arg_1:uint):void
        {
            if (_sessionData.isActiveSession())
            {
                Logger.log("Can't create a new help request while another help request is ongoing");
                return;
            };
            if (((_arg_1 == 0) || (_arg_1 == 2)))
            {
                _sessionData.role = 2;
                _sessionData.activeWindow = "user_create";
                _sessionData.requestType = _arg_1;
                _habboHelp.sendMessage(new GuideSessionCreateMessageComposer(_arg_1, _habboHelp.localization.getLocalization("guide.help.request.tour.description")));
            }
            else
            {
                setStateUserCreateRequest(_arg_1);
            };
        }

        public function showGuideTool():void
        {
            _habboHelp.sendMessage(new GuideSessionOnDutyUpdateMessageComposer(_onDuty, _SafeStr_2668, _SafeStr_2666, _SafeStr_2667));
        }

        private function onGuideOnDutyStatus(_arg_1:GuideOnDutyStatusMessageEvent):void
        {
            var _local_2:GuideOnDutyStatusMessageParser = _arg_1.getParser();
            _onDuty = _local_2.onDuty;
            _habboHelp.localization.registerParameter("guide.help.guide.tool.guidesonduty", "amount", _local_2.guidesOnDuty.toString());
            _habboHelp.localization.registerParameter("guide.help.guide.tool.helpersonduty", "amount", _local_2.helpersOnDuty.toString());
            _habboHelp.localization.registerParameter("guide.help.guide.tool.guardiansonduty", "amount", _local_2.guardiansOnDuty.toString());
            setStateGuideTool();
        }

        private function onGuideSessionAttached(_arg_1:IMessageEvent):void
        {
            Logger.log("onGuideSessionAttached");
            if (((_disposed) || (!(_sessionData))))
            {
                Logger.log("_diposed or no _sessionData");
                return;
            };
            var _local_2:GuideSessionAttachedMessageParser = (_arg_1.parser as GuideSessionAttachedMessageParser);
            if (_local_2.asGuide)
            {
                if (_sessionData.isActiveGuideSession())
                {
                    setStateError();
                    return;
                };
                setStateGuideAccept(_local_2.helpRequestType, _local_2.helpRequestDescription, _local_2.roleSpecificWaitTime);
            }
            else
            {
                if (!_sessionData.isActiveUserSession())
                {
                    setStateError();
                    return;
                };
                setStateUserPendingRequest(_local_2.helpRequestType, _local_2.helpRequestDescription, _local_2.roleSpecificWaitTime);
            };
        }

        private function onGuideSessionDetached(_arg_1:IMessageEvent):void
        {
            var _local_2:int;
            var _local_3:String;
            Logger.log("onGuideSessionDetached");
            if (_disposed)
            {
                return;
            };
            if (_resubmitDescription)
            {
                _local_2 = _sessionData.requestType;
                _local_3 = _sessionData.requestDescription;
                resetSessionData();
                setStateUserCreateRequest(_local_2, _local_3);
            }
            else
            {
                if (((_sessionData.isActiveUserSession()) && (_sessionData.activeWindow == "user_feedback")))
                {
                    setStateUserThanks();
                }
                else
                {
                    setStateClosed(true);
                };
            };
        }

        private function onGuideSessionStarted(_arg_1:IMessageEvent):void
        {
            Logger.log("onGuideSessionStarted");
            if (_disposed)
            {
                return;
            };
            var _local_2:GuideSessionStartedMessageParser = (_arg_1.parser as GuideSessionStartedMessageParser);
            _sessionData.userId = _local_2.requesterUserId;
            _sessionData.userName = _local_2.requesterName;
            _sessionData.userFigure = _local_2.requesterFigure;
            _sessionData.guideId = _local_2.guideUserId;
            _sessionData.guideName = _local_2.guideName;
            _sessionData.guideFigure = _local_2.guideFigure;
            _lastTypingInfo = false;
            if (_sessionData.isActiveGuideSession())
            {
                setStateGuideOngoing();
            }
            else
            {
                setStateUserOngoingRequest();
            };
        }

        private function onGuideSessionEnded(_arg_1:IMessageEvent):void
        {
            Logger.log("onGuideSessionEnded");
            if (_disposed)
            {
                return;
            };
            var _local_2:GuideSessionEndedMessageParser = (_arg_1.parser as GuideSessionEndedMessageParser);
            if (_sessionData.isActiveGuideSession())
            {
                setStateGuideClosed(_local_2.endReason);
            }
            else
            {
                if (_local_2.endReason == 0)
                {
                    setStateUserGuideDisconnected();
                }
                else
                {
                    setStateUserFeedback();
                };
            };
        }

        private function onGuideSessionError(_arg_1:GuideSessionErrorMessageEvent):void
        {
            Logger.log("onGuideSessionError");
            if (_disposed)
            {
                return;
            };
            var _local_2:GuideSessionErrorMessageParser = _arg_1.getParser();
            switch (_local_2.errorCode)
            {
                case 1:
                    setStateRejected();
                    return;
                case 2:
                case 3:
                    setStateClosedWithNotification("guide.bully.request.error.not_enough_guardians");
                    return;
                default:
                    setStateError();
            };
        }

        private function onGuideSessionMessage(_arg_1:IMessageEvent):void
        {
            var _local_4:String;
            var _local_6:String;
            Logger.log("onGuideSessionMessage");
            if ((((_disposed) || (!(_sessionData.isOnGoingSession()))) || (_window == null)))
            {
                return;
            };
            var _local_5:GuideSessionMessageMessageParser = (_arg_1.parser as GuideSessionMessageMessageParser);
            var _local_3:int = _local_5.senderId;
            if (_local_3 == _sessionData.guideId)
            {
                _local_4 = _sessionData.guideName;
                _local_6 = _sessionData.guideFigure;
            }
            else
            {
                _local_4 = _sessionData.userName;
                _local_6 = _sessionData.userFigure;
            };
            var _local_2:Boolean = true;
            if (((_sessionData.isActiveGuideSession()) && (_sessionData.guideId == _local_3)))
            {
                _local_2 = false;
            }
            else
            {
                if (((!(_sessionData.isActiveGuideSession())) && (_sessionData.userId == _local_3)))
                {
                    _local_2 = false;
                };
            };
            addChatMessage(_local_3, _local_4, _local_6, _local_5.chatMessage, _local_2);
        }

        private function onGuideSessionRequesterRoom(_arg_1:IMessageEvent):void
        {
            Logger.log("onGuideSessionRequesterRoom");
            if (((_disposed) || (!(_sessionData.isOnGoingSession()))))
            {
                return;
            };
            var _local_2:GuideSessionRequesterRoomMessageParser = (_arg_1.parser as GuideSessionRequesterRoomMessageParser);
            if (_local_2.getRequesterRoomId() > 0)
            {
                _habboHelp.roomSessionManager.gotoRoom(_local_2.getRequesterRoomId());
            }
            else
            {
                addChatMessage(_sessionData.guideId, _sessionData.guideName, _sessionData.guideFigure, _habboHelp.localization.getLocalization("guide.help.request.guide.ongoing.user.not.in.room.error", ""), false, 2);
            };
        }

        private function onGuideSessionInvitedToGuideRoom(_arg_1:IMessageEvent):void
        {
            Logger.log("onGuideSessionInvitedToGuideRoom");
            if ((((_disposed) || (_window == null)) || (!(_sessionData.isOnGoingSession()))))
            {
                return;
            };
            var _local_2:GuideSessionInvitedToGuideRoomMessageParser = (_arg_1.parser as GuideSessionInvitedToGuideRoomMessageParser);
            if (_sessionData.isActiveGuideSession())
            {
                if (_local_2.getRoomId() > 0)
                {
                    addSystemMessage(0, _habboHelp.localization.getLocalizationWithParams("guide.help.request.guide.ongoing.error.invite.success", "", "name", _sessionData.userName));
                }
                else
                {
                    addSystemMessage(0, _habboHelp.localization.getLocalization("guide.help.request.guide.ongoing.error.invite.failed", ""));
                };
            }
            else
            {
                if (_local_2.getRoomId() > 0)
                {
                    addChatMessage(_sessionData.guideId, _sessionData.guideName, _sessionData.guideFigure, _habboHelp.localization.getLocalizationWithParams("guide.help.request.user.ongoing.visit.guide.request.message", "", "name", _sessionData.guideName, "roomname", _local_2.getRoomName()), true, 1, _local_2.getRoomId());
                };
            };
        }

        private function onGuideSessionPartnerIsTyping(_arg_1:IMessageEvent):void
        {
            Logger.log("onGuideSessionPartnerIsTyping");
            var _local_2:GuideSessionPartnerIsTypingMessageParser = GuideSessionPartnerIsTypingMessageEvent(_arg_1).getParser();
            displayPartnerIsTypingMessage(_local_2.isTyping);
        }

        private function onPerkAllowances(_arg_1:PerkAllowancesMessageEvent):void
        {
            var _local_2:PerkAllowancesMessageParser;
            if (_sessionData.activeWindow == "guide_tool")
            {
                _local_2 = _arg_1.getParser();
                if (!_local_2.isPerkAllowed("USE_GUIDE_TOOL"))
                {
                    if (_onDuty)
                    {
                        setOnDuty(false);
                        _habboHelp.sendMessage(new GuideSessionOnDutyUpdateMessageComposer(false, false, false, false));
                    };
                    setStateClosed(false);
                };
            };
        }

        private function onChatReviewSessionOfferedToGuide(_arg_1:ChatReviewSessionOfferedToGuideMessageEvent):void
        {
            setStateGuardianChatReviewAccept(_arg_1.getParser().acceptanceTimeout);
        }

        private function onChatReviewSessionStarted(_arg_1:ChatReviewSessionStartedMessageEvent):void
        {
            var _local_2:ChatReviewSessionStartedMessageParser = _arg_1.getParser();
            setStateGuardianChatReviewVote(_local_2.votingTimeout, _local_2.chatRecord);
        }

        private function onChatReviewSessionVotingStatus(_arg_1:ChatReviewSessionVotingStatusMessageEvent):void
        {
            if (_sessionData.activeWindow != "guardian_chat_review_wait_for_results")
            {
                return;
            };
            showStatus((_window.findChildByName("results") as IItemListWindow), _arg_1.getParser().status);
        }

        private function onChatReviewSessionResults(_arg_1:ChatReviewSessionResultsMessageEvent):void
        {
            var _local_2:ChatReviewSessionResultsMessageParser = _arg_1.getParser();
            setStateGuardianChatReviewResults(_local_2.winningVoteCode, _local_2.ownVoteCode, _local_2.finalStatus);
        }

        private function onChatReviewSessionDetached(_arg_1:IMessageEvent):void
        {
            setStateClosed(true);
        }

        private function setStateGuideTool():void
        {
            var _local_2:IItemListWindow;
            var _local_1:IWindowContainer;
            if (_sessionData.isActiveSession())
            {
                Logger.log("Trying to set state to guide tool, but an active session exists");
                return;
            };
            _sessionData.activeWindow = "guide_tool";
            openWindow(onGuideToolEvent, true);
            setOnDutyStatus(_onDuty);
            _window.procedure = onGuideToolEvent;
            setCheckBoxValue("handle_guardian_tickets", _SafeStr_2667);
            setCheckBoxValue("handle_helper_tickets", _SafeStr_2666);
            setCheckBoxValue("handle_guide_tickets", _SafeStr_2668);
            if (!_habboHelp.sessionDataManager.isPerkAllowed("JUDGE_CHAT_REVIEWS"))
            {
                _local_2 = IItemListWindow(_window.findChildByName("list"));
                _local_1 = (_local_2.getListItemByName("handle_selection_container") as IWindowContainer);
                _local_1.findChildByName("handle_guardian_tickets").dispose();
                _local_1.findChildByName("selection_separator").y = (_local_1.findChildByName("selection_separator").y - 17);
                _local_1.height = (_local_1.height - 17);
            };
        }

        private function onGuideToolEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:String;
            if ((((disposed) || (_window == null)) || (!(_window.name == "guide_tool"))))
            {
                return;
            };
            var _local_3:int;
            switch (_arg_2.name)
            {
                case "header_button_close":
                    if (_arg_1.type == "WME_CLICK")
                    {
                        setStateClosed(false);
                    };
                    return;
                case "helper_group_link":
                    if (_arg_1.type == "WME_CLICK")
                    {
                        _local_3 = _habboHelp.getInteger("guide.help.alpha.groupid", 0);
                        if (_local_3 > 0)
                        {
                            _habboHelp.sendMessage(new GetHabboGroupDetailsMessageComposer(_local_3, true));
                            _habboHelp.trackGoogle("guideHelp", (_window.name + "_groupProfile"));
                        };
                    };
                    return;
                case "guide_forum_link":
                    if (_arg_1.type == "WME_CLICK")
                    {
                        _local_3 = _habboHelp.getInteger("guide.help.alpha.groupid", 0);
                        if (_local_3 > 0)
                        {
                            _local_4 = _habboHelp.getProperty("group.homepage.url");
                            _local_4 = _local_4.replace("%groupid%", _local_3);
                            HabboWebTools.openWebPage(_local_4, "habboMain");
                            _habboHelp.trackGoogle("guideHelp", (_window.name + "_groupForum"));
                        };
                    };
                    return;
                case "guide_tool_duty":
                    switch (_arg_1.type)
                    {
                        case "WE_SELECTED":
                            setOnDutyStatus(true);
                            _SafeStr_2666 = (_window.findChildByName("handle_helper_tickets") as _SafeStr_108).isSelected;
                            _SafeStr_2667 = ((!(_window.findChildByName("handle_guardian_tickets") == null)) && ((_window.findChildByName("handle_guardian_tickets") as _SafeStr_108).isSelected));
                            _SafeStr_2668 = (_window.findChildByName("handle_guide_tickets") as _SafeStr_108).isSelected;
                            if ((((!(_SafeStr_2666)) && (!(_SafeStr_2667))) && (!(_SafeStr_2668))))
                            {
                                _habboHelp.windowManager.simpleAlert("${guide.help.guide.tool.noqueueselected.caption}", "${guide.help.guide.tool.noqueueselected.subtitle}", "${guide.help.guide.tool.noqueueselected.message}");
                                setOnDutyStatus(false);
                                return;
                            };
                            _habboHelp.sendMessage(new GuideSessionOnDutyUpdateMessageComposer(true, _SafeStr_2668, _SafeStr_2666, _SafeStr_2667));
                            _habboHelp.trackGoogle("guideHelp", (_window.name + "_onDuty"));
                            break;
                        case "WE_UNSELECTED":
                            setOnDutyStatus(false);
                            _habboHelp.sendMessage(new GuideSessionOnDutyUpdateMessageComposer(false, false, false, false));
                            _habboHelp.trackGoogle("guideHelp", (_window.name + "_offDuty"));
                    };
                    return;
                case "guide_tool_talent":
                    if (_arg_1.type == "WME_CLICK")
                    {
                        if (_habboHelp.getBoolean("talent.track.enabled"))
                        {
                            _habboHelp.tracking.trackTalentTrackOpen("helper", "guidetool");
                            _habboHelp.sendMessage(new GetTalentTrackMessageComposer("helper"));
                            _habboHelp.trackGoogle("guideHelp", (_window.name + "_talent"));
                        };
                    };
                    return;
            };
        }

        private function setStateGuideAccept(_arg_1:int, _arg_2:String, _arg_3:int):void
        {
            var _local_9:IWindow;
            var _local_5:ITextWindow;
            var _local_7:IItemListWindow;
            var _local_6:int;
            var _local_4:int;
            if (((!(_onDuty)) || (_sessionData.isActiveSession())))
            {
                Logger.log("Trying to set state to guide accept, but not on duty or active session exists");
                return;
            };
            _sessionData.activeWindow = "guide_accept";
            _sessionData.role = 1;
            _sessionData.requestDescription = _arg_2;
            _sessionData.requestType = _arg_1;
            openWindow(onGuideAcceptEvent, false);
            _habboHelp.soundManager.playSound("HBST_guide_request");
            if (((_arg_1 == 2) || (_arg_1 == 0)))
            {
                _window.findChildByName("frank_greeting").visible = true;
                _window.findChildByName("request_title").caption = "${guide.help.request.guide.accept.tour_request.title}";
                _window.findChildByName("request_type").dispose();
                _local_9 = _window.findChildByName("request_description_wrapper");
                _local_5 = (_window.findChildByName("request_description") as ITextWindow);
                _local_7 = (_window.findChildByName("itemlist") as IItemListWindow);
                _local_7.addListItemAt(_local_5, _local_7.getListItemIndex(_local_9));
                _local_7.removeListItem(_local_9);
                _local_5.x = _window.findChildByName("request_title").x;
                _local_5.margins.top = 10;
                _local_5.caption = _arg_2;
                _local_6 = _local_7.height;
                _local_4 = _window.findChildByName("skip_link").bottom;
                _local_7.height = _local_4;
                _window.findChildByName("border").height = (_window.findChildByName("border").height + (_local_4 - _local_6));
                _window.height = (_window.height + ((_local_4 - _local_6) + 40));
            }
            else
            {
                _window.findChildByName("request_type").caption = getRequestTypeCaption(_arg_1);
                _window.findChildByName("request_description").caption = _arg_2;
            };
            var _local_8:ICountdownWidget = ICountdownWidget(IWidgetWindow(_window.findChildByName("countdown")).widget);
            _local_8.seconds = _arg_3;
            _local_8.running = true;
        }

        private function onGuideAcceptEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((((disposed) || (_window == null)) || (!(_window.name == "guide_accept"))) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "accept_button":
                    _habboHelp.sendMessage(new GuideSessionGuideDecidesMessageComposer(true));
                    _habboHelp.trackGoogle("guideHelp", (_window.name + "_clickAccept"));
                    closeWindow();
                    return;
                case "skip_link":
                    _habboHelp.sendMessage(new GuideSessionGuideDecidesMessageComposer(false));
                    _habboHelp.trackGoogle("guideHelp", (_window.name + "_clickSkip"));
                    closeWindow();
                    return;
            };
        }

        private function setStateGuideOngoing():void
        {
            if (((!(_onDuty)) || (!(_sessionData.isActiveGuideSession()))))
            {
                Logger.log("Trying to set state to guide ongoing, but not on duty or no active guide session");
                return;
            };
            _sessionData.activeWindow = "guide_ongoing";
            openWindow(onGuideOngoingEvent, false);
            addChatMessage(_sessionData.userId, _sessionData.userName, _sessionData.userFigure, _sessionData.requestDescription, true, 2);
            _window.caption = _habboHelp.localization.getLocalizationWithParams("guide.help.request.guide.ongoing.title", "", "name", _sessionData.userName);
            var inputWidget:IIlluminaInputWidget = IIlluminaInputWidget(IWidgetWindow(_window.findChildByName("input_widget")).widget);
            inputWidget.submitHandler = this;
            inputWidget.emptyMessage = _habboHelp.localization.getLocalizationWithParams("guide.help.request.guide.ongoing.input.empty", "", "name", _sessionData.userName);
            inputWidget.maxChars = _habboHelp.getInteger("guide.help.request.max.chat.message.length", 150);
            if (((_sessionData.requestType == 2) || (_sessionData.requestType == 0)))
            {
                var title:String = "${guide.help.request.join.room.title}";
                var summary:String = _habboHelp.localization.getLocalizationWithParams("guide.help.request.join.room.summary", "", "name", _sessionData.userName);
                _habboHelp.windowManager.confirm(title, summary, 0, function (_arg_1:_SafeStr_126, _arg_2:WindowEvent):void
                {
                    _arg_1.dispose();
                    if (_arg_2.type == "WE_OK")
                    {
                        _habboHelp.sendMessage(new GuideSessionGetRequesterRoomMessageComposer());
                    };
                });
            };
        }

        private function onGuideOngoingEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((((disposed) || (_window == null)) || (!(_window.name == "guide_ongoing"))) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "visit_button":
                    _habboHelp.sendMessage(new GuideSessionGetRequesterRoomMessageComposer());
                    _habboHelp.trackGoogle("guideHelp", (_window.name + "_clickVisit"));
                    return;
                case "invite_button":
                    _habboHelp.sendMessage(new GuideSessionInviteRequesterMessageComposer());
                    _habboHelp.trackGoogle("guideHelp", (_window.name + "_clickInvite"));
                    return;
                case "report_link":
                    tryOpeningReportWindow();
                    _habboHelp.trackGoogle("guideHelp", (_window.name + "_clickReport"));
                    return;
                case "close_link":
                    _habboHelp.sendMessage(new GuideSessionResolvedMessageComposer());
                    _habboHelp.trackGoogle("guideHelp", (_window.name + "_clickClose"));
                    closeWindow();
                    return;
            };
        }

        private function setStateGuideClosed(_arg_1:int):void
        {
            if (((!(_onDuty)) || (!(_sessionData.isActiveGuideSession()))))
            {
                Logger.log("Trying to set state to guide ongoing, but not on duty or no active guide session");
                return;
            };
            _sessionData.activeWindow = "guide_closed";
            openWindow(onGuideClosedEvent, true);
            if (((_arg_1 == 0) || (_arg_1 == 1)))
            {
                _window.findChildByName("close_reason").caption = _habboHelp.localization.getLocalizationWithParams("guide.help.request.guide.closed.reason.other", "", "name", _sessionData.userName);
            }
            else
            {
                _window.findChildByName("close_reason").caption = _habboHelp.localization.getLocalization("guide.help.request.guide.closed.reason.you", "");
            };
            _window.findChildByName("report_link").caption = _habboHelp.localization.getLocalizationWithParams("guide.help.request.guide.closed.report.link", "", "name", _sessionData.userName);
            IAvatarImageWidget(IWidgetWindow(_window.findChildByName("requester_avatar")).widget).figure = _sessionData.userFigure;
        }

        private function onGuideClosedEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((((disposed) || (_window == null)) || (!(_window.name == "guide_closed"))) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "close_button":
                case "header_button_close":
                    _habboHelp.sendMessage(new GuideSessionFeedbackMessageComposer(true));
                    closeWindow();
                    return;
                case "report_link":
                    tryOpeningReportWindow();
                    _habboHelp.trackGoogle("guideHelp", (_window.name + "_clickReport"));
                    return;
            };
        }

        private function setStateUserCreateRequest(_arg_1:uint, _arg_2:String=null):void
        {
            if (_sessionData.isActiveSession())
            {
                Logger.log("Trying to set state to user create, but active session exists");
                return;
            };
            _sessionData.role = 2;
            _sessionData.activeWindow = "user_create";
            _sessionData.requestType = _arg_1;
            openWindow(onUserCreateEvent, true);
            var _local_3:IIlluminaInputWidget = IIlluminaInputWidget(IWidgetWindow(_window.findChildByName("input_widget")).widget);
            _local_3.maxChars = _habboHelp.getInteger("guide.help.request.max.description.length", 0xFF);
            if (_arg_2)
            {
                _local_3.message = _arg_2;
            };
        }

        private function onUserCreateEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:String;
            if (((((disposed) || (_window == null)) || (!(_window.name == "user_create"))) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "create_button":
                    _local_3 = StringUtil.trim(IIlluminaInputWidget(IWidgetWindow(_window.findChildByName("input_widget")).widget).message);
                    if (_local_3.length < _habboHelp.getInteger("guide.help.request.min.description.length", 15))
                    {
                        _window.findChildByName("create_error").visible = true;
                        IItemListWindow(_window.findChildByName("list")).arrangeListItems();
                    }
                    else
                    {
                        _habboHelp.sendMessage(new GuideSessionCreateMessageComposer(_sessionData.requestType, _local_3));
                        _habboHelp.trackGoogle("guideHelp", (_window.name + "_clickCreate"));
                        closeWindow();
                    };
                    return;
                case "header_button_close":
                case "cancel_link":
                    _habboHelp.trackGoogle("guideHelp", (_window.name + "_clickCancel"));
                    setStateClosed(true);
                    return;
            };
        }

        private function setStateUserPendingRequest(_arg_1:int, _arg_2:String, _arg_3:int):void
        {
            if (!_sessionData.isActiveUserSession())
            {
                Logger.log("Trying to set state to user pending request, but no active user session");
                return;
            };
            _sessionData.activeWindow = "user_pending";
            _sessionData.requestType = _arg_1;
            _sessionData.requestDescription = _arg_2;
            openWindow(onUserPendingEvent, false);
            _window.findChildByName("request_type").caption = getRequestTypeCaption(_arg_1);
            _window.findChildByName("request_description").caption = _arg_2;
            _window.findChildByName("waiting_time").caption = _habboHelp.localization.getLocalizationWithParams("guide.help.request.user.pending.info.waiting", "", "waitingtime", FriendlyTime.getFriendlyTime(_habboHelp.localization, _arg_3));
        }

        private function onUserPendingEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((((disposed) || (_window == null)) || (!(_window.name == "user_pending"))) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "cancel_button":
                    _habboHelp.sendMessage(new GuideSessionRequesterCancelsMessageComposer());
                    _habboHelp.trackGoogle("guideHelp", (_window.name + "_clickCancel"));
                    closeWindow();
                    return;
            };
        }

        private function setStateUserOngoingRequest():void
        {
            if (!_sessionData.isActiveUserSession())
            {
                Logger.log("Trying to set state to user ongoing request, but no active user session");
                return;
            };
            _sessionData.activeWindow = "user_ongoing";
            openWindow(onUserOngoingEvent, false);
            addSystemMessage(1, _habboHelp.localization.getLocalization("guide.help.requester.disclaimer"));
            if (((_sessionData.requestType == 0) || (_sessionData.requestType == 2)))
            {
                addSystemMessage(2, _habboHelp.localization.getLocalization("guide.help.request.tour.reminder"));
            }
            else
            {
                addChatMessage(_sessionData.userId, _sessionData.userName, _sessionData.userFigure, _sessionData.requestDescription, false, 2);
            };
            _window.caption = _habboHelp.localization.getLocalizationWithParams("guide.help.request.user.ongoing.title", "", "name", _sessionData.guideName);
            _window.findChildByName("guide_name_link").caption = _sessionData.guideName;
            var _local_1:IIlluminaInputWidget = IIlluminaInputWidget(IWidgetWindow(_window.findChildByName("input_widget")).widget);
            _local_1.submitHandler = this;
            _local_1.emptyMessage = _habboHelp.localization.getLocalizationWithParams("guide.help.request.user.ongoing.input.help", "", "name", _sessionData.guideName);
            _local_1.maxChars = _habboHelp.getInteger("guide.help.request.max.chat.message.length", 150);
        }

        private function onUserOngoingEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((((disposed) || (_window == null)) || (!(_window.name == "user_ongoing"))) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "guide_name_link":
                    _habboHelp.sendMessage(new GetExtendedProfileMessageComposer(_sessionData.guideId));
                    _habboHelp.trackGoogle("guideHelp", (_window.name + "_clickProfile"));
                    return;
                case "report_guide_link":
                    tryOpeningReportWindow();
                    _habboHelp.trackGoogle("guideHelp", (_window.name + "_clickReport"));
                    return;
                case "close_link":
                    _habboHelp.sendMessage(new GuideSessionResolvedMessageComposer());
                    _habboHelp.trackGoogle("guideHelp", (_window.name + "_clickClose"));
                    closeWindow();
                    return;
            };
        }

        private function setStateUserGuideDisconnected():void
        {
            if (!_sessionData.isActiveUserSession())
            {
                Logger.log("Trying to set state to user guide disconnected, but no active user session");
                return;
            };
            _sessionData.activeWindow = "user_guide_disconnected";
            openWindow(onUserGuideDisconnected, true);
            _window.findChildByName("guide_name_link").caption = _sessionData.guideName;
        }

        private function onUserGuideDisconnected(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((((disposed) || (_window == null)) || (!(_window.name == "user_guide_disconnected"))) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "header_button_close":
                    _habboHelp.sendMessage(new GuideSessionFeedbackMessageComposer(false));
                    closeWindow();
                    return;
                case "guide_name_link":
                    _habboHelp.sendMessage(new GetExtendedProfileMessageComposer(_sessionData.guideId));
                    _habboHelp.trackGoogle("guideHelp", (_window.name + "_clickProfile"));
                    return;
                case "report_guide_link":
                    tryOpeningReportWindow();
                    _habboHelp.trackGoogle("guideHelp", (_window.name + "_clickReport"));
                    return;
                case "resubmit_button":
                    _resubmitDescription = true;
                    _habboHelp.sendMessage(new GuideSessionFeedbackMessageComposer(false));
                    _habboHelp.trackGoogle("guideHelp", (_window.name + "_clickResubmit"));
                    closeWindow();
                    return;
            };
        }

        private function setStateUserFeedback():void
        {
            if (!_sessionData.isActiveUserSession())
            {
                Logger.log("Trying to set state to user feedback, but no active user session");
                return;
            };
            _sessionData.activeWindow = "user_feedback";
            openWindow(onUserFeedbackEvent, false);
            _window.findChildByName("guide_name_link").caption = _sessionData.guideName;
        }

        private function onUserFeedbackEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((((disposed) || (_window == null)) || (!(_window.name == "user_feedback"))) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "guide_name_link":
                    _habboHelp.sendMessage(new GetExtendedProfileMessageComposer(_sessionData.guideId));
                    _habboHelp.trackGoogle("guideHelp", (_window.name + "_clickProfile"));
                    return;
                case "report_guide_link":
                    tryOpeningReportWindow();
                    _habboHelp.trackGoogle("guideHelp", (_window.name + "_clickReport"));
                    return;
                case "positive_button":
                    _habboHelp.sendMessage(new GuideSessionFeedbackMessageComposer(true));
                    _habboHelp.trackGoogle("guideHelp", (_window.name + "_clickPositiveFeedback"));
                    closeWindow();
                    return;
                case "negative_button":
                    _habboHelp.sendMessage(new GuideSessionFeedbackMessageComposer(false));
                    _habboHelp.trackGoogle("guideHelp", (_window.name + "_clickNegativeFeedback"));
                    closeWindow();
                    return;
            };
        }

        private function setStateUserThanks():void
        {
            if (!_sessionData.isActiveUserSession())
            {
                Logger.log("Trying to set state to user thanks, but no active user session");
                return;
            };
            _sessionData.activeWindow = "user_thanks";
            openWindow(onUserThanksEvent, true);
        }

        private function onUserThanksEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((((disposed) || (_window == null)) || (!(_window.name == "user_thanks"))) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "header_button_close":
                case "close_button":
                    setStateClosed(false);
                    return;
            };
        }

        private function setStateGuardianChatReviewAccept(_arg_1:int):void
        {
            _sessionData.activeWindow = "guardian_chat_review_accept";
            openWindow(onGuardianChatReviewAcceptEvent, false);
            _habboHelp.soundManager.playSound("HBST_guide_request");
            var _local_2:ICountdownWidget = (IWidgetWindow(_window.findChildByName("countdown")).widget as ICountdownWidget);
            _local_2.seconds = _arg_1;
            _local_2.running = true;
        }

        private function onGuardianChatReviewAcceptEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if ((((disposed) || (_window == null)) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "skip_link":
                    _habboHelp.sendMessage(new ChatReviewGuideDecidesOnOfferMessageComposer(false));
                    setStateClosed(true);
                    return;
                case "accept_button":
                    _habboHelp.sendMessage(new ChatReviewGuideDecidesOnOfferMessageComposer(true));
                    setStateGuardianChatReviewWaitForOtherVoters();
                    return;
            };
        }

        private function setStateGuardianChatReviewWaitForOtherVoters():void
        {
            _sessionData.activeWindow = "guardian_chat_review_wait_for_voters";
            openWindow(onGuardianChatReviewWaitForOtherVotersEvent, false);
            startWaitingAnimation((_window.findChildByName("waiting_animation") as IStaticBitmapWrapperWindow), "help_chat_review_progress_big", 4);
        }

        private function onGuardianChatReviewWaitForOtherVotersEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if ((((disposed) || (_window == null)) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "close_link":
                    _habboHelp.sendMessage(new ChatReviewGuideDetachedMessageComposer());
                    setStateClosed(true);
                    return;
            };
        }

        private function setStateGuardianChatReviewVote(_arg_1:int, _arg_2:String):void
        {
            var _local_18:Date;
            var _local_15:Array;
            var _local_12:int;
            var _local_10:String;
            var _local_5:Boolean;
            var _local_11:String;
            _sessionData.activeWindow = "guardian_chat_review_vote";
            openWindow(onGuardianChatReviewVoteEvent, false);
            var _local_7:ICountdownWidget = (IWidgetWindow(_window.findChildByName("countdown")).widget as ICountdownWidget);
            _local_7.seconds = _arg_1;
            _local_7.running = true;
            var _local_3:Array = _arg_2.substr(0, _arg_2.indexOf(";")).match(/\d+/g);
            if (_local_3.length > 5)
            {
                _local_18 = new Date(_local_3[0], (_local_3[1] - 1), _local_3[2], _local_3[3], _local_3[4], _local_3[5]);
            }
            else
            {
                _local_18 = new Date();
            };
            var _local_16:Number = ((new Date().getTime() - _local_18.getTime()) / 1000);
            _window.findChildByName("incident_time").caption = (("(" + FriendlyTime.getFriendlyTime(_habboHelp.localization, _local_16, ".ago")) + ")");
            var _local_4:IItemListWindow = (_window.findChildByName("chatlog") as IItemListWindow);
            var _local_8:IWindow = _window.findChildByName("reported_user_template");
            var _local_6:IWindow = _window.findChildByName("other_user_template");
            var _local_9:IWindow = _window.findChildByName("separator_template");
            _local_4.removeListItems();
            var _local_14:int = -1;
            var _local_13:IWindowContainer;
            for each (var _local_17:String in _arg_2.split("\r"))
            {
                if (_local_17 != "")
                {
                    _local_15 = _local_17.split(";", 3);
                    _local_12 = 1;
                    if (_local_15.length >= 3)
                    {
                        _local_12 = _local_15[1];
                        _local_10 = _local_15[2].replace("<", "&lt;").replace(">", "&gt;");
                        if (((_local_12 == _local_14) && (!(_local_13 == null))))
                        {
                            _local_13.findChildByName("message").caption = (_local_13.findChildByName("message").caption + ("\n" + _local_10));
                        }
                        else
                        {
                            _local_5 = (_local_12 == 0);
                            _local_13 = (((_local_5) ? _local_8.clone() : _local_6.clone()) as IWindowContainer);
                            _local_11 = ((_local_5) ? _habboHelp.localization.getLocalization("guide.bully.request.guide.vote.perpetrator", "") : _habboHelp.localization.getLocalizationWithParams("guide.bully.request.guide.vote.anonymous", "%ID%", "id", _local_12.toString()));
                            _local_13.findChildByName("message").caption = ((("<b>" + _local_11) + ":</b> ") + _local_10);
                            _local_4.addListItem(_local_13);
                            _local_14 = _local_12;
                        };
                    };
                };
            };
        }

        private function onGuardianChatReviewVoteEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_5:String;
            var _local_6:IRegionWindow;
            var _local_3:String;
            var _local_4:IStaticBitmapWrapperWindow;
            if (((disposed) || (_window == null)))
            {
                return;
            };
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "close_link":
                        _habboHelp.sendMessage(new ChatReviewGuideDetachedMessageComposer());
                        setStateClosed(true);
                        break;
                    case "vote_ok":
                        _habboHelp.sendMessage(new ChatReviewGuideVoteMessageComposer(0));
                        setStateGuardianChatReviewWaitForResults(0);
                        break;
                    case "vote_bad":
                        _habboHelp.sendMessage(new ChatReviewGuideVoteMessageComposer(1));
                        setStateGuardianChatReviewWaitForResults(1);
                        break;
                    case "vote_very_bad":
                        _habboHelp.sendMessage(new ChatReviewGuideVoteMessageComposer(2));
                        setStateGuardianChatReviewWaitForResults(2);
                };
            }
            else
            {
                if (((_arg_2.type == 5) && (_arg_2.name.substr(0, 5) == "vote_")))
                {
                    _local_5 = _arg_2.name.substr(5);
                    _local_6 = (_arg_2 as IRegionWindow);
                    _local_3 = ("help_chat_review_vote_" + _local_5);
                    _local_4 = (_local_6.getChildAt(0) as IStaticBitmapWrapperWindow);
                    switch (_arg_1.type)
                    {
                        case "WME_OVER":
                            _local_4.id = (_local_4.id | 0x01);
                            break;
                        case "WME_OUT":
                            _local_4.id = (_local_4.id & 0xFFFFFFFE);
                            break;
                        case "WME_DOWN":
                            _local_4.id = (_local_4.id | 0x02);
                            break;
                        case "WME_UP":
                        case "WME_UP_OUTSIDE":
                            _local_4.id = (_local_4.id & 0xFFFFFFFD);
                    };
                    switch (_local_4.id)
                    {
                        case 1:
                            _local_4.assetUri = (_local_3 + "_over");
                            return;
                        case 3:
                            _local_4.assetUri = (_local_3 + "_down");
                            return;
                        default:
                            _local_4.assetUri = _local_3;
                    };
                };
            };
        }

        private function setStateGuardianChatReviewWaitForResults(_arg_1:int):void
        {
            _sessionData.activeWindow = "guardian_chat_review_wait_for_results";
            openWindow(onGuardianChatReviewWaitForResultsEvent, true);
            showOwnVote(_arg_1);
        }

        private function onGuardianChatReviewWaitForResultsEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if ((((disposed) || (_window == null)) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "header_button_close":
                case "close_button":
                    _habboHelp.sendMessage(new ChatReviewGuideDetachedMessageComposer());
                    setStateClosed(true);
                    return;
            };
        }

        private function setStateGuardianChatReviewResults(_arg_1:int, _arg_2:int, _arg_3:Array):void
        {
            _sessionData.activeWindow = "guardian_chat_review_results";
            openWindow(onGuardianChatReviewResultsEvent, true);
            var _local_4:int = statusFromVote(_arg_1);
            _window.findChildByName("result_text").caption = (("${guide.bully.request.guide.results.outcome." + RESULT_KEYS[_local_4]) + "}");
            IStaticBitmapWrapperWindow(_window.findChildByName("result_image")).assetUri = ("help_chat_review_decision_" + STATUS_KEYS[_local_4]);
            showOwnVote(_arg_2);
            showStatus((_window.findChildByName("results") as IItemListWindow), _arg_3);
        }

        private function onGuardianChatReviewResultsEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if ((((disposed) || (_window == null)) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "header_button_close":
                case "close_button":
                    _habboHelp.sendMessage(new ChatReviewGuideDetachedMessageComposer());
                    setStateClosed(true);
                    return;
            };
        }

        private function showOwnVote(_arg_1:int):void
        {
            var _local_2:int = statusFromVote(_arg_1);
            _window.findChildByName("vote_text").caption = (("${guide.bully.request.guide.results.outcome." + STATUS_KEYS[_local_2]) + "}");
            IStaticBitmapWrapperWindow(_window.findChildByName("vote_image")).assetUri = ("help_chat_review_decision_" + STATUS_KEYS[_local_2]);
        }

        private function showStatus(_arg_1:IItemListWindow, _arg_2:Array):void
        {
            var _local_3:IWindowContainer;
            var _local_6:int;
            var _local_4:IWindowContainer;
            var _local_7:int;
            var _local_5:IStaticBitmapWrapperWindow;
            if (_arg_1.numListItems < (_arg_2.length + 1))
            {
                _local_4 = (_arg_1.getListItemAt(0) as IWindowContainer);
                _local_6 = 0;
                while (_local_6 < _arg_2.length)
                {
                    _local_3 = (_local_4.clone() as IWindowContainer);
                    _arg_1.addListItem(_local_3);
                    _local_6++;
                };
                _local_3.findChildByName("vote_separator").dispose();
            };
            _local_6 = 0;
            while (_local_6 < _arg_2.length)
            {
                _local_3 = (_arg_1.getListItemAt((_local_6 + 1)) as IWindowContainer);
                _local_7 = _arg_2[_local_6];
                _local_5 = (_local_3.findChildByName("vote_image") as IStaticBitmapWrapperWindow);
                _local_3.findChildByName("vote_text").caption = (("${guide.bully.request.guide.results.outcome." + STATUS_KEYS[_local_7]) + "}");
                stopWaitingAnimation(_local_5);
                switch (_local_7)
                {
                    case 0:
                    case 5:
                        startWaitingAnimation(_local_5, ("help_chat_review_decision_" + STATUS_KEYS[_local_7]), 2);
                        break;
                    default:
                        _local_5.assetUri = ("help_chat_review_decision_" + STATUS_KEYS[_local_7]);
                };
                _local_6++;
            };
        }

        private function setStateClosedWithNotification(_arg_1:String):void
        {
            _habboHelp.windowManager.simpleAlert((("${" + _arg_1) + ".title}"), (("${" + _arg_1) + ".heading}"), (("${" + _arg_1) + ".message}"));
            setStateClosed(true);
        }

        private function setStateError():void
        {
            setOnDuty(false);
            _sessionData.activeWindow = "error_window";
            openWindow(onErrorWindowEvent, true);
        }

        private function onErrorWindowEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((((disposed) || (_window == null)) || (!(_window.name == "error_window"))) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "header_button_close":
                case "close_button":
                    setStateClosed(true);
                    return;
            };
        }

        private function setStateRejected():void
        {
            setOnDuty(false);
            _sessionData.activeWindow = "rejected_window";
            openWindow(onRejectedWindowEvent, true);
            if (((_sessionData.requestType == 0) || (_sessionData.requestType == 2)))
            {
                _window.caption = "${guide.help.request.no_tour_guides.title}";
                _window.findChildByName("heading").caption = "${guide.help.request.no_tour_guides.heading}";
                _window.findChildByName("message").caption = "${guide.help.request.no_tour_guides.message}";
            };
        }

        private function onRejectedWindowEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((((disposed) || (_window == null)) || (!(_window.name == "rejected_window"))) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "header_button_close":
                case "close_button":
                    setStateClosed(true);
                    return;
            };
        }

        private function setStateClosed(_arg_1:Boolean):void
        {
            resetSessionData();
            closeWindow();
            if (((_onDuty) && (!(_habboHelp.sessionDataManager.isPerkAllowed("USE_GUIDE_TOOL")))))
            {
                setOnDuty(false);
            };
            if (((_arg_1) && (_onDuty)))
            {
                setStateGuideTool();
            };
        }

        private function openWindow(_arg_1:Function, _arg_2:Boolean):void
        {
            if (_disposed)
            {
                return;
            };
            if (_window != null)
            {
                closeWindow();
            };
            Logger.log(("Opening window " + _sessionData.activeWindow));
            _window = (_guideHelp.habboHelp.getXmlWindow(_sessionData.activeWindow) as IWindowContainer);
            _window.position = _windowPosition;
            _window.procedure = _arg_1;
            _window.findChildByName("header_button_close").visible = _arg_2;
        }

        private function closeWindow():void
        {
            if (_window != null)
            {
                Logger.log(("Closing window: " + _window.name));
                _windowPosition.x = Math.max(0, _window.position.x);
                _windowPosition.y = Math.max(0, _window.position.y);
                _window.dispose();
                _window = null;
            };
        }

        private function tryOpeningReportWindow():void
        {
            _habboHelp.queryForPendingCallsForHelp(2);
        }

        public function openReportWindow():void
        {
            if (((_SafeStr_2665) || (_window == null)))
            {
                return;
            };
            var _local_1:IDesktopWindow = _habboHelp.windowManager.getDesktop(0);
            _SafeStr_2665 = IWindowContainer(_habboHelp.getXmlWindow("report_window"));
            _SafeStr_2665.procedure = onReportWindowEvent;
            _SafeStr_2665.x = Math.max(0, Math.min((_local_1.width - _SafeStr_2665.width), ((_window.x + _window.width) + 10)));
            _SafeStr_2665.y = Math.max(0, _window.y);
        }

        private function closeReportWindow():void
        {
            if (_SafeStr_2665)
            {
                _SafeStr_2665.dispose();
                _SafeStr_2665 = null;
            };
        }

        private function onReportWindowEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:String;
            if (((((disposed) || (!(_SafeStr_2665))) || (_SafeStr_2665.disposed)) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "header_button_close":
                case "cancel_link":
                    _habboHelp.trackGoogle("guideHelp", (_SafeStr_2665.name + "_clickClose"));
                    closeReportWindow();
                    return;
                case "urgent_help_link":
                    return;
                case "submit_button":
                    _local_3 = IIlluminaInputWidget(IWidgetWindow(_SafeStr_2665.findChildByName("input_widget")).widget).message;
                    if (_local_3.length == 0)
                    {
                        _SafeStr_2665.findChildByName("report_error").visible = true;
                        IItemListWindow(_SafeStr_2665.findChildByName("list")).arrangeListItems();
                    }
                    else
                    {
                        _habboHelp.sendMessage(new GuideSessionReportMessageComposer(_local_3));
                        _habboHelp.trackGoogle("guideHelp", (_SafeStr_2665.name + "_clickReport"));
                        closeReportWindow();
                        closeWindow();
                    };
                    return;
            };
        }

        private function resetSessionData():void
        {
            _sessionData = new GuideSessionData();
        }

        private function setOnDutyStatus(_arg_1:Boolean):void
        {
            var _local_2:_SafeStr_108 = _SafeStr_108(_window.findChildByName("guide_tool_duty"));
            setOnDuty(_arg_1);
            _local_2.isSelected = _arg_1;
            if (_arg_1)
            {
                _local_2.caption = _habboHelp.localization.getLocalization("guide.help.guide.tool.duty.on", "");
            }
            else
            {
                _local_2.caption = _habboHelp.localization.getLocalization("guide.help.guide.tool.duty.off", "");
            };
            var _local_3:IWindow = _window.findChildByName("disabled_screen");
            if (_local_3)
            {
                _local_3.visible = _arg_1;
            };
        }

        private function setCheckBoxValue(_arg_1:String, _arg_2:Boolean):void
        {
            var _local_3:_SafeStr_108 = (_window.findChildByName(_arg_1) as _SafeStr_108);
            if (_local_3 != null)
            {
                _local_3.isSelected = _arg_2;
            };
        }

        private function getRequestTypeCaption(_arg_1:int):String
        {
            if (_arg_1 == 2)
            {
                _arg_1 = 0;
            };
            return (_habboHelp.localization.getLocalization(("guide.help.request.type." + _arg_1), ""));
        }

        private function addChatMessage(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:Boolean, _arg_6:int=0, _arg_7:*=null):void
        {
            var _local_8:IIlluminaChatBubbleWidget;
            var _local_9:IWindowContainer;
            var _local_10:IWidgetWindow = getLastChatListItem();
            if ((((!(_local_10 == null)) && (!(null == (_local_10.widget as IIlluminaChatBubbleWidget)))) && (_local_10.name == "chat_msg_0")))
            {
                _local_8 = IIlluminaChatBubbleWidget(_local_10.widget);
            };
            if ((((_local_8) && (_local_8.userId == _arg_1)) && (_arg_6 == 0)))
            {
                _local_8.message = ((_local_8.message + "\n") + _arg_4);
                addItemAndUpdateChatList(null);
            }
            else
            {
                _local_10 = IWidgetWindow(_chatMsg.clone());
                _local_10.name = ("chat_msg_" + _arg_6);
                _local_8 = IIlluminaChatBubbleWidget(_local_10.widget);
                _local_8.figure = _arg_3;
                _local_8.flipped = _arg_5;
                _local_8.message = _arg_4;
                _local_8.userName = _arg_2;
                _local_8.userId = _arg_1;
                switch (_arg_6)
                {
                    case 1:
                        _local_9 = IWindowContainer(IWindowContainer(_local_10.rootWindow).findChildByName("message_region"));
                        _local_9.procedure = onChatMessageEvent;
                        _local_9.setParamFlag(1, true);
                        _local_9.id = _arg_7;
                        ITextWindow(_local_9.findChildByName("message")).underline = true;
                    default:
                        addItemAndUpdateChatList(_local_10);
                };
            };
        }

        private function onChatMessageEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if ((((disposed) || (_window == null)) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            _habboHelp.navigator.goToPrivateRoom(_arg_2.id);
        }

        private function addItemAndUpdateChatList(_arg_1:IWindow):void
        {
            var _local_2:IItemListWindow = IItemListWindow(_window.findChildByName("chat_list"));
            if (_arg_1)
            {
                _local_2.addListItemAt(_arg_1, (_local_2.numListItems - 1));
            };
            _local_2.scrollV = 1;
            _local_2.arrangeListItems();
            resetTypingTimer();
        }

        private function addSystemMessage(_arg_1:int, _arg_2:String):void
        {
            var _local_3:IWindowContainer;
            if (((!(_sessionData.isOnGoingSession())) || (_arg_2 == "")))
            {
                return;
            };
            switch (_arg_1)
            {
                case 1:
                    _local_3 = (_chatMsgNotification.clone() as IWindowContainer);
                    _local_3.findChildByName("content").caption = _arg_2;
                    addItemAndUpdateChatList(_local_3);
                    return;
                case 2:
                    _local_3 = (_SafeStr_2669.clone() as IWindowContainer);
                    _local_3.findChildByName("content").caption = _arg_2;
                    addItemAndUpdateChatList(_local_3);
                    return;
                default:
                    if (_sessionData.isActiveUserSession())
                    {
                        addChatMessage(_sessionData.userId, _sessionData.userName, _sessionData.userFigure, _arg_2, true, 2);
                    }
                    else
                    {
                        addChatMessage(_sessionData.guideId, _sessionData.guideName, _sessionData.guideFigure, _arg_2, true, 2);
                    };
            };
        }

        private function getLastChatListItem():IWidgetWindow
        {
            if (((_window == null) || (_window.disposed)))
            {
                return (null);
            };
            var _local_1:IItemListWindow = IItemListWindow(_window.findChildByName("chat_list"));
            if (_local_1.numListItems > 1)
            {
                return (_local_1.getListItemAt((_local_1.numListItems - 2)) as IWidgetWindow);
            };
            return (null);
        }

        public function onInput(_arg_1:IWidgetWindow, _arg_2:String):void
        {
            if (_arg_2.length > 0)
            {
                _habboHelp.sendMessage(new GuideSessionMessageMessageComposer(_arg_2));
                IIlluminaInputWidget(_arg_1.widget).message = "";
                resetTypingTimer();
            };
        }

        private function setOnDuty(_arg_1:Boolean):void
        {
            _onDuty = _arg_1;
            _habboHelp.toolbar.onDuty = _arg_1;
        }

        private function resetTypingTimer():void
        {
            if (_SafeStr_2670 != null)
            {
                _SafeStr_2670.stop();
                _SafeStr_2670 = null;
            };
            if ((((_window == null) || (_window.disposed)) || ((!(_window.name == "user_ongoing")) && (!(_window.name == "guide_ongoing")))))
            {
                return;
            };
            _SafeStr_2670 = new Timer(3000);
            _SafeStr_2670.addEventListener("timer", onTypingTimer);
            _SafeStr_2670.start();
            _lastMessageTypedLength = messageLength;
            displayPartnerIsTypingMessage(false);
        }

        private function get messageLength():int
        {
            if ((((_window == null) || (_window.disposed)) || ((!(_window.name == "user_ongoing")) && (!(_window.name == "guide_ongoing")))))
            {
                return (0);
            };
            var _local_1:IWidgetWindow = (_window.findChildByName("input_widget") as IWidgetWindow);
            return ((_local_1 != null) ? IIlluminaInputWidget(_local_1.widget).message.length : 0);
        }

        private function onTypingTimer(_arg_1:TimerEvent):void
        {
            var _local_3:int;
            if ((((_window == null) || (_window.disposed)) || ((!(_window.name == "user_ongoing")) && (!(_window.name == "guide_ongoing")))))
            {
                return;
            };
            var _local_2:Boolean = (!(_lastMessageTypedLength == _local_3));
            if (_lastTypingInfo != _local_2)
            {
                _habboHelp.sendMessage(new GuideSessionIsTypingMessageComposer(_local_2));
                _lastTypingInfo = _local_2;
            };
            _lastMessageTypedLength = _local_3;
        }

        private function displayPartnerIsTypingMessage(_arg_1:Boolean):void
        {
            if ((((_window == null) || (_window.disposed)) || ((!(_window.name == "user_ongoing")) && (!(_window.name == "guide_ongoing")))))
            {
                return;
            };
            var _local_2:IItemListWindow = IItemListWindow(_window.findChildByName("chat_list"));
            _local_2.getListItemAt((_local_2.numListItems - 1)).blend = ((_arg_1) ? 1 : 0);
        }

        private function onWaitingAnimationTimer(_arg_1:TimerEvent):void
        {
            var event:TimerEvent = _arg_1;
            _SafeStr_2671 = _SafeStr_2671.filter(function (_arg_1:AnimationData, _arg_2:int, _arg_3:Vector.<AnimationData>):Boolean
            {
                return ((!(_arg_1.window == null)) && (!(_arg_1.window.disposed)));
            });
            for each (var data:AnimationData in _SafeStr_2671)
            {
                setAnimationFrame(data);
            };
        }

        private function startWaitingAnimation(_arg_1:IStaticBitmapWrapperWindow, _arg_2:String, _arg_3:int):void
        {
            if (_window == null)
            {
                return;
            };
            var _local_4:AnimationData = new AnimationData(_arg_1, _arg_2, _arg_3);
            setAnimationFrame(_local_4);
            _SafeStr_2671.push(_local_4);
        }

        private function setAnimationFrame(_arg_1:AnimationData):void
        {
            var _local_2:int = (_SafeStr_2661.currentCount % _arg_1.frameCount);
            _arg_1.window.assetUri = ((_arg_1.asset + "_") + (_local_2 + 1));
        }

        private function stopWaitingAnimation(_arg_1:IStaticBitmapWrapperWindow):void
        {
            var window:IStaticBitmapWrapperWindow = _arg_1;
            _SafeStr_2671 = _SafeStr_2671.filter(function (_arg_1:AnimationData, _arg_2:int, _arg_3:Vector.<AnimationData>):Boolean
            {
                return (!(_arg_1.window == window));
            });
        }

        private function onStageMouseMove(_arg_1:MouseEvent):void
        {
            _SafeStr_2672 = getTimer();
        }

        private function onIdleCheckTimer(_arg_1:TimerEvent):void
        {
            if (((_onDuty) && ((getTimer() - _SafeStr_2672) > (_habboHelp.getInteger("guidetool.idle.timeout", 300) * 1000))))
            {
                _habboHelp.sendMessage(new GuideSessionOnDutyUpdateMessageComposer(false, _SafeStr_2668, _SafeStr_2666, _SafeStr_2667));
            };
        }


    }
}