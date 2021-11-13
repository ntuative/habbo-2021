package com.sulake.habbo.notifications.feed.view.pane
{
    import com.sulake.habbo.notifications.feed.NotificationView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.notifications.feed.FeedSettings;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class SettingsPane extends AbstractPane 
    {

        public function SettingsPane(_arg_1:String, _arg_2:NotificationView, _arg_3:IWindowContainer)
        {
            super(_arg_1, _arg_2, _arg_3, 2);
            applySettingsToView();
            _window.procedure = onWindowEventProc;
        }

        override public function dispose():void
        {
            super.dispose();
        }

        private function applySettingsToView():void
        {
            var _local_1:FeedSettings = _SafeStr_461.controller.getSettings();
            _local_1.getVisibleFeedCategories();
        }

        public function onWindowEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:FeedSettings;
            var _local_5:int;
            if (_arg_1.type == "WME_CLICK")
            {
                _local_3 = _SafeStr_461.controller.getSettings();
                for each (var _local_4:String in _arg_2.tags)
                {
                    switch (_local_4)
                    {
                        case "ME":
                            _local_5 = 0;
                            break;
                        case "HOTEL":
                            _local_5 = 2;
                            break;
                        case "FRIENDS":
                            _local_5 = 1;
                    };
                    _local_3.toggleVisibleFeedCategory(_local_5);
                };
                applySettingsToView();
            };
        }


    }
}

