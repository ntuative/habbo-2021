package com.sulake.habbo.navigator
{
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.communication.messages.incoming.newnavigator.NavigatorSavedSearchesEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FavouritesEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatAccessDeniedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.newnavigator.NavigatorSearchResultBlocksEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsSaveErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.UserEventCatsEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomRatingEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCreatedEvent;
    import com.sulake.habbo.communication.messages.incoming.newnavigator.NavigatorMetaDataEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsDataEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsSavedEvent;
    import com.sulake.habbo.communication.messages.incoming.newnavigator.NavigatorLiftedRoomsEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.PopularRoomTagsResultEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.CanCreateRoomEventEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventEvent;
    import com.sulake.habbo.communication.messages.parser.competition.NoOwnedRoomsAlertMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.MuteAllInRoomEvent;
    import com.sulake.habbo.communication.messages.parser.room.chat.RoomFilterSettingsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.UserUnbannedFromRoomEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.CategoriesWithVisitorCountEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerRemovedEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListFragmentMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.CompetitionRoomsDataMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.BannedUsersFromRoomEvent;
    import com.sulake.habbo.communication.messages.incoming.newnavigator.NewNavigatorPreferencesEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerAddedEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.DoorbellMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FavouriteChangedEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.FlatAccessibleMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.CantConnectMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.NoSuchFlatEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.UserFlatCatsEvent;
    import com.sulake.habbo.communication.messages.incoming.newnavigator.NavigatorCollapsedCategoriesMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllersEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomInfoUpdatedEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomsEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventCancelEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.newnavigator.SearchResultContainer;
    import com.sulake.habbo.navigator.domain.NavigatorData;
    import com.sulake.habbo.communication.messages.parser.roomsettings.MuteAllInRoomParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.habbo.navigator.transitional.LegacyNavigator;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetUserFlatCatsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator._SafeStr_53;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.CategoriesWithVisitorCountParser;
    import com.sulake.habbo.communication.messages.parser.navigator.OfficialRoomsMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultData;
    import com.sulake.habbo.communication.messages.incoming.navigator.PopularRoomTagsData;
    import com.sulake.habbo.communication.messages.parser.navigator.RoomEventMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.CanCreateRoomEventMessageParser;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.communication.messages.parser.navigator.FlatCreatedMessageParser;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.habbo.communication.messages.parser.navigator.UserFlatCatsMessageParser;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.RoomsTabPageDecorator;
    import com.sulake.habbo.communication.messages.parser.navigator.UserEventCatsMessageParser;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsDataMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.chat.RoomFilterSettingsMessageParser;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsErrorMessageParser;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSavedMessageParser;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSaveErrorMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.RoomInfoUpdatedMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetGuestRoomMessageComposer;
    import com.sulake.habbo.communication.messages.parser.navigator.FavouritesMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.FavouriteChangedMessageParser;
    import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllersMessageParser;
    import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllerAddedMessageParser;
    import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllerRemovedMessageParser;
    import com.sulake.habbo.communication.messages.parser.roomsettings.BannedUsersFromRoomParser;
    import com.sulake.habbo.communication.messages.parser.roomsettings.UserUnbannedFromRoomParser;
    import com.sulake.habbo.communication.messages.parser.room.session.FlatAccessibleMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.RoomRatingMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.FlatAccessDeniedMessageParser;
    import com.sulake.core.window.IWindowContext;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.parser.room.session.CantConnectMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.room.session._SafeStr_23;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;

        public class NewIncomingMessages 
    {

        private var _navigator:HabboNewNavigator;
        private var _messageListeners:Array = [];

        public function NewIncomingMessages(_arg_1:HabboNewNavigator)
        {
            _navigator = _arg_1;
            var _local_2:IHabboCommunicationManager = _navigator.communication;
            addMessageListeners();
        }

        public function addMessageListeners():void
        {
            var _local_1:IHabboCommunicationManager = _navigator.communication;
            _messageListeners.push(_local_1.connection.addMessageEvent(new NavigatorSavedSearchesEvent(onSavedSearches)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new FavouritesEvent(onFavourites)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new CloseConnectionMessageEvent(onRoomExit)));
            _messageListeners.push(_local_1.connection.addMessageEvent(new HabboGroupDetailsMessageEvent(onGroupDetails)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new FlatAccessDeniedMessageEvent(onFlatAccessDenied)));
            _messageListeners.push(_local_1.connection.addMessageEvent(new NavigatorSearchResultBlocksEvent(onNavigatorSearchResultBlocks)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new RoomSettingsSaveErrorEvent(onRoomSettingsSaveError)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new UserEventCatsEvent(onUserEventCats)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new RoomRatingEvent(onRoomRating)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new FlatCreatedEvent(onFlatCreated)));
            _messageListeners.push(_local_1.connection.addMessageEvent(new NavigatorMetaDataEvent(onNavigatorMetaData)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new RoomSettingsDataEvent(onRoomSettingsData)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new RoomSettingsErrorEvent(onRoomSettingsError)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new RoomSettingsSavedEvent(onRoomSettingsSaved)));
            _messageListeners.push(_local_1.connection.addMessageEvent(new NavigatorLiftedRoomsEvent(onNavigatorLiftedRooms)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new PopularRoomTagsResultEvent(onPopularRoomTagsResult)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new CanCreateRoomEventEvent(onCanCreateRoomEventEvent)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new RoomEventEvent(onRoomEventEvent)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new NoOwnedRoomsAlertMessageEvent(onNoOwnedRoomsAlert)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new MuteAllInRoomEvent(onMuteAllEvent)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new RoomFilterSettingsMessageEvent(onRoomFilterSettings)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new UserUnbannedFromRoomEvent(onUserUnbannedFromRoom)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new CategoriesWithVisitorCountEvent(onCategoriesWithUserCount)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new FlatControllerRemovedEvent(onFlatControllerRemoved)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new FriendListFragmentMessageEvent(onFriendsListFragment)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new CompetitionRoomsDataMessageEvent(onCompetitionData)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new BannedUsersFromRoomEvent(onBannedUsersFromRoom)));
            _messageListeners.push(_local_1.connection.addMessageEvent(new NewNavigatorPreferencesEvent(onNavigatorPreferences)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new FlatControllerAddedEvent(onFlatControllerAdded)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new GuestRoomSearchResultEvent(onGuestRoomSearchResult)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new DoorbellMessageEvent(onDoorbell)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new FavouriteChangedEvent(onFavouriteChanged)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new FriendListUpdateEvent(onFriendListUpdate)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new FlatAccessibleMessageEvent(onDoorOpened)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new CantConnectMessageEvent(onCantConnect)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new NoSuchFlatEvent(onNoSuchFlat)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new UserFlatCatsEvent(onUserFlatCats)));
            _messageListeners.push(_local_1.connection.addMessageEvent(new NavigatorCollapsedCategoriesMessageEvent(onCollapsedCategories)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new FlatControllersEvent(onFlatControllers)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new RoomInfoUpdatedEvent(onRoomInfoUpdated)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new OfficialRoomsEvent(onOfficialRooms)));
            _messageListeners.push(_local_1.addHabboConnectionMessageEvent(new RoomEventCancelEvent(onRoomEventCancel)));
        }

        public function removeLegacyMessageListeners():void
        {
            var _local_1:IHabboCommunicationManager = _navigator.communication;
            for each (var _local_2:IMessageEvent in _messageListeners)
            {
                _local_1.removeHabboConnectionMessageEvent(_local_2);
            };
            _messageListeners = [];
        }

        private function onNavigatorMetaData(_arg_1:NavigatorMetaDataEvent):void
        {
            _navigator.initialize(_arg_1.getParser());
        }

        private function onNavigatorSearchResultBlocks(_arg_1:NavigatorSearchResultBlocksEvent):void
        {
            _navigator.onSearchResult(new SearchResultContainer(_arg_1.getParser().searchResult));
        }

        private function onNavigatorLiftedRooms(_arg_1:NavigatorLiftedRoomsEvent):void
        {
            _navigator.onLiftedRooms(_arg_1.getParser());
        }

        private function onNavigatorPreferences(_arg_1:NewNavigatorPreferencesEvent):void
        {
            _navigator.onPreferences(_arg_1.getParser());
        }

        private function onSavedSearches(_arg_1:NavigatorSavedSearchesEvent):void
        {
            _navigator.onSavedSearches(_arg_1.getParser());
        }

        private function onGroupDetails(_arg_1:HabboGroupDetailsMessageEvent):void
        {
            _navigator.onGroupDetails(_arg_1.data);
        }

        private function onCollapsedCategories(_arg_1:NavigatorCollapsedCategoriesMessageEvent):void
        {
            _navigator.onCollapsedCategories(_arg_1.getParser().collapsedCategories);
        }

        private function get data():NavigatorData
        {
            return (_navigator.data);
        }

        private function onMuteAllEvent(_arg_1:IMessageEvent):void
        {
            var _local_4:MuteAllInRoomEvent = (_arg_1 as MuteAllInRoomEvent);
            var _local_3:MuteAllInRoomParser = _local_4.getParser();
            var _local_2:GuestRoomData = _navigator.data.enteredGuestRoom;
            if (_local_2 != null)
            {
                _local_2.allInRoomMuted = _local_3.allMuted;
                if (LegacyNavigator(_navigator.legacyNavigator).roomInfoViewCtrl != null)
                {
                    LegacyNavigator(_navigator.legacyNavigator).roomInfoViewCtrl.refreshButtons(_navigator.data.enteredGuestRoom);
                };
            };
        }

        private function onNoSuchFlat(_arg_1:IMessageEvent):void
        {
        }

        private function onUserObject(_arg_1:IMessageEvent):void
        {
            var _local_2:UserObjectMessageParser = UserObjectEvent(_arg_1).getParser();
            _navigator.data.avatarId = _local_2.id;
            LegacyNavigator(_navigator.legacyNavigator).send(new GetUserFlatCatsMessageComposer());
            LegacyNavigator(_navigator.legacyNavigator).send(new _SafeStr_53());
        }

        private function onUserRights(_arg_1:IMessageEvent):void
        {
            var _local_2:UserRightsMessageEvent;
            if (_navigator)
            {
                _local_2 = UserRightsMessageEvent(_arg_1);
                if (_local_2.securityLevel >= 5)
                {
                    _navigator.data.eventMod = true;
                };
                if (_local_2.securityLevel >= 7)
                {
                    _navigator.data.roomPicker = true;
                };
            };
        }

        private function onCategoriesWithUserCount(_arg_1:IMessageEvent):void
        {
            var _local_2:CategoriesWithVisitorCountParser = CategoriesWithVisitorCountEvent(_arg_1).getParser();
            data.categoriesWithVisitorData = _local_2.data;
            Logger.log(("Received Categories with user count: " + data.categoriesWithVisitorData.categoryToCurrentUserCountMap.length));
        }

        private function onOfficialRooms(_arg_1:IMessageEvent):void
        {
            var _local_2:OfficialRoomsMessageParser = OfficialRoomsEvent(_arg_1).getParser();
            data.officialRooms = _local_2.data;
            data.adRoom = _local_2.adRoom;
            data.promotedRooms = _local_2.promotedRooms;
            Logger.log(("Received Official rooms: " + data.officialRooms.entries.length));
        }

        private function onGuestRoomSearchResult(_arg_1:IMessageEvent):void
        {
            var _local_2:GuestRoomSearchResultData = GuestRoomSearchResultEvent(_arg_1).getParser().data;
            data.guestRoomSearchResults = _local_2;
            Logger.log(("Received GuestRoomSearch: " + ((data.guestRoomSearchResults.rooms) ? data.guestRoomSearchResults.rooms.length : " no rooms")));
        }

        private function onPopularRoomTagsResult(_arg_1:IMessageEvent):void
        {
            var _local_2:PopularRoomTagsData = PopularRoomTagsResultEvent(_arg_1).getParser().data;
            data.popularTags = _local_2;
            Logger.log(("Received popular room tags: " + data.popularTags.tags.length));
        }

        private function onRoomEventEvent(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomEventMessageParser = RoomEventEvent(_arg_1).getParser();
            Logger.log(((("Got room event: " + _local_2.data.ownerAvatarId) + ", ") + _local_2.data.eventName));
            data.roomEventData = ((_local_2.data.ownerAvatarId > 0) ? _local_2.data : null);
            LegacyNavigator(_navigator.legacyNavigator).roomEventInfoCtrl.refresh();
        }

        private function onRoomEventCancel(_arg_1:IMessageEvent):void
        {
            data.roomEventData = null;
            LegacyNavigator(_navigator.legacyNavigator).roomEventInfoCtrl.refresh();
        }

        private function onCanCreateRoomEventEvent(_arg_1:IMessageEvent):void
        {
            var _local_3:SimpleAlertView;
            var _local_2:CanCreateRoomEventMessageParser = CanCreateRoomEventEvent(_arg_1).getParser();
            Logger.log(("CAN CREATE EVENT: " + _local_2.canCreateEvent));
            if (_local_2.canCreateEvent)
            {
                LegacyNavigator(_navigator.legacyNavigator).roomEventViewCtrl.show();
            }
            else
            {
                _local_3 = new SimpleAlertView(LegacyNavigator(_navigator.legacyNavigator), "${navigator.cannotcreateevent.title}", (("${navigator.cannotcreateevent.error." + _local_2.errorCode) + "}"));
                _local_3.show();
                Logger.log("Cannot create an event just now...");
            };
        }

        private function requestRoomEnterAd():void
        {
            if (_navigator.getProperty("roomenterad.habblet.enabled") == "true")
            {
                HabboWebTools.openRoomEnterAd();
            };
        }

        private function onFlatCreated(_arg_1:IMessageEvent):void
        {
            var _local_2:FlatCreatedMessageParser = FlatCreatedEvent(_arg_1).getParser();
            ErrorReportStorage.addDebugData("IncomingEvent", ((("Flat created: " + _local_2.flatId) + ", ") + _local_2.flatName));
            data.createdFlatId = _local_2.flatId;
            LegacyNavigator(_navigator.legacyNavigator).goToRoom(_local_2.flatId, true);
            LegacyNavigator(_navigator.legacyNavigator).mainViewCtrl.reloadRoomList(5);
            LegacyNavigator(_navigator.legacyNavigator).goToMainView();
            LegacyNavigator(_navigator.legacyNavigator).closeNavigator();
        }

        private function onGameStarted(_arg_1:IMessageEvent):void
        {
            LegacyNavigator(_navigator.legacyNavigator).mainViewCtrl.close();
        }

        private function onRoomExit(_arg_1:IMessageEvent):void
        {
            Logger.log("Navigator: exiting room");
            data.onRoomExit();
            LegacyNavigator(_navigator.legacyNavigator).roomInfoViewCtrl.close();
            LegacyNavigator(_navigator.legacyNavigator).roomEventInfoCtrl.close();
            LegacyNavigator(_navigator.legacyNavigator).roomEventViewCtrl.close();
            LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.close();
            LegacyNavigator(_navigator.legacyNavigator).roomFilterCtrl.close();
            var _local_2:Boolean = _navigator.getBoolean("news.auto_popup.enabled");
            if (_local_2)
            {
                HabboWebTools.openNews();
            };
        }

        private function onUserFlatCats(_arg_1:IMessageEvent):void
        {
            var _local_3:UserFlatCatsMessageParser = (_arg_1 as UserFlatCatsEvent).getParser();
            _navigator.data.categories = _local_3.nodes;
            var _local_2:RoomsTabPageDecorator = RoomsTabPageDecorator(LegacyNavigator(_navigator.legacyNavigator).tabs.getTab(2).tabPageDecorator);
            _local_2.prepareRoomCategories();
        }

        private function onUserEventCats(_arg_1:IMessageEvent):void
        {
            var _local_2:UserEventCatsMessageParser = (_arg_1 as UserEventCatsEvent).getParser();
            _navigator.data.eventCategories = _local_2.eventCategories;
        }

        private function onRoomSettingsData(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomSettingsDataMessageParser;
            try
            {
                _local_2 = (_arg_1 as RoomSettingsDataEvent).getParser();
                LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.onRoomSettings(_local_2.data);
                Logger.log(((((("GOT ROOM SETTINGS DATA: " + _local_2.data.name) + ", ") + _local_2.data.maximumVisitors) + ", ") + _local_2.data.maximumVisitorsLimit));
            }
            catch(e:Error)
            {
                Logger.log("CRASHED WHILE PROCESSING ROOM SETTINGS DATA!");
            };
        }

        private function onRoomFilterSettings(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomFilterSettingsMessageParser = (_arg_1 as RoomFilterSettingsMessageEvent).getParser();
            LegacyNavigator(_navigator.legacyNavigator).roomFilterCtrl.onRoomFilterSettings(_local_2.badWords);
            Logger.log(("GOT ROOM FILTER SETTINGS: " + _local_2.badWords));
        }

        private function onRoomSettingsError(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomSettingsErrorMessageParser = (_arg_1 as RoomSettingsErrorEvent).getParser();
        }

        private function onRoomSettingsSaved(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomSettingsSavedMessageParser = (_arg_1 as RoomSettingsSavedEvent).getParser();
            ErrorReportStorage.addDebugData("IncomingEvent", ("Room settings saved: " + _local_2.roomId));
            LegacyNavigator(_navigator.legacyNavigator).mainViewCtrl.reloadRoomList(5);
        }

        private function onRoomSettingsSaveError(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomSettingsSaveErrorMessageParser = (_arg_1 as RoomSettingsSaveErrorEvent).getParser();
            LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.onRoomSettingsSaveError(_local_2.roomId, _local_2.errorCode, _local_2.info);
        }

        private function onRoomInfoUpdated(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomInfoUpdatedMessageParser = (_arg_1 as RoomInfoUpdatedEvent).getParser();
            LegacyNavigator(_navigator.legacyNavigator).send(new GetGuestRoomMessageComposer(_local_2.flatId, false, false));
        }

        private function onFavourites(_arg_1:IMessageEvent):void
        {
            var _local_2:FavouritesMessageParser = (_arg_1 as FavouritesEvent).getParser();
            _navigator.data.onFavourites(_local_2);
        }

        private function onFavouriteChanged(_arg_1:IMessageEvent):void
        {
            var _local_2:FavouriteChangedMessageParser = (_arg_1 as FavouriteChangedEvent).getParser();
            data.favouriteChanged(_local_2.flatId, _local_2.added);
            LegacyNavigator(_navigator.legacyNavigator).roomInfoViewCtrl.reload();
            LegacyNavigator(_navigator.legacyNavigator).mainViewCtrl.refresh();
        }

        private function onFlatControllers(_arg_1:IMessageEvent):void
        {
            var _local_2:FlatControllersMessageParser = (_arg_1 as FlatControllersEvent).getParser();
            LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.onFlatControllers(_local_2.roomId, _local_2.controllers);
        }

        private function onFlatControllerAdded(_arg_1:IMessageEvent):void
        {
            var _local_2:FlatControllerAddedMessageParser = (_arg_1 as FlatControllerAddedEvent).getParser();
            LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.onFlatControllerAdded(_local_2.flatId, _local_2.data);
        }

        private function onFlatControllerRemoved(_arg_1:IMessageEvent):void
        {
            var _local_2:FlatControllerRemovedMessageParser = (_arg_1 as FlatControllerRemovedEvent).getParser();
            Logger.log(((("Flat controller removed: " + _local_2.flatId) + ", ") + _local_2.userId));
            LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.onFlatControllerRemoved(_local_2.flatId, _local_2.userId);
        }

        private function onBannedUsersFromRoom(_arg_1:IMessageEvent):void
        {
            var _local_2:BannedUsersFromRoomParser = (_arg_1 as BannedUsersFromRoomEvent).getParser();
            Logger.log(((("Got Banned users for room: " + _local_2.roomId) + ", ") + _local_2.bannedUsers.length));
            LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.onBannedUsersFromRoom(_local_2.roomId, _local_2.bannedUsers);
        }

        private function onUserUnbannedFromRoom(_arg_1:IMessageEvent):void
        {
            var _local_2:UserUnbannedFromRoomParser = (_arg_1 as UserUnbannedFromRoomEvent).getParser();
            Logger.log(((("User was unbanned from room. User Id: " + _local_2.userId) + " Room Id: ") + _local_2.roomId));
            LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.onUserUnbannedFromRoom(_local_2.roomId, _local_2.userId);
        }

        private function onDoorbell(_arg_1:IMessageEvent):void
        {
            var _local_2:DoorbellMessageEvent = (_arg_1 as DoorbellMessageEvent);
            if (_local_2 == null)
            {
                return;
            };
            if (_local_2.userName != "")
            {
                return;
            };
            LegacyNavigator(_navigator.legacyNavigator).doorbell.showWaiting();
        }

        private function onDoorOpened(_arg_1:IMessageEvent):void
        {
            var _local_3:FlatAccessibleMessageEvent = (_arg_1 as FlatAccessibleMessageEvent);
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:FlatAccessibleMessageParser = _local_3.getParser();
            if (((!(_local_2 == null)) && ((_local_2.userName == null) || (_local_2.userName.length == 0))))
            {
                LegacyNavigator(_navigator.legacyNavigator).doorbell.hide();
            };
        }

        private function onRoomRating(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomRatingMessageParser = (_arg_1 as RoomRatingEvent).getParser();
            data.currentRoomRating = _local_2.rating;
            data.canRate = _local_2.canRate;
            LegacyNavigator(_navigator.legacyNavigator).roomInfoViewCtrl.reload();
        }

        private function onFlatAccessDenied(_arg_1:IMessageEvent):void
        {
            var _local_2:FlatAccessDeniedMessageParser = (_arg_1 as FlatAccessDeniedMessageEvent).getParser();
            if (((_local_2.userName == null) || (_local_2.userName == "")))
            {
                LegacyNavigator(_navigator.legacyNavigator).doorbell.showNoAnswer();
            };
        }

        private function onFriendsListFragment(_arg_1:IMessageEvent):void
        {
            data.friendList.onFriendsListFragment(_arg_1);
        }

        private function onFriendListUpdate(_arg_1:IMessageEvent):void
        {
            data.friendList.onFriendListUpdate(_arg_1);
            LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.onFriendListUpdate();
        }

        private function onCompetitionData(_arg_1:CompetitionRoomsDataMessageEvent):void
        {
            data.competitionRoomsData = _arg_1.getParser().data;
        }

        private function forwardToRoom(_arg_1:int):void
        {
            LegacyNavigator(_navigator.legacyNavigator).send(new GetGuestRoomMessageComposer(_arg_1, false, true));
            LegacyNavigator(_navigator.legacyNavigator).trackNavigationDataPoint("Room Forward", "go.roomforward", "", _arg_1);
        }

        private function onNoOwnedRoomsAlert(_arg_1:NoOwnedRoomsAlertMessageEvent):void
        {
            LegacyNavigator(_navigator.legacyNavigator).startRoomCreation();
        }

        private function closeOpenCantConnectAlerts():void
        {
            var _local_1:Array;
            var _local_7:IWindowContext;
            var _local_4:int;
            var _local_5:int;
            var _local_6:IWindow;
            var _local_3:AlertView;
            if (_navigator != null)
            {
                _local_1 = [];
                _local_7 = _navigator.windowManager.getWindowContext(2);
                _local_4 = _local_7.getDesktopWindow().numChildren;
                _local_5 = 0;
                while (_local_5 < _local_4)
                {
                    _local_6 = _local_7.getDesktopWindow().getChildAt(_local_5);
                    if (_local_6.tags.indexOf("SimpleAlertView") > -1)
                    {
                        _local_1.push(_local_6);
                    };
                    _local_5++;
                };
                if (_local_1.length > 0)
                {
                    for each (var _local_2:IWindow in _local_1)
                    {
                        _local_3 = AlertView.findAlertView(_local_2);
                        if (_local_3 != null)
                        {
                            _local_3.dispose();
                        };
                    };
                };
            };
        }

        private function onCantConnect(_arg_1:IMessageEvent):void
        {
            var _local_2:SimpleAlertView;
            var _local_3:CantConnectMessageParser = (_arg_1 as CantConnectMessageEvent).getParser();
            Logger.log(("FAILED TO CONNECT: REASON: " + _local_3.reason));
            switch (_local_3.reason)
            {
                case 1:
                    _local_2 = new SimpleAlertView(LegacyNavigator(_navigator.legacyNavigator), "${navigator.guestroomfull.title}", "${navigator.guestroomfull.text}");
                    _local_2.show();
                    break;
                case 3:
                    _local_2 = new SimpleAlertView(LegacyNavigator(_navigator.legacyNavigator), "${room.queue.error.title}", (("${room.queue.error." + _local_3.parameter) + "}"));
                    _local_2.show();
                    break;
                case 4:
                    _local_2 = new SimpleAlertView(LegacyNavigator(_navigator.legacyNavigator), "${navigator.banned.title}", "${navigator.banned.text}");
                    _local_2.show();
                    break;
                default:
                    _local_2 = new SimpleAlertView(LegacyNavigator(_navigator.legacyNavigator), "${room.queue.error.title}", "${room.queue.error.title}");
                    _local_2.show();
            };
            LegacyNavigator(_navigator.legacyNavigator).send(new _SafeStr_23());
            var _local_4:HabboToolbarEvent = new HabboToolbarEvent("HTE_TOOLBAR_CLICK");
            _local_4.iconId = "HTIE_ICON_RECEPTION";
            LegacyNavigator(_navigator.legacyNavigator).toolbar.events.dispatchEvent(_local_4);
        }


    }
}

