package com.sulake.habbo.communication
{
    import com.sulake.core.runtime.ICoreErrorLogger;
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import flash.net.URLVariables;
    import com.sulake.habbo.utils.CommunicationUtils;
    import flash.utils.describeType;
    import com.hurlant.crypto.hash.SHA1;
    import com.hurlant.util._SafeStr_15;
    import flash.utils.ByteArray;
    import flash.net.URLRequest;
    import flash.net.URLRequestHeader;
    import com.sulake.habbo.utils.PlatformData;

    public class HabboWebApiSession implements IHabboWebApiSession, IApiListener, ICoreErrorLogger
    {

        private var SHARED_SECRET:String = "CnurvLf7UP";
        private var _SafeStr_2147:Dictionary;
        private var _SafeStr_2148:XMLList;
        private var _server:String;
        private var _captchaToken:String;
        private var _listeners:Vector.<IHabboWebApiListener>;
        private var _SafeStr_2149:Boolean = false;
        private var _disposed:Boolean;
        private var _SafeStr_2150:String;
        private var _deviceToken:String;
        private var _SafeStr_2151:WebApiRequest;
        private var _SafeStr_2152:URLVariables;
        private var _SafeStr_2153:Array;
        private var _SafeStr_2154:String;

        public function HabboWebApiSession(_arg_1:String)
        {
            super();
            var _local_7:String = null;
            var _local_10:String = null;
            var _local_6:String = null;
            var _local_4:String = CommunicationUtils.readSOLString("machineid", CommunicationUtils.generateRandomHexString(32));
            _SafeStr_2150 = generateDeviceId(_local_4);
            _server = _arg_1;
            _listeners = new Vector.<IHabboWebApiListener>(0);
            _SafeStr_2148 = describeType(this)..method;
            var _local_9:XML = describeType(IHabboWebApiSession);
            Logger.log("[HabboWebApiSession] Start searching for Metadata");
            _SafeStr_2147 = new Dictionary();
            var _local_2:String = "";
            var _local_5:int;
            for each (var _local_8:XML in _local_9.factory.method)
            {
                _local_7 = _local_8.@name;
                for each (var _local_3:XML in _local_8.metadata)
                {
                    if (_local_3.@name == "HabboWebApiRoute")
                    {
                        _local_10 = _local_3.arg.(@key == "uri")[0].@value;
                        _local_6 = _local_3.arg.(@key == "method")[0].@value;
                        if (((!(_local_10 == null)) && (!(_local_6 == null))))
                        {
                            _SafeStr_2147[_local_7] = new WebApiRequest(_local_10, _local_6, (_local_10.indexOf("/public/") == -1));
                            _local_5++;
                        }
                        else
                        {
                            throw (new Error(("Web Api Route Metdata missing for method (both uri and requestType are required): " + _local_7)));
                        };
                    };
                };
            };
            if (_local_5 == 0)
            {
                Logger.log("[HabboWebApiSession] Could not fetch META information correctly, make sure the build-params keep the information!");
            };
        }

        private function generateDeviceId(_arg_1:String):String
        {
            var _local_2:SHA1 = new SHA1();
            var _local_4:ByteArray = _SafeStr_15.toArray(_SafeStr_15.fromString((SHARED_SECRET + _arg_1)));
            var _local_5:ByteArray = _local_2.hash(_local_4);
            var _local_3:String = _SafeStr_15.fromArray(_local_5);
            return ((_arg_1 + ":") + _local_3);
        }

        private function getFunctionName(_arg_1:Function):String
        {
            for each (var _local_2:XML in _SafeStr_2148)
            {
                if (this[_local_2.@name] == _arg_1)
                {
                    return (_local_2.@name);
                };
            };
            return (null);
        }

        private function getURL(_arg_1:String):String
        {
            return (_server + _arg_1);
        }

        private function executeRequest(_arg_1:String, _arg_2:URLVariables=null, _arg_3:Array=null):void
        {
            var _local_5:WebApiRequest;
            var _local_4:URLRequest;
            if (_arg_1 != null)
            {
                _local_5 = _SafeStr_2147[_arg_1];
                _SafeStr_2151 = _local_5;
                _SafeStr_2152 = _arg_2;
                _SafeStr_2153 = _arg_3;
                if (_local_5 != null)
                {
                    Logger.log(("Found request for method: " + _arg_1), _local_5.uri, _local_5.requestMethod);
                    if (_captchaToken != null)
                    {
                        if (_arg_2 == null)
                        {
                            _arg_2 = new URLVariables();
                        };
                        _arg_2.captchaToken = _captchaToken;
                        _captchaToken = null;
                    };
                    _local_4 = new URLRequest(getURL(_local_5.uri));
//                    _local_4.manageCookies = true;
                    if (_local_5.requestMethod.toUpperCase() == "GET".toUpperCase())
                    {
                        if (((!(_arg_2 == null)) && (_arg_2.toString().length > 0)))
                        {
                            _local_4.data = _arg_2;
                        };
                    }
                    else
                    {
                        if (((!(_arg_2 == null)) && (_arg_2.toString().length > 0)))
                        {
                            _local_4.data = JSON.stringify(_arg_2);
                        }
                        else
                        {
                            _local_4.data = "{}";
                        };
                        _local_4.requestHeaders.push(new URLRequestHeader("Content-type", "application/json"));
                    };
                    addHeaders(_local_4);
                    _local_5.makeRequest(this, _local_4);
                };
            }
            else
            {
                Logger.log("Could not execute request for null method...");
            };
        }

        public function setCaptchaToken(_arg_1:String):Boolean
        {
            var _local_2:String;
            _captchaToken = _arg_1;
            if ((((_SafeStr_2151) && (_SafeStr_2154)) && (_SafeStr_2154 == _SafeStr_2151.uri)))
            {
                _local_2 = getMethodForRequest(_SafeStr_2151);
                if (_local_2 != null)
                {
                    executeRequest(_local_2, _SafeStr_2152, _SafeStr_2153);
                    return (true);
                };
            };
            return (false);
        }

        public function get captchaToken():String
        {
            return (_captchaToken);
        }

        private function getMethodForRequest(_arg_1:WebApiRequest):String
        {
            var _local_2:WebApiRequest;
            for (var _local_3:String in _SafeStr_2147)
            {
                _local_2 = _SafeStr_2147[_local_3];
                if (((_local_2) && (_local_2.uri == _arg_1.uri)))
                {
                    return (_local_3);
                };
            };
            return (null);
        }

        private function addHeaders(_arg_1:URLRequest):void
        {
            _arg_1.requestHeaders.push(new URLRequestHeader("X-Habbo-Device-ID", _SafeStr_2150));
            _arg_1.requestHeaders.push(new URLRequestHeader("x-habbo-api-deviceid", _SafeStr_2150));
            _arg_1.requestHeaders.push(new URLRequestHeader("X-Habbo-Device-Type", PlatformData.platformString()));
        }

        public function apiResponse(_arg_1:String, _arg_2:Object):void
        {
            Logger.log(("[HabboWebApiSession] Got response for Web Api: " + _arg_1));
            if (_listeners != null)
            {
                for each (var _local_3:IHabboWebApiListener in _listeners)
                {
                    if (!_local_3.disposed)
                    {
                        _local_3.habboWebApiResponse(_arg_1, _arg_2);
                    };
                };
            };
        }

        public function apiRawResponse(_arg_1:String, _arg_2:Object):void
        {
            Logger.log(("[HabboWebApiSession] Got response for Web Api Raw: " + _arg_1));
            if (_listeners != null)
            {
                for each (var _local_3:IHabboWebApiListener in _listeners)
                {
                    if (!_local_3.disposed)
                    {
                        _local_3.habboWebApiRawResponse(_arg_1, _arg_2);
                    };
                };
            };
        }

        public function apiError(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:Object, _arg_5:Boolean=false):void
        {
            var _local_8:Array;
            var _local_7:String;
            Logger.log(("[HabboWebApiSession] Got error for Web Api: " + _arg_1), _arg_2, _arg_3, _arg_4);
            _SafeStr_2154 = null;
            if (((!(_arg_4 == null)) && (_arg_4 is String)))
            {
                _arg_4 = {"error":_arg_4};
            };
            if (((!(_arg_4 == null)) && (!(_arg_4 is String))))
            {
                if (_arg_4.error == null)
                {
                    _local_8 = _arg_4.errors;
                    _local_7 = (((_local_8) && (_local_8.length > 0)) ? _local_8[0] : "");
                    if (((_local_7 == "") && (!(_arg_4.message == null))))
                    {
                        _local_7 = _arg_4.message;
                    };
                }
                else
                {
                    _local_7 = (_arg_4.error as String);
                };
            }
            else
            {
                _local_7 = _arg_2.toString();
            };
            Logger.log(("[HabboWebApiSession] Error code: " + _local_7));
            switch (_local_7)
            {
                case "invalid-captcha":
                case "registration.captcha_is_empty":
                case "registration.invalid_captcha":
                    if (((_local_8 == null) || (_local_8.length == 1)))
                    {
                        _SafeStr_2154 = _arg_1;
                    };
            };
            if (_listeners != null)
            {
                for each (var _local_6:IHabboWebApiListener in _listeners)
                {
                    if (!_local_6.disposed)
                    {
                        _local_6.habboWebApiError(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
                    };
                };
            };
        }

        public function dispose():void
        {
            var _local_1:WebApiRequest;
            _listeners = null;
            _server = "";
            _disposed = true;
            for (var _local_2:String in _SafeStr_2147)
            {
                _local_1 = _SafeStr_2147[_local_2];
                _local_1.dispose();
            };
            _SafeStr_2147 = new Dictionary();
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function addListener(_arg_1:IHabboWebApiListener):Boolean
        {
            if (((_listeners) && (_listeners.indexOf(_arg_1) == -1)))
            {
                _listeners.push(_arg_1);
                return (true);
            };
            return (false);
        }

        public function removeListener(_arg_1:IHabboWebApiListener):void
        {
            var _local_2:int;
            if (_listeners)
            {
                _local_2 = _listeners.indexOf(_arg_1);
                if (_local_2 != -1)
                {
                    _listeners.splice(_local_2, 1);
                };
            };
        }

        public function emailChange(_arg_1:String):void
        {
            var _local_2:URLVariables = new URLVariables();
            _local_2.newEmail = _arg_1;
            executeRequest(getFunctionName(emailChange), _local_2);
        }

        public function passwordChange(_arg_1:String):void
        {
            var _local_2:URLVariables = new URLVariables();
            _local_2.newPassword = _arg_1;
            executeRequest(getFunctionName(passwordChange), _local_2);
        }

        public function tosAccept():void
        {
            executeRequest(getFunctionName(tosAccept));
        }

        public function captcha():void
        {
            executeRequest(getFunctionName(captcha));
        }

        public function achievements():void
        {
            executeRequest(getFunctionName(achievements));
        }

        public function achievementsForId(_arg_1:int):void
        {
            executeRequest(getFunctionName(achievementsForId), null, ["id", _arg_1]);
        }

        public function time():void
        {
            executeRequest(getFunctionName(time));
        }

        public function activate(_arg_1:String):void
        {
            var _local_2:URLVariables = new URLVariables();
            _local_2.token = _arg_1;
            executeRequest(getFunctionName(activate), _local_2);
        }

        public function login(_arg_1:String, _arg_2:String):void
        {
            var _local_3:URLVariables = new URLVariables();
            _local_3.email = _arg_1;
            _local_3.password = _arg_2;
            executeRequest(getFunctionName(login), _local_3);
        }

        public function facebook(_arg_1:String):void
        {
            var _local_2:URLVariables = new URLVariables();
            _local_2.accessToken = _arg_1;
            executeRequest(getFunctionName(facebook), _local_2);
        }

        public function rpx(_arg_1:String):void
        {
            var _local_2:URLVariables = new URLVariables();
            _local_2.token = _arg_1;
            executeRequest(getFunctionName(rpx), _local_2);
        }

        public function logout():void
        {
            executeRequest(getFunctionName(logout));
        }

        public function authenticateUser():void
        {
            executeRequest(getFunctionName(authenticateUser));
        }

        public function forgotPassword(_arg_1:String):void
        {
            var _local_2:URLVariables = new URLVariables();
            _local_2.email = _arg_1;
            executeRequest(getFunctionName(forgotPassword), _local_2);
        }

        public function changePassword(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String):void
        {
            var _local_5:URLVariables = new URLVariables();
            _local_5.token = _arg_1;
            _local_5.password = _arg_2;
            _local_5.answer1 = _arg_3;
            _local_5.answer2 = _arg_4;
            executeRequest(getFunctionName(changePassword), _local_5);
        }

        public function groups(_arg_1:int):void
        {
            executeRequest(getFunctionName(groups), null, ["id", _arg_1]);
        }

        public function members(_arg_1:int):void
        {
            executeRequest(getFunctionName(members), null, ["id", _arg_1]);
        }

        public function hello():void
        {
            executeRequest(getFunctionName(hello));
        }

        public function register(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Boolean, _arg_7:String):void
        {
            _captchaToken = _arg_7;
            var _local_8:URLVariables = new URLVariables();
            _local_8.email = _arg_1;
            _local_8.password = _arg_2;
            _local_8.passwordRepeated = _arg_2;
            _local_8.birthdate = {
                "day":_arg_3,
                "month":_arg_4,
                "year":_arg_5
            };
            _local_8.termsOfServiceAccepted = _arg_6;
            executeRequest(getFunctionName(register), _local_8);
        }

        public function popularRooms():void
        {
            executeRequest(getFunctionName(popularRooms));
        }

        public function room(_arg_1:int):void
        {
            executeRequest(getFunctionName(room), null, ["id", _arg_1]);
        }

        public function hotlooks():void
        {
            executeRequest(getFunctionName(hotlooks));
        }

        public function logCrash(_arg_1:String):void
        {
            var _local_2:URLVariables = new URLVariables();
            _local_2.message = _arg_1;
            executeRequest(getFunctionName(logCrash), _local_2);
        }

        public function logError(_arg_1:String):void
        {
            var _local_2:URLVariables = new URLVariables();
            _local_2.message = _arg_1;
            executeRequest(getFunctionName(logError), _local_2);
        }

        public function logLoginStep(_arg_1:String, _arg_2:String):void
        {
            var _local_3:URLVariables = new URLVariables();
            _local_3.step = _arg_1;
            executeRequest(getFunctionName(logLoginStep), _local_3);
        }

        public function clientUrl():void
        {
            executeRequest(getFunctionName(clientUrl));
        }

        public function nameCheck(_arg_1:String):void
        {
            var _local_2:URLVariables = new URLVariables();
            _local_2.name = _arg_1;
            executeRequest(getFunctionName(nameCheck), _local_2);
        }

        public function selectUser(_arg_1:String):void
        {
            var _local_2:URLVariables = new URLVariables();
            _local_2.name = _arg_1;
            executeRequest(getFunctionName(selectUser), _local_2);
        }

        public function selectRoom(_arg_1:int):void
        {
            var _local_2:URLVariables = new URLVariables();
            _local_2.roomIndex = _arg_1;
            executeRequest(getFunctionName(selectRoom), _local_2);
        }

        public function safetyLockStatus():void
        {
            executeRequest(getFunctionName(safetyLockStatus));
        }

        public function safetyLockDisable():void
        {
            executeRequest(getFunctionName(safetyLockDisable));
        }

        public function resetTrustedLogins():void
        {
            executeRequest(getFunctionName(resetTrustedLogins));
        }

        public function safetyLockSave(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:String):void
        {
            var _local_6:URLVariables = new URLVariables();
            _local_6.password = _arg_1;
            _local_6.questionId1 = _arg_2;
            _local_6.answer1 = _arg_3;
            _local_6.questionId2 = _arg_4;
            _local_6.answer2 = _arg_5;
            executeRequest(getFunctionName(safetyLockSave), _local_6);
        }

        public function safetyLockQuestions():void
        {
            executeRequest(getFunctionName(safetyLockQuestions));
        }

        public function safetyLockUnlock(_arg_1:String, _arg_2:String, _arg_3:Boolean):void
        {
            var _local_4:URLVariables = new URLVariables();
            _local_4.answer1 = _arg_1;
            _local_4.answer2 = _arg_2;
            _local_4.trustDevice = _arg_3;
            executeRequest(getFunctionName(safetyLockUnlock), _local_4);
        }

        public function commonFriends(_arg_1:int):void
        {
            executeRequest(getFunctionName(commonFriends), null, ["id", _arg_1]);
        }

        public function preferences():void
        {
            executeRequest(getFunctionName(preferences));
        }

        public function self():void
        {
            executeRequest(getFunctionName(self));
        }

        public function ping():void
        {
            executeRequest(getFunctionName(ping));
        }

        public function saveUser():void
        {
            executeRequest(getFunctionName(saveUser));
        }

        public function saveVisibility(_arg_1:Boolean):void
        {
            var _local_2:URLVariables = new URLVariables();
            _local_2.visibility = _arg_1;
            executeRequest(getFunctionName(saveVisibility), _local_2);
        }

        public function campaignMessages():void
        {
            executeRequest(getFunctionName(campaignMessages));
        }

        public function campaignMessagesAll():void
        {
            executeRequest(getFunctionName(campaignMessagesAll));
        }

        public function campaignMessagesSeen():void
        {
            executeRequest(getFunctionName(campaignMessagesSeen));
        }

        public function discussions():void
        {
            executeRequest(getFunctionName(discussions));
        }

        public function creditBalance():void
        {
            executeRequest(getFunctionName(creditBalance));
        }

        public function friendRequestsSent():void
        {
            executeRequest(getFunctionName(friendRequestsSent));
        }

        public function friendRequestsReceived():void
        {
            executeRequest(getFunctionName(friendRequestsReceived));
        }

        public function saveLooks(_arg_1:String, _arg_2:String):void
        {
            var _local_3:URLVariables = new URLVariables();
            _local_3.figure = _arg_1;
            _local_3.gender = _arg_2;
            executeRequest(getFunctionName(saveLooks), _local_3);
        }

        public function avatars():void
        {
            executeRequest(getFunctionName(avatars));
        }

        public function selectAvatar(_arg_1:String):void
        {
            var _local_2:URLVariables = new URLVariables();
            _local_2.uniqueId = _arg_1;
            executeRequest(getFunctionName(selectAvatar), _local_2);
        }

        public function changeEmail(_arg_1:String, _arg_2:String):void
        {
            var _local_3:URLVariables = new URLVariables();
            _local_3.newEmail = _arg_1;
            _local_3.currentPassword = _arg_2;
            executeRequest(getFunctionName(changeEmail), _local_3);
        }

        public function createAvatar(_arg_1:String):void
        {
            var _local_2:URLVariables = new URLVariables();
            _local_2.name = _arg_1;
            executeRequest(getFunctionName(createAvatar), _local_2);
        }

        public function profile():void
        {
            executeRequest(getFunctionName(profile));
        }

        public function ssoToken():void
        {
            executeRequest(getFunctionName(ssoToken));
        }

        public function validateItunesIAP(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:String):void
        {
            var _local_5:URLVariables = new URLVariables();
            _local_5.transactionId = _arg_1;
            _local_5.receipt = _arg_2;
            _local_5.centPrice = _arg_3;
            _local_5.priceLocale = _arg_4;
            executeRequest(getFunctionName(validateItunesIAP), _local_5);
        }

        public function validatePlaystoreIAP(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:String, _arg_5:String):void
        {
            var _local_6:URLVariables = new URLVariables();
            _local_6.transactionId = _arg_1;
            _local_6.receipt = _arg_2;
            _local_6.centPrice = _arg_3;
            _local_6.priceLocale = _arg_4;
            _local_6.signature = _arg_5;
            executeRequest(getFunctionName(validatePlaystoreIAP), _local_6);
        }

        public function setDeviceToken(_arg_1:String):void
        {
            var _local_2:URLVariables = new URLVariables();
            _local_2.device_token = _arg_1;
            _deviceToken = _arg_1;
            executeRequest(getFunctionName(setDeviceToken), _local_2);
        }

        public function getDeviceToken():String
        {
            return (_deviceToken);
        }


    }
}