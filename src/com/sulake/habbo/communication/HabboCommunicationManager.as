package com.sulake.habbo.communication
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.communication.connection.IConnectionStateListener;
    import com.sulake.core.communication.ICoreCommunicationManager;
    import com.sulake.core.communication.messages.IMessageConfiguration;
    import flash.utils.Timer;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDCoreCommunicationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import __AS3__.vec.Vector;
    import flash.events.Event;
    import com.sulake.core.Core;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.habbo.communication.encryption.ArcFour;
    import com.sulake.core.communication.encryption.IEncryption;
    import com.sulake.habbo.communication.encryption.DiffieHellman;
    import com.hurlant.math.BigInteger;
    import com.sulake.core.communication.handshake.IKeyExchange;
    import com.sulake.habbo.communication.messages.outgoing.handshake.DisconnectMessageComposer;
    import flash.events.IOErrorEvent;
    import flash.events.TimerEvent;
    import flash.events.SecurityErrorEvent;

    public class HabboCommunicationManager extends Component implements IHabboCommunicationManager, IConnectionStateListener
    {

        private static const DEFAULT_CONNECTION_ATTEMPTS:int = 2;

        private var _communication:ICoreCommunicationManager;
        private var _SafeStr_2122:IMessageConfiguration = new HabboMessages();
        private var _host:String = "";
        private var _ports:Array = [];
        private var _portIndex:int = -1;
        private var _SafeStr_2126:Timer = new Timer(100, 1);
        private var _attempts:int = 1;
        private var _SafeStr_2128:String = "";
        private var _SafeStr_2129:Boolean = false;
        private var _SafeStr_2130:Boolean = false;
        private var _webApiSession:IHabboWebApiSession;
        private var _connection:IConnection;
        private var _SafeStr_1493:int = 0;
        private var _requiresInitialRetryAttempt:Boolean = true;

        public function HabboCommunicationManager(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            _arg_1.events.addEventListener("unload", unloading);
        }


        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDCoreCommunicationManager(), function (_arg_1:ICoreCommunicationManager):void
            {
                _communication = _arg_1;
            }), new ComponentDependency(new IIDHabboConfigurationManager(), null, false, [{
                "type":"complete",
                "callback":onConfigurationComplete
            }])]));
        }

        private function onAuthenticated(_arg_1:Event):void
        {
            _connection.isAuthenticated();
        }

        private function onConfigurationComplete(_arg_1:Event):void
        {
            _connection.isConfigured();
        }

        public function disconnect():void
        {
            if (_connection)
            {
                _connection.close();
            };
        }

        public function get connection():IConnection
        {
            return (_connection);
        }

        public function get mode():int
        {
            return (0);
        }

        public function set mode(_arg_1:int):void
        {
            _SafeStr_1493 = _arg_1;
        }

        public function get port():int
        {
            if ((((_ports.length == 0) || (_portIndex < 0)) || (_portIndex >= _ports.length)))
            {
                return (0);
            };
            return (_ports[_portIndex]);
        }

        override protected function initComponent():void
        {
            context.events.addEventListener("HABBO_CONNECTION_EVENT_AUTHENTICATED", onAuthenticated);
            _connection = _communication.createConnection(this);
            _connection.registerMessageClasses(_SafeStr_2122);
            _connection.addListener("ioError", onIOError);
            _connection.addListener("securityError", onSecurityError);
            _connection.addListener("connect", onConnect);
            updateHostParameters();
            if (_SafeStr_2130)
            {
                nextPort();
            };
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            if (_connection)
            {
                _connection.dispose();
                _connection = null;
            };
            if (_webApiSession)
            {
                _webApiSession.dispose();
                _webApiSession = null;
            };
            super.dispose();
        }

        public function updateHostParameters():void
        {
            var _local_1:String = getProperty("connection.info.host", null);
            if (_local_1 == null)
            {
                Core.crash("connection.info.host", 30);
                return;
            };
            
            var _local_2: String = getProperty("connection.info.port", null);
            if (_local_2 == null)
            {
                Core.crash("connection.info.host", 30);
                return;
            };

            _ports = [];
            var _local_3:Array = _local_2.split(",");

            for each (var _local_4:String in _local_3)
            {
                _ports.push(parseInt(_local_4.replace(" ", "")));
            };

            _host = _local_1;
        }

        public function renewSocket():void
        {
            _attempts = 1;
            _requiresInitialRetryAttempt = true;
            if (_connection != null)
            {
                _connection.createSocket();
            };
        }

        public function initConnection(_arg_1:String):void
        {
            switch (_arg_1)
            {
                case "habbo":
                    if (_connection == null)
                    {
                        Core.crash("Tried to connect to proxy but connection was null", 30);
                        return;
                    };
                    _SafeStr_2130 = true;
                    if (allRequiredDependenciesInjected)
                    {
                        nextPort();
                    };
                    return;
                default:
                    return;
            };
        }

        public function addHabboConnectionMessageEvent(_arg_1:IMessageEvent):IMessageEvent
        {
            if (_connection)
            {
                _connection.addMessageEvent(_arg_1);
            };
            return (_arg_1);
        }

        public function removeHabboConnectionMessageEvent(_arg_1:IMessageEvent):void
        {
            if (_connection)
            {
                _connection.removeMessageEvent(_arg_1);
            };
        }

        public function connectionInit(_arg_1:String, _arg_2:int):void
        {
            ErrorReportStorage.setParameter("host", _arg_1);
            ErrorReportStorage.setParameter("port", String(_arg_2));
        }

        public function messageReceived(_arg_1:String):void
        {
            ErrorReportStorage.setParameter("rece_msg_time", String(new Date().getTime()));
            if (_SafeStr_2128.length > 0)
            {
                _SafeStr_2128 = (_SafeStr_2128 + (",R:" + _arg_1));
            }
            else
            {
                _SafeStr_2128 = ("R:" + _arg_1);
            };
            if (_SafeStr_2128.length > 150)
            {
                _SafeStr_2128 = _SafeStr_2128.substring((_SafeStr_2128.length - 150));
            };
        }

        public function messageSent(_arg_1:String):void
        {
            ErrorReportStorage.setParameter("sent_msg_time", String(new Date().getTime()));
            if (_SafeStr_2128.length > 0)
            {
                _SafeStr_2128 = (_SafeStr_2128 + (",S:" + _arg_1));
            }
            else
            {
                _SafeStr_2128 = ("S:" + _arg_1);
            };
            if (_SafeStr_2128.length > 150)
            {
                _SafeStr_2128 = _SafeStr_2128.substring((_SafeStr_2128.length - 150));
            };
        }

        public function messageParseError(_arg_1:IMessageDataWrapper):void
        {
            ErrorReportStorage.setParameter("sent_msg_data", (_arg_1 as Object).toString());
            ErrorReportStorage.addDebugData("MESSAGE_QUEUE", _SafeStr_2128);
        }

        public function setMessageQueueErrorDebugData():void
        {
            ErrorReportStorage.addDebugData("MESSAGE_QUEUE", _SafeStr_2128);
        }

        public function initializeEncryption():IEncryption
        {
            return (new ArcFour());
        }

        public function initializeKeyExchange(_arg_1:BigInteger, _arg_2:BigInteger):IKeyExchange
        {
            return (new DiffieHellman(_arg_1, _arg_2));
        }

        private function nextPort():void
        {
            var _local_1:int;
            if (!_connection)
            {
                return;
            };
            if (_connection.connected)
            {
                return;
            };
            _portIndex++;
            if (_portIndex >= _ports.length)
            {
                ErrorReportStorage.addDebugData("ConnectionRetry", ("Connection attempt " + _attempts));
                _attempts++;
                _local_1 = 2;
                if (_ports.length == 1)
                {
                    _local_1++;
                };
                if (_attempts <= _local_1)
                {
                    _portIndex = 0;
                }
                else
                {
                    if (_SafeStr_2129)
                    {
                        return;
                    };
                    _SafeStr_2129 = true;
                    Core.error("Connection failed to host and ports", true, 30);
                    return;
                };
            };
            _connection.timeout = (_attempts * 10000);
            _connection.init(_host, _ports[_portIndex]);
            if (_requiresInitialRetryAttempt)
            {
                _portIndex--;
                _requiresInitialRetryAttempt = false;
            };
        }

        private function tryNextPort():void
        {
            _SafeStr_2126.addEventListener("timer", onTryNextPort);
            _SafeStr_2126.start();
        }

        private function unloading(_arg_1:Event):void
        {
            if (_connection)
            {
                _connection.send(new DisconnectMessageComposer());
            };
        }

        private function onIOError(_arg_1:IOErrorEvent):void
        {
            switch (_arg_1.type)
            {
                case "ioError":
                    break;
                case "diskError":
                    break;
                case "networkError":
                    break;
                case "verifyError":
            };
            ErrorReportStorage.addDebugData("Communication IO Error", ((((("IOError " + _arg_1.type) + " on connect: ") + _arg_1.text) + ". Port was ") + _ports[_portIndex]));
            tryNextPort();
        }

        private function onConnect(_arg_1:Event):void
        {
            ErrorReportStorage.addDebugData("Connection", (("Connected with " + _attempts) + " attempts"));
        }

        private function onTryNextPort(_arg_1:TimerEvent):void
        {
            nextPort();
        }

        private function onSecurityError(_arg_1:SecurityErrorEvent):void
        {
            ErrorReportStorage.addDebugData("Communication Security Error", ((("SecurityError on connect: " + _arg_1.text) + ". Port was ") + _ports[_portIndex]));
            tryNextPort();
        }

        public function createHabboWebApiSession(_arg_1:IHabboWebApiListener, _arg_2:String):IHabboWebApiSession
        {
            if (_webApiSession != null)
            {
                resetHabboWebApiSession();
            };
            var _local_3:HabboWebApiSession = new HabboWebApiSession(_arg_2);
            _local_3.addListener(_arg_1);
            _webApiSession = _local_3;
            events.dispatchEvent(new Event("HABBO_POCKET_SESSION_CREATED"));
            return (_local_3);
        }

        public function getHabboWebApiSession():IHabboWebApiSession
        {
            return (_webApiSession);
        }

        public function resetHabboWebApiSession():void
        {
            if (_webApiSession)
            {
                _webApiSession.dispose();
                _webApiSession = null;
            };
        }


    }
}