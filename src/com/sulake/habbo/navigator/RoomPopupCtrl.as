package com.sulake.habbo.navigator
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.utils.ExtendedProfileIcon;
    import com.sulake.habbo.utils.FriendlyTime;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
    import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class RoomPopupCtrl extends PopupCtrl 
    {

        private var _details:IWindowContainer;
        private var _SafeStr_3001:GuestRoomData;
        private var _SafeStr_2910:TagRenderer;
        private var _navigator:IHabboTransitionalNavigator;
        private var _SafeStr_2909:GuildInfoCtrl;

        public function RoomPopupCtrl(_arg_1:IHabboTransitionalNavigator, _arg_2:int, _arg_3:int)
        {
            super(HabboNavigator(_arg_1), _arg_2, _arg_3, "grs_guest_room_details_long");
            _navigator = _arg_1;
            _SafeStr_2910 = new TagRenderer(_arg_1, hideInstantly);
            _SafeStr_2909 = new GuildInfoCtrl(_navigator);
        }

        public function set room(_arg_1:GuestRoomData):void
        {
            _SafeStr_3001 = _arg_1;
        }

        override public function refreshContent(_arg_1:IWindowContainer):void
        {
            if (_details == null)
            {
                _details = IWindowContainer(_arg_1.findChildByName("details_container"));
            };
            _details.visible = true;
            _SafeStr_2910.useHashTags = true;
            Util.hideChildren(_details);
            _SafeStr_2909.refresh(_details, _SafeStr_3001);
            refreshRoomName(_details, _SafeStr_3001);
            refreshOwnerName();
            refreshTextWithCaption("roomctg", _details, getRoomCtg(_SafeStr_3001.categoryId));
            refreshRoomDesc(_details, _SafeStr_3001);
            refreshExtraCont();
            refreshEventInfo(_SafeStr_3001);
            refreshRoomSettings();
            refreshInfo(_details, "trading_allowed", (_SafeStr_3001.tradeMode == 2));
            refreshInfo(_details, "doormode_doorbell", (_SafeStr_3001.doorMode == 1));
            refreshInfo(_details, "doormode_password", (_SafeStr_3001.doorMode == 2));
            refreshInfo(_details, "doormode_invisible", (_SafeStr_3001.doorMode == 3));
            Util.moveChildrenToColumn(_details, ["guild_info", "roomname", "roomctg_cont", "roomowner_cont", "roomdesc", "extra_cont", "doormode_doorbell", "doormode_password", "doormode_invisible", "trading_allowed", "eventinfo_cont", "roomsettings_cont"], 0, 0);
            _details.findChildByName("guild_info").x = 2;
            _details.height = Util.getLowestPoint(_details);
        }

        private function refreshOwnerName():void
        {
            var _local_1:ITextWindow = ITextWindow(_details.findChildByName("roomowner"));
            var _local_2:IRegionWindow = IRegionWindow(_details.findChildByName("roomowner_cont"));
            _local_2.procedure = onOwnerName;
            _local_1.caption = ((_SafeStr_3001.showOwner) ? _SafeStr_3001.ownerName : "");
            _local_2.visible = (((_SafeStr_3001.showOwner) && (!(_SafeStr_3001.ownerName == ""))) && (!(_SafeStr_3001.ownerName == "-")));
            ExtendedProfileIcon.setUserInfoState(false, _local_2);
            Util.layoutChildrenInArea(_local_2, 1000, 10, 2);
        }

        private function refreshRoomSettings():void
        {
            var _local_2:IRegionWindow;
            var _local_1:ITextWindow;
            var _local_3:Boolean = true;
            _local_2 = IRegionWindow(_details.findChildByName("roomsettings_cont"));
            _local_1 = ITextWindow(_details.findChildByName("roomsettings"));
            _local_2.procedure = onRoomSettings;
            _local_2.visible = ((_local_3) && (_navigator.sessionData.userId == _SafeStr_3001.ownerId));
            Util.layoutChildrenInArea(_local_2, 1000, 10, 2);
        }

        private function refreshExtraCont():void
        {
            var _local_1:IWindowContainer = IWindowContainer(_details.findChildByName("extra_cont"));
            Util.hideChildren(_local_1);
            _SafeStr_2910.refreshTags(_local_1, _SafeStr_3001.tags);
            if (_SafeStr_3001.score > 0)
            {
                refreshTextWithCaption("rating", _local_1, ("" + _SafeStr_3001.score));
                _local_1.findChildByName("rating_cont").visible = true;
            };
            if (Util.hasVisibleChildren(_local_1))
            {
                Util.moveChildrenToColumn(_local_1, ["tags", "startedat_cont", "rating_cont"], 0, 3);
                _local_1.height = (Util.getLowestPoint(_local_1) + 4);
                _local_1.visible = true;
            };
        }

        private function refreshEventInfo(_arg_1:GuestRoomData):void
        {
            if (((_arg_1.roomAdName == null) || (_arg_1.roomAdName.length == 0)))
            {
                return;
            };
            var _local_2:IWindowContainer = IWindowContainer(_details.findChildByName("eventinfo_cont"));
            Util.hideChildren(_local_2);
            var _local_4:ITextWindow = ITextWindow(_local_2.findChildByName("eventinfo_name"));
            var _local_7:ITextWindow = ITextWindow(_local_2.findChildByName("eventinfo_desc"));
            var _local_3:ITextWindow = ITextWindow(_local_2.findChildByName("eventinfo_expirationtime"));
            var _local_6:ITextWindow = ITextWindow(_local_2.findChildByName("eventinfo.caption"));
            _local_4.caption = _arg_1.roomAdName;
            _local_7.caption = _arg_1.roomAdDescription;
            _local_3.caption = FriendlyTime.getFriendlyTime(_navigator.localization, (_arg_1.roomAdExpiresInMin * 60));
            _local_7.height = (_local_7.textHeight + 10);
            _local_3.y = (_local_7.y + _local_7.height);
            _local_2.height = (((_local_4.height + _local_7.height) + _local_3.height) + 20);
            var _local_5:IWindowContainer = (_local_2.findChildByName("eventinfo_child_container") as IWindowContainer);
            _local_5.x = (_local_6.textWidth + 5);
            _local_5.height = (Util.getLowestPoint(_local_5) + 5);
            _local_2.visible = true;
            _local_6.visible = true;
            _local_5.visible = true;
        }

        private function refreshRoomName(_arg_1:IWindowContainer, _arg_2:GuestRoomData):void
        {
            var _local_3:ITextWindow = ITextWindow(_arg_1.getChildByName("roomname"));
            _local_3.visible = true;
            _local_3.text = _arg_2.roomName;
            _local_3.height = (_local_3.textHeight + 3);
        }

        private function refreshRoomDesc(_arg_1:IWindowContainer, _arg_2:GuestRoomData):void
        {
            if (_arg_2.description == "")
            {
                return;
            };
            var _local_3:String = "roomdesc";
            var _local_4:ITextWindow = ITextWindow(_arg_1.getChildByName(_local_3));
            _local_4.text = _arg_2.description;
            _local_4.height = (_local_4.textHeight + 10);
            _local_4.y = Util.getLowestPoint(_arg_1);
            _local_4.visible = true;
        }

        private function refreshTextWithCaption(_arg_1:String, _arg_2:IWindowContainer, _arg_3:String):void
        {
            var _local_5:IWindowContainer = IWindowContainer(_arg_2.findChildByName((_arg_1 + "_cont")));
            _local_5.visible = true;
            var _local_6:ITextWindow = ITextWindow(_local_5.getChildByName(_arg_1));
            var _local_4:ITextWindow = ITextWindow(_local_5.getChildByName((_arg_1 + ".caption")));
            _local_6.text = _arg_3;
            Util.moveChildrenToRow(_local_5, [(_arg_1 + ".caption"), _arg_1], _local_4.x, 0, 2);
        }

        private function refreshInfo(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean):void
        {
            if (!_arg_3)
            {
                return;
            };
            var _local_4:IWindowContainer = IWindowContainer(_arg_1.findChildByName(_arg_2));
            _local_4.visible = true;
            navigator.refreshButton(_local_4, _arg_2, true, null, 0);
        }

        private function getEventCtg(_arg_1:int):String
        {
            var _local_3:String = ("roomevent_type_" + _arg_1);
            var _local_2:String = navigator.getText(_local_3);
            return ((_local_2 == null) ? "" : _local_2);
        }

        private function getRoomCtg(_arg_1:int):String
        {
            for each (var _local_2:FlatCategory in navigator.data.allCategories)
            {
                if (_local_2.nodeId == _arg_1)
                {
                    return (_local_2.nodeName);
                };
            };
            return ("");
        }

        private function onOwnerName(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            ExtendedProfileIcon.onEntry(_arg_1, _arg_2);
            if (_arg_1.type == "WME_CLICK")
            {
                _navigator.trackGoogle("extendedProfile", "navigator_roomPopup");
                _navigator.send(new GetExtendedProfileMessageComposer(_SafeStr_3001.ownerId));
                this.hideInstantly();
            };
        }

        private function onRoomSettings(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _navigator.trackGoogle("roomInfo", "editRoomSettings");
                _navigator.roomSettingsCtrl.startRoomSettingsEditFromNavigator(_SafeStr_3001.flatId, _SafeStr_3001.habboGroupId);
                this.hideInstantly();
            };
        }


    }
}

