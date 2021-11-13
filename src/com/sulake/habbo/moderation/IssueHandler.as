package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
    import com.sulake.core.window.components.IFrameWindow;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.callforhelp.CallForHelpCategoryData;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import flash.utils.getTimer;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components._SafeStr_108;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetCfhChatlogMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModToolPreferencesComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.communication.messages.incoming.callforhelp.CallForHelpTopicData;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class IssueHandler implements ITrackedWindow, IIssueHandler, IUpdateReceiver 
    {

        private static const USELESS_REPORTS_TOPIC_ID:int = 27;
        private static const AUTO_TOPIC_ID:int = 28;
        private static const _SafeStr_2835:int = 1;
        private static const AUTO_TRIGGERED_CATEGORY_ID:int = 3;

        private var _moderationManager:ModerationManager;
        private var _SafeStr_2836:IssueBundle;
        private var _SafeStr_2837:IssueMessageData;
        private var _window:IFrameWindow;
        private var _SafeStr_2838:Vector.<CallForHelpCategoryData>;
        private var _SafeStr_2839:Array;
        private var _topicDropdown:IDropMenuWindow;
        private var _callerUserInfo:UserInfoCtrl;
        private var _reportedUserInfo:UserInfoCtrl;
        private var _disposed:Boolean;
        private var _SafeStr_2840:int;
        private var _SafeStr_2841:ChatlogCtrl;
        private var _chatFrame:IWindowContainer;
        private var _SafeStr_2704:IItemListWindow;
        private var _SafeStr_2842:int = 0;
        private var _SafeStr_2843:int;
        private var _SafeStr_2844:int;
        private var _lastWindowWidth:int;
        private var _SafeStr_2470:int;
        private var _SafeStr_2845:uint = getTimer();
        private var _SafeStr_2846:IWindowContainer;
        private var _SafeStr_2847:ITextFieldWindow;

        public function IssueHandler(_arg_1:ModerationManager, _arg_2:IssueBundle, _arg_3:Vector.<CallForHelpCategoryData>, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int)
        {
            _moderationManager = _arg_1;
            _SafeStr_2836 = _arg_2;
            _SafeStr_2838 = _arg_3;
            _SafeStr_2843 = _arg_4;
            _SafeStr_2844 = _arg_5;
            _lastWindowWidth = _arg_6;
            _SafeStr_2470 = _arg_7;
        }

        public function getType():int
        {
            return (8);
        }

        public function getId():String
        {
            return ("" + _SafeStr_2836.id);
        }

        public function getFrame():IFrameWindow
        {
            return (_window);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
            if (this._callerUserInfo != null)
            {
                this._callerUserInfo.dispose();
                this._callerUserInfo = null;
            };
            if (this._reportedUserInfo != null)
            {
                this._reportedUserInfo.dispose();
                this._reportedUserInfo = null;
            };
            if (this._SafeStr_2841 != null)
            {
                this._SafeStr_2841.dispose();
                this._SafeStr_2841 = null;
            };
            if (_SafeStr_2846)
            {
                _SafeStr_2846.dispose();
                _SafeStr_2846 = null;
            };
            if (_SafeStr_2847)
            {
                _SafeStr_2847.dispose();
                _SafeStr_2847 = null;
            };
            _moderationManager.removeUpdateReceiver(this);
            _moderationManager = null;
            _SafeStr_2836 = null;
        }

        public function show():void
        {
            var _local_5:IItemListWindow;
            var _local_6:IWindow;
            if (_window != null)
            {
                return;
            };
            if (((_moderationManager.windowManager == null) || (_moderationManager.assets == null)))
            {
                return;
            };
            _window = (_moderationManager.getXmlWindow("issue_handler") as IFrameWindow);
            if (_window == null)
            {
                return;
            };
            var _local_3:IItemListWindow = (_window.findChildByName("issues_item_list") as IItemListWindow);
            _SafeStr_2846 = (_local_3.getListItemAt(0) as IWindowContainer);
            _local_3.removeListItems();
            var _local_2:IItemListWindow = (_window.findChildByName("msg_item_list") as IItemListWindow);
            _SafeStr_2847 = (_local_2.getListItemAt(0) as ITextFieldWindow);
            _local_2.removeListItems();
            var _local_7:IWindow = _window.findChildByTag("close");
            if (_local_7 != null)
            {
                _local_7.addEventListener("WME_CLICK", onClose);
            };
            _local_7 = _window.findChildByName("issue_cont");
            if (_local_7 != null)
            {
                _local_7.addEventListener("WE_RELOCATED", onWindowRelocatedOrResized);
                _local_7.addEventListener("WE_RESIZED", onWindowRelocatedOrResized);
                _moderationManager.registerUpdateReceiver(this, 1000);
            };
            _SafeStr_2845 = getTimer();
            setProc("close_useless", onCloseUseless);
            setProc("close_sanction", onCloseSanction);
            setProc("close_resolved", onCloseResolved);
            setProc("release", onRelease);
            _local_7 = _window.findChildByName("move_to_player_support");
            if (_local_7 != null)
            {
                _local_7.disable();
            };
            _moderationManager.issueManager.requestSanctionData(_SafeStr_2836.id, -1);
            initializeTopicDropdown();
            _SafeStr_2837 = _SafeStr_2836.getHighestPriorityIssue();
            _callerUserInfo = new UserInfoCtrl(_window, _moderationManager, _SafeStr_2837, this);
            _reportedUserInfo = new UserInfoCtrl(_window, _moderationManager, _SafeStr_2837, this);
            _callerUserInfo.load(IWindowContainer(_window.findChildByName("caller_user_info")), _SafeStr_2837.reporterUserId);
            if (((_SafeStr_2837.categoryId == 3) && (_SafeStr_2837.reportedCategoryId == 28)))
            {
                _topicDropdown.selection = _SafeStr_2840;
                _moderationManager.issueManager.requestSanctionData(_SafeStr_2836.id, 1);
            };
            var _local_1:IWindowContainer = IWindowContainer(_window.findChildByName("reported_user_info"));
            if (_SafeStr_2836.reportedUserId > 0)
            {
                _reportedUserInfo.load(_local_1, _SafeStr_2836.reportedUserId);
            }
            else
            {
                _local_5 = IItemListWindow(_window.findChildByName("issue_cont"));
                _local_6 = _window.findChildByName("reported_user_info_caption");
                _local_5.removeListItem(_local_6);
                _local_5.removeListItem(_local_1);
            };
            var _local_4:_SafeStr_108 = (_window.findChildByName("handle_next_checkbox") as _SafeStr_108);
            if (_local_4 != null)
            {
                _local_4.select();
            };
            _chatFrame = IWindowContainer(_window.findChildByName("chat_cont"));
            _SafeStr_2704 = IItemListWindow(_chatFrame.findChildByName("evidence_list"));
            _SafeStr_2841 = new ChatlogCtrl(new GetCfhChatlogMessageComposer(_SafeStr_2837.issueId), _moderationManager, 3, _SafeStr_2837.issueId, _SafeStr_2837, _chatFrame, _SafeStr_2704, true);
            _SafeStr_2841.show();
            Logger.log(("HARASSER: " + _SafeStr_2836.reportedUserId));
            updateIssueList();
            updateMessages();
        }

        private function sendWindowPreferences():void
        {
            _SafeStr_2843 = _window.x;
            _SafeStr_2844 = _window.y;
            _lastWindowWidth = _window.width;
            _SafeStr_2470 = _window.height;
            _moderationManager.issueManager.setToolPreferences(_SafeStr_2843, _SafeStr_2844, _lastWindowWidth, _SafeStr_2470);
            _moderationManager.connection.send(new ModToolPreferencesComposer(_SafeStr_2843, _SafeStr_2844, _lastWindowWidth, _SafeStr_2470));
        }

        private function windowDimensionsChanged():Boolean
        {
            if (_SafeStr_2843 != _window.x)
            {
                return (true);
            };
            if (_SafeStr_2844 != _window.y)
            {
                return (true);
            };
            if (_lastWindowWidth != _window.width)
            {
                return (true);
            };
            if (_SafeStr_2470 != _window.height)
            {
                return (true);
            };
            return (false);
        }

        public function update(_arg_1:uint):void
        {
            var _local_2:uint = getTimer();
            if (((windowDimensionsChanged()) && ((_local_2 - _SafeStr_2845) > 5000)))
            {
                sendWindowPreferences();
            };
        }

        private function onWindowRelocatedOrResized(_arg_1:WindowEvent):void
        {
            var _local_4:IItemListWindow = (_arg_1.window as IItemListWindow);
            if (_local_4 == null)
            {
                return;
            };
            var _local_5:IItemListWindow = (_local_4.getListItemByName("issues_item_list") as IItemListWindow);
            var _local_3:IItemListWindow = (_local_4.getListItemByName("msg_item_list") as IItemListWindow);
            if (((_local_5 == null) || (_local_3 == null)))
            {
                return;
            };
            var _local_2:int = ((((_local_4.height - _local_4.scrollableRegion.height) + _local_5.height) + _local_3.height) * 0.5);
            _local_4.autoArrangeItems = false;
            _local_5.height = _local_2;
            _local_3.height = _local_2;
            _local_4.autoArrangeItems = true;
        }

        private function updateIssueList():void
        {
            var _local_1:IWindowContainer;
            var _local_10:IWindowContainer;
            var _local_2:IWindow;
            var _local_4:IssueMessageData;
            var _local_13:String;
            if (_window == null)
            {
                return;
            };
            var _local_6:IItemListWindow = (_window.findChildByName("issues_item_list") as IItemListWindow);
            if (_local_6 == null)
            {
                return;
            };
            var _local_8:Array = _SafeStr_2836.issues;
            var _local_7:int;
            var _local_12:int = _local_6.numListItems;
            var _local_3:int = _local_8.length;
            if (_local_12 < _local_3)
            {
                _local_1 = (_SafeStr_2846.clone() as IWindowContainer);
                _local_6.addListItem(_local_1);
                _local_7 = 1;
                while (_local_7 < (_local_3 - _local_12))
                {
                    _local_10 = (_local_1.clone() as IWindowContainer);
                    if (_local_10 == null)
                    {
                        return;
                    };
                    _local_6.addListItem(_local_10);
                    _local_7++;
                };
            }
            else
            {
                if (_local_12 > _local_3)
                {
                    _local_7 = 0;
                    while (_local_7 < (_local_12 - _local_3))
                    {
                        _local_2 = _local_6.removeListItemAt(0);
                        _local_2.dispose();
                        _local_7++;
                    };
                };
            };
            var _local_9:IssueMessageData = _SafeStr_2836.getHighestPriorityIssue();
            var _local_11:int = ((_local_9 == null) ? 0 : _local_9.issueId);
            var _local_5:int = getTimer();
            _local_7 = 0;
            for each (_local_4 in _local_8)
            {
                _local_1 = (_local_6.getListItemAt(_local_7) as IWindowContainer);
                if (_local_1 == null)
                {
                    return;
                };
                _local_1.background = ((_local_7++ % 2) == 0);
                _local_1.id = _local_4.issueId;
                _local_1.removeEventListener("WME_CLICK", onIssueClicked);
                _local_1.addEventListener("WME_CLICK", onIssueClicked);
                setCaption(_local_1.findChildByName("reporter"), _local_4.reporterUserName);
                setCaption(_local_1.findChildByName("type"), IssueCategoryNames.getSourceName(_local_4.categoryId));
                setCaption(_local_1.findChildByName("category"), IssueCategoryNames.getCategoryName(_local_4.reportedCategoryId));
                setCaption(_local_1.findChildByName("time_open"), _local_4.getOpenTime(_local_5));
                _local_13 = (((_local_4.issueId == _local_11) && (_local_3 > 1)) ? "Volter Bold" : "Volter");
                (_local_1.findChildByName("category") as ITextWindow).fontFace = _local_13;
            };
        }

        private function updateMessages():void
        {
            var _local_1:ITextFieldWindow;
            var _local_6:ITextWindow;
            var _local_2:IWindow;
            var _local_5:IssueMessageData;
            if (_window == null)
            {
                return;
            };
            var _local_4:IItemListWindow = (_window.findChildByName("msg_item_list") as IItemListWindow);
            if (_local_4 == null)
            {
                return;
            };
            var _local_8:Array = _SafeStr_2836.issues;
            var _local_7:int;
            var _local_9:int = _local_4.numListItems;
            var _local_3:int = _local_8.length;
            if (_local_9 < _local_3)
            {
                _local_1 = (_SafeStr_2847.clone() as ITextFieldWindow);
                _local_1.selectable = true;
                _local_1.editable = false;
                _local_4.addListItem(_local_1);
                _local_7 = 1;
                while (_local_7 < (_local_3 - _local_9))
                {
                    _local_6 = (_local_1.clone() as ITextWindow);
                    if (_local_6 == null)
                    {
                        return;
                    };
                    _local_4.addListItem(_local_6);
                    _local_7++;
                };
            }
            else
            {
                if (_local_9 > _local_3)
                {
                    _local_7 = 0;
                    while (_local_7 < (_local_9 - _local_3))
                    {
                        _local_2 = _local_4.removeListItemAt(0);
                        _local_2.dispose();
                        _local_7++;
                    };
                };
            };
            _local_7 = 0;
            for each (_local_5 in _local_8)
            {
                _local_1 = (_local_4.getListItemAt(_local_7) as ITextFieldWindow);
                if (_local_1 == null)
                {
                    return;
                };
                _local_1.width = _local_4.width;
                _local_1.background = ((_local_7++ % 2) == 0);
                _local_1.caption = ((_local_5.reporterUserName + ": ") + _local_5.message);
                _local_1.height = (_local_1.textHeight + 10);
            };
        }

        private function setCaption(_arg_1:IWindow, _arg_2:String):void
        {
            if (_arg_1 != null)
            {
                _arg_1.caption = _arg_2;
            };
        }

        private function initializeTopicDropdown():void
        {
            _topicDropdown = (_window.findChildByName("cfh_topics") as IDropMenuWindow);
            var _local_1:int = -1;
            var _local_6:int = _SafeStr_2836.getHighestPriorityIssue().reportedCategoryId;
            if (_local_6 == 27)
            {
                _topicDropdown.disable();
                return;
            };
            _SafeStr_2839 = [];
            var _local_2:Array = [];
            var _local_3:int;
            for each (var _local_5:CallForHelpCategoryData in _SafeStr_2838)
            {
                for each (var _local_4:CallForHelpTopicData in _local_5.topics)
                {
                    _local_2[_local_3] = (("${help.cfh.topic." + _local_4.id) + "}");
                    _SafeStr_2839[_local_3] = _local_4.id;
                    if (_local_4.id == 1)
                    {
                        _SafeStr_2840 = _local_3;
                    };
                    if (_local_4.id == _local_6)
                    {
                        _local_1 = _local_3;
                    };
                    _local_3++;
                };
            };
            _topicDropdown.populate(_local_2);
            if (_local_1 >= 0)
            {
                _topicDropdown.selection = _local_1;
            };
            _topicDropdown.addEventListener("WE_SELECTED", refreshSanctionDataForSelectedTopic);
        }

        private function refreshSanctionDataForSelectedTopic(_arg_1:WindowEvent):void
        {
            var _local_3:int = _topicDropdown.selection;
            var _local_2:int = _SafeStr_2839[_local_3];
            _moderationManager.issueManager.requestSanctionData(_SafeStr_2836.id, _local_2);
        }

        private function setProc(_arg_1:String, _arg_2:Function):void
        {
            _window.findChildByName(_arg_1).addEventListener("WME_CLICK", _arg_2);
        }

        private function onClose(_arg_1:WindowMouseEvent):void
        {
            if ((((!(_moderationManager == null)) && (!(_moderationManager.issueManager == null))) && (!(_SafeStr_2836 == null))))
            {
                _moderationManager.issueManager.removeHandler(_SafeStr_2836.id);
                trackAction("closeWindow");
            };
            this.dispose();
        }

        private function onCloseUseless(_arg_1:WindowMouseEvent):void
        {
            Logger.log("Close useless clicked");
            trackAction("closeUseless");
            _moderationManager.trackGoogle("actionCountUseless", _SafeStr_2842);
            _moderationManager.issueManager.closeBundle(_SafeStr_2836.id, 1);
            checkAutoHandling();
            dispose();
        }

        private function onCloseResolved(_arg_1:WindowMouseEvent):void
        {
            Logger.log("Close resolved clicked");
            trackAction("closeResolved");
            _moderationManager.trackGoogle("actionCountResolved", _SafeStr_2842);
            _moderationManager.issueManager.closeBundle(_SafeStr_2836.id, 3);
            checkAutoHandling();
            dispose();
        }

        private function onCloseSanction(_arg_1:WindowMouseEvent):void
        {
            Logger.log("Close with default sanction clicked");
            trackAction("closeSanction");
            _moderationManager.trackGoogle("actionCountSanction", _SafeStr_2842);
            var _local_2:int = -1;
            var _local_3:int = _topicDropdown.selection;
            if (_local_3 >= 0)
            {
                _local_2 = _SafeStr_2839[_local_3];
            };
            if (((_local_2 <= 0) && (_SafeStr_2836.getHighestPriorityIssue().reportedCategoryId == 28)))
            {
                _moderationManager.windowManager.alert("Topic missing", "You need to select the topic first.", 0, null);
            }
            else
            {
                _moderationManager.issueManager.closeDefaultAction(_SafeStr_2836.id, _local_2);
                checkAutoHandling();
                dispose();
            };
        }

        private function onRelease(_arg_1:WindowMouseEvent):void
        {
            Logger.log("Release clicked");
            trackAction("release");
            _moderationManager.issueManager.releaseBundle(_SafeStr_2836.id);
            checkAutoHandling();
            dispose();
        }

        private function onIssueClicked(_arg_1:WindowMouseEvent):void
        {
            var _local_3:int;
            for each (var _local_2:IssueMessageData in _SafeStr_2836.issues)
            {
                if (_local_2.issueId == _arg_1.window.id)
                {
                    _SafeStr_2837 = _local_2;
                    _local_3 = _local_2.reporterUserId;
                    if (_local_3 != 0)
                    {
                        if (_callerUserInfo != null)
                        {
                            _callerUserInfo.dispose();
                        };
                        _callerUserInfo = new UserInfoCtrl(_window, _moderationManager, _local_2, this);
                        _callerUserInfo.load(IWindowContainer(_window.findChildByName("caller_user_info")), _local_3);
                        _moderationManager.connection.send(new GetCfhChatlogMessageComposer(_local_2.issueId));
                        _SafeStr_2841.setId(_local_2.issueId);
                        _moderationManager.messageHandler.addChatlogListener(_SafeStr_2841);
                    };
                    return;
                };
            };
        }

        public function updateIssuesAndMessages():void
        {
            updateIssueList();
            updateMessages();
        }

        public function showDefaultSanction(_arg_1:int, _arg_2:String):void
        {
            if (((((_window == null) || (_moderationManager == null)) || (_moderationManager.issueManager == null)) || (_SafeStr_2836 == null)))
            {
                return;
            };
            if (_arg_1 != _SafeStr_2836.reportedUserId)
            {
                return;
            };
            var _local_3:ITextWindow = (_window.findChildByName("sanction_label") as ITextWindow);
            if (_local_3 != null)
            {
                _local_3.caption = _arg_2;
            };
        }

        private function checkAutoHandling():void
        {
            if ((((_window == null) || (_moderationManager == null)) || (_moderationManager.issueManager == null)))
            {
                return;
            };
            var _local_1:_SafeStr_108 = (_window.findChildByName("handle_next_checkbox") as _SafeStr_108);
            if (((!(_local_1 == null)) && (_local_1.isSelected)))
            {
                _moderationManager.issueManager.autoPick("issue handler pick next");
            };
        }

        internal function get callerUserInfo():UserInfoCtrl
        {
            return (_callerUserInfo);
        }

        internal function get reportedUserInfo():UserInfoCtrl
        {
            return (_reportedUserInfo);
        }

        internal function trackAction(_arg_1:String):void
        {
            if (((_moderationManager == null) || (_moderationManager.disposed)))
            {
                return;
            };
            _SafeStr_2842++;
            _moderationManager.trackGoogle(("issueHandler_" + _arg_1));
        }


    }
}

