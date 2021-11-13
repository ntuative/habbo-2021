package com.sulake.habbo.notifications.feed
{
    import com.sulake.habbo.notifications.HabboNotifications;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.notifications.feed.view.content.FeedEntity;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.notifications.feed.view.pane.NotificationsPane;
    import com.sulake.habbo.notifications.feed.view.pane.StreamPane;
    import com.sulake.habbo.notifications.feed.view.pane.InfoPane;
    import com.sulake.habbo.notifications.feed.view.pane.SettingsPane;
    import com.sulake.habbo.notifications.feed.view.pane.StatusPane;
    import com.sulake.habbo.notifications.feed.view.pane.IPane;
    import com.sulake.habbo.notifications.feed.view.pane.AbstractPane;
    import com.sulake.habbo.notifications.feed.view.content.IFeedEntity;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class NotificationView 
    {

        public static const VIEW_PANE_FEEDS:String = "pane_feeds";
        public static const VIEW_PANE_NOTIFICATIONS:String = "pane_notifications";
        public static const VIEW_PANE_STREAM:String = "pane_stream";
        public static const VIEW_PANE_SETTINGS:String = "pane_settings";
        public static const VIEW_PANE_INFO:String = "pane_info";
        public static const VIEW_PANE_STATUS:String = "pane_status";
        private static const _SafeStr_3026:String = "settings_toggle";
        private static const ELEMENT_INFO:String = "info_toggle";

        private var _SafeStr_3027:StateController;
        private var _SafeStr_659:HabboNotifications;
        private var _controller:NotificationController;
        private var _window:IWindowContainer;
        private var _SafeStr_3028:Map;

        public function NotificationView(_arg_1:NotificationController, _arg_2:HabboNotifications)
        {
            _controller = _arg_1;
            _SafeStr_659 = _arg_2;
            _SafeStr_3027 = new StateController();
            FeedEntity.assignHandles(windowManager, assets, localization, _arg_1);
            setupUserInterface();
            closePaneLevel(2);
            switchToPane("pane_notifications");
            setVisibilityState(1);
        }

        public function dispose():void
        {
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            if (_SafeStr_3028)
            {
                for each (var _local_1:IDisposable in _SafeStr_3028)
                {
                    _local_1.dispose();
                };
                _SafeStr_3028.dispose();
                _SafeStr_3028 = null;
            };
            FeedEntity.removeHandles();
            _controller = null;
            _SafeStr_3027 = null;
            _SafeStr_659 = null;
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_SafeStr_659.windowManager);
        }

        public function get assets():IAssetLibrary
        {
            return (_SafeStr_659.assets);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (_SafeStr_659.localization);
        }

        public function get controller():NotificationController
        {
            return (_controller);
        }

        private function setupUserInterface():void
        {
            if (_window)
            {
                return;
            };
            _window = (_SafeStr_659.windowManager.buildFromXML((_SafeStr_659.assets.getAssetByName("feed_display_xml").content as XML)) as IWindowContainer);
            _window.height = _window.desktop.height;
            _window.setParamFlag(64);
            _window.setParamFlag(0x0800);
            _window.findChildByName("settings_toggle").addEventListener("WME_CLICK", onSettingsToggle);
            _window.findChildByName("info_toggle").addEventListener("WME_CLICK", onInfoToggle);
            _SafeStr_3028 = new Map();
            _SafeStr_3028.add("pane_notifications", new NotificationsPane("pane_notifications", this, (_window.findChildByName("pane_notifications") as IWindowContainer)));
            _SafeStr_3028.add("pane_stream", new StreamPane("pane_stream", this, (_window.findChildByName("pane_stream") as IWindowContainer)));
            _SafeStr_3028.add("pane_info", new InfoPane("pane_info", this, (_window.findChildByName("pane_info") as IWindowContainer)));
            _SafeStr_3028.add("pane_settings", new SettingsPane("pane_settings", this, (_window.findChildByName("pane_settings") as IWindowContainer)));
            _SafeStr_3028.add("pane_status", new StatusPane("pane_status", this, (_window.findChildByName("pane_status") as IWindowContainer)));
        }

        public function toggleMinimized():void
        {
            switch (_SafeStr_3027.currentState())
            {
                case 2:
                    setVisibilityState(1);
                    return;
                case 1:
                    setVisibilityState(2);
                default:
            };
        }

        public function setVisibilityState(_arg_1:int):void
        {
            var _local_2:IWindowContainer;
            var _local_3:int = _SafeStr_3027.requestState(_arg_1);
            switch (_local_3)
            {
                case 0:
                    _window.x = _window.desktop.width;
                    _window.visible = false;
                    return;
                case 1:
                    _window.visible = true;
                    _local_2 = (_window.findChildByName("main_view") as IWindowContainer);
                    _window.x = (_window.desktop.width - (_window.width - _local_2.width));
                    return;
                case 2:
                    _window.visible = true;
                    _window.x = (_window.desktop.width - _window.width);
                default:
            };
        }

        public function setViewEnabled(_arg_1:Boolean):void
        {
            _SafeStr_3027.setEnabled(_arg_1);
            setVisibilityState(_SafeStr_3027.currentState());
        }

        public function setGameMode(_arg_1:Boolean):void
        {
            _SafeStr_3027.setGameMode(_arg_1);
            setVisibilityState(_SafeStr_3027.currentState());
        }

        public function switchToPane(_arg_1:String):void
        {
            var _local_2:IPane = _SafeStr_3028.getValue(_arg_1);
            if (!_local_2)
            {
                return;
            };
            closePaneLevel(_local_2.paneLevel);
            _local_2.isVisible = true;
        }

        public function closePaneLevel(_arg_1:int):void
        {
            for each (var _local_2:AbstractPane in _SafeStr_3028)
            {
                if (_local_2.paneLevel == _arg_1)
                {
                    _local_2.isVisible = false;
                };
            };
        }

        public function addNotificationFeedItem(_arg_1:int, _arg_2:IFeedEntity):void
        {
            (_SafeStr_3028.getValue("pane_notifications") as NotificationsPane).addItem(_arg_1, _arg_2);
        }

        public function addStreamFeedItem(_arg_1:IFeedEntity):void
        {
            (_SafeStr_3028.getValue("pane_stream") as StreamPane).addItem(_arg_1);
        }

        public function removeStreamItems():void
        {
        }

        private function onSettingsToggle(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IPane = (_SafeStr_3028.getValue("pane_settings") as IPane);
            if (_local_2)
            {
                if (_local_2.isVisible)
                {
                    closePaneLevel(2);
                }
                else
                {
                    switchToPane("pane_settings");
                };
            };
        }

        private function onInfoToggle(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IPane = (_SafeStr_3028.getValue("pane_info") as IPane);
            if (_local_2)
            {
                if (_local_2.isVisible)
                {
                    closePaneLevel(2);
                }
                else
                {
                    switchToPane("pane_info");
                };
            };
        }


    }
}

