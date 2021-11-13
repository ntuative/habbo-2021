package com.sulake.habbo.window
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.window.ICoreWindowManager;
    import com.sulake.core.window.IWindowFactory;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.window.IInputEventTracker;
    import com.sulake.core.window.IWidgetFactory;
    import flash.events.Event;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.IWindowContext;
    import com.sulake.core.window.graphics.IWindowRenderer;
    import com.sulake.core.window.graphics.SkinContainer;
    import com.sulake.core.window.tools.ProfilerOutput;
    import com.sulake.core.utils.profiler.ProfilerAgentTask;
    import com.sulake.habbo.window.theme.ThemeManager;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.window.utils.floorplaneditor.BCFloorPlanEditor;
    import com.sulake.habbo.window.utils.habbopedia.HabboPagesViewer;
    import com.sulake.habbo.window.handlers.HabbletLinkHandler;
    import com.sulake.habbo.window.utils.ElementPointerHandler;
    import com.sulake.core.utils.FontEnum;
    import com.sulake.core.window.components.HTMLTextController;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDRoomEngine;
    import __AS3__.vec.Vector;
    import flash.utils.getTimer;
    import com.sulake.core.assets.IAsset;
    import com.sulake.habbo.window.utils.SkinParserUtil;
    import com.sulake.core.window.graphics.WindowRenderer;
    import flash.geom.Rectangle;
    import com.sulake.core.window.WindowContext;
    import com.sulake.core.runtime.IIDProfiler;
    import flash.external.ExternalInterface;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.runtime.IProfiler;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.utils.DefaultAttStruct;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.habbo.window.utils.AlertDialog;
    import com.sulake.core.window.utils.INotify;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.window.utils.AlertDialogWithLink;
    import com.sulake.habbo.window.utils.IAlertDialogWithLink;
    import com.sulake.habbo.window.utils.ConfirmDialog;
    import com.sulake.habbo.window.utils._SafeStr_126;
    import com.sulake.core.window.utils.MouseCursorControl;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.core.window.events.WindowEvent;
    import flash.system.Capabilities;
    import com.sulake.core.window.theme.IThemeManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.widgets.WidgetClasses;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.core.window.IWidget;
    import com.sulake.core.assets.IResourceManager;
    import com.sulake.habbo.window.utils.ModalDialog;
    import com.sulake.habbo.window.utils.IModalDialog;
    import com.sulake.habbo.window.utils.SimpleAlertDialog;
    import flash.text.StyleSheet;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.tools.*;

    public class HabboWindowManagerComponent extends Component implements IHabboWindowManager, ICoreWindowManager, IWindowFactory, IUpdateReceiver, IInputEventTracker, IWidgetFactory 
    {

        private static const TRACKING_EVENT_INPUT:Event = new Event("HABBO_WINDOW_TRACKING_EVENT_INPUT");
        private static const TRACKING_EVENT_RENDER:Event = new Event("HABBO_WINDOW_TRACKING_EVENT_RENDER");
        private static const TRACKING_EVENT_SLEEP:Event = new Event("HABBO_WINDOW_TRACKING_EVENT_SLEEP");
        private static const NUMBER_OF_CONTEXT_LAYERS:uint = 4;
        private static const DEFAULT_CONTEXT_LAYER_INDEX:uint = 1;

        private var _localization:IHabboLocalizationManager;
        private var _windowContextArray:Array;
        private var _SafeStr_442:IWindowContext;
        private var _windowRenderer:IWindowRenderer;
        private var _SafeStr_437:SkinContainer;
        private var _SafeStr_443:Boolean = false;
        private var _SafeStr_439:ProfilerOutput;
        private var _profilerAgentTaskUpdate:ProfilerAgentTask;
        private var _profilerAgentTaskRedraw:ProfilerAgentTask;
        private var _SafeStr_444:ThemeManager;
        private var _resourceManager:ResourceManager;
        private var _hintManager:HintManager;
        private var _avatarRenderer:IAvatarRenderManager;
        private var _communication:IHabboCommunicationManager;
        private var _sessionDataManager:ISessionDataManager;
        private var _SafeStr_573:Boolean = false;
        private var _roomEngine:IRoomEngine;
        private var _SafeStr_4447:uint;
        private var _bcfloorPlanEditor:BCFloorPlanEditor;
        private var _SafeStr_441:HabboPagesViewer;
        private var _SafeStr_438:HabbletLinkHandler;
        private var _SafeStr_440:ElementPointerHandler;

        public function HabboWindowManagerComponent(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            FontEnum.refresh();
            HTMLTextController.defaultLinkTarget = "habboMain";
        }

        public function get roomEngine():IRoomEngine
        {
            return (_roomEngine);
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDSessionDataManager(), function (_arg_1:ISessionDataManager):void
            {
                _sessionDataManager = _arg_1;
            }, false), new ComponentDependency(new IIDHabboLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                _localization = _arg_1;
            }), new ComponentDependency(new IIDHabboConfigurationManager(), function (_arg_1:ICoreConfiguration):void
            {
            }, false, [{
                "type":"complete",
                "callback":onConfigurationComplete
            }]), new ComponentDependency(new IIDAvatarRenderManager(), function (_arg_1:IAvatarRenderManager):void
            {
                _avatarRenderer = _arg_1;
            }, false), new ComponentDependency(new IIDHabboCommunicationManager(), setCommunicationManager, false), new ComponentDependency(new IIDRoomEngine(), function (_arg_1:IRoomEngine):void
            {
                _roomEngine = _arg_1;
            }, false)]));
        }

        private function setCommunicationManager(_arg_1:IHabboCommunicationManager):void
        {
            _communication = _arg_1;
        }

        private function onConfigurationComplete(_arg_1:Event):void
        {
            if (_communication != null)
            {
                _bcfloorPlanEditor = new BCFloorPlanEditor(this);
                _SafeStr_440 = new ElementPointerHandler(this);
            };
        }

        override protected function initComponent():void
        {
            var _local_3:uint;
            var _local_1:int = getTimer();
            var _local_2:IAsset = assets.getAssetByName("habbo_element_description_xml");
            _SafeStr_437 = new SkinContainer();
            SkinParserUtil.parse((_local_2.content as XML), assets, _SafeStr_437);
            _SafeStr_444 = new ThemeManager(_SafeStr_437);
            _resourceManager = new ResourceManager(this);
            _hintManager = new HintManager(this);
            _windowRenderer = new WindowRenderer(_SafeStr_437);
            _windowContextArray = new Array(4);
            var _local_4:Rectangle = new Rectangle(0, 0, context.displayObjectContainer.stage.stageWidth, context.displayObjectContainer.stage.stageHeight);
            _local_3 = 0;
            while (_local_3 < 4)
            {
                _windowContextArray[_local_3] = new WindowContext(("layer_" + _local_3), _windowRenderer, this, this, _resourceManager, _localization, this, context.displayObjectContainer, _local_4, context.linkEventTrackers);
                _local_3++;
            };
            assets.removeAsset(_local_2);
            _local_2.dispose();
            _SafeStr_442 = _windowContextArray[1];
            addMouseEventTracker(this);
            registerUpdateReceiver(this, 0);
            queueInterface(new IIDProfiler(), receiveProfilerInterface);
            _local_1 = (getTimer() - _local_1);
            Logger.log((("initializing window framework took " + _local_1) + "ms"));
            _SafeStr_573 = true;
            _SafeStr_441 = new HabboPagesViewer(this);
            _SafeStr_438 = new HabbletLinkHandler(this);
            context.addLinkEventTracker(_SafeStr_438);
            if (ExternalInterface.available)
            {
                ExternalInterface.addCallback("openlink", context.createLinkEvent);
            };
        }

        public function toggleFullScreen():void
        {
            if (context.displayObjectContainer.stage.displayState == "fullScreenInteractive")
            {
                context.displayObjectContainer.stage.displayState = "normal";
            }
            else
            {
                context.displayObjectContainer.stage.displayState = "fullScreenInteractive";
            };
        }

        private function onCrashTest(_arg_1:WindowMouseEvent):void
        {
            var _local_2:* = null;
            Logger.log("CRASH!");
            _local_2.background = true;
        }

        private function receiveProfilerInterface(_arg_1:IID, _arg_2:IUnknown):void
        {
            var _local_3:IProfiler = (_arg_2 as IProfiler);
            if (_local_3 != null)
            {
                if (!_SafeStr_439)
                {
                    _SafeStr_439 = new ProfilerOutput(context, this, _windowRenderer);
                };
                _SafeStr_439.profiler = _local_3;
                _profilerAgentTaskUpdate = new ProfilerAgentTask("Update", "Event processing");
                _local_3.getProfilerAgentForReceiver(this).addSubTask(_profilerAgentTaskUpdate);
                _profilerAgentTaskRedraw = new ProfilerAgentTask("Redraw", "Window rasterizer");
                _local_3.getProfilerAgentForReceiver(this).addSubTask(_profilerAgentTaskRedraw);
                _SafeStr_443 = true;
            };
        }

        private function receiveLoggerInterface(_arg_1:IID, _arg_2:IUnknown):void
        {
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                if (_SafeStr_438 != null)
                {
                    context.removeLinkEventTracker(_SafeStr_438);
                    _SafeStr_438.dispose();
                    _SafeStr_438 = null;
                };
                if (_SafeStr_440 != null)
                {
                    _SafeStr_440.dispose();
                    _SafeStr_440 = null;
                };
                removeUpdateReceiver(this);
                if (_bcfloorPlanEditor != null)
                {
                    _bcfloorPlanEditor.dispose();
                    _bcfloorPlanEditor = null;
                };
                if (_SafeStr_441)
                {
                    _SafeStr_441.dispose();
                    _SafeStr_441 = null;
                };
                if (_windowContextArray)
                {
                    while (_windowContextArray.length > 0)
                    {
                        IDisposable(_windowContextArray.pop()).dispose();
                    };
                };
                _windowContextArray = null;
                if (_windowRenderer)
                {
                    _windowRenderer.dispose();
                    _windowRenderer = null;
                };
                if (_SafeStr_437)
                {
                    _SafeStr_437.dispose();
                    _SafeStr_437 = null;
                };
                if (_resourceManager != null)
                {
                    _resourceManager.dispose();
                    _resourceManager = null;
                };
                if (_hintManager != null)
                {
                    _hintManager.dispose();
                    _hintManager = null;
                };
                super.dispose();
            };
        }

        public function create(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:Rectangle, _arg_6:Function=null, _arg_7:String="", _arg_8:uint=0, _arg_9:Array=null, _arg_10:IWindow=null, _arg_11:Array=null, _arg_12:String=""):IWindow
        {
            return (_SafeStr_442.create(_arg_1, _arg_7, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_10, _arg_8, _arg_11, _arg_12, _arg_9));
        }

        public function destroy(_arg_1:IWindow):void
        {
            _arg_1.destroy();
        }

        public function buildFromXML(_arg_1:XML, _arg_2:uint=1, _arg_3:Map=null):IWindow
        {
            var _local_4:IWindow = getWindowContext(_arg_2).getWindowParser().parseAndConstruct(_arg_1, null, _arg_3);
            if ((_local_4 is IFrameWindow))
            {
                IFrameWindow(_local_4).helpButtonAction = openHelpPage;
            };
            return (_local_4);
        }

        public function windowToXMLString(_arg_1:IWindow):String
        {
            return (_SafeStr_442.getWindowParser().windowToXMLString(_arg_1));
        }

        public function getLayoutByTypeAndStyle(_arg_1:uint, _arg_2:uint):XML
        {
            return (_SafeStr_437.getWindowLayoutByTypeAndStyle(_arg_1, _arg_2));
        }

        public function getDefaultsByTypeAndStyle(_arg_1:uint, _arg_2:uint):DefaultAttStruct
        {
            return (_SafeStr_437.getDefaultAttributesByTypeAndStyle(_arg_1, _arg_2));
        }

        public function createWindow(_arg_1:String, _arg_2:String="", _arg_3:uint=0, _arg_4:uint=0, _arg_5:uint=0, _arg_6:Rectangle=null, _arg_7:Function=null, _arg_8:uint=0, _arg_9:uint=1, _arg_10:String=""):IWindow
        {
            return (_windowContextArray[_arg_9].create(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, null, _arg_8, null, null, null));
        }

        public function removeWindow(_arg_1:String, _arg_2:uint=1):void
        {
            var _local_3:IDesktopWindow;
            _local_3 = _windowContextArray[_arg_2].getDesktopWindow();
            var _local_4:IWindow = _local_3.getChildByName(_arg_1);
            if (_local_4 != null)
            {
                _local_4.destroy();
            };
        }

        public function getWindowByName(_arg_1:String, _arg_2:uint=1):IWindow
        {
            return (_windowContextArray[_arg_2].getDesktopWindow().getChildByName(_arg_1));
        }

        public function getActiveWindow(_arg_1:uint=1):IWindow
        {
            return (_windowContextArray[_arg_1].getDesktopWindow().getChildAt((_SafeStr_442.getDesktopWindow().numChildren - 1)));
        }

        public function getWindowContext(_arg_1:uint):IWindowContext
        {
            return (_windowContextArray[_arg_1]);
        }

        public function getDesktop(_arg_1:uint):IDesktopWindow
        {
            var _local_2:IWindowContext = _windowContextArray[_arg_1];
            return ((_local_2) ? _local_2.getDesktopWindow() : null);
        }

        public function notify(_arg_1:String, _arg_2:String, _arg_3:Function, _arg_4:uint=0):INotify
        {
            var _local_6:IAsset = assets.getAssetByName("habbo_window_alert_xml");
            if (!_local_6)
            {
                throw (new Error("Failed to initialize alert dialog; missing asset!"));
            };
            var _local_5:XML = (_local_6.content as XML);
            return (new AlertDialog(this, _local_5, _arg_1, _arg_2, _arg_4, _arg_3, false));
        }

        public function alert(_arg_1:String, _arg_2:String, _arg_3:uint, _arg_4:Function):IAlertDialog
        {
            var _local_6:IAsset = assets.getAssetByName("habbo_window_alert_xml");
            if (!_local_6)
            {
                throw (new Error("Failed to initialize alert dialog; missing asset!"));
            };
            var _local_5:XML = (_local_6.content as XML);
            return (new AlertDialog(this, _local_5, _arg_1, _arg_2, _arg_3, _arg_4, false));
        }

        public function alertWithModal(_arg_1:String, _arg_2:String, _arg_3:uint, _arg_4:Function):IAlertDialog
        {
            var _local_6:IAsset = assets.getAssetByName("habbo_window_alert_xml");
            if (!_local_6)
            {
                throw (new Error("Failed to initialize alert dialog; missing asset!"));
            };
            var _local_5:XML = (_local_6.content as XML);
            return (new AlertDialog(this, _local_5, _arg_1, _arg_2, _arg_3, _arg_4, true));
        }

        public function alertWithLink(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:uint, _arg_6:Function):IAlertDialogWithLink
        {
            var _local_8:IAsset = assets.getAssetByName("habbo_window_alert_link_xml");
            if (!_local_8)
            {
                throw (new Error("Failed to initialize alert dialog; missing asset!"));
            };
            var _local_7:XML = (_local_8.content as XML);
            return (new AlertDialogWithLink(this, _local_7, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6));
        }

        public function confirm(_arg_1:String, _arg_2:String, _arg_3:uint, _arg_4:Function):_SafeStr_126
        {
            var _local_6:IAsset = assets.getAssetByName("habbo_window_confirm_xml");
            if (!_local_6)
            {
                throw (new Error("Failed to initialize aleret dialog; missing asset!"));
            };
            var _local_5:XML = (_local_6.content as XML);
            return (new ConfirmDialog(this, _local_5, _arg_1, _arg_2, _arg_3, _arg_4, false));
        }

        public function confirmWithModal(_arg_1:String, _arg_2:String, _arg_3:uint, _arg_4:Function):_SafeStr_126
        {
            var _local_6:IAsset = assets.getAssetByName("habbo_window_confirm_xml");
            if (!_local_6)
            {
                throw (new Error("Failed to initialize aleret dialog; missing asset!"));
            };
            var _local_5:XML = (_local_6.content as XML);
            return (new ConfirmDialog(this, _local_5, _arg_1, _arg_2, _arg_3, _arg_4, true));
        }

        public function registerLocalizationParameter(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String="%"):void
        {
            _localization.registerParameter(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        public function update(_arg_1:uint):void
        {
            var _local_2:int;
            if (_SafeStr_443)
            {
                _profilerAgentTaskUpdate.start();
            };
            if (WindowContext.inputEventQueue.length > 0)
            {
                events.dispatchEvent(TRACKING_EVENT_INPUT);
                _local_2 = (4 - 1);
                while (_local_2 >= 0)
                {
                    _windowContextArray[_local_2].update(_arg_1);
                    _local_2--;
                };
            };
            if (_SafeStr_443)
            {
                _profilerAgentTaskUpdate.stop();
            };
            if (_SafeStr_443)
            {
                _profilerAgentTaskRedraw.start();
            };
            events.dispatchEvent(TRACKING_EVENT_RENDER);
            _local_2 = 0;
            while (_local_2 < 4)
            {
                _windowContextArray[_local_2].render(_arg_1);
                _local_2++;
            };
            if (_SafeStr_443)
            {
                _profilerAgentTaskRedraw.stop();
            };
            if (WindowContext.inputEventQueue.length > 0)
            {
                WindowContext.inputEventQueue.flush();
            };
            MouseCursorControl.change();
            events.dispatchEvent(TRACKING_EVENT_SLEEP);
        }

        override public function purge():void
        {
            super.purge();
            if (_windowRenderer)
            {
                _windowRenderer.purge();
            };
        }

        public function addMouseEventTracker(_arg_1:IInputEventTracker):void
        {
            for each (var _local_2:IWindowContext in _windowContextArray)
            {
                _local_2.addMouseEventTracker(_arg_1);
            };
        }

        public function removeMouseEventTracker(_arg_1:IInputEventTracker):void
        {
            for each (var _local_2:IWindowContext in _windowContextArray)
            {
                _local_2.removeMouseEventTracker(_arg_1);
            };
        }

        public function eventReceived(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_2 != null)
            {
                if (_arg_1.type == "WME_CLICK")
                {
                    ErrorReportStorage.setParameter("click_time", new Date().getTime().toString());
                    ErrorReportStorage.setParameter("click_target", ((_arg_2.name + ": ") + _arg_2.toString()));
                }
                else
                {
                    if (_arg_1.type == "WME_UP")
                    {
                        ErrorReportStorage.setParameter("mouse_up_time", new Date().getTime().toString());
                        ErrorReportStorage.setParameter("mouse_up_target", ((_arg_2.name + ": ") + _arg_2.toString()));
                    };
                };
            };
        }

        private function performTestCases():void
        {
            Logger.log(((((("type: " + Capabilities.playerType) + " debugger: ") + Capabilities.isDebugger) + " version: ") + Capabilities.version));
        }

        public function findWindowByName(_arg_1:String):IWindow
        {
            var _local_2:IWindow;
            for each (var _local_3:IWindowContext in _windowContextArray)
            {
                _local_2 = _local_3.findWindowByName(_arg_1);
                if (_local_2)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function findWindowByTag(_arg_1:String):IWindow
        {
            var _local_2:IWindow;
            for each (var _local_3:IWindowContext in _windowContextArray)
            {
                _local_2 = _local_3.findWindowByTag(_arg_1);
                if (_local_2)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function groupWindowsWithTag(_arg_1:String, _arg_2:Array, _arg_3:int=0):uint
        {
            var _local_4:uint;
            for each (var _local_5:IWindowContext in _windowContextArray)
            {
                _local_4 = (_local_4 + _local_5.groupChildrenWithTag(_arg_1, _arg_2, _arg_3));
            };
            return (_local_4);
        }

        public function getThemeManager():IThemeManager
        {
            return (_SafeStr_444);
        }

        public function createUnseenItemCounter():IWindowContainer
        {
            var _local_1:IAsset = (assets.getAssetByName("unseen_item_counter_xml") as IAsset);
            var _local_2:XML = (_local_1.content as XML);
            return (buildFromXML(_local_2) as IWindowContainer);
        }

        public function createWidget(_arg_1:String, _arg_2:IWidgetWindow):IWidget
        {
            var _local_3:Class = WidgetClasses._SafeStr_445[_arg_1];
            if (_local_3 != null)
            {
                return (new _local_3(_arg_2, this));
            };
            throw (new Error((("Unknown widget type " + _arg_1) + "! You might need to update Glaze to be able to work on this layout.")));
        }

        public function get avatarRenderer():IAvatarRenderManager
        {
            return (_avatarRenderer);
        }

        public function get resourceManager():IResourceManager
        {
            return (_resourceManager);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (_localization);
        }

        public function buildModalDialogFromXML(_arg_1:XML):IModalDialog
        {
            return (new ModalDialog(this, _arg_1));
        }

        public function get communication():IHabboCommunicationManager
        {
            return (_communication);
        }

        public function get sessionDataManager():ISessionDataManager
        {
            return (_sessionDataManager);
        }

        public function simpleAlert(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String=null, _arg_5:String=null, _arg_6:Map=null, _arg_7:String=null, _arg_8:Function=null, _arg_9:Function=null):void
        {
            new SimpleAlertDialog(this, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9); //not popped
        }

        public function registerHintWindow(_arg_1:String, _arg_2:IWindow, _arg_3:int=1):void
        {
            _hintManager.registerWindow(_arg_1, _arg_2, _arg_3);
        }

        public function unregisterHintWindow(_arg_1:String):void
        {
            _hintManager.unregisterWindow(_arg_1);
        }

        public function showHint(_arg_1:String, _arg_2:Rectangle=null):void
        {
            _hintManager.showHint(_arg_1, _arg_2);
        }

        public function hideHint():void
        {
            _hintManager.hideHint();
        }

        public function hideMatchingHint(_arg_1:String):void
        {
            _hintManager.hideMatchingHint(_arg_1);
        }

        public function displayFloorPlanEditor():void
        {
            if (_bcfloorPlanEditor == null)
            {
                _bcfloorPlanEditor = new BCFloorPlanEditor(this);
            };
            if (_bcfloorPlanEditor != null)
            {
                _bcfloorPlanEditor.visible = true;
            };
        }

        public function openHelpPage(_arg_1:String):void
        {
            if (_SafeStr_441 != null)
            {
                _SafeStr_441.openPage(_arg_1);
            };
        }

        public function get habboPagesStyleSheet():StyleSheet
        {
            return (HabboPagesViewer.styleSheet);
        }


    }
}

