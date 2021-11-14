package
{
    import flash.display.MovieClip;
    import login.LoginFlow;
    import flash.utils.Dictionary;
    import flash.utils.getTimer;
//    import flash.desktop.NativeApplication;
    import flash.external.ExternalInterface;
    import com.sulake.core.runtime.ICoreErrorLogger;
    import flash.net.URLRequest;
    import flash.net.URLVariables;
    import flash.system.Capabilities;
    import flash.system.System;
    import com.sulake.core.utils.ErrorReportStorage;
    import flash.net.sendToURL;
//    import flash.events.BrowserInvokeEvent;
//    import flash.events.InvokeEvent;
    import com.sulake.habbo.utils.CommunicationUtils;
    import flash.events.Event;
    import flash.events.UncaughtErrorEvent;
    import com.sulake.air._SafeStr_12;
    import com.sulake.core.utils.MouseWheelEnabler;
    import flash.events.HTTPStatusEvent;
    import flash.utils.setTimeout;
    import flash.events.IOErrorEvent;
    import flash.display.DisplayObject;
    import flash.utils.getDefinitionByName;

        public class HabboAir extends MovieClip
    {

        public static const CORE_RATIO:Number = 0.6;
        private static const _SafeStr_236:int = 7000000;
        public static const ERROR_VARIABLE_IS_FATAL:String = "is_fatal";
        public static const ERROR_VARIABLE_CLIENT_CRASH_TIME:String = "crash_time";
        public static const ERROR_VARIABLE_CONTEXT:String = "error_ctx";
        public static const ERROR_VARIABLE_FLASH_VERSION:String = "flash_version";
        public static const ERROR_VARIABLE_AVERAGE_UPDATE_INTERVAL:String = "avg_update";
        public static const ERROR_VARIABLE_DEBUG:String = "debug";
        public static const ERROR_VARIABLE_DESCRIPTION:String = "error_desc";
        public static const ERROR_VARIABLE_CATEGORY:String = "error_cat";
        public static const ERROR_VARIABLE_DATA:String = "error_data";
        private static const RECEPTION_LOG_STEP_FUNCTION:String = "NewUserReception.logStep";
        private static const STEP_NUX_ENTERED:String = "NUX_ENTERED";
        private static const STEP_RECEPTION_EXITED:String = "RECEPTION_EXITED";
        private static const STEP_NUX_EXITED:String = "NUX_EXITED";
        private static const STEP_CLIENT_LOADED:String = "CLIENT_LOADED";
        public static const ERROR_CATEGORY_FINALIZE_PRELOADING:int = 9;
        public static const ERROR_CATEGORY_DOWNLOAD_FONT:int = 11;
        public static const ERROR_UNCAUGHT_ERROR:int = 40;
        private static const ARGUMENT_ENVIRONMENT:String = "server";
        private static const ARGUMENT_SSO_TOKEN:String = "ticket";

        protected static var PROCESSLOG_ENABLED:Boolean = false;
        private static var _SafeStr_237:String = "https://www.habbo.com/api/log/crash";
        private static var _SafeStr_238:Boolean = false;

        private var _SafeStr_239:Boolean;
        private var _SafeStr_240:uint;
        private var _cachedBytesLoaded:uint;
        private var _httpStatus:int;
        private var _disposed:Boolean = false;
        private var _SafeStr_241:Boolean;
        private var _loadingScreen:IHabboLoadingScreen;
        private var _startTime:int;
        private var _loginFlow:LoginFlow = null;
        private var _SafeStr_242:Boolean;
        private var _SafeStr_243:Boolean;
        private var _SafeStr_244:Boolean = true;
        private var _SafeStr_246:Boolean = false;
        private var _SafeStr_245:Dictionary;

        public function HabboAir()
        {
            super();
            var _local_1:_SafeStr_2 = new _SafeStr_2();
            if (!_local_1._SafeStr_247(this))
            {
                return;
            };
            _startTime = getTimer();
            stop();
            _SafeStr_245 = new Dictionary();
            if (stage)
            {
                onAddedToStage();
            }
            else
            {
                this.addEventListener("addedToStage", onAddedToStage);
            };

            parseArguments([]);
//            NativeApplication.nativeApplication.addEventListener("invoke", onInvoke);
//            NativeApplication.nativeApplication.addEventListener("browserInvoke", onBrowserInvoke);
        }

        public static function trackLoginStep(_arg_1:String, _arg_2:String=null):void
        {
            Logger.log(("* HabboMain Login Step: " + _arg_1));
            if (PROCESSLOG_ENABLED)
            {
                try
                {
                    if (ExternalInterface.available)
                    {
                        if (_arg_2 != null)
                        {
                            ExternalInterface.call("FlashExternalInterface.logLoginStep", _arg_1, _arg_2);
                        }
                        else
                        {
                            ExternalInterface.call("FlashExternalInterface.logLoginStep", _arg_1);
                        };
                    }
                    else
                    {
                        Logger.log("ExternalInterface is not available, tracking is disabled");
                    };
                }
                catch(e:Error)
                {
                };
            };
        }

        public static function reportCrash(_arg_1:String, _arg_2:int, _arg_3:Boolean, _arg_4:Error=null, _arg_5:ICoreErrorLogger=null):void
        {
            var _local_6:String = ((_arg_4 == null) ? "" : _arg_4.getStackTrace());
            reportCrashStack(_arg_1, _arg_2, _arg_3, _local_6, _arg_5);
        }

        public static function reportCrashStack(_arg_1:String, _arg_2:int, _arg_3:Boolean, _arg_4:String, _arg_5:ICoreErrorLogger=null):void
        {
            var _local_10:int;
            var _local_6:URLRequest = new URLRequest(HabboAir._SafeStr_237);
            var _local_7:URLVariables = new URLVariables();
            _local_7["crash_time"] = new Date().getTime().toString();
            _local_7["is_fatal"] = _arg_3.toString();
            _local_7["error_ctx"] = "";
            _local_7["flash_version"] = Capabilities.version;
            _local_7["avg_update"] = 0;
            _local_7["error_desc"] = _arg_1;
            _local_7["error_cat"] = String(_arg_2);
            if (_arg_4 != "")
            {
                _local_7["error_data"] = _arg_4;
            };
            _local_7["debug"] = (("Memory usage: " + Math.round((System.totalMemory / 0x100000))) + " MB");
            var _local_8:Array = ErrorReportStorage.getParameterNames();
            var _local_9:int = _local_8.length;
            _local_10 = 0;
            while (_local_10 < _local_9)
            {
                _local_7[_local_8[_local_10]] = ErrorReportStorage.getParameter(_local_8[_local_10]);
                _local_10++;
            };
            _local_7["debug"] = ErrorReportStorage.getDebugData();
            if (_arg_3)
            {
                if (!_SafeStr_238)
                {
                    _SafeStr_238 = true;
                };
            };
            _local_6.data = _local_7;
            _local_6.method = "POST";
            try
            {
                (sendToURL(_local_6));
            }
            catch(e:Error)
            {
                Logger.log(("Error while sending error report: " + e.message));
            };
        }


//        private function onBrowserInvoke(_arg_1:BrowserInvokeEvent):void
        private function onBrowserInvoke(_arg_1:*):void
        {
            Logger.log(("Received Browser Invoke: " + _arg_1.arguments));
//            NativeApplication.nativeApplication.removeEventListener("browserInvoke", onBrowserInvoke);
//            parseArguments(_arg_1.arguments);
        }

//        private function onInvoke(_arg_1:InvokeEvent):void
        private function onInvoke(_arg_1:*):void
        {
//            NativeApplication.nativeApplication.removeEventListener("invoke", onInvoke);
//            parseArguments(_arg_1.arguments);
        }

        private function parseArguments(_arg_1:Array):void
        {
            _SafeStr_245 = new Dictionary();

            _SafeStr_245["environment.id"] = "en";
            _SafeStr_245["sso.token"] = stage.loaderInfo.parameters["sso.ticket"];

            _SafeStr_243 = true;
            tryInit();
        }

        private function onAddedToStage(_arg_1:Event=null):void
        {
            removeEventListener("addedToStage", onAddedToStage);
            _SafeStr_242 = true;
            tryInit();
        }

        private function tryInit():void
        {
            if (((!(_SafeStr_243)) || (!(_SafeStr_242))))
            {
                return;
            };
            var clientFatalErrorUrl:String = _SafeStr_245["client.fatal.error.url"];
            if (clientFatalErrorUrl != null)
            {
                _SafeStr_237 = clientFatalErrorUrl;
            }
            else
            {
                var urlPrefix:String = _SafeStr_245["url.prefix"];
                if (urlPrefix != null)
                {
                    _SafeStr_237 = (urlPrefix + "/flash_client_error");
                };
            };
            PROCESSLOG_ENABLED = (_SafeStr_245["processlog.enabled"] == "1");
            trackLoginStep("client.init.start");
            stage.scaleMode = "noScale";
            stage.quality = "low";
            stage.align = "TL";
            root.loaderInfo.addEventListener("progress", onPreLoadingProgress);
            root.loaderInfo.addEventListener("httpStatus", onPreLoadingStatus);
            root.loaderInfo.addEventListener("complete", onPreLoadingCompleted);
            root.loaderInfo.addEventListener("ioError", onPreLoadingFailed);
            root.loaderInfo.uncaughtErrorEvents.addEventListener("uncaughtError", function (_arg_1:UncaughtErrorEvent):void
            {
                reportCrash((((((("Uncaught client error, eventType: " + _arg_1.type) + " errorID: ") + _arg_1.errorID) + " runtime: ") + ((getTimer() - _startTime) / 1000)) + "s"), 40, true, _arg_1.error);
            });
            if (_SafeStr_12.isSupported())
            {
                CommunicationUtils.encryptedLocalStorage = new _SafeStr_12();
            };
            createNewUserLobbyOrLoadingScreen();
            checkPreLoadingStatus();
            MouseWheelEnabler.init(stage);
        }

        private function onLoginFLowFinished(_arg_1:Event):void
        {
            _SafeStr_245["sso.token"] = _loginFlow.ssoToken;
            _SafeStr_245["environment.id"] = CommunicationUtils.readSOLString("environment");
            _loginFlow.removeEventListener("LOGIN_FLOW_FINISHED_EVENT", onLoginFLowFinished);
            _loginFlow.dispose();
            _loginFlow = null;
            _loadingScreen = null;
            createLoadingScreen();
            checkPreLoadingStatus();
        }

        private function onPreLoadingStatus(_arg_1:HTTPStatusEvent):void
        {
            _httpStatus = _arg_1.status;
        }

        private function onPreLoadingProgress(_arg_1:Event):void
        {
            checkPreLoadingStatus();
            updateLoadingBarProgress();
            _SafeStr_239 = true;
        }

        private function onPreLoadingCompleted(_arg_1:Event):void
        {
            try
            {
                _SafeStr_241 = true;
                checkPreLoadingStatus();
            }
            catch(error:Error)
            {
                trackLoginStep("client.init.swf.error");
                reportCrash((((("Failed to finalize main swf preloading: " + error.message) + " runtime: ") + ((getTimer() - _startTime) / 1000)) + "s"), 9, true, error);
            };
        }

        private function onPreLoadingFailed(_arg_1:IOErrorEvent):void
        {
            var event:IOErrorEvent = _arg_1;
            setTimeout(function ():void
            {
                trackLoginStep("client.init.swf.error");
                reportCrash((((((((((((("IO error in main swf preloading: " + event.text) + " / URL: ") + root.loaderInfo.loaderURL) + " / HTTP status: ") + _httpStatus) + " / Loaded: ") + root.loaderInfo.bytesLoaded) + " of ") + root.loaderInfo.bytesTotal) + " bytes. Runtime: ") + ((getTimer() - _startTime) / 1000)) + "s"), 9, true, null);
            }, 5000); //not popped
        }

        private function checkPreLoadingStatus():void
        {
            if (_loginFlow != null)
            {
                return;
            };
            if (((_SafeStr_241) && (progress >= 1)))
            {
                finalizePreloading();
                return;
            };
        }

        private function calculateProgress():void
        {
            _cachedBytesLoaded = root.loaderInfo.bytesLoaded;
            if (root.loaderInfo.bytesTotal == 0)
            {
                if (!_SafeStr_246)
                {
                    _SafeStr_240 = 7000000;
                    _SafeStr_246 = true;
                    trackLoginStep("client.gzip.environment");
                };
            };
            if (root.loaderInfo.bytesTotal != 0)
            {
                _SafeStr_240 = root.loaderInfo.bytesTotal;
            };
            if (((_SafeStr_240 < _cachedBytesLoaded) || (_SafeStr_241)))
            {
                _SafeStr_240 = _cachedBytesLoaded;
            };
            _SafeStr_239 = false;
            if (((!(_SafeStr_241)) && (_cachedBytesLoaded == _SafeStr_240)))
            {
                _SafeStr_239 = true;
                _cachedBytesLoaded = (_cachedBytesLoaded * 0.99);
            };
        }

        private function clone(_arg_1:Dictionary):Dictionary
        {
            var _local_2:Dictionary = new Dictionary();
            for (var _local_3:Object in _arg_1)
            {
                if ((_arg_1[_local_3] is Dictionary))
                {
                    _local_2[_local_3] = clone(_arg_1[_local_3]);
                }
                else
                {
                    _local_2[_local_3] = _arg_1[_local_3];
                };
            };
            return (_local_2);
        }

        private function createNewUserLobbyOrLoadingScreen():void
        {
            if (((!(ssoTokenAvailable)) && (_SafeStr_244)))
            {
                _loginFlow = new LoginFlow(clone(_SafeStr_245));
                _loginFlow.addEventListener("LOGIN_FLOW_FINISHED_EVENT", onLoginFLowFinished);
                stage.addChild(_loginFlow);
                _loginFlow.init();
                updateLoadingBarProgress();
                return;
            };
            createLoadingScreen();
        }

        public function createLoadingScreen():void
        {
            _loadingScreen = new HabboLoadingScreen(stage.stageWidth, stage.stageHeight, clone(_SafeStr_245));
            updateLoadingBarProgress();
            stage.addChild(DisplayObject(_loadingScreen));
        }

        private function updateLoadingBarProgress():void
        {
            var _local_2:Number;
            var _local_1:Number;
            if (_loadingScreen != null)
            {
                _local_1 = progress;
                if (_local_1 == 0)
                {
                    _local_2 = ((bytesLoaded / 7000000) * 0.6);
                }
                else
                {
                    _local_2 = (_local_1 * 0.6);
                };
                _loadingScreen.updateLoadingBar(_local_2);
            };
        }

        private function finalizePreloading():void
        {
            var _local_1:Class;
            var _local_2:DisplayObject;
            trackLoginStep("client.init.swf.loaded");
            root.loaderInfo.removeEventListener("progress", onPreLoadingProgress);
            root.loaderInfo.removeEventListener("httpStatus", onPreLoadingStatus);
            root.loaderInfo.removeEventListener("complete", onPreLoadingCompleted);
            root.loaderInfo.removeEventListener("ioError", onPreLoadingFailed);
            nextFrame();
            _local_1 = Class(getDefinitionByName("HabboAirMain"));
            if (_local_1)
            {
                _local_2 = (new _local_1(_loadingScreen, _SafeStr_245) as HabboAirMain);
                if (_local_2)
                {
                    _local_2.addEventListener("removed", onMainRemoved, false, 0, true);
                    addChild(_local_2);
                };
            };
        }

        private function onMainRemoved(_arg_1:Event):void
        {
            dispose();
        }

        private function dispose():void
        {
            removeEventListener("addedToStage", onAddedToStage);
            if (!_disposed)
            {
                _disposed = true;
                if (_loadingScreen != null)
                {
                    _loadingScreen = null;
                };
                if (parent)
                {
                    parent.removeChild(this);
                };
            };
        }

        public function get progress():Number
        {
            return ((this.bytesTotal != 0) ? (bytesLoaded / bytesTotal) : ((_SafeStr_241) ? 1 : 0));
        }

        public function get bytesLoaded():uint
        {
            if (_SafeStr_239)
            {
                calculateProgress();
            };
            return (_cachedBytesLoaded);
        }

        public function get bytesTotal():uint
        {
            if (_SafeStr_239)
            {
                calculateProgress();
            };
            return (_SafeStr_240);
        }

        private function get ssoTokenAvailable():Boolean
        {
            var _local_1:String = _SafeStr_245["sso.token"];
            return ((!(_local_1 == null)) && (_local_1.length > 0));
        }


    }
}