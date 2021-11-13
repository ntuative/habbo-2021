package com.sulake.habbo.friendbar.view.tabs
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.motion.Motions;
    import com.sulake.core.window.motion.Combo;
    import com.sulake.core.window.motion.EaseOut;
    import com.sulake.core.window.motion.ResizeTo;
    import com.sulake.core.window.motion.MoveBy;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class AddFriendsTab extends Tab 
    {

        protected static const ICON:String = "icon";
        protected static const _SafeStr_2402:String = "text";
        protected static const HEADER:String = "header";
        protected static const LABEL:String = "label";
        protected static const _SafeStr_2403:String = "button";
        private static const _SafeStr_2404:String = "add_friends_tab_xml";
        private static const ICON_RESOURCE:String = "find_friends_icon_png";
        private static const DEFAULT_COLOR:uint = 8374494;
        private static const _SafeStr_2406:uint = 9560569;
        private static const _SafeStr_1036:Array = [];
        private static const _SafeStr_2407:Array = [];

        private static var _SafeStr_2405:int = -1;


        public static function allocate():AddFriendsTab
        {
            var _local_1:AddFriendsTab = ((_SafeStr_1036.length > 0) ? _SafeStr_1036.pop() : new AddFriendsTab());
            _local_1._SafeStr_1037 = false;
            _local_1._window = _local_1.allocateEntityWindow();
            return (_local_1);
        }


        public function allocateEntityWindow():IWindowContainer
        {
            var _local_1:IWindowContainer = ((_SafeStr_2407.length > 0) ? _SafeStr_2407.pop() : (WINDOWING.buildFromXML((ASSETS.getAssetByName("add_friends_tab_xml").content as XML)) as IWindowContainer));
            var _local_4:IRegionWindow = IRegionWindow(_local_1.findChildByName("header"));
            _local_1.addEventListener("WME_CLICK", onMouseClick);
            _local_1.addEventListener("WME_OVER", onMouseOver);
            _local_1.addEventListener("WME_OUT", onMouseOut);
            _local_4.addEventListener("WME_CLICK", onMouseClick);
            _local_4.addEventListener("WME_OVER", onMouseOver);
            _local_4.addEventListener("WME_OUT", onMouseOut);
            if (_SafeStr_2405 < 0)
            {
                _SafeStr_2405 = _local_1.height;
            };
            _local_1.height = HEIGHT;
            var _local_3:IBitmapWrapperWindow = (_local_1.findChildByName("icon") as IBitmapWrapperWindow);
            _local_3.disposesBitmap = false;
            if (ASSETS.getAssetByName("find_friends_icon_png") != null)
            {
                _local_3.bitmap = (ASSETS.getAssetByName("find_friends_icon_png").content as BitmapData);
            }
            else
            {
                (trace("crash"));
            };
            var _local_2:IWindow = _local_1.findChildByName("button");
            _local_2.addEventListener("WME_CLICK", onButtonClick);
            var _local_5:IWindow = _local_1.findChildByName("text");
            _local_5.visible = false;
            return (_local_1);
        }

        private function releaseEntityWindow(_arg_1:IWindowContainer):void
        {
            var _local_2:IRegionWindow;
            if (((_arg_1) && (!(_arg_1.disposed))))
            {
                _arg_1.procedure = null;
                _arg_1.removeEventListener("WME_CLICK", onMouseClick);
                _arg_1.removeEventListener("WME_OVER", onMouseOver);
                _arg_1.removeEventListener("WME_OUT", onMouseOut);
                _local_2 = IRegionWindow(_arg_1.findChildByName("header"));
                _local_2.removeEventListener("WME_CLICK", onMouseClick);
                _local_2.removeEventListener("WME_OVER", onMouseOver);
                _local_2.removeEventListener("WME_OUT", onMouseOut);
                _arg_1.findChildByName("button").removeEventListener("WME_CLICK", onButtonClick);
                _arg_1.findChildByName("text").visible = false;
                _arg_1.width = WIDTH;
                _arg_1.height = HEIGHT;
                if (_SafeStr_2407.indexOf(_arg_1) == -1)
                {
                    _SafeStr_2407.push(_arg_1);
                };
            };
        }

        override public function select(_arg_1:Boolean):void
        {
            if (!selected)
            {
                if ((((_arg_1) && (false)) && (Motions.getMotionByTarget(_window) == null)))
                {
                    Motions.runMotion(new Combo(new EaseOut(new ResizeTo(_window, 80, _window.width, _SafeStr_2405), 3), new EaseOut(new MoveBy(_window, 80, _window.x, -(_SafeStr_2405 - HEIGHT)), 3)));
                }
                else
                {
                    _window.height = _SafeStr_2405;
                    _window.y = (_window.y - (_window.height - HEIGHT));
                };
                _window.findChildByName("text").visible = true;
                super.select(_arg_1);
            };
        }

        override public function deselect(_arg_1:Boolean):void
        {
            if (selected)
            {
                _window.y = 0;
                _window.height = HEIGHT;
                _window.findChildByName("text").visible = false;
                super.deselect(_arg_1);
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
            ITextWindow(_window.findChildByTag("label")).underline = exposed;
            _window.color = ((exposed) ? 9560569 : 8374494);
        }

        override protected function conceal():void
        {
            super.conceal();
            ITextWindow(_window.findChildByTag("label")).underline = exposed;
            _window.color = ((exposed) ? 9560569 : 8374494);
        }

        private function onButtonClick(_arg_1:WindowMouseEvent):void
        {
            if (((!(disposed)) && (!(recycled))))
            {
                DATA.findNewFriends();
                deselect(true);
            };
        }


    }
}

