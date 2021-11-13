package com.sulake.core.window
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.window.utils.IEventQueue;
    import com.sulake.core.window.utils.IEventProcessor;
    import com.sulake.core.window.graphics.IWindowRenderer;
    import flash.display.Stage;
    import __AS3__.vec.Vector;
    import com.sulake.core.runtime.events.ILinkEventTracker;
    import com.sulake.core.window.utils.EventProcessorState;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import flash.display.DisplayObjectContainer;
    import com.sulake.core.window.services.IInternalWindowServices;
    import com.sulake.core.window.utils.IWindowParser;
    import com.sulake.core.assets.IResourceManager;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.components.SubstituteParentController;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.core.window.services.ServiceManager;
    import com.sulake.core.window.utils.WindowParser;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.DesktopController;
    import com.sulake.core.window.utils.MouseEventQueue;
    import com.sulake.core.window.utils.MouseEventProcessor;
    import com.sulake.core.window.utils.tablet.TabletEventQueue;
    import com.sulake.core.window.utils.tablet.TabletEventProcessor;
    import com.sulake.core.window.graphics.IGraphicContextHost;
    import flash.display.DisplayObject;
    import com.sulake.core.localization.ILocalizable;
    import flash.events.Event;

    public class WindowContext implements IWindowContext, IDisposable, IUpdateReceiver 
    {

        public static const INPUT_MODE_MOUSE:uint = 0;
        public static const INPUT_MODE_TOUCH:uint = 1;
        public static const ERROR_UNKNOWN:int = 0;
        public static const ERROR_INVALID_WINDOW:int = 1;
        public static const ERROR_WINDOW_NOT_FOUND:int = 2;
        public static const ERROR_WINDOW_ALREADY_EXISTS:int = 3;
        public static const ERROR_UNKNOWN_WINDOW_TYPE:int = 4;
        public static const ERROR_DURING_EVENT_HANDLING:int = 5;

        public static var inputEventQueue:IEventQueue;
        private static var inputEventProcessor:IEventProcessor;
        private static var _inputMode:uint = 0;
        private static var _SafeStr_1196:IWindowRenderer;
        private static var stage:Stage;

        public var inputEventTrackers:Vector.<IInputEventTracker>;
        private var _linkEventTrackers:Vector.<ILinkEventTracker>;
        private var _SafeStr_1217:EventProcessorState;
        protected var _localization:ICoreLocalizationManager;
        protected var _rootDisplayObject:DisplayObjectContainer;
        protected var _throwErrors:Boolean = true;
        protected var _lastError:Error;
        protected var _SafeStr_1218:int = -1;
        protected var _SafeStr_1219:IInternalWindowServices;
        protected var _SafeStr_1220:IWindowParser;
        protected var _SafeStr_1221:IWindowFactory;
        protected var _SafeStr_959:IWidgetFactory;
        protected var _SafeStr_1222:IResourceManager;
        protected var _SafeStr_1193:IDesktopWindow;
        protected var _SafeStr_1223:SubstituteParentController;
        private var _disposed:Boolean = false;
        private var _SafeStr_929:Boolean = false;
        private var _rendering:Boolean = false;
        private var _name:String;
        private var _configuration:ICoreConfiguration;

        public function WindowContext(_arg_1:String, _arg_2:IWindowRenderer, _arg_3:IWindowFactory, _arg_4:IWidgetFactory, _arg_5:IResourceManager, _arg_6:ICoreLocalizationManager, _arg_7:ICoreConfiguration, _arg_8:DisplayObjectContainer, _arg_9:Rectangle, _arg_10:Vector.<ILinkEventTracker>)
        {
            _name = _arg_1;
            _SafeStr_1196 = _arg_2;
            _localization = _arg_6;
            _configuration = _arg_7;
            _rootDisplayObject = _arg_8;
            _SafeStr_1219 = new ServiceManager(this, _arg_8);
            _SafeStr_1221 = _arg_3;
            _SafeStr_959 = _arg_4;
            _SafeStr_1222 = _arg_5;
            _SafeStr_1220 = new WindowParser(this);
            inputEventTrackers = new Vector.<IInputEventTracker>(0);
            _linkEventTrackers = _arg_10;
            if (!stage)
            {
                if ((_rootDisplayObject is Stage))
                {
                    stage = (_rootDisplayObject as Stage);
                }
                else
                {
                    if (_rootDisplayObject.stage)
                    {
                        stage = _rootDisplayObject.stage;
                    };
                };
            };
            Classes.init();
            if (_arg_9 == null)
            {
                _arg_9 = new Rectangle(0, 0, 800, 600);
            };
            _SafeStr_1193 = new DesktopController(("_CONTEXT_DESKTOP_" + _name), this, _arg_9);
            _SafeStr_1193.limits.maxWidth = _arg_9.width;
            _SafeStr_1193.limits.maxHeight = _arg_9.height;
            _rootDisplayObject.addChild(_SafeStr_1193.getDisplayObject());
            _rootDisplayObject.doubleClickEnabled = true;
            _rootDisplayObject.addEventListener("resize", stageResizedHandler);
            _SafeStr_1217 = new EventProcessorState(_SafeStr_1196, _SafeStr_1193, _SafeStr_1193, null, inputEventTrackers);
            inputMode = 0;
            _SafeStr_1223 = new SubstituteParentController(this);
        }

        public static function get inputMode():uint
        {
            return (_inputMode);
        }

        public static function set inputMode(_arg_1:uint):void
        {
            if (inputEventQueue)
            {
                if ((inputEventQueue is IDisposable))
                {
                    IDisposable(inputEventQueue).dispose();
                };
            };
            if (inputEventProcessor)
            {
                if ((inputEventProcessor is IDisposable))
                {
                    IDisposable(inputEventProcessor).dispose();
                };
            };
            switch (_arg_1)
            {
                case INPUT_MODE_MOUSE:
                    inputEventQueue = new MouseEventQueue(stage);
                    inputEventProcessor = new MouseEventProcessor();
                    try
                    {
                    }
                    catch(e:Error)
                    {
                    };
                    return;
                case 1:
                    inputEventQueue = new TabletEventQueue(stage);
                    inputEventProcessor = new TabletEventProcessor();
                    try
                    {
                    }
                    catch(e:Error)
                    {
                    };
                    return;
                default:
                    inputMode = INPUT_MODE_MOUSE;
                    throw (new Error(("Unknown input mode " + _arg_1)));
            };
        }


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                _disposed = true;
                _rootDisplayObject.removeEventListener("resize", stageResizedHandler);
                _rootDisplayObject.removeChild((IGraphicContextHost(_SafeStr_1193).getGraphicContext(true) as DisplayObject));
                _SafeStr_1193.destroy();
                _SafeStr_1193 = null;
                _SafeStr_1223.destroy();
                _SafeStr_1223 = null;
                if ((_SafeStr_1219 is IDisposable))
                {
                    IDisposable(_SafeStr_1219).dispose();
                };
                _SafeStr_1219 = null;
                _SafeStr_1220.dispose();
                _SafeStr_1220 = null;
                _SafeStr_1196 = null;
                _localization = null;
                _rootDisplayObject = null;
                _SafeStr_1221 = null;
                _SafeStr_959 = null;
                _SafeStr_1222 = null;
            };
        }

        public function getLastError():Error
        {
            return (_lastError);
        }

        public function getLastErrorCode():int
        {
            return (_SafeStr_1218);
        }

        public function handleError(_arg_1:int, _arg_2:Error):void
        {
            _lastError = _arg_2;
            _SafeStr_1218 = _arg_1;
            if (_throwErrors)
            {
                throw (_arg_2);
            };
        }

        public function flushError():void
        {
            _lastError = null;
            _SafeStr_1218 = -1;
        }

        public function getWindowServices():IInternalWindowServices
        {
            return (_SafeStr_1219);
        }

        public function getWindowParser():IWindowParser
        {
            return (_SafeStr_1220);
        }

        public function getWindowFactory():IWindowFactory
        {
            return (_SafeStr_1221);
        }

        public function getDesktopWindow():IDesktopWindow
        {
            return (_SafeStr_1193);
        }

        public function findWindowByName(_arg_1:String):IWindow
        {
            return (_SafeStr_1193.findChildByName(_arg_1));
        }

        public function findWindowByTag(_arg_1:String):IWindow
        {
            return (_SafeStr_1193.findChildByTag(_arg_1));
        }

        public function groupChildrenWithTag(_arg_1:String, _arg_2:Array, _arg_3:int=0):uint
        {
            return (_SafeStr_1193.groupChildrenWithTag(_arg_1, _arg_2, _arg_3));
        }

        public function registerLocalizationListener(_arg_1:String, _arg_2:IWindow):void
        {
            _localization.registerListener(_arg_1, (_arg_2 as ILocalizable));
        }

        public function removeLocalizationListener(_arg_1:String, _arg_2:IWindow):void
        {
            _localization.removeListener(_arg_1, (_arg_2 as ILocalizable));
        }

        public function create(_arg_1:String, _arg_2:String, _arg_3:uint, _arg_4:uint, _arg_5:uint, _arg_6:Rectangle, _arg_7:Function, _arg_8:IWindow, _arg_9:uint, _arg_10:Array=null, _arg_11:String="", _arg_12:Array=null):IWindow
        {
            var _local_14:IWindow;
            var _local_13:Class = Classes.getWindowClassByType(_arg_3);
            if (_local_13 == null)
            {
                handleError(4, new Error((('Failed to solve implementation for window "' + _arg_1) + '"!')));
                return (null);
            };
            if (_arg_8 == null)
            {
                if ((_arg_5 & 0x10))
                {
                    _arg_8 = _SafeStr_1223;
                };
            };
            _local_14 = new _local_13(_arg_1, _arg_3, _arg_4, _arg_5, this, _arg_6, ((_arg_8 != null) ? _arg_8 : _SafeStr_1193), _arg_7, _arg_10, _arg_12, _arg_9);
            _local_14.dynamicStyle = _arg_11;
            if (((_arg_2) && (_arg_2.length)))
            {
                _local_14.caption = _arg_2;
            };
            return (_local_14);
        }

        public function destroy(_arg_1:IWindow):Boolean
        {
            if (_arg_1 == _SafeStr_1193)
            {
                _SafeStr_1193 = null;
            };
            if (_arg_1.state != 0x40000000)
            {
                _arg_1.destroy();
            };
            return (true);
        }

        public function invalidate(_arg_1:IWindow, _arg_2:Rectangle, _arg_3:uint):void
        {
            if (!disposed)
            {
                _SafeStr_1196.addToRenderQueue(_arg_1, _arg_2, _arg_3);
            };
        }

        public function update(_arg_1:uint):void
        {
            var _local_2:Error;
            _SafeStr_929 = true;
            if (_lastError)
            {
                _local_2 = _lastError;
                _lastError = null;
                throw (_local_2);
            };
            inputEventProcessor.process(_SafeStr_1217, inputEventQueue);
            _SafeStr_929 = false;
        }

        public function render(_arg_1:uint):void
        {
            _rendering = true;
            _SafeStr_1196.render();
            _rendering = false;
        }

        private function stageResizedHandler(_arg_1:Event):void
        {
            var _local_2:int;
            var _local_3:int;
            if (((!(_SafeStr_1193 == null)) && (!(_SafeStr_1193.disposed))))
            {
                if ((_rootDisplayObject is Stage))
                {
                    _local_2 = Stage(_rootDisplayObject).stageWidth;
                    _local_3 = Stage(_rootDisplayObject).stageHeight;
                }
                else
                {
                    _local_2 = _rootDisplayObject.width;
                    _local_3 = _rootDisplayObject.height;
                };
                if (((_local_2 >= 10) && (_local_3 >= 10)))
                {
                    _SafeStr_1193.limits.maxWidth = _local_2;
                    _SafeStr_1193.limits.maxHeight = _local_3;
                    _SafeStr_1193.width = _local_2;
                    _SafeStr_1193.height = _local_3;
                };
            };
        }

        public function addMouseEventTracker(_arg_1:IInputEventTracker):void
        {
            if (inputEventTrackers.indexOf(_arg_1) < 0)
            {
                inputEventTrackers.push(_arg_1);
            };
        }

        public function removeMouseEventTracker(_arg_1:IInputEventTracker):void
        {
            var _local_2:int = inputEventTrackers.indexOf(_arg_1);
            if (_local_2 > -1)
            {
                inputEventTrackers.splice(_local_2, 1);
            };
        }

        public function getResourceManager():IResourceManager
        {
            return (_SafeStr_1222);
        }

        public function getWidgetFactory():IWidgetFactory
        {
            return (_SafeStr_959);
        }

        public function get linkEventTrackers():Vector.<ILinkEventTracker>
        {
            return (_linkEventTrackers);
        }


    }
}

