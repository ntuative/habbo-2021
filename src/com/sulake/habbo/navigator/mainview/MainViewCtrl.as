package com.sulake.habbo.navigator.mainview
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Point;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITabContextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.navigator.TextSearchInputs;
    import flash.utils.Timer;
    import com.sulake.habbo.utils.WindowToggle;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.navigator.IViewCtrl;
    import com.sulake.habbo.navigator.domain.Tab;
    import com.sulake.core.window.components.ITabButtonWindow;
    import com.sulake.habbo.navigator.Util;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.window.events.WindowEvent;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomAdEventTabViewedComposer;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetPopularRoomTagsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetOfficialRoomsMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.navigator.CompetitionRoomsData;
    import com.sulake.habbo.communication.messages.outgoing.navigator.MyFavouriteRoomsSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.MyFriendsRoomsSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.MyRoomHistorySearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.MyRoomsSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.PopularRoomsSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomsWhereMyFriendsAreSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomsWithHighestScoreSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomTextSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GuildBaseSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.CompetitionRoomsSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomAdSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.MyRoomRightsSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.MyGuildBasesSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.MyRecommendedRoomsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.MyFrequentRoomHistorySearchMessageComposer;
    import com.sulake.core.communication.messages.IMessageComposer;
    import flash.events.TimerEvent;

    public class MainViewCtrl implements ITransitionalMainViewCtrl, IUpdateReceiver, IDisposable 
    {

        public static const SEARCHMSG_SEARCH:int = 1;
        public static const _SafeStr_2917:int = 2;
        public static const SEARCHMSG_OFFICIALROOMS:int = 4;
        public static const _SafeStr_2918:int = 5;
        private static const BLEND_STAGE_BLENDING_OUT:int = 1;
        private static const BLEND_STAGE_LOADING:int = 2;
        private static const BLEND_STAGE_REFRESHING:int = 3;
        private static const BLEND_STAGE_BLENDING_IN:int = 4;
        private static const SCROLLBAR_WIDTH:int = 22;
        private static const PANIC_BUTTON_HEIGHT:int = 60;

        private const DEFAULT_VIEW_LOCATION:Point = new Point(100, 10);

        private var _navigator:HabboNavigator;
        private var _mainWindow:IFrameWindow;
        private var _content:IWindowContainer;
        private var _SafeStr_2919:IWindowContainer;
        private var _footer:IWindowContainer;
        private var _SafeStr_2920:IWindowContainer;
        private var _SafeStr_2921:PopularTagsListCtrl;
        private var _guestRooms:GuestRoomListCtrl;
        private var _officialRooms:OfficialRoomListCtrl;
        private var _SafeStr_2922:RoomAdListCtrl;
        private var _SafeStr_2923:CategoryListCtrl;
        private var _tabContext:ITabContextWindow;
        private var _SafeStr_2924:Boolean;
        private var _SafeStr_2925:int;
        private var _SafeStr_2926:Boolean = true;
        private var _SafeStr_2927:int = 0;
        private var _loadingText:IWindow;
        private var _SafeStr_2928:int = 0;
        private var _searchInput:TextSearchInputs;
        private var _SafeStr_2821:Timer;
        private var _disposed:Boolean = false;
        private var _SafeStr_2929:WindowToggle;
        private var _isPhaseOneNavigator:Boolean = false;

        public function MainViewCtrl(_arg_1:HabboNavigator):void
        {
            _navigator = _arg_1;
            _SafeStr_2921 = new PopularTagsListCtrl(_navigator);
            _guestRooms = new GuestRoomListCtrl(_navigator, 0, false);
            _officialRooms = new OfficialRoomListCtrl(_navigator);
            _SafeStr_2922 = new RoomAdListCtrl(_navigator, 0, false);
            _SafeStr_2923 = new CategoryListCtrl(_navigator);
            _SafeStr_2821 = new Timer(300, 1);
            _SafeStr_2821.addEventListener("timer", onResizeTimer);
        }

        private static function refreshScrollbar(_arg_1:IViewCtrl, _arg_2:Boolean):void
        {
            var _local_4:IItemListWindow;
            var _local_5:IWindow;
            if (((_arg_1.content == null) || (!(_arg_1.content.visible))))
            {
                return;
            };
            _local_4 = IItemListWindow(_arg_1.content.findChildByName("item_list"));
            _local_5 = _arg_1.content.findChildByName("scroller");
            var _local_3:Boolean = (_local_4.scrollableRegion.height > _local_4.height);
            if (_local_5.visible)
            {
                if (!_local_3)
                {
                    _local_5.visible = false;
                    _local_4.width = (_local_4.width + 22);
                };
            }
            else
            {
                if (_local_3)
                {
                    _local_5.visible = true;
                    _local_4.width = (_local_4.width - 22);
                };
            };
        }

        public static function stretchNewEntryIfNeeded(_arg_1:IViewCtrl, _arg_2:IWindowContainer):void
        {
            var _local_3:IWindow = _arg_1.content.findChildByName("scroller");
            if (((_local_3 == null) || (_local_3.visible)))
            {
                return;
            };
            _arg_2.width = (_arg_2.width + 22);
        }


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function onNavigatorToolBarIconClick():void
        {
            if (!_mainWindow)
            {
                reloadData();
                return;
            };
            if (((!(_SafeStr_2929)) || (_SafeStr_2929.disposed)))
            {
                _SafeStr_2929 = new WindowToggle(_mainWindow, _mainWindow.desktop, reloadData, close);
            };
            _SafeStr_2929.toggle();
        }

        private function reloadData():void
        {
            var _local_1:Tab = _navigator.tabs.getSelected();
            _local_1.tabPageDecorator.navigatorOpenedWhileInTab();
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                _disposed = true;
                _navigator = null;
                if (_mainWindow)
                {
                    _mainWindow.dispose();
                    _mainWindow = null;
                };
                if (_SafeStr_2929)
                {
                    _SafeStr_2929.dispose();
                    _SafeStr_2929 = null;
                };
                if (_content)
                {
                    _content.dispose();
                    _content = null;
                };
                if (_SafeStr_2821)
                {
                    _SafeStr_2821.removeEventListener("timer", onResizeTimer);
                    _SafeStr_2821.reset();
                    _SafeStr_2821 = null;
                };
                if (_SafeStr_2921)
                {
                    _SafeStr_2921.dispose();
                    _SafeStr_2921 = null;
                };
                if (_guestRooms)
                {
                    _guestRooms.dispose();
                    _guestRooms = null;
                };
                if (_officialRooms)
                {
                    _officialRooms.dispose();
                    _officialRooms = null;
                };
                if (_SafeStr_2922)
                {
                    _SafeStr_2922.dispose();
                    _SafeStr_2922 = null;
                };
                if (_searchInput)
                {
                    _searchInput.dispose();
                    _searchInput = null;
                };
            };
        }

        public function open():void
        {
            if (_mainWindow == null)
            {
                prepare();
            };
            refresh();
            _mainWindow.visible = true;
            _mainWindow.y = Math.max(_mainWindow.y, 60);
            _mainWindow.activate();
        }

        public function isOpen():Boolean
        {
            return ((!(_mainWindow == null)) && (_mainWindow.visible));
        }

        public function close():void
        {
            if (_mainWindow != null)
            {
                if (_searchInput)
                {
                    _searchInput.dispose();
                    _searchInput = null;
                };
                if (_SafeStr_2929)
                {
                    _SafeStr_2929.dispose();
                    _SafeStr_2929 = null;
                };
                _mainWindow.dispose();
                _mainWindow = null;
                _tabContext = null;
                _content = null;
                _SafeStr_2919 = null;
                _SafeStr_2920 = null;
                _footer = null;
                _loadingText = null;
                _SafeStr_2921.content = null;
                _guestRooms.content = null;
                _officialRooms.content = null;
                _SafeStr_2923.content = null;
                _SafeStr_2922.content = null;
                _SafeStr_2928 = 0;
            };
        }

        public function get mainWindow():IFrameWindow
        {
            return (_mainWindow);
        }

        private function prepare():void
        {
            var _local_4:Array;
            var _local_7:ITabButtonWindow;
            var _local_5:ITabButtonWindow;
            var _local_2:Boolean = _navigator.getBoolean("eventinfo.enabled");
            var _local_6:Boolean;
            _mainWindow = IFrameWindow(_navigator.getXmlWindow("grs_main_window_new"));
            _tabContext = ITabContextWindow(_mainWindow.findChildByName("tab_context"));
            _content = IWindowContainer(_mainWindow.findChildByName("tab_content"));
            _SafeStr_2919 = IWindowContainer(_mainWindow.findChildByName("custom_content"));
            _SafeStr_2920 = IWindowContainer(_mainWindow.findChildByName("list_content"));
            _footer = IWindowContainer(_mainWindow.findChildByName("custom_footer"));
            _loadingText = _mainWindow.findChildByName("loading_text");
            var _local_3:IWindow = _mainWindow.findChildByTag("close");
            if (_local_3 != null)
            {
                _local_3.addEventListener("WME_CLICK", onWindowClose);
            };
            _mainWindow.addEventListener("WE_RESIZED", onWindowResized);
            if (((!(_local_2)) || (!(_isPhaseOneNavigator))))
            {
                _local_4 = [];
                while (_tabContext.numTabItems > 0)
                {
                    _local_7 = _tabContext.getTabItemAt(0);
                    _local_4.push(_local_7);
                    _tabContext.removeTabItem(_local_7);
                };
                for each (_local_7 in _local_4)
                {
                    if (!(((_local_7.id == 1) && (!(_local_2))) || ((_local_7.id == 6) && (!(_local_6)))))
                    {
                        _tabContext.addTabItem(_local_7);
                    };
                };
            };
            for each (var _local_1:Tab in _navigator.tabs.tabs)
            {
                _local_5 = _tabContext.getTabItemByID(_local_1.id);
                if (_local_5 != null)
                {
                    _local_5.addEventListener("WE_SELECTED", onTabSelected);
                    _local_1.button = _local_5;
                };
            };
            _mainWindow.scaler.setParamFlag(0x3000, false);
            _mainWindow.scaler.setParamFlag(0x2000, true);
            _mainWindow.position = DEFAULT_VIEW_LOCATION;
            createSearchInput();
        }

        private function createSearchInput():void
        {
            var _local_1:IWindowContainer;
            var _local_2:String = "search_header";
            if (_searchInput == null)
            {
                _local_1 = (_mainWindow.findChildByName(_local_2) as IWindowContainer);
                _searchInput = new TextSearchInputs(_navigator, _local_1);
            };
            var _local_3:IWindowContainer = (_mainWindow.findChildByName(_local_2) as IWindowContainer);
            _local_3.visible = true;
        }

        public function refresh():void
        {
            if (_mainWindow == null)
            {
                return;
            };
            refreshTab();
            refreshCustomContent();
            refreshListContent(true);
            refreshFooter();
            _SafeStr_2919.height = Util.getLowestPoint(_SafeStr_2919);
            _footer.height = Util.getLowestPoint(_footer);
            var _local_1:int = _SafeStr_2920.y;
            Util.moveChildrenToColumn(_content, ["custom_content", "list_content"], _SafeStr_2919.y, 8);
            _SafeStr_2920.height = ((((_SafeStr_2920.height + _local_1) - _SafeStr_2920.y) - _footer.height) + _SafeStr_2928);
            Util.moveChildrenToColumn(_content, ["list_content", "custom_footer"], _SafeStr_2920.y, 0);
            _SafeStr_2928 = _footer.height;
            onResizeTimer(null);
        }

        private function refreshTab():void
        {
            var _local_2:Tab = _navigator.tabs.getSelected();
            var _local_1:ISelectableWindow = _tabContext.selector.getSelected();
            if (_local_2.button != _local_1)
            {
                _SafeStr_2924 = true;
                _tabContext.selector.setSelected(_local_2.button);
            };
        }

        private function refreshCustomContent():void
        {
            Util.hideChildren(_SafeStr_2919);
            var _local_1:Tab = _navigator.tabs.getSelected();
            _local_1.tabPageDecorator.refreshCustomContent(_SafeStr_2919);
            if (Util.hasVisibleChildren(_SafeStr_2919))
            {
                _SafeStr_2919.visible = true;
            }
            else
            {
                _SafeStr_2919.visible = false;
                _SafeStr_2919.blend = 1;
            };
        }

        private function refreshFooter():void
        {
            Util.hideChildren(_footer);
            var _local_1:Tab = _navigator.tabs.getSelected();
            _local_1.tabPageDecorator.refreshFooter(_footer);
            _footer.visible = Util.hasVisibleChildren(_footer);
        }

        private function refreshListContent(_arg_1:Boolean):void
        {
            Util.hideChildren(_SafeStr_2920);
            var _local_2:Tab = _navigator.tabs.getSelected();
            var _local_3:Boolean = ((_navigator.data.guestRoomSearchArrived) && (_local_2.defaultSearchType == 16));
            refreshRoomAds(_arg_1, _local_3);
            refreshGuestRooms(_arg_1, (!(_local_3)));
            refreshPopularTags(_arg_1, _navigator.data.popularTagsArrived);
            refreshOfficialRooms(_arg_1, _navigator.data.officialRoomsArrived);
        }

        private function refreshGuestRooms(_arg_1:Boolean, _arg_2:Boolean):void
        {
            refreshList(_arg_1, _arg_2, _guestRooms, "guest_rooms");
        }

        private function refreshPopularTags(_arg_1:Boolean, _arg_2:Boolean):void
        {
            refreshList(_arg_1, _arg_2, _SafeStr_2921, "popular_tags");
        }

        private function refreshOfficialRooms(_arg_1:Boolean, _arg_2:Boolean):void
        {
            refreshList(_arg_1, _arg_2, _officialRooms, "official_rooms");
        }

        private function refreshRoomAds(_arg_1:Boolean, _arg_2:Boolean):void
        {
            refreshList(_arg_1, _arg_2, _SafeStr_2922, "room_ads");
        }

        private function refreshCategoryList(_arg_1:Boolean, _arg_2:Boolean):void
        {
            refreshList(_arg_1, _arg_2, _SafeStr_2923, "categories_container");
        }

        private function refreshList(_arg_1:Boolean, _arg_2:Boolean, _arg_3:IViewCtrl, _arg_4:String):void
        {
            var _local_5:IWindow;
            if (_arg_2)
            {
                if (_arg_3.content == null)
                {
                    _local_5 = _SafeStr_2920.findChildByName(_arg_4);
                    _arg_3.content = IWindowContainer(_local_5);
                };
                if (_arg_1)
                {
                    _arg_3.refresh();
                };
                _arg_3.content.visible = true;
            };
        }

        private function onWindowClose(_arg_1:WindowEvent):void
        {
            Logger.log("Close navigator window");
            this.close();
        }

        private function onTabSelected(_arg_1:WindowEvent):void
        {
            var _local_4:IWindow = _arg_1.target;
            var _local_2:int = _local_4.id;
            if (_SafeStr_2924)
            {
                _SafeStr_2924 = false;
                return;
            };
            var _local_3:Tab = _navigator.tabs.getTab(_local_2);
            _local_3.sendSearchRequest();
            switch (_local_3.id)
            {
                case 1:
                    _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_EVENTS"));
                    _navigator.send(new RoomAdEventTabViewedComposer());
                    return;
                case 3:
                    _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_ME"));
                    return;
                case 4:
                    _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_OFFICIAL"));
                    return;
                case 2:
                    _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_ROOMS"));
                    return;
                case 5:
                    _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCH"));
                    return;
                case 6:
                    _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_CATEGORIES"));
                default:
            };
        }

        public function reloadRoomList(_arg_1:int):Boolean
        {
            ErrorReportStorage.addDebugData("MainViewCtrl", "Reloading RoomList");
            if ((((this.isOpen()) && (!(this._navigator.data.guestRoomSearchResults == null))) && (this._navigator.data.guestRoomSearchResults.searchType == _arg_1)))
            {
                startSearch(_navigator.tabs.getSelected().id, _arg_1, "");
                return (true);
            };
            return (false);
        }

        public function startSearch(_arg_1:int, _arg_2:int, _arg_3:String="-1", _arg_4:int=1):void
        {
            var _local_5:Tab = _navigator.tabs.getSelected();
            _navigator.tabs.setSelectedTab(_arg_1);
            var _local_6:Tab = _navigator.tabs.getSelected();
            ErrorReportStorage.addDebugData("StartSearch", ((("Start search " + _local_5.id) + " => ") + _local_6.id));
            if (_isPhaseOneNavigator)
            {
                if (_arg_3.substr(0, 1) == "#")
                {
                    _arg_2 = 9;
                    _arg_3 = _arg_3.substr(1, (_arg_3.length - 1));
                };
            };
            this._SafeStr_2926 = (!(_local_5 == _local_6));
            if (_local_5 != _local_6)
            {
                _local_6.tabPageDecorator.tabSelected();
            };
            _navigator.data.startLoading();
            if (_arg_4 == 1)
            {
                _navigator.send(getSearchMsg(_arg_2, _arg_3));
            }
            else
            {
                if (_arg_4 == 2)
                {
                    _navigator.send(new GetPopularRoomTagsMessageComposer());
                }
                else
                {
                    if (_arg_4 != 5)
                    {
                        _navigator.send(new GetOfficialRoomsMessageComposer(_navigator.data.adIndex));
                    };
                };
            };
            if (!isOpen())
            {
                open();
                this._SafeStr_2925 = 2;
                this._SafeStr_2920.blend = 0;
                if (this._SafeStr_2919.visible)
                {
                    this._SafeStr_2919.blend = 0;
                    this._footer.blend = 0;
                };
            }
            else
            {
                this._SafeStr_2925 = 1;
            };
            this._SafeStr_2927 = 0;
            _navigator.registerUpdateReceiver(this, 2);
            sendTrackingEvent(_arg_2);
            _navigator.data.competitionRoomsData = null;
            if (_isPhaseOneNavigator)
            {
                if (((!(searchInput == null)) && (!(_arg_3 == "-1"))))
                {
                    if (_arg_2 != 1)
                    {
                        searchInput.setText(_arg_3, _arg_2);
                    };
                };
            };
        }

        private function sendTrackingEvent(_arg_1:int):void
        {
            switch (_arg_1)
            {
                case 6:
                    _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FAVOURITES"));
                    return;
                case 3:
                    _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FRIENDS_ROOMS"));
                    return;
                case 7:
                    _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_HISTORY"));
                    return;
                case 5:
                    _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_ROOMS"));
                    return;
                case 11:
                    _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_OFFICIALROOMS"));
                    return;
                case 1:
                    _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_POPULAR_ROOMS"));
                    return;
                case 4:
                    _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WHERE_MY_FRIENDS_ARE"));
                    return;
                case 2:
                    _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WITH_HIGHEST_SCORE"));
                    return;
                case 9:
                    _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TAG_SEARCH"));
                    return;
                case 8:
                    _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TEXT_SEARCH"));
                    return;
                case 23:
                    _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FREQUENT_HISTORY"));
                    return;
            };
        }

        private function getSearchMsg(_arg_1:int, _arg_2:String):IMessageComposer
        {
            var _local_3:CompetitionRoomsData;
            switch (_arg_1)
            {
                case 6:
                    return (new MyFavouriteRoomsSearchMessageComposer());
                case 3:
                    return (new MyFriendsRoomsSearchMessageComposer());
                case 7:
                    return (new MyRoomHistorySearchMessageComposer());
                case 5:
                    return (new MyRoomsSearchMessageComposer());
                case 1:
                    return (new PopularRoomsSearchMessageComposer(_arg_2, _navigator.data.adIndex));
                case 4:
                    return (new RoomsWhereMyFriendsAreSearchMessageComposer());
                case 2:
                    return (new RoomsWithHighestScoreSearchMessageComposer(_navigator.data.adIndex));
                case 9:
                    return (new RoomTextSearchMessageComposer(("tag:" + _arg_2)));
                case 8:
                    return (new RoomTextSearchMessageComposer(_arg_2));
                case 13:
                    return (new RoomTextSearchMessageComposer(("group:" + _arg_2)));
                case 10:
                    return (new RoomTextSearchMessageComposer(("roomname:" + _arg_2)));
                case 14:
                    return (new GuildBaseSearchMessageComposer(_navigator.data.adIndex));
                case 15:
                    _local_3 = _navigator.data.competitionRoomsData;
                    return (new CompetitionRoomsSearchMessageComposer(_local_3.goalId, _local_3.pageIndex));
                case 16:
                case 17:
                    return (new RoomAdSearchMessageComposer(_navigator.data.adIndex, _arg_1));
                case 18:
                    return (new MyRoomRightsSearchMessageComposer());
                case 19:
                    return (new MyGuildBasesSearchMessageComposer());
                case 20:
                    return (new RoomTextSearchMessageComposer(("owner:" + _arg_2)));
                case 22:
                    return (new MyRecommendedRoomsMessageComposer());
                case 23:
                    return (new MyFrequentRoomHistorySearchMessageComposer());
            };
            Logger.log(("No message for searchType: " + _arg_1));
            return (null);
        }

        public function update(_arg_1:uint):void
        {
            var _local_3:Number;
            if (this._SafeStr_2920 == null)
            {
                return;
            };
            var _local_2:Number = (_arg_1 / 150);
            if (_SafeStr_2925 == 1)
            {
                _local_3 = Math.min(1, Math.max(0, (this._SafeStr_2920.blend - _local_2)));
                this._SafeStr_2920.blend = _local_3;
                this._SafeStr_2919.blend = ((_SafeStr_2926) ? _local_3 : 1);
                this._footer.blend = ((_SafeStr_2926) ? _local_3 : 1);
                if (_local_3 == 0)
                {
                    _SafeStr_2925 = 2;
                };
            }
            else
            {
                if (_SafeStr_2925 == 2)
                {
                    if ((_SafeStr_2927 % 10) == 1)
                    {
                        _loadingText.visible = (!(_loadingText.visible));
                    };
                    _SafeStr_2927++;
                    if (!_navigator.data.isLoading())
                    {
                        _SafeStr_2925 = 3;
                    };
                }
                else
                {
                    if (_SafeStr_2925 == 3)
                    {
                        this.refresh();
                        _SafeStr_2925 = 4;
                    }
                    else
                    {
                        _loadingText.visible = false;
                        _local_3 = Math.min(1, Math.max(0, (this._SafeStr_2920.blend + _local_2)));
                        this._SafeStr_2920.blend = _local_3;
                        this._SafeStr_2919.blend = ((_SafeStr_2926) ? _local_3 : 1);
                        this._footer.blend = ((_SafeStr_2926) ? _local_3 : 1);
                        if (_SafeStr_2920.blend >= 1)
                        {
                            _navigator.removeUpdateReceiver(this);
                        };
                    };
                };
            };
        }

        private function onWindowResized(_arg_1:WindowEvent):void
        {
            var _local_2:IWindow = _arg_1.target;
            if (_local_2 != _mainWindow)
            {
                return;
            };
            if (!this._SafeStr_2821.running)
            {
                this._SafeStr_2821.reset();
                this._SafeStr_2821.start();
            };
        }

        private function onResizeTimer(_arg_1:TimerEvent):void
        {
            refreshScrollbar(_SafeStr_2921, false);
            refreshScrollbar(_guestRooms, false);
            refreshScrollbar(_SafeStr_2922, false);
            if (_navigator.isPerkAllowed("NAVIGATOR_PHASE_ONE_2014"))
            {
            };
        }

        public function get searchInput():TextSearchInputs
        {
            return (_searchInput);
        }

        public function openAtPosition(_arg_1:Point):void
        {
            reloadData();
            if (_arg_1 != null)
            {
                _mainWindow.position = _arg_1;
            }
            else
            {
                if (_mainWindow.position.x == 0)
                {
                    _mainWindow.position = DEFAULT_VIEW_LOCATION;
                };
            };
        }

        public function get isPhaseOneNavigator():Boolean
        {
            return (_isPhaseOneNavigator);
        }


    }
}

