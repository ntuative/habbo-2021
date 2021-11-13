package com.sulake.habbo.navigator
{
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.communication.messages.parser.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.chat.RoomFilterSettingsMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2GameStartedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.CanCreateRoomEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.ShowEnforceRoomCategoryDialogEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.CanCreateRoomEventEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.CantConnectMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCreatedEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventCancelEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.CategoriesWithVisitorCountEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.BannedUsersFromRoomEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.FlatAccessibleMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomsEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomForwardMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FavouritesEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.NavigatorSettingsEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.UserFlatCatsEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsDataEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
    import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatAccessDeniedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsSaveErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerAddedEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.NoSuchFlatEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllersEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.ConvertedRoomIdEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.MuteAllInRoomEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListFragmentMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.PopularRoomTagsResultEvent;
    import com.sulake.habbo.communication.messages.parser.competition.NoOwnedRoomsAlertMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomRatingEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.DoorbellMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsSavedEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.CompetitionRoomsDataMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.UserEventCatsEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.UserUnbannedFromRoomEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.GenericErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomInfoUpdatedEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerRemovedEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FavouriteChangedEvent;
    import com.sulake.habbo.navigator.domain.NavigatorData;
    import com.sulake.habbo.communication.messages.parser.roomsettings.MuteAllInRoomParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetUserFlatCatsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator._SafeStr_53;
    import com.sulake.habbo.communication.messages.parser.navigator.CategoriesWithVisitorCountParser;
    import com.sulake.habbo.communication.messages.parser.navigator.OfficialRoomsMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultData;
    import com.sulake.habbo.communication.messages.incoming.navigator.PopularRoomTagsData;
    import com.sulake.habbo.communication.messages.parser.navigator.RoomEventMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.CanCreateRoomEventMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetGuestRoomMessageComposer;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.navigator.domain.RoomSessionTags;
    import com.sulake.habbo.communication.messages.parser.navigator.GetGuestRoomResultMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.FlatCreatedMessageParser;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.habbo.communication.messages.parser.users.ScrSendUserInfoMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomForwardMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.ConvertedRoomIdMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.NavigatorSettingsMessageParser;
    import com.sulake.habbo.configuration.enum.HabboComponentFlags;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer;
    import com.sulake.habbo.communication.messages.parser.navigator.UserFlatCatsMessageParser;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.RoomsTabPageDecorator;
    import com.sulake.habbo.communication.messages.parser.navigator.UserEventCatsMessageParser;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsDataMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.chat.RoomFilterSettingsMessageParser;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsErrorMessageParser;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSavedMessageParser;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSaveErrorMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.RoomInfoUpdatedMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.FavouritesMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.FavouriteChangedMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.CanCreateRoomMessageParser;
    import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllersMessageParser;
    import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllerAddedMessageParser;
    import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllerRemovedMessageParser;
    import com.sulake.habbo.communication.messages.parser.roomsettings.BannedUsersFromRoomParser;
    import com.sulake.habbo.communication.messages.parser.roomsettings.UserUnbannedFromRoomParser;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.FlatAccessibleMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.RoomRatingMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.FlatAccessDeniedMessageParser;
    import com.sulake.core.window.IWindowContext;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.parser.room.session.CantConnectMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.room.session._SafeStr_23;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.communication.messages.parser.roomsettings.ShowEnforceRoomCategoryDialogParser;

        public class IncomingMessages
    {

        private var _navigator:HabboNavigator;

        public function IncomingMessages(_arg_1:HabboNavigator)
        {
            _navigator = _arg_1;
            var _local_2:IHabboCommunicationManager = _navigator.communication;
            _local_2.addHabboConnectionMessageEvent(new CloseConnectionMessageEvent(onRoomExit));
            _local_2.addHabboConnectionMessageEvent(new RoomFilterSettingsMessageEvent(onRoomFilterSettings));
            _local_2.addHabboConnectionMessageEvent(new Game2GameStartedMessageEvent(onGameStarted));
            _local_2.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
            _local_2.addHabboConnectionMessageEvent(new CanCreateRoomEvent(onCanCreateRoom));
            _local_2.addHabboConnectionMessageEvent(new ShowEnforceRoomCategoryDialogEvent(onEnforceRoomCategorySelection));
            _local_2.addHabboConnectionMessageEvent(new CanCreateRoomEventEvent(onCanCreateRoomEventEvent));
            _local_2.addHabboConnectionMessageEvent(new CantConnectMessageEvent(onCantConnect));
            _local_2.addHabboConnectionMessageEvent(new RoomSettingsErrorEvent(onRoomSettingsError));
            _local_2.addHabboConnectionMessageEvent(new FlatCreatedEvent(onFlatCreated));
            _local_2.addHabboConnectionMessageEvent(new RoomEventCancelEvent(onRoomEventCancel));
            _local_2.addHabboConnectionMessageEvent(new GuestRoomSearchResultEvent(onGuestRoomSearchResult));
            _local_2.addHabboConnectionMessageEvent(new CategoriesWithVisitorCountEvent(onCategoriesWithUserCount));
            _local_2.addHabboConnectionMessageEvent(new BannedUsersFromRoomEvent(onBannedUsersFromRoom));
            _local_2.addHabboConnectionMessageEvent(new FlatAccessibleMessageEvent(onDoorOpened));
            _local_2.addHabboConnectionMessageEvent(new OfficialRoomsEvent(onOfficialRooms));
            _local_2.addHabboConnectionMessageEvent(new RoomForwardMessageEvent(onRoomForward));
            _local_2.addHabboConnectionMessageEvent(new FavouritesEvent(onFavourites));
            _local_2.addHabboConnectionMessageEvent(new NavigatorSettingsEvent(onNavigatorSettings));
            _local_2.addHabboConnectionMessageEvent(new UserFlatCatsEvent(onUserFlatCats));
            _local_2.addHabboConnectionMessageEvent(new RoomEventEvent(onRoomEventEvent));
            _local_2.addHabboConnectionMessageEvent(new RoomSettingsDataEvent(onRoomSettingsData));
            _local_2.addHabboConnectionMessageEvent(new FriendListUpdateEvent(onFriendListUpdate));
            _local_2.addHabboConnectionMessageEvent(new GetGuestRoomResultEvent(onRoomInfo));
            _local_2.addHabboConnectionMessageEvent(new ScrSendUserInfoEvent(onSubscriptionInfo));
            _local_2.addHabboConnectionMessageEvent(new FlatAccessDeniedMessageEvent(onFlatAccessDenied));
            _local_2.addHabboConnectionMessageEvent(new RoomSettingsSaveErrorEvent(onRoomSettingsSaveError));
            _local_2.addHabboConnectionMessageEvent(new FlatControllerAddedEvent(onFlatControllerAdded));
            _local_2.addHabboConnectionMessageEvent(new UserObjectEvent(onUserObject));
            _local_2.addHabboConnectionMessageEvent(new NoSuchFlatEvent(onNoSuchFlat));
            _local_2.addHabboConnectionMessageEvent(new UserRightsMessageEvent(onUserRights));
            _local_2.addHabboConnectionMessageEvent(new FlatControllersEvent(onFlatControllers));
            _local_2.addHabboConnectionMessageEvent(new ConvertedRoomIdEvent(onConvertedRoomId));
            _local_2.addHabboConnectionMessageEvent(new MuteAllInRoomEvent(onMuteAllEvent));
            _local_2.addHabboConnectionMessageEvent(new FriendListFragmentMessageEvent(onFriendsListFragment));
            _local_2.addHabboConnectionMessageEvent(new PopularRoomTagsResultEvent(onPopularRoomTagsResult));
            _local_2.addHabboConnectionMessageEvent(new NoOwnedRoomsAlertMessageEvent(onNoOwnedRoomsAlert));
            _local_2.addHabboConnectionMessageEvent(new RoomRatingEvent(onRoomRating));
            _local_2.addHabboConnectionMessageEvent(new DoorbellMessageEvent(onDoorbell));
            _local_2.addHabboConnectionMessageEvent(new RoomSettingsSavedEvent(onRoomSettingsSaved));
            _local_2.addHabboConnectionMessageEvent(new CompetitionRoomsDataMessageEvent(onCompetitionData));
            _local_2.addHabboConnectionMessageEvent(new UserEventCatsEvent(onUserEventCats));
            _local_2.addHabboConnectionMessageEvent(new UserUnbannedFromRoomEvent(onUserUnbannedFromRoom));
            _local_2.addHabboConnectionMessageEvent(new GenericErrorEvent(onError));
            _local_2.addHabboConnectionMessageEvent(new RoomInfoUpdatedEvent(onRoomInfoUpdated));
            _local_2.addHabboConnectionMessageEvent(new FlatControllerRemovedEvent(onFlatControllerRemoved));
            _local_2.addHabboConnectionMessageEvent(new FavouriteChangedEvent(onFavouriteChanged));
        }

        public function get data():NavigatorData
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
                if (_navigator.roomInfoViewCtrl != null)
                {
                    _navigator.roomInfoViewCtrl.refreshButtons(_navigator.data.enteredGuestRoom);
                };
            };
        }

        private function onNoSuchFlat(_arg_1:IMessageEvent):void
        {
        }

        private function onUserObject(_arg_1:IMessageEvent):void
        {
            var _local_2:UserObjectMessageParser = UserObjectEvent(_arg_1).getParser();
            data.avatarId = _local_2.id;
            _navigator.send(new GetUserFlatCatsMessageComposer());
            _navigator.send(new _SafeStr_53());
        }

        private function onUserRights(_arg_1:IMessageEvent):void
        {
            var _local_2:UserRightsMessageEvent = UserRightsMessageEvent(_arg_1);
            if (_local_2.securityLevel >= 5)
            {
                _navigator.data.eventMod = true;
            };
            if (_local_2.securityLevel >= 7)
            {
                _navigator.data.roomPicker = true;
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
            Logger.log(("Received GuestRoomSearch: " + data.guestRoomSearchResults.rooms.length));
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
            _navigator.roomEventInfoCtrl.refresh();
        }

        private function onRoomEventCancel(_arg_1:IMessageEvent):void
        {
            data.roomEventData = null;
            _navigator.roomEventInfoCtrl.refresh();
        }

        private function onCanCreateRoomEventEvent(_arg_1:IMessageEvent):void
        {
            var _local_3:SimpleAlertView;
            var _local_2:CanCreateRoomEventMessageParser = CanCreateRoomEventEvent(_arg_1).getParser();
            Logger.log(("CAN CREATE EVENT: " + _local_2.canCreateEvent));
            if (_local_2.canCreateEvent)
            {
                _navigator.roomEventViewCtrl.show();
            }
            else
            {
                _local_3 = new SimpleAlertView(_navigator, "${navigator.cannotcreateevent.title}", (("${navigator.cannotcreateevent.error." + _local_2.errorCode) + "}"));
                _local_3.show();
                Logger.log("Cannot create an event just now...");
            };
        }

        private function onRoomEnter(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomEntryInfoMessageParser = RoomEntryInfoMessageEvent(_arg_1).getParser();
            Logger.log("Navigator: entering room");
            data.onRoomEnter(_local_2);
            closeOpenCantConnectAlerts();
            _navigator.roomInfoViewCtrl.close();
            _navigator.send(new GetGuestRoomMessageComposer(_local_2.guestRoomId, true, false));
            Logger.log("Sent get guest room...");
            _navigator.roomEventInfoCtrl.refresh();
            _navigator.roomEventViewCtrl.close();
            _navigator.roomSettingsCtrl.close();
            _navigator.roomFilterCtrl.close();
            HabboWebTools.closeNews();
        }

        private function onRoomInfo(_arg_1:IMessageEvent):void
        {
            var _local_3:Boolean;
            var _local_4:RoomSessionTags;
            var _local_2:GetGuestRoomResultMessageParser = GetGuestRoomResultEvent(_arg_1).getParser();
            Logger.log(((("Got room info: " + _local_2.enterRoom) + ", ") + _local_2.roomForward));
            if (_local_2.enterRoom)
            {
                data.enteredRoom = _local_2.data;
                data.currentRoomIsStaffPick = _local_2.staffPick;
                _local_3 = (data.createdFlatId == _local_2.data.flatId);
                if (((!(_local_3)) && (_local_2.data.displayRoomEntryAd)))
                {
                    requestRoomEnterAd();
                };
                data.createdFlatId = 0;
                if (((!(data.enteredGuestRoom == null)) && (data.enteredGuestRoom.habboGroupId > 0)))
                {
                    _navigator.roomEventInfoCtrl.expanded = false;
                    _navigator.roomEventInfoCtrl.refresh();
                };
                _local_4 = _navigator.data.getAndResetSessionTags();
                if (_local_4 != null)
                {
                    _navigator.send(_local_4.getMsg());
                };
            }
            else
            {
                if (_local_2.roomForward)
                {
                    if (((_local_2.data.doorMode == 1) && ((!(_navigator.sessionData.userName == _local_2.data.ownerName)) && (_local_2.isGroupMember == false))))
                    {
                        _navigator.doorbell.show(_local_2.data);
                    }
                    else
                    {
                        if (((_local_2.data.doorMode == 2) && ((!(_navigator.sessionData.userName == _local_2.data.ownerName)) && (_local_2.isGroupMember == false))))
                        {
                            _navigator.passwordInput.show(_local_2.data);
                        }
                        else
                        {
                            if (((((_local_2.data.doorMode == 4) && (!(_navigator.sessionData.isAmbassador))) && (!(_navigator.sessionData.isRealNoob))) && (!(_navigator.sessionData.isAnyRoomController))))
                            {
                                return;
                            };
                            _navigator.goToRoom(_local_2.data.flatId, false);
                        };
                    };
                }
                else
                {
                    data.enteredRoom = _local_2.data;
                    data.currentRoomIsStaffPick = _local_2.staffPick;
                    _navigator.roomInfoViewCtrl.reload();
                };
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
            _navigator.goToRoom(_local_2.flatId, true);
            _navigator.mainViewCtrl.reloadRoomList(5);
            _navigator.goToMainView();
            _navigator.closeNavigator();
        }

        private function onGameStarted(_arg_1:IMessageEvent):void
        {
            _navigator.mainViewCtrl.close();
        }

        private function onSubscriptionInfo(_arg_1:IMessageEvent):void
        {
            var _local_2:ScrSendUserInfoMessageParser = ScrSendUserInfoEvent(_arg_1).getParser();
            Logger.log(((((((((("Got subscription info: " + _local_2.productName) + ", ") + _local_2.daysToPeriodEnd) + ", ") + _local_2.memberPeriods) + ", ") + _local_2.periodsSubscribedAhead) + ", ") + _local_2.responseType));
            data.hcMember = (_local_2.daysToPeriodEnd > 0);
        }

        private function onRoomForward(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomForwardMessageParser = RoomForwardMessageEvent(_arg_1).getParser();
            Logger.log(("Got room forward: " + _local_2.roomId));
            forwardToRoom(_local_2.roomId);
        }

        private function onConvertedRoomId(_arg_1:IMessageEvent):void
        {
            var _local_2:ConvertedRoomIdMessageParser = ConvertedRoomIdEvent(_arg_1).getParser();
            if (_navigator.webRoomReport)
            {
                _navigator.habboHelp.reportRoom(_local_2.convertedId, _navigator.webRoomReportedName, "");
            }
            else
            {
                Logger.log(((("Got converted room ID for " + _local_2.globalId) + ", forward to room ") + _local_2.convertedId));
                forwardToRoom(_local_2.convertedId);
            };
        }

        private function onNavigatorSettings(_arg_1:IMessageEvent):void
        {
            var _local_6:Boolean;
            var _local_4:Boolean;
            var _local_7:int;
            var _local_5:Boolean;
            var _local_2:NavigatorSettingsMessageParser = NavigatorSettingsEvent(_arg_1).getParser();
            Logger.log(("Got navigator settings: " + _local_2.homeRoomId));
            var _local_3:Boolean = (!(_navigator.data.settingsReceived));
            _navigator.data.homeRoomId = _local_2.homeRoomId;
            _navigator.data.settingsReceived = true;
            _navigator.mainViewCtrl.refresh();
            var _local_8:int = -1;
            var _local_9:int = -1;
            if (((_local_3) && (!(HabboComponentFlags.isRoomViewerMode(_navigator.flags)))))
            {
                _local_6 = false;
                _local_4 = false;
                if (_navigator.propertyExists("friend.id"))
                {
                    _local_8 = 0;
                    _navigator.send(new FollowFriendMessageComposer(int(_navigator.getProperty("friend.id"))));
                };
                if (((_navigator.propertyExists("forward.type")) && (_navigator.propertyExists("forward.id"))))
                {
                    _local_8 = int(_navigator.getProperty("forward.type"));
                    _local_9 = int(_navigator.getProperty("forward.id"));
                };
                _local_4 = (_local_2.roomIdToEnter <= 0);
                if (_local_8 == 2)
                {
                    Logger.log(("Guest room forward on enter: " + _local_9));
                    forwardToRoom(_local_9);
                }
                else
                {
                    if (_local_8 == -1)
                    {
                        if (!_local_4)
                        {
                            _local_7 = _local_2.roomIdToEnter;
                            if (_local_7 != _navigator.data.homeRoomId)
                            {
                                this._navigator.goToRoom(_local_7, true);
                            }
                            else
                            {
                                _local_5 = this._navigator.goToHomeRoom();
                                if (!_local_5)
                                {
                                    _local_6 = true;
                                };
                            };
                        };
                    };
                };
                if (((_local_6) && (!(_navigator.mainViewCtrl.isOpen()))))
                {
                    _navigator.mainViewCtrl.onNavigatorToolBarIconClick();
                };
            }
            else
            {
                _navigator.roomInfoViewCtrl.reload();
            };
        }

        private function onRoomExit(_arg_1:IMessageEvent):void
        {
            Logger.log("Navigator: exiting room");
            data.onRoomExit();
            _navigator.roomInfoViewCtrl.close();
            _navigator.roomEventInfoCtrl.close();
            _navigator.roomEventViewCtrl.close();
            _navigator.roomSettingsCtrl.close();
            _navigator.roomFilterCtrl.close();
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
            var _local_2:RoomsTabPageDecorator = RoomsTabPageDecorator(_navigator.tabs.getTab(2).tabPageDecorator);
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
                _navigator.roomSettingsCtrl.onRoomSettings(_local_2.data);
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
            _navigator.roomFilterCtrl.onRoomFilterSettings(_local_2.badWords);
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
            _navigator.mainViewCtrl.reloadRoomList(5);
        }

        private function onRoomSettingsSaveError(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomSettingsSaveErrorMessageParser = (_arg_1 as RoomSettingsSaveErrorEvent).getParser();
            _navigator.roomSettingsCtrl.onRoomSettingsSaveError(_local_2.roomId, _local_2.errorCode, _local_2.info);
        }

        private function onRoomInfoUpdated(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomInfoUpdatedMessageParser = (_arg_1 as RoomInfoUpdatedEvent).getParser();
            Logger.log(("ROOM UPDATED: " + _local_2.flatId));
            _navigator.send(new GetGuestRoomMessageComposer(_local_2.flatId, false, false));
        }

        private function onFavourites(_arg_1:IMessageEvent):void
        {
            var _local_2:FavouritesMessageParser = (_arg_1 as FavouritesEvent).getParser();
            _navigator.data.onFavourites(_local_2);
        }

        private function onFavouriteChanged(_arg_1:IMessageEvent):void
        {
            var _local_2:FavouriteChangedMessageParser = (_arg_1 as FavouriteChangedEvent).getParser();
            Logger.log(((("Received favourite changed: " + _local_2.flatId) + ", ") + _local_2.added));
            _navigator.data.favouriteChanged(_local_2.flatId, _local_2.added);
            _navigator.roomInfoViewCtrl.reload();
            _navigator.mainViewCtrl.refresh();
        }

        private function onCanCreateRoom(_arg_1:IMessageEvent):void
        {
            var _local_2:AlertView;
            var _local_3:CanCreateRoomMessageParser = (_arg_1 as CanCreateRoomEvent).getParser();
            Logger.log(((("Can create room: " + _local_3.resultCode) + ", ") + _local_3.roomLimit));
            if (_local_3.resultCode == 0)
            {
                _navigator.roomCreateViewCtrl.show();
            }
            else
            {
                _navigator.registerParameter("navigator.createroom.limitreached", "limit", ("" + _local_3.roomLimit));
                if (_navigator.sessionData.hasVip)
                {
                    _local_2 = new SimpleAlertView(_navigator, "${navigator.createroom.error}", "${navigator.createroom.limitreached}");
                }
                else
                {
                    _local_2 = new ClubPromoAlertView(_navigator, "${navigator.createroom.error}", "${navigator.createroom.limitreached}", "${navigator.createroom.vippromo}");
                };
                _local_2.show();
            };
        }

        private function onFlatControllers(_arg_1:IMessageEvent):void
        {
            var _local_2:FlatControllersMessageParser = (_arg_1 as FlatControllersEvent).getParser();
            Logger.log(((("Got flat controllers: " + _local_2.roomId) + ", ") + _local_2.controllers.length));
            _navigator.roomSettingsCtrl.onFlatControllers(_local_2.roomId, _local_2.controllers);
        }

        private function onFlatControllerAdded(_arg_1:IMessageEvent):void
        {
            var _local_2:FlatControllerAddedMessageParser = (_arg_1 as FlatControllerAddedEvent).getParser();
            Logger.log(((((("Flat controller added: " + _local_2.flatId) + ", ") + _local_2.data.userId) + ", ") + _local_2.data.userName));
            _navigator.roomSettingsCtrl.onFlatControllerAdded(_local_2.flatId, _local_2.data);
        }

        private function onFlatControllerRemoved(_arg_1:IMessageEvent):void
        {
            var _local_2:FlatControllerRemovedMessageParser = (_arg_1 as FlatControllerRemovedEvent).getParser();
            Logger.log(((("Flat controller removed: " + _local_2.flatId) + ", ") + _local_2.userId));
            _navigator.roomSettingsCtrl.onFlatControllerRemoved(_local_2.flatId, _local_2.userId);
        }

        private function onBannedUsersFromRoom(_arg_1:IMessageEvent):void
        {
            var _local_2:BannedUsersFromRoomParser = (_arg_1 as BannedUsersFromRoomEvent).getParser();
            Logger.log(((("Got Banned users for room: " + _local_2.roomId) + ", ") + _local_2.bannedUsers.length));
            _navigator.roomSettingsCtrl.onBannedUsersFromRoom(_local_2.roomId, _local_2.bannedUsers);
        }

        private function onUserUnbannedFromRoom(_arg_1:IMessageEvent):void
        {
            var _local_2:UserUnbannedFromRoomParser = (_arg_1 as UserUnbannedFromRoomEvent).getParser();
            Logger.log(((("User was unbanned from room. User Id: " + _local_2.userId) + " Room Id: ") + _local_2.roomId));
            _navigator.roomSettingsCtrl.onUserUnbannedFromRoom(_local_2.roomId, _local_2.userId);
        }

        private function onError(_arg_1:IMessageEvent):void
        {
            var event:IMessageEvent = _arg_1;
            var error:GenericErrorEvent = (event as GenericErrorEvent);
            if (error == null)
            {
                return;
            };
            switch (error.getParser().errorCode)
            {
                case -100002:
                    _navigator.passwordInput.showRetry();
                    return;
                case 4009:
                    _navigator.windowManager.alert("${generic.alert.title}", "${navigator.alert.need.to.be.vip}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                    {
                        _arg_1.dispose();
                    });
                    return;
                case 4010:
                    _navigator.windowManager.alert("${generic.alert.title}", "${navigator.alert.invalid_room_name}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                    {
                        _arg_1.dispose();
                    });
                    return;
                case 4011:
                    _navigator.windowManager.alert("${generic.alert.title}", "${navigator.alert.cannot_perm_ban}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                    {
                        _arg_1.dispose();
                    });
                    return;
                case 4013:
                    _navigator.windowManager.alert("${generic.alert.title}", "${navigator.alert.room_in_maintenance}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                    {
                        _arg_1.dispose();
                    });
                    return;
            };
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
            _navigator.doorbell.showWaiting();
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
                _navigator.doorbell.hide();
            };
        }

        private function onRoomRating(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomRatingMessageParser = (_arg_1 as RoomRatingEvent).getParser();
            _navigator.data.currentRoomRating = _local_2.rating;
            _navigator.data.canRate = _local_2.canRate;
            this._navigator.roomInfoViewCtrl.reload();
        }

        private function onFlatAccessDenied(_arg_1:IMessageEvent):void
        {
            var _local_2:FlatAccessDeniedMessageParser = (_arg_1 as FlatAccessDeniedMessageEvent).getParser();
            if (((_local_2.userName == null) || (_local_2.userName == "")))
            {
                _navigator.doorbell.showNoAnswer();
            };
        }

        private function onFriendsListFragment(_arg_1:IMessageEvent):void
        {
            _navigator.data.friendList.onFriendsListFragment(_arg_1);
        }

        private function onFriendListUpdate(_arg_1:IMessageEvent):void
        {
            _navigator.data.friendList.onFriendListUpdate(_arg_1);
            _navigator.roomSettingsCtrl.onFriendListUpdate();
        }

        private function onCompetitionData(_arg_1:CompetitionRoomsDataMessageEvent):void
        {
            _navigator.data.competitionRoomsData = _arg_1.getParser().data;
        }

        private function forwardToRoom(_arg_1:int):void
        {
            _navigator.send(new GetGuestRoomMessageComposer(_arg_1, false, true));
            _navigator.trackNavigationDataPoint("Room Forward", "go.roomforward", "", _arg_1);
        }

        private function onNoOwnedRoomsAlert(_arg_1:NoOwnedRoomsAlertMessageEvent):void
        {
            _navigator.startRoomCreation();
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
                    _local_2 = new SimpleAlertView(_navigator, "${navigator.guestroomfull.title}", "${navigator.guestroomfull.text}");
                    _local_2.show();
                    break;
                case 3:
                    _local_2 = new SimpleAlertView(_navigator, "${room.queue.error.title}", (("${room.queue.error." + _local_3.parameter) + "}"));
                    _local_2.show();
                    break;
                case 4:
                    _local_2 = new SimpleAlertView(_navigator, "${navigator.banned.title}", "${navigator.banned.text}");
                    _local_2.show();
                    break;
                default:
                    _local_2 = new SimpleAlertView(_navigator, "${room.queue.error.title}", "${room.queue.error.title}");
                    _local_2.show();
            };
            _navigator.send(new _SafeStr_23());
            var _local_4:HabboToolbarEvent = new HabboToolbarEvent("HTE_TOOLBAR_CLICK");
            _local_4.iconId = "HTIE_ICON_RECEPTION";
            _navigator.toolbar.events.dispatchEvent(_local_4);
        }

        private function onEnforceRoomCategorySelection(_arg_1:IMessageEvent):void
        {
            var _local_2:ShowEnforceRoomCategoryDialogParser = (_arg_1 as ShowEnforceRoomCategoryDialogEvent).getParser();
            _navigator.enforceCategoryCtrl.show(_local_2.selectionType);
        }


    }
}