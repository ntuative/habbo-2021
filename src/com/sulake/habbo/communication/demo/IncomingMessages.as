package com.sulake.habbo.communication.demo
{
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.core.communication.handshake.IKeyExchange;
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.hurlant.crypto.rsa.RSAKey;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.incoming.handshake.IdentityAccountsEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.PingMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.DisconnectReasonEvent;
    import com.sulake.habbo.communication.messages.parser.error.ErrorReportEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.InitDiffieHandshakeEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.CompleteDiffieHandshakeEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.GenericErrorEvent;
    import com.sulake.habbo.communication.messages.parser.availability.LoginFailedHotelClosedMessageEvent;
    import com.sulake.habbo.communication.messages.parser.availability.MaintenanceStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UniqueMachineIDEvent;
    import flash.events.Event;
    import flash.utils.ByteArray;
    import com.sulake.core.communication.encryption.CryptoTools;
    import com.hurlant.math.BigInteger;
    import com.sulake.core.Core;
    import com.sulake.habbo.communication.messages.outgoing.handshake.CompleteDiffieHandshakeMessageComposer;
    import com.sulake.core.communication.encryption.IEncryption;
    import com.sulake.habbo.communication.messages.outgoing.handshake.InfoRetrieveMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.habbo.communication.messages.parser.availability.LoginFailedHotelClosedMessageParser;
    import com.sulake.habbo.communication.messages.parser.handshake.GenericErrorParser;
    import com.sulake.habbo.communication.messages.outgoing.handshake.PongMessageComposer;
    import com.sulake.habbo.utils.CommunicationUtils;
    import com.sulake.habbo.communication.login.AvatarData;
    import flash.utils.Dictionary;
    import com.sulake.habbo.communication.messages.parser.error.ErrorReportMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.handshake.ClientHelloMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.handshake.InitDiffieHandshakeMessageComposer;
    import com.sulake.habbo.communication.messages.parser.availability.MaintenanceStatusMessageParser;
    import com.sulake.habbo.utils.HabboWebTools;
    import flash.external.ExternalInterface;
    import com.sulake.habbo.communication.demo.utils.Base64;
    import com.sulake.habbo.communication.demo.utils.KeyObfuscator;

        public class IncomingMessages 
    {

        private var _SafeStr_659:HabboCommunicationDemo;
        private var _communication:IHabboCommunicationManager;
        private var _SafeStr_1673:IKeyExchange;
        private var _privateKey:String;
        private var _SafeStr_1674:Boolean;
        private var _SafeStr_1660:Boolean;
        private var _messageEvents:Vector.<IMessageEvent> = new Vector.<IMessageEvent>(0);
        private var _rsa:RSAKey;

        public function IncomingMessages(_arg_1:HabboCommunicationDemo, _arg_2:IHabboCommunicationManager)
        {
            _SafeStr_659 = _arg_1;
            _communication = _arg_2;
            var _local_3:IConnection = _communication.connection;
            if (_local_3 == null)
            {
                throw (new Error("Connection is required to initialize!"));
            };
            _local_3.addEventListener("connect", onConnectionEstablished);
            _local_3.addEventListener("close", onConnectionDisconnected);
            addHabboConnectionMessageEvent(new IdentityAccountsEvent(onIdentityAccounts));
            addHabboConnectionMessageEvent(new AuthenticationOKMessageEvent(onAuthenticationOK));
            addHabboConnectionMessageEvent(new PingMessageEvent(onPing));
            addHabboConnectionMessageEvent(new DisconnectReasonEvent(onDisconnectReason));
            addHabboConnectionMessageEvent(new ErrorReportEvent(onErrorReport));
            addHabboConnectionMessageEvent(new InitDiffieHandshakeEvent(onInitDiffieHandshake));
            addHabboConnectionMessageEvent(new CompleteDiffieHandshakeEvent(onCompleteDiffieHandshake));
            addHabboConnectionMessageEvent(new GenericErrorEvent(onGenericError));
            addHabboConnectionMessageEvent(new LoginFailedHotelClosedMessageEvent(onLoginFailedHotelClosed));
            addHabboConnectionMessageEvent(new MaintenanceStatusMessageEvent(onMaintenance));
            addHabboConnectionMessageEvent(new UniqueMachineIDEvent(onUniqueMachineId));
            _SafeStr_659.context.events.addEventListener("unload", unloading);
        }

        private static function setReasonProperty(_arg_1:String, _arg_2:String):String
        {
            if (_arg_1.indexOf("%reason%") != -1)
            {
                return (_arg_1.replace("%reason%", _arg_2));
            };
            return (_arg_1);
        }


        public function dispose():void
        {
            var _local_1:IConnection;
            if (_communication)
            {
                _local_1 = _communication.connection;
                if (_local_1 != null)
                {
                    _local_1.removeEventListener("connect", onConnectionEstablished);
                    _local_1.removeEventListener("close", onConnectionDisconnected);
                };
                for each (var _local_2:IMessageEvent in _messageEvents)
                {
                    _communication.removeHabboConnectionMessageEvent(_local_2);
                };
                _messageEvents = new Vector.<IMessageEvent>(0);
            };
            _SafeStr_659 = null;
            _communication = null;
            _SafeStr_1673 = null;
        }

        private function addHabboConnectionMessageEvent(_arg_1:IMessageEvent):void
        {
            _communication.addHabboConnectionMessageEvent(_arg_1);
            _messageEvents.push(_arg_1);
        }

        private function unloading(_arg_1:Event):void
        {
            _SafeStr_1660 = true;
        }

        private function onInitDiffieHandshake(_arg_1:IMessageEvent):void
        {
            var _local_9:String;
            var _local_16:IConnection = _arg_1.connection;
            var _local_2:InitDiffieHandshakeEvent = (_arg_1 as InitDiffieHandshakeEvent);
            var _local_3:ByteArray = new ByteArray();
            var _local_4:ByteArray = new ByteArray();
            _local_3.writeBytes(CryptoTools.hexStringToByteArray(_local_2.encryptedPrime));
            _local_4.writeBytes(CryptoTools.hexStringToByteArray(_local_2.encryptedGenerator));
            var _local_5:ByteArray = new ByteArray();
            var _local_8:ByteArray = new ByteArray();
            _rsa = RSAKey.parsePublicKey(_SafeStr_7._SafeStr_251(-1820302793), "10001");
            _rsa.verify(_local_3, _local_5, _local_3.length);
            _rsa.verify(_local_4, _local_8, _local_4.length);
            var _local_11:BigInteger = new BigInteger(_local_5.toString(), 10);
            var _local_12:BigInteger = new BigInteger(_local_8.toString(), 10);
            var _local_10:BigInteger = BigInteger.nbv(2);
            if (((_local_11.compareTo(_local_10) <= 0) || (_local_12.compareTo(_local_11) >= 0)))
            {
                Core.crash("Invalid DH prime and generator", 29);
                return;
            };
            if (_local_11.equals(_local_12))
            {
                Core.crash("Invalid DH prime and generator", 29);
                return;
            };
            _SafeStr_1673 = _communication.initializeKeyExchange(_local_11, _local_12);
            var _local_6:String;
            var _local_13:int = 10;
            var _local_7:String;
            while (_local_13 > 0)
            {
                _local_7 = generateRandomHexString(30);
                _SafeStr_1673.init(_local_7);
                _local_9 = _SafeStr_1673.getPublicKey(10);
                if (_local_9.length < 64)
                {
                    if (((_local_6 == null) || (_local_9.length > _local_6.length)))
                    {
                        _local_6 = _local_9;
                        _privateKey = _local_7;
                    };
                }
                else
                {
                    _local_6 = _local_9;
                    _privateKey = _local_7;
                    break;
                };
                _local_13--;
            };
            if (_local_7 != _privateKey)
            {
                _SafeStr_1673.init(_privateKey);
            };
            var _local_15:ByteArray = new ByteArray();
            var _local_14:ByteArray = new ByteArray();
            _local_15.writeMultiByte(_local_6, "iso-8859-1");
            _rsa.encrypt(_local_15, _local_14, _local_15.length);
            _local_16.sendUnencrypted(new CompleteDiffieHandshakeMessageComposer(CryptoTools.byteArrayToHexString(_local_14)));
        }

        private function onCompleteDiffieHandshake(_arg_1:IMessageEvent):void
        {
            var _local_9:IEncryption;
            var _local_7:IConnection = _arg_1.connection;
            var _local_4:CompleteDiffieHandshakeEvent = (_arg_1 as CompleteDiffieHandshakeEvent);
            var _local_6:ByteArray = new ByteArray();
            var _local_3:ByteArray = new ByteArray();
            _local_6.writeBytes(CryptoTools.hexStringToByteArray(_local_4.encryptedPublicKey));
            _rsa.verify(_local_6, _local_3, _local_6.length);
            _rsa.dispose();
            _SafeStr_1673.generateSharedKey(_local_3.toString(), 10);
            var _local_2:String = _SafeStr_1673.getSharedKey(16).toUpperCase();
            if (!_SafeStr_1673.isValidServerPublicKey())
            {
                return;
            };
            var _local_8:ByteArray = CryptoTools.hexStringToByteArray(_local_2);
            _local_8.position = 0;
            var _local_5:IEncryption = _communication.initializeEncryption();
            _local_5.init(_local_8);
            if (_local_4.serverClientEncryption)
            {
                _local_9 = _communication.initializeEncryption();
                _local_9.init(_local_8);
            };
            _local_7.setEncryption(_local_5, _local_9);
            _SafeStr_1674 = false;
            _SafeStr_659.dispatchLoginStepEvent("HABBO_CONNECTION_EVENT_HANDSHAKED");
            _SafeStr_659.sendConnectionParameters(_local_7);
        }

        private function onAuthenticationOK(_arg_1:IMessageEvent):void
        {
            var _local_4:IConnection = _arg_1.connection;
            _SafeStr_659.dispatchLoginStepEvent("HABBO_CONNECTION_EVENT_AUTHENTICATED");
            var _local_2:InfoRetrieveMessageComposer = new InfoRetrieveMessageComposer();
            _local_4.send(_local_2);
            var _local_3:EventLogMessageComposer = new EventLogMessageComposer("Login", "socket", "client.auth_ok");
            _local_4.send(_local_3);
            _SafeStr_659.loginOk();
        }

        private function onLoginFailedHotelClosed(_arg_1:IMessageEvent):void
        {
            var _local_2:LoginFailedHotelClosedMessageParser = (_arg_1 as LoginFailedHotelClosedMessageEvent).getParser();
            _SafeStr_659.handleLoginFailedHotelClosedMessage(_local_2.openHour, _local_2.openMinute);
        }

        private function onGenericError(_arg_1:IMessageEvent):void
        {
            var _local_2:GenericErrorParser = (_arg_1 as GenericErrorEvent).getParser();
            switch (_local_2.errorCode)
            {
                case -3:
                    _SafeStr_659.alert("${connection.error.id.title}", "${connection.login.error.-3.desc}");
                    return;
                case -400:
                    _SafeStr_659.alert("${connection.error.id.title}", "${connection.login.error.-400.desc}");
                    return;
            };
        }

        private function onPing(_arg_1:IMessageEvent):void
        {
            var _local_2:IConnection = _arg_1.connection;
            var _local_3:PongMessageComposer = new PongMessageComposer();
            _local_2.send(_local_3);
        }

                private function onUniqueMachineId(_arg_1:UniqueMachineIDEvent):void
        {
            CommunicationUtils.writeSOLProperty("machineid", _arg_1.machineID);
        }

        private function onIdentityAccounts(_arg_1:IdentityAccountsEvent):void
        {
            var _local_3:String;
            var _local_6:AvatarData;
            var _local_4:Vector.<AvatarData> = new Vector.<AvatarData>(0);
            var _local_2:Dictionary = _arg_1.getParser().accounts;
            for (var _local_5:String in _local_2)
            {
                _local_3 = _local_2[_local_5];
                _local_6 = new AvatarData(null);
                _local_6.id = parseInt(_local_5);
                _local_6.name = _local_3;
                _local_4.push(_local_6);
            };
            _SafeStr_659.onUserList(_local_4);
        }

        private function onErrorReport(_arg_1:IMessageEvent):void
        {
            var _local_2:ErrorReportMessageParser = (_arg_1 as ErrorReportEvent).getParser();
            var _local_3:int = _local_2.errorCode;
            var _local_4:int = _local_2.messageId;
            _SafeStr_659.handleErrorMessage(_local_3, _local_4);
        }

        private function onConnectionEstablished(_arg_1:Event=null):void
        {
            var _local_2:IConnection = _communication.connection;
            if (_local_2 != null)
            {
                updateRsaData();
                _SafeStr_659.dispatchLoginStepEvent("HABBO_CONNECTION_EVENT_ESTABLISHED");
                _SafeStr_1660 = false;
                _SafeStr_1674 = true;
                _SafeStr_659.dispatchLoginStepEvent("HABBO_CONNECTION_EVENT_HANDSHAKING");
                _local_2.sendUnencrypted(new ClientHelloMessageComposer());
                _local_2.sendUnencrypted(new InitDiffieHandshakeMessageComposer());
            };
        }

        private function onMaintenance(_arg_1:MaintenanceStatusMessageEvent):void
        {
            var _local_2:MaintenanceStatusMessageParser = (_arg_1.parser as MaintenanceStatusMessageParser);
            Logger.log(("Got maintenance status, with minutes left: " + _local_2.minutesUntilMaintenance.toString()));
            _SafeStr_659.localization.registerParameter("disconnected.maintenance_status", "%minutes%", _local_2.minutesUntilMaintenance.toString());
            var _local_3:String = _SafeStr_659.localization.getLocalization("disconnected.maintenance_status");
            _SafeStr_659.disconnected(-2, _local_3);
        }

        private function onDisconnectReason(_arg_1:DisconnectReasonEvent):void
        {
            if (_SafeStr_1674)
            {
                _SafeStr_659.dispatchLoginStepEvent("HABBO_CONNECTION_EVENT_HANDSHAKE_FAIL");
            };
            Logger.log(("[HabboLogin] Got disconnect reason: " + _arg_1.reason));
            _SafeStr_659.disconnected(_arg_1.reason, _arg_1.getReasonName());
            _SafeStr_1674 = false;
            _SafeStr_1660 = true;
        }

        private function handleWebLogout(_arg_1:DisconnectReasonEvent):void
        {
            var _local_2:String = _SafeStr_659.getProperty("logout.url");
            if (_local_2.length > 0)
            {
                _local_2 = setReasonProperty(_local_2, _arg_1.reasonString);
                _local_2 = setOriginProperty(_local_2);
                _local_2 = (_local_2 + ("&id=" + _arg_1.reason));
                if (_SafeStr_659.context.configuration.getInteger("spaweb", 0) == 1)
                {
                    HabboWebTools.sendDisconnectToWeb(_arg_1.reason, _arg_1.reasonString);
                }
                else
                {
                    HabboWebTools.openWebPage(_local_2, "_self");
                };
            };
        }

        private function setOriginProperty(_arg_1:String):String
        {
            if (_arg_1.indexOf("%origin%") != -1)
            {
                return (_arg_1.replace("%origin%", _SafeStr_659.getProperty("flash.client.origin")));
            };
            return (_arg_1);
        }

        private function onConnectionDisconnected(_arg_1:Event):void
        {
            var _local_2:String;
            if (_SafeStr_659.isRoomViewerMode)
            {
                return;
            };
            if (_SafeStr_1674)
            {
                _SafeStr_659.dispatchLoginStepEvent("HABBO_CONNECTION_EVENT_HANDSHAKE_FAIL");
            };
            if (ExternalInterface.available)
            {
                ExternalInterface.call("FlashExternalInterface.logDisconnection", "Communication failure, client disconnected.");
                if (((_arg_1.type == "close") && (!(_SafeStr_1660))))
                {
                    _local_2 = _SafeStr_659.getProperty("logout.disconnect.url");
                    _local_2 = setOriginProperty(_local_2);
                    if (_SafeStr_659.context.configuration.getInteger("spaweb", 0) == 1)
                    {
                        HabboWebTools.sendDisconnectToWeb(-1, "HABBO_CONNECTION_EVENT_HANDSHAKE_FAIL");
                    }
                    else
                    {
                        HabboWebTools.openWebPage(_local_2, "_self");
                    };
                };
            };
            if (((_arg_1.type == "close") && (!(_SafeStr_1660))))
            {
                _SafeStr_659.disconnected(-3, "");
            };
        }

        private function generateRandomHexString(_arg_1:uint=16):String
        {
            var _local_4:int;
            var _local_3:uint;
            var _local_2:String = "";
            _local_4 = 0;
            while (_local_4 < _arg_1)
            {
                _local_3 = uint((Math.random() * 0xFF));
                _local_2 = (_local_2 + _local_3.toString(16));
                _local_4++;
            };
            return (_local_2);
        }

        public function updateRsaData():void
        {
            var _local_5:String = "xIBlMDUyODA4YzFhYmVmNjlhMWE2MmMzOTYzOTZiODU5NTVlMmZmNTIyZjUxNTc2MzlmYTZhMTlhOThiNTRlMGU0ZDZlNDRmNDRjNGMwMzkwZmVlOGNjZjY0MmEyMmI2ZDQ2ZDcyMjhiMTBlMzRhZTZmZmZiNjFhMzVjMTEzMzM3ODBhZjZkZDFhYWFmYTczODhmYTZjNjViNTFlODIyNWM2YjU3Y2Y1ZmJhYzMwODU2ZTg5NjIyOTUxMmUxZjlhZjAzNDg5NTkzN2IyY2I2NjM3ZWI2ZWRmNzY4YzEwMTg5ZGYzMGMxMGQ4YTNlYzIwNDg4YTE5ODA2MzU5OWNhNmFkBTEwMDAx";
            var _local_3:String = Base64.decode(_local_5);
            var _local_2:int = _local_3.charCodeAt(0);
            var _local_4:int = _local_3.charCodeAt((_local_2 + 1));
            var _local_1:Array = KeyObfuscator.getRsaData();
            _local_1[0] = _local_3.substr(1, _local_2);
            _local_1[1] = _local_3.substr((_local_2 + 2), _local_4);
        }


    }
}

