package com.sulake.habbo.notifications.feed.view.pane
{
    import com.sulake.core.window.components._SafeStr_143;
    import com.sulake.habbo.notifications.feed.NotificationView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class InfoPane extends AbstractPane 
    {

        public function InfoPane(_arg_1:String, _arg_2:NotificationView, _arg_3:IWindowContainer)
        {
            super(_arg_1, _arg_2, _arg_3, 2);
            (_window.findChildByName("info_ok") as _SafeStr_143).addEventListener("WME_CLICK", onOkClick);
        }

        override public function dispose():void
        {
            var _local_1:_SafeStr_143;
            super.dispose();
            if (_window)
            {
                _local_1 = (_window.findChildByName("info_ok") as _SafeStr_143);
                if (_local_1)
                {
                    _local_1.removeEventListener("WME_CLICK", onOkClick);
                    _local_1 = null;
                };
            };
        }

        private function onOkClick(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_461.closePaneLevel(2);
        }


    }
}

