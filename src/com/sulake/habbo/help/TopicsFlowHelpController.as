package com.sulake.habbo.help
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.window.utils.IModalDialog;
    import com.sulake.core.window.IWindowContainer;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.communication.messages.incoming.callforhelp.CallForHelpTopicData;
    import com.sulake.habbo.window.widgets.IIlluminaInputWidget;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromPhotoMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromIMMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromForumThreadMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromForumMessageMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.help.ChatReviewSessionCreateMessageComposer;
    import com.sulake.habbo.help.cfh.registry.chat.ChatRegistryItem;
    import com.sulake.habbo.help.cfh.registry.user.UserRegistryItem;
    import com.sulake.habbo.window.widgets.IAvatarImageWidget;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.communication.messages.incoming.callforhelp.CallForHelpCategoryData;
    import com.sulake.core.window.components.ITextLinkWindow;
    import com.sulake.core.window.components._SafeStr_108;
    import com.sulake.habbo.help.cfh.registry.instantmessage.InstantMessageRegistryItem;

    public class TopicsFlowHelpController implements IDisposable
    {

        private static const START_CONTAINER:String = "start_container";
        private static const HELP_CONTAINER:String = "help_container";
        private static const USERS_CONTAINER:String = "users_container";
        private static const USER_CONTAINER:String = "user";
        private static const REASON_CONTAINER:String = "reason_container";
        private static const TOPIC_CONTAINER:String = "topic_container";
        private static const MESSAGE_CONTAINER:String = "message_container";
        private static const CHAT_CONTAINER:String = "chat_container";
        private static const BACK_BUTTON:String = "back_button";
        private static const SUMMARY_CONTAINER:String = "summary_container";
        private static const CONTINUE_BUTTON:String = "continue_button";
        private static const REQUIRES_CONTINUE_BUTTON:Array = ["users_container", "message_container", "chat_container"];
        private static const REQUIRES_USER_DATA:Array = ["reason_container", "message_container", "chat_container", "summary_container"];
        private static const FIELD_MAX_CHARS:int = 253;
        private static const TOPIC_NAME_BULLYING:String = "bullying";
        private static const TOPIC_NAME_BAD_USER_NAME:String = "habbo_name";

        private var _habboHelp:HabboHelp;
        private var _disposed:Boolean = false;
        private var _SafeStr_2677:IModalDialog;
        private var _SafeStr_570:IWindowContainer;
        private var _containers:Vector.<String>;
        private var _SafeStr_2702:IItemListWindow;
        private var _SafeStr_2703:IItemListWindow;
        private var _SafeStr_2704:IItemListWindow;
        private var _SafeStr_2705:IWindowContainer;
        private var _SafeStr_2706:IWindowContainer;
        private var _SafeStr_2707:IWindowContainer;
        private var _SafeStr_2708:String = "start_container";
        private var _SafeStr_2709:CallForHelpTopicData;
        private var _SafeStr_835:String;
        private var _reportedUserName:String;
        private var _SafeStr_2710:int = -1;
        private var _SafeStr_2711:Boolean = false;

        public function TopicsFlowHelpController(_arg_1:HabboHelp)
        {
            _habboHelp = _arg_1;
            _containers = new Vector.<String>(0);
            _containers.push("start_container", "help_container", "users_container", "user", "reason_container", "message_container", "chat_container", "back_button", "summary_container");
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            closeWindow();
            _habboHelp = null;
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function openReportingUserName():void
        {
            _SafeStr_2711 = true;
            showReportingDialog(-1, false);
            _SafeStr_2709 = getTopic("habbo_name");
            _SafeStr_570.findChildByName("message_phase_title").caption = ((_habboHelp.localization.getLocalization("generic.reason") + " ") + _habboHelp.localization.getLocalization(("help.cfh.topic." + _SafeStr_2709.id)));
            showContainer("message_container");
        }

        public function openReportingChatLineSelection():void
        {
            showReportingDialog(-1, true);
            if (!userChatLinesAvailable())
            {
                return;
            };
            showContainer("chat_container");
            populateChatMessage();
        }

        public function openReportingContentReasonCategory(_arg_1:int):Boolean
        {
            showReportingDialog(_arg_1, false);
            var _local_2:Boolean = showReasons(_arg_1);
            if (!_local_2)
            {
                closeWindow();
            };
            return (_local_2);
        }

        public function openReportingIMSelection():void
        {
            showReportingDialog(3, false);
            showContainer("chat_container");
            populateInstantMessages();
            if (_SafeStr_2704.numListItems == 0)
            {
                _habboHelp.windowManager.alertWithModal("${generic.alert.title}", "${help.cfh.error.no_user_data}", 0, null);
                closeWindow();
            };
        }

        private function showReportingDialog(_arg_1:int, _arg_2:Boolean):void
        {
            _SafeStr_2710 = _arg_1;
            if (_SafeStr_2677 == null)
            {
                openWindow();
            };
            _SafeStr_570.findChildByName("change_user").visible = _arg_2;
        }

        private function openWindow():void
        {
            if (((_SafeStr_2677 == null) && (!(disposed))))
            {
                _SafeStr_2677 = _habboHelp.getModalXmlWindow("topics_flow_help");
                _SafeStr_2677.rootWindow.procedure = windowEventProcedure;
                _SafeStr_570 = (_SafeStr_2677.rootWindow as IWindowContainer);
                _SafeStr_2702 = (_SafeStr_570.findChildByName("user_list") as IItemListWindow);
                _SafeStr_2703 = (_SafeStr_570.findChildByName("reason_list") as IItemListWindow);
                _SafeStr_2704 = (_SafeStr_570.findChildByName("chat_list") as IItemListWindow);
                _SafeStr_2705 = (_SafeStr_2702.getListItemAt(0) as IWindowContainer);
                _SafeStr_2706 = (_SafeStr_2703.getListItemAt(0) as IWindowContainer);
                _SafeStr_2707 = (_SafeStr_2704.getListItemAt(0) as IWindowContainer);
                _SafeStr_2702.removeListItems();
                _SafeStr_2703.removeListItems();
                _SafeStr_2704.removeListItems();
                IIlluminaInputWidget(IWidgetWindow(_SafeStr_570.findChildByName("help_message")).widget).maxChars = 253;
                deselectChatEntries();
            };
        }

        public function closeWindow():void
        {
            if (_SafeStr_2677 != null)
            {
                _SafeStr_2677.dispose();
                _SafeStr_2677 = null;
            };
            _SafeStr_2708 = "start_container";
        }

        public function toggleWindow():void
        {
            if (_SafeStr_2677 == null)
            {
                _SafeStr_2710 = -1;
                openWindow();
                showContainer("start_container");
            }
            else
            {
                closeWindow();
            };
        }

        private function showContainer(_arg_1:String):void
        {
            for each (var _local_2:String in _containers)
            {
                _SafeStr_570.findChildByName(_local_2).visible = false;
            };
            _SafeStr_570.findChildByName("continue_button").visible = (REQUIRES_CONTINUE_BUTTON.indexOf(_arg_1) > -1);
            _SafeStr_570.findChildByName("user").visible = (REQUIRES_USER_DATA.indexOf(_arg_1) > -1);
            _SafeStr_2708 = _arg_1;
            updateBackButtonVisibility();
            _SafeStr_570.findChildByName(_arg_1).visible = true;
            if (REQUIRES_USER_DATA.indexOf(_arg_1) > -1)
            {
                updateUserData();
            };
        }

        private function updateBackButtonVisibility():void
        {
            var _local_1:Boolean = true;
            if (_SafeStr_2708 == "start_container")
            {
                _local_1 = false;
            }
            else
            {
                if (_SafeStr_2710 == 3)
                {
                    _local_1 = (!(_SafeStr_2708 == "chat_container"));
                }
                else
                {
                    if (_SafeStr_2710 > -1)
                    {
                        _local_1 = (!(_SafeStr_2708 == "reason_container"));
                    }
                    else
                    {
                        if (_SafeStr_2711)
                        {
                            _local_1 = (!(_SafeStr_2708 == "message_container"));
                        };
                    };
                };
            };
            _SafeStr_570.findChildByName("back_button").visible = _local_1;
        }

        private function verifyUserSelected():Boolean
        {
            if (_habboHelp.reportedUserId == -1)
            {
                _habboHelp.windowManager.alertWithModal("${generic.alert.title}", "${guide.bully.request.usermissing}", 0, null);
                return (false);
            };
            return (true);
        }

        private function verifyMessage():Boolean
        {
            _SafeStr_835 = IIlluminaInputWidget(IWidgetWindow(_SafeStr_570.findChildByName("help_message")).widget).message;
            if (((_SafeStr_835 == null) || (_SafeStr_835 == "")))
            {
                _habboHelp.windowManager.alertWithModal("${generic.alert.title}", "${help.cfh.error.nomsg}", 0, null);
                return (false);
            };
            if (_SafeStr_835.length < _habboHelp.getInteger("help.cfh.length.minimum", 15))
            {
                _habboHelp.windowManager.alertWithModal("${generic.alert.title}", "${help.cfh.error.msgtooshort}", 0, null);
                return (false);
            };
            return (true);
        }

        private function verifySelectedChatLines():Boolean
        {
            var _local_1:Array = _habboHelp.callForHelpManager.chatReportController.collectSelectedEntries(_SafeStr_2710, _habboHelp.reportedUserId);
            if (((_local_1 == null) || (_local_1.length == 0)))
            {
                _habboHelp.windowManager.alertWithModal("${generic.alert.title}", "${help.cfh.error.chatmissing}", 0, null);
                return (false);
            };
            return (true);
        }

        private function windowEventProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((disposed) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "header_button_close":
                    closeWindow();
                    return;
                case "back_button":
                    switch (_SafeStr_2708)
                    {
                        case "reason_container":
                            showContainer("chat_container");
                            break;
                        case "topic_container":
                        case "message_container":
                            showContainer("reason_container");
                            populateReasons();
                            break;
                        case "chat_container":
                            if (populateUsers())
                            {
                                showContainer("users_container");
                            }
                            else
                            {
                                showContainer("start_container");
                            };
                            break;
                        case "summary_container":
                            showContainer("message_container");
                            break;
                        default:
                            showContainer("start_container");
                    };
                    return;
                case "continue_button":
                    switch (_SafeStr_2708)
                    {
                        case "users_container":
                            if (verifyUserSelected())
                            {
                                showContainer("chat_container");
                                populateChatMessage();
                            };
                            break;
                        case "message_container":
                            if (verifyMessage())
                            {
                                showContainer("summary_container");
                            };
                            break;
                        case "chat_container":
                            if (verifySelectedChatLines())
                            {
                                showContainer("reason_container");
                                populateReasons();
                            };
                            break;
                        default:
                            showContainer("start_container");
                    };
                    return;
                case "button_habbo_help":
                    showContainer("help_container");
                    return;
                case "button_user_report":
                case "change_user":
                    if (populateUsers())
                    {
                        showContainer("users_container");
                    }
                    else
                    {
                        _habboHelp.windowManager.alertWithModal("${generic.alert.title}", "${help.cfh.error.nochathistory}", 0, null);
                    };
                    return;
                case "button_account":
                    HabboWebTools.openWebPage(_habboHelp.getProperty("zendesk.url"), "habboMain");
                    _habboHelp.trackGoogle("helpWindow", "click_selfHelp");
                    closeWindow();
                    return;
                case "tour_button":
                    _habboHelp.guideHelpManager.createHelpRequest(((_habboHelp.newIdentity) ? 0 : 2));
                    _habboHelp.trackGoogle("helpWindow", "click_userTour");
                    closeWindow();
                    return;
                case "bully_button":
                    closeWindow();
                    _habboHelp.toggleNewHelpWindow();
                    _habboHelp.trackGoogle("helpWindow", "click_reportBully");
                    return;
                case "instructions_button":
                    _habboHelp.guideHelpManager.createHelpRequest(1);
                    _habboHelp.trackGoogle("helpWindow", "click_instructions");
                    closeWindow();
                    return;
                case "safetybooklet_link":
                    _habboHelp.showSafetyBooklet();
                    _habboHelp.trackGoogle("helpWindow", "click_showSafetyBooklet");
                    closeWindow();
                    return;
                case "habboway_link":
                    if (_habboHelp.getBoolean("habboway.enabled"))
                    {
                        _habboHelp.showHabboWay();
                    }
                    else
                    {
                        HabboWebTools.openWebPage(_habboHelp.getProperty("habboway.url"), "habboMain");
                    };
                    _habboHelp.trackGoogle("helpWindow", "click_habboWay");
                    closeWindow();
                    return;
                case "faq_link":
                    _habboHelp.openCfhFaq();
                    return;
                case "sanction_info_link":
                    _habboHelp.requestSanctionInfo(false);
                    closeWindow();
                    return;
                case "submit_button":
                    if (_SafeStr_2709)
                    {
                        submitCallForHelp(true);
                        closeWindow();
                    }
                    else
                    {
                        _habboHelp.windowManager.alertWithModal("${generic.alert.title}", "${help.cfh.error.notopic}", 0, null);
                    };
                    return;
                default:
                    return;
            };
        }

        public function submitCallForHelp(_arg_1:Boolean):void
        {
            if ((((!(_SafeStr_835)) || (!(_SafeStr_2709))) || (!(_habboHelp))))
            {
                return;
            };
            _habboHelp.ignoreAndUnfriendReportedUser();
            switch (_SafeStr_2710)
            {
                case 9:
                    _habboHelp.sendMessage(new CallForHelpFromPhotoMessageComposer(_habboHelp.reportedExtraDataId, _habboHelp.reportedRoomId, _habboHelp.reportedUserId, _SafeStr_2709.id, _habboHelp.reportedRoomObjectId));
                    return;
                case 3:
                    _habboHelp.sendMessage(new CallForHelpFromIMMessageComposer(_SafeStr_835, _SafeStr_2709.id, _habboHelp.reportedUserId, _habboHelp.callForHelpManager.chatReportController.collectSelectedEntries(3, _habboHelp.reportedUserId)));
                    return;
                case 4:
                    _habboHelp.sendMessage(new CallForHelpMessageComposer(_SafeStr_835, _SafeStr_2709.id, -1, _habboHelp.reportedRoomId, []));
                    return;
                case 7:
                    _habboHelp.sendMessage(new CallForHelpFromForumThreadMessageComposer(_habboHelp.callForHelpManager.reportedGroupId, _habboHelp.callForHelpManager.reportedThreadId, _SafeStr_2709.id, _SafeStr_835));
                    return;
                case 8:
                    _habboHelp.sendMessage(new CallForHelpFromForumMessageMessageComposer(_habboHelp.callForHelpManager.reportedGroupId, _habboHelp.callForHelpManager.reportedThreadId, _habboHelp.callForHelpManager.reportedMessageId, _SafeStr_2709.id, _SafeStr_835));
                    return;
                default:
                    if (((((_arg_1) && (_SafeStr_2709.name == "bullying")) && (_habboHelp.getBoolean("guides.enabled"))) && (_habboHelp.guardiansEnabled)))
                    {
                        _habboHelp.sendMessage(new ChatReviewSessionCreateMessageComposer(_habboHelp.reportedUserId, _habboHelp.reportedRoomId));
                    }
                    else
                    {
                        _habboHelp.sendMessage(new CallForHelpMessageComposer(_SafeStr_835, _SafeStr_2709.id, _habboHelp.reportedUserId, _habboHelp.reportedRoomId, _habboHelp.callForHelpManager.chatReportController.collectSelectedEntries(1, -1)));
                    };
            };
        }

        private function populateUsers():Boolean
        {
            var _local_5:Vector.<ChatRegistryItem> = undefined;
            var _local_1:IWindowContainer;
            var _local_2:Boolean;
            _SafeStr_2702.removeListItems();
            var _local_3:int;
            var _local_6:Boolean;
            for each (var _local_4:UserRegistryItem in _habboHelp.userRegistry.getRegistry())
            {
                _local_5 = _habboHelp.chatRegistry.getItemsByUser(_local_4.userId);
                if (_local_5.length != 0)
                {
                    _local_1 = (_SafeStr_2705.clone() as IWindowContainer);
                    _local_2 = (_local_4.userId == _habboHelp.reportedUserId);
                    _local_1.name = _local_4.userId.toString();
                    _local_1.findChildByName("user_bg").blend = ((_local_2) ? 1 : 0);
                    _local_1.procedure = onUserSelectEvent;
                    _local_1.findChildByName("user_name").caption = _local_4.userName;
                    _local_1.findChildByName("room_name").id = _local_4.roomId;
                    if (_local_2)
                    {
                        _habboHelp.reportedRoomId = _local_4.roomId;
                    };
                    _local_1.findChildByName("room_name").caption = ((_local_4.roomName != "") ? _habboHelp.localization.getLocalizationWithParams("help.emergency.main.step.two.room.name", "", "room_name", _local_4.roomName) : "");
                    IAvatarImageWidget(IWidgetWindow(_local_1.findChildByName("user_avatar")).widget).figure = _local_4.figure;
                    _SafeStr_2702.addListItemAt(_local_1, _local_3);
                    if (_local_2)
                    {
                        _local_3 = 1;
                        _local_6 = true;
                    };
                };
            };
            if (!_local_6)
            {
                _habboHelp.reportedUserId = -1;
                _habboHelp.reportedRoomId = -1;
            };
            return (_SafeStr_2702.numListItems > 0);
        }

        private function refreshUserList():void
        {
            var _local_2:int;
            var _local_1:IWindowContainer;
            _local_2 = 0;
            while (_local_2 < _SafeStr_2702.numListItems)
            {
                _local_1 = IWindowContainer(_SafeStr_2702.getListItemAt(_local_2));
                _local_1.findChildByName("user_bg").blend = ((int(_local_1.name) == _habboHelp.reportedUserId) ? 1 : 0);
                _local_2++;
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
            var _local_2:int = int(_arg_1.name);
            _habboHelp.reportedUserId = _local_2;
            _habboHelp.reportedRoomId = _arg_1.findChildByName("room_name").id;
            refreshUserList();
        }

        private function populateRoomReportButton():void
        {
            _SafeStr_2703.destroyListItems();
            var _local_3:int = _SafeStr_2703.height;
            _SafeStr_2703.height = 0;
            _SafeStr_2703.height = _local_3;
            var _local_2:int = 34;
            var _local_5:String = "inappropiate_room_group_event";
            var _local_4:IWindowContainer = (_SafeStr_2706.clone() as IWindowContainer);
            _habboHelp.localization.registerParameter(("help.cfh.topic." + _local_2), "name", _reportedUserName);
            var _local_1:ITextWindow = (_local_4.findChildByName("name") as ITextWindow);
            _local_1.caption = (("${help.cfh.topic." + _local_2) + "}");
            if (_local_1.height < _local_1.textHeight)
            {
                _local_1.height = (_local_1.textHeight + 5);
            };
            if (_local_4.height < ((_local_1.height + (_local_1.y * 2)) + 5))
            {
                _local_4.height = ((_local_1.height + (_local_1.y * 2)) + 5);
            };
            _local_4.name = _local_5;
            _local_4.addEventListener("WME_CLICK", onReportTopic);
            _SafeStr_2703.addListItem(_local_4);
        }

        private function populateReasons():void
        {
            var _local_1:IWindowContainer;
            _SafeStr_2703.destroyListItems();
            for each (var _local_2:CallForHelpCategoryData in _habboHelp.callForHelpCategories)
            {
                _local_1 = (_SafeStr_2706.clone() as IWindowContainer);
                _local_1.findChildByName("name").caption = (("${help.cfh.reason." + _local_2.name) + "}");
                _local_1.name = _local_2.name;
                _local_1.addEventListener("WME_CLICK", populateTopicsEvent);
                _SafeStr_2703.addListItem(_local_1);
            };
        }

        private function populateTopicsEvent(_arg_1:WindowEvent):void
        {
            var _local_2:IWindow = _arg_1.target;
            populateTopics(_local_2.name);
        }

        private function populateTopics(_arg_1:String):Boolean
        {
            var _local_5:Vector.<CallForHelpTopicData> = undefined;
            var _local_3:int;
            var _local_4:IWindowContainer;
            var _local_2:ITextWindow;
            for each (var _local_7:CallForHelpCategoryData in _habboHelp.callForHelpCategories)
            {
                if (_local_7.name == _arg_1)
                {
                    _local_5 = _local_7.topics;
                    break;
                };
            };
            if (((_local_5) && (_local_5.length > 0)))
            {
                _SafeStr_2703.destroyListItems();
                _local_3 = _SafeStr_2703.height;
                _SafeStr_2703.height = 0;
                _SafeStr_2703.height = _local_3;
                for each (var _local_6:CallForHelpTopicData in _local_5)
                {
                    _local_4 = (_SafeStr_2706.clone() as IWindowContainer);
                    _habboHelp.localization.registerParameter(("help.cfh.topic." + _local_6.id), "name", _reportedUserName);
                    _local_2 = (_local_4.findChildByName("name") as ITextWindow);
                    _local_2.caption = (("${help.cfh.topic." + _local_6.id) + "}");
                    if (_local_2.height < _local_2.textHeight)
                    {
                        _local_2.height = (_local_2.textHeight + 5);
                    };
                    if (_local_4.height < ((_local_2.height + (_local_2.y * 2)) + 5))
                    {
                        _local_4.height = ((_local_2.height + (_local_2.y * 2)) + 5);
                    };
                    _local_4.name = _local_6.name;
                    _local_4.addEventListener("WME_CLICK", onReportTopic);
                    _SafeStr_2703.addListItem(_local_4);
                };
                _SafeStr_2708 = "topic_container";
                updateBackButtonVisibility();
            }
            else
            {
                return (false);
            };
            return (true);
        }

        private function populateChatMessage():void
        {
            var _local_1:IWindowContainer;
            var _local_2:ITextLinkWindow;
            var _local_3:_SafeStr_108;
            _SafeStr_2704.removeListItems();
            _habboHelp.chatRegistry.holdPurges = true;
            var _local_4:Vector.<ChatRegistryItem> = ((_habboHelp.reportedUserId > 0) ? _habboHelp.chatRegistry.getItemsByUser(_habboHelp.reportedUserId) : _habboHelp.chatRegistry.getItems());
            Logger.log(((("Found chat items: " + _local_4.length) + " from user:") + _habboHelp.reportedUserId));
            for each (var _local_5:ChatRegistryItem in _local_4)
            {
                if (_local_5.userId != _habboHelp.ownUserId)
                {
                    _local_1 = (_SafeStr_2707.clone() as IWindowContainer);
                    _local_2 = (_local_1.findChildByName("chat_text") as ITextLinkWindow);
                    _local_2.caption = _local_5.text;
                    if (_local_2.height < _local_2.textHeight)
                    {
                        _local_2.height = (_local_2.textHeight + 5);
                    };
                    if (_local_1.height < (_local_2.height + (_local_2.y * 2)))
                    {
                        _local_1.height = (_local_2.height + (_local_2.y * 2));
                    };
                    _local_1.id = _local_5.index;
                    _local_1.procedure = onChatEntryEvent;
                    _local_3 = (_local_1.findChildByName("chat_check") as _SafeStr_108);
                    _local_3.isSelected = _local_5.selected;
                    _SafeStr_2704.addListItem(_local_1);
                };
            };
        }

        private function deselectChatEntries():void
        {
            for each (var _local_2:Vector.<InstantMessageRegistryItem> in _habboHelp.instantMessageRegistry.getItems())
            {
                for each (var _local_3:InstantMessageRegistryItem in _local_2)
                {
                    _local_3.selected = false;
                };
            };
            for each (var _local_1:ChatRegistryItem in _habboHelp.chatRegistry.getItems())
            {
                _local_1.selected = false;
            };
        }

        private function onChatEntryEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:int;
            var _local_4:_SafeStr_108;
            var _local_5:ChatRegistryItem;
            if (_arg_1.type == "WME_CLICK")
            {
                _local_3 = _arg_2.id;
                if ((_arg_2 is ITextLinkWindow))
                {
                    _local_3 = _arg_2.parent.id;
                    _local_4 = ((_arg_2.parent as IWindowContainer).findChildByName("chat_check") as _SafeStr_108);
                };
                if ((_arg_2 is _SafeStr_108))
                {
                    _local_3 = _arg_2.parent.id;
                    _local_4 = (_arg_2 as _SafeStr_108);
                };
                _local_5 = _habboHelp.chatRegistry.getItem(_local_3);
                if (!_local_5)
                {
                    return;
                };
                if (((!(_local_5.selected)) && (!(_local_5.roomId == _habboHelp.reportedRoomId))))
                {
                    _habboHelp.reportedRoomId = _local_5.roomId;
                };
                _local_5.selected = (!(_local_5.selected));
                _local_4.isSelected = _local_5.selected;
            };
        }

        private function populateInstantMessages():void
        {
            var _local_1:IWindowContainer;
            var _local_2:_SafeStr_108;
            _SafeStr_2704.removeListItems();
            _habboHelp.instantMessageRegistry.holdPurges = true;
            var _local_3:Vector.<InstantMessageRegistryItem> = _habboHelp.instantMessageRegistry.getItemsByUser(_habboHelp.reportedUserId);
            for each (var _local_4:InstantMessageRegistryItem in _local_3)
            {
                _local_1 = (_SafeStr_2707.clone() as IWindowContainer);
                _local_1.findChildByName("chat_text").caption = _local_4.text;
                _local_1.id = _local_4.index;
                _local_1.procedure = onInstantMessageEntryEvent;
                _local_2 = (_local_1.findChildByName("chat_check") as _SafeStr_108);
                _local_2.isSelected = _local_4.selected;
                _SafeStr_2704.addListItem(_local_1);
            };
        }

        private function onInstantMessageEntryEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:int;
            var _local_4:_SafeStr_108;
            var _local_5:InstantMessageRegistryItem;
            if (_arg_1.type == "WME_CLICK")
            {
                _local_3 = _arg_2.id;
                if ((_arg_2 is ITextLinkWindow))
                {
                    _local_3 = _arg_2.parent.id;
                    _local_4 = ((_arg_2.parent as IWindowContainer).findChildByName("chat_check") as _SafeStr_108);
                }
                else
                {
                    if ((_arg_2 is _SafeStr_108))
                    {
                        _local_3 = _arg_2.parent.id;
                        _local_4 = (_arg_2 as _SafeStr_108);
                    };
                };
                _local_5 = _habboHelp.instantMessageRegistry.getItem(_habboHelp.reportedUserId, _local_3);
                if (_local_5)
                {
                    _local_5.selected = (!(_local_5.selected));
                    _local_4.isSelected = _local_5.selected;
                };
            };
        }

        private function onReportTopic(_arg_1:WindowEvent=null):void
        {
            if (_SafeStr_2677 == null)
            {
                openWindow();
            };
            _SafeStr_2709 = getTopic(_arg_1.target.name);
            showContainer("message_container");
        }

        private function isNotNeededToSelectUser():Boolean
        {
            return (((_SafeStr_2710 == 4) || (_SafeStr_2710 == 7)) || (_SafeStr_2710 == 8));
        }

        private function showReasons(_arg_1:int):Boolean
        {
            if (((isNotNeededToSelectUser()) || (verifyUserSelected())))
            {
                showContainer("reason_container");
                if (_arg_1 == 4)
                {
                    populateRoomReportButton();
                }
                else
                {
                    populateReasons();
                };
                return (true);
            };
            return (false);
        }

        private function userChatLinesAvailable():Boolean
        {
            populateUsers();
            if (_habboHelp.reportedUserId <= 0)
            {
                _habboHelp.windowManager.alertWithModal("${generic.alert.title}", "${help.cfh.error.no_user_data}", 0, null);
                closeWindow();
                return (false);
            };
            return (true);
        }

        private function getTopic(_arg_1:String):CallForHelpTopicData
        {
            for each (var _local_3:CallForHelpCategoryData in _habboHelp.callForHelpCategories)
            {
                for each (var _local_2:CallForHelpTopicData in _local_3.topics)
                {
                    if (_local_2.name == _arg_1)
                    {
                        return (_local_2);
                    };
                };
            };
            return (null);
        }

        private function updateUserData():void
        {
            var _local_1:UserRegistryItem;
            switch (_SafeStr_2710)
            {
                case 4:
                    _SafeStr_570.findChildByName("reported_user_avatar").visible = false;
                    _SafeStr_570.findChildByName("user_info_title").visible = false;
                    _SafeStr_570.findChildByName("reported_user_name").caption = _habboHelp.callForHelpManager.reportedRoomName;
                    return;
                case 7:
                case 8:
                    _SafeStr_570.findChildByName("reported_user_avatar").visible = false;
                    _SafeStr_570.findChildByName("user_info_title").visible = false;
                    _SafeStr_570.findChildByName("reported_user_name").visible = false;
                    return;
                default:
                    if (_habboHelp.reportedUserId > 0)
                    {
                        _local_1 = _habboHelp.userRegistry.getEntry(_habboHelp.reportedUserId);
                        if (_local_1)
                        {
                            _reportedUserName = _local_1.userName;
                            IAvatarImageWidget(IWidgetWindow(_SafeStr_570.findChildByName("reported_user_avatar")).widget).figure = _local_1.figure;
                        }
                        else
                        {
                            _SafeStr_570.findChildByName("reported_user_avatar").visible = false;
                            _reportedUserName = _habboHelp.reportedUserName;
                        };
                        _SafeStr_570.findChildByName("reported_user_name").caption = _reportedUserName;
                    };
            };
        }


    }
}