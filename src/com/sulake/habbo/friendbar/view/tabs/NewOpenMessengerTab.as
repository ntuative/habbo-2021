package com.sulake.habbo.friendbar.view.tabs
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class NewOpenMessengerTab extends Tab 
    {

        protected static const ICON:String = "icon";
        protected static const HEADER:String = "header";
        private static const _SafeStr_2404:String = "new_open_messenger_tab_xml";
        private static const DEFAULT_COLOR:uint = 8374494;
        private static const _SafeStr_2406:uint = 9560569;
        private static const FRIENDS_Y_PADDING:int = 10;
        private static const _SafeStr_1036:Array = [];
        private static const _SafeStr_2407:Array = [];


        public static function allocate():NewOpenMessengerTab
        {
            var _local_1:NewOpenMessengerTab = ((_SafeStr_1036.length > 0) ? _SafeStr_1036.pop() : new NewOpenMessengerTab());
            _local_1._SafeStr_1037 = false;
            _local_1._window = _local_1.allocateEntityWindow();
            return (_local_1);
        }


        public function allocateEntityWindow():IWindowContainer
        {
            var _local_1:IWindowContainer = ((_SafeStr_2407.length > 0) ? _SafeStr_2407.pop() : (WINDOWING.buildFromXML((ASSETS.getAssetByName("new_open_messenger_tab_xml").content as XML)) as IWindowContainer));
            _local_1.addEventListener("WME_CLICK", onButtonClick);
            _local_1.addEventListener("WME_OVER", onMouseOver);
            _local_1.addEventListener("WME_OUT", onMouseOut);
            _local_1.height = HEIGHT;
            return (_local_1);
        }

        private function releaseEntityWindow(_arg_1:IWindowContainer):void
        {
            if (((_arg_1) && (!(_arg_1.disposed))))
            {
                _arg_1.procedure = null;
                _arg_1.removeEventListener("WME_CLICK", onMouseClick);
                _arg_1.removeEventListener("WME_OVER", onMouseOver);
                _arg_1.removeEventListener("WME_OUT", onMouseOut);
                _arg_1.width = WIDTH;
                _arg_1.height = HEIGHT;
                if (_SafeStr_2407.indexOf(_arg_1) == -1)
                {
                    _SafeStr_2407.push(_arg_1);
                };
            };
        }

        override public function recycle():void
        {
            if (!disposed)
            {
                if (!_SafeStr_1037)
                {
                    if (_window)
                    {
                        releaseEntityWindow(_window);
                        _window = null;
                    };
                    _SafeStr_1037 = true;
                    _SafeStr_1036.push(this);
                };
            };
        }

        override protected function expose():void
        {
            super.expose();
            _window.color = ((exposed) ? 9560569 : 8374494);
        }

        override protected function conceal():void
        {
            super.conceal();
            _window.color = ((exposed) ? 9560569 : 8374494);
        }

        private function onButtonClick(_arg_1:WindowMouseEvent):void
        {
            if (((!(disposed)) && (!(recycled))))
            {
                DATA.toggleMessenger();
            };
        }


    }
}

