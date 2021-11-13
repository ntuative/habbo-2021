package com.sulake.habbo.utils
{
    import flash.net.SharedObject;
    import flash.geom.Point;
    import flash.utils.ByteArray;
    import flash.display.BitmapData;
    import com.hurlant.crypto.hash.MD5;
    import flash.external.ExternalInterface;
    import flash.system.Capabilities;
    import flash.text.Font;
    import com.hurlant.util._SafeStr_15;

    public class CommunicationUtils
    {

        public static const SOL_PROPERTY_ENVIRONMENT:String = "environment";
        public static const SOL_PROPERTY_LOGIN_NAME:String = "login";
        public static const SOL_PROPERTY_CHARACTER_ID:String = "userid";
        public static const SOL_PROPERTY_CHARACTER_UNIQUE_ID:String = "useruniqueid";
        public static const SOL_PROPERTY_REMEMBER_LOGIN:String = "autologin";
        public static const SOL_PROPERTY_LOGIN_METHOD:String = "loginmethod";
        public static const SOL_PROPERTY_MACHINE_ID:String = "machineid";
        public static const SOL_PROPERTY_APP_RATER_STATUS:String = "ratingstatus";
        public static const SOL_PROPERTY_APP_RATER_TIMESTAMP:String = "ratingstatustime";
        public static const LOGIN_METHOD_HABBO:String = "habbo";
        public static const _SafeStr_4353:String = "facebook";
        private static const SOL_ID:String = "fuselogin";
        private static const SOL_PROPERTY_PASSWORD:String = "password";

        private static var _forcedAutoLoginEnabled:Boolean;
        private static var _SafeStr_4354:IEncryptedLocalStorage;


        public static function set encryptedLocalStorage(_arg_1:IEncryptedLocalStorage):void
        {
            _SafeStr_4354 = _arg_1;
        }

        public static function clearAllLoginData():void
        {
            writeSOLProperty("loginmethod", null);
            writeSOLProperty("environment", null);
            writeSOLProperty("userid", null);
            writeSOLProperty("autologin", null);
            storePassword(null);
            CommunicationUtils.forcedAutoLoginEnabled = false;
        }

        public static function get forcedAutoLoginEnabled():Boolean
        {
            return (_forcedAutoLoginEnabled);
        }

        public static function set forcedAutoLoginEnabled(_arg_1:Boolean):void
        {
            _forcedAutoLoginEnabled = _arg_1;
        }

        public static function resetPassword():void
        {
            if (_SafeStr_4354)
            {
                _SafeStr_4354.reset();
            };
            writeSOLProperty("password", "");
        }

        public static function storePassword(_arg_1:String):void
        {
            if (_SafeStr_4354)
            {
                if (_SafeStr_4354.storeString("password", _arg_1))
                {
                    writeSOLProperty("password", "");
                }
                else
                {
                    writeSOLProperty("password", _arg_1);
                };
            }
            else
            {
                writeSOLProperty("password", _arg_1);
            };
        }

        public static function restorePassword():String
        {
            var _local_1:String;
            if (_SafeStr_4354)
            {
                _local_1 = _SafeStr_4354.restoreString("password");
            };
            if (!_local_1)
            {
                _local_1 = readSOLString("password", "");
            };
            return (_local_1);
        }

        public static function propertyExists(_arg_1:String):Boolean
        {
            var _local_3:SharedObject;
            var _local_2:Object;
            try
            {
                _local_3 = SharedObject.getLocal("fuselogin", "/");
                _local_2 = _local_3.data[_arg_1];
                if (_local_2 == null)
                {
                    var _local_5:Boolean = false;
                    return (_local_5);
                };
                var _local_6:Boolean = true;
                return (_local_6);
            }
            catch(e:Error)
            {
                return (false);
            };

            return false;
        }

        public static function writeSOLProperty(_arg_1:String, _arg_2:Object):void
        {
            var _local_3:SharedObject;
            try
            {
                _local_3 = SharedObject.getLocal("fuselogin", "/");
                _local_3.data[_arg_1] = _arg_2;
                _local_3.flush();
            }
            catch(e:Error)
            {
                Logger.log((((("Error writing SOL propert '" + _arg_1) + "' with value '") + _arg_2) + "'"));
            };
        }

        public static function readSOLProperty(_arg_1:String, _arg_2:Object=null):Object
        {
            var _local_4:SharedObject;
            var _local_3:Object;
            try
            {
                _local_4 = SharedObject.getLocal("fuselogin", "/");
                _local_3 = _local_4.data[_arg_1];
                if (_local_3 == null)
                {
                    _local_3 = _arg_2;
                };
                if (((_arg_1 == "environment") && (_local_3)))
                {
                    _local_3 = _local_3.replace("hh", "");
                    _local_3 = _local_3.replace("br", "pt");
                    _local_3 = _local_3.replace("us", "en");
                };
                var _local_6:Object = _local_3;
                return (_local_6);
            }
            catch(e:Error)
            {
                Logger.log((("Error reading SOL property '" + _arg_1) + "'"));
                return (_arg_2);
            };

            return _arg_2;
        }

        public static function readSOLString(_arg_1:String, _arg_2:String=null):String
        {
            var _local_3:Object = readSOLProperty(_arg_1, _arg_2);

            if (!_local_3)
            {
                return (null);
            };

            return String(_local_3);
        }

        public static function readSOLBoolean(_arg_1:String, _arg_2:String=null):Boolean
        {
            var _local_3:String = String(readSOLProperty(_arg_1, _arg_2));
            return ((!(_local_3 == null)) && ((_local_3.toLowerCase() == "true") || (_local_3 == "1")));
        }

        public static function readSOLInteger(_arg_1:String, _arg_2:String=null):int
        {
            var _local_3:Object = readSOLProperty(_arg_1, _arg_2);
            return (parseInt(String(_local_3)));
        }

        public static function readSOLFloat(_arg_1:String, _arg_2:String=null):Number
        {
            var _local_3:Object = readSOLProperty(_arg_1, _arg_2);
            return (parseFloat(String(_local_3)));
        }

        public static function decodeFromBitmap(_arg_1:BitmapData):String
        {
            var _local_18:int;
            var _local_17:int;
            var _local_5:uint;
            var _local_6:int;
            var _local_3:uint;
            var _local_9:uint;
            var _local_15:int = 4;
            var _local_4:Point = new Point(4, 39);
            var _local_2:Point = new Point(80, 30);
            var _local_14:ByteArray = _arg_1.getPixels(_arg_1.rect);
            var _local_16:int = _arg_1.width;
            var _local_7:String = "";
            var _local_12:uint;
            var _local_19:uint;
            var _local_13:uint;
            var _local_8:uint;
            if (_local_15 == 4)
            {
                _local_8 = 1;
            };
            var _local_10:int = (_local_4.y + _local_2.y);
            var _local_11:int = (_local_4.x + _local_2.x);
            _local_18 = _local_4.y;
            while (_local_18 < _local_10)
            {
                _local_17 = _local_4.x;
                while (_local_17 < _local_11)
                {
                    _local_5 = ((((_local_18 + _local_13) * _local_16) + _local_17) * _local_15);
                    _local_6 = _local_8;
                    while (_local_6 < _local_15)
                    {
                        _local_14.position = (_local_5 + _local_6);
                        _local_3 = _local_14.readUnsignedByte();
                        _local_9 = (_local_3 & 0x01);
                        _local_19 = (_local_19 | (_local_9 << (7 - _local_12)));
                        if (_local_12 == 7)
                        {
                            _local_7 = (_local_7 + String.fromCharCode(_local_19));
                            _local_19 = 0;
                            _local_12 = 0;
                        }
                        else
                        {
                            _local_12++;
                        };
                        _local_6++;
                    };
                    if ((_local_17 % 2) == 0)
                    {
                        _local_13++;
                    };
                    _local_17++;
                };
                _local_13 = 0;
                _local_18++;
            };
            return (_local_7);
        }

        public static function xor(_arg_1:String, _arg_2:String):String
        {
            var _local_7:int;
            var _local_5:uint;
            var _local_3:String = "";
            var _local_6:int;
            var _local_4:int = _arg_1.length;
            _local_7 = 0;
            while (_local_7 < _local_4)
            {
                _local_5 = _arg_1.charCodeAt(_local_7);
                _local_3 = (_local_3 + String.fromCharCode((_local_5 ^ _arg_2.charCodeAt(_local_6))));
                if (++_local_6 == _arg_2.length)
                {
                    _local_6 = 0;
                };
                _local_7++;
            };
            return (_local_3);
        }

        public static function generateFingerprint():String
        {
            var _local_8:String;
            var _local_4:String;
            var _local_2:String;
            var _local_5:String;
            var _local_9:Array;
            var _local_1:Array;
            var _local_3:String;
            var _local_6:String;
            var _local_11:ByteArray;
            var _local_12:MD5;
            var _local_7:String;
            try
            {
                if (ExternalInterface.available)
                {
                    _local_8 = ExternalInterface.call("window.navigator.userAgent.toString");
                    _local_4 = ExternalInterface.call("FlashExternalInterface.listPlugins");
                };
                _local_2 = Capabilities.serverString;
                _local_5 = new String(new Date().timezoneOffset);
                _local_9 = Font.enumerateFonts(true);
                _local_1 = [];
                for each (var _local_10:Font in _local_9)
                {
                    if (!((_local_10.fontType == "embedded") || (!(_local_10.fontStyle == "regular"))))
                    {
                        _local_1.push(_local_10.fontName);
                    };
                };
                _local_3 = _local_1.join(",");
                _local_6 = ((((((((_local_8 + "#") + _local_2) + "#") + _local_5) + "#") + _local_4) + "#") + _local_3);
                _local_11 = new ByteArray();
                _local_11.writeUTFBytes(_local_6);
                _local_12 = new MD5();
                _local_7 = _SafeStr_15.fromArray(_local_12.hash(_local_11), false);
                if (((!(_local_4)) || (_local_4.length == 0)))
                {
                    var _local_15:String = ("~" + _local_7);
                    return (_local_15);
                };
                var _local_14:String = _local_7;
                return (_local_14);
            }
            catch(e:Error)
            {
                return ("");
            };

            return "";
        }

        public static function generateRandomHexString(_arg_1:uint=16):String
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

        public static function removeProtocol(_arg_1:String):String
        {
            _arg_1 = _arg_1.replace("http://", "");
            return (_arg_1.replace("https://", ""));
        }


    }
}