package
{
    import flash.display.Sprite;
    import com.sulake.core.runtime.ICore;
    import flash.utils.Dictionary;
    import flash.utils.getQualifiedClassName;
    import com.sulake.core.Core;
    import com.sulake.core.utils.ErrorReportStorage;
    import flash.events.Event;
//    import flash.desktop.NativeApplication;
    import flash.system.Capabilities;
    import com.sulake.core.runtime.ICoreErrorReporter;
    import com.sulake.core.runtime.CoreComponentContext;
    import com.sulake.air.FileProxy;
    import com.sulake.habbo.utils.PlatformData;
    import com.sulake.air.NativeApplicationProxy;
    import flash.events.ProgressEvent;
    import flash.external.ExternalInterface;
    import flash.system.System;
    import com.sulake.core.runtime.IID;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.core.runtime.Component;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDRoomEngine;
    import flash.utils.setInterval;
    import com.sulake.habbo.utils.HabboWebTools;

        public class HabboAirMain extends Sprite
    {

        public static const CORE_RATIO:Number = 0.6;
        private static const INIT_STEPS:int = 3;

        private var _core:ICore;
        private var _loadingScreen:IHabboLoadingScreen;
        private var _SafeStr_415:int = 3;
        private var _SafeStr_414:int = 0;
        private var _completedInitSteps:int = 0;
        private var _SafeStr_412:Boolean = false;
        private var _SafeStr_413:Boolean = false;
        private var _SafeStr_245:Dictionary;
        private var _prepareCoreOnNextFrame:Boolean;

        public function HabboAirMain(_arg_1:IHabboLoadingScreen, _arg_2:Dictionary)
        {
            _loadingScreen = _arg_1;
            _SafeStr_245 = _arg_2;
            addEventListener("addedToStage", onAddedToStage);
            addEventListener("exitFrame", onExitFrame);
            Logger.log(((getQualifiedClassName(Core) + " version: ") + Core.version));
        }

        private function dispose():void
        {
            removeEventListener("progress", onProgressEvent);
            removeEventListener("complete", onCompleteEvent);
            removeEventListener("addedToStage", onAddedToStage);
            removeEventListener("exitFrame", onExitFrame);
            if (_loadingScreen)
            {
                _loadingScreen.dispose();
                _loadingScreen = null;
            };
            if (_core != null)
            {
                _core.events.removeEventListener("COMPONENT_EVENT_RUNNING", onCoreRunning);
            };
            if (parent)
            {
                parent.removeChild(this);
            };
        }

        public function unloading():void
        {
            try
            {
                if (((_core) && (!(_core.disposed))))
                {
                    ErrorReportStorage.addDebugData("Unload", "Client unloading started");
                    _core.events.dispatchEvent(new Event("unload"));
                };
            }
            catch(error:Error)
            {
            };
        }

        protected function onAddedToStage(_arg_1:Event=null):void
        {
//            var _local_3:XML = NativeApplication.nativeApplication.applicationDescriptor;
//            var _local_5:Namespace = _local_3.namespace();
//            var _local_2:String = _local_3._local_5::copyright;
//            var _local_4:String = _local_3._local_5::versionLabel;
//            var _local_6:String = _local_3._local_5::versionNumber;
//            _SafeStr_13.log(("AIR Runtime version: " + NativeApplication.nativeApplication.runtimeVersion));
//            _SafeStr_13.log(("Application ID: " + NativeApplication.nativeApplication.applicationID));
//            _SafeStr_13.log(("Copyright: " + _local_2));
//            _SafeStr_13.log(("Version: " + _local_4));
//            _SafeStr_13.log(("VersionNumber: " + _local_6));
            try
            {
                init();
            }
            catch(error:Error)
            {
                HabboAir.trackLoginStep("client.init.core.fail");
                HabboAir.reportCrash(("Failed to prepare the core: " + error.message), 10, true, error);
                Core.dispose();
            };
        }

        private function init():void
        {
            var _local_2:String = Capabilities.version.toLowerCase();
            if (((_local_2.indexOf("win") > -1) || (_local_2.indexOf("mac") > -1)))
            {
            };
            _prepareCoreOnNextFrame = true;
        }

        protected function onExitFrame(_arg_1:Event=null):void
        {
            if (_prepareCoreOnNextFrame)
            {
                _prepareCoreOnNextFrame = false;
                prepareCore();
                return;
            };
            if (((_SafeStr_412) && (_SafeStr_413)))
            {
                dispose();
            };
        }

        private function prepareCore():void
        {
            var _local_1:ICoreErrorReporter;
            var _local_2:XML;
            try
            {
                _local_1 = ((Capabilities.playerType != "StandAlone") ? new HabboCoreErrorReporter() : null);
                _core = Core.instantiate(stage, 1, _local_1, _SafeStr_245);
                _core.events.addEventListener("COMPONENT_EVENT_ERROR", onCoreError);
                _core.events.addEventListener("COMPONENT_EVENT_REBOOT", onCoreReboot);
                _core.prepareComponent(HabboTrackingLib);
                addEventListener("progress", onProgressEvent);
                addEventListener("complete", onCompleteEvent);
                _local_2 = <config>
					<asset-libraries>
						<library url="hh_human_body.swf"/>
						<library url="hh_human_item.swf"/>
					</asset-libraries>
					<service-libraries/>
					<component-libraries/>
				</config>
                ;
                _local_2 = new XML();
                _core.readConfigDocument(_local_2, this);
                (_core as CoreComponentContext).fileProxy = new FileProxy();
                if (PlatformData.nativeApplicationProxy)
                {
                    PlatformData.nativeApplicationProxy.dispose();
                };
                PlatformData.nativeApplicationProxy = new NativeApplicationProxy();
                _SafeStr_415 = ((_core.getNumberOfFilesPending() + _core.getNumberOfFilesLoaded()) + 3);
                _core.prepareComponent(CoreCommunicationFrameworkLib);
                _core.prepareComponent(HabboRoomObjectLogicLib);
                _core.prepareComponent(HabboRoomObjectVisualizationLib);
                _core.prepareComponent(RoomManagerLib);
                _core.prepareComponent(RoomSpriteRendererLib);
                _core.prepareComponent(HabboRoomSessionManagerLib);
                _core.prepareComponent(HabboAvatarRenderLib);
                _core.prepareComponent(HabboSessionDataManagerLib);
                _core.prepareComponent(HabboConfigurationCom);
                _core.prepareComponent(HabboLocalizationCom);
                _core.prepareComponent(HabboWindowManagerCom);
                _core.prepareComponent(HabboCommunicationCom);
                _core.prepareComponent(HabboCommunicationDemoCom);
                _core.prepareComponent(HabboNavigatorCom);
                _core.prepareComponent(HabboFriendListCom);
                _core.prepareComponent(HabboMessengerCom);
                _core.prepareComponent(HabboInventoryCom);
                _core.prepareComponent(HabboToolbarCom);
                _core.prepareComponent(HabboCatalogCom);
                _core.prepareComponent(HabboRoomEngineCom);
                _core.prepareComponent(HabboRoomUICom);
                _core.prepareComponent(HabboAvatarEditorCom);
                _core.prepareComponent(HabboNotificationsCom);
                _core.prepareComponent(HabboHelpCom);
                _core.prepareComponent(HabboAdManagerCom);
                _core.prepareComponent(HabboModerationCom);
                _core.prepareComponent(HabboUserDefinedRoomEventsCom);
                _core.prepareComponent(HabboSoundManagerFlash10Com);
                _core.prepareComponent(HabboQuestEngineCom);
                _core.prepareComponent(HabboFriendBarCom);
                _core.prepareComponent(HabboGroupsCom);
                _core.prepareComponent(HabboGamesCom);
                _core.prepareComponent(HabboFreeFlowChatCom);
                _core.prepareComponent(HabboNewNavigatorCom);
                addInitializationProgressListeners();
            }
            catch(error:Error)
            {
                Core.dispose();
            };
        }

        private function updateProgressBar():void
        {
            var _local_1:Number;
            if (_loadingScreen != null)
            {
                _local_1 = (0.6 + (((_completedInitSteps + _SafeStr_414) / _SafeStr_415) * (1 - 0.6)));
                _loadingScreen.updateLoadingBar(_local_1);
            };
        }

        private function onProgressEvent(_arg_1:ProgressEvent):void
        {
            _SafeStr_414 = _core.getNumberOfFilesLoaded();
            updateProgressBar();
        }

        private function onCompleteEvent(_arg_1:Event):void
        {
            removeEventListener("progress", onProgressEvent);
            removeEventListener("complete", onCompleteEvent);
            initializeCore();
        }

        private function initializeCore():void
        {
            HabboAir.trackLoginStep("client.init.core.init");
            try
            {
                _core.initialize();
                if (ExternalInterface.available)
                {
                    ExternalInterface.addCallback("unloading", unloading);
                };
            }
            catch(error:Error)
            {
                HabboAir.trackLoginStep("client.init.core.fail");
                Core.crash(("Failed to initialize the core: " + error.message), 10, error);
            };
        }

        public function onCoreError(_arg_1:Event):void
        {
            Logger.log(("onCoreError " + _arg_1.type));
        }

        private function onCoreReboot(_arg_1:Event):void
        {
            Logger.log(("Reboot application! " + System.privateMemory), System.totalMemory, System.totalMemoryNumber);
            _core.events.removeEventListener("COMPONENT_EVENT_ERROR", onCoreError);
            _core.events.removeEventListener("COMPONENT_EVENT_REBOOT", onCoreReboot);
            Core.dispose();
            _core = null;
            Logger.log(("Application ready for restart! " + System.privateMemory), System.totalMemory, System.totalMemoryNumber);
//            NativeApplication.nativeApplication.exit(1);
        }

        private function simpleQueueInterface(_arg_1:IID, _arg_2:Function):void
        {
            var _local_3:Object = _core.queueInterface(_arg_1, _arg_2);
            if (_local_3 != null)
            {
                (_arg_2(_arg_1, _local_3));
            };
        }

        private function addInitializationProgressListeners():void
        {
            simpleQueueInterface(new IIDHabboLocalizationManager(), function (_arg_1:IID, _arg_2:Component):void
            {
                _arg_2.events.addEventListener("complete", onLocalizationComplete);
            });
            simpleQueueInterface(new IIDHabboConfigurationManager(), onConfigurationComplete);
            simpleQueueInterface(new IIDRoomEngine(), function (_arg_1:IID, _arg_2:Component):void
            {
                _arg_2.events.addEventListener("REE_ENGINE_INITIALIZED", onRoomEngineReady);
            });
            _core.events.addEventListener("COMPONENT_EVENT_RUNNING", onCoreRunning);
        }

        private function onLocalizationComplete(_arg_1:Event):void
        {
            HabboAir.trackLoginStep("client.init.localization.loaded");
            _completedInitSteps++;
            updateProgressBar();
        }

        private function onConfigurationComplete(_arg_1:IID, _arg_2:Component):void
        {
            HabboAir.trackLoginStep("client.init.config.loaded");
            _completedInitSteps++;
            updateProgressBar();
        }

        private function onRoomEngineReady(_arg_1:Event):void
        {
            _SafeStr_412 = true;
            HabboAir.trackLoginStep("client.init.room.ready");
            if (_core.getInteger("spaweb", 0) == 1)
            {
                startSendingHeartBeat();
            };
        }

        private function startSendingHeartBeat():void
        {
            sendHeartBeat();
            setInterval(sendHeartBeat, 10000); //not popped
        }

        private function sendHeartBeat():void
        {
            HabboWebTools.sendHeartBeat();
        }

        private function onCoreRunning(_arg_1:Event):void
        {
            _SafeStr_413 = true;
            HabboAir.trackLoginStep("client.init.core.running");
            _completedInitSteps++;
            updateProgressBar();
        }


    }
}import com.sulake.core.runtime.ICoreErrorReporter;
import com.sulake.core.runtime.ICoreErrorLogger;

class HabboCoreErrorReporter implements ICoreErrorReporter
{

    private var _logger:ICoreErrorLogger;


    public function logError(_arg_1:String, _arg_2:Boolean, _arg_3:int=-1, _arg_4:Error=null):void
    {
        HabboAir.reportCrash(_arg_1, _arg_3, _arg_2, _arg_4, _logger);
    }

    public function set errorLogger(_arg_1:ICoreErrorLogger):void
    {
        _logger = _arg_1;
    }


}


// _SafeStr_13 = "_-OS" (String#30212, DoABC#4)
// _SafeStr_245 = "_-l1n" (String#31330, DoABC#4)
// _SafeStr_412 = "_-kD" (String#31285, DoABC#4)
// _SafeStr_413 = "_-K1A" (String#29960, DoABC#4)
// _SafeStr_414 = "_-FL" (String#29750, DoABC#4)
// _SafeStr_415 = "_-313" (String#29118, DoABC#4)
