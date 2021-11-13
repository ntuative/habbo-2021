package com.sulake.habbo.notifications.feed.view.pane
{
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.notifications.feed.NotificationView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.notifications.feed.view.content.IFeedEntity;

    public class NotificationsPane extends AbstractPane 
    {

        private static const SECTIONS_LIST:String = "list";
        private static const _SafeStr_3010:String = "list_urgent";
        private static const _SafeStr_3011:String = "list_actions";
        private static const _SafeStr_3012:String = "list_persistent";
        private static const _SafeStr_3013:String = "list_notifications";

        private var _SafeStr_853:IItemListWindow;

        public function NotificationsPane(_arg_1:String, _arg_2:NotificationView, _arg_3:IWindowContainer)
        {
            super(_arg_1, _arg_2, _arg_3, 1);
            setUp();
        }

        override public function dispose():void
        {
            _SafeStr_853 = null;
            super.dispose();
        }

        private function setUp():void
        {
            _SafeStr_853 = (_window.findChildByName("list") as IItemListWindow);
        }

        public function addItem(_arg_1:int, _arg_2:IFeedEntity):void
        {
            var _local_3:IItemListWindow = getSection(_arg_1);
            _local_3.addListItemAt(_arg_2.window, 0);
        }

        private function getSection(_arg_1:int):IItemListWindow
        {
            var _local_2:String;
            switch (_arg_1)
            {
                case 0:
                    _local_2 = "list_urgent";
                    break;
                case 1:
                    _local_2 = "list_actions";
                    break;
                case 2:
                    _local_2 = "list_persistent";
                    break;
                case 3:
                    _local_2 = "list_notifications";
                default:
            };
            return (_SafeStr_853.getListItemByName(_local_2) as IItemListWindow);
        }


    }
}

