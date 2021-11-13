package com.sulake.habbo.help
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpReplyMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.IssueCloseNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpResultMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromSelfieMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromPhotoMessageComposer;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.habbo.window.widgets.IIlluminaInputWidget;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.habbo.help.cfh.registry.user.UserRegistryItem;
    import com.sulake.habbo.window.widgets.IAvatarImageWidget;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.users.IgnoreUserIdMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.help.ChatReviewSessionCreateMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromIMMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromForumThreadMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromForumMessageMessageComposer;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.communication.messages.parser.help.CallForHelpReplyMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.CallForHelpResultMessageParser;
    import com.sulake.habbo.communication.messages.parser.help.IssueCloseNotificationMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.help.DeletePendingCallsForHelpMessageComposer;

    public class CallForHelpManager implements IDisposable
    {

        private static const FIELD_MAX_CHARS:int = 253;
        private static const EMERGENCY_HELP_REQUEST_TITLE:String = "emergency_help_request";

        private var _disposed:Boolean;
        private var _habboHelp:HabboHelp;
        private var _window:IWindowContainer;
        private var _chatReportController:ChatReportController;
        private var _reportedUserId:int = -1;
        private var _reportedUserName:String = "";
        private var _reportedRoomId:int = -1;
        private var _reportedRoomName:String;
        private var _reportedRoomDescription:String;
        private var _reportedGroupId:int = -1;
        private var _reportedThreadId:int = -1;
        private var _reportedMessageId:int = -1;
        private var _reportedExtraDataId:String;
        private var _reportedRoomObjectId:int = -1;
        private var _SafeStr_562:int;
        private var _SafeStr_2683:int;
        private var _SafeStr_2684:int;
        private var _SafeStr_835:String;

        public function CallForHelpManager(_arg_1:HabboHelp)
        {
            _habboHelp = _arg_1;
            _chatReportController = new ChatReportController(_habboHelp, onChatReportEvent);
            _habboHelp.communicationManager.addHabboConnectionMessageEvent(new CallForHelpReplyMessageEvent(onCallForHelpReply));
            _habboHelp.communicationManager.addHabboConnectionMessageEvent(new IssueCloseNotificationMessageEvent(onIssueClose));
            _habboHelp.communicationManager.addHabboConnectionMessageEvent(new CallForHelpResultMessageEvent(onCallForHelpResult));
        }

        private static function getCloseReasonKey(_arg_1:int):String
        {
            if (_arg_1 == 1)
            {
                return ("useless");
            };
            if (_arg_1 == 2)
            {
                return ("abusive");
            };
            return ("resolved");
        }


        public function dispose():void
        {
            if (!_disposed)
            {
                closeWindow();
                if (_chatReportController)
                {
                    _chatReportController.dispose();
                    _chatReportController = null;
                };
                _habboHelp = null;
                _disposed = true;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get reportedUserId():int
        {
            return (_reportedUserId);
        }

        public function get reportedUserName():String
        {
            return (_reportedUserName);
        }

        public function get reportedRoomId():int
        {
            return (_reportedRoomId);
        }

        public function get reportedRoomName():String
        {
            return (_reportedRoomName);
        }

        public function get reportedExtraDataId():String
        {
            return (_reportedExtraDataId);
        }

        public function get reportedRoomObjectId():int
        {
            return (_reportedRoomObjectId);
        }

        public function get reportedGroupId():int
        {
            return (_reportedGroupId);
        }

        public function get reportedThreadId():int
        {
            return (_reportedThreadId);
        }

        public function get reportedMessageId():int
        {
            return (_reportedMessageId);
        }

        public function set reportedUserId(_arg_1:int):void
        {
            _reportedUserId = _arg_1;
        }

        public function set reportedUserName(_arg_1:String):void
        {
            _reportedUserName = _arg_1;
        }

        public function set reportedRoomId(_arg_1:int):void
        {
            _reportedRoomId = _arg_1;
        }

        public function set reportedRoomName(_arg_1:String):void
        {
            _reportedRoomName = _arg_1;
        }

        public function set reportedExtraDataId(_arg_1:String):void
        {
            _reportedExtraDataId = _arg_1;
        }

        public function set reportedRoomObjectId(_arg_1:int):void
        {
            _reportedRoomObjectId = _arg_1;
        }

        public function set reportedGroupId(_arg_1:int):void
        {
            _reportedGroupId = _arg_1;
        }

        public function set reportedThreadId(_arg_1:int):void
        {
            _reportedThreadId = _arg_1;
        }

        public function set reportedMessageId(_arg_1:int):void
        {
            _reportedMessageId = _arg_1;
        }

        public function reportBully(_arg_1:int, _arg_2:int):void
        {
            if (_habboHelp.guardiansEnabled)
            {
                _reportedUserId = _arg_1;
                _reportedRoomId = _arg_2;
                _habboHelp.queryForGuideReportingStatus(3);
            }
            else
            {
                reportUser(_arg_1, 1, 123);
            };
        }

        public function reportUser(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            _reportedUserId = _arg_1;
            _reportedRoomId = -1;
            _SafeStr_2683 = _arg_3;
            _habboHelp.queryForPendingCallsForHelp(_arg_2);
        }

        public function reportRoom(_arg_1:int, _arg_2:String, _arg_3:String):void
        {
            _reportedRoomId = _arg_1;
            _reportedRoomName = _arg_2;
            _reportedRoomDescription = _arg_3;
            _reportedUserId = -1;
            _habboHelp.queryForPendingCallsForHelp(4);
        }

        public function reportThread(_arg_1:int, _arg_2:int):void
        {
            _reportedGroupId = _arg_1;
            _reportedThreadId = _arg_2;
            _habboHelp.queryForPendingCallsForHelp(7);
        }

        public function reportMessage(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            _reportedGroupId = _arg_1;
            _reportedThreadId = _arg_2;
            _reportedMessageId = _arg_3;
            _habboHelp.queryForPendingCallsForHelp(8);
        }

        public function reportSelfie(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:int):void
        {
            _habboHelp.sendMessage(new CallForHelpFromSelfieMessageComposer(_arg_1, _arg_3, _arg_4, _arg_2, _arg_5));
        }

        public function reportPhoto(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int):void
        {
            _habboHelp.setReportMessage(new CallForHelpFromPhotoMessageComposer(_arg_1, _arg_3, _arg_4, _arg_2, _arg_5));
            _habboHelp.queryForPendingCallsForHelp(9);
        }

        public function openEmergencyHelpRequest():void
        {
            reportUser(0, 1, -1);
        }

        private function showAbusiveNotice():void
        {
            closeWindow();
            _window = (_habboHelp.getXmlWindow("abusive_notice") as IWindowContainer);
            _window.center();
            _window.findChildByName("header_button_close").visible = false;
            _window.procedure = onAbusiveNoticeEvent;
        }

        public function showEmergencyHelpRequest(_arg_1:int):void
        {
            var _local_3:ISelectableWindow;
            var _local_6:ISelectableWindow;
            closeWindow();
            _SafeStr_562 = _arg_1;
            if (_SafeStr_562 == 6)
            {
                _window = (_habboHelp.getXmlWindow("bully_report") as IWindowContainer);
                _window.procedure = onBullyReportEvent;
            }
            else
            {
                _window = (_habboHelp.getXmlWindow("emergency_help_request") as IWindowContainer);
                _window.procedure = onEmergencyHelpRequestEvent;
                IIlluminaInputWidget(IWidgetWindow(_window.findChildByName("help_message")).widget).maxChars = 253;
            };
            _window.center();
            var _local_4:IItemListWindow = (_window.findChildByName("user_panel") as IItemListWindow);
            var _local_5:IItemListWindow = (_window.findChildByName("room_panel") as IItemListWindow);
            var _local_2:ISelectorWindow = ISelectorWindow(_window.findChildByName("topic_selector"));
            if (_local_2 != null)
            {
                _local_3 = _local_2.getSelectableByName(("" + _SafeStr_2683));
                if (_local_3 != null)
                {
                    _local_2.setSelected(_local_3);
                };
                _local_6 = _local_2.getSelectableByName("123");
                if (((!(_local_6 == null)) && (_habboHelp.guardiansEnabled)))
                {
                    _local_6.visible = false;
                };
            };
            switch (_SafeStr_562)
            {
                case 4:
                    showPanels(false, true);
                    return;
                case 1:
                    showPanels(true, false);
                    return;
                case 3:
                    showPanels(false, false);
                    return;
                case 7:
                case 8:
                    showPanels(false, false);
                    return;
                case 6:
                    populateUserList();
                default:
            };
        }

        private function showChatReportTool():void
        {
            closeWindow();
            _chatReportController.show(_habboHelp.ownUserId, _reportedUserId, _SafeStr_562);
        }

        private function showPanels(_arg_1:Boolean, _arg_2:Boolean):void
        {
            var _local_3:IItemListWindow = (_window.findChildByName("user_panel") as IItemListWindow);
            var _local_5:IItemListWindow = (_window.findChildByName("room_panel") as IItemListWindow);
            var _local_4:Boolean = ((_arg_1) || (_arg_2));
            _window.findChildByName("submit_box_wide").visible = _local_4;
            _window.findChildByName("submit_box_narrow").visible = (!(_local_4));
            _window.findChildByName("separator").visible = _local_4;
            _local_5.visible = _arg_2;
            _local_3.visible = _arg_1;
            if (_arg_2)
            {
                _local_5.getListItemByName("room_name").caption = ((_reportedRoomName != null) ? _reportedRoomName : "");
                _local_5.getListItemByName("room_description").caption = ((_reportedRoomDescription != null) ? _reportedRoomDescription : "");
            };
            if (_arg_1)
            {
                populateUserList();
            };
            if (!_local_4)
            {
                _window.width = 301;
            };
        }

        private function populateUserList():void
        {
            var _local_3:IWindowContainer;
            var _local_4:Boolean;
            var _local_2:IItemListWindow = (_window.findChildByName("user_list") as IItemListWindow);
            var _local_1:IWindowContainer = (_local_2.getListItemAt(0) as IWindowContainer);
            _local_2.removeListItems();
            var _local_5:int;
            for each (var _local_6:UserRegistryItem in _habboHelp.userRegistry.getRegistry())
            {
                _local_3 = (_local_1.clone() as IWindowContainer);
                _local_4 = (_local_6.userId == _reportedUserId);
                _local_3.name = _local_6.userId.toString();
                _local_3.blend = ((_local_4) ? 1 : 0);
                _local_3.procedure = onUserSelectEvent;
                _local_3.findChildByName("user_name").caption = _local_6.userName;
                _local_3.findChildByName("room_name").id = _local_6.roomId;
                if (_local_4)
                {
                    _reportedRoomId = _local_6.roomId;
                };
                _local_3.findChildByName("room_name").caption = ((_local_6.roomName != "") ? _habboHelp.localization.getLocalizationWithParams("help.emergency.main.step.two.room.name", "", "room_name", _local_6.roomName) : "");
                IAvatarImageWidget(IWidgetWindow(_local_3.findChildByName("user_avatar")).widget).figure = _local_6.figure;
                _local_2.addListItemAt(_local_3, _local_5);
                if (_local_4)
                {
                    _local_5 = 1;
                };
            };
        }

        private function refreshUserList():void
        {
            var _local_3:int;
            var _local_2:IWindowContainer;
            var _local_1:IItemListWindow = (_window.findChildByName("user_list") as IItemListWindow);
            _local_3 = 0;
            while (_local_3 < _local_1.numListItems)
            {
                _local_2 = IWindowContainer(_local_1.getListItemAt(_local_3));
                _local_2.blend = ((int(_local_2.name) == _reportedUserId) ? 1 : 0);
                _local_3++;
            };
        }

        public function showPendingRequest(_arg_1:String):void
        {
            closeWindow();
            _window = (_habboHelp.getXmlWindow("pending_request") as IWindowContainer);
            _window.findChildByName("request_message").caption = _arg_1;
            _window.center();
            _window.procedure = onPendingReuqestEvent;
        }

        private function closeWindow():void
        {
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
        }

        private function onAbusiveNoticeEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "close_button":
                        closeWindow();
                        return;
                };
            };
        }

        private function onEmergencyHelpRequestEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "submit_button":
                        if (!saveEmergencyHelpRequestData())
                        {
                            return;
                        };
                        basicInfoDone();
                        return;
                    case "header_button_close":
                        closeWindow();
                        return;
                };
            };
        }

        private function onBullyReportEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "submit_button":
                        if (_reportedUserId > 0)
                        {
                            _habboHelp.sendMessage(new IgnoreUserIdMessageComposer(_reportedUserId));
                            _habboHelp.sendMessage(new ChatReviewSessionCreateMessageComposer(_reportedUserId, _reportedRoomId));
                            closeWindow();
                        }
                        else
                        {
                            _habboHelp.windowManager.alert("${generic.alert.title}", "${guide.bully.request.usermissing}", 0, null);
                        };
                        return;
                    case "header_button_close":
                        closeWindow();
                        return;
                };
            };
        }

        private function onChatReportEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "submit_button":
                        if (_chatReportController.collectSelectedEntries(_SafeStr_562, -1).length == 0)
                        {
                            _habboHelp.windowManager.alert("${generic.alert.title}", "${help.cfh.error.chatmissing}", 0, null);
                            return;
                        };
                        submitCallForHelp();
                        _chatReportController.closeWindow();
                        closeWindow();
                        return;
                    case "header_button_close":
                        _chatReportController.closeWindow();
                        return;
                };
            };
        }

        private function onUserSelectEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                selectUserToReport((_arg_2 as IWindowContainer));
            };
        }

        private function selectUserToReport(_arg_1:IWindowContainer):void
        {
            if ((((_window == null) || (!(_window.name == "emergency_help_request"))) || (_arg_1 == null)))
            {
                return;
            };
            var _local_2:int = int(_arg_1.name);
            if (_reportedUserId == _local_2)
            {
                _reportedUserId = 0;
                _reportedRoomId = -1;
            }
            else
            {
                _reportedUserId = _local_2;
                _reportedRoomId = _arg_1.findChildByName("room_name").id;
            };
            refreshUserList();
        }

        private function basicInfoDone():void
        {
            var _local_1:Boolean = isChatSelectionRequired();
            if (_SafeStr_562 == 3)
            {
                if (!_habboHelp.instantMessageRegistry.hasUserChatted(_reportedUserId))
                {
                    _habboHelp.windowManager.alert("${generic.alert.title}", "${help.cfh.error.nochathistory}", 0, null);
                };
            }
            else
            {
                if ((((_local_1) && (!(_habboHelp.chatRegistry.hasContentWithoutChatFromUser(_habboHelp.ownUserId)))) && (_habboHelp.chatRegistry.hasContentWithoutChatFromUser(_reportedUserId))))
                {
                    _habboHelp.windowManager.alert("${generic.alert.title}", "${help.cfh.error.nochathistory}", 0, null);
                    return;
                };
            };
            if (_local_1)
            {
                showChatReportTool();
            }
            else
            {
                submitCallForHelp();
            };
        }

        private function isChatSelectionRequired():Boolean
        {
            if ((((_SafeStr_562 == 7) || (_SafeStr_562 == 8)) || (_SafeStr_562 == 4)))
            {
                return (false);
            };
            return (((_reportedUserId <= 0) || (_habboHelp.chatRegistry.getItemsByUser(_reportedUserId).length > 0)) || (_SafeStr_562 == 3));
        }

        private function saveEmergencyHelpRequestData(_arg_1:Boolean=true):Boolean
        {
            if (((_window == null) || (!(_window.name == "emergency_help_request"))))
            {
                return (false);
            };
            _SafeStr_835 = IIlluminaInputWidget(IWidgetWindow(_window.findChildByName("help_message")).widget).message;
            if (((_SafeStr_835 == null) || (_SafeStr_835 == "")))
            {
                _habboHelp.windowManager.alert("${generic.alert.title}", "${help.cfh.error.nomsg}", 0, null);
                return (false);
            };
            if (_SafeStr_835.length < _habboHelp.getInteger("help.cfh.length.minimum", 15))
            {
                _habboHelp.windowManager.alert("${generic.alert.title}", "${help.cfh.error.msgtooshort}", 0, null);
                return (false);
            };
            _SafeStr_2684 = 0;
            var _local_2:ISelectableWindow = ISelectorWindow(_window.findChildByName("topic_selector")).getSelected();
            if (_local_2 != null)
            {
                _SafeStr_2684 = int(_local_2.name);
            };
            if (_SafeStr_2684 == 0)
            {
                _habboHelp.windowManager.alert("${generic.alert.title}", "${help.cfh.error.notopic}", 0, null);
                return (false);
            };
            if (((_SafeStr_562 == 8) || (_SafeStr_562 == 7)))
            {
                return (true);
            };
            if ((((_reportedUserId <= 0) && ((!(_SafeStr_562 == 8)) && (_SafeStr_562 == 7))) || ((_SafeStr_562 == 4) && (!(_habboHelp.getBoolean("room.report.enabled"))))))
            {
                _habboHelp.windowManager.alert("${generic.alert.title}", "${guide.bully.request.usermissing}", 0, null);
                return (false);
            };
            if (_habboHelp.friendList.getFriend(_reportedUserId) != null)
            {
                _habboHelp.windowManager.confirm("${help.cfh.unfriend.confirm.title}", "${help.cfh.unfriend.confirm.message}", (0x10 | 0x20), onFriendReportConfirmation);
                return (false);
            };
            return (true);
        }

        private function submitCallForHelp():void
        {
            var _local_1:int;
            closeWindow();
            switch (_SafeStr_562)
            {
                case 1:
                case 4:
                    _local_1 = ((_chatReportController.reportedRoomId <= 0) ? _reportedRoomId : _chatReportController.reportedRoomId);
                    _habboHelp.sendMessage(new CallForHelpMessageComposer(_SafeStr_835, _SafeStr_2684, _reportedUserId, _local_1, _chatReportController.collectSelectedEntries(_SafeStr_562, -1)));
                    break;
                case 3:
                    _habboHelp.sendMessage(new CallForHelpFromIMMessageComposer(_SafeStr_835, _SafeStr_2684, _reportedUserId, _chatReportController.collectSelectedEntries(3, -1)));
                    break;
                case 7:
                    _habboHelp.sendMessage(new CallForHelpFromForumThreadMessageComposer(_reportedGroupId, _reportedThreadId, _SafeStr_2684, _SafeStr_835));
                    break;
                case 8:
                    _habboHelp.sendMessage(new CallForHelpFromForumMessageMessageComposer(_reportedGroupId, _reportedThreadId, _reportedMessageId, _SafeStr_2684, _SafeStr_835));
                default:
            };
            _habboHelp.ignoreAndUnfriendReportedUser();
        }

        private function onFriendReportConfirmation(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            if (_arg_2.type == "WE_OK")
            {
                basicInfoDone();
            };
            _arg_1.dispose();
        }

        private function onPendingReuqestEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "keep_button":
                    case "header_button_close":
                        closeWindow();
                        return;
                    case "discard_button":
                        deletePendingCallsForHelp();
                        closeWindow();
                        return;
                };
            };
        }

        private function onCallForHelpReply(_arg_1:IMessageEvent):void
        {
            var _local_2:CallForHelpReplyMessageParser = CallForHelpReplyMessageEvent(_arg_1).getParser();
            _habboHelp.windowManager.alert("${help.cfh.reply.title}", _local_2.message, 0, null);
        }

        private function onCallForHelpResult(_arg_1:IMessageEvent):void
        {
            var _local_3:CallForHelpResultMessageParser = CallForHelpResultMessageEvent(_arg_1).getParser();
            var _local_4:int = _local_3.resultType;
            var _local_2:String = _local_3.messageText;
            switch (_local_4)
            {
                case 1:
                    _habboHelp.queryForPendingCallsForHelp(1);
                    return;
                case 2:
                    showAbusiveNotice();
                    return;
                default:
                    if (_local_2 == "")
                    {
                        _local_2 = "${help.cfh.sent.text}";
                    };
                    _habboHelp.windowManager.alert("${help.cfh.sent.title}", _local_2, 0, null);
            };
        }

        private function onIssueClose(_arg_1:IssueCloseNotificationMessageEvent):void
        {
            var _local_3:IssueCloseNotificationMessageParser = _arg_1.getParser();
            var _local_2:String = _local_3.messageText;
            if (_local_2 == "")
            {
                _local_2 = (("${help.cfh.closed." + getCloseReasonKey(_local_3.closeReason)) + "}");
            };
            _habboHelp.windowManager.alert("${mod.alert.title}", _local_2, 0, null);
        }

        private function deletePendingCallsForHelp():void
        {
            _habboHelp.sendMessage(new DeletePendingCallsForHelpMessageComposer());
        }

        public function get chatReportController():ChatReportController
        {
            return (_chatReportController);
        }


    }
}