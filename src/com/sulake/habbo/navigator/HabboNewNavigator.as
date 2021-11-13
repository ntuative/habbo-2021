package com.sulake.habbo.navigator
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.events.ILinkEventTracker;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.navigator.transitional.LegacyNavigator;
    import com.sulake.habbo.navigator.view.NavigatorView;
    import com.sulake.habbo.navigator.context.ContextContainer;
    import com.sulake.habbo.navigator.lift.LiftDataContainer;
    import com.sulake.habbo.navigator.context.SearchContextHistoryManager;
    import com.sulake.habbo.communication.messages.incoming.newnavigator.SearchResultContainer;
    import com.sulake.core.utils.Map;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.navigator.cache.NavigatorCache;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboTracking;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboHelp;
    import com.sulake.iid.IIDHabboNavigator;
    import com.sulake.habbo.communication.messages.outgoing.newnavigator.NewNavigatorInitComposer;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.communication.messages.parser.newnavigator.NavigatorMetaDataParser;
    import com.sulake.habbo.navigator.context.SearchContext;
    import com.sulake.habbo.communication.messages.incoming.newnavigator.SearchResultList;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.habbo.communication.messages.incoming.newnavigator.SearchResultSet;
    import com.sulake.habbo.communication.messages.parser.newnavigator.NavigatorLiftedRoomsParser;
    import com.sulake.habbo.communication.messages.parser.newnavigator.NewNavigatorPreferencesParser;
    import com.sulake.habbo.communication.messages.incoming.newnavigator.SavedSearch;
    import com.sulake.habbo.communication.messages.parser.newnavigator.NavigatorSavedSearchesParser;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsData;
    import com.sulake.habbo.communication.messages.outgoing.newnavigator.NewNavigatorSearchComposer;
    import com.sulake.habbo.communication.messages.outgoing.newnavigator.NavigatorAddSavedSearchComposer;
    import com.sulake.habbo.communication.messages.outgoing.newnavigator.NavigatorDeleteSavedSearchComposer;
    import com.sulake.habbo.session.events.PerksUpdatedEvent;
    import com.sulake.habbo.communication.messages.outgoing.navigator.ForwardToSomeRoomMessageComposer;
    import com.sulake.habbo.utils.Base64;
    import flash.geom.Point;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetGuestRoomMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.navigator.domain.NavigatorData;
    import com.sulake.habbo.communication.messages.outgoing.preferences.SetNewNavigatorWindowPreferencesMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.newnavigator.NavigatorAddCollapsedCategoryMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.newnavigator.NavigatorRemoveCollapsedCategoryMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.newnavigator.NavigatorSetSearchCodeViewModeMessageComposer;

    public class HabboNewNavigator extends Component implements IHabboNewNavigator, ILinkEventTracker
    {

        private var _communication:IHabboCommunicationManager;
        private var _roomSessionManager:IRoomSessionManager;
        private var _windowManager:IHabboWindowManager;
        private var _localization:IHabboLocalizationManager;
        private var _sessionData:ISessionDataManager;
        private var _tracking:IHabboTracking;
        private var _catalog:IHabboCatalog;
        private var _habboHelp:IHabboHelp;
        private var _avatarManager:IAvatarRenderManager;
        private var _SafeStr_457:NewIncomingMessages;
        private var _toolbar:IHabboToolbar;
        private var _SafeStr_606:HabboNavigator;
        private var _legacyNavigator:LegacyNavigator;
        private var _SafeStr_527:Boolean = false;
        private var _view:NavigatorView;
        private var _contextContainer:ContextContainer;
        private var _liftDataContainer:LiftDataContainer;
        private var _searchContextHistoryManager:SearchContextHistoryManager;
        private var _currentResults:SearchResultContainer;
        private var _groupDetails:Map = new Map();
        private var _SafeStr_609:Map = new Map();
        private var _collapsedCategories:Vector.<String> = new Vector.<String>(0);
        private var _navigatorCache:NavigatorCache;
        private var _SafeStr_610:String = "official_view";
        private var _SafeStr_611:String = "";
        private var _SafeStr_608:String = "";
        private var _newResultsRendered:Boolean = false;
        private var _noPushToHistoryDueToNavigation:Boolean = false;

        public function HabboNewNavigator(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            _legacyNavigator = new LegacyNavigator(this, _SafeStr_606);
        }

        public static function getEventLogExtraStringFromSearch(_arg_1:String, _arg_2:String):String
        {
            return (_arg_1 + ((_arg_2 == "") ? "" : (":" + _arg_2)));
        }


        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get communication():IHabboCommunicationManager
        {
            return (_communication);
        }

        public function get sessionData():ISessionDataManager
        {
            return (_sessionData);
        }

        public function get roomSessionManager():IRoomSessionManager
        {
            return (_roomSessionManager);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (_localization);
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communication = _arg_1;
            }), new ComponentDependency(new IIDHabboRoomSessionManager(), function (_arg_1:IRoomSessionManager):void
            {
                _roomSessionManager = _arg_1;
            }), new ComponentDependency(new IIDHabboToolbar(), function (_arg_1:IHabboToolbar):void
            {
                _toolbar = _arg_1;
            }, false, [{
                "type":"HTE_TOOLBAR_CLICK",
                "callback":onHabboToolbarEvent
            }]), new ComponentDependency(new IIDHabboCatalog(), function (_arg_1:IHabboCatalog):void
            {
                _catalog = _arg_1;
            }, false), new ComponentDependency(new IIDSessionDataManager(), function (_arg_1:ISessionDataManager):void
            {
                _sessionData = _arg_1;
            }, true, [{
                "type":"PUE_perks_updated",
                "callback":onPerksUpdated
            }]), new ComponentDependency(new IIDHabboLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                _localization = _arg_1;
            }), new ComponentDependency(new IIDHabboWindowManager(), function (_arg_1:IHabboWindowManager):void
            {
                _windowManager = _arg_1;
            }), new ComponentDependency(new IIDHabboTracking(), function (_arg_1:IHabboTracking):void
            {
                _tracking = _arg_1;
            }), new ComponentDependency(new IIDAvatarRenderManager(), function (_arg_1:IAvatarRenderManager):void
            {
                _avatarManager = _arg_1;
            }), new ComponentDependency(new IIDHabboHelp(), function (_arg_1:IHabboHelp):void
            {
                _habboHelp = _arg_1;
            }, false), new ComponentDependency(new IIDHabboLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                _localization = _arg_1;
            }), new ComponentDependency(new IIDHabboNavigator(), function (_arg_1:IHabboNavigator):void
            {
                _SafeStr_606 = HabboNavigator(_arg_1);
                if (_legacyNavigator)
                {
                    _legacyNavigator.oldNavigator = _SafeStr_606;
                };
            }, true)]));
        }

        override protected function initComponent():void
        {
            _SafeStr_457 = new NewIncomingMessages(this);
            context.addLinkEventTracker(this);
            _view = new NavigatorView(this);
            _contextContainer = new ContextContainer(this);
            _searchContextHistoryManager = new SearchContextHistoryManager(this);
            _liftDataContainer = new LiftDataContainer(this);
            _navigatorCache = new NavigatorCache();
            _communication.connection.send(new NewNavigatorInitComposer());
            _SafeStr_527 = true;
        }

        private function onHabboToolbarEvent(_arg_1:HabboToolbarEvent):void
        {
            if (_arg_1.type == "HTE_TOOLBAR_CLICK")
            {
                switch (_arg_1.iconId)
                {
                    case "HTIE_ICON_NAVIGATOR":
                        toggle();
                        return;
                };
            };
        }

        public function initialize(_arg_1:NavigatorMetaDataParser):void
        {
            _contextContainer.initialize(_arg_1);
        }

        public function onSearchResult(_arg_1:SearchResultContainer):void
        {
            _newResultsRendered = false;
            _currentResults = _arg_1;
            extractRoomNamesFromResults(_arg_1.resultSet);
            if (!_noPushToHistoryDueToNavigation)
            {
                _searchContextHistoryManager.addSearchContextAtCurrentOffset(new SearchContext(_arg_1.searchCodeOriginal, _arg_1.filteringData));
            };
            _navigatorCache.put(((_arg_1.searchCodeOriginal + "/") + _arg_1.filteringData), _arg_1);
            _noPushToHistoryDueToNavigation = false;
            if (_view.visible)
            {
                _view.onSearchResults(_arg_1, _SafeStr_608);
            };
        }

        private function extractRoomNamesFromResults(_arg_1:SearchResultSet):void
        {
            _SafeStr_609 = new Map();
            for each (var _local_2:SearchResultList in _arg_1.blocks)
            {
                for each (var _local_3:GuestRoomData in _local_2.guestRooms)
                {
                    _SafeStr_609.add(_local_3.flatId, _local_3.roomName);
                };
            };
        }

        public function get newResultsRendered():Boolean
        {
            return (_newResultsRendered);
        }

        public function set newResultsRendered(_arg_1:Boolean):void
        {
            _newResultsRendered = _arg_1;
        }

        public function onLiftedRooms(_arg_1:NavigatorLiftedRoomsParser):void
        {
            _liftDataContainer.setLiftedRooms(_arg_1.liftedRooms);
            _view.refreshLiftedRooms();
        }

        public function onPreferences(_arg_1:NewNavigatorPreferencesParser):void
        {
            _view.setInitialWindowDimensions(_arg_1.windowX, _arg_1.windowY, _arg_1.windowHeight, _arg_1.leftPaneHidden, _arg_1.resultsMode);
        }

        public function onSavedSearches(_arg_1:NavigatorSavedSearchesParser):void
        {
            _contextContainer.savedSearches = _arg_1.savedSearches.concat(new Vector.<SavedSearch>(0));
            _view.onSavedSearches(_contextContainer.savedSearches);
        }

        public function onGroupDetails(_arg_1:HabboGroupDetailsData):void
        {
            if (_groupDetails.hasKey(_arg_1.groupId))
            {
                _groupDetails.remove(_arg_1.groupId);
            };
            _groupDetails.add(_arg_1.groupId, _arg_1);
            _view.onGroupDetailsArrived(_arg_1.groupId);
        }

        public function onCollapsedCategories(_arg_1:Vector.<String>):void
        {
            _collapsedCategories = _arg_1.concat();
        }

        public function get collapsedCategories():Vector.<String>
        {
            return (_collapsedCategories);
        }

        public function getCachedGroupDetails(_arg_1:int):HabboGroupDetailsData
        {
            return (_groupDetails.getValue(_arg_1));
        }

        public function goBack():void
        {
            if (_searchContextHistoryManager.hasPrevious)
            {
                _noPushToHistoryDueToNavigation = true;
                performSearchByContext(_searchContextHistoryManager.getPreviousSearchContextAndGoBack());
            };
            trackEventLog("browse.back", "Results");
        }

        public function performLastSearch():void
        {
            if (((!(_SafeStr_610 == null)) && (!(_SafeStr_611 == null))))
            {
                _navigatorCache.removeEntry(((_SafeStr_610 + "/") + _SafeStr_611));
                performSearch(_SafeStr_610, _SafeStr_611);
            };
        }

        public function performSearch(_arg_1:String, _arg_2:String="", _arg_3:String=""):void
        {
            _view.isBusy = true;
            _SafeStr_608 = _arg_3;
            var _local_4:SearchResultContainer = _navigatorCache.getEntry(((_arg_1 + "/") + _arg_2));
            if (_local_4 != null)
            {
                onSearchResult(_local_4);
            }
            else
            {
                _SafeStr_610 = _arg_1;
                _SafeStr_611 = _arg_2;
                _communication.connection.send(new NewNavigatorSearchComposer(_arg_1, _arg_2));
                trackEventLog("search", "Search", getEventLogExtraStringFromSearch(_arg_1, _arg_2));
            };
            open();
        }

        public function performSearchByContext(_arg_1:SearchContext):void
        {
            performSearch(_arg_1.searchCode, _arg_1.filtering);
        }

        public function addSavedSearch(_arg_1:String, _arg_2:String):void
        {
            if (_currentResults != null)
            {
                _communication.connection.send(new NavigatorAddSavedSearchComposer(_arg_1, _arg_2));
            };
            trackEventLog("savedsearch.add", "SavedSearch", getEventLogExtraStringFromSearch(_arg_1, _arg_2));
            _view.setLeftPaneVisibility(true);
        }

        public function deleteSavedSearch(_arg_1:int):void
        {
            _communication.connection.send(new NavigatorDeleteSavedSearchComposer(_arg_1));
            trackEventLog("savedsearch.delete", "SavedSearch");
        }

        private function onPerksUpdated(_arg_1:PerksUpdatedEvent):void
        {
            if (!_sessionData.isPerkAllowed("NAVIGATOR_PHASE_TWO_2014"))
            {
                context.removeLinkEventTracker(this);
                if (_SafeStr_527)
                {
                    _SafeStr_457.removeLegacyMessageListeners();
                    close();
                };
                return;
            };
            if (!_SafeStr_527)
            {
                initComponent();
            }
            else
            {
                if (_sessionData.isPerkAllowed("NAVIGATOR_PHASE_TWO_2014"))
                {
                    _SafeStr_457.addMessageListeners();
                };
            };
        }

        public function get linkPattern():String
        {
            return ("navigator/");
        }

        public function linkReceived(_arg_1:String):void
        {
            var _local_3:int;
            var _local_2:Array = _arg_1.split("/");
            if (_local_2.length < 2)
            {
                return;
            };
            switch (_local_2[1])
            {
                case "goto":
                    if (_local_2.length > 2)
                    {
                        switch (_local_2[2])
                        {
                            case "home":
                                _legacyNavigator.goToHomeRoom();
                                break;
                            default:
                                _local_3 = _local_2[2];
                                if (_local_3 > 0)
                                {
                                    _legacyNavigator.goToPrivateRoom(_local_3);
                                }
                                else
                                {
                                    communication.connection.send(new ForwardToSomeRoomMessageComposer(_local_2[2]));
                                };
                        };
                    };
                    return;
                case "search":
                    if (_local_2.length > 2)
                    {
                        performSearch("hotel_view", _local_2[2]);
                    };
                    return;
                case "tag":
                    if (_local_2.length > 2)
                    {
                        performSearch("hotel_view", _local_2[2]);
                    };
                    return;
                case "tab":
                    if (_local_2.length > 2)
                    {
                        performSearch(_local_2[2]);
                    };
                    return;
                case "report":
                    if (_local_2.length > 3)
                    {
                        _legacyNavigator.reportRoomFromWeb(_local_2[2], Base64.decode(_local_2[3]));
                    };
                    return;
                default:
                    Logger.log(("Navigator unknown link-type received: " + _local_2[1]));
                    return;
            };
        }

        public function showOwnRooms():void
        {
        }

        public function showToolbarHover(_arg_1:Point):void
        {
        }

        public function hideToolbarHover(_arg_1:Boolean):void
        {
        }

        public function get isReady():Boolean
        {
            return ((!(_contextContainer == null)) && (_contextContainer.isReady()));
        }

        public function get contextContainer():ContextContainer
        {
            return (_contextContainer);
        }

        public function get searchContextHistoryManager():SearchContextHistoryManager
        {
            return (_searchContextHistoryManager);
        }

        public function get liftDataContainer():LiftDataContainer
        {
            return (_liftDataContainer);
        }

        public function get currentResults():SearchResultContainer
        {
            return (_currentResults);
        }

        public function goToRoom(_arg_1:int, _arg_2:String="mainview"):void
        {
            communication.connection.send(new GetGuestRoomMessageComposer(_arg_1, false, true));
            _view.visible = false;
            var _local_3:String = _SafeStr_609.getValue(_arg_1);
            trackEventLog("go", _arg_2, ((_local_3) ? _local_3 : ""), _arg_1);
        }

        public function getExtendedProfile(_arg_1:int):void
        {
            communication.connection.send(new GetExtendedProfileMessageComposer(_arg_1));
        }

        public function get imageLibraryBaseUrl():String
        {
            return (context.configuration.getProperty("image.library.url"));
        }

        public function performTagSearch(_arg_1:String):void
        {
            performSearch("hotel_view", ("tag:" + _arg_1));
        }

        public function createRoom():void
        {
            _legacyNavigator.roomCreateViewCtrl.show();
        }

        public function open():void
        {
            if (_view == null)
            {
                return;
            };
            if (!_view.visible)
            {
                _view.visible = true;
            };
        }

        public function close():void
        {
            if (_view.visible)
            {
                _view.visible = false;
            };
        }

        public function toggle():void
        {
            if (_view == null)
            {
                return;
            };
            _view.visible = (!(_view.visible));
            if (_view.visible)
            {
                performLastSearch();
            };
        }

        public function get mainWindow():IFrameWindow
        {
            return (_view.mainWindow);
        }

        public function refresh():void
        {
            if (_currentResults)
            {
                _view.onSearchResults(_currentResults);
            };
        }

        public function get legacyNavigator():IHabboNavigator
        {
            return (_legacyNavigator);
        }

        public function get data():NavigatorData
        {
            return (_legacyNavigator.data);
        }

        public function sendWindowPreferences(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Boolean, _arg_6:int):void
        {
            _communication.connection.send(new SetNewNavigatorWindowPreferencesMessageComposer(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6));
        }

        public function getGuildInfo(_arg_1:int, _arg_2:Boolean=true):void
        {
            _communication.connection.send(new GetHabboGroupDetailsMessageComposer(_arg_1, _arg_2));
        }

        public function sendAddCollapsedCategory(_arg_1:String):void
        {
            _communication.connection.send(new NavigatorAddCollapsedCategoryMessageComposer(_arg_1));
        }

        public function sendRemoveCollapsedCategory(_arg_1:String):void
        {
            _communication.connection.send(new NavigatorRemoveCollapsedCategoryMessageComposer(_arg_1));
        }

        public function goToHomeRoom():void
        {
            goToRoom(_legacyNavigator.data.homeRoomId, "external");
        }

        public function trackEventLog(_arg_1:String, _arg_2:String, _arg_3:String="", _arg_4:int=0):void
        {
            if (_tracking)
            {
                _tracking.trackEventLog("NewNavigator", _arg_2, _arg_1, _arg_3, _arg_4);
            };
        }

        public function get view():NavigatorView
        {
            return (_view);
        }

        public function toggleSearchCodeViewMode(_arg_1:String, _arg_2:int):void
        {
            _communication.connection.send(new NavigatorSetSearchCodeViewModeMessageComposer(_arg_1, _arg_2));
            trackEventLog("browse.toggleviewmode", "ViewMode", "", _arg_2);
        }

        public function get habboHelp():IHabboHelp
        {
            return (_habboHelp);
        }

        public function performTextSearch(_arg_1:String):void
        {
        }

        public function performGuildBaseSearch():void
        {
        }

        public function performCompetitionRoomsSearch(_arg_1:int, _arg_2:int):void
        {
        }


    }
}