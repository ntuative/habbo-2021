package com.sulake.habbo.notifications
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.notifications.utils.ProductImageUtility;
    import com.sulake.habbo.notifications.utils.PetImageUtility;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.habbo.notifications.feed.NotificationController;
    import com.sulake.habbo.notifications.singular.SingularNotificationController;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboInventory;
    import com.sulake.iid.IIDHabboFriendList;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDHabboHelp;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.outgoing.users.GetMOTDMessageComposer;
    import com.sulake.core.utils.Map;
    import com.adobe.serialization.json.JSONDecoder;
    import com.sulake.habbo.catalog.event.CatalogEvent;

    public class HabboNotifications extends Component implements IHabboNotifications 
    {

        private var _communication:IHabboCommunicationManager;
        private var _sessionDataManager:ISessionDataManager;
        private var _windowManager:IHabboWindowManager;
        private var _localization:IHabboLocalizationManager;
        private var _inventory:IHabboInventory;
        private var _friendList:IHabboFriendList;
        private var _roomEngine:IRoomEngine;
        private var _catalog:IHabboCatalog;
        private var _toolBar:IHabboToolbar;
        private var _SafeStr_603:ProductImageUtility;
        private var _SafeStr_604:PetImageUtility;
        private var _roomSessionManager:IRoomSessionManager;
        private var _habboHelp:IHabboHelp;
        private var _feedController:NotificationController;
        private var _singularController:SingularNotificationController;
        private var _SafeStr_605:IncomingMessages;
        private var _disabled:Boolean;

        public function HabboNotifications(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            _disabled = false;
        }

        public function get assetLibrary():IAssetLibrary
        {
            return (assets);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (_localization);
        }

        public function get sessionDataManager():ISessionDataManager
        {
            return (_sessionDataManager);
        }

        public function get roomSessionManager():IRoomSessionManager
        {
            return (_roomSessionManager);
        }

        public function get catalog():IHabboCatalog
        {
            return (_catalog);
        }

        public function get toolBar():IHabboToolbar
        {
            return (_toolBar);
        }

        public function get habboHelp():IHabboHelp
        {
            return (_habboHelp);
        }

        public function get singularController():SingularNotificationController
        {
            return (_singularController);
        }

        public function get feedController():NotificationController
        {
            return (_feedController);
        }

        public function get disabled():Boolean
        {
            return (_disabled);
        }

        public function set disabled(_arg_1:Boolean):void
        {
            _disabled = _arg_1;
        }

        public function get productImageUtility():ProductImageUtility
        {
            if (((_roomEngine == null) || (_inventory == null)))
            {
                return (null);
            };
            if (_SafeStr_603 == null)
            {
                _SafeStr_603 = new ProductImageUtility(_roomEngine, _inventory);
            };
            return (_SafeStr_603);
        }

        public function get petImageUtility():PetImageUtility
        {
            if (_roomEngine == null)
            {
                return (null);
            };
            if (_SafeStr_604 == null)
            {
                _SafeStr_604 = new PetImageUtility(_roomEngine);
            };
            return (_SafeStr_604);
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboInventory(), function (_arg_1:IHabboInventory):void
            {
                _inventory = _arg_1;
            }, false), new ComponentDependency(new IIDHabboFriendList(), function (_arg_1:IHabboFriendList):void
            {
                _friendList = _arg_1;
            }, false), new ComponentDependency(new IIDSessionDataManager(), function (_arg_1:ISessionDataManager):void
            {
                _sessionDataManager = _arg_1;
            }), new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communication = _arg_1;
            }), new ComponentDependency(new IIDRoomEngine(), function (_arg_1:IRoomEngine):void
            {
                _roomEngine = _arg_1;
            }, false), new ComponentDependency(new IIDHabboCatalog(), function (_arg_1:IHabboCatalog):void
            {
                _catalog = _arg_1;
            }, false, [{
                "type":"CATALOG_BUILDER_MEMBERSHIP_EXPIRED",
                "callback":onBuilderMembershipExpired
            }, {
                "type":"CATALOG_BUILDER_MEMBERSHIP_IN_GRACE",
                "callback":onBuilderMembershipInGrace
            }]), new ComponentDependency(new IIDHabboToolbar(), function (_arg_1:IHabboToolbar):void
            {
                _toolBar = _arg_1;
            }), new ComponentDependency(new IIDHabboLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                _localization = _arg_1;
            }), new ComponentDependency(new IIDHabboWindowManager(), function (_arg_1:IHabboWindowManager):void
            {
                _windowManager = _arg_1;
            }), new ComponentDependency(new IIDHabboRoomSessionManager(), function (_arg_1:IRoomSessionManager):void
            {
                _roomSessionManager = _arg_1;
            }, false), new ComponentDependency(new IIDHabboHelp(), function (_arg_1:IHabboHelp):void
            {
                _habboHelp = _arg_1;
            })]));
        }

        override protected function initComponent():void
        {
            _singularController = new SingularNotificationController(this);
            _SafeStr_605 = new IncomingMessages(this, _communication);
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            if (_SafeStr_605 != null)
            {
                _SafeStr_605.dispose();
                _SafeStr_605 = null;
            };
            if (_feedController != null)
            {
                _feedController.dispose();
                _feedController = null;
            };
            if (_SafeStr_604 != null)
            {
                _SafeStr_604.dispose();
                _SafeStr_604 = null;
            };
            if (_SafeStr_603 != null)
            {
                _SafeStr_603.dispose();
                _SafeStr_603 = null;
            };
            super.dispose();
        }

        public function activate():void
        {
            if (_feedController != null)
            {
                _feedController.setFeedEnabled(true);
            };
            _communication.connection.send(new GetMOTDMessageComposer());
        }

        public function addSongPlayingNotification(_arg_1:String, _arg_2:String):void
        {
            _singularController.addSongPlayingNotification(_arg_1, _arg_2);
        }

        public function showNotification(_arg_1:String, _arg_2:Map=null):void
        {
            var _local_7:Object;
            var _local_9:String;
            var _local_6:String;
            var _local_3:Boolean;
            var _local_5:String;
            if (_arg_2 == null)
            {
                _arg_2 = new Map();
            };
            var _local_4:String = ("notification." + _arg_1);
            if (propertyExists(_local_4))
            {
                _local_7 = new JSONDecoder(getProperty(_local_4), true).getValue();
                for (var _local_8:String in _local_7)
                {
                    _arg_2[_local_8] = _local_7[_local_8];
                };
            };
            if (_arg_2["display"] == "BUBBLE")
            {
                _local_9 = getNotificationPart(_arg_2, _arg_1, "message", true);
                _local_6 = getNotificationPart(_arg_2, _arg_1, "linkUrl", false);
                _local_3 = ((!(_local_6 == null)) && (_local_6.substr(0, 6) == "event:"));
                _local_5 = getNotificationImageUrl(_arg_2, _arg_1);
                _singularController.addItem(_local_9, "info", null, _local_5, null, ((_local_3) ? _local_6.substr(6) : _local_6));
            }
            else
            {
                new NotificationPopup(this, _arg_1, _arg_2);
            };
        }

        public function getNotificationPart(_arg_1:Map, _arg_2:String, _arg_3:String, _arg_4:Boolean):String
        {
            var _local_5:String;
            if (_arg_1.hasKey(_arg_3))
            {
                return (_arg_1.getValue(_arg_3));
            };
            _local_5 = ["notification", _arg_2, _arg_3].join(".");
            if (((localization.hasLocalization(_local_5)) || (_arg_4)))
            {
                return (localization.getLocalizationWithParamMap(_local_5, _local_5, _arg_1));
            };
            return (null);
        }

        public function getNotificationImageUrl(_arg_1:Map, _arg_2:String):String
        {
            var _local_3:String = _arg_1.getValue("image");
            if (_local_3 == null)
            {
                _local_3 = (("${image.library.url}notifications/" + _arg_2.replace(/\./g, "_")) + ".png");
            };
            return (_local_3);
        }

        private function onBuilderMembershipInGrace(_arg_1:CatalogEvent):void
        {
            showNotification("builders_club.membership_in_grace", null);
        }

        private function onBuilderMembershipExpired(_arg_1:CatalogEvent):void
        {
            showNotification("builders_club.membership_expired", null);
        }

        public function createLinkEvent(_arg_1:String):void
        {
            context.createLinkEvent(_arg_1);
        }


    }
}

