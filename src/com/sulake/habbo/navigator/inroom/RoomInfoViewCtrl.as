package com.sulake.habbo.navigator.inroom
{
    import com.sulake.habbo.navigator.IHabboTransitionalNavigator;
    import com.sulake.habbo.navigator.GuildInfoCtrl;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.navigator.TagRenderer;
    import flash.events.Event;
    import com.sulake.habbo.navigator.Util;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.utils.ExtendedProfileIcon;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.habbo.navigator.SimpleAlertView;
    import com.sulake.habbo.communication.messages.outgoing.navigator.AddFavouriteRoomMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.navigator.DeleteFavouriteRoomMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.MuteAllInRoomComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.UpdateHomeRoomMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.ToggleStaffPickMessageComposer;
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;

    public class RoomInfoViewCtrl 
    {

        private var _navigator:IHabboTransitionalNavigator;
        private var _SafeStr_2909:GuildInfoCtrl;
        private var _window:IFrameWindow;
        private var _SafeStr_2910:TagRenderer;
        private var _embedExpanded:Boolean = false;
        private var _SafeStr_898:Boolean = false;

        public function RoomInfoViewCtrl(_arg_1:IHabboTransitionalNavigator)
        {
            _navigator = _arg_1;
            _SafeStr_2909 = new GuildInfoCtrl(_navigator);
            _SafeStr_2910 = new TagRenderer(_navigator);
        }

        public function dispose():void
        {
            _navigator = null;
            _SafeStr_898 = false;
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            if (_SafeStr_2910)
            {
                _SafeStr_2910.dispose();
                _SafeStr_2910 = null;
            };
            if (_SafeStr_2909)
            {
                _SafeStr_2909.dispose();
                _SafeStr_2909 = null;
            };
        }

        public function close():void
        {
            if (_window == null)
            {
                return;
            };
            _SafeStr_898 = false;
            _window.dispose();
            _window = null;
            _navigator.events.dispatchEvent(new Event("HABBO_ROOM_SETTINGS_TRACKING_EVENT_CLOSED"));
        }

        public function reload():void
        {
            if (_SafeStr_898)
            {
                refresh();
            };
        }

        public function toggle():void
        {
            if (_SafeStr_898)
            {
                _SafeStr_898 = false;
                if (_window)
                {
                    _window.dispose();
                    _window = null;
                };
            }
            else
            {
                _SafeStr_898 = true;
                refresh();
                if (_window != null)
                {
                    _window.activate();
                };
            };
        }

        private function refresh():void
        {
            if (_navigator.data.enteredGuestRoom == null)
            {
                return;
            };
            _SafeStr_2910.useHashTags = true;
            prepareWindow();
            Util.hideChildren(_window.content);
            refreshRoomDetails(_navigator.data.enteredGuestRoom);
            refreshEmbed();
            _SafeStr_2909.refresh(_window.content, _navigator.data.enteredGuestRoom);
            refreshButtons(_navigator.data.enteredGuestRoom);
            Util.moveChildrenToColumn(_window.content, ["room_details", "public_space_details", "guild_info", "embed_info", "buttons_cont"], 0, 3);
            _window.findChildByName("guild_info").x = 11;
            _window.height = (Util.getLowestPoint(_window.content) + 45);
        }

        private function isHome(_arg_1:GuestRoomData):Boolean
        {
            return ((!(_arg_1 == null)) && (_arg_1.flatId == _navigator.data.homeRoomId));
        }

        private function refreshEmbed():void
        {
            var _local_6:ITextWindow;
            var _local_4:ITextFieldWindow;
            var _local_3:IWindow;
            var _local_1:IWindowContainer = IWindowContainer(find("embed_info"));
            var _local_2:Boolean = _navigator.getBoolean("embed.showInRoomInfo");
            var _local_5:Boolean = (!(_navigator.data.enteredGuestRoom == null));
            if (((_local_5) && (_local_2)))
            {
                _local_6 = ITextWindow(_local_1.findChildByName("embed_info_txt"));
                _local_4 = ITextFieldWindow(_local_1.findChildByName("embed_src_txt"));
                _local_3 = _local_1.findChildByName("embed_info_region");
                _local_1.visible = true;
                if (_embedExpanded)
                {
                    _local_4.text = this.getEmbedData();
                };
                _local_6.visible = _embedExpanded;
                _local_4.visible = _embedExpanded;
                _local_3.visible = false;
                _local_1.height = (Util.getLowestPoint(_local_1) + 5);
                _local_3.visible = true;
                _local_3.height = ((_embedExpanded) ? _local_4.y : _local_1.height);
            }
            else
            {
                _local_1.visible = false;
            };
        }

        private function refreshRoomDetails(_arg_1:GuestRoomData):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            var _local_4:IWindowContainer = IWindowContainer(find("room_details"));
            var _local_6:ITextWindow = ITextWindow(find("room_name"));
            _local_6.text = _arg_1.roomName;
            _local_6.height = (_local_6.textHeight + 5);
            var _local_2:ITextWindow = ITextWindow(find("owner_name"));
            if (((_arg_1.showOwner) && (_arg_1.ownerId > 0)))
            {
                find("owner_name_cont").visible = true;
                _local_2.visible = true;
                _local_2.text = _arg_1.ownerName;
                ExtendedProfileIcon.setUserInfoState(false, _local_4);
            }
            else
            {
                find("owner_name_cont").visible = false;
            };
            var _local_3:ITextWindow = ITextWindow(find("room_desc"));
            _local_3.text = _arg_1.description;
            _SafeStr_2910.refreshTags(_local_4, _arg_1.tags);
            _local_3.visible = false;
            if (_arg_1.description != "")
            {
                _local_3.height = (_local_3.textHeight + 5);
                _local_3.visible = true;
            };
            find("rating_region").visible = _navigator.data.canRate;
            ITextWindow(find("rating_txt")).text = ("" + _navigator.data.currentRoomRating);
            var _local_5:IWindow = _window.findChildByName("rating_txt");
            _window.findChildByName("rating_region").x = ((_local_5.x + _local_5.width) + 5);
            find("ranking_cont").visible = (_arg_1.ranking > 0);
            ITextWindow(find("ranking_txt")).text = ("" + _arg_1.ranking);
            _navigator.refreshButton(_local_4, "home", isHome(_arg_1), null, 0);
            _window.findChildByName("make_home_region").visible = (!(isHome(_arg_1)));
            _window.findChildByName("make_favourite_region").visible = ((!(_navigator.data.currentRoomOwner)) && (!(_navigator.data.isCurrentRoomFavourite())));
            _window.findChildByName("favourite_region").visible = ((!(_navigator.data.currentRoomOwner)) && (_navigator.data.isCurrentRoomFavourite()));
            _window.findChildByName("floor_plan_editor_button").visible = _navigator.data.canEditRoomSettings;
            Util.moveChildrenToColumn(_local_4, ["room_name", "owner_name_cont", "rating_cont", "ranking_cont", "padding_cont", "tags", "room_desc", "thumbnail_container"], _local_6.y, 0);
            _local_4.visible = true;
            _local_4.height = Util.getLowestPoint(_local_4);
        }

        private function refreshStaffPick(_arg_1:Boolean=false):void
        {
            var _local_2:IWindow;
            if (_window)
            {
                _local_2 = _window.findChildByName("staff_pick_button");
                if (!_navigator.data.roomPicker)
                {
                    _local_2.visible = false;
                    return;
                };
                _local_2.visible = true;
                if (_arg_1)
                {
                    _local_2.caption = _navigator.getText(((_navigator.data.currentRoomIsStaffPick) ? "navigator.staffpicks.pick" : "navigator.staffpicks.unpick"));
                }
                else
                {
                    _local_2.caption = _navigator.getText(((_navigator.data.currentRoomIsStaffPick) ? "navigator.staffpicks.unpick" : "navigator.staffpicks.pick"));
                };
            };
        }

        public function refreshButtons(_arg_1:GuestRoomData):void
        {
            var _local_3:IWindowContainer;
            if (((_navigator.data.enteredGuestRoom == null) || (_window == null)))
            {
                return;
            };
            find("room_settings_button").visible = _navigator.data.canEditRoomSettings;
            find("room_filter_button").visible = ((_navigator.data.canEditRoomSettings) && (_navigator.getBoolean("room.custom.filter.enabled")));
            if (!_navigator.getBoolean("room.report.enabled"))
            {
                _local_3 = IWindowContainer(find("room_report_button"));
                if (_local_3)
                {
                    _local_3.visible = false;
                };
            };
            refreshStaffPick();
            var _local_6:IWindow = find("room_muteall_button");
            _local_6.visible = ((_navigator.data.enteredGuestRoom.canMute) && (_navigator.getBoolean("room_moderation.mute_all.enabled")));
            var _local_5:Boolean = _navigator.data.enteredGuestRoom.allInRoomMuted;
            _local_6.caption = ((_local_5) ? "${navigator.muteall_on}" : "${navigator.muteall_off}");
            var _local_7:IRoomSession = _navigator.roomSessionManager.getSession(_navigator.data.enteredGuestRoom.flatId);
            find("floor_plan_editor_button").visible = (_local_7.roomControllerLevel >= 1);
            var _local_4:IWindowContainer = IWindowContainer(_window.findChildByName("buttons_cont"));
            var _local_2:Array = ["room_settings_button", "room_filter_button", "floor_plan_editor_button", "staff_pick_button", "room_report_button", "room_muteall_button"];
            Util.moveChildrenToColumn(_local_4, _local_2, 0, 3);
            _local_4.visible = Util.hasVisibleChildren(IWindowContainer(_local_4));
            _local_4.height = Util.getLowestPoint(_local_4);
        }

        private function prepareWindow():void
        {
            var _local_1:String;
            var _local_3:String;
            _SafeStr_898 = true;
            if (_window != null)
            {
                return;
            };
            _window = IFrameWindow(_navigator.getXmlWindow("iro_room_details_framed"));
            _window.center();
            addMouseClickListener(find("make_favourite_region"), onAddFavouriteClick);
            addMouseClickListener(find("favourite_region"), onRemoveFavouriteClick);
            addMouseClickListener(find("room_settings_button"), onRoomSettingsClick);
            addMouseClickListener(find("room_filter_button"), onRoomFilterButtonClick);
            addMouseClickListener(find("floor_plan_editor_button"), onFloorPlanEditorButtonClick);
            addMouseClickListener(find("room_muteall_button"), onMuteAllClick);
            addMouseClickListener(find("make_home_region"), onMakeHomeClick);
            addMouseClickListener(find("remove_rights_region"), onRemoveRights);
            addMouseClickListener(find("embed_src_txt"), onEmbedSrcClick);
            addMouseClickListener(find("staff_pick_button"), onStaffPick);
            addMouseClickListener(find("room_report_button"), onRoomReport);
            _navigator.refreshButton(IRegionWindow(find("remove_rights_region")), "remove_rights", _navigator.hasRoomRightsButIsNotOwner(_navigator.data.enteredGuestRoom.flatId), null, 0);
            _navigator.refreshButton(IRegionWindow(find("make_home_region")), "make_home", true, null, 0);
            _navigator.refreshButton(IRegionWindow(find("favourite_region")), "favourite", true, null, 0);
            _navigator.refreshButton(IRegionWindow(find("make_favourite_region")), "make_favourite", true, null, 0);
            _navigator.refreshButton(IWindowContainer(find("embed_info")), "icon_weblink", true, null, 0);
            addMouseClickListener(_window.findChildByTag("close"), onCloseButtonClick);
            var _local_2:IWindowContainer = IWindowContainer(_window.findChildByName("owner_name_cont"));
            _local_2.procedure = onOwnerName;
            Util.layoutChildrenInArea(_local_2, 1000, 10, 2, 5);
            setupLabelAndValue("rating_cont", "rating_caption", "rating_txt");
            setupLabelAndValue("ranking_cont", "ranking_caption", "ranking_txt");
            var _local_4:IWindowContainer = IWindowContainer(find("embed_info"));
            var _local_5:ITextWindow = ITextWindow(find("embed_info_txt"));
            _local_5.height = (_local_5.textHeight + 5);
            Util.moveChildrenToColumn(_local_4, ["embed_info_txt", "embed_src_txt"], _local_5.y, 2);
            _local_4.height = (Util.getLowestPoint(_local_4) + 5);
            _local_4.findChildByName("embed_info_region").procedure = onEmbedInfo;
            if (_navigator.sessionData.isPerkAllowed("NAVIGATOR_ROOM_THUMBNAIL_CAMERA"))
            {
                _window.findChildByName("add_thumbnail_region").visible = _navigator.data.canEditRoomSettings;
                if (_navigator.data.canEditRoomSettings)
                {
                    addMouseClickListener(find("add_thumbnail_region"), onAddRoomThumbnail);
                };
                _local_3 = "";
                if (_navigator.data.enteredGuestRoom.officialRoomPicRef != null)
                {
                    if (_navigator.getBoolean("new.navigator.official.room.thumbnails.in.amazon"))
                    {
                        _local_1 = _navigator.getProperty("navigator.thumbnail.url_base");
                        _local_3 = ((_local_1 + _navigator.data.enteredGuestRoom.flatId) + ".png");
                    }
                    else
                    {
                        _local_3 = (_navigator.getProperty("image.library.url") + _navigator.data.enteredGuestRoom.officialRoomPicRef);
                    };
                }
                else
                {
                    _local_1 = _navigator.getProperty("navigator.thumbnail.url_base");
                    _local_3 = ((_local_1 + _navigator.data.enteredGuestRoom.flatId) + ".png");
                };
                IStaticBitmapWrapperWindow(_window.findChildByName("thumbnail_image")).assetUri = _local_3;
            }
            else
            {
                _window.findChildByName("thumbnail_container").visible = false;
            };
        }

        private function setupLabelAndValue(_arg_1:String, _arg_2:String, _arg_3:String):void
        {
            var _local_4:IWindowContainer = IWindowContainer(find(_arg_1));
            var _local_5:ITextWindow = ITextWindow(_local_4.findChildByName(_arg_2));
            _local_5.width = _local_5.textWidth;
            Util.moveChildrenToRow(_local_4, [_arg_2, _arg_3], _local_5.x, _local_5.y, 3);
        }

        private function addMouseClickListener(_arg_1:IWindow, _arg_2:Function):void
        {
            if (_arg_1 != null)
            {
                _arg_1.addEventListener("WME_CLICK", _arg_2);
            };
        }

        private function find(_arg_1:String):IWindow
        {
            var _local_2:IWindow = _window.findChildByName(_arg_1);
            if (_local_2 == null)
            {
                throw (new Error((("Window element with name: " + _arg_1) + " cannot be found!")));
            };
            return (_local_2);
        }

        public function onAddFavouriteClick(_arg_1:WindowEvent):void
        {
            var _local_2:SimpleAlertView;
            if (_navigator.data.enteredGuestRoom == null)
            {
                return;
            };
            if (_navigator.data.isFavouritesFull())
            {
                _local_2 = new SimpleAlertView(_navigator, "${navigator.favouritesfull.title}", "${navigator.favouritesfull.body}");
                _local_2.show();
            }
            else
            {
                _navigator.trackGoogle("roomInfo", "addFavourite");
                _navigator.send(new AddFavouriteRoomMessageComposer(_navigator.data.enteredGuestRoom.flatId));
            };
        }

        public function onRemoveFavouriteClick(_arg_1:WindowEvent):void
        {
            if (_navigator.data.enteredGuestRoom == null)
            {
                return;
            };
            _navigator.trackGoogle("roomInfo", "removeFavourite");
            _navigator.send(new DeleteFavouriteRoomMessageComposer(_navigator.data.enteredGuestRoom.flatId));
        }

        private function onRoomSettingsClick(_arg_1:WindowEvent):void
        {
            var _local_2:GuestRoomData = _navigator.data.enteredGuestRoom;
            if (_local_2 == null)
            {
                Logger.log("No entered room data?!");
                return;
            };
            _navigator.trackGoogle("roomInfo", "editRoomSettings");
            _navigator.roomSettingsCtrl.startRoomSettingsEdit(_local_2.flatId);
            close();
        }

        private function onRoomFilterButtonClick(_arg_1:WindowEvent):void
        {
            var _local_2:GuestRoomData = _navigator.data.enteredGuestRoom;
            if (_local_2 == null)
            {
                Logger.log("No entered room data?!");
                return;
            };
            _navigator.trackGoogle("roomInfo", "editRoomFilter");
            _navigator.roomFilterCtrl.startRoomFilterEdit(_local_2.flatId);
            close();
        }

        private function onFloorPlanEditorButtonClick(_arg_1:WindowEvent):void
        {
            _navigator.trackGoogle("roomInfo", "floorPlanEditor");
            _navigator.windowManager.displayFloorPlanEditor();
            close();
        }

        private function onMuteAllClick(_arg_1:WindowEvent):void
        {
            _navigator.send(new MuteAllInRoomComposer());
        }

        private function onMakeHomeClick(_arg_1:WindowEvent):void
        {
            var _local_2:GuestRoomData = _navigator.data.enteredGuestRoom;
            if (_local_2 == null)
            {
                Logger.log("No entered room data?!");
                return;
            };
            Logger.log(("SETTING HOME ROOM TO: " + _local_2.flatId));
            _navigator.trackGoogle("roomInfo", "makeHome");
            _navigator.send(new UpdateHomeRoomMessageComposer(_local_2.flatId));
        }

        private function onCloseButtonClick(_arg_1:WindowEvent):void
        {
            hideInfo(null);
        }

        private function onRemoveRights(_arg_1:WindowEvent):void
        {
            _navigator.removeRoomRights(_navigator.enteredGuestRoomData.flatId);
            find("remove_rights_region").visible = false;
        }

        private function onStaffPick(_arg_1:WindowEvent):void
        {
            refreshStaffPick(true);
            _navigator.send(new ToggleStaffPickMessageComposer(_navigator.data.enteredGuestRoom.flatId, _navigator.data.currentRoomIsStaffPick));
        }

        private function onRoomReport(_arg_1:WindowEvent):void
        {
            _navigator.trackGoogle("roomInfo", "reportRoom");
            var _local_2:GuestRoomData = _navigator.data.enteredGuestRoom;
            _navigator.habboHelp.reportRoom(_local_2.flatId, _local_2.roomName, _local_2.description);
            close();
        }

        private function onEmbedSrcClick(_arg_1:WindowEvent):void
        {
            var _local_2:ITextFieldWindow = ITextFieldWindow(find("embed_src_txt"));
            _local_2.setSelection(0, _local_2.text.length);
            _navigator.trackGoogle("roomInfo", "embedSrc");
        }

        private function onAddRoomThumbnail(_arg_1:WindowEvent):void
        {
            (_navigator.windowManager as Component).context.createLinkEvent("roomThumbnailCamera/open");
            close();
            var _local_2:String = ((_navigator.getProperty("navigator.thumbnail.url_base") + _navigator.data.enteredGuestRoom.flatId) + ".png");
            _navigator.windowManager.resourceManager.removeAsset(_local_2);
            _navigator.trackGoogle("roomInfo", "addThumbnail");
        }

        private function hideInfo(_arg_1:Event):void
        {
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            _SafeStr_898 = false;
        }

        private function getEmbedData():String
        {
            var _local_2:String;
            var _local_3:String;
            if (_navigator.data.enteredGuestRoom != null)
            {
                _local_2 = "private";
                _local_3 = ("" + _navigator.data.enteredGuestRoom.flatId);
            };
            var _local_1:String = _navigator.getProperty("user.hash");
            _navigator.registerParameter("navigator.embed.src", "roomType", _local_2);
            _navigator.registerParameter("navigator.embed.src", "embedCode", _local_1);
            _navigator.registerParameter("navigator.embed.src", "roomId", _local_3);
            return (_navigator.getText("navigator.embed.src"));
        }

        private function onEmbedInfo(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            _embedExpanded = (!(_embedExpanded));
            refresh();
        }

        private function onOwnerName(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            ExtendedProfileIcon.onEntry(_arg_1, _arg_2);
            if (_arg_1.type == "WME_CLICK")
            {
                _navigator.trackGoogle("roomInfo", "extendedProfile");
                _navigator.trackGoogle("extendedProfile", "navigator_roomInfo");
                _navigator.send(new GetExtendedProfileMessageComposer(_navigator.data.enteredGuestRoom.ownerId));
            };
        }


    }
}

