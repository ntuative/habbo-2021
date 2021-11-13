package com.sulake.habbo.notifications.singular
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.notifications.HabboNotifications;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;
    import flash.events.Event;

    public class HabboNotificationViewManager implements IUpdateReceiver 
    {

        private static const SPACING:int = 4;

        private var _SafeStr_1354:IAssetLibrary;
        private var _windowManager:IHabboWindowManager;
        private var _toolbar:IHabboToolbar;
        private var _notifications:HabboNotifications;
        private var _styleConfig:Map;
        private var _viewConfig:Map;
        private var _disposed:Boolean = false;
        private var _viewItems:Array;

        public function HabboNotificationViewManager(_arg_1:HabboNotifications, _arg_2:IAssetLibrary, _arg_3:IHabboWindowManager, _arg_4:IHabboToolbar, _arg_5:Map, _arg_6:Map)
        {
            _notifications = _arg_1;
            _SafeStr_1354 = _arg_2;
            _windowManager = _arg_3;
            _toolbar = _arg_4;
            _styleConfig = _arg_5;
            _viewConfig = _arg_6;
            _viewItems = [];
            if (_toolbar)
            {
                _toolbar.events.addEventListener("EVE_EXTENSION_VIEW_RESIZED", refreshTopMargin);
            };
            _notifications.registerUpdateReceiver(this, 2);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function replaceIcon(_arg_1:BadgeImageReadyEvent):void
        {
            for each (var _local_2:HabboNotificationItemView in _viewItems)
            {
                _local_2.replaceIcon(_arg_1);
            };
        }

        public function dispose():void
        {
            var _local_2:int;
            var _local_1:int = _viewItems.length;
            _local_2 = 0;
            while (_local_2 < _local_1)
            {
                (_viewItems.pop() as HabboNotificationItemView).dispose();
                _local_2++;
            };
            _SafeStr_1354 = null;
            _windowManager = null;
            if (_styleConfig)
            {
                _styleConfig.dispose();
                _styleConfig = null;
            };
            if (_viewConfig)
            {
                _viewConfig.dispose();
                _viewConfig = null;
            };
            if (_toolbar)
            {
                _toolbar.events.removeEventListener("EVE_EXTENSION_VIEW_RESIZED", refreshTopMargin);
                _toolbar = null;
            };
            if (_notifications != null)
            {
                _notifications.removeUpdateReceiver(this);
                _notifications = null;
            };
            _disposed = true;
        }

        public function showItem(_arg_1:HabboNotificationItem):Boolean
        {
            if (!isSpaceAvailable())
            {
                return (false);
            };
            var _local_2:HabboNotificationItemView = new HabboNotificationItemView(_SafeStr_1354.getAssetByName("layout_notification_xml"), _windowManager, _styleConfig, _viewConfig, _arg_1);
            _local_2.reposition(getNextAvailableVerticalPosition());
            _viewItems.push(_local_2);
            _viewItems.sortOn("verticalPosition", 16);
            return (true);
        }

        public function isSpaceAvailable():Boolean
        {
            return ((getNextAvailableVerticalPosition() + 70) < _windowManager.getDesktop(0).height);
        }

        public function update(_arg_1:uint):void
        {
            var _local_2:HabboNotificationItemView;
            var _local_3:int;
            _local_3 = 0;
            while (_local_3 < _viewItems.length)
            {
                (_viewItems[_local_3] as HabboNotificationItemView).update(_arg_1);
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < _viewItems.length)
            {
                _local_2 = (_viewItems[_local_3] as HabboNotificationItemView);
                if (_local_2.ready)
                {
                    _local_2.dispose();
                    _viewItems.splice(_local_3, 1);
                    _local_3--;
                };
                _local_3++;
            };
        }

        private function getNextAvailableVerticalPosition():int
        {
            var _local_3:int;
            var _local_1:HabboNotificationItemView;
            if (!_toolbar)
            {
                return (4);
            };
            if (!_toolbar.extensionView)
            {
                return (4);
            };
            var _local_2:int = (_toolbar.extensionView.screenHeight + 4);
            if (_viewItems.length == 0)
            {
                return (_local_2);
            };
            var _local_4:int = _local_2;
            _local_3 = 0;
            while (_local_3 < _viewItems.length)
            {
                _local_1 = (_viewItems[_local_3] as HabboNotificationItemView);
                if ((_local_4 + 70) < _local_1.verticalPosition)
                {
                    return (_local_4);
                };
                _local_4 = ((_local_1.verticalPosition + 70) + 4);
                _local_3++;
            };
            return (_local_4);
        }

        public function refreshTopMargin(_arg_1:Event):void
        {
            var _local_4:int;
            var _local_2:HabboNotificationItemView;
            var _local_3:int = (_toolbar.extensionView.screenHeight + 4);
            _local_4 = 0;
            while (_local_4 < _viewItems.length)
            {
                _local_2 = (_viewItems[_local_4] as HabboNotificationItemView);
                _local_2.reposition(_local_3);
                _local_3 = ((_local_2.verticalPosition + 70) + 4);
                _local_4++;
            };
        }


    }
}

