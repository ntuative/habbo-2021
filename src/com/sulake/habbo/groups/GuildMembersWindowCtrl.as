package com.sulake.habbo.groups
{
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Point;
    import com.sulake.core.window.components.IFrameWindow;
    import flash.utils.Timer;
    import com.sulake.habbo.communication.messages.incoming.users.GuildMemberData;
    import com.sulake.habbo.utils.InfoText;
    import com.sulake.habbo.utils.LoadingIcon;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.habbo.communication.messages.incoming.users.GuildMembersMessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipUpdatedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.GuildMemberMgmtFailedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipRejectedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.GroupMembershipRequestedMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.GroupMembershipRequestedMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.users.GetGuildMembersMessageComposer;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.IBadgeImageWidget;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.incoming.users.MemberData;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.window.widgets.IAvatarImageWidget;
    import com.sulake.habbo.communication.messages.outgoing.users.RejectMembershipRequestMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.UnblockGroupMemberMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.RemoveAdminRightsFromMemberMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.AddAdminRightsToMemberMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.ApproveMembershipRequestMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.ApproveAllMembershipRequestsMessageComposer;
    import com.sulake.core.window.components.IDropMenuWindow;
    import flash.events.Event;

    public class GuildMembersWindowCtrl implements IDisposable 
    {

        private static const MEMBER_SPACING:Point = new Point(5, 5);

        private var _SafeStr_825:HabboGroupsManager;
        private var _window:IFrameWindow;
        private var _groupId:int;
        private var _SafeStr_2647:Timer = new Timer(1000, 1);
        private var _data:GuildMemberData;
        private var _SafeStr_2648:InfoText;
        private var _loadingIcon:LoadingIcon;

        public function GuildMembersWindowCtrl(_arg_1:HabboGroupsManager)
        {
            _SafeStr_825 = _arg_1;
            _SafeStr_2647.addEventListener("timer", onSearchTimer);
            _loadingIcon = new LoadingIcon();
        }

        public function dispose():void
        {
            _SafeStr_825 = null;
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            if (_SafeStr_2648 != null)
            {
                _SafeStr_2648.dispose();
                _SafeStr_2648 = null;
            };
            if (_SafeStr_2647)
            {
                _SafeStr_2647.removeEventListener("timer", onSearchTimer);
                _SafeStr_2647.stop();
                _SafeStr_2647 = null;
            };
            if (_loadingIcon)
            {
                _loadingIcon.dispose();
                _loadingIcon = null;
            };
        }

        private function setSearchingIcon(_arg_1:Boolean):void
        {
            if (_window)
            {
                _loadingIcon.setVisible(IIconWindow(_window.findChildByName("searching_icon")), _arg_1);
            };
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_825 == null);
        }

        public function onGuildMembers(_arg_1:IMessageEvent):void
        {
            _data = GuildMembersMessageEvent(_arg_1).data;
            show();
            populateSearchTypes();
            populateUserNameFilter();
        }

        public function onGuildMembershipUpdated(_arg_1:IMessageEvent):void
        {
            var _local_2:GuildMembershipUpdatedMessageEvent = GuildMembershipUpdatedMessageEvent(_arg_1);
            if (((!(_data == null)) && (_data.groupId == _local_2.guildId)))
            {
                _data.update(_local_2.data);
                reload();
            };
        }

        public function onGuildMemberMgmtFailed(_arg_1:IMessageEvent):void
        {
            var _local_2:GuildMemberMgmtFailedMessageEvent = GuildMemberMgmtFailedMessageEvent(_arg_1);
            var _local_3:int = _local_2.reason;
            var _local_4:String = ("group.membermgmt.fail." + _local_3);
            var _local_5:String = _SafeStr_825.localization.getLocalization(_local_4, _local_4);
            _SafeStr_825.windowManager.alert("${group.membermgmt.fail.title}", _local_5, 0, null);
            if (((((!(_data == null)) && (_data.groupId == _local_2.guildId)) && (!(_window == null))) && (_window.visible)))
            {
                doSearch(_data.pageIndex);
            };
        }

        public function onGuildMembershipRejected(_arg_1:IMessageEvent):void
        {
            var _local_2:GuildMembershipRejectedMessageEvent = GuildMembershipRejectedMessageEvent(_arg_1);
            if (((((_window) && (_window.visible)) && (!(_data == null))) && (_data.groupId == _local_2.getParser().guildId)))
            {
                doSearch(_data.pageIndex);
            };
        }

        public function onMembershipRequested(_arg_1:IMessageEvent):void
        {
            var _local_2:GroupMembershipRequestedMessageParser = GroupMembershipRequestedMessageEvent(_arg_1).getParser();
            if (((((_window) && (_window.visible)) && (!(_data == null))) && (_data.groupId == _local_2.groupId)))
            {
                doSearch(_data.pageIndex);
            };
        }

        public function onMembersClick(_arg_1:int, _arg_2:int):void
        {
            if (!_SafeStr_825.getBoolean("groupMembers.enabled"))
            {
                return;
            };
            if ((((!(_window == null)) && (_window.visible)) && (_groupId == _arg_1)))
            {
                close();
            }
            else
            {
                if (_SafeStr_2648)
                {
                    _SafeStr_2648.goBackToInitialState();
                };
                _groupId = _arg_1;
                _SafeStr_825.send(new GetGuildMembersMessageComposer(_arg_1, 0, "", _arg_2));
            };
        }

        public function show():void
        {
            prepareWindow();
            refresh();
            _window.visible = true;
            _window.activate();
        }

        public function reload():void
        {
            if (((!(_window == null)) && (_window.visible)))
            {
                refresh();
            };
        }

        private function refresh():void
        {
            var _local_2:int;
            _SafeStr_825.localization.registerParameter("group.members.title", "groupName", _data.groupName);
            var _local_3:IWindowContainer = IWindowContainer(_window.findChildByName("members_cont"));
            var _local_4:Array = _data.entries;
            _local_2 = 0;
            while (_local_2 < _data.pageSize)
            {
                refreshEntry(_local_3, _local_2, _local_4[_local_2]);
                _local_2++;
            };
            var _local_1:IBadgeImageWidget = (IWidgetWindow(_window.findChildByName("group_logo")).widget as IBadgeImageWidget);
            _local_1.badgeId = _data.badgeCode;
            _local_1.groupId = _data.groupId;
            _SafeStr_825.localization.registerParameter("group.members.pageinfo", "amount", ("" + _data.totalEntries));
            _SafeStr_825.localization.registerParameter("group.members.pageinfo", "page", ("" + (_data.pageIndex + 1)));
            _SafeStr_825.localization.registerParameter("group.members.pageinfo", "totalPages", ("" + _data.totalPages));
            _window.findChildByName("previous_page_button").visible = hasPreviousPage();
            _window.findChildByName("next_page_button").visible = hasNextPage();
        }

        private function prepareWindow():void
        {
            if (_window != null)
            {
                return;
            };
            _window = IFrameWindow(_SafeStr_825.getXmlWindow("guild_members_window"));
            _window.findChildByTag("close").procedure = onClose;
            _window.findChildByName("previous_page_button").procedure = onPreviousPage;
            _window.findChildByName("next_page_button").procedure = onNextPage;
            _SafeStr_2648 = new InfoText(ITextFieldWindow(_window.findChildByName("filter_members_input")), _SafeStr_825.localization.getLocalization("group.members.searchinfo"));
            _window.center();
        }

        private function onClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            close();
        }

        public function close():void
        {
            if (_window != null)
            {
                _groupId = 0;
                _window.visible = false;
            };
        }

        private function refreshEntry(_arg_1:IWindowContainer, _arg_2:int, _arg_3:MemberData):void
        {
            var _local_4:IWindowContainer = IWindowContainer(_arg_1.getChildAt(_arg_2));
            if (_local_4 == null)
            {
                if (_arg_3 == null)
                {
                    return;
                };
                _local_4 = getListEntry();
                _local_4.tags[0] = ("" + _arg_2);
                _arg_1.addChild(_local_4);
                _local_4.x = (((_arg_2 % 2) == 0) ? 0 : (_local_4.width + MEMBER_SPACING.x));
                _local_4.y = (Math.floor((_arg_2 / 2)) * (_local_4.height + MEMBER_SPACING.y));
            };
            if (_arg_3 != null)
            {
                refreshUserEntry(_local_4, _arg_3);
                _local_4.visible = true;
            }
            else
            {
                _local_4.visible = false;
            };
        }

        public function refreshUserEntry(_arg_1:IWindowContainer, _arg_2:MemberData):void
        {
            var _local_8:Boolean;
            _arg_1.findChildByName("user_name_txt").caption = _arg_2.userName;
            _arg_1.findChildByName("icon_owner").visible = _arg_2.owner;
            this.setAdminState(_arg_2.member, _arg_2.admin, _arg_1);
            var _local_5:IWindow = _arg_1.findChildByName("admin_container");
            _local_5.visible = ((!(_local_8)) && ((_arg_2.admin) || (_data.allowedToManage)));
            var _local_9:IRegionWindow = IRegionWindow(_arg_1.findChildByName("bg_region"));
            _local_9.id = _arg_2.userId;
            this.setRemoveState(false, _arg_1);
            this.setActionLinkState(false, _arg_1);
            _local_8 = (_arg_2.userId == _SafeStr_825.avatarId);
            var _local_11:IRegionWindow = IRegionWindow(_arg_1.findChildByName("remove_region"));
            _local_11.toolTipCaption = _SafeStr_825.localization.getLocalization(((_arg_2.member) ? "group.members.kick" : "group.members.reject"));
            _local_11.visible = ((((!(_arg_2.owner)) && (!(_local_8))) && (_data.allowedToManage)) && (!(_arg_2.blocked)));
            _local_11.id = _arg_2.userId;
            var _local_6:Boolean = ((((((_arg_2.member) && (!(_arg_2.owner))) && (!(_local_8))) && (_data.allowedToManage)) && (_SafeStr_825.getBoolean("group.blocking.enabled"))) && (!(_arg_2.blocked)));
            var _local_3:IRegionWindow = IRegionWindow(_arg_1.findChildByName("block_region"));
            _local_3.toolTipCaption = _SafeStr_825.localization.getLocalization("group.members.block");
            _local_3.visible = _local_6;
            _local_3.id = _arg_2.userId;
            var _local_4:Boolean = ((!(_local_8)) && (_data.allowedToManage));
            var _local_10:IRegionWindow = IRegionWindow(_arg_1.findChildByName("action_link_region"));
            _local_10.visible = _local_4;
            _local_10.id = _arg_2.userId;
            var _local_7:ITextWindow = ITextWindow(_arg_1.findChildByName("member_since_txt"));
            _local_7.visible = ((!(_local_4)) && (!(_arg_2.memberSince == "")));
            _SafeStr_825.localization.registerParameter("group.members.since", "date", _arg_2.memberSince);
            _local_7.caption = _SafeStr_825.localization.getLocalization("group.members.since");
            IAvatarImageWidget(IWidgetWindow(_arg_1.findChildByName("avatar_image")).widget).figure = _arg_2.figure;
            if (_arg_2.blocked)
            {
                setActionLink(_arg_1, "group.members.unblock", false);
            }
            else
            {
                if (_arg_2.owner)
                {
                    setActionLink(_arg_1, "group.members.owner", false);
                }
                else
                {
                    if (_arg_2.admin)
                    {
                        setActionLink(_arg_1, "group.members.removerights", true);
                    }
                    else
                    {
                        if (_arg_2.member)
                        {
                            setActionLink(_arg_1, "group.members.giverights", true);
                        }
                        else
                        {
                            setActionLink(_arg_1, "group.members.accept", true);
                        };
                    };
                };
            };
        }

        public function getListEntry():IWindowContainer
        {
            var _local_1:IWindowContainer = IWindowContainer(_SafeStr_825.getXmlWindow("member_entry"));
            var _local_3:IRegionWindow = IRegionWindow(_local_1.findChildByName("bg_region"));
            _local_3.procedure = onBg;
            var _local_2:IRegionWindow = IRegionWindow(_local_1.findChildByName("block_region"));
            _local_2.addEventListener("WME_OVER", onRemoveMouseOver);
            _local_2.addEventListener("WME_OUT", onRemoveMouseOut);
            _local_2.addEventListener("WME_CLICK", onBlockMouseClick);
            var _local_5:IRegionWindow = IRegionWindow(_local_1.findChildByName("remove_region"));
            _local_5.addEventListener("WME_OVER", onRemoveMouseOver);
            _local_5.addEventListener("WME_OUT", onRemoveMouseOut);
            _local_5.addEventListener("WME_CLICK", onRemoveMouseClick);
            var _local_4:IRegionWindow = IRegionWindow(_local_1.findChildByName("action_link_region"));
            _local_4.addEventListener("WME_OVER", onActionLinkMouseOver);
            _local_4.addEventListener("WME_OUT", onActionLinkMouseOut);
            _local_4.addEventListener("WME_CLICK", onActionLinkClick);
            return (_local_1);
        }

        private function onRemoveMouseOver(_arg_1:WindowEvent):void
        {
            var _local_2:IRegionWindow = IRegionWindow(_arg_1.target);
            setRemoveState(true, _local_2);
        }

        private function onRemoveMouseOut(_arg_1:WindowEvent):void
        {
            var _local_2:IRegionWindow = IRegionWindow(_arg_1.target);
            setRemoveState(false, _local_2);
        }

        private function onRemoveMouseClick(_arg_1:WindowEvent):void
        {
            var _local_3:IWindow = _arg_1.target;
            var _local_2:MemberData = _data.getUser(_local_3.id);
            if (((_local_2 == null) || (_local_2.owner)))
            {
                return;
            };
            if (_local_2.member)
            {
                _SafeStr_825.handleUserKick(_local_3.id, _data.groupId);
            }
            else
            {
                _SafeStr_825.send(new RejectMembershipRequestMessageComposer(_data.groupId, _local_2.userId));
            };
        }

        private function onBlockMouseClick(_arg_1:WindowEvent):void
        {
            var _local_3:IWindow = _arg_1.target;
            var _local_2:MemberData = _data.getUser(_local_3.id);
            if (((_local_2 == null) || (_local_2.owner)))
            {
                return;
            };
            if (_local_2.member)
            {
                _SafeStr_825.handleUserBlock(_local_3.id, _data.groupId);
            };
        }

        private function setActionLink(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean):void
        {
            var _local_4:ITextWindow = ITextWindow(_arg_1.findChildByName("action_link"));
            _local_4.text = _SafeStr_825.localization.getLocalization(_arg_2, _arg_2);
            _local_4.underline = _arg_3;
        }

        private function setRemoveState(_arg_1:Boolean, _arg_2:IWindowContainer):void
        {
            _arg_2.findChildByName("icon_close_off").visible = (!(_arg_1));
            _arg_2.findChildByName("icon_close_over").visible = _arg_1;
            _arg_2.findChildByName("icon_close_down").visible = false;
        }

        private function setActionLinkState(_arg_1:Boolean, _arg_2:IWindowContainer):void
        {
            var _local_3:ITextWindow = ITextWindow(_arg_2.findChildByName("action_link"));
            _local_3.textColor = ((_arg_1) ? 4280984060 : 4285492837);
        }

        private function onActionLinkMouseOver(_arg_1:WindowEvent):void
        {
            var _local_3:IRegionWindow = IRegionWindow(_arg_1.target);
            var _local_2:MemberData = _data.getUser(_arg_1.target.id);
            if (((_local_2 == null) || (_local_2.owner)))
            {
                return;
            };
            setActionLinkState(true, _local_3);
            setAdminState(_local_2.member, (!(_local_2.admin)), IWindowContainer(_local_3.parent));
        }

        private function onActionLinkMouseOut(_arg_1:WindowEvent):void
        {
            var _local_3:IRegionWindow = IRegionWindow(_arg_1.target);
            setActionLinkState(false, _local_3);
            var _local_2:MemberData = _data.getUser(_arg_1.target.id);
            if (_local_2 != null)
            {
                setAdminState(_local_2.member, _local_2.admin, IWindowContainer(_local_3.parent));
            };
        }

        private function onActionLinkClick(_arg_1:WindowEvent):void
        {
            var _local_2:MemberData = _data.getUser(_arg_1.target.id);
            if (((_local_2 == null) || (_local_2.owner)))
            {
                return;
            };
            if (_local_2.blocked)
            {
                _SafeStr_825.send(new UnblockGroupMemberMessageComposer(_data.groupId, _local_2.userId));
            }
            else
            {
                if (_local_2.admin)
                {
                    _SafeStr_825.send(new RemoveAdminRightsFromMemberMessageComposer(_data.groupId, _local_2.userId));
                }
                else
                {
                    if (_local_2.member)
                    {
                        _SafeStr_825.send(new AddAdminRightsToMemberMessageComposer(_data.groupId, _local_2.userId));
                    }
                    else
                    {
                        _SafeStr_825.send(new ApproveMembershipRequestMessageComposer(_data.groupId, _local_2.userId));
                    };
                };
            };
        }

        private function setAdminState(_arg_1:Boolean, _arg_2:Boolean, _arg_3:IWindowContainer):void
        {
            _arg_3.findChildByName("icon_admin_off").visible = ((_arg_1) && (_arg_2));
            _arg_3.findChildByName("icon_admin_over").visible = ((_arg_1) && (!(_arg_2)));
        }

        private function onBg(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _SafeStr_825.send(new GetExtendedProfileMessageComposer(_arg_2.id));
            };
        }

        private function onFilterMembers(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WE_CHANGE")
            {
                _SafeStr_2647.reset();
                _SafeStr_2647.start();
                setSearchingIcon(true);
            };
        }

        private function onTypeDropmenu(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WE_SELECTED")
            {
                doSearch(0);
            };
        }

        private function doSearch(_arg_1:int):void
        {
            _SafeStr_2647.stop();
            _SafeStr_2647.reset();
            setSearchingIcon(true);
            var _local_2:GuildMemberData = _data;
            var _local_3:String = _SafeStr_2648.getText();
            var _local_4:int = getTypeDropMenu().selection;
            _SafeStr_825.send(new GetGuildMembersMessageComposer(_local_2.groupId, _arg_1, _local_3, _local_4));
        }

        private function onAcceptAll(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            _SafeStr_825.send(new ApproveAllMembershipRequestsMessageComposer(_data.groupId));
        }

        private function getTypeDropMenu():IDropMenuWindow
        {
            return (IDropMenuWindow(_window.findChildByName("type_drop_menu")));
        }

        private function onSearchTimer(_arg_1:Event):void
        {
            if (((!(_window == null)) && (_window.visible)))
            {
                doSearch(0);
            };
        }

        private function onNextPage(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            doSearch(limitPageIndex((_data.pageIndex + 1)));
        }

        private function onPreviousPage(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            doSearch(limitPageIndex((_data.pageIndex - 1)));
        }

        private function hasPreviousPage():Boolean
        {
            return (!(_data.pageIndex == limitPageIndex((_data.pageIndex - 1))));
        }

        private function hasNextPage():Boolean
        {
            return (!(_data.pageIndex == limitPageIndex((_data.pageIndex + 1))));
        }

        private function limitPageIndex(_arg_1:int):int
        {
            var _local_2:int = int(Math.ceil((_data.totalEntries / _data.pageSize)));
            return (Math.max(0, Math.min(_arg_1, (_local_2 - 1))));
        }

        public function get data():GuildMemberData
        {
            return (_data);
        }

        private function populateSearchTypes():void
        {
            var _local_2:Array = [];
            _local_2.push("${group.members.search.all}");
            _local_2.push("${group.members.search.admins}");
            if (_data.allowedToManage)
            {
                _local_2.push("${group.members.search.pending}");
                if (_SafeStr_825.getBoolean("group.blocking.enabled"))
                {
                    _local_2.push("${group.members.search.blocked}");
                };
            };
            var _local_1:IDropMenuWindow = getTypeDropMenu();
            _local_1.procedure = null;
            _local_1.populate(_local_2);
            _local_1.selection = ((_data.allowedToManage) ? _data.searchType : Math.min(_data.searchType, 1));
            _local_1.procedure = onTypeDropmenu;
        }

        private function populateUserNameFilter():void
        {
            var _local_1:ITextFieldWindow = _SafeStr_2648.input;
            _local_1.procedure = null;
            if (_SafeStr_2648.getText() != _data.userNameFilter)
            {
                _SafeStr_2648.setText(_data.userNameFilter);
            };
            _local_1.procedure = onFilterMembers;
            _SafeStr_2647.stop();
            setSearchingIcon(false);
        }


    }
}

