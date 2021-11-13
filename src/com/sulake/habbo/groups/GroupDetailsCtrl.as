package com.sulake.habbo.groups
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsData;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.IBadgeImageWidget;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.users.JoinHabboGroupMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.communication.messages.outgoing.users.GetGuildEditInfoMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.DeactivateGuildMessageComposer;
    import com.sulake.habbo.window.utils._SafeStr_126;

    public class GroupDetailsCtrl implements IDisposable 
    {

        private var _SafeStr_825:HabboGroupsManager;
        private var _window:IWindowContainer;
        private var _selectedGroup:HabboGroupDetailsData;

        public function GroupDetailsCtrl(_arg_1:HabboGroupsManager, _arg_2:Boolean)
        {
            _SafeStr_825 = _arg_1;
        }

        public function dispose():void
        {
            _SafeStr_825 = null;
            _selectedGroup = null;
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_825 == null);
        }

        private function prepareWindow(_arg_1:IWindowContainer):void
        {
            if (_window != null)
            {
                return;
            };
            _window = IWindowContainer(_SafeStr_825.getXmlWindow("group"));
            setProc("group_room_link_region", onRoomLink);
            setProc("manage_guild_region", onManageGuild);
            setProc("delete_guild_region", onDeleteGuild);
            setProc("members_region", onMembers);
            setProc("pending_members_region", onPendingMembers);
            setProc("show_groups_link_region", onShowGroups);
            setProc("buy_furni_link_region", onBuyFurni);
            _window.findChildByName("leave_button").procedure = onLeave;
            _window.findChildByName("join_button").procedure = onJoin;
            _window.findChildByName("request_membership_button").procedure = onJoin;
        }

        private function attachWindow(_arg_1:IWindowContainer):void
        {
            if (_arg_1.getChildIndex(_window) == -1)
            {
                _arg_1.addChild(_window);
            };
        }

        public function onGroupDetails(_arg_1:IWindowContainer, _arg_2:HabboGroupDetailsData):void
        {
            _selectedGroup = _arg_2;
            prepareWindow(_arg_1);
            attachWindow(_arg_1);
            var _local_10:IWindow = _window.findChildByName("group_decorate_icon_region");
            var _local_9:IWindow = _window.findChildByName("group_name");
            _local_9.caption = _arg_2.groupName;
            _local_10.visible = _arg_2.membersCanDecorate;
            _local_9.x = ((_arg_2.membersCanDecorate) ? (_local_10.x + _local_10.width) : _local_10.x);
            var _local_6:ITextWindow = ITextWindow(_window.findChildByName("group_description"));
            _local_6.caption = _arg_2.description;
            _local_6.height = (_local_6.textHeight + 5);
            _window.findChildByName("group_description_scrollbar").visible = (_local_6.height > _window.findChildByName("group_description_item_list").height);
            var _local_8:Boolean = _selectedGroup.hasBoard;
            _window.findChildByName("show_forum_link_region").visible = _local_8;
            _window.findChildByName("show_forum_link").visible = _local_8;
            if (_local_8)
            {
                setProc("show_forum_link_region", onForumLink);
            };
            _SafeStr_825.windowManager.registerLocalizationParameter("group.created", "date", ("" + _arg_2.creationDate));
            _SafeStr_825.windowManager.registerLocalizationParameter("group.created", "owner", ("" + _arg_2.ownerName));
            _window.findChildByName("created_txt").caption = _SafeStr_825.localization.getLocalization("group.created");
            _SafeStr_825.windowManager.registerLocalizationParameter("group.membercount", "totalMembers", ("" + _arg_2.totalMembers));
            _window.findChildByName("members_txt").caption = _SafeStr_825.localization.getLocalization("group.membercount");
            _window.findChildByName("group_room_link_region").visible = (_arg_2.roomId > -1);
            _SafeStr_825.windowManager.registerLocalizationParameter("group.linktobase", "room_name", _arg_2.roomName);
            _window.findChildByName("group_room_link").caption = _SafeStr_825.localization.getLocalization("group.linktobase");
            var _local_4:IBadgeImageWidget = (IWidgetWindow(_window.findChildByName("group_logo")).widget as IBadgeImageWidget);
            _local_4.badgeId = _selectedGroup.badgeCode;
            _local_4.groupId = _selectedGroup.groupId;
            _window.findChildByName("join_button").visible = _arg_2.joiningAllowed;
            _window.findChildByName("join_button").enable();
            _window.findChildByName("request_membership_button").visible = _arg_2.requestMembershipAllowed;
            _window.findChildByName("leave_button").visible = _arg_2.leaveAllowed;
            _window.findChildByName("membership_pending_txt").visible = (_arg_2.status == 2);
            _window.findChildByName("youaremember_txt").visible = ((!(_selectedGroup.isGuild)) && (_arg_2.status == 1));
            _window.findChildByName("youaremember_icon").visible = ((!(_selectedGroup.isGuild)) && (_arg_2.status == 1));
            var _local_5:IWindow = _window.findChildByName("pending_members_region");
            _local_5.visible = (_selectedGroup.pendingMemberCount > 0);
            if (_selectedGroup.pendingMemberCount > 0)
            {
                _SafeStr_825.windowManager.registerLocalizationParameter("group.pendingmembercount", "amount", ("" + _arg_2.pendingMemberCount));
                _window.findChildByName("pending_members_txt").caption = _SafeStr_825.localization.getLocalization("group.pendingmembercount");
            };
            var _local_3:IWindow = _window.findChildByName("manage_guild_region");
            _local_3.visible = ((_selectedGroup.isOwner) && (_selectedGroup.isGuild));
            _local_3.y = ((_local_5.visible) ? (_local_5.y + 16) : _local_5.y);
            var _local_7:IWindow = _window.findChildByName("delete_guild_region");
            _local_7.visible = (((_selectedGroup.isGuild) && (_SafeStr_825.groupDeletionEnabled)) && ((_selectedGroup.isOwner) || (_SafeStr_825.sessionDataManager.hasSecurity(5))));
            _local_7.y = ((_local_3.visible) ? (_local_3.y + 16) : _local_5.y);
            _window.findChildByName("you_are_owner_region").visible = ((_selectedGroup.isGuild) && (_selectedGroup.isOwner));
            _window.findChildByName("you_are_admin_region").visible = (((_selectedGroup.isGuild) && (_selectedGroup.isAdmin)) && (!(_selectedGroup.isOwner)));
            _window.findChildByName("you_are_member_region").visible = ((_selectedGroup.isGuild) && ((_selectedGroup.status == 1) && (!((_selectedGroup.isAdmin) || (_selectedGroup.isOwner)))));
            getGroupTypeRegion(0).visible = false;
            getGroupTypeRegion(1).visible = false;
            getGroupTypeRegion(2).visible = false;
            if (getGroupTypeRegion(_arg_2.type) != null)
            {
                getGroupTypeRegion(_arg_2.type).visible = true;
            };
        }

        private function getGroupTypeRegion(_arg_1:int):IWindow
        {
            return (_window.findChildByName(("grouptype_region_" + _arg_1)));
        }

        private function getGroupTypeIcon(_arg_1:int):IWindow
        {
            return (_window.findChildByName(("grouptype_icon_" + _arg_1)));
        }

        private function setProc(_arg_1:String, _arg_2:Function):void
        {
            var _local_3:IWindow = _window.findChildByName(_arg_1);
            _local_3.mouseThreshold = 0;
            _local_3.procedure = _arg_2;
        }

        private function onLeave(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            _SafeStr_825.trackGoogle("groupDetails", "leaveGroup");
            _SafeStr_825.handleUserKick(_SafeStr_825.avatarId, _selectedGroup.groupId);
        }

        private function onJoin(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            _SafeStr_825.trackGoogle("groupDetails", "joinGroup");
            _window.findChildByName("join_button").disable();
            _SafeStr_825.send(new JoinHabboGroupMessageComposer(_selectedGroup.groupId));
            _SafeStr_825.send(new EventLogMessageComposer("HabboGroups", ("" + _selectedGroup.groupId), "join"));
        }

        private function onRoomLink(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            _SafeStr_825.trackGoogle("groupDetails", "groupBaseRoom");
            _SafeStr_825.navigator.goToPrivateRoom(_selectedGroup.roomId);
            _SafeStr_825.send(new EventLogMessageComposer("HabboGroups", ("" + _selectedGroup.groupId), "base"));
        }

        private function onForumLink(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            _SafeStr_825.openGroupForum(_selectedGroup.groupId);
        }

        private function openExternalLink(_arg_1:String):void
        {
            if (_arg_1 != "")
            {
                _SafeStr_825.windowManager.alert("${catalog.alert.external.link.title}", "${catalog.alert.external.link.desc}", 0, onExternalLink);
                HabboWebTools.navigateToURL(_arg_1, "_empty");
            };
        }

        private function onExternalLink(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }

        private function onManageGuild(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            _SafeStr_825.trackGoogle("groupDetails", "groupManage");
            _SafeStr_825.send(new GetGuildEditInfoMessageComposer(_selectedGroup.groupId));
        }

        private function onDeleteGuild(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            _SafeStr_825.windowManager.confirm("${group.deleteconfirm.title}", "${group.deleteconfirm.desc}", 0, onDeleteGuildConfirmation);
        }

        private function onDeleteGuildConfirmation(_arg_1:_SafeStr_126, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
            if (_arg_2.type == "WE_OK")
            {
                _SafeStr_825.trackGoogle("groupDetails", "groupDelete");
                _SafeStr_825.send(new DeactivateGuildMessageComposer(_selectedGroup.groupId));
            };
        }

        private function onMembers(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            _SafeStr_825.trackGoogle("groupDetails", "groupMembers");
            _SafeStr_825.guildMembersWindowCtrl.onMembersClick(_selectedGroup.groupId, 0);
        }

        private function onPendingMembers(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            _SafeStr_825.trackGoogle("groupDetails", "groupPendingMembers");
            _SafeStr_825.guildMembersWindowCtrl.onMembersClick(_selectedGroup.groupId, 2);
        }

        private function onShowGroups(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            _SafeStr_825.trackGoogle("groupDetails", "hottestGroups");
            _SafeStr_825.navigator.performGuildBaseSearch();
        }

        private function onBuyFurni(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            _SafeStr_825.trackGoogle("groupDetails", "groupFurni");
            _SafeStr_825.openCatalog("guild_custom_furni");
        }


    }
}

