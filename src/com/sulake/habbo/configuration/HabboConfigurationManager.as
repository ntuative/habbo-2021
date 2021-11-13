package com.sulake.habbo.configuration
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.ICoreConfiguration;
    import flash.utils.Dictionary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.utils.CommunicationUtils;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import __AS3__.vec.Vector;
    import flash.events.Event;
    import com.sulake.core.assets.AssetLoaderStruct;
    import flash.net.URLRequest;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.Core;
    import flash.utils.ByteArray;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.utils.ErrorReportStorage;
    import flash.system.Security;
    import com.sulake.core.assets.TextAsset;
    import com.sulake.core.runtime.ICore;
    import flash.display.Stage;

    public class HabboConfigurationManager extends Component implements ICoreConfiguration, IHabboConfigurationManager
    {

        private static const INTERPOLATION_DEPTH_LIMIT:int = 3;
        private static const REPLACE_CHAR:String = "%";

        private var _SafeStr_2169:Boolean = false;
        private var _SafeStr_2170:Boolean = false;
        private var _SafeStr_2171:Dictionary;
        private var _SafeStr_527:Boolean = false;
        private var _SafeStr_2172:Array = [];
        private var _SafeStr_2173:Boolean = false;
        private var _SafeStr_1701:String;
        private var _localization:IHabboLocalizationManager;

        public function HabboConfigurationManager(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            _arg_1.configuration = this;
            _SafeStr_2169 = ((_arg_2 & 0x10000000) > 0);
            _SafeStr_2170 = ((_arg_2 & 0x01000000) > 0);
            lock();
            resetAll();
            if (((!(propertyExists("environment.id"))) && (CommunicationUtils.propertyExists("environment"))))
            {
                updateEnvironmentId(CommunicationUtils.readSOLString("environment"));
            };
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                _localization = _arg_1;
            }, false, [{
                "type":"complete",
                "callback":onLocalizationComplete
            }])]));
        }

        private function onLocalizationComplete(_arg_1:Event):void
        {
            initConfigurationDownload();
        }

        public function updateEnvironmentId(_arg_1:String):void
        {
            if (_SafeStr_1701 != _arg_1)
            {
                _SafeStr_1701 = _arg_1;
                setProperty("environment.id", _arg_1);
                updateEnvironmentVariables();
            };
            initEmbeddedConfigurations();
            setDefaults();
        }

        public function resetAll():void
        {
            _SafeStr_527 = false;
            _SafeStr_2171 = new Dictionary();
            _SafeStr_2172 = [];
            parseDevelopmentVariables();
            parseCommonVariables();
            parseLocalizationVariables();
            parseStageVariables();
            parseArguments();
            setDefaults();
            updateEnvironmentVariables();
            if (!propertyExists("environment.id"))
            {
                initEmbeddedConfigurations();
            };
            if (((!(_SafeStr_527)) && (_SafeStr_2169)))
            {
                _SafeStr_527 = true;
                unlock();
                events.dispatchEvent(new Event("complete"));
            }
            else
            {
                if (((!(_SafeStr_527)) && (_SafeStr_2170)))
                {
                    initConfigurationDownload();
                };
            };
        }

        override public function dispose():void
        {
            super.dispose();
        }

        public function isInitialized():Boolean
        {
            return (_SafeStr_527);
        }

        private function updateEnvironmentVariables():void
        {
            var _local_1:String;
            var _local_5:String;
            var _local_3:String;
            var _local_4:Vector.<String> = new <String>[];
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
            for each (var _local_2:String in _local_4)
            {
                _local_1 = getProperty(_local_2);
                _local_5 = ((_local_2 + ".") + _SafeStr_1701);
                if (propertyExists(_local_5))
                {
                    _local_3 = getProperty(_local_5);
                    setProperty(_local_2, _local_3);
                }
                else
                {
                    setProperty(_local_2, _local_1);
                };
            };
        }

        override public function propertyExists(_arg_1:String):Boolean
        {
            var _local_2:String = (_SafeStr_2171[_arg_1] as String);
            return (!(_local_2 == null));
        }

        override public function getProperty(_arg_1:String, _arg_2:Dictionary=null):String
        {
            var _local_3:String = (_SafeStr_2171[_arg_1] as String);
            _local_3 = interpolate(_local_3);
            if (_local_3 == null)
            {
                return ("");
            };
            if (_local_3.substr(0, 2) == "//")
            {
                _local_3 = (((_SafeStr_2173) ? "https:" : "http:") + _local_3);
            };
            _local_3 = updateUrlProtocol(_local_3);
            if (_arg_2 != null)
            {
                _local_3 = this.fillParams(_local_3, _arg_2);
            };
            return (_local_3);
        }

        override public function setProperty(_arg_1:String, _arg_2:String, _arg_3:Boolean=false, _arg_4:Boolean=false):void
        {
            if (_arg_4)
            {
                if (_SafeStr_2171[_arg_1] == null)
                {
                    Logger.log(((_arg_1 + "=") + _arg_2));
                };
            };
            if (((_SafeStr_2172.indexOf(_arg_1) < 0) || (_arg_3)))
            {
                _SafeStr_2171[_arg_1] = _arg_2;
            };
            if (_arg_3)
            {
                _SafeStr_2172.push(_arg_1);
            };
        }

        override public function getBoolean(_arg_1:String):Boolean
        {
            var _local_2:String = (_SafeStr_2171[_arg_1] as String);
            if (_local_2 == null)
            {
                return (false);
            };
            return ((_local_2 == "1") || (_local_2.toLowerCase() == "true"));
        }

        override public function getInteger(_arg_1:String, _arg_2:int):int
        {
            var _local_3:String = (_SafeStr_2171[_arg_1] as String);
            if (_local_3 == null)
            {
                return (_arg_2);
            };
            return int((_local_3));
        }

        override public function updateUrlProtocol(_arg_1:String):String
        {
            var _local_2:String = _arg_1;
            if (_SafeStr_2173)
            {
                _local_2 = _arg_1.replace("http://", "https://");
                _local_2 = _local_2.replace(":8080/", ":8443/");
            };
            return (_local_2);
        }

        override public function interpolate(_arg_1:String) : String
        {
            var _local_6:int = 0;
            var _local_5:Object = null;
            var _local_2:int = 0;
            var _local_3:String = null;

            if(_arg_1 == null)
            {
                return null;
            }

            var _local_4:String = _arg_1;
            var _local_7:RegExp = /\${([^}]*)}/g;
            _local_6 = 0;

            while(_local_6 < 3)
            {
                _local_2 = 0;
                _local_3 = "";

                while((_local_5 = _local_7.exec(_local_4)) != null)
                {
                    if(!propertyExists(_local_5[1]))
                    {
                        return null;
                    }
                    _local_3 += _local_4.substring(_local_2,_local_5.index);
                    _local_3 += getProperty(_local_5[1]);
                    _local_2 = _local_5.index + _local_5[0].length;
                }

                _local_3 += _local_4.substring(_local_2);

                if(_local_3 == _local_4)
                {
                    break;
                }
                _local_4 = _local_3;
                _local_6++;
            }

            return _local_3;
        }

        public function initConfigurationDownload():void
        {
            var _local_2:AssetLoaderStruct;
            var _local_1:URLRequest;
            var _local_4:String;
            _SafeStr_527 = false;
            var _local_3:String = ((_localization == null) ? getProperty("external.variables.txt") : ((("variables_" + _localization.getActiveEnvironmentId().toLowerCase()) + "_") + _localization.getExternalVariablesHash()));
            if (assets.hasAsset(_local_3))
            {
                assets.removeAsset(assets.getAssetByName(_local_3));
            };
            if (_localization == null)
            {
                _local_1 = new URLRequest(_local_3);
                _local_2 = assets.loadAssetFromFile(_local_3, _local_1, "text/plain");
                _local_2.addEventListener("AssetLoaderEventComplete", onInitConfiguration);
                _local_2.addEventListener("AssetLoaderEventError", onConfigurationError);
            }
            else
            {
                _local_4 = ((_localization.getExternalVariablesUrl() + "/") + _localization.getExternalVariablesHash());
                _local_2 = assets.loadAssetFromFile(_local_3, new URLRequest(_local_4), "text/plain", ("external_variables_" + _localization.getActiveEnvironmentId().toLowerCase()), _localization.getExternalVariablesHash());
                _local_2.addEventListener("AssetLoaderEventComplete", onInitConfiguration);
                _local_2.addEventListener("AssetLoaderEventError", onConfigurationError);
            };
        }

        private function parseConfiguration(_arg_1:String):void
        {
            var _local_8:Array;
            var _local_9:String;
            var _local_7:String;
            var _local_2:RegExp = /\n\r{1,}|\n{1,}|\r{1,}/gm;
            var _local_6:RegExp = /^\s+|\s+$/g;
            var _local_5:Array = _arg_1.split(_local_2);
            var _local_4:Boolean;
            for each (var _local_3:String in _local_5)
            {
                if (!((_local_3.substr(0, 1) == "#") || (_local_3 == "")))
                {
                    _local_8 = _local_3.split("=");
                    if ((((_local_8.length >= 2) && (_local_8[0].length > 0)) && (_local_8[1].length > 0)))
                    {
                        _local_9 = _local_8.shift();
                        _local_7 = _local_8.join("=");
                        _local_9 = _local_9.replace(_local_6, "");
                        _local_7 = _local_7.replace(_local_6, "");
                        if (((_local_9 == "configuration.readonly") && (_local_7 == "true")))
                        {
                            _local_4 = true;
                        };
                        this.setProperty(_local_9, _local_7, _local_4);
                    };
                };
            };
        }

        private function initEmbeddedConfigurations():void
        {
            var _local_2:int;
            var _local_3:String;
            var _local_4:String;
            var _local_1:String = CommunicationUtils.readSOLString("environment");
            Logger.log(("[HabboConfigurationManager] Default Environment: " + _local_1));
            for (var _local_5:String in _SafeStr_2171)
            {
                _local_2 = _local_5.lastIndexOf(("." + _local_1));
                if (((!(_local_2 == -1)) && (((_local_2 + 1) + _local_1.length) == _local_5.length)))
                {
                    _local_3 = _local_5.substring(0, _local_2);
                    _local_4 = getProperty(_local_5);
                    setProperty(_local_3, _local_4);
                };
            };
        }

        private function fillParams(_arg_1:String, _arg_2:Dictionary):String
        {
            var _local_5:int;
            var _local_3:int;
            var _local_4:int;
            var _local_7:String;
            var _local_6:String;
            _local_5 = 0;
            while (_local_5 < 10)
            {
                _local_3 = _arg_1.indexOf("%");
                if (_local_3 < 0) break;
                _local_4 = _arg_1.indexOf("%", (_local_3 + 1));
                if (_local_4 < 0) break;
                _local_7 = _arg_1.substring((_local_3 + 1), _local_4);
                _local_6 = _arg_2[_local_7];
                _arg_1 = _arg_1.replace((("%" + _local_7) + "%"), _local_6);
                _local_5++;
            };
            return (_arg_1);
        }

        private function onConfigurationError(_arg_1:Event=null):void
        {
            var _local_3:AssetLoaderEvent = (_arg_1 as AssetLoaderEvent);
            var _local_2:int;
            if (_local_3 != null)
            {
                _local_2 = _local_3.status;
            };
            Logger.log(_local_3.toString());
            HabboWebTools.logEventLog(("external_variables download error " + _local_2));
            Core.error((((("Could not load external variables. Failed to load URL " + getProperty("external.variables.txt")) + "HTTP status ") + _local_2) + ". Client startup failed!"), true, 20);
        }

        private function onInitConfiguration(_arg_1:Event=null):void
        {
            var _local_2:String;
            var _local_3:ByteArray;
            var _local_4:int;
            if (disposed)
            {
                return;
            };
            var _local_5:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_5 == null)
            {
                return;
            };
            if ((_local_5.assetLoader.content is ByteArray))
            {
                _local_3 = (_local_5.assetLoader.content as ByteArray);
                _local_3.position = 0;
                _local_2 = _local_3.readUTFBytes(_local_3.length);
            }
            else
            {
                _local_2 = (_local_5.assetLoader.content as String);
            };
            if (_local_2 != null)
            {
                parseConfiguration(_local_2);
            };
            var _local_6:IAsset = assets.getAssetByName(_local_5.assetName);
            if (_local_6)
            {
                assets.removeAsset(_local_6).dispose();
            };
            if (((_local_2 == null) || (_local_2.length == 0)))
            {
                _local_4 = ((_local_2 != null) ? _local_2.length : -1);
                Core.error((((("Could not load external variables, got empty data from URL " + getProperty("external.variables.txt")) + " data length = ") + _local_4) + ". Client startup failed!"), false, 20);
            };
            if (!_SafeStr_527)
            {
                configurationsLoaded();
            };
        }

        private function configurationsLoaded():void
        {
            events.dispatchEvent(new Event("HCE_CONFIGURATION_LOADED"));
            configurationsComplete();
        }

        private function configurationsComplete():void
        {
            if (disposed)
            {
                return;
            };
            if (_SafeStr_527)
            {
                return;
            };
            _SafeStr_527 = true;
            if (locked)
            {
                unlock();
            };
            events.dispatchEvent(new Event("complete"));
        }

        private function setDefaults():void
        {
            var _local_1:Array;
            ErrorReportStorage.addDebugData("Flashvars/host", ("Host: " + getProperty("connection.info.host")));
            ErrorReportStorage.addDebugData("Flashvars/port", ("Port: " + getProperty("connection.info.port")));
            setProperty("client.fatal.error.url", "${url.prefix}/flash_client_error");
            setProperty("game.center.error.url", "${url.prefix}/log/gameerror");
            var _local_2:String = getProperty("flashclient.crossdomain.policy.files");
            if (((_local_2) && (!(_local_2 == ""))))
            {
                _local_1 = _local_2.split(",");
                for each (var _local_3:String in _local_1)
                {
                    _local_3 = _local_3.replace(" ", "");
                    Security.loadPolicyFile(_local_3);
                };
            };
        }

        private function parseDevelopmentVariables():void
        {
        }

        private function parseCommonVariables():void
        {
            parseConfigurationAsset("common_configuration");
        }

        private function parseConfigurationAsset(_arg_1:String):void
        {
            var _local_2:TextAsset = (assets.getAssetByName(_arg_1) as TextAsset);
            if (_local_2 != null)
            {
                parseConfiguration(_local_2.content.toString());
            }
            else
            {
                Logger.log(("Could not parse configuration " + _arg_1));
            };
        }

        private function parseLocalizationVariables():void
        {
            parseConfigurationAsset("localization_configuration");
        }

        private function parseArguments():void
        {
            var _local_2:String;
            var _local_1:Dictionary = (context as ICore).arguments;
            for (var _local_3:String in _local_1)
            {
                _local_2 = _local_1[_local_3];
                _local_3 = _local_3.replace(/[_]/g, ".");
                setProperty(_local_3, _local_2);
                if (((_SafeStr_1701 == null) && (_local_3 == "environment.id")))
                {
                    _SafeStr_1701 = _local_2;
                };
            };
            (context as ICore).clearArguments();
        }

        private function parseStageVariables():void
        {
            var _local_3:String;
            if (context.displayObjectContainer == null)
            {
                Logger.log("[HabboConfigurationManager] Context has not stage ");
                return;
            };
            var _local_1:Stage = context.displayObjectContainer.stage;
            var _local_4:String = _local_1.loaderInfo.url;
            var _local_2:int = _local_4.lastIndexOf("/");
            _local_4 = _local_4.substring(0, (_local_2 + 1));
            setProperty("flash.client.url", _local_4);
            _SafeStr_2173 = (_local_4.substr(0, 8) == "https://");
            ErrorReportStorage.addDebugData("Parsing flashvars", "Parsing flasvars");
            for (var _local_5:String in _local_1.loaderInfo.parameters)
            {
                _local_3 = _local_1.loaderInfo.parameters[_local_5];
                _local_5 = _local_5.replace(/[_]/g, ".");
                setProperty(_local_5, _local_3, true);
            };
        }


    }
}