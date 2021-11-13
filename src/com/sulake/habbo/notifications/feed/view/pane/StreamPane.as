package com.sulake.habbo.notifications.feed.view.pane
{
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.notifications.feed.NotificationView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.notifications.feed.view.content.IFeedEntity;

    public class StreamPane extends AbstractPane 
    {

        private var _SafeStr_853:IItemListWindow;

        public function StreamPane(_arg_1:String, _arg_2:NotificationView, _arg_3:IWindowContainer)
        {
            super(_arg_1, _arg_2, _arg_3, 1);
            _SafeStr_853 = (_window.findChildByName("list") as IItemListWindow);
        }

        override public function dispose():void
        {
            _SafeStr_853 = null;
            super.dispose();
        }

        public function addItem(_arg_1:IFeedEntity):void
        {
            _SafeStr_853.addListItem(_arg_1.window);
        }


    }
}

