package com.sulake.habbo.navigator.view
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.navigator.HabboNewNavigator;
    import com.sulake.habbo.navigator.view.search.SearchView;
    import com.sulake.habbo.navigator.view.search.results.BlockResultsView;
    import com.sulake.habbo.navigator.view.search.results.RoomEntryElementFactory;
    import com.sulake.habbo.navigator.view.search.results.CategoryElementFactory;
    import com.sulake.core.window.components._SafeStr_124;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.getTimer;
    import com.sulake.core.window.IWindow;
    import flash.geom.Rectangle;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.newnavigator.SavedSearch;
    import com.sulake.habbo.navigator.view.search.ViewMode;
    import com.sulake.habbo.communication.messages.incoming.newnavigator.SearchResultContainer;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IScrollableListWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.ITabContextWindow;
    import com.sulake.core.window.components.ITabButtonWindow;
    import com.sulake.core.window.events.WindowEvent;

    public class NavigatorView implements IUpdateReceiver 
    {

        private static const POPUP_HIDE_DELAY_MS:uint = 4000;
        private static const MAX_WINDOW_WIDTH:int = 578;
        private static const STARTING_TAB_POSITION:int = 115;
        private static const _SafeStr_2972:int = 7;
        private static const _SafeStr_2973:int = 7;

        private var _navigator:HabboNewNavigator;
        private var _SafeStr_2974:LiftView;
        private var _SafeStr_2975:QuickLinksView;
        private var _SafeStr_2976:SearchView;
        private var _SafeStr_2954:BlockResultsView;
        private var _SafeStr_2955:RoomEntryElementFactory;
        private var _SafeStr_2950:CategoryElementFactory;
        private var _SafeStr_1464:TopViewSelector;
        private var _roomInfoPopup:RoomInfoPopup;
        private var _SafeStr_2977:_SafeStr_124;
        private var _SafeStr_2978:_SafeStr_124;
        private var _SafeStr_2979:_SafeStr_124;
        private var _window:IWindowContainer;
        private var _isBusy:Boolean;
        private var _SafeStr_2980:uint = getTimer();
        private var _SafeStr_2843:int = -1;
        private var _SafeStr_2844:int = -1;
        private var _lastWindowWidth:int = -1;
        private var _SafeStr_2470:int = -1;
        private var _lastLeftPaneHidden:Boolean = false;
        private var _waitingForGroupDetails:int = -1;
        private var _SafeStr_2981:int = 4000;
        private var _SafeStr_2982:Boolean = false;
        private var _SafeStr_2983:int;
        private var _SafeStr_2984:int;
        private var _SafeStr_2300:IWindow;
        private var _leftPaneMargin:int;
        private var roomInfoGlobalRectangle:Rectangle = new Rectangle();

        public function NavigatorView(_arg_1:HabboNewNavigator)
        {
            _navigator = _arg_1;
        }

        public function set visible(_arg_1:Boolean):void
        {
            if (((_arg_1) && (_navigator.isReady)))
            {
                if (_SafeStr_2955 == null)
                {
                    _SafeStr_2955 = new RoomEntryElementFactory(_navigator);
                };
                if (_SafeStr_2950 == null)
                {
                    _SafeStr_2950 = new CategoryElementFactory(_navigator, _SafeStr_2955);
                };
                createSubViews();
                if (_window == null)
                {
                    createMainWindow();
                    _navigator.registerUpdateReceiver(this, 1000);
                    _SafeStr_2975.setQuickLinks(_navigator.contextContainer.savedSearches);
                };
                if (_navigator.currentResults != null)
                {
                    this.onSearchResults(_navigator.currentResults);
                }
                else
                {
                    if (!_isBusy)
                    {
                        _navigator.performSearch("official_view");
                    };
                };
                _window.activate();
            }
            else
            {
                if (_roomInfoPopup)
                {
                    _roomInfoPopup.show(false);
                };
            };
            if (_window)
            {
                _window.visible = _arg_1;
            };
        }

        public function get visible():Boolean
        {
            if (_window)
            {
                return (_window.visible);
            };
            return (false);
        }

        public function setInitialWindowDimensions(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Boolean, _arg_5:int):void
        {
            if (_window)
            {
                setLeftPaneVisibility((!(_arg_4)));
                _window.x = _arg_1;
                _window.y = _arg_2;
                _window.height = _arg_3;
            }
            else
            {
                _SafeStr_2843 = _arg_1;
                _SafeStr_2844 = _arg_2;
                _SafeStr_2470 = _arg_3;
                _lastLeftPaneHidden = _arg_4;
            };
        }

        public function onSavedSearches(_arg_1:Vector.<SavedSearch>):void
        {
            if (_SafeStr_2975)
            {
                _SafeStr_2975.setQuickLinks(_arg_1);
            };
        }

        private function createSubViews():void
        {
            if (_SafeStr_2954 == null)
            {
                _SafeStr_2954 = new BlockResultsView(_navigator);
                _SafeStr_2954.categoryElementFactory = _SafeStr_2950;
                _SafeStr_2950.blockResultsView = _SafeStr_2954;
            };
            if (_SafeStr_2976 == null)
            {
                _SafeStr_2976 = new SearchView(_navigator);
            };
            if (_SafeStr_2975 == null)
            {
                _SafeStr_2975 = new QuickLinksView(_navigator);
            };
            if (_SafeStr_2974 == null)
            {
            };
            if (_SafeStr_1464 == null)
            {
                _SafeStr_1464 = new TopViewSelector(_navigator);
            };
        }

        public function onSearchResults(_arg_1:SearchResultContainer, _arg_2:String=""):void
        {
            var _local_3:int;
            if (_navigator.newResultsRendered)
            {
                return;
            };
            if (((!(_SafeStr_2955)) || (!(_SafeStr_2954))))
            {
                return;
            };
            _SafeStr_2955.viewMode = ViewMode.getViewMode(_arg_1.searchCodeOriginal);
            _SafeStr_2954.displayCurrentResults();
            if (_navigator.contextContainer.hasContextFor(_arg_1.searchCodeOriginal))
            {
                _local_3 = _navigator.contextContainer.getTopLevelSearches().indexOf(_arg_1.searchCodeOriginal);
                if (_local_3 != -1)
                {
                    _SafeStr_1464.selectTabByIndex(_local_3);
                };
            };
            _window.findChildByName("create_room").procedure = createRoomProcedure;
            _window.findChildByName("random_room_border").visible = false;
            _window.findChildByName("promote_room_border").visible = false;
            if (((_arg_1.searchCodeOriginal == "roomads_view") || (_arg_1.searchCodeOriginal == "myworld_view")))
            {
                _window.findChildByName("promote_room_border").visible = true;
                _window.findChildByName("promote_room").procedure = promoteRoomProcedure;
            }
            else
            {
                _window.findChildByName("random_room_border").visible = true;
                _window.findChildByName("random_room").procedure = randomRoomProcedure;
            };
            _SafeStr_2976.setTextAndSearchModeFromFilter(_arg_1.filteringData, _arg_2);
            _navigator.newResultsRendered = true;
            isBusy = false;
            if (_roomInfoPopup)
            {
                _roomInfoPopup.show(false);
            };
        }

        public function currentFilterText():String
        {
            if (_SafeStr_2976 != null)
            {
                return (_SafeStr_2976.currentInput);
            };
            return (null);
        }

        public function refreshLiftedRooms():void
        {
            if (_SafeStr_2974)
            {
                _SafeStr_2974.refresh();
            };
        }

        public function showRoomInfoBubbleAt(_arg_1:GuestRoomData, _arg_2:int, _arg_3:int, _arg_4:Boolean=false):void
        {
            _SafeStr_2982 = true;
            if (!_window)
            {
                return;
            };
            if (!_roomInfoPopup)
            {
                _roomInfoPopup = new RoomInfoPopup(_navigator);
            };
            if (((_roomInfoPopup.visible) && (!(_arg_4))))
            {
                _roomInfoPopup.show(false);
            }
            else
            {
                _roomInfoPopup.setData(_arg_1);
                if (((!(_arg_1.habboGroupId == 0)) && (_navigator.getCachedGroupDetails(_arg_1.habboGroupId) == null)))
                {
                    _navigator.getGuildInfo(_arg_1.habboGroupId, false);
                    _waitingForGroupDetails = _arg_1.habboGroupId;
                };
                _roomInfoPopup.showAt(true, _arg_2, _arg_3);
                _navigator.trackEventLog("browse.openroominfo", "Results", _arg_1.roomName, _arg_1.flatId);
                _SafeStr_2981 = 4000;
            };
        }

        public function get mainWindow():IFrameWindow
        {
            return (_window as IFrameWindow);
        }

        public function set isBusy(_arg_1:Boolean):void
        {
            if (_window)
            {
                _window.caption = ((_arg_1) ? "${navigator.title.is.busy}" : "${navigator.title}");
                _window.findChildByName("search_waiting_for_results_mask").visible = _arg_1;
            };
            _isBusy = _arg_1;
        }

        public function get isBusy():Boolean
        {
            return (_isBusy);
        }

        private function createMainWindow():void
        {
            var _local_8:IWindowContainer = IWindowContainer(_navigator.windowManager.buildFromXML(XML(_navigator.assets.getAssetByName("navigator_frame_2_xml").content)));
            IScrollableListWindow(_local_8.findChildByName("block_results")).autoHideScrollBar = false;
            var _local_10:IWindowContainer = IWindowContainer(_local_8.findChildByName("navigator_entry_row_container"));
            _SafeStr_2955.rowEntryTemplate = IWindowContainer(_local_10.clone());
            _local_10.destroy();
            var _local_4:IItemListWindow = IItemListWindow(_local_8.findChildByName("navigator_entry_tile_container").clone());
            var _local_5:IWindowContainer = IWindowContainer(_local_4.getListItemByName("navigator_entry_tile").clone());
            _SafeStr_2955.tileEntryTemplate = _local_5;
            _local_4.destroyListItems();
            _SafeStr_2955.tileContainerTemplate = _local_4;
            IItemListWindow(_local_8.findChildByName("category_content")).destroyListItems();
            var _local_9:IWindowContainer = IWindowContainer(_local_8.findChildByName("category_container"));
            _SafeStr_2950.categoryTemplate = IWindowContainer(_local_9.clone());
            IItemListWindow(_local_8.findChildByName("block_results")).removeListItemAt(0);
            _local_9.destroy();
            var _local_1:IWindowContainer = IWindowContainer(_local_8.findChildByName("category_container_collapsed"));
            _SafeStr_2950.collapsedCategoryTemplate = IWindowContainer(_local_1.clone());
            IItemListWindow(_local_8.findChildByName("block_results")).removeListItemAt(0);
            _local_1.destroy();
            var _local_6:IWindowContainer = IWindowContainer(_local_8.findChildByName("no_results_container"));
            _SafeStr_2950.noResultsTemplate = IWindowContainer(_local_6.clone());
            IItemListWindow(_local_8.findChildByName("block_results")).removeListItemAt(0);
            _local_6.destroy();
            _SafeStr_2954.itemList = IItemListWindow(_local_8.findChildByName("block_results"));
            _SafeStr_2976.container = IWindowContainer(_local_8.findChildByName("search_tools"));
            var _local_3:IRegionWindow = IRegionWindow(_local_8.findChildByName("quick_link"));
            _local_3.findChildByName("quick_link_text").caption = "";
            _SafeStr_2975.template = IRegionWindow(_local_3.clone());
            _SafeStr_2975.itemList = IItemListWindow(_local_8.findChildByName("quicklinks_list"));
            IItemListWindow(_local_8.findChildByName("quicklinks_list")).removeListItems();
            _local_3.destroy();
            var _local_2:ITabContextWindow = ITabContextWindow(_local_8.findChildByName("top_view_select_tab_context"));
            var _local_7:ITabButtonWindow = ITabButtonWindow(_local_2.getTabItemAt(0).clone());
            _SafeStr_1464.template = _local_7;
            _SafeStr_1464.tabContext = _local_2;
            _local_2.removeTabItem(_local_7);
            _SafeStr_1464.refresh();
            _SafeStr_2977 = _SafeStr_124(_local_8.findChildByName("create_room_border").clone());
            IItemListWindow(_local_8.findChildByName("left_pane")).removeListItem(_local_8.findChildByName("create_room_border"));
            _SafeStr_2978 = _SafeStr_124(_local_8.findChildByName("promote_room_border").clone());
            IItemListWindow(_local_8.findChildByName("left_pane")).removeListItem(_local_8.findChildByName("promote_room_border"));
            _SafeStr_2979 = _SafeStr_124(_local_8.findChildByName("random_room_border").clone());
            IItemListWindow(_local_8.findChildByName("left_pane")).removeListItem(_local_8.findChildByName("random_room_border"));
            _leftPaneMargin = _local_8.findChildByName("left_pane").x;
            _local_8.findChildByName("refreshButton").procedure = refreshSearchResults;
            _local_8.findChildByName("header_button_close").procedure = headerProcedure;
            _SafeStr_2983 = 7;
            _local_8.findChildByName("temp_back").procedure = leftPaneShowHideProcedure;
            _SafeStr_2300 = _local_8.findChildByName("right_pane");
            _SafeStr_2984 = _SafeStr_2300.x;
            _window = _local_8;
            setLeftPaneVisibility(false);
            if (((_SafeStr_2843 == -1) && (_SafeStr_2844 == -1)))
            {
                _SafeStr_2843 = _window.x;
                _SafeStr_2844 = _window.y;
                _lastWindowWidth = _window.width;
                _SafeStr_2470 = _window.height;
            }
            else
            {
                if (_lastLeftPaneHidden)
                {
                    setLeftPaneVisibility(true);
                };
                _window.x = _SafeStr_2843;
                _window.y = _SafeStr_2844;
                _window.height = _SafeStr_2470;
            };
            _SafeStr_2980 = getTimer();
        }

        private function refreshSearchResults(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((_arg_1.type == "WME_CLICK") && (_arg_2.name == "refreshButton")))
            {
                _navigator.performLastSearch();
            };
        }

        private function headerProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                if (_arg_2.name == "header_button_close")
                {
                    visible = false;
                };
            };
        }

        private function createRoomProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _navigator.createRoom();
                if (_roomInfoPopup)
                {
                    _roomInfoPopup.show(false);
                };
            };
        }

        private function promoteRoomProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _navigator.context.createLinkEvent("catalog/open/room_ad");
                if (_roomInfoPopup)
                {
                    _roomInfoPopup.show(false);
                };
            };
        }

        private function randomRoomProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _navigator.context.createLinkEvent("navigator/goto/random_friending_room");
                if (_roomInfoPopup)
                {
                    _roomInfoPopup.show(false);
                };
                visible = false;
            };
        }

        private function leftPaneShowHideProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:IWindow;
            if (_arg_1.type == "WME_CLICK")
            {
                _local_3 = _window.findChildByName("left_pane");
                setLeftPaneVisibility((!(_local_3.visible)));
                if (_roomInfoPopup)
                {
                    _roomInfoPopup.show(false);
                };
            };
        }

        public function setLeftPaneVisibility(_arg_1:Boolean):void
        {
            var _local_3:int;
            var _local_2:IWindow = _window.findChildByName("left_pane");
            var _local_5:int = ((_SafeStr_2984 - _leftPaneMargin) + 7);
            _SafeStr_2300.setParamFlag(0, true);
            _SafeStr_2300.setParamFlag(128, false);
            if (!_arg_1)
            {
                _local_2.visible = false;
                _SafeStr_2300.x = _SafeStr_2983;
                _window.limits.minWidth = ((_window.width - _local_5) + _SafeStr_2983);
                _window.limits.maxWidth = ((_window.width - _local_5) + _SafeStr_2983);
                _window.width = ((_window.width - _local_5) + _SafeStr_2983);
            }
            else
            {
                _local_2.visible = true;
                _SafeStr_2300.x = _SafeStr_2984;
                _local_3 = ((_window.width + _local_5) - _SafeStr_2983);
                _window.limits.minWidth = ((_local_3 > 578) ? 578 : _local_3);
                _window.limits.maxWidth = ((_local_3 > 578) ? 578 : _local_3);
                _window.width = ((_local_3 > 578) ? 578 : _local_3);
            };
            _SafeStr_2300.setParamFlag(0, false);
            _SafeStr_2300.setParamFlag(128, true);
            _window.findChildByName("left_hide_container").visible = _arg_1;
            _window.findChildByName("left_show_container").visible = (!(_arg_1));
            var _local_4:int = ((_arg_1) ? 115 : (115 - (_local_5 / 2)));
            _window.findChildByName("top_view_select_tab_context").x = _local_4;
        }

        private function keepWindowInsideScreenRegion():void
        {
            _window.x = Math.max(0, _window.x);
            _window.y = Math.max(0, _window.y);
            if (_window.desktop)
            {
                _window.x = Math.min((_window.desktop.width - _window.width), _window.x);
                _window.y = Math.min((_window.desktop.height - _window.height), _window.y);
            };
        }

        private function sendWindowPreferences():void
        {
            _SafeStr_2843 = _window.x;
            _SafeStr_2844 = _window.y;
            _lastWindowWidth = _window.width;
            _SafeStr_2470 = _window.height;
            _lastLeftPaneHidden = _window.findChildByName("left_pane").visible;
            _SafeStr_2980 = getTimer();
            _navigator.sendWindowPreferences(_SafeStr_2843, _SafeStr_2844, _lastWindowWidth, _SafeStr_2470, _lastLeftPaneHidden, 0);
            _navigator.trackEventLog("windowsettings", "Interface", ((_window.width + " x ") + _window.height));
        }

        private function get windowPreferencesChanged():Boolean
        {
            if (_lastLeftPaneHidden != _window.findChildByName("left_pane").visible)
            {
                return (true);
            };
            if (_SafeStr_2843 != _window.x)
            {
                return (true);
            };
            if (_SafeStr_2844 != _window.y)
            {
                return (true);
            };
            if (_SafeStr_2470 != _window.height)
            {
                return (true);
            };
            return (false);
        }

        public function update(_arg_1:uint):void
        {
            var _local_2:uint = getTimer();
            if (((windowPreferencesChanged) && ((_local_2 - _SafeStr_2980) > 5000)))
            {
                sendWindowPreferences();
            };
            keepWindowInsideScreenRegion();
            _SafeStr_2981 = (_SafeStr_2981 - _arg_1);
            if (((isRoomInfoBubbleVisible) && (_SafeStr_2981 < 0)))
            {
                _roomInfoPopup.getGlobalRectangle(roomInfoGlobalRectangle);
                if (!roomInfoGlobalRectangle.contains(_window.desktop.mouseX, _window.desktop.mouseY))
                {
                    _roomInfoPopup.show(false);
                };
            };
        }

        public function dispose():void
        {
            _navigator.removeUpdateReceiver(this);
        }

        public function get disposed():Boolean
        {
            return (false);
        }

        public function onGroupDetailsArrived(_arg_1:int):void
        {
            if (_waitingForGroupDetails == _arg_1)
            {
                _waitingForGroupDetails = -1;
            };
        }

        public function get isRoomInfoBubbleVisible():Boolean
        {
            if (_roomInfoPopup)
            {
                return (_roomInfoPopup.visible);
            };
            return (false);
        }


    }
}

