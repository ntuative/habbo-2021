package com.sulake.habbo.friendlist
{
    import flash.geom.Point;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import flash.utils.Dictionary;

    public class FriendListView 
    {

        private static const DEFAULT_LOCATION:Point = new Point(110, 50);
        private static const MIN_LEFT_MARGIN:int = 110;
        private static const _SafeStr_2323:int = 1;

        private var _friendList:HabboFriendList;
        private var _SafeStr_2467:FriendListTabsView;
        private var _mainWindow:IFrameWindow;
        private var _SafeStr_2468:IWindowContainer;
        private var _footer:IWindowContainer;
        private var _SafeStr_2469:ITextWindow;
        private var _SafeStr_2470:int = -1;
        private var _lastWindowWidth:int = -1;
        private var _ignoreResizeEvents:Boolean;

        public function FriendListView(_arg_1:HabboFriendList)
        {
            _friendList = _arg_1;
            _SafeStr_2467 = new FriendListTabsView(_friendList);
        }

        public function openFriendList():void
        {
            if (_mainWindow == null)
            {
                prepare();
                _mainWindow.position = DEFAULT_LOCATION;
            }
            else
            {
                _mainWindow.visible = true;
                _mainWindow.activate();
            };
        }

        public function showInfo(_arg_1:WindowEvent, _arg_2:String):void
        {
            var _local_3:WindowMouseEvent = (_arg_1 as WindowMouseEvent);
            if (_local_3 == null)
            {
                return;
            };
            if (_local_3.type == "WME_OUT")
            {
                _SafeStr_2469.text = "";
            }
            else
            {
                if (_local_3.type == "WME_OVER")
                {
                    _SafeStr_2469.text = _arg_2;
                };
            };
        }

        public function refresh(_arg_1:String):void
        {
            if (this._mainWindow == null)
            {
                return;
            };
            _SafeStr_2467.refresh(_arg_1);
            refreshWindowSize();
        }

        public function close():void
        {
            if (this._mainWindow != null)
            {
                this._mainWindow.visible = false;
            };
        }

        public function isOpen():Boolean
        {
            return ((_mainWindow) && (_mainWindow.visible));
        }

        private function prepare():void
        {
            _mainWindow = IFrameWindow(_friendList.getXmlWindow("main_window"));
            _mainWindow.findChildByTag("close").procedure = onWindowClose;
            _SafeStr_2468 = IWindowContainer(_mainWindow.content.findChildByName("main_content"));
            _footer = IWindowContainer(_mainWindow.content.findChildByName("footer"));
            _SafeStr_2467.prepare(_SafeStr_2468);
            _mainWindow.procedure = onWindow;
            _mainWindow.content.setParamFlag(0x0C00, false);
            _mainWindow.content.setParamFlag(0, true);
            _mainWindow.header.setParamFlag(192, false);
            _mainWindow.header.setParamFlag(0, true);
            _mainWindow.content.setParamFlag(192, false);
            _mainWindow.content.setParamFlag(0, true);
            var _local_1:Boolean = _friendList.getBoolean("friendship.category.management.enabled");
            if (((_local_1) && (!(_friendList.getInteger("spaweb", 0) == 1))))
            {
                _mainWindow.findChildByName("open_edit_ctgs_but").procedure = onEditCategoriesButtonClick;
            }
            else
            {
                _mainWindow.findChildByName("open_edit_ctgs_but").visible = false;
            };
            _SafeStr_2469 = ITextWindow(_mainWindow.findChildByName("info_text"));
            _SafeStr_2469.text = "";
            _friendList.refreshButton(_mainWindow, "open_edit_ctgs", true, null, 0);
            refresh("prepare");
            _mainWindow.height = 350;
            _mainWindow.width = 230;
        }

        private function onWindowClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            Logger.log("Close window");
            _mainWindow.visible = false;
            _friendList.trackFriendListEvent("HABBO_FRIENDLIST_TRACKING_EVENT_CLOSED");
            _friendList.categories.view.refreshed();
        }

        private function onWindow(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((_arg_1.type == "WE_RELOCATE") || (_arg_1.type == "WE_RESIZED")))
            {
                _friendList.categories.view.refreshed();
            };
            if (((!(_arg_1.type == "WE_RESIZED")) || (!(_arg_2 == _mainWindow))))
            {
                return;
            };
            if (this._ignoreResizeEvents)
            {
                return;
            };
            var _local_3:int = ((_SafeStr_2470 == -1) ? 0 : (_mainWindow.height - _SafeStr_2470));
            var _local_4:int = ((_lastWindowWidth == -1) ? 0 : (_mainWindow.width - _lastWindowWidth));
            _friendList.tabs.tabContentHeight = Math.max(100, (_friendList.tabs.tabContentHeight + _local_3));
            _friendList.tabs.windowWidth = Math.max(147, (_friendList.tabs.windowWidth + _local_4));
            refresh(("resize: " + _local_3));
        }

        private function refreshWindowSize():void
        {
            this._ignoreResizeEvents = true;
            _footer.visible = false;
            _footer.y = Util.getLowestPoint(_mainWindow.content);
            _footer.width = _friendList.tabs.windowWidth;
            _footer.visible = true;
            _mainWindow.content.height = Util.getLowestPoint(_mainWindow.content);
            _mainWindow.content.width = (_friendList.tabs.windowWidth - 10);
            _mainWindow.header.width = (_friendList.tabs.windowWidth - 10);
            _mainWindow.height = (_mainWindow.content.height + 30);
            _mainWindow.width = _friendList.tabs.windowWidth;
            this._ignoreResizeEvents = false;
            _mainWindow.scaler.setParamFlag(0x3000, false);
            _mainWindow.scaler.setParamFlag(0x3000, (!(this._friendList.tabs.findSelectedTab() == null)));
            _mainWindow.scaler.setParamFlag(192, false);
            _mainWindow.scaler.setParamFlag(0x0C00, false);
            _mainWindow.scaler.x = (_mainWindow.width - _mainWindow.scaler.width);
            _mainWindow.scaler.y = (_mainWindow.height - _mainWindow.scaler.height);
            _SafeStr_2470 = _mainWindow.height;
            _lastWindowWidth = _mainWindow.width;
            Logger.log(("RESIZED: " + _friendList.tabs.windowWidth));
        }

        private function onEditCategoriesButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            _friendList.view.showInfo(_arg_1, "${friendlist.tip.preferences}");
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            Logger.log("Edit categories clicked");
            var _local_3:WindowMouseEvent = (_arg_1 as WindowMouseEvent);
            _friendList.openHabboWebPage("link.format.friendlist.pref", new Dictionary(), _local_3.stageX, _local_3.stageY);
        }

        public function get mainWindow():IWindowContainer
        {
            return (_mainWindow);
        }

        public function alignBottomLeftTo(_arg_1:Point):void
        {
            var _local_2:Point = _arg_1.clone();
            _local_2.y = (_local_2.y - _mainWindow.height);
            var _local_3:int = _friendList.windowManager.getWindowContext(1).getDesktopWindow().width;
            _local_2.x = Math.min((_local_3 - _mainWindow.width), _local_2.x);
            _local_2.x = Math.max(110, _local_2.x);
            _mainWindow.position = _local_2;
        }


    }
}

