package com.sulake.habbo.nux
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.events.ILinkEventTracker;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.core.communication.connection.IConnection;
    import flash.utils.Timer;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboNavigator;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.nux.NewUserExperienceNotCompleteEvent;
    import com.sulake.habbo.communication.messages.incoming.nux.NewUserExperienceGiftOfferEvent;
    import com.sulake.habbo.communication.messages.outgoing.gifts.SetPhoneNumberVerificationStatusMessageComposer;
    import com.sulake.habbo.window.utils._SafeStr_126;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.nux.NewUserExperienceGetGiftsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.nux.NewUserExperienceGetGiftsSelection;
    import com.sulake.habbo.communication.messages.parser.nux.NewUserExperienceGiftOfferParser;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.habbo.communication.messages.incoming.nux.NewUserExperienceGiftOptions;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import flash.events.TimerEvent;

    public class HabboNuxDialogs extends Component implements ILinkEventTracker 
    {

        protected var _communicationManager:IHabboCommunicationManager;
        protected var _navigator:IHabboNavigator;
        protected var _windowManager:IHabboWindowManager;
        protected var _localizationManager:IHabboLocalizationManager;
        protected var _catalog:IHabboCatalog;
        protected var _sessionDataManager:ISessionDataManager;
        protected var _roomSessionManager:IRoomSessionManager;
        private var _connection:IConnection;
        private var _SafeStr_3043:NuxOfferOldUserView;
        private var _SafeStr_3044:NuxGiftSelectionView;
        private var _SafeStr_3045:NuxNoobRoomOfferView;
        private var _SafeStr_2690:Timer;

        public function HabboNuxDialogs(_arg_1:IContext, _arg_2:uint, _arg_3:IAssetLibrary)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communicationManager = _arg_1;
            }, true), new ComponentDependency(new IIDHabboWindowManager(), function (_arg_1:IHabboWindowManager):void
            {
                _windowManager = _arg_1;
            }), new ComponentDependency(new IIDHabboNavigator(), function (_arg_1:IHabboNavigator):void
            {
                _navigator = _arg_1;
            }), new ComponentDependency(new IIDHabboLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                _localizationManager = _arg_1;
            }), new ComponentDependency(new IIDHabboCatalog(), function (_arg_1:IHabboCatalog):void
            {
                _catalog = _arg_1;
            }), new ComponentDependency(new IIDSessionDataManager(), function (_arg_1:ISessionDataManager):void
            {
                _sessionDataManager = _arg_1;
            }), new ComponentDependency(new IIDHabboRoomSessionManager(), function (_arg_1:IRoomSessionManager):void
            {
                _roomSessionManager = _arg_1;
            }, false, [{
                "type":"RSE_STARTED",
                "callback":onRoomSessionEvent
            }, {
                "type":"RSE_ENDED",
                "callback":onRoomSessionEvent
            }])]));
        }

        override public function dispose():void
        {
            context.removeLinkEventTracker(this);
            if (_windowManager)
            {
                _windowManager = null;
            };
            destroyGiftSelectionView();
            destroyNoobRoomOfferView();
            destroyNuxOfferView();
            super.dispose();
        }

        override protected function initComponent():void
        {
            _connection = _communicationManager.connection;
            if (_connection)
            {
                _connection.addMessageEvent(new NewUserExperienceNotCompleteEvent(onNewUserExperienceNotCompleteMessage));
                _connection.addMessageEvent(new NewUserExperienceGiftOfferEvent(onNewUserExperienceGiftOfferMessage));
            };
            context.addLinkEventTracker(this);
        }

        public function get linkPattern():String
        {
            return ("nux/");
        }

        public function linkReceived(_arg_1:String):void
        {
            var _local_2:Array = _arg_1.split("/");
            if (_local_2.length < 2)
            {
                return;
            };
            switch (_local_2[1])
            {
                case "lobbyoffer":
                    if (((_local_2.length > 2) && (_local_2[2] == "show")))
                    {
                        createNoobRoomOfferView();
                    }
                    else
                    {
                        destroyNoobRoomOfferView();
                    };
                    return;
                default:
                    Logger.log(("HabboNuxDialogs unknown link-type received: " + _local_2[1]));
                    return;
            };
        }

        public function onVerify():void
        {
            _connection.send(new SetPhoneNumberVerificationStatusMessageComposer(0));
        }

        public function onReject():void
        {
            _windowManager.confirm("${phone.number.never.again.confirm.title}", "${phone.number.never.again.confirm.text}", 0, onNeverAgainConfirmClose);
        }

        private function onNeverAgainConfirmClose(_arg_1:_SafeStr_126, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
            if (((_arg_2.type == "WE_OK") && (_connection)))
            {
                destroyNuxOfferView();
                _connection.send(new SetPhoneNumberVerificationStatusMessageComposer(2));
            };
        }

        public function onSendGetGifts(_arg_1:Vector.<NewUserExperienceGetGiftsSelection>):void
        {
            destroyGiftSelectionView();
            _connection.send(new NewUserExperienceGetGiftsMessageComposer(_arg_1));
        }

        private function onNewUserExperienceNotCompleteMessage(_arg_1:NewUserExperienceNotCompleteEvent):void
        {
            createNuxOfferView();
        }

        private function onNewUserExperienceGiftOfferMessage(_arg_1:NewUserExperienceGiftOfferEvent):void
        {
            var _local_2:NewUserExperienceGiftOfferParser = _arg_1.getParser();
            createGiftSelectionView(_local_2.giftOptions);
        }

        private function onRoomSessionEvent(_arg_1:RoomSessionEvent):void
        {
            var _local_2:uint;
            if (((!(getBoolean("nux.lobbies.enabled"))) || (!(_sessionDataManager.isRealNoob))))
            {
                return;
            };
            if ((((_arg_1.type == "RSE_STARTED") && (_arg_1.session)) && (_arg_1.session.roomId == _navigator.homeRoomId)))
            {
                _local_2 = (getInteger("nux.noob.lobby.popup.delay", 70) * 1000);
                _SafeStr_2690 = new Timer(_local_2, 1);
                _SafeStr_2690.addEventListener("timer", createNoobRoomOfferView);
                _SafeStr_2690.start();
            }
            else
            {
                destroyNoobRoomOfferView();
            };
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get localizationManager():IHabboLocalizationManager
        {
            return (_localizationManager);
        }

        public function get sessionDataManager():ISessionDataManager
        {
            return (_sessionDataManager);
        }

        public function get configuration():ICoreConfiguration
        {
            return (this);
        }

        public function get catalog():IHabboCatalog
        {
            return (_catalog);
        }

        private function createNuxOfferView():void
        {
            destroyNuxOfferView();
            _SafeStr_3043 = new NuxOfferOldUserView(this);
        }

        public function destroyNuxOfferView():void
        {
            if (_SafeStr_3043)
            {
                _SafeStr_3043.dispose();
                _SafeStr_3043 = null;
            };
        }

        private function createGiftSelectionView(_arg_1:Vector.<NewUserExperienceGiftOptions>):void
        {
            destroyGiftSelectionView();
            _SafeStr_3044 = new NuxGiftSelectionView(this, _arg_1);
        }

        private function destroyGiftSelectionView():void
        {
            if (_SafeStr_3044)
            {
                _SafeStr_3044.dispose();
                _SafeStr_3044 = null;
            };
        }

        private function startNoobRoomOfferTimer():void
        {
        }

        private function createNoobRoomOfferView(_arg_1:TimerEvent=null):void
        {
            if (((!(getBoolean("nux.lobbies.enabled"))) || (!(_sessionDataManager.isRealNoob))))
            {
                return;
            };
            destroyNoobRoomOfferView();
            _SafeStr_3045 = new NuxNoobRoomOfferView(this);
            _connection.send(new EventLogMessageComposer("NewNavigator", "nux.offer.lobby", "nux.offer.lobby"));
        }

        public function destroyNoobRoomOfferView():void
        {
            if (_SafeStr_2690)
            {
                _SafeStr_2690.reset();
                _SafeStr_2690 = null;
            };
            if (_SafeStr_3045)
            {
                _SafeStr_3045.dispose();
                _SafeStr_3045 = null;
            };
        }


    }
}

