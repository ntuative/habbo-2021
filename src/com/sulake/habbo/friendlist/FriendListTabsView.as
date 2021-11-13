package com.sulake.habbo.friendlist
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.friendlist.domain.FriendListTab;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IItemListWindow;

    public class FriendListTabsView 
    {

        private var _friendList:HabboFriendList;
        private var _content:IWindowContainer;

        public function FriendListTabsView(_arg_1:HabboFriendList)
        {
            _friendList = _arg_1;
        }

        public function prepare(_arg_1:IWindowContainer):void
        {
            _content = _arg_1;
            refresh("prepare");
        }

        public function refresh(_arg_1:String):void
        {
            var _local_3:IWindowContainer;
            var _local_4:int;
            Logger.log(("TABS: REFRESH: " + _arg_1));
            _content.width = _friendList.tabs.tabContentWidth;
            _content.findChildByName("bg").width = _friendList.tabs.tabContentWidth;
            var _local_2:int = 1;
            for each (var _local_5:FriendListTab in _friendList.tabs.getTabs())
            {
                _local_3 = (_content.getChildByName(("flt_" + _local_5.id)) as IWindowContainer);
                if (!isTabVisible(_local_5.id))
                {
                    _local_3.visible = false;
                }
                else
                {
                    _local_3.visible = true;
                    _local_3.width = _friendList.tabs.tabContentWidth;
                    _local_3.y = _local_2;
                    _local_4 = refreshHeader(_local_5, _local_3);
                    refreshTabContent(_local_5, _local_3);
                    _local_3.height = (_local_4 + ((_local_5.selected) ? _friendList.tabs.tabContentHeight : 0));
                    _local_2 = (_local_2 + _local_3.height);
                };
            };
            _content.height = (_local_2 + 1);
            _content.findChildByName("bg").height = _content.height;
            Logger.log("TABS: REFRESH END");
        }

        private function isTabVisible(_arg_1:int):Boolean
        {
            if (_arg_1 != 2)
            {
                return (true);
            };
            return (_friendList.friendRequests.requests.length > 0);
        }

        private function refreshTabContent(_arg_1:FriendListTab, _arg_2:IWindowContainer):void
        {
            if (_arg_1.selected)
            {
                if (_arg_1.view == null)
                {
                    _arg_1.view = (this.getTabContent(_arg_1) as IWindowContainer);
                };
                refreshTabContentDims(_arg_1.view);
                refreshScrollBarVisibility(_arg_1.view);
                _arg_2.addChild(_arg_1.view);
            }
            else
            {
                if (_arg_1.view != null)
                {
                    _arg_2.removeChild(_arg_1.view);
                };
            };
        }

        private function refreshHeader(_arg_1:FriendListTab, _arg_2:IWindowContainer):int
        {
            var _local_3:IWindowContainer = (_arg_2.getChildByName("header") as IWindowContainer);
            _local_3.width = _friendList.tabs.tabContentWidth;
            showBgImage(_local_3, _arg_1.newMessageArrived, "hdr_hilite");
            showBgImage(_local_3, (!(_arg_1.newMessageArrived)), _arg_1.headerPicName);
            var _local_4:Boolean = ((_arg_1.id == 1) && (!(_arg_1.newMessageArrived)));
            Logger.log(((((("TAB " + _arg_1.id) + ", ") + _arg_1.name) + ", ") + _local_4));
            refreshArrowIcon(_local_3, "arrow_down_black", ((_arg_1.selected) && (_local_4)), 12);
            refreshArrowIcon(_local_3, "arrow_right_black", ((!(_arg_1.selected)) && (_local_4)), 15);
            refreshArrowIcon(_local_3, "arrow_down_white", ((_arg_1.selected) && (!(_local_4))), 12);
            refreshArrowIcon(_local_3, "arrow_right_white", ((!(_arg_1.selected)) && (!(_local_4))), 15);
            refreshTabText(_arg_1, _local_3);
            return (_local_3.height);
        }

        private function showBgImage(_arg_1:IWindowContainer, _arg_2:Boolean, _arg_3:String):void
        {
            Logger.log(((("REFRESHING BG IMAGE: " + _arg_2) + ", ") + _arg_3));
            var _local_4:IBitmapWrapperWindow = (_arg_1.getChildByName(_arg_3) as IBitmapWrapperWindow);
            if (!_arg_2)
            {
                if (_local_4 != null)
                {
                    _local_4.visible = false;
                };
            }
            else
            {
                if (_local_4.bitmap == null)
                {
                    _local_4.bitmap = _friendList.getButtonImage(_arg_3);
                    _local_4.height = _local_4.bitmap.height;
                    _arg_1.height = _local_4.bitmap.height;
                    _local_4.procedure = onTabClick;
                };
                _local_4.width = _friendList.tabs.tabContentWidth;
                _local_4.visible = true;
            };
        }

        private function refreshArrowIcon(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean, _arg_4:int):void
        {
            var _local_5:ITextWindow;
            var _local_6:IWindow;
            _friendList.refreshButton(_arg_1, _arg_2, _arg_3, null, 0);
            if (_arg_3)
            {
                _local_5 = ITextWindow(_arg_1.findChildByName("caption_text"));
                _local_6 = IWindow(_arg_1.findChildByName(_arg_2));
                _local_6.x = (_local_5.textWidth + _arg_4);
            };
        }

        private function refreshTabText(_arg_1:FriendListTab, _arg_2:IWindowContainer):void
        {
            var _local_3:ITextWindow = (_arg_2.findChildByName("caption_text") as ITextWindow);
            _local_3.text = (((_arg_1.name + " (") + _arg_1.tabView.getEntryCount()) + ")");
            _local_3.textColor = _friendList.laf.getTabTextColor(_arg_1.newMessageArrived, _arg_1.id);
        }

        private function onTabClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            _friendList.view.showInfo(_arg_1, (("${friendlist.tip.tab." + _arg_2.id) + "}"));
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            Logger.log("TAB CLICKED!");
            var _local_3:FriendListTab = _friendList.tabs.findTab(_arg_2.id);
            for each (var _local_4:FriendListTab in _friendList.tabs.getTabs())
            {
                _local_4.tabView.tabClicked(_local_3.id);
            };
            _friendList.tabs.toggleSelected(_local_3);
            _friendList.view.refresh("tabClick");
            if (_local_3.selected)
            {
                switch (_local_3.id)
                {
                    case 1:
                        _friendList.trackFriendListEvent("HABBO_FRIENDLIST_TRACKING_EVENT_FRIENDS");
                        break;
                    case 3:
                        _friendList.trackFriendListEvent("HABBO_FRIENDLIST_TRACKING_EVENT_SEARCH");
                        break;
                    case 2:
                        _friendList.trackFriendListEvent("HABBO_FRIENDLIST_TRACKING_EVENT_REQUEST");
                    default:
                };
            }
            else
            {
                _friendList.trackFriendListEvent("HABBO_FRIENDLIST_TRACKING_EVENT_MINIMZED");
            };
        }

        private function getTabContent(_arg_1:FriendListTab):IWindow
        {
            var _local_2:IWindowContainer = IWindowContainer(_friendList.getXmlWindow("tab_content"));
            _local_2.background = true;
            _local_2.color = _friendList.laf.getTabBgColor(_arg_1.id);
            _local_2.addChild(getTabContentFooter(_arg_1));
            var _local_3:IItemListWindow = IItemListWindow(_local_2.findChildByName("list_content"));
            _local_3.color = _friendList.laf.getTabBgColor(_arg_1.id);
            _arg_1.tabView.fillList(_local_3);
            return (_local_2);
        }

        private function refreshTabContentDims(_arg_1:IWindowContainer):void
        {
            var _local_3:IWindowContainer = (_arg_1.getChildByName("footer") as IWindowContainer);
            var _local_6:IWindowContainer = (_arg_1.getChildByName("list") as IWindowContainer);
            var _local_8:IWindow = (_local_6.getChildByName("scroller") as IWindow);
            var _local_9:IItemListWindow = IItemListWindow(_local_6.getChildByName("list_content"));
            var _local_7:IWindow = _local_6.parent;
            var _local_4:int = _friendList.tabs.tabContentWidth;
            var _local_5:int = _friendList.tabs.tabContentHeight;
            _local_7.height = Math.max(0, _local_5);
            _local_7.width = _local_4;
            var _local_2:int = Math.max(((_local_5 - _local_6.y) - _local_3.height), 0);
            _local_6.height = _local_2;
            _local_8.height = _local_2;
            _local_9.height = _local_2;
            _local_6.width = _local_4;
            _local_9.width = _local_4;
            _local_8.x = (_local_4 - 27);
            _local_3.y = (_local_5 - _local_3.height);
            _local_3.width = _local_4;
        }

        private function refreshScrollBarVisibility(_arg_1:IWindowContainer):void
        {
            var _local_6:IWindowContainer = (_arg_1.getChildByName("list") as IWindowContainer);
            var _local_7:IWindow = (_local_6.getChildByName("scroller") as IWindow);
            var _local_9:IItemListWindow = IItemListWindow(_local_6.getChildByName("list_content"));
            var _local_3:Boolean = (_local_9.scrollableRegion.height > _local_9.height);
            var _local_2:int = 22;
            var _local_5:int = (_friendList.tabs.tabContentWidth - 10);
            var _local_8:int = (_local_5 - _local_2);
            var _local_4:int = ((_local_3) ? _local_8 : _local_5);
            _local_7.visible = _local_3;
            _local_9.width = _local_4;
            change(_local_9, _local_4);
        }

        private function change(_arg_1:IItemListWindow, _arg_2:int):void
        {
            var _local_3:int;
            var _local_4:IWindow;
            _local_3 = 0;
            while (_local_3 < _arg_1.numListItems)
            {
                _local_4 = _arg_1.getListItemAt(_local_3);
                _local_4.width = _arg_2;
                _local_3++;
            };
        }

        private function getTabContentFooter(_arg_1:FriendListTab):IWindow
        {
            var _local_2:IWindowContainer = IWindowContainer(this._friendList.getXmlWindow(_arg_1.footerName));
            _arg_1.tabView.fillFooter(_local_2);
            return (_local_2);
        }


    }
}

