package com.sulake.core.window.tools
{
    import flash.geom.Point;
    import com.sulake.core.runtime.IProfiler;
    import com.sulake.core.runtime.ICore;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.ICoreWindowManager;
    import com.sulake.core.window.graphics.IWindowRenderer;
    import com.sulake.core.utils.Map;
    import com.sulake.core.runtime.IContext;
    import flash.utils.ByteArray;
    import com.sulake.core.window.components.ILabelWindow;
    import com.sulake.core.runtime.IIDProfiler;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import flash.events.Event;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.utils.profiler.ProfilerAgentTask;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;

    public class ProfilerOutput implements IDevTool
    {

        private static const ZERO_POINT:Point = new Point();

        private static var profiler_dialog_xml:Class = HabboProfilerOutput_profiler_dialog_xml;
        private static var profiler_task_xml:Class = HabboProfilerOutput_profiler_task_xml;

        private var _disposed:Boolean = false;
        private var _profiler:IProfiler;
        private var _core:ICore;
        private var _window:IFrameWindow;
        private var _windowItemArray:Array;
        private var _windowManager:ICoreWindowManager;
        private var _windowRenderer:IWindowRenderer;
        private var _memoryTracking:Boolean = false;
        private var _windowToTaskMap:Map;

        public function ProfilerOutput(_arg_1:IContext, _arg_2:ICoreWindowManager, _arg_3:IWindowRenderer)
        {
            _core = (_arg_1 as ICore);
            _windowItemArray = [];
            _profiler = profiler;
            _windowManager = _arg_2;
            _windowRenderer = _arg_3;
            _windowToTaskMap = new Map();
        }

        private static function padAlign(_arg_1:String, _arg_2:int, _arg_3:String=" ", _arg_4:Boolean=false):String
        {
            var _local_6:int;
            var _local_5:int = (_arg_2 - _arg_1.length);
            if (_local_5 <= 0)
            {
                return (_arg_1.substring(0, _arg_2));
            };
            var _local_7:String = "";
            _local_6 = 0;
            while (_local_6 < _local_5)
            {
                _local_7 = (_local_7 + _arg_3);
                _local_6++;
            };
            return ((_arg_4) ? (_local_7 + _arg_1) : (_arg_1 + _local_7));
        }


        public function get caption():String
        {
            return ("Component Profiler");
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get visible():Boolean
        {
            return ((_window) && (_window.visible));
        }

        public function set visible(_arg_1:Boolean):void
        {
            var value:Boolean = _arg_1;
            if (((!(_window)) && (value)))
            {
                var bytes:ByteArray = (new profiler_dialog_xml() as ByteArray);
                var xml:XML = new XML(bytes.readUTFBytes(bytes.length));
                _window = (_windowManager.buildFromXML(xml, 2) as IFrameWindow);
                _window.procedure = profilerWindowEventProc;
                _window.findChildByName("header").caption = (((((((padAlign("task", 28) + "|") + padAlign("#rounds", 8)) + "|") + padAlign("latest ms", 8)) + "|") + padAlign("total ms", 8)) + "|");
                _window.findChildByName("footer").caption = "<- Click to enable bitmap memory tracking";
                ILabelWindow(_window.findChildByName("footer")).textColor = 4284900966;
            };
            if (_window)
            {
                if (value)
                {
                    _window.activate();
                    _core.setProfilerMode(true);
                    _core.queueInterface(new IIDProfiler(), function (_arg_1:IID, _arg_2:IUnknown):void
                    {
                        profiler = (_arg_2 as IProfiler);
                    });
                }
                else
                {
                    _core.setProfilerMode(false);
                    _window.dispose();
                    _window = null;
                };
            };
        }

        public function set profiler(_arg_1:IProfiler):void
        {
            if (_profiler)
            {
                _profiler.removeStopEventListener(refresh);
                _profiler = null;
            };
            if (((!(_profiler)) && (_arg_1)))
            {
                _profiler = _arg_1;
                _profiler.addStopEventListener(refresh);
            };
        }

        public function get profiler():IProfiler
        {
            return (_profiler);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_window)
                {
                    _window.dispose();
                    _window = null;
                };
                _profiler.removeStopEventListener(refresh);
                _profiler = null;
                _windowManager = null;
                _windowRenderer = null;
                _windowToTaskMap.dispose();
                _windowToTaskMap = null;
                _disposed = true;
            };
        }

        private function profilerWindowEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                if (_arg_2.tags.indexOf("close") > -1)
                {
                    visible = false;
                }
                else
                {
                    if (_arg_2.name == "button_gc")
                    {
                        _profiler.gc();
                    };
                };
            };
            if (_arg_2.name == "footer_enable_toggle")
            {
                if (_arg_1.type == "WE_SELECTED")
                {
                    _memoryTracking = true;
                    ILabelWindow(_window.findChildByName("footer")).textColor = 0xFF000000;
                }
                else
                {
                    if (_arg_1.type == "WE_UNSELECTED")
                    {
                        _memoryTracking = false;
                        ILabelWindow(_window.findChildByName("footer")).textColor = 4284900966;
                    };
                };
            };
        }

        public function refresh(_arg_1:Event):void
        {
            if (!_window)
            {
                return;
            };
            _windowToTaskMap.reset();
            var _local_4:Array = _profiler.getProfilerAgentsInArray();
            var _local_3:IItemListWindow = (_window.findChildByName("list") as IItemListWindow);
            var _local_2:uint;
            while (_local_4.length > 0)
            {
                _local_2 = recursiveRedraw(_local_4.pop(), _local_3, _local_2, 0);
            };
            if (_memoryTracking)
            {
                _window.findChildByName("footer").caption = (((((((((((("Assets - Libraries: " + _profiler.numAssetLibraryInstances) + " ") + "Bitmaps: ") + _profiler.numBitmapAssetInstances) + " / ") + _profiler.numAllocatedBitmapDataBytes) + " bytes \n") + "Tracked bitmap data: ") + _profiler.numTrackedBitmapDataInstances) + " / ") + _profiler.numTrackedBitmapDataBytes) + " bytes");
            };
        }

        private function recursiveRedraw(_arg_1:ProfilerAgentTask, _arg_2:IItemListWindow, _arg_3:uint, _arg_4:uint):uint
        {
            var _local_5:IWindowContainer;
            var _local_6:IBitmapWrapperWindow;
            var _local_8:uint;
            if (_arg_3 >= _arg_2.numListItems)
            {
                _local_5 = createListItem(_arg_2);
            }
            else
            {
                _local_5 = (_arg_2.getListItemAt(_arg_3) as IWindowContainer);
            };
            var _local_7:String = _arg_1.name;
            if (_arg_4 > 0)
            {
                _local_7 = padAlign(_local_7, (_arg_4 + _local_7.length), "-", true);
            };
            var _local_9:IWindow = (_local_5.findChildByName("text") as IWindow);
            _local_9.caption = (((((((padAlign(_local_7, 28, " ", false) + "|") + padAlign(String(_arg_1.rounds), 8, " ", true)) + "|") + padAlign(String(_arg_1.latest), 8, " ", true)) + "|") + padAlign(String(_arg_1.total), 8, " ", true)) + "|\r");
            _local_5.findChildByName("caption").caption = _arg_1.caption;
            _local_5.findChildByName("check").setStateFlag(8, (!(_arg_1.paused)));
            _windowToTaskMap.add(_local_5, _arg_1);
            if (!_arg_1.paused)
            {
                _local_6 = (_local_5.findChildByName("canvas") as IBitmapWrapperWindow);
                refreshBitmapImage(_local_6, _arg_1);
            };
            _arg_3++;
            _local_8 = 0;
            while (_local_8 < _arg_1.numSubTasks)
            {
                _arg_3 = recursiveRedraw(_arg_1.getSubTaskAt(_local_8), _arg_2, _arg_3, (_arg_4 + 1));
                _local_8++;
            };
            return (_arg_3);
        }

        private function refreshBitmapImage(_arg_1:IBitmapWrapperWindow, _arg_2:ProfilerAgentTask):void
        {
            var _local_4:BitmapData = _arg_1.bitmap;
            if (_local_4 == null)
            {
                _local_4 = new BitmapData(_arg_1.width, _arg_1.height, false, 0xFFFFFFFF);
                _arg_1.bitmap = _local_4;
            };
            var _local_3:Rectangle = _local_4.rect;
            var _local_6:int = _arg_2.latest;
            var _local_5:int = ((_local_6 > _local_4.height) ? _local_4.height : _local_6);
            _local_3.x = (_local_3.x + 1);
            _local_3.width = (_local_3.width - 1);
            _local_4.copyPixels(_local_4, _local_3, ZERO_POINT);
            _local_3.x = (_local_3.x + (_local_3.width - 2));
            _local_3.y = (_local_3.y + (_local_3.height - _local_5));
            _local_3.width = 1;
            _local_3.height = _local_5;
            _local_4.fillRect(_local_3, ((_local_6 > _local_4.height) ? 0xFFFF0000 : 0xFF0000FF));
            _arg_1.invalidate();
        }

        private function createListItem(_arg_1:IItemListWindow):IWindowContainer
        {
            var _local_3:ByteArray;
            _local_3 = (new profiler_task_xml() as ByteArray);
            var _local_4:XML = new XML(_local_3.readUTFBytes(_local_3.length));
            var _local_2:IWindowContainer = (_windowManager.buildFromXML(_local_4, 2) as IWindowContainer);
            _arg_1.addListItem(_local_2);
            var _local_5:IWindow = _local_2.findChildByName("check");
            _local_5.addEventListener("WME_CLICK", onCheckMouseClick);
            return (_local_2);
        }

        private function onCheckMouseClick(_arg_1:WindowEvent):void
        {
            var _local_3:IWindow = _arg_1.window;
            var _local_2:ProfilerAgentTask = _windowToTaskMap.getValue(_local_3.parent);
            if (_local_2)
            {
                _local_2.paused = (!(_local_3.getStateFlag(8)));
            };
        }


    }
}
