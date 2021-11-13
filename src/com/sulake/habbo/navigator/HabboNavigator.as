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
    import com.sulake.habbo.navigator.mainview.MainViewCtrl;
    import com.sulake.habbo.navigator.inroom.RoomInfoViewCtrl;
    import com.sulake.habbo.navigator.roomsettings.RoomCreateViewCtrl;
    import com.sulake.habbo.navigator.domain.NavigatorData;
    import com.sulake.habbo.navigator.domain.Tabs;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.navigator.roomsettings.RoomSettingsCtrl;
    import com.sulake.habbo.navigator.mainview.OfficialRoomEntryManager;
    import com.sulake.habbo.navigator.inroom.RoomEventViewCtrl;
    import com.sulake.habbo.navigator.inroom.RoomEventInfoCtrl;
    import com.sulake.habbo.navigator.roomsettings.RoomFilterCtrl;
    import com.sulake.habbo.navigator.toolbar.ToolbarHoverCtrl;
    import com.sulake.habbo.navigator.roomsettings.EnforceCategoryCtrl;
    import com.sulake.core.assets.AssetLibraryCollection;
    import com.sulake.core.runtime.IContext;
    import com.sulake.habbo.navigator.mainview.ITransitionalMainViewCtrl;
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
    import __AS3__.vec.Vector;
    import flash.external.ExternalInterface;
    import com.sulake.habbo.communication.messages.outgoing.navigator.ConvertGlobalRoomIdMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetGuestRoomMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RemoveOwnRoomRightsRoomMessageComposer;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.utils.ErrorReportStorage;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.CompetitionRoomsData;
    import flash.geom.Point;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.habbo.communication.messages.outgoing.navigator.ForwardToSomeRoomMessageComposer;
    import com.sulake.habbo.session.events.PerksUpdatedEvent;
    import com.sulake.habbo.navigator.inroom.*;

    public class HabboNavigator extends Component implements IHabboNavigator, IHabboTransitionalNavigator, ILinkEventTracker 
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
        private var _mainViewCtrl:MainViewCtrl;
        private var _roomInfoViewCtrl:RoomInfoViewCtrl;
        private var _roomCreateViewCtrl:RoomCreateViewCtrl;
        private var _data:NavigatorData;
        private var _tabs:Tabs;
        private var _assetLibrary:IAssetLibrary;
        private var _SafeStr_457:IncomingMessages;
        private var _toolbar:IHabboToolbar;
        private var _roomSettingsCtrl:RoomSettingsCtrl;
        private var _passwordInput:GuestRoomPasswordInput;
        private var _doorbell:GuestRoomDoorbell;
        private var _officialRoomEntryManager:OfficialRoomEntryManager;
        private var _roomEventViewCtrl:RoomEventViewCtrl;
        private var _roomEventInfoCtrl:RoomEventInfoCtrl;
        private var _roomFilterCtrl:RoomFilterCtrl;
        private var _toolbarHover:ToolbarHoverCtrl;
        private var _enforceCategoryCtrl:EnforceCategoryCtrl;
        private var _webRoomReport:Boolean = true;
        private var _webRoomReportedName:String = null;

        public function HabboNavigator(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            _assetLibrary = new AssetLibraryCollection("NavigatorComponent");
            _data = new NavigatorData(this);
            _mainViewCtrl = new MainViewCtrl(this);
            _roomInfoViewCtrl = new RoomInfoViewCtrl(this);
            _roomCreateViewCtrl = new RoomCreateViewCtrl(this);
            _passwordInput = new GuestRoomPasswordInput(this);
            _doorbell = new GuestRoomDoorbell(this);
            _tabs = new Tabs(this);
            _officialRoomEntryManager = new OfficialRoomEntryManager(this);
            _roomEventViewCtrl = new RoomEventViewCtrl(this);
            _roomEventInfoCtrl = new RoomEventInfoCtrl(this);
            _roomFilterCtrl = new RoomFilterCtrl(this);
            _enforceCategoryCtrl = new EnforceCategoryCtrl(this);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get data():NavigatorData
        {
            return (_data);
        }

        public function get mainViewCtrl():ITransitionalMainViewCtrl
        {
            return (_mainViewCtrl);
        }

        public function get tabs():Tabs
        {
            return (_tabs);
        }

        public function get roomInfoViewCtrl():RoomInfoViewCtrl
        {
            return (_roomInfoViewCtrl);
        }

        public function get roomCreateViewCtrl():RoomCreateViewCtrl
        {
            return (_roomCreateViewCtrl);
        }

        public function get assetLibrary():IAssetLibrary
        {
            return (_assetLibrary);
        }

        public function get communication():IHabboCommunicationManager
        {
            return (_communication);
        }

        public function get roomSettingsCtrl():RoomSettingsCtrl
        {
            return (_roomSettingsCtrl);
        }

        public function get sessionData():ISessionDataManager
        {
            return (_sessionData);
        }

        public function get passwordInput():GuestRoomPasswordInput
        {
            return (_passwordInput);
        }

        public function get doorbell():GuestRoomDoorbell
        {
            return (_doorbell);
        }

        public function get roomEventViewCtrl():RoomEventViewCtrl
        {
            return (_roomEventViewCtrl);
        }

        public function get officialRoomEntryManager():OfficialRoomEntryManager
        {
            return (_officialRoomEntryManager);
        }

        public function get toolbar():IHabboToolbar
        {
            return (_toolbar);
        }

        public function get habboHelp():IHabboHelp
        {
            return (_habboHelp);
        }

        public function get roomEventInfoCtrl():RoomEventInfoCtrl
        {
            return (_roomEventInfoCtrl);
        }

        public function get roomFilterCtrl():RoomFilterCtrl
        {
            return (_roomFilterCtrl);
        }

        public function get roomSessionManager():IRoomSessionManager
        {
            return (_roomSessionManager);
        }

        public function get enforceCategoryCtrl():EnforceCategoryCtrl
        {
            return (_enforceCategoryCtrl);
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
            }), new ComponentDependency(new IIDHabboLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                _localization = _arg_1;
            })]));
        }

        override protected function initComponent():void
        {
            _SafeStr_457 = new IncomingMessages(this);
            _roomSessionManager.events.addEventListener("RSE_CREATED", onRoomSessionCreatedEvent);
            if (!_sessionData.isPerkAllowed("NAVIGATOR_PHASE_TWO_2014"))
            {
                context.addLinkEventTracker(this);
            };
            var _local_1:String = getProperty("navigator.default_tab");
            if (getInteger("new.identity", 0) > 0)
            {
                _local_1 = getProperty("new.identity.navigator.default_tab");
            };
            tabs.setSelectedTab(Tabs.tabIdFromName(_local_1, 2));
            _roomSettingsCtrl = new RoomSettingsCtrl(this);
            if (ExternalInterface.available)
            {
                ExternalInterface.addCallback("openroom", enterRoomWebRequest);
            };
        }

        public function enterRoomWebRequest(_arg_1:String, _arg_2:Boolean=false, _arg_3:String=null):void
        {
            _webRoomReport = _arg_2;
            _webRoomReportedName = _arg_3;
            send(new ConvertGlobalRoomIdMessageComposer(_arg_1));
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            if (_mainViewCtrl)
            {
                _mainViewCtrl.dispose();
                _mainViewCtrl = null;
            };
            if (_roomSessionManager != null)
            {
                _roomSessionManager.events.removeEventListener("RSE_CREATED", onRoomSessionCreatedEvent);
            };
            context.removeLinkEventTracker(this);
            if (((!(_toolbar == null)) && (!(_toolbar.events == null))))
            {
                _toolbar.events.removeEventListener("HTE_TOOLBAR_CLICK", onHabboToolbarEvent);
            };
            if (_roomInfoViewCtrl)
            {
                _roomInfoViewCtrl.dispose();
                _roomInfoViewCtrl = null;
            };
            if (_roomFilterCtrl)
            {
                _roomFilterCtrl.dispose();
                _roomFilterCtrl = null;
            };
            if (_roomCreateViewCtrl)
            {
                _roomCreateViewCtrl.dispose();
                _roomCreateViewCtrl = null;
            };
            if (_officialRoomEntryManager)
            {
                _officialRoomEntryManager.dispose();
                _officialRoomEntryManager = null;
            };
            if (_roomEventViewCtrl)
            {
                _roomEventViewCtrl.dispose();
                _roomEventViewCtrl = null;
            };
            if (_roomSettingsCtrl)
            {
                _roomSettingsCtrl.dispose();
                _roomSettingsCtrl = null;
            };
            if (_toolbarHover)
            {
                _toolbarHover.dispose();
                _toolbarHover = null;
            };
            super.dispose();
        }

        public function startRoomCreation():void
        {
            _roomCreateViewCtrl.show();
        }

        public function goToPrivateRoom(_arg_1:int):void
        {
            send(new GetGuestRoomMessageComposer(_arg_1, false, true));
        }

        public function removeRoomRights(_arg_1:int):void
        {
            send(new RemoveOwnRoomRightsRoomMessageComposer(_arg_1));
        }

        public function hasRoomRightsButIsNotOwner(_arg_1:int):Boolean
        {
            var _local_2:IRoomSession;
            if (_roomSessionManager)
            {
                _local_2 = _roomSessionManager.getSession(_arg_1);
                return ((_local_2.roomControllerLevel == 1) && (!(_local_2.isRoomOwner)));
            };
            return (false);
        }

        public function goToRoomNetwork(_arg_1:int, _arg_2:Boolean):void
        {
            var _local_3:int;
            if (_roomSessionManager)
            {
                _roomInfoViewCtrl.close();
                _local_3 = 0;
                if (((_arg_2) && (_data.homeRoomId > 0)))
                {
                    _local_3 = _data.homeRoomId;
                };
                _roomSessionManager.gotoRoomNetwork(_arg_1, _local_3);
            };
        }

        public function goToRoom(_arg_1:int, _arg_2:Boolean, _arg_3:String="", _arg_4:int=-1):void
        {
            var _local_5:int;
            if (_roomSessionManager)
            {
                Logger.log(("[HabboNavigator] Go to room: " + _arg_1));
                if (_arg_2)
                {
                    _mainViewCtrl.close();
                };
                _roomSessionManager.gotoRoom(_arg_1, _arg_3);
                if (tabs.getSelected())
                {
                    _local_5 = ((_arg_4 > -1) ? (_arg_4 + 1) : 0);
                    switch (tabs.getSelected().id)
                    {
                        case 4:
                            trackNavigationDataPoint(tabs.getSelected().tabPageDecorator.filterCategory, "go.official", String(_arg_1), _local_5);
                            break;
                        case 3:
                            trackNavigationDataPoint(tabs.getSelected().tabPageDecorator.filterCategory, "go.me", String(_arg_1), _local_5);
                            break;
                        case 2:
                            trackNavigationDataPoint(tabs.getSelected().tabPageDecorator.filterCategory, "go.rooms", String(_arg_1), _local_5);
                            break;
                        case 1:
                            trackNavigationDataPoint("Events", "go.events", String(_arg_1), _local_5);
                            break;
                        case 5:
                            trackNavigationDataPoint("Search", "go.search", String(_arg_1), _local_5);
                        default:
                    };
                };
            }
            else
            {
                Logger.log(("[HabboNavigator] Room Session Manager is not initialized. Can not enter: " + _arg_1));
            };
        }

        public function goToHomeRoom():Boolean
        {
            if (this._data.homeRoomId < 1)
            {
                Logger.log("No home room set while attempting to go to home room");
                return (false);
            };
            this.goToRoom(this._data.homeRoomId, true);
            return (true);
        }

        public function send(_arg_1:IMessageComposer, _arg_2:Boolean=false):void
        {
            _communication.connection.send(_arg_1);
        }

        public function getXmlWindow(_arg_1:String, _arg_2:uint=1):IWindow
        {
            var _local_5:IAsset;
            var _local_3:XmlAsset;
            var _local_4:IWindow;
            try
            {
                _local_5 = assets.getAssetByName((_arg_1 + "_xml"));
                _local_3 = XmlAsset(_local_5);
                _local_4 = _windowManager.buildFromXML(XML(_local_3.content), _arg_2);
            }
            catch(e:Error)
            {
                ErrorReportStorage.addDebugData("HabboNavigator", (((((("Failed to build window " + _arg_1) + "_xml, ") + _local_5) + ", ") + _windowManager) + "!"));
                throw (e);
            };
            return (_local_4);
        }

        public function getText(_arg_1:String):String
        {
            var _local_2:String = _localization.getLocalization(_arg_1);
            if (((_local_2 == null) || (_local_2 == "")))
            {
                _local_2 = _arg_1;
            };
            return (_local_2);
        }

        public function registerParameter(_arg_1:String, _arg_2:String, _arg_3:String):String
        {
            return (_localization.registerParameter(_arg_1, _arg_2, _arg_3));
        }

        public function getButton(_arg_1:String, _arg_2:String, _arg_3:Function, _arg_4:int=0, _arg_5:int=0, _arg_6:int=0):IBitmapWrapperWindow
        {
            var _local_8:BitmapData = getButtonImage(_arg_2);
            var _local_7:IBitmapWrapperWindow = IBitmapWrapperWindow(_windowManager.createWindow(_arg_1, "", 21, 0, (0x01 | 0x10), new Rectangle(_arg_4, _arg_5, _local_8.width, _local_8.height), _arg_3, _arg_6));
            _local_7.bitmap = _local_8;
            _local_7.disposesBitmap = false;
            return (_local_7);
        }

        public function refreshButton(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean, _arg_4:Function, _arg_5:int, _arg_6:String=null):void
        {
            if (!_arg_6)
            {
                _arg_6 = _arg_2;
            };
            var _local_7:IBitmapWrapperWindow = (_arg_1.findChildByName(_arg_2) as IBitmapWrapperWindow);
            if (!_local_7)
            {
                Logger.log(("Could not locate button in navigator: " + _arg_2));
            };
            if (!_arg_3)
            {
                _local_7.visible = false;
            }
            else
            {
                prepareButton(_local_7, _arg_6, _arg_4, _arg_5);
                _local_7.visible = true;
            };
        }

        private function prepareButton(_arg_1:IBitmapWrapperWindow, _arg_2:String, _arg_3:Function, _arg_4:int):void
        {
            _arg_1.id = _arg_4;
            _arg_1.procedure = _arg_3;
            if (_arg_1.bitmap != null)
            {
                return;
            };
            _arg_1.bitmap = getButtonImage(_arg_2);
            _arg_1.disposesBitmap = false;
            _arg_1.width = _arg_1.bitmap.width;
            _arg_1.height = _arg_1.bitmap.height;
        }

        public function getButtonImage(_arg_1:String, _arg_2:String="_png"):BitmapData
        {
            var _local_4:String = (_arg_1 + _arg_2);
            var _local_7:IAsset = assets.getAssetByName(_local_4);
            var _local_5:BitmapDataAsset = BitmapDataAsset(_local_7);
            return (BitmapData(_local_5.content));
        }

        private function onRoomSessionCreatedEvent(_arg_1:RoomSessionEvent):void
        {
            if (((_roomSessionManager) && (_roomInfoViewCtrl)))
            {
                _roomInfoViewCtrl.close();
            };
        }

        public function openCatalogClubPage(_arg_1:String):void
        {
            if (_catalog == null)
            {
                return;
            };
            _catalog.openClubCenter();
        }

        public function openCatalogRoomAdsPage():void
        {
            if (_catalog == null)
            {
                return;
            };
            _catalog.openCatalogPage("room_ad");
        }

        public function openCatalogRoomAdsExtendPage(_arg_1:String, _arg_2:String, _arg_3:Date, _arg_4:int):void
        {
            if (_catalog == null)
            {
                return;
            };
            var _local_5:String = _data.enteredGuestRoom.roomName;
            _catalog.openRoomAdCatalogPageInExtendedMode("room_ad", _arg_1, _arg_2, _local_5, _arg_3, _arg_4);
        }

        private function onHabboToolbarEvent(_arg_1:HabboToolbarEvent):void
        {
            if (_arg_1.type == "HTE_TOOLBAR_CLICK")
            {
                switch (_arg_1.iconId)
                {
                    case "HTIE_ICON_ROOMINFO":
                        toggleRoomInfoVisibility();
                        return;
                    case "HTIE_ICON_NAVIGATOR_ME_TAB":
                        showOwnRooms();
                        return;
                    case "HTIE_ICON_GAMES":
                        if (getBoolean("game.center.enabled"))
                        {
                            closeNavigator();
                        };
                        return;
                    case "HTIE_ICON_HOME":
                        goToHomeRoom();
                        return;
                };
            };
        }

        public function toggleRoomInfoVisibility():void
        {
            if (_roomCreateViewCtrl)
            {
                _roomInfoViewCtrl.toggle();
            };
        }

        public function performTagSearch(_arg_1:String):void
        {
            if (_mainViewCtrl == null)
            {
                return;
            };
            if (_arg_1.indexOf(" ") != -1)
            {
                _arg_1 = (('"' + _arg_1) + '"');
            };
            _mainViewCtrl.startSearch(5, 9, _arg_1);
            trackNavigationDataPoint("Search", "search.tag", _arg_1);
            _mainViewCtrl.mainWindow.activate();
        }

        public function performTextSearch(_arg_1:String):void
        {
            if (_mainViewCtrl == null)
            {
                return;
            };
            _mainViewCtrl.startSearch(5, 8, _arg_1);
            trackNavigationDataPoint("Search", "search", _arg_1);
            _mainViewCtrl.mainWindow.activate();
            _mainViewCtrl.searchInput.searchStr.setText(_arg_1);
        }

        public function performCompetitionRoomsSearch(_arg_1:int, _arg_2:int):void
        {
            if (((_mainViewCtrl == null) || ((!(_data == null)) && (_data.isLoading()))))
            {
                return;
            };
            _data.competitionRoomsData = new CompetitionRoomsData(null, _arg_1, _arg_2);
            _mainViewCtrl.startSearch(5, 15, "");
            _mainViewCtrl.mainWindow.activate();
            _mainViewCtrl.searchInput.searchStr.setText("");
        }

        public function performGuildBaseSearch():void
        {
            if (_mainViewCtrl == null)
            {
                return;
            };
            _mainViewCtrl.startSearch(5, 14, "");
            _mainViewCtrl.mainWindow.activate();
            _mainViewCtrl.searchInput.searchStr.setText("");
        }

        public function showOwnRooms():void
        {
            if (_mainViewCtrl == null)
            {
                return;
            };
            _mainViewCtrl.startSearch(3, 5);
            _tabs.getTab(3).tabPageDecorator.tabSelected();
        }

        public function showFavouriteRooms():void
        {
            showMeTab(6);
        }

        public function showHistoryRooms():void
        {
            showMeTab(7);
        }

        public function showFrequentRooms():void
        {
            showMeTab(23);
        }

        private function showMeTab(_arg_1:int):void
        {
            if (_mainViewCtrl == null)
            {
                return;
            };
            _mainViewCtrl.startSearch(3, _arg_1);
            _tabs.getTab(3).tabPageDecorator.setSubSelection(_arg_1);
        }

        public function trackNavigationDataPoint(_arg_1:String, _arg_2:String, _arg_3:String="", _arg_4:int=0):void
        {
            if (_tracking)
            {
                _tracking.trackEventLog("Navigation", _arg_1, _arg_2, _arg_3, _arg_4);
            };
        }

        public function trackGoogle(_arg_1:String, _arg_2:String, _arg_3:int=-1):void
        {
            if (_tracking)
            {
                _tracking.trackGoogle(_arg_1, _arg_2, _arg_3);
            };
        }

        public function get tracking():IHabboTracking
        {
            return (_tracking);
        }

        public function openNavigator(_arg_1:Point=null):void
        {
        }

        public function closeNavigator():void
        {
            _mainViewCtrl.close();
        }

        public function goToMainView():void
        {
            _roomCreateViewCtrl.hide();
            _roomInfoViewCtrl.close();
        }

        public function get homeRoomId():int
        {
            return ((_data) ? _data.homeRoomId : -1);
        }

        public function get webRoomReport():Boolean
        {
            return (_webRoomReport);
        }

        public function get webRoomReportedName():String
        {
            return (_webRoomReportedName);
        }

        public function get enteredGuestRoomData():GuestRoomData
        {
            if (_data)
            {
                return (_data.enteredGuestRoom);
            };
            return (null);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (_localization);
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
                                goToHomeRoom();
                                break;
                            default:
                                _local_3 = _local_2[2];
                                if (_local_3 > 0)
                                {
                                    goToPrivateRoom(_local_3);
                                }
                                else
                                {
                                    send(new ForwardToSomeRoomMessageComposer(_local_2[2]));
                                };
                        };
                    };
                    return;
                case "search":
                    if (_local_2.length > 2)
                    {
                        performTextSearch(_local_2[2]);
                    };
                    return;
                case "tag":
                    if (_local_2.length > 2)
                    {
                        performTagSearch(_local_2[2]);
                    };
                    return;
                case "tab":
                    if (_local_2.length > 2)
                    {
                        tabs.setSelectedTab(Tabs.tabIdFromName(_local_2[2], 2));
                        openNavigator(null);
                    };
                    return;
                case "report":
                    if (_local_2.length > 3)
                    {
                        enterRoomWebRequest(_local_2[2], true, _local_2[3]);
                    };
                    return;
                default:
                    Logger.log(("Navigator unknown link-type received: " + _local_2[1]));
                    return;
            };
        }

        private function onPerksUpdated(_arg_1:PerksUpdatedEvent):void
        {
            if (!_sessionData.isPerkAllowed("NAVIGATOR_PHASE_TWO_2014"))
            {
                if (((_mainViewCtrl) && (!(_mainViewCtrl.isPhaseOneNavigator == isPerkAllowed("NAVIGATOR_PHASE_ONE_2014")))))
                {
                    _mainViewCtrl.close();
                };
                context.addLinkEventTracker(this);
            }
            else
            {
                context.removeLinkEventTracker(this);
            };
        }

        public function showToolbarHover(_arg_1:Point):void
        {
            if (!_toolbarHover)
            {
                _toolbarHover = new ToolbarHoverCtrl(this);
            };
            _toolbarHover.show(_arg_1);
        }

        public function hideToolbarHover(_arg_1:Boolean):void
        {
            if (!_toolbarHover)
            {
                return;
            };
            if (_arg_1)
            {
                _toolbarHover.hideDelayed();
            }
            else
            {
                _toolbarHover.hide();
            };
        }

        public function get isDoorModeOverriddenInCurrentRoom():Boolean
        {
            return (_catalog.isDoorModeOverriddenInCurrentRoom);
        }

        public function isPerkAllowed(_arg_1:String):Boolean
        {
            if (_sessionData)
            {
                return (_sessionData.isPerkAllowed(_arg_1));
            };
            return (false);
        }

        public function canRateRoom():Boolean
        {
            if (!data)
            {
                return (false);
            };
            return (data.canRate);
        }

        public function isRoomFavorite(_arg_1:int):Boolean
        {
            if (!data)
            {
                return (false);
            };
            return (data.isRoomFavourite(_arg_1));
        }

        public function isRoomHome(_arg_1:int):Boolean
        {
            if (!data)
            {
                return (false);
            };
            return (data.isRoomHome(_arg_1));
        }

        public function get visibleEventCategories():Array
        {
            if (!data)
            {
                return ([]);
            };
            return (data.visibleEventCategories);
        }


    }
}

