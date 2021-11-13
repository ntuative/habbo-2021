package com.sulake.habbo.notifications.singular
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.notifications.HabboNotifications;
    import com.sulake.core.utils.Map;
    import flash.utils.Dictionary;
    import flash.utils.Timer;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.utils.XMLVariableParser;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.localization.ILocalization;
    import flash.events.TimerEvent;
    import com.sulake.room.utils.RoomEnterEffect;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;

    public class SingularNotificationController implements IUpdateReceiver 
    {

        private static const MODERATION_DISCLAIMER_DELAY_MS:int = 5000;

        private var _notifications:HabboNotifications;
        private var _SafeStr_3036:Array;
        private var _styleConfiguration:Map;
        private var _SafeStr_3037:HabboNotificationViewManager;
        private var _alertDialogManager:HabboAlertDialogManager;
        private var _SafeStr_3038:Boolean;
        private var _clubGiftNotification:ClubGiftNotification;
        private var _safetyLockedNotification:SafetyLockedNotification;
        private var _SafeStr_3039:Dictionary;
        private var _SafeStr_3040:Timer;
        private var _disposed:Boolean;

        public function SingularNotificationController(_arg_1:HabboNotifications)
        {
            super();
            var _local_5:int;
            var _local_7:* = null;
            var _local_3:BitmapDataAsset = null;
            var _local_4:BitmapData = null;
            _notifications = _arg_1;
            _SafeStr_3036 = [];
            _styleConfiguration = new Map();
            _SafeStr_3039 = new Dictionary();
            _alertDialogManager = new HabboAlertDialogManager(_notifications.windowManager, _notifications.localization, _notifications.habboHelp);
            var _local_8:IAsset = _notifications.assetLibrary.getAssetByName("habbo_notifications_config_xml");
            var _local_2:XmlAsset = XmlAsset(_local_8);
            if (_local_2 != null)
            {
                XMLVariableParser.parseVariableList(XML(_local_2.content).children(), _styleConfiguration);
            };
            var _local_6:Map = _styleConfiguration["styles"];
            if (_local_6 != null)
            {
                _local_5 = 0;
                while (_local_5 < _local_6.length)
                {
                    _local_7 = _local_6.getWithIndex(_local_5);
                    if (_local_7["icon"] != null)
                    {
                        _local_3 = (_notifications.assetLibrary.getAssetByName(_local_7["icon"]) as BitmapDataAsset);
                        _local_4 = (_local_3.content as BitmapData);
                        _local_7["icon"] = _local_4;
                    };
                    _local_5++;
                };
            };
            _SafeStr_3037 = new HabboNotificationViewManager(_notifications, _notifications.assetLibrary, _notifications.windowManager, _notifications.toolBar, _styleConfiguration["styles"], _styleConfiguration["view"]);
            _notifications.sessionDataManager.events.addEventListener("BIRE_BADGE_IMAGE_READY", onBadgeImage);
            _notifications.registerUpdateReceiver(this, 2);
        }

        public function get alertDialogManager():HabboAlertDialogManager
        {
            return (_alertDialogManager);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            if (_SafeStr_3040)
            {
                _SafeStr_3040.removeEventListener("timerComplete", onShowModerationDisclaimer);
                _SafeStr_3040 = null;
            };
            if (_SafeStr_3037 != null)
            {
                _SafeStr_3037.dispose();
                _SafeStr_3037 = null;
            };
            if (_alertDialogManager != null)
            {
                _alertDialogManager.dispose();
                _alertDialogManager = null;
            };
            if (_clubGiftNotification != null)
            {
                _clubGiftNotification.dispose();
                _clubGiftNotification = null;
            };
            if (_safetyLockedNotification != null)
            {
                _safetyLockedNotification.dispose();
                _safetyLockedNotification = null;
            };
            if (_notifications != null)
            {
                _notifications.removeUpdateReceiver(this);
                _notifications = null;
            };
            _disposed = true;
        }

        public function update(_arg_1:uint):void
        {
            var _local_2:HabboNotificationItem;
            if (((_SafeStr_3037.isSpaceAvailable()) && (_SafeStr_3036.length > 0)))
            {
                _local_2 = getNextItemFromQueue();
                if (!_SafeStr_3037.showItem(_local_2))
                {
                    _local_2.dispose();
                };
            };
        }

        public function addItem(_arg_1:String, _arg_2:String, _arg_3:BitmapData, _arg_4:String=null, _arg_5:String=null, _arg_6:String=null):int
        {
            if (_notifications.disabled)
            {
                return (0);
            };
            var _local_8:Map = _styleConfiguration["styles"];
            if (_local_8 == null)
            {
                return (0);
            };
            var _local_10:Map = _local_8[_arg_2];
            if (_local_10 == null)
            {
                return (0);
            };
            var _local_9:HabboNotificationItemStyle = new HabboNotificationItemStyle(_local_10, _arg_3, _arg_4, true, _arg_5);
            if (_arg_6)
            {
                _local_9.internalLink = _arg_6;
            };
            var _local_7:HabboNotificationItem = new HabboNotificationItem(_arg_1, _local_9, this);
            _SafeStr_3036.push(_local_7);
            return (_SafeStr_3036.length);
        }

        private function getNextItemFromQueue():HabboNotificationItem
        {
            var _local_1:Array = _SafeStr_3036.splice(0, 1);
            return (_local_1[0] as HabboNotificationItem);
        }

        public function addSongPlayingNotification(_arg_1:String, _arg_2:String):void
        {
            _notifications.localization.registerParameter("soundmachine.notification.playing", "songname", _arg_1);
            _notifications.localization.registerParameter("soundmachine.notification.playing", "songauthor", _arg_2);
            var _local_3:ILocalization = _notifications.localization.getLocalizationRaw("soundmachine.notification.playing");
            if (_local_3)
            {
                addItem(_local_3.value, "soundmachine", null);
            };
        }

        public function onInternalLink(_arg_1:String):void
        {
            _notifications.createLinkEvent(_arg_1);
        }

        private function onShowModerationDisclaimer(_arg_1:TimerEvent):void
        {
            _SafeStr_3040.removeEventListener("timerComplete", onShowModerationDisclaimer);
            _SafeStr_3040 = null;
            showModerationDisclaimer();
        }

        public function showModerationDisclaimer():void
        {
            var _local_1:String;
            if (RoomEnterEffect.isRunning())
            {
                if (_SafeStr_3040 == null)
                {
                    _SafeStr_3040 = new Timer((RoomEnterEffect.totalRunningTime + 5000), 1);
                    _SafeStr_3040.addEventListener("timerComplete", onShowModerationDisclaimer);
                    _SafeStr_3040.start();
                };
            }
            else
            {
                if (!_SafeStr_3038)
                {
                    _local_1 = _notifications.localization.getLocalization("mod.chatdisclaimer", "NA");
                    this.addItem(_local_1, "info", null);
                    _SafeStr_3038 = true;
                    Logger.log(("DISPLAYED MOD INFO: " + _local_1));
                };
            };
        }

        public function showClubGiftNotification(_arg_1:int):void
        {
            if (((_clubGiftNotification) && (_clubGiftNotification.visible)))
            {
                return;
            };
            _clubGiftNotification = new ClubGiftNotification(_arg_1, _notifications.assets, _notifications.windowManager, _notifications.catalog, _notifications.toolBar);
        }

        public function showSafetyLockedNotification(_arg_1:int):void
        {
            if (((_safetyLockedNotification) && (_safetyLockedNotification.visible)))
            {
                return;
            };
            _safetyLockedNotification = new SafetyLockedNotification(_arg_1, _notifications.assets, _notifications.windowManager, _notifications.catalog, _notifications.toolBar);
        }

        public function hideSafetyLockedNotification():void
        {
            if (!_safetyLockedNotification)
            {
                return;
            };
            _safetyLockedNotification.dispose();
        }

        private function onBadgeImage(_arg_1:BadgeImageReadyEvent):void
        {
            if (((!(_arg_1 == null)) && (!(this._SafeStr_3037 == null))))
            {
                _SafeStr_3037.replaceIcon(_arg_1);
            };
        }


    }
}

