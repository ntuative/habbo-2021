package com.sulake.habbo.communication.demo
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.login.ILoginProvider;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import __AS3__.vec.Vector;
    import com.sulake.core.Core;
    import flash.display.Stage;
    import com.sulake.core.runtime.events.HotelViewEvent;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.utils.CommunicationUtils;
    import com.sulake.habbo.communication.IHabboWebApiSession;
    import flash.events.Event;
    import flash.events.DataEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.outgoing.handshake.TryLoginMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.handshake.SSOTicketMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.handshake.VersionCheckMessageComposer;
    import flash.system.Capabilities;
    import com.sulake.habbo.communication.messages.outgoing.handshake.UniqueIDMessageComposer;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import flash.utils.Timer;
    import com.sulake.habbo.communication.login.AvatarData;
    import flash.events.TimerEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.DisconnectReasonEvent;
    import com.sulake.core.runtime.events.ErrorEvent;
    import com.sulake.habbo.configuration.enum.HabboComponentFlags;

        public class HabboCommunicationDemo extends Component
    {

        public static const ERROR_TYPE_IO_ERROR:String = "ioError";
        public static const ERROR_CODE_MAINTENANCE:String = "maintenance";
        private static const AUTO_RECONNECT:Boolean = false;

        private var _SafeStr_596:HabboLoginDemoScreen;
        private var _SafeStr_1660:Boolean;
        private var _SafeStr_599:String;
        private var _SafeStr_457:IncomingMessages;
        private var _communication:IHabboCommunicationManager;
        private var _localization:IHabboLocalizationManager;
        private var _windowManager:IHabboWindowManager;
        private var _SafeStr_595:String;
        private var _SafeStr_598:String;
        private var _loginName:String;
        private var _SafeStr_600:String;
        private var _SafeStr_597:ILoginProvider;
        private var _SafeStr_1661:Boolean;
        private var _autoLogin:Boolean;
        private var _SafeStr_1662:Boolean;

        public function HabboCommunicationDemo(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            _arg_1.events.addEventListener("unload", unloading);
        }

        public function get communication():IHabboCommunicationManager
        {
            return (_communication);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function set ssoTicket(_arg_1:String):void
        {
            _SafeStr_595 = _arg_1;
        }

        public function set flashClientUrl(_arg_1:String):void
        {
            _SafeStr_598 = _arg_1;
        }

        public function get localization():IHabboLocalizationManager
        {
            return (_localization);
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(), function (_arg_1:IHabboWindowManager):void
            {
                _windowManager = _arg_1;
            }, (!(isRoomViewerMode))), new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communication = _arg_1;
            }), new ComponentDependency(new IIDHabboLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                _localization = _arg_1;
            }, true, [{
                "type":"complete",
                "callback":onLocalizationsComplete
            }, {
                "type":"LOCALIZATION_EVENT_LOCALIZATION_FAILED",
                "callback":onLocalizationFailed
            }])]));
        }

        override protected function initComponent():void
        {
            Core.instance.events.addEventListener("COMPONENT_EVENT_ERROR", onCoreError);
            var _local_1:Stage = context.displayObjectContainer.stage;
            if (_local_1 != null)
            {
                _local_1.dispatchEvent(new HotelViewEvent("HOTEL_VIEW_READY"));
            };
            _SafeStr_1661 = false;
            if (_SafeStr_457)
            {
                _SafeStr_457.dispose();
                if (_communication)
                {
                    _communication.renewSocket();
                };
            };
            _SafeStr_457 = new IncomingMessages(this, _communication);
            context.events.addEventListener("HHVE_ERROR", onHotelViewError);
            prepareProperties();
            HabboWebTools.baseUrl = getProperty("url.prefix");
            if (_autoLogin)
            {
                initWithStoredCredentials();
            }
            else
            {
                if (_SafeStr_595)
                {
                    initWithSSO(_SafeStr_595);
                }
                else
                {
                    initWithLoginView();
                };
            };
        }

        override public function dispose():void
        {
            if (Core.instance.events)
            {
                Core.instance.events.removeEventListener("COMPONENT_EVENT_ERROR", onCoreError);
            };
            if (_SafeStr_596)
            {
                _SafeStr_596.dispose();
                _SafeStr_596 = null;
            };
            if (_SafeStr_457)
            {
                _SafeStr_457.dispose();
                _SafeStr_457 = null;
            };
            _localization = null;
            _communication = null;
        }

        public function initGameSocket():void
        {
            dispatchLoginStepEvent("HABBO_CONNECTION_EVENT_INIT");
            if (_SafeStr_595 != null)
            {
                _communication.mode = 0;
            }
            else
            {
                _communication.mode = 0;
            };
            _communication.initConnection("habbo");
        }

        private function prepareProperties():void
        {
            _localization.loadDefaultEmbedLocalizations("en");
            _loginName = CommunicationUtils.readSOLString("login");
            _SafeStr_600 = CommunicationUtils.restorePassword();
            var _local_2:String = CommunicationUtils.readSOLString("environment");
            var _local_3:String = CommunicationUtils.readSOLString("loginmethod", "habbo");
            var _local_6:Boolean = CommunicationUtils.readSOLBoolean("autologin");
            var _local_5:Boolean = CommunicationUtils.forcedAutoLoginEnabled;
            CommunicationUtils.forcedAutoLoginEnabled = false;
            var _local_4:Array = getProperty("live.environment.list").split("/");
            if (_local_4.indexOf(_local_2) == -1)
            {
                Logger.log(("Missing environment, require hotel selection! " + _local_2));
                _local_2 = null;
                CommunicationUtils.writeSOLProperty("environment", null);
            };
            if (_local_2 != null)
            {
                initEnvironment(_local_2);
            };
            _SafeStr_595 = getProperty("sso.token");
            _SafeStr_598 = getProperty("flash.client.url");
            _SafeStr_599 = getProperty("external.variables.txt");
            var _local_1:Boolean = getBoolean("use.sso");
        }

        private function initWithStoredCredentials():void
        {
            _communication.mode = 0;
            _SafeStr_596.showLoadingScreen();
            var _local_1:String = CommunicationUtils.readSOLString("environment");
            initEnvironment(_local_1);
        }

        private function initWithSSO(_arg_1:String):void
        {
            _SafeStr_595 = _arg_1;
            _communication.mode = 0;
            initGameSocket();
        }

        private function initWithLoginView():void
        {
            var _local_1:String = CommunicationUtils.readSOLString("environment");
            if (!((_local_1 == null) || (_local_1 == "")))
            {
            };
            if (((!(_windowManager == null)) && (!(isRoomViewerMode))))
            {
                Core.crash("Login without an SSO ticket is not supported", 29);
            };
            if (((_local_1) && (_local_1 == "")))
            {
                _SafeStr_597.init(_communication);
            };
        }

        private function onInitLogin(_arg_1:Event):void
        {
            var _local_2:IHabboWebApiSession;
            if (_SafeStr_596.useWebApi)
            {
                _local_2 = _communication.getHabboWebApiSession();
                _local_2.login(_SafeStr_596.name, _SafeStr_596.password);
            }
            else
            {
                initGameSocket();
            };
        }

        private function onAvatarSelected(_arg_1:Event):void
        {
            var _local_2:IHabboWebApiSession;
            if (_SafeStr_596.useWebApi)
            {
                _local_2 = _communication.getHabboWebApiSession();
                _local_2.selectAvatar(_SafeStr_596.selectedAccount.uniqueId);
            }
            else
            {
                sendTryLoginDevelopmentOnly(_SafeStr_596.name, _SafeStr_596.password, _SafeStr_596.avatarId);
            };
        }

        private function onEnvironmentSelected(_arg_1:Event):void
        {
            initEnvironment(_SafeStr_596.selectedEnvironment);
        }

        private function initEnvironment(_arg_1:String):void
        {
            setProperty("environment.id", _arg_1);
            CommunicationUtils.writeSOLProperty("environment", _arg_1);
            updateEnvironmentVariables(_arg_1);
            _communication.updateHostParameters();
            _communication.resetHabboWebApiSession();
            _localization.loadDefaultEmbedLocalizations(_arg_1);
            if (_SafeStr_596 != null)
            {
                if (_SafeStr_596.useWebApi)
                {
                    _SafeStr_597.init(_communication);
                }
                else
                {
                    _SafeStr_596.environmentReady();
                };
            };
        }

        private function onConfigurationLoaded(_arg_1:Event):void
        {
            Logger.log("[HabboCommunicationDemo] Configuration Loaded!");
        }

        private function onConfigurationError(_arg_1:Event):void
        {
            var _local_2:DataEvent = (_arg_1 as DataEvent);
            Logger.log("[HabboCommunicationDemo] Configuration Error!");
            if (!((_local_2) && (_local_2.data == "503")))
            {
            };
        }

        private function onLocalizationsComplete(_arg_1:Event):void
        {
        }

        private function onLocalizationFailed(_arg_1:Event):void
        {
        }

        public function setSSOTicket(_arg_1:String):void
        {
            if (((_arg_1) && (!(_SafeStr_595))))
            {
                _SafeStr_595 = _arg_1;
                initGameSocket();
            };
        }

        public function sendTryLoginDevelopmentOnly(_arg_1:String, _arg_2:String, _arg_3:int=0):void
        {
            var _local_5:IConnection = _communication.connection;
            if (!_local_5)
            {
                _communication.initConnection("habbo");
                _local_5 = _communication.connection;
            };
            var _local_4:TryLoginMessageComposer = new TryLoginMessageComposer(_arg_1, _arg_2, _arg_3);
            _local_5.send(_local_4);
        }

        public function sendConnectionParameters(_arg_1:IConnection):void
        {
            var _local_2:SSOTicketMessageComposer;
            _arg_1.send(new VersionCheckMessageComposer(401, _SafeStr_598, _SafeStr_599));
            var _local_3:String = CommunicationUtils.readSOLString("machineid");
            var _local_4:String = CommunicationUtils.generateFingerprint();
            var _local_5:Array = Capabilities.version.split(" ");
            _arg_1.send(new UniqueIDMessageComposer(_local_3, _local_4, _local_5.join("/")));
            if (((_SafeStr_595) && (_SafeStr_595.length > 0)))
            {
                _local_2 = new SSOTicketMessageComposer(_SafeStr_595);
                _arg_1.send(_local_2);
            };
        }

        public function loginOk():void
        {
            _SafeStr_1661 = false;
            if (_SafeStr_596 != null)
            {
                _SafeStr_596.closeLoginWindow();
                _SafeStr_596.dispose();
                _SafeStr_596 = null;
            };
            _SafeStr_1662 = false;
        }

        public function alert(_arg_1:String, _arg_2:String):void
        {
            var titleKey:String = _arg_1;
            var messageKey:String = _arg_2;
            _windowManager.alert(titleKey, messageKey, 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
            {
                _arg_1.dispose();
            });
        }

        public function dispatchLoginStepEvent(_arg_1:String):void
        {
            if (((Component(context) == null) || (Component(context).events == null)))
            {
                return;
            };
            Component(context).events.dispatchEvent(new Event(_arg_1));
        }

        private function unloading(_arg_1:Event):void
        {
            _SafeStr_1660 = true;
        }

        public function onUserList(_arg_1:Vector.<AvatarData>):void
        {
            var _local_3:String;
            var _local_2:Timer;
            if (_autoLogin)
            {
                _local_3 = CommunicationUtils.readSOLString("useruniqueid");
                if (userExists(_arg_1, _local_3))
                {
                    _local_2 = new Timer(500, 1);
                    _local_2.addEventListener("timerComplete", onAutoSendLogin);
                    _local_2.start();
                }
                else
                {
                    _SafeStr_596.populateCharacterList(_arg_1);
                };
            }
            else
            {
                _SafeStr_596.populateCharacterList(_arg_1);
            };
        }

        private function onAutoSendLogin(_arg_1:TimerEvent):void
        {
            var _local_2:int = CommunicationUtils.readSOLInteger("userid");
            sendTryLoginDevelopmentOnly(_loginName, _SafeStr_600, _local_2);
        }

        private function userExists(_arg_1:Vector.<AvatarData>, _arg_2:String):Boolean
        {
            for each (var _local_3:AvatarData in _arg_1)
            {
                if (_local_3.uniqueId == _arg_2)
                {
                    return (true);
                };
            };
            return (false);
        }

        public function disconnected(_arg_1:int, _arg_2:String):void
        {
            var _local_3:String;
            _SafeStr_1661 = true;
            if (!_SafeStr_596)
            {
                if (((_arg_2 == null) || (_arg_2.length < 6)))
                {
                    _arg_2 = _localization.getLocalization(DisconnectReasonEvent.resolveDisconnectedReasonLocalizationKey(_arg_1));
                };
                _local_3 = "connection.login.logged_out";
                _localization.registerParameter(_local_3, "reason", _arg_1.toString());
                _localization.registerParameter(_local_3, "reasonName", _arg_2);
                alert(DisconnectReasonEvent.resolveDisconnectedReasonLocalizationKey(_arg_1), "${connection.login.logged_out}");
                return;
            };
            onBufferedDisconnected(_arg_1, _arg_2);
        }

        private function onBufferedDisconnected(_arg_1:int, _arg_2:String):void
        {
            var _local_5:Boolean;
            var _local_3:String;
            var _local_4:Boolean;
            if (_arg_1 == 20)
            {
                _SafeStr_596.showInvalidLoginError(null);
            }
            else
            {
                _local_5 = ((((_loginName) && (_loginName.length)) && (_SafeStr_600)) && (_SafeStr_600.length));
                _local_3 = CommunicationUtils.readSOLString("loginmethod", "habbo");
                _local_4 = (_local_3 == "facebook");
                if ((((!(_arg_1 == -3)) || ((!(_local_5)) && (!(_local_4)))) || (!(false))))
                {
                    _SafeStr_596.showDisconnected(_arg_1, _arg_2);
                    if (_communication)
                    {
                        _communication.disconnect();
                    };
                }
                else
                {
                    _SafeStr_1662 = true;
                    CommunicationUtils.forcedAutoLoginEnabled = true;
                    initComponent();
                };
            };
        }

        public function handleErrorMessage(_arg_1:int, _arg_2:int):void
        {
            switch (_arg_1)
            {
                case 0:
                    localization.registerParameter("connection.server.error.desc", "errorCode", String(_arg_1));
                    alert("${connection.server.error.title}", "${connection.server.error.desc}");
                    return;
                case 1001:
                case 1002:
                case 1003:
                case 1004:
                case 1005:
                case 1006:
                case 1007:
                case 1008:
                case 1009:
                case 1010:
                case 1011:
                case 1012:
                case 1013:
                case 1014:
                case 1015:
                case 1016:
                case 1017:
                case 1018:
                case 1019:
                    _communication.connection.close();
                    return;
                case 4013:
                    alert("${connection.room.maintenance.title}", "${connection.room.maintenance.desc}");
                    return;
                default:
                    localization.registerParameter("connection.server.error.desc", "errorCode", String(_arg_1));
                    alert("${connection.server.error.title}", "${connection.server.error.desc}");
                    return;
            };
        }

        private function onCoreError(_arg_1:ErrorEvent):void
        {
            switch (_arg_1.category)
            {
                case 30:
                case 29:
                case 1:
                case 3:
                case 20:
                case 8:
                case 12:
                case 7:
                    if (_arg_1.critical)
                    {
                        disconnected(-2, _localization.getLocalization("disconnected.reason.maintenance"));
                    };
                    return;
                default:
                    if (_arg_1.critical)
                    {
                        disconnected(-1, DisconnectReasonEvent.resolveDisconnectedReasonLocalizationKey(-1));
                    };
                    return;
            };
        }

        public function handleLoginFailedHotelClosedMessage(_arg_1:int, _arg_2:int):void
        {
            if (_SafeStr_596)
            {
                _SafeStr_596.showDisconnectedWithText(12);
            };
        }

        private function updateEnvironmentVariables(_arg_1:String):void
        {
            var _local_4:Array;
            var _local_2:String;
            var _local_5:String;
            _local_4 = [];
            _local_4.push("connection.info.host");
            _local_4.push("connection.info.port");
            _local_4.push("url.prefix");
            _local_4.push("site.url");
            _local_4.push("flash.dynamic.download.url");
            _local_4.push("flash.dynamic.download.name.template");
            _local_4.push("flash.dynamic.avatar.download.configuration");
            _local_4.push("flash.dynamic.avatar.download.url");
            _local_4.push("pocket.api");
            _local_4.push("web.api");
            _local_4.push("facebook.application.id");
            _local_4.push("web.terms_of_service.link");
            for each (var _local_3:String in _local_4)
            {
                _local_2 = getProperty(_local_3);
                _local_5 = ((_local_3 + ".") + _arg_1);
                if (propertyExists(_local_5))
                {
                    setProperty(_local_3, getProperty(_local_5));
                }
                else
                {
                    setProperty(_local_3, _local_2);
                };
            };
        }

        private function onHotelViewError(_arg_1:Event):void
        {
            disconnected(-2, _localization.getLocalization("disconnected.reason.maintenance"));
        }

        public function get isRoomViewerMode():Boolean
        {
            return (HabboComponentFlags.isRoomViewerMode(flags));
        }


    }
}