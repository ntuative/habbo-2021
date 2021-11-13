package com.sulake.habbo.groups
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsData;
    import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.IBadgeImageWidget;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.users.GetGuildEditInfoMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.JoinHabboGroupMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;

    public class GroupRoomInfoCtrl implements IDisposable 
    {

        private static const TOOLBAR_EXTENSION_ID:String = "room_group_info";

        private var _SafeStr_825:HabboGroupsManager;
        private var _window:IWindowContainer;
        private var _expanded:Boolean = true;
        private var _group:HabboGroupDetailsData;
        private var _SafeStr_2637:int;

        public function GroupRoomInfoCtrl(_arg_1:HabboGroupsManager)
        {
            _SafeStr_825 = _arg_1;
        }

        public function dispose():void
        {
            if (toolbarAttachAllowed())
            {
                _SafeStr_825.toolbar.extensionView.detachExtension("room_group_info");
            };
            _SafeStr_825 = null;
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

        public function onRoomInfo(_arg_1:GuestRoomData):void
        {
            if (!_SafeStr_825.groupRoomInfoEnabled)
            {
                return;
            };
            if (_arg_1.habboGroupId > 0)
            {
                _SafeStr_2637 = _arg_1.habboGroupId;
                _SafeStr_825.send(new GetHabboGroupDetailsMessageComposer(_arg_1.habboGroupId, false));
            }
            else
            {
                _SafeStr_2637 = 0;
                close();
            };
        }

        public function onGroupDeactivated(_arg_1:int):void
        {
            if (((_arg_1 == _group.groupId) || (_arg_1 == _SafeStr_2637)))
            {
                expectedGroupId = 0;
                close();
            };
        }

        public function onGroupDetails(_arg_1:HabboGroupDetailsData):void
        {
            if (!_SafeStr_825.groupRoomInfoEnabled)
            {
                return;
            };
            if (_arg_1.groupId == _SafeStr_2637)
            {
                _expanded = true;
                _group = _arg_1;
                refresh();
            };
        }

        public function isDisplayingGroup(_arg_1:int):Boolean
        {
            return (((!(_window == null)) && (!(_group == null))) && (_arg_1 == _group.groupId));
        }

        private function refresh():void
        {
            if (!_group.isGuild)
            {
                return;
            };
            prepareWindow();
            _window.findChildByName("bg_expanded").visible = _expanded;
            _window.findChildByName("bg_contracted").visible = (!(_expanded));
            _window.findChildByName("group_name_txt").visible = _expanded;
            _window.findChildByName("join_button").visible = ((_expanded) && (_group.joiningAllowed));
            _window.findChildByName("join_button").enable();
            _window.findChildByName("request_membership_button").visible = ((_expanded) && (_group.requestMembershipAllowed));
            _window.findChildByName("manage_button").visible = ((_expanded) && (_group.isOwner));
            _window.findChildByName("group_logo").visible = _expanded;
            _window.findChildByName("group_name_txt").caption = _group.groupName;
            _window.findChildByName("info_region").visible = _expanded;
            var _local_1:IBadgeImageWidget = (IWidgetWindow(_window.findChildByName("group_logo")).widget as IBadgeImageWidget);
            _local_1.badgeId = _group.badgeCode;
            _local_1.groupId = _group.groupId;
            _window.x = 0;
            _window.y = 0;
            _window.height = ((_expanded) ? _window.findChildByName("bg_expanded").height : _window.findChildByName("bg_contracted").height);
            if (toolbarAttachAllowed())
            {
                _SafeStr_825.toolbar.extensionView.attachExtension("room_group_info", _window, -1, ["next_quest_timer", "quest_tracker", "event_info_window"]);
            };
        }

        private function prepareWindow():void
        {
            if (this._window != null)
            {
                return;
            };
            _window = IWindowContainer(_SafeStr_825.getXmlWindow("group_room_info"));
            _window.findChildByName("join_button").procedure = onJoin;
            _window.findChildByName("request_membership_button").procedure = onJoin;
            _window.findChildByName("manage_button").procedure = onManage;
            _window.findChildByName("title_region").procedure = onTitleClick;
            _window.findChildByName("info_region").procedure = onInfoClick;
        }

        public function close():void
        {
            if (_window != null)
            {
                if (toolbarAttachAllowed())
                {
                    _SafeStr_825.toolbar.extensionView.detachExtension("room_group_info");
                };
                _SafeStr_2637 = 0;
                _group = null;
            };
        }

        private function onTitleClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            _expanded = (!(_expanded));
            refresh();
            _SafeStr_825.toolbar.events.dispatchEvent(new HabboToolbarEvent("HTE_GROUP_ROOM_INFO_CLICK"));
        }

        private function onInfoClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _SafeStr_825.trackGoogle("groupRoomInfo", "groupInfo");
                _SafeStr_825.send(new GetHabboGroupDetailsMessageComposer(_group.groupId, true));
                _SafeStr_825.toolbar.events.dispatchEvent(new HabboToolbarEvent("HTE_GROUP_ROOM_INFO_CLICK"));
            };
        }

        private function onManage(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _SafeStr_825.trackGoogle("groupRoomInfo", "manageGroup");
                _SafeStr_825.send(new GetGuildEditInfoMessageComposer(_group.groupId));
                _SafeStr_825.toolbar.events.dispatchEvent(new HabboToolbarEvent("HTE_GROUP_ROOM_INFO_CLICK"));
            };
        }

        private function onJoin(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _SafeStr_825.trackGoogle("groupRoomInfo", "joinGroup");
                _window.findChildByName("join_button").disable();
                _SafeStr_825.send(new JoinHabboGroupMessageComposer(_group.groupId));
                _SafeStr_825.send(new EventLogMessageComposer("HabboGroups", ("" + _group.groupId), "join"));
                _SafeStr_825.toolbar.events.dispatchEvent(new HabboToolbarEvent("HTE_GROUP_ROOM_INFO_CLICK"));
            };
        }

        public function set expectedGroupId(_arg_1:int):void
        {
            _SafeStr_2637 = _arg_1;
        }

        private function toolbarAttachAllowed():Boolean
        {
            return ((((!(_SafeStr_825 == null)) && (!(_SafeStr_825.toolbar == null))) && (!(_SafeStr_825.toolbar.extensionView == null))) && (_SafeStr_825.toolbarAttachEnabled));
        }


    }
}

