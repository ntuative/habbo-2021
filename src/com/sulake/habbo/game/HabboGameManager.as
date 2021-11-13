package com.sulake.habbo.game
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.game.snowwar.SnowWarEngine;
    import com.sulake.habbo.friendbar.IHabboLandingView;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDHabboLandingView;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDHabboHelp;
    import com.sulake.iid.IIDHabboInventory;
    import com.sulake.iid.IIDHabboNavigator;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.game.snowwar.utils.WindowUtils;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2CheckGameDirectoryStatusMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2StartSnowWarMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2QuickJoinGameMessageComposer;
    import com.sulake.habbo.room.events.RoomObjectTileMouseEvent;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetSnowWarGameTokensOfferComposer;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;

    public class HabboGameManager extends Component implements IHabboGameManager 
    {

        private var _communication:IHabboCommunicationManager;
        private var _windowManager:IHabboWindowManager;
        private var _localization:IHabboLocalizationManager;
        private var _sessionDataManager:ISessionDataManager;
        private var _roomSessionManager:IRoomSessionManager;
        private var _toolbar:IHabboToolbar;
        private var _avatarManager:IAvatarRenderManager;
        private var _catalog:IHabboCatalog;
        private var _roomEngine:IRoomEngine;
        private var _habboHelp:IHabboHelp;
        private var _inventory:IHabboInventory;
        private var _navigator:IHabboNavigator;
        private var _SafeStr_458:SnowWarEngine;
        private var _SafeStr_457:IncomingMessages;
        private var _SafeStr_455:Boolean = false;
        private var _SafeStr_456:Boolean = false;
        private var _isHotelClosed:Boolean = false;
        private var _landingView:IHabboLandingView;
        private var _activeGame:int = -1;

        public function HabboGameManager(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            queueInterface(new IIDHabboWindowManager(), onWindowManagerReady);
            queueInterface(new IIDHabboCommunicationManager(), onHabboCommunicationReady);
            queueInterface(new IIDHabboConfigurationManager(), onConfigurationReady);
            queueInterface(new IIDHabboLocalizationManager(), onLocalizationReady);
            queueInterface(new IIDSessionDataManager(), onSessionDataManagerReady);
            queueInterface(new IIDHabboRoomSessionManager(), onRoomSessionManagerReady);
            queueInterface(new IIDAvatarRenderManager(), onAvatarRenderedReady);
            queueInterface(new IIDHabboToolbar(), onToolbarReady);
            queueInterface(new IIDHabboCatalog(), onCatalogReady);
            queueInterface(new IIDHabboLandingView(), onLandingViewReady);
            queueInterface(new IIDRoomEngine(), onRoomEngineReady);
            queueInterface(new IIDHabboHelp(), onHabboHelpReady);
            queueInterface(new IIDHabboInventory(), onHabboInventory);
            queueInterface(new IIDHabboNavigator(), onHabboNavigator);
            _SafeStr_458 = new SnowWarEngine(this, _arg_1, 0, _arg_3);
            HabboGamesCom.log(("HabboGameManager initialized: " + _arg_3));
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get sessionDataManager():ISessionDataManager
        {
            return (_sessionDataManager);
        }

        public function get communication():IHabboCommunicationManager
        {
            return (_communication);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (_localization);
        }

        public function get avatarManager():IAvatarRenderManager
        {
            return (_avatarManager);
        }

        public function get roomEngine():IRoomEngine
        {
            return (_roomEngine);
        }

        public function get inventory():IHabboInventory
        {
            return (_inventory);
        }

        public function get navigator():IHabboNavigator
        {
            return (_navigator);
        }

        public function get gameCenterEnabled():Boolean
        {
            return ((_SafeStr_455) || ((_SafeStr_456) && (sessionDataManager.hasSecurity(4))));
        }

        public function get isHotelClosed():Boolean
        {
            return (_isHotelClosed);
        }

        public function set hotelClosed(_arg_1:Boolean):void
        {
            _isHotelClosed = _arg_1;
        }

        override public function dispose():void
        {
            if (_communication)
            {
                _communication.release(new IIDHabboCommunicationManager());
                _communication = null;
            };
            if (_windowManager)
            {
                _windowManager.release(new IIDHabboWindowManager());
                _windowManager = null;
            };
            if (_localization)
            {
                _localization.release(new IIDHabboLocalizationManager());
                _localization = null;
            };
            if (_sessionDataManager != null)
            {
                _sessionDataManager.release(new IIDSessionDataManager());
                _sessionDataManager = null;
            };
            if (_habboHelp != null)
            {
                _habboHelp.release(new IIDHabboHelp());
                _habboHelp = null;
            };
            if (_toolbar)
            {
                if (_toolbar.events)
                {
                    _toolbar.events.removeEventListener("HTE_TOOLBAR_CLICK", onToolbarClick);
                };
                _toolbar.release(new IIDHabboToolbar());
                _toolbar = null;
            };
            if (_avatarManager != null)
            {
                _avatarManager.release(new IIDAvatarRenderManager());
                _avatarManager = null;
            };
            if (_catalog != null)
            {
                _catalog.release(new IIDHabboCatalog());
                _catalog = null;
            };
            if (_SafeStr_457)
            {
                _SafeStr_457.dispose();
                _SafeStr_457 = null;
            };
            if (_landingView)
            {
                _landingView.release(new IIDHabboLandingView());
                _landingView = null;
            };
            if (_roomEngine)
            {
                _roomEngine.release(new IIDRoomEngine());
                _roomEngine = null;
            };
            if (_inventory)
            {
                _inventory.release(new IIDHabboInventory());
                _inventory = null;
            };
            if (_navigator)
            {
                _navigator.release(new IIDHabboNavigator());
                _navigator = null;
            };
            _activeGame = -1;
            super.dispose();
        }

        private function onWindowManagerReady(_arg_1:IID, _arg_2:IUnknown):void
        {
            _windowManager = (_arg_2 as IHabboWindowManager);
            WindowUtils.init(assets, _windowManager);
        }

        private function onHabboCommunicationReady(_arg_1:IID, _arg_2:IUnknown):void
        {
            _communication = (_arg_2 as IHabboCommunicationManager);
            _SafeStr_457 = new IncomingMessages(this);
        }

        private function onConfigurationReady(_arg_1:IID, _arg_2:IUnknown):void
        {
            _SafeStr_455 = getBoolean("game.center.enabled");
            _SafeStr_456 = getBoolean("game.center.enabled.forStaff");
        }

        private function onLocalizationReady(_arg_1:IID, _arg_2:IUnknown):void
        {
            _localization = (_arg_2 as IHabboLocalizationManager);
        }

        private function onSessionDataManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            _sessionDataManager = (_arg_2 as ISessionDataManager);
        }

        private function onRoomSessionManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            _roomSessionManager = (_arg_2 as IRoomSessionManager);
        }

        private function onAvatarRenderedReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            _avatarManager = (_arg_2 as IAvatarRenderManager);
        }

        private function onToolbarReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            _toolbar = (_arg_2 as IHabboToolbar);
            _toolbar.events.addEventListener("HTE_TOOLBAR_CLICK", onToolbarClick);
        }

        private function onCatalogReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            _catalog = (_arg_2 as IHabboCatalog);
        }

        private function onLandingViewReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            _landingView = (_arg_2 as IHabboLandingView);
        }

        private function onRoomEngineReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            _roomEngine = (_arg_2 as IRoomEngine);
        }

        private function onHabboHelpReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            _habboHelp = (_arg_2 as IHabboHelp);
        }

        private function onHabboInventory(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            _inventory = (_arg_2 as IHabboInventory);
        }

        private function onHabboNavigator(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            _navigator = (_arg_2 as IHabboNavigator);
        }

        public function initGameDirectoryConnection():void
        {
            send(new Game2CheckGameDirectoryStatusMessageComposer());
        }

        public function startSnowWarGame(_arg_1:String):void
        {
            initGameDirectoryConnection();
            send(new Game2StartSnowWarMessageComposer(_arg_1));
        }

        public function startQuickSnowWarGame():void
        {
            send(new Game2QuickJoinGameMessageComposer());
        }

        public function onSnowWarArenaSessionEnded():void
        {
            if (!_SafeStr_458.isGameStarting)
            {
                _SafeStr_458.resetSession();
                if (_landingView != null)
                {
                    _landingView.activate();
                };
            };
        }

        public function generateChecksumMismatch():void
        {
            if (_SafeStr_458)
            {
                _SafeStr_458.generateChecksumMismatch();
            };
        }

        public function handleClickOnTile(_arg_1:RoomObjectTileMouseEvent):void
        {
            if (_SafeStr_458)
            {
                _SafeStr_458.handleClickOnTile(_arg_1);
            };
        }

        public function handleClickOnHuman(_arg_1:int, _arg_2:Boolean, _arg_3:Boolean):void
        {
            if (_SafeStr_458)
            {
                _SafeStr_458.handleClickOnHuman(_arg_1, _arg_2, _arg_3);
            };
        }

        public function handleMouseOverOnHuman(_arg_1:int, _arg_2:Boolean, _arg_3:Boolean):void
        {
            if (_SafeStr_458)
            {
                _SafeStr_458.handleMouseOverOnHuman(_arg_1, _arg_2, _arg_3);
            };
        }

        public function send(_arg_1:IMessageComposer):void
        {
            if (_communication)
            {
                _communication.connection.send(_arg_1);
            };
        }

        private function onToolbarClick(_arg_1:HabboToolbarEvent):void
        {
            switch (_arg_1.iconId)
            {
                case "HTIE_ICON_GAMES":
                    initGameDirectoryConnection();
                    send(new GetSnowWarGameTokensOfferComposer());
                    return;
                case "HTIE_ICON_RECEPTION":
                    return;
            };
        }


    }
}

