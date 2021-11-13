package com.sulake.habbo.notifications.feed
{
    import com.sulake.habbo.notifications.HabboNotifications;
    import com.sulake.habbo.notifications.feed.view.content.EntityFactory;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.habbo.notifications.feed.view.content.IFeedEntity;
    import com.sulake.habbo.notifications.feed.data.GenericNotificationItemData;
    import com.sulake.habbo.utils.HabboWebTools;

    public class NotificationController 
    {

        private var _SafeStr_659:HabboNotifications;
        private var _SafeStr_3023:NotificationView;
        private var _SafeStr_3024:FeedSettings;
        private var _SafeStr_3025:EntityFactory;

        public function NotificationController(_arg_1:HabboNotifications)
        {
            _SafeStr_659 = _arg_1;
            _SafeStr_3024 = new FeedSettings(this);
            _SafeStr_3023 = new NotificationView(this, _arg_1);
            _SafeStr_3025 = new EntityFactory();
            _SafeStr_659.roomSessionManager.events.addEventListener("RSE_CREATED", roomSessionStateEventHandler);
            _SafeStr_659.roomSessionManager.events.addEventListener("RSE_STARTED", roomSessionStateEventHandler);
            _SafeStr_659.roomSessionManager.events.addEventListener("RSE_ENDED", roomSessionStateEventHandler);
        }

        public function dispose():void
        {
            if (_SafeStr_3023)
            {
                _SafeStr_3023.dispose();
                _SafeStr_3023 = null;
            };
            _SafeStr_659.roomSessionManager.events.removeEventListener("RSE_CREATED", roomSessionStateEventHandler);
            _SafeStr_659.roomSessionManager.events.removeEventListener("RSE_STARTED", roomSessionStateEventHandler);
            _SafeStr_659.roomSessionManager.events.removeEventListener("RSE_ENDED", roomSessionStateEventHandler);
            _SafeStr_659 = null;
            if (_SafeStr_3024)
            {
                _SafeStr_3024.dispose();
                _SafeStr_3024 = null;
            };
            if (_SafeStr_3025)
            {
                _SafeStr_3025.dispose();
                _SafeStr_3025 = null;
            };
        }

        private function roomSessionStateEventHandler(_arg_1:RoomSessionEvent):void
        {
            switch (_arg_1.type)
            {
                case "RSE_CREATED":
                case "RSE_STARTED":
                case "RSE_ENDED":
                    if (_SafeStr_3023)
                    {
                        _SafeStr_3023.setGameMode(_arg_1.session.isGameSession);
                    };
                    return;
            };
        }

        public function setFeedEnabled(_arg_1:Boolean):void
        {
            if (_SafeStr_3023)
            {
                _SafeStr_3023.setViewEnabled(_arg_1);
            };
        }

        public function getSettings():FeedSettings
        {
            return (_SafeStr_3024);
        }

        public function updateFeedCategoryFiltering():void
        {
        }

        public function addFeedItem(_arg_1:int, _arg_2:GenericNotificationItemData):void
        {
            var _local_3:IFeedEntity = _SafeStr_3025.createNotificationEntity(_arg_2);
            _SafeStr_3023.addNotificationFeedItem(_arg_1, _local_3);
        }

        public function executeAction(_arg_1:String):void
        {
            if (_arg_1.indexOf("http") == 0)
            {
                HabboWebTools.openWebPage(_arg_1);
            };
        }


    }
}

