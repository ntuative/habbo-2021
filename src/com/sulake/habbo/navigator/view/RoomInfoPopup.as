package com.sulake.habbo.navigator.view
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.navigator.HabboNewNavigator;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsData;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.habbo.window.widgets.IBadgeImageWidget;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.utils.FriendlyTime;
    import com.sulake.habbo.session.enum.RoomTradingLevelEnum;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.navigator.roomsettings.RoomSettingsCtrl;
    import com.sulake.habbo.navigator.transitional.LegacyNavigator;
    import com.sulake.habbo.communication.messages.outgoing.navigator.AddFavouriteRoomMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.DeleteFavouriteRoomMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.UpdateHomeRoomMessageComposer;

    public class RoomInfoPopup 
    {

        private var _window:IWindowContainer;
        private var _navigator:HabboNewNavigator;
        private var _SafeStr_2987:Vector.<String> = new Vector.<String>(0);
        private var _SafeStr_2988:GuestRoomData = null;
        private var _lastWindowPosition:Point = new Point(-1, -1);
        private var _SafeStr_2989:Boolean = false;
        private var _SafeStr_2990:Boolean;
        private var _SafeStr_2991:Boolean = false;
        private var _SafeStr_2992:Boolean;

        public function RoomInfoPopup(_arg_1:HabboNewNavigator)
        {
            _navigator = _arg_1;
        }

        public function show(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                if (!_window)
                {
                    createWindow();
                };
                populate();
                _window.visible = true;
                _SafeStr_2989 = false;
                _SafeStr_2991 = false;
            }
            else
            {
                if (_window)
                {
                    _window.visible = false;
                };
            };
        }

        public function get visible():Boolean
        {
            if (!_window)
            {
                return (false);
            };
            return (_window.visible);
        }

        public function showAt(_arg_1:Boolean, _arg_2:int, _arg_3:int):void
        {
            var _local_5:Point;
            var _local_4:Boolean = (!(this.visible));
            show(_arg_1);
            if (_arg_1)
            {
                _local_5 = new Point(_arg_2, (_arg_3 - (_window.height / 2)));
                if (_lastWindowPosition != _local_5)
                {
                    if ((((_local_4) && (_arg_1)) && (_SafeStr_2988)))
                    {
                        _navigator.trackEventLog("browse.openroominfo", "Results", _SafeStr_2988.roomName, _SafeStr_2988.flatId);
                    };
                };
                position = _local_5;
                _window.activate();
            };
        }

        public function setData(_arg_1:GuestRoomData):void
        {
            this._SafeStr_2988 = _arg_1;
        }

        public function getGlobalRectangle(_arg_1:Rectangle):void
        {
            _window.getGlobalRectangle(_arg_1);
        }

        private function set position(_arg_1:Point):void
        {
            _window.position = _arg_1;
            _lastWindowPosition = _arg_1;
        }

        private function get roomIsHome():Boolean
        {
            if (_SafeStr_2989)
            {
                return (_SafeStr_2990);
            };
            return (_navigator.legacyNavigator.isRoomHome(_SafeStr_2988.flatId));
        }

        private function set roomIsHome(_arg_1:Boolean):void
        {
            _SafeStr_2989 = true;
            _SafeStr_2990 = _arg_1;
        }

        private function get roomIsFavorite():Boolean
        {
            if (_SafeStr_2991)
            {
                return (_SafeStr_2992);
            };
            return (_navigator.legacyNavigator.isRoomFavorite(_SafeStr_2988.flatId));
        }

        private function set roomIsFavorite(_arg_1:Boolean):void
        {
            _SafeStr_2991 = true;
            _SafeStr_2992 = _arg_1;
        }

        private function populate():void
        {
            var _local_7:HabboGroupDetailsData;
            var _local_5:String;
            var _local_1:String;
            var _local_10:int;
            if (_SafeStr_2988 == null)
            {
                return;
            };
            var _local_4:IItemListWindow = IItemListWindow(_window.findChildByName("main_content"));
            var _local_9:IItemListWindow = IItemListWindow(_window.findChildByName("header_content"));
            var _local_6:IItemListWindow = IItemListWindow(_window.findChildByName("bottom_itemlist"));
            _window.findChildByName("room_owner_region").visible = _SafeStr_2988.showOwner;
            _window.findChildByName("room_group_region").visible = (!(_SafeStr_2988.groupBadgeCode == ""));
            _window.findChildByName("room_name").caption = _SafeStr_2988.roomName;
            _window.findChildByName("room_desc").caption = _SafeStr_2988.description;
            _window.findChildByName("owner_name").caption = _SafeStr_2988.ownerName;
            _window.findChildByName("room_owner_region").id = _SafeStr_2988.ownerId;
            _window.findChildByName("room_owner_region").procedure = ownerLinkProcedure;
            _window.findChildByName("favorite_region").procedure = roomFavoriteRegionProcedure;
            _window.findChildByName("home_region").procedure = homeRoomRegionProcedure;
            _window.findChildByName("settings_region").procedure = settingsRegionProcedure;
            _window.findChildByName("settings_container").visible = (_SafeStr_2988.ownerName == _navigator.sessionData.userName);
            if (((_navigator.context.configuration.getBoolean("room.report.enabled")) && (!(_SafeStr_2988.ownerName == _navigator.sessionData.userName))))
            {
                _window.findChildByName("report_region").id = _SafeStr_2988.ownerId;
                _window.findChildByName("report_region").procedure = reportRegionProcedure;
                _window.findChildByName("report_region").visible = true;
                _window.findChildByName("report_container").visible = true;
            }
            else
            {
                _window.findChildByName("report_region").visible = false;
                _window.findChildByName("report_container").visible = false;
            };
            IItemListWindow(_window.findChildByName("midBottom_itemlist")).arrangeListItems();
            IStaticBitmapWrapperWindow(_window.findChildByName("favorite_icon")).assetUri = ("newnavigator_icon_fav_" + ((roomIsFavorite) ? "yes" : "no"));
            IStaticBitmapWrapperWindow(_window.findChildByName("home_icon")).assetUri = ("newnavigator_icon_home_" + ((roomIsHome) ? "yes" : "no"));
            var _local_8:Boolean = (!(_SafeStr_2988.groupBadgeCode == ""));
            _window.findChildByName("room_group_badge").visible = _local_8;
            _window.findChildByName("room_owner_region").visible = _SafeStr_2988.showOwner;
            _window.findChildByName("room_group_region").visible = _local_8;
            _window.findChildByName("room_group_owner_container").visible = ((_local_8) || (_SafeStr_2988.showOwner));
            if (_local_8)
            {
                IBadgeImageWidget(IWidgetWindow(_window.findChildByName("room_group_badge")).widget).badgeId = _SafeStr_2988.groupBadgeCode;
                _window.findChildByName("group_name").caption = _SafeStr_2988.groupName;
                _window.findChildByName("group_name").id = _SafeStr_2988.habboGroupId;
                _window.findChildByName("room_group_region").id = _SafeStr_2988.habboGroupId;
                _window.findChildByName("room_group_region").procedure = groupLinkProcedure;
                _local_7 = _navigator.getCachedGroupDetails(_SafeStr_2988.habboGroupId);
                if (_local_7)
                {
                    if (_local_7.isOwner)
                    {
                        IStaticBitmapWrapperWindow(_window.findChildByName("group_mode_admin")).assetUri = "newnavigator_icon_group_owner";
                    }
                    else
                    {
                        if (_local_7.isAdmin)
                        {
                            IStaticBitmapWrapperWindow(_window.findChildByName("group_mode_admin")).assetUri = "newnavigator_icon_group_admin";
                        }
                        else
                        {
                            IStaticBitmapWrapperWindow(_window.findChildByName("group_mode_admin")).assetUri = null;
                        };
                    };
                    IStaticBitmapWrapperWindow(_window.findChildByName("group_mode_size")).assetUri = (("${image.library.url}guilds/grouptype_icon_" + _local_7.type) + ".png");
                    IStaticBitmapWrapperWindow(_window.findChildByName("group_mode_furnish")).assetUri = ((_local_7.membersCanDecorate) ? "${image.library.url}guilds/group_decorate_icon.png" : null);
                };
            }
            else
            {
                IStaticBitmapWrapperWindow(_window.findChildByName("group_mode_admin")).assetUri = null;
                IStaticBitmapWrapperWindow(_window.findChildByName("group_mode_size")).assetUri = null;
                IStaticBitmapWrapperWindow(_window.findChildByName("group_mode_furnish")).assetUri = null;
            };
            var _local_3:Boolean = (_SafeStr_2988.roomAdExpiresInMin > 0);
            if (_local_3)
            {
                _local_5 = ((_navigator.localization.getLocalizationWithParams("navigator.eventsettings.name") + ": ") + _SafeStr_2988.roomAdName);
                _local_1 = (((_navigator.localization.getLocalizationWithParams("navigator.eventsettings.desc") + ": ") + _SafeStr_2988.roomAdDescription) + "\n");
                _local_1 = (_local_1 + (_navigator.localization.getLocalizationWithParams("roomad.event.expiration_time") + FriendlyTime.getFriendlyTime(_navigator.localization, (_SafeStr_2988.roomAdExpiresInMin * 60))));
                _window.findChildByName("event_name").caption = _local_5;
                _window.findChildByName("event_desc").caption = _local_1;
            };
            _local_6.getListItemByName("event_info").visible = _local_3;
            _local_9.arrangeListItems();
            _SafeStr_2987 = new Vector.<String>(0);
            var _local_2:IItemListWindow = IItemListWindow(_window.findChildByName("tag_list"));
            _local_2.destroyListItems();
            _local_10 = 0;
            while (_local_10 < _SafeStr_2988.tags.length)
            {
                _SafeStr_2987.push(_SafeStr_2988.tags[_local_10]);
                _local_2.addListItem(getNewTagItem(_SafeStr_2988.tags[_local_10], _local_10));
                _local_10++;
            };
            clearProperties();
            addProperty("properties", "${navigator.roompopup.property.trading}", RoomTradingLevelEnum.getLocalizationKey(_SafeStr_2988.tradeMode));
            if (_navigator.context.configuration.getBoolean("room.ranking.enabled"))
            {
                addProperty("properties", "${navigator.roompopup.property.ranking}", _SafeStr_2988.ranking.toString());
            };
            addProperty("properties", "${navigator.roompopup.property.max_users}", _SafeStr_2988.maxUserCount.toString());
            IStaticBitmapWrapperWindow(_window.findChildByName("room_thumbnail")).assetUri = "newnavigator_default_room";
            if (_navigator.sessionData.isPerkAllowed("NAVIGATOR_ROOM_THUMBNAIL_CAMERA"))
            {
                if (_SafeStr_2988.officialRoomPicRef != null)
                {
                    if (_navigator.getBoolean("new.navigator.official.room.thumbnails.in.amazon"))
                    {
                        IStaticBitmapWrapperWindow(_window.findChildByName("room_thumbnail")).assetUri = ((_navigator.getProperty("navigator.thumbnail.url_base") + _SafeStr_2988.flatId) + ".png");
                    }
                    else
                    {
                        IStaticBitmapWrapperWindow(_window.findChildByName("room_thumbnail")).assetUri = (_navigator.getProperty("image.library.url") + _SafeStr_2988.officialRoomPicRef);
                    };
                }
                else
                {
                    IStaticBitmapWrapperWindow(_window.findChildByName("room_thumbnail")).assetUri = ((_navigator.getProperty("navigator.thumbnail.url_base") + _SafeStr_2988.flatId) + ".png");
                };
            };
            _local_6.arrangeListItems();
            _local_4.arrangeListItems();
        }

        private function clearProperties():void
        {
            IItemListWindow(_window.findChildByName("properties")).destroyListItems();
        }

        private function addProperty(_arg_1:String, _arg_2:String, _arg_3:String):void
        {
            var _local_5:IItemListWindow = IItemListWindow(_window.findChildByName(_arg_1));
            var _local_4:IWindowContainer = IWindowContainer(_navigator.windowManager.buildFromXML(XML(_navigator.assets.getAssetByName("property_xml").content)));
            _local_4.findChildByName("property_name").caption = _arg_2;
            _local_4.findChildByName("property_value").caption = _arg_3;
            _local_5.addListItem(_local_4);
        }

        private function getNewTagItem(_arg_1:String, _arg_2:int):IWindow
        {
            var _local_3:IWindowContainer = IWindowContainer(_navigator.windowManager.buildFromXML(XML(_navigator.assets.getAssetByName("tag_xml").content)));
            var _local_4:IRegionWindow = IRegionWindow(_local_3.findChildByName("tag_region"));
            _local_4.id = _arg_2;
            _local_4.procedure = tagRegionProcedure;
            _local_4.findChildByName("tag_text").caption = ("#" + _arg_1);
            return (_local_4);
        }

        private function createWindow():void
        {
            _window = IWindowContainer(_navigator.windowManager.buildFromXML(XML(_navigator.assets.getAssetByName("room_info_popup_bubble_xml").content)));
        }

        private function ownerLinkProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _navigator.getExtendedProfile(_arg_2.id);
                destroy();
            };
        }

        private function groupLinkProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _navigator.getGuildInfo(_arg_2.id);
                destroy();
            };
        }

        private function reportRegionProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _navigator.habboHelp.reportRoom(_SafeStr_2988.flatId, _SafeStr_2988.roomName, _SafeStr_2988.description);
                destroy();
            };
        }

        private function tagRegionProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _navigator.performTagSearch(_SafeStr_2987[_arg_2.id]);
                destroy();
            };
        }

        private function settingsRegionProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:RoomSettingsCtrl;
            if (_arg_1.type == "WME_CLICK")
            {
                _local_3 = LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl;
                _local_3.startRoomSettingsEditFromNavigator(_SafeStr_2988.flatId, _SafeStr_2988.habboGroupId);
                destroy();
            };
        }

        private function roomFavoriteRegionProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                if (!roomIsFavorite)
                {
                    _navigator.communication.connection.send(new AddFavouriteRoomMessageComposer(_SafeStr_2988.flatId));
                    roomIsFavorite = true;
                }
                else
                {
                    _navigator.communication.connection.send(new DeleteFavouriteRoomMessageComposer(_SafeStr_2988.flatId));
                    roomIsFavorite = false;
                };
                IStaticBitmapWrapperWindow(_window.findChildByName("favorite_icon")).assetUri = ("newnavigator_icon_fav_" + ((roomIsFavorite) ? "yes" : "no"));
            };
        }

        private function homeRoomRegionProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                if (!roomIsHome)
                {
                    _navigator.communication.connection.send(new UpdateHomeRoomMessageComposer(_SafeStr_2988.flatId));
                    roomIsHome = true;
                };
                IStaticBitmapWrapperWindow(_window.findChildByName("home_icon")).assetUri = ("newnavigator_icon_home_" + ((roomIsHome) ? "yes" : "no"));
            };
        }

        private function destroy():void
        {
            if (_window)
            {
                _window.destroy();
            };
            _window = null;
        }


    }
}

