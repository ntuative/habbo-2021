package com.sulake.habbo.friendbar.landingview
{
    import com.sulake.habbo.friendbar.view.AbstractView;
    import com.sulake.habbo.friendbar.IHabboLandingView;
    import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.quest.IHabboQuestEngine;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.habbo.avatar.IHabboAvatarEditor;
    import com.sulake.habbo.game.IHabboGameManager;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDHabboNavigator;
    import com.sulake.iid.IIDHabboQuestEngine;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDHabboHelp;
    import com.sulake.iid.IIDHabboGameManager;
    import com.sulake.iid.IIDHabboAvatarEditor;
    import com.sulake.iid.IIDRoomEngine;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.session._SafeStr_23;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.NavigatorSettingsEvent;
    import com.sulake.habbo.catalog.event.CatalogEvent;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.communication.messages.outgoing.navigator.ForwardToARandomPromotedRoomMessageComposer;
    import com.sulake.habbo.session.product.IProductDataListener;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.communication.messages.outgoing.inventory.badges.RequestABadgeComposer;
    import com.sulake.habbo.communication.messages.outgoing.landingview.votes.CommunityGoalVoteMessageComposer;
    import com.sulake.habbo.session.ISessionDataManager;

    public class HabboLandingView extends AbstractView implements IHabboLandingView 
    {

        private var _landingViewLayout:WidgetContainerLayout;
        private var _communicationManager:IHabboCommunicationManager;
        private var _roomSessionManager:IRoomSessionManager;
        private var _catalog:IHabboCatalog;
        private var _navigator:IHabboNavigator;
        private var _questEngine:IHabboQuestEngine;
        private var _toolbar:IHabboToolbar;
        private var _habboHelp:IHabboHelp;
        private var _avatarEditor:IHabboAvatarEditor;
        private var _gameManager:IHabboGameManager;
        private var _errorLayout:IWindow;
        private var _roomEngine:IRoomEngine;
        private var _SafeStr_573:Boolean = false;

        public function HabboLandingView(_arg_1:IContext, _arg_2:uint, _arg_3:IAssetLibrary)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        public static function positionAfterAndStretch(_arg_1:IWindowContainer, _arg_2:String, _arg_3:String):void
        {
            var _local_5:IWindow = _arg_1.findChildByName(_arg_2);
            var _local_6:IWindow = _arg_1.findChildByName(_arg_3);
            var _local_4:int = _local_6.x;
            _local_6.x = ((_local_5.x + _local_5.width) + 5);
            _local_6.width = (_local_6.width + (_local_4 - _local_6.x));
        }


        public function get catalog():IHabboCatalog
        {
            return (_catalog);
        }

        public function get navigator():IHabboNavigator
        {
            return (_navigator);
        }

        public function get questEngine():IHabboQuestEngine
        {
            return (_questEngine);
        }

        public function get tracking():IHabboTracking
        {
            return (_tracking);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get communicationManager():IHabboCommunicationManager
        {
            return (_communicationManager);
        }

        public function get localizationManager():IHabboLocalizationManager
        {
            return (_localizationManager);
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communicationManager = _arg_1;
            }), new ComponentDependency(new IIDHabboRoomSessionManager(), function (_arg_1:IRoomSessionManager):void
            {
                _roomSessionManager = _arg_1;
            }), new ComponentDependency(new IIDHabboConfigurationManager(), null), new ComponentDependency(new IIDHabboCatalog(), function (_arg_1:IHabboCatalog):void
            {
                _catalog = _arg_1;
            }), new ComponentDependency(new IIDHabboNavigator(), function (_arg_1:IHabboNavigator):void
            {
                _navigator = _arg_1;
            }), new ComponentDependency(new IIDHabboQuestEngine(), function (_arg_1:IHabboQuestEngine):void
            {
                _questEngine = _arg_1;
            }), new ComponentDependency(new IIDHabboToolbar(), function (_arg_1:IHabboToolbar):void
            {
                _toolbar = _arg_1;
            }), new ComponentDependency(new IIDHabboHelp(), function (_arg_1:IHabboHelp):void
            {
                _habboHelp = _arg_1;
            }), new ComponentDependency(new IIDHabboGameManager(), function (_arg_1:IHabboGameManager):void
            {
                _gameManager = _arg_1;
            }, false), new ComponentDependency(new IIDHabboAvatarEditor(), function (_arg_1:IHabboAvatarEditor):void
            {
                _avatarEditor = _arg_1;
            }), new ComponentDependency(new IIDRoomEngine(), function (_arg_1:IRoomEngine):void
            {
                _roomEngine = _arg_1;
            })]));
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                _SafeStr_573 = false;
                if (_landingViewLayout)
                {
                    _landingViewLayout.dispose();
                    _landingViewLayout = null;
                };
                if (((!(_toolbar == null)) && (!(_toolbar.events == null))))
                {
                    _toolbar.events.removeEventListener("HTE_TOOLBAR_CLICK", onToolbarClick);
                };
                if (_errorLayout)
                {
                    _errorLayout.dispose();
                    _errorLayout = null;
                };
                super.dispose();
            };
        }

        public function initialize():void
        {
            var _local_3:Array;
            var _local_5:int;
            var _local_4:String;
            _SafeStr_573 = true;
            var _local_2:IDesktopWindow = _windowManager.getDesktop(0);
            var _local_1:IWindow = _local_2.getChildByName("hotel_view_welcome_window");
            if (_local_1 != null)
            {
                _local_2.removeChild(_local_1);
                _local_1.dispose();
            };
            if (((newIdentity) && (getBoolean("landing.view.new_identity_override_enabled"))))
            {
                _local_3 = getProperty("landing.view.new_identity_widgets").split(",");
                _local_5 = 1;
                while (_local_5 <= 6)
                {
                    _local_4 = (("landing.view.dynamic.slot." + _local_5) + ".");
                    if (((_local_5 == 1) || (_local_5 == 6)))
                    {
                        setProperty((_local_4 + "widget"), "");
                    }
                    else
                    {
                        setProperty((_local_4 + "widget"), "widgetcontainer");
                        setProperty((_local_4 + "conf"), ("2001-01-01 00:00," + _local_3[(_local_5 - 2)]));
                    };
                    _local_5++;
                };
                setProperty("landing.view.dynamic.leftPaneWidth", "400");
                setProperty("landing.view.dynamic.rightPaneWidth", "400");
            };
            _landingViewLayout = new WidgetContainerLayout(this);
            activate();
        }

        public function activate():void
        {
            if (!_SafeStr_573)
            {
                tryInitialize();
            };
            if (_toolbar)
            {
                _toolbar.setToolbarState("HTE_STATE_HOTEL_VIEW");
            };
            if (_landingViewLayout != null)
            {
                _landingViewLayout.activate();
            }
            else
            {
                Logger.log("ERROR - Landing view layout is not initialized and cannot be activated - See caught errors in tryInitialize()");
            };
        }

        public function disable():void
        {
            if (_landingViewLayout != null)
            {
                _landingViewLayout.disable();
                toolbarExtensionExtraMargin = false;
            };
        }

        public function get isLandingViewVisible():Boolean
        {
            return (((!(_landingViewLayout == null)) && (!(_landingViewLayout.window == null))) && (_landingViewLayout.window.visible));
        }

        public function send(_arg_1:IMessageComposer):void
        {
            if (_communicationManager)
            {
                _communicationManager.connection.send(_arg_1);
            };
        }

        private function onToolbarClick(_arg_1:HabboToolbarEvent):void
        {
            switch (_arg_1.iconId)
            {
                case "HTIE_ICON_RECEPTION":
                    if (_roomSessionManager.getSession(-1))
                    {
                        send(new _SafeStr_23());
                        _roomSessionManager.disposeSession(-1);
                    };
                    return;
                case "HTIE_ICON_GAMES":
                    if (getBoolean("game.center.enabled"))
                    {
                        disable();
                    };
                    return;
            };
        }

        override protected function initComponent():void
        {
            _toolbar.events.addEventListener("HTE_TOOLBAR_CLICK", onToolbarClick);
            _catalog.events.addEventListener("CATALOG_INVISIBLE_PAGE_VISITED", onExpiredLinkCLick);
            _communicationManager.addHabboConnectionMessageEvent(new NavigatorSettingsEvent(onNavigatorSettings));
        }

        private function onExpiredLinkCLick(_arg_1:CatalogEvent):void
        {
            if (((((_SafeStr_573) && (!(_landingViewLayout == null))) && (!(_landingViewLayout.window == null))) && (_landingViewLayout.window.visible)))
            {
                activate();
            };
        }

        private function onNavigatorSettings(_arg_1:NavigatorSettingsEvent):void
        {
            if (_arg_1.getParser().roomIdToEnter <= 0)
            {
                tryInitialize();
            };
        }

        private function tryInitialize():void
        {
            _errorLayout = getXmlWindow("initialization_error");
            _errorLayout.visible = false;
            try
            {
                initialize();
                IWindowContainer(_errorLayout.parent).removeChild(_errorLayout);
            }
            catch(e:Error)
            {
                ErrorReportStorage.addDebugData("HabboLandingView", "Landing view layout initialization failed!");
                _landingViewLayout.dispose();
                _landingViewLayout = null;
                windowManager.getDesktop(0).addChild(_errorLayout);
                _errorLayout.center();
                _errorLayout.visible = true;
                context.root.error((e.message + " Landing view initialization failed because of a Flash Error. Landing view removed and disposed!"), false, e.errorID);
            };
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
                if (((_local_5 == null) || (_local_3 == null)))
                {
                    return null;
                };
                _local_4 = _windowManager.buildFromXML(XML(_local_3.content), _arg_2);
            }
            catch(e:Error)
            {
                ErrorReportStorage.addDebugData("HabboLandingView", (("Failed to build window " + _arg_1) + "_xml!"));
                throw (e);
            };
            return (_local_4);
        }

        public function goToRoom(_arg_1:String=null):void
        {
            if (_arg_1 == null)
            {
                _arg_1 = getProperty("landing.view.roomcategory");
            };
            if (_arg_1 != null)
            {
                send(new ForwardToARandomPromotedRoomMessageComposer(_arg_1));
            };
        }

        public function getProductData(_arg_1:String, _arg_2:IProductDataListener):IProductData
        {
            if (_sessionDataManager.loadProductData(_arg_2))
            {
                return (_sessionDataManager.getProductData(_arg_1));
            };
            return (null);
        }

        public function get habboHelp():IHabboHelp
        {
            return (_habboHelp);
        }

        public function requestBadge(_arg_1:String):void
        {
            send(new RequestABadgeComposer(_arg_1));
        }

        public function communityGoalVote(_arg_1:int):void
        {
            send(new CommunityGoalVoteMessageComposer(_arg_1));
        }

        public function get sessionDataManager():ISessionDataManager
        {
            return (_sessionDataManager);
        }

        public function set toolbarExtensionExtraMargin(_arg_1:Boolean):void
        {
            if (((_toolbar) && (_toolbar.extensionView)))
            {
                _toolbar.extensionView.extraMargin = ((_arg_1) ? 10 : 0);
            };
        }

        public function get newIdentity():Boolean
        {
            return (getInteger("new.identity", 0) > 0);
        }

        public function get dynamicLayoutLeftPaneWidth():int
        {
            return (getInteger("landing.view.dynamic.leftPaneWidth", 500));
        }

        public function get dynamicLayoutRightPaneWidth():int
        {
            return (getInteger("landing.view.dynamic.rightPaneWidth", 250));
        }

        public function get avatarEditor():IHabboAvatarEditor
        {
            return (_avatarEditor);
        }

        public function get roomEngine():IRoomEngine
        {
            return (_roomEngine);
        }


    }
}

