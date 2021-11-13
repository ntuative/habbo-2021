package com.sulake.habbo.navigator.transitional
{
    import com.sulake.habbo.navigator.IHabboTransitionalNavigator;
    import com.sulake.habbo.navigator.HabboNewNavigator;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.habbo.navigator.roomsettings.RoomSettingsCtrl;
    import com.sulake.habbo.navigator.inroom.RoomInfoViewCtrl;
    import com.sulake.habbo.navigator.roomsettings.RoomCreateViewCtrl;
    import com.sulake.habbo.navigator.GuestRoomPasswordInput;
    import com.sulake.habbo.navigator.GuestRoomDoorbell;
    import com.sulake.habbo.navigator.mainview.OfficialRoomEntryManager;
    import com.sulake.habbo.navigator.inroom.RoomEventViewCtrl;
    import com.sulake.habbo.navigator.inroom.RoomEventInfoCtrl;
    import com.sulake.habbo.navigator.roomsettings.RoomFilterCtrl;
    import com.sulake.habbo.navigator.roomsettings.EnforceCategoryCtrl;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.navigator.domain.NavigatorData;
    import com.sulake.habbo.navigator.mainview.ITransitionalMainViewCtrl;
    import com.sulake.habbo.navigator.domain.Tabs;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import com.sulake.habbo.tracking.IHabboTracking;
    import flash.events.IEventDispatcher;
    import flash.geom.Point;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import flash.utils.Dictionary;

    public class LegacyNavigator implements IHabboTransitionalNavigator 
    {

        private var _newNavigator:HabboNewNavigator;
        private var _SafeStr_606:HabboNavigator;
        private var _mainViewCtrl:FakeMainViewCtrl;
        private var _roomSettingsCtrl:RoomSettingsCtrl;
        private var _roomInfoViewCtrl:RoomInfoViewCtrl;
        private var _roomCreateViewCtrl:RoomCreateViewCtrl;
        private var _passwordInput:GuestRoomPasswordInput;
        private var _doorbell:GuestRoomDoorbell;
        private var _officialRoomEntryManager:OfficialRoomEntryManager;
        private var _roomEventViewCtrl:RoomEventViewCtrl;
        private var _roomEventInfoCtrl:RoomEventInfoCtrl;
        private var _roomFilterCtrl:RoomFilterCtrl;
        private var _enforceCategoryCtrl:EnforceCategoryCtrl;

        public function LegacyNavigator(_arg_1:HabboNewNavigator, _arg_2:HabboNavigator)
        {
            _newNavigator = _arg_1;
            _SafeStr_606 = _arg_2;
            _mainViewCtrl = new FakeMainViewCtrl(_newNavigator, _SafeStr_606);
            _roomSettingsCtrl = new RoomSettingsCtrl(this);
            _roomInfoViewCtrl = new RoomInfoViewCtrl(this);
            _roomCreateViewCtrl = new RoomCreateViewCtrl(this);
            _passwordInput = new GuestRoomPasswordInput(this);
            _doorbell = new GuestRoomDoorbell(this);
            _officialRoomEntryManager = new OfficialRoomEntryManager(this);
            _roomEventViewCtrl = new RoomEventViewCtrl(this);
            _roomEventInfoCtrl = new RoomEventInfoCtrl(this);
            _roomFilterCtrl = new RoomFilterCtrl(this);
            _enforceCategoryCtrl = new EnforceCategoryCtrl(this);
        }

        public function set oldNavigator(_arg_1:HabboNavigator):void
        {
            _SafeStr_606 = _arg_1;
        }

        public function get assets():IAssetLibrary
        {
            return (_SafeStr_606.assets);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_newNavigator.windowManager);
        }

        public function get data():NavigatorData
        {
            return (_SafeStr_606.data);
        }

        public function get mainViewCtrl():ITransitionalMainViewCtrl
        {
            return (_mainViewCtrl);
        }

        public function get tabs():Tabs
        {
            return (_SafeStr_606.tabs);
        }

        public function get roomInfoViewCtrl():RoomInfoViewCtrl
        {
            return (_roomInfoViewCtrl);
        }

        public function get roomCreateViewCtrl():RoomCreateViewCtrl
        {
            return (_roomCreateViewCtrl);
        }

        public function get communication():IHabboCommunicationManager
        {
            return (_SafeStr_606.communication);
        }

        public function get roomSettingsCtrl():RoomSettingsCtrl
        {
            return (_roomSettingsCtrl);
        }

        public function get sessionData():ISessionDataManager
        {
            return (_SafeStr_606.sessionData);
        }

        public function get passwordInput():GuestRoomPasswordInput
        {
            return (_SafeStr_606.passwordInput);
        }

        public function get doorbell():GuestRoomDoorbell
        {
            return (_doorbell);
        }

        public function get roomEventViewCtrl():RoomEventViewCtrl
        {
            return (_roomEventViewCtrl);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (_SafeStr_606.localization);
        }

        public function get officialRoomEntryManager():OfficialRoomEntryManager
        {
            return (_SafeStr_606.officialRoomEntryManager);
        }

        public function get toolbar():IHabboToolbar
        {
            return (_SafeStr_606.toolbar);
        }

        public function get habboHelp():IHabboHelp
        {
            return (_SafeStr_606.habboHelp);
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
            return (_SafeStr_606.roomSessionManager);
        }

        public function get enforceCategoryCtrl():EnforceCategoryCtrl
        {
            return (_enforceCategoryCtrl);
        }

        public function send(_arg_1:IMessageComposer, _arg_2:Boolean=false):void
        {
            return (_SafeStr_606.send(_arg_1, _arg_2));
        }

        public function getXmlWindow(_arg_1:String, _arg_2:uint=1):IWindow
        {
            return (_SafeStr_606.getXmlWindow(_arg_1, _arg_2));
        }

        public function getText(_arg_1:String):String
        {
            return (_SafeStr_606.getText(_arg_1));
        }

        public function registerParameter(_arg_1:String, _arg_2:String, _arg_3:String):String
        {
            return (_SafeStr_606.registerParameter(_arg_1, _arg_2, _arg_3));
        }

        public function getButton(_arg_1:String, _arg_2:String, _arg_3:Function, _arg_4:int=0, _arg_5:int=0, _arg_6:int=0):IBitmapWrapperWindow
        {
            return (_SafeStr_606.getButton(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6));
        }

        public function refreshButton(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean, _arg_4:Function, _arg_5:int, _arg_6:String=null):void
        {
            return (_SafeStr_606.refreshButton(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6));
        }

        public function getButtonImage(_arg_1:String, _arg_2:String="_png"):BitmapData
        {
            return (_SafeStr_606.getButtonImage(_arg_1, _arg_2));
        }

        public function openCatalogClubPage(_arg_1:String):void
        {
            return (_SafeStr_606.openCatalogClubPage(_arg_1));
        }

        public function openCatalogRoomAdsPage():void
        {
            return (_SafeStr_606.openCatalogRoomAdsPage());
        }

        public function showFavouriteRooms():void
        {
            return (_newNavigator.performSearch("favorites"));
        }

        public function showHistoryRooms():void
        {
            return (_newNavigator.performSearch("history"));
        }

        public function showFrequentRooms():void
        {
            return (_newNavigator.performSearch("history_freq"));
        }

        public function get tracking():IHabboTracking
        {
            return (_SafeStr_606.tracking);
        }

        public function goToMainView():void
        {
            _roomCreateViewCtrl.hide();
        }

        public function reportRoomFromWeb(_arg_1:String, _arg_2:String=null):void
        {
            _SafeStr_606.enterRoomWebRequest(_arg_1, true, _arg_2);
        }

        public function goToRoom(_arg_1:int, _arg_2:Boolean, _arg_3:String="", _arg_4:int=-1):void
        {
            _SafeStr_606.goToRoom(_arg_1, false, _arg_3, _arg_4);
        }

        public function isPerkAllowed(_arg_1:String):Boolean
        {
            return (_SafeStr_606.isPerkAllowed(_arg_1));
        }

        public function trackGoogle(_arg_1:String, _arg_2:String, _arg_3:int=-1):void
        {
            return (_SafeStr_606.trackGoogle(_arg_1, _arg_2, _arg_3));
        }

        public function getBoolean(_arg_1:String):Boolean
        {
            return (_SafeStr_606.getBoolean(_arg_1));
        }

        public function getInteger(_arg_1:String, _arg_2:int):int
        {
            return (_SafeStr_606.getInteger(_arg_1, _arg_2));
        }

        public function get events():IEventDispatcher
        {
            return (_newNavigator.events);
        }

        public function goToHomeRoom():Boolean
        {
            _newNavigator.goToHomeRoom();
            return (true);
        }

        public function performTagSearch(_arg_1:String):void
        {
            return (_newNavigator.performTagSearch(_arg_1));
        }

        public function performTextSearch(_arg_1:String):void
        {
            return (_newNavigator.performTextSearch(_arg_1));
        }

        public function performGuildBaseSearch():void
        {
            return (_newNavigator.performSearch("groups"));
        }

        public function performCompetitionRoomsSearch(_arg_1:int, _arg_2:int):void
        {
            return (_newNavigator.performSearch("competition"));
        }

        public function showOwnRooms():void
        {
            return (_newNavigator.performSearch("myworld_view"));
        }

        public function goToPrivateRoom(_arg_1:int):void
        {
            _newNavigator.goToRoom(_arg_1);
        }

        public function hasRoomRightsButIsNotOwner(_arg_1:int):Boolean
        {
            return (_SafeStr_606.hasRoomRightsButIsNotOwner(_arg_1));
        }

        public function removeRoomRights(_arg_1:int):void
        {
            return (_SafeStr_606.removeRoomRights(_arg_1));
        }

        public function goToRoomNetwork(_arg_1:int, _arg_2:Boolean):void
        {
            return (goToRoomNetwork(_arg_1, _arg_2));
        }

        public function startRoomCreation():void
        {
            return (_newNavigator.createRoom());
        }

        public function openNavigator(_arg_1:Point=null):void
        {
            return (_newNavigator.open());
        }

        public function closeNavigator():void
        {
            return (_newNavigator.close());
        }

        public function get homeRoomId():int
        {
            return (_SafeStr_606.homeRoomId);
        }

        public function get enteredGuestRoomData():GuestRoomData
        {
            return (_SafeStr_606.enteredGuestRoomData);
        }

        public function showToolbarHover(_arg_1:Point):void
        {
        }

        public function hideToolbarHover(_arg_1:Boolean):void
        {
        }

        public function toggleRoomInfoVisibility():void
        {
            if (_roomInfoViewCtrl)
            {
                _roomInfoViewCtrl.toggle();
            };
        }

        public function canRateRoom():Boolean
        {
            return (_SafeStr_606.canRateRoom());
        }

        public function queueInterface(_arg_1:IID, _arg_2:Function=null):IUnknown
        {
            return (_newNavigator.queueInterface(_arg_1, _arg_2));
        }

        public function release(_arg_1:IID):uint
        {
            return (_newNavigator.release(_arg_1));
        }

        public function dispose():void
        {
            _roomSettingsCtrl.dispose();
            _roomInfoViewCtrl.dispose();
            _roomCreateViewCtrl.dispose();
            _passwordInput.dispose();
            _doorbell.dispose();
            _officialRoomEntryManager.dispose();
            _roomEventViewCtrl.dispose();
            _roomEventInfoCtrl.dispose();
            _roomFilterCtrl.dispose();
            _enforceCategoryCtrl = null;
            _SafeStr_606 = null;
            _newNavigator = null;
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_606 == null);
        }

        public function openCatalogRoomAdsExtendPage(_arg_1:String, _arg_2:String, _arg_3:Date, _arg_4:int):void
        {
            return (_SafeStr_606.openCatalogRoomAdsExtendPage(_arg_1, _arg_2, _arg_3, _arg_4));
        }

        public function getProperty(_arg_1:String, _arg_2:Dictionary=null):String
        {
            return (_SafeStr_606.getProperty(_arg_1, _arg_2));
        }

        public function get isDoorModeOverriddenInCurrentRoom():Boolean
        {
            return (_SafeStr_606.isDoorModeOverriddenInCurrentRoom);
        }

        public function trackNavigationDataPoint(_arg_1:String, _arg_2:String, _arg_3:String="", _arg_4:int=0):void
        {
            return (_SafeStr_606.trackNavigationDataPoint(_arg_1, _arg_2, _arg_3, _arg_4));
        }

        public function isRoomFavorite(_arg_1:int):Boolean
        {
            return (_SafeStr_606.isRoomFavorite(_arg_1));
        }

        public function isRoomHome(_arg_1:int):Boolean
        {
            return (_SafeStr_606.isRoomHome(_arg_1));
        }

        public function get visibleEventCategories():Array
        {
            return (_SafeStr_606.data.visibleEventCategories);
        }

        public function get roomSettingsControl():RoomSettingsCtrl
        {
            return (_SafeStr_606.roomSettingsCtrl);
        }


    }
}

