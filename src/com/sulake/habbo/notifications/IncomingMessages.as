package com.sulake.habbo.notifications
{
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.InfoFeedEnableMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.RespectNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.NotificationDialogMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetReceivedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.AccountSafetyLockStatusChangeMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.ClubGiftNotificationEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorMessageEvent;
    import com.sulake.habbo.communication.messages.parser.availability.LoginFailedHotelClosedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.MOTDNotificationEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorCautionEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.RestoreClientMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.parser.availability.InfoHotelClosedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.PetLevelNotificationEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetRespectFailedEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.UserBannedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftSelectedEvent;
    import com.sulake.habbo.communication.messages.parser.availability.InfoHotelClosingMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboActivityPointNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.parser.availability.MaintenanceStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboBroadcastMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RoomMessageNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.OpenConnectionMessageEvent;
    import com.sulake.habbo.notifications.feed.data.GenericNotificationItemData;
    import com.sulake.habbo.communication.messages.parser.notifications.MOTDNotificationParser;
    import com.sulake.habbo.notifications.singular.MOTDNotification;
    import flash.utils.getTimer;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementNotificationMessageParser;
    import flash.display.BitmapData;
    import com.sulake.core.localization.ILocalization;
    import com.sulake.habbo.communication.messages.parser.room.furniture.RoomMessageNotificationMessageParser;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.communication.messages.parser.moderation.ModerationCautionParser;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.UserBannedMessageParser;
    import com.sulake.habbo.communication.messages.parser.availability.InfoHotelClosingMessageParser;
    import com.sulake.habbo.communication.messages.parser.availability.MaintenanceStatusMessageParser;
    import com.sulake.habbo.communication.messages.parser.availability.InfoHotelClosedMessageParser;
    import com.sulake.habbo.communication.messages.parser.availability.LoginFailedHotelClosedMessageParser;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetFigureData;
    import com.sulake.habbo.communication.messages.parser.notifications.PetLevelNotificationParser;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetData;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetReceivedMessageParser;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboBroadcastMessageParser;
    import com.sulake.habbo.communication.messages.parser.notifications.NotificationDialogMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetRespectFailedParser;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.ClubGiftNotificationParser;
    import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
    import com.sulake.habbo.communication.messages.parser.users.AccountSafetyLockStatusChangeMessageParser;
    import com.sulake.habbo.communication.messages.parser.catalog.ClubGiftSelectedParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageProductData;

        public class IncomingMessages
    {

        private const CALL_FOR_HELP_NOTIFICATION_TYPE:String = "cfh.created";

        private var _notifications:HabboNotifications;
        private var _communication:IHabboCommunicationManager;
        private var _messageEvents:Vector.<IMessageEvent>;

        public function IncomingMessages(_arg_1:HabboNotifications, _arg_2:IHabboCommunicationManager)
        {
            _notifications = _arg_1;
            _communication = _arg_2;
            _messageEvents = new Vector.<IMessageEvent>(0);
            addMessageEvent(new InfoFeedEnableMessageEvent(onInfoFeedEnable));
            addMessageEvent(new RespectNotificationMessageEvent(onRespectNotification));
            addMessageEvent(new NotificationDialogMessageEvent(onNotificationDialogMessageEvent));
            addMessageEvent(new PetReceivedMessageEvent(onPetReceived));
            addMessageEvent(new AccountSafetyLockStatusChangeMessageEvent(onAccountSafetyLockStatusChanged));
            addMessageEvent(new ClubGiftNotificationEvent(onClubGiftNotification));
            addMessageEvent(new ModeratorMessageEvent(onModMessageEvent));
            addMessageEvent(new LoginFailedHotelClosedMessageEvent(onLoginFailedHotelClosed));
            addMessageEvent(new MOTDNotificationEvent(onMOTD));
            addMessageEvent(new ModeratorCautionEvent(onModCautionEvent));
            addMessageEvent(new RestoreClientMessageEvent(onRestoreClientMessageEvent));
            addMessageEvent(new HabboAchievementNotificationMessageEvent(onLevelUp));
            addMessageEvent(new InfoHotelClosedMessageEvent(onHotelClosed));
            addMessageEvent(new PetLevelNotificationEvent(onPetLevelNotification));
            addMessageEvent(new PetRespectFailedEvent(onPetRespectFailed));
            addMessageEvent(new UserBannedMessageEvent(onUserBannedMessageEvent));
            addMessageEvent(new ClubGiftSelectedEvent(onClubGiftSelected));
            addMessageEvent(new InfoHotelClosingMessageEvent(onHotelClosing));
            addMessageEvent(new HabboActivityPointNotificationMessageEvent(onActivityPointNotification));
            addMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
            addMessageEvent(new MaintenanceStatusMessageEvent(onHotelMaintenance));
            addMessageEvent(new UserObjectEvent(onUserObject));
            addMessageEvent(new HabboBroadcastMessageEvent(onBroadcastMessageEvent));
            addMessageEvent(new RoomMessageNotificationMessageEvent(onRoomMessagesNotification));
            addMessageEvent(new OpenConnectionMessageEvent(onRoomEnter));
            _notifications.activate();
        }

        private function addMessageEvent(_arg_1:IMessageEvent):void
        {
            _messageEvents.push(_communication.addHabboConnectionMessageEvent(_arg_1));
        }

        public function dispose():void
        {
            if (((!(_messageEvents == null)) && (!(_communication == null))))
            {
                for each (var _local_1:IMessageEvent in _messageEvents)
                {
                    _communication.removeHabboConnectionMessageEvent(_local_1);
                };
            };
            _messageEvents = null;
            _notifications = null;
            _communication = null;
        }

        private function useNotificationFeed():Boolean
        {
            return (_notifications.getBoolean("notification.feed.enabled"));
        }

        private function useNotifications():Boolean
        {
            return (_notifications.getBoolean("notification.items.enabled"));
        }

        internal function onMOTD(_arg_1:IMessageEvent):void
        {
            var _local_4:GenericNotificationItemData;
            var _local_5:MOTDNotificationEvent = (_arg_1 as MOTDNotificationEvent);
            var _local_3:MOTDNotificationParser = (_local_5.getParser() as MOTDNotificationParser);
            if (((_local_3.messages) && (_local_3.messages.length > 0)))
            {
                if (useNotifications())
                {
                    new MOTDNotification(_local_3.messages, _notifications.assetLibrary, _notifications.windowManager);
                };
                if (useNotificationFeed())
                {
                    for each (var _local_2:String in _local_3.messages)
                    {
                        _local_4 = new GenericNotificationItemData();
                        _local_4.title = _local_2;
                        _local_4.timeStamp = getTimer();
                        _notifications.feedController.addFeedItem(3, _local_4);
                    };
                };
            };
        }

        private function onLevelUp(_arg_1:IMessageEvent):void
        {
            var _local_2:HabboAchievementNotificationMessageEvent = (_arg_1 as HabboAchievementNotificationMessageEvent);
            var _local_3:HabboAchievementNotificationMessageParser = _local_2.getParser();
            var _local_4:String = _notifications.localization.getLocalization("achievements.levelup.desc", "");
            var _local_6:String = _notifications.localization.getBadgeName(_local_3.data.badgeCode);
            var _local_5:BitmapData = _notifications.sessionDataManager.requestBadgeImage(_local_3.data.badgeCode);
            _notifications.singularController.addItem(((_local_4 + " ") + _local_6), "achievement", _local_5, null, _local_3.data.badgeCode, ("questengine/achievements/" + _local_3.data.category));
        }

        internal function onRespectNotification(_arg_1:IMessageEvent):void
        {
            var _local_4:ILocalization;
            var _local_2:ILocalization;
            var _local_3:RespectNotificationMessageEvent = (_arg_1 as RespectNotificationMessageEvent);
            if (_notifications.sessionDataManager.userId == _local_3.userId)
            {
                _notifications.localization.registerParameter("notifications.text.respect.2", "count", String(_local_3.respectTotal));
                _local_4 = _notifications.localization.getLocalizationRaw("notifications.text.respect.1");
                _local_2 = _notifications.localization.getLocalizationRaw("notifications.text.respect.2");
                if (_local_4)
                {
                    _notifications.singularController.addItem(_local_4.value, "respect", null);
                };
                if (_local_2)
                {
                    _notifications.singularController.addItem(_local_2.value, "respect", null);
                };
            };
        }

        private function onRoomMessagesNotification(_arg_1:RoomMessageNotificationMessageEvent):void
        {
            var _local_2:ILocalization;
            var _local_3:RoomMessageNotificationMessageParser = _arg_1.getParser();
            var _local_5:String = "roommessagesposted";
            _notifications.localization.registerParameter("notifications.text.room.messages.posted", "room_name", _local_3.roomName);
            _notifications.localization.registerParameter("notifications.text.room.messages.posted", "messages_count", _local_3.messageCount.toString());
            _local_2 = _notifications.localization.getLocalizationRaw("notifications.text.room.messages.posted");
            var _local_6:BitmapDataAsset = (_notifications.assets.getAssetByName("if_icon_temp_png") as BitmapDataAsset);
            var _local_4:BitmapData = (_local_6.content as BitmapData);
            if (_local_2)
            {
                _notifications.singularController.addItem(_local_2.value, _local_5, _local_4.clone());
            };
        }

        private function onInfoFeedEnable(_arg_1:IMessageEvent):void
        {
            var _local_2:InfoFeedEnableMessageEvent = (_arg_1 as InfoFeedEnableMessageEvent);
            if (_local_2 != null)
            {
                _notifications.disabled = (!(_local_2.enabled));
            };
        }

        private function onModCautionEvent(_arg_1:IMessageEvent):void
        {
            var _local_3:GenericNotificationItemData;
            var _local_2:ModerationCautionParser = (_arg_1 as ModeratorCautionEvent).getParser();
            if (((_local_2 == null) || (_notifications.singularController.alertDialogManager == null)))
            {
                return;
            };
            if (useNotifications())
            {
                _notifications.singularController.alertDialogManager.handleModeratorCaution(_local_2.message, _local_2.url);
            };
            if (useNotificationFeed())
            {
                _local_3 = new GenericNotificationItemData();
                _local_3.title = _local_2.message;
                _local_3.buttonAction = _local_2.url;
                _local_3.buttonCaption = _local_2.url;
                _local_3.timeStamp = getTimer();
                _notifications.feedController.addFeedItem(3, _local_3);
            };
        }

        private function onModMessageEvent(_arg_1:IMessageEvent):void
        {
            var _local_3:GenericNotificationItemData;
            var _local_2:ModeratorMessageParser = (_arg_1 as ModeratorMessageEvent).getParser();
            if (((_local_2 == null) || (_notifications.singularController.alertDialogManager == null)))
            {
                return;
            };
            if (useNotifications())
            {
                _notifications.singularController.alertDialogManager.handleModeratorMessage(_local_2.message, _local_2.url);
            };
            if (useNotificationFeed())
            {
                _local_3 = new GenericNotificationItemData();
                _local_3.title = _local_2.message;
                _local_3.buttonAction = _local_2.url;
                _local_3.buttonCaption = _local_2.url;
                _local_3.timeStamp = getTimer();
                _notifications.feedController.addFeedItem(3, _local_3);
            };
        }

        private function onUserBannedMessageEvent(_arg_1:IMessageEvent):void
        {
            var _local_2:UserBannedMessageParser = (_arg_1 as UserBannedMessageEvent).getParser();
            if (((_local_2 == null) || (_notifications.singularController.alertDialogManager == null)))
            {
                return;
            };
            _notifications.singularController.alertDialogManager.handleUserBannedMessage(_local_2.message);
        }

        private function onHotelClosing(_arg_1:IMessageEvent):void
        {
            var _local_2:InfoHotelClosingMessageParser = (_arg_1 as InfoHotelClosingMessageEvent).getParser();
            if (((_local_2 == null) || (_notifications.singularController.alertDialogManager == null)))
            {
                return;
            };
            _notifications.singularController.alertDialogManager.handleHotelClosingMessage(_local_2.minutesUntilClosing);
        }

        private function onHotelMaintenance(_arg_1:IMessageEvent):void
        {
            var _local_2:MaintenanceStatusMessageParser = (_arg_1 as MaintenanceStatusMessageEvent).getParser();
            if (((_local_2 == null) || (_notifications.singularController.alertDialogManager == null)))
            {
                return;
            };
            _notifications.singularController.alertDialogManager.handleHotelMaintenanceMessage(_local_2.minutesUntilMaintenance, _local_2.duration);
        }

        private function onHotelClosed(_arg_1:IMessageEvent):void
        {
            var _local_2:InfoHotelClosedMessageParser = (_arg_1 as InfoHotelClosedMessageEvent).getParser();
            if (((_local_2 == null) || (_notifications.singularController.alertDialogManager == null)))
            {
                return;
            };
            _notifications.singularController.alertDialogManager.handleHotelClosedMessage(_local_2.openHour, _local_2.openMinute, _local_2.userThrownOutAtClose);
        }

        private function onLoginFailedHotelClosed(_arg_1:IMessageEvent):void
        {
            var _local_2:LoginFailedHotelClosedMessageParser = (_arg_1 as LoginFailedHotelClosedMessageEvent).getParser();
            if (((_local_2 == null) || (_notifications.singularController.alertDialogManager == null)))
            {
                return;
            };
            _notifications.singularController.alertDialogManager.handleLoginFailedHotelClosedMessage(_local_2.openHour, _local_2.openMinute);
        }

        private function onRestoreClientMessageEvent(_arg_1:IMessageEvent):void
        {
            HabboWebTools.closeWebPageAndRestoreClient();
        }

        private function onPetLevelNotification(_arg_1:PetLevelNotificationEvent):void
        {
            var _local_2:PetFigureData;
            var _local_5:BitmapData;
            if (_arg_1 == null)
            {
                return;
            };
            var _local_4:PetLevelNotificationParser = _arg_1.getParser();
            _notifications.localization.registerParameter("notifications.text.petlevel", "pet_name", _local_4.petName);
            _notifications.localization.registerParameter("notifications.text.petlevel", "level", _local_4.level.toString());
            var _local_3:ILocalization = _notifications.localization.getLocalizationRaw("notifications.text.petlevel");
            if (_local_3)
            {
                _local_2 = _local_4.figureData;
                _local_5 = _notifications.petImageUtility.getPetImage(_local_2.typeId, _local_2.paletteId, _local_2.color);
                _notifications.singularController.addItem(_local_3.value, "petlevel", _local_5);
            };
        }

        private function onPetReceived(_arg_1:PetReceivedMessageEvent):void
        {
            var _local_2:ILocalization;
            var _local_4:PetData;
            var _local_5:BitmapData;
            if (_arg_1 == null)
            {
                return;
            };
            var _local_3:PetReceivedMessageParser = _arg_1.getParser();
            if (_local_3.boughtAsGift)
            {
                _local_2 = _notifications.localization.getLocalizationRaw("notifications.text.petbought");
            }
            else
            {
                _local_2 = _notifications.localization.getLocalizationRaw("notifications.text.petreceived");
            };
            if (_local_2)
            {
                _local_4 = _local_3.pet;
                _local_5 = _notifications.petImageUtility.getPetImage(_local_4.typeId, _local_4.paletteId, _local_4.color);
                _notifications.singularController.addItem(_local_2.value, "petlevel", _local_5);
            };
        }

        private function onRoomEnter(_arg_1:IMessageEvent):void
        {
            _notifications.singularController.showModerationDisclaimer();
        }

        private function onBroadcastMessageEvent(_arg_1:IMessageEvent):void
        {
            var _local_4:HabboBroadcastMessageParser = (_arg_1 as HabboBroadcastMessageEvent).getParser();
            var _local_2:String = _local_4.messageText;
            var _local_3:RegExp = /\\r/g;
            _local_2 = _local_2.replace(_local_3, "\r");
            _notifications.windowManager.simpleAlert("${notifications.broadcast.title}", "", _local_2, "", "", null, "illumina_alert_illustrations_frank_neutral_png");
        }

        private function onNotificationDialogMessageEvent(_arg_1:NotificationDialogMessageEvent):void
        {
            var _local_2:NotificationDialogMessageParser = _arg_1.getParser();
            if ("cfh.created" == _local_2.type)
            {
                showCallCreatedNotification(_local_2.parameters["message"], _local_2.parameters["linkUrl"]);
            }
            else
            {
                _notifications.showNotification(_local_2.type, _local_2.parameters);
            };
        }

        private function showCallCreatedNotification(_arg_1:String, _arg_2:String):void
        {
            var _local_3:String = _arg_1.replace(/\\r/g, "\r");
            if (_arg_2 != null)
            {
                _notifications.windowManager.simpleAlert("${help.cfh.sent.title}", "", _local_3, "${help.main.faq.link.text}", _arg_2, null, "illumina_alert_illustrations_frank_neutral_png");
            }
            else
            {
                _notifications.windowManager.simpleAlert("${help.cfh.sent.title}", "", _local_3, null, null, null, "illumina_alert_illustrations_frank_neutral_png");
            };
        }

        private function onPetRespectFailed(_arg_1:IMessageEvent):void
        {
            var _local_2:PetRespectFailedParser = (_arg_1 as PetRespectFailedEvent).getParser();
            this._notifications.localization.registerParameter("room.error.pets.respectfailed", "required_age", ("" + _local_2.requiredDays));
            this._notifications.localization.registerParameter("room.error.pets.respectfailed", "avatar_age", ("" + _local_2.avatarAgeInDays));
            _notifications.windowManager.alert("${error.title}", "${room.error.pets.respectfailed}", 0, onAlert);
        }

        public function onAlert(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            if (((_arg_2.type == "WE_OK") || (_arg_2.type == "WE_CANCEL")))
            {
                _arg_1.dispose();
            };
        }

        private function onClubGiftNotification(_arg_1:ClubGiftNotificationEvent):void
        {
            if (!_arg_1)
            {
                return;
            };
            var _local_2:ClubGiftNotificationParser = _arg_1.getParser();
            if (!_local_2)
            {
                return;
            };
            if (_local_2.numGifts < 1)
            {
                return;
            };
            _notifications.singularController.showClubGiftNotification(_local_2.numGifts);
        }

        private function onUserObject(_arg_1:UserObjectEvent):void
        {
            var _local_2:UserObjectMessageParser = _arg_1.getParser();
            if (_local_2.accountSafetyLocked)
            {
                _notifications.singularController.showSafetyLockedNotification(_local_2.id);
            };
        }

        private function onAccountSafetyLockStatusChanged(_arg_1:AccountSafetyLockStatusChangeMessageEvent):void
        {
            var _local_2:AccountSafetyLockStatusChangeMessageParser = _arg_1.getParser();
            if (_local_2.status == 1)
            {
                _notifications.singularController.hideSafetyLockedNotification();
            };
        }

        private function onClubGiftSelected(_arg_1:ClubGiftSelectedEvent):void
        {
            if (((!(_arg_1)) || (!(_notifications.localization))))
            {
                return;
            };
            var _local_3:ClubGiftSelectedParser = _arg_1.getParser();
            if (!_local_3)
            {
                return;
            };
            var _local_6:Array = _local_3.products;
            if (((!(_local_6)) || (_local_6.length == 0)))
            {
                return;
            };
            var _local_2:CatalogPageMessageProductData = (_local_6[0] as CatalogPageMessageProductData);
            if (!_local_2)
            {
                return;
            };
            var _local_5:String = _notifications.localization.getLocalization("notifications.text.club_gift.received");
            var _local_4:BitmapData = _notifications.productImageUtility.getProductImage(_local_2.productType, _local_2.furniClassId, _local_2.extraParam);
            _notifications.singularController.addItem(_local_5, "info", _local_4);
        }

        private function onActivityPointNotification(_arg_1:HabboActivityPointNotificationMessageEvent):void
        {
            var _local_3:String;
            var _local_2:BitmapData;
            if (_arg_1.change <= 0)
            {
                return;
            };
            switch (_arg_1.type)
            {
                case 5:
                    _local_3 = _notifications.localization.getLocalizationWithParams("notifications.text.loyalty.received", "", "amount", _arg_1.change);
                    _local_2 = (_notifications.assets.getAssetByName("if_icon_diamond_png").content as BitmapData);
                    break;
                default:
                    return;
            };
            _notifications.singularController.addItem(_local_3, "info", _local_2.clone());
        }


    }
}
