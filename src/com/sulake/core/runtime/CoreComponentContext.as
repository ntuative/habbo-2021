package com.sulake.core.runtime
{
    import com.sulake.core.utils.IFileProxy;
    import com.sulake.core.utils.LibraryLoaderQueue;
    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;
    import com.sulake.core.assets.AssetLibraryCollection;
    import flash.utils.getTimer;
    import com.sulake.core.utils.profiler.ProfilerViewer;
    import flash.display.DisplayObjectContainer;
    import flash.utils.ByteArray;
    import com.sulake.core.Core;
    import flash.events.Event;
    import com.sulake.core.utils.PurgeTrigger;
    import com.sulake.core.utils.LibraryLoader;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;
    import flash.net.URLRequest;
    import com.sulake.core.utils.LibraryLoaderEvent;
    import com.sulake.core.runtime.events.LibraryProgressEvent;
    import flash.utils.getQualifiedClassName;

        public final class CoreComponentContext extends ComponentContext implements ICore
    {

        private static const NUM_UPDATE_RECEIVER_LEVELS:uint = 3;
        private static const CONFIG_XML_NODE_ASSET_LIBRARIES:String = "asset-libraries";
        private static const CONFIG_XML_NODE_ASSET_LIBRARY:String = "library";
        private static const CONFIG_XML_NODE_SERVICE_LIBRARIES:String = "service-libraries";
        private static const CONFIG_XML_NODE_SERVICE_LIBRARY:String = "library";
        private static const CONFIG_XML_NODE_COMPONENT_LIBRARIES:String = "component-libraries";
        private static const CONFIG_XML_NODE_COMPONENT_LIBRARY:String = "library";

        private static var _fileProxy:IFileProxy;

        private var _SafeStr_849:LibraryLoaderQueue;
        private var _loadingEventDelegate:IEventDispatcher;
        private var _numberOfFilesInConfig:uint;
        private var _SafeStr_850:Function;
        private var _SafeStr_848:Profiler;
        private var _SafeStr_851:ICoreErrorReporter;
        private var _SafeStr_846:Array;
        private var _SafeStr_847:Array;
        private var _lastUpdateTimeMs:uint;
        private var _SafeStr_852:uint = 0;
        private var _hibernationLevel:int = -1;
        private var _hibernationUpdateFrequency:uint;
        private var _arguments:Dictionary;
        private var _rebootOnNextFrame:Boolean;

        public function CoreComponentContext(_arg_1:DisplayObjectContainer, _arg_2:ICoreErrorReporter, _arg_3:uint, _arg_4:Dictionary)
        {
            var _local_5:uint;
            super(this, 2, new AssetLibraryCollection("_core_assets"));
            if (_arg_4 == null)
            {
                _arg_4 = new Dictionary();
            };
            _arguments = _arg_4;
            _SafeStr_852 = _arg_3;
            _SafeStr_845 = ((_arg_3 & 0x0F) == 15);
            _SafeStr_846 = [];
            _SafeStr_847 = [];
            _SafeStr_842 = _arg_1;
            _SafeStr_851 = _arg_2;
            _local_5 = 0;
            while (_local_5 < 3)
            {
                _SafeStr_846.push([]);
                _SafeStr_847.push(0);
                _local_5++;
            };
            _lastUpdateTimeMs = getTimer();
            attachComponent(this, [new IIDCore()]);
            _SafeStr_842.addEventListener("enterFrame", onEnterFrame);
            switch ((_arg_3 & 0x0F))
            {
                case 0:
                    debug("Core; using simple frame update handler");
                    _SafeStr_850 = simpleFrameUpdateHandler;
                    return;
                case 1:
                    debug("Core; using complex frame update handler");
                    _SafeStr_850 = complexFrameUpdateHandler;
                    return;
                case 2:
                    debug("Core; using profiler frame update handler");
                    _SafeStr_850 = profilerFrameUpdateHandler;
                    _SafeStr_848 = new Profiler(this);
                    attachComponent(_SafeStr_848, [new IIDProfiler()]);
                    _SafeStr_842.addChild(new ProfilerViewer(_SafeStr_848));
                    return;
                case 4:
                    debug("Core; using experimental frame update handler");
                    _SafeStr_850 = experimentalFrameUpdateHandler;
                    return;
                case 15:
                    debug("Core; using debug frame update handler");
                    _SafeStr_850 = debugFrameUpdateHandler;
                default:
            };
        }

        private static function writeObjectToProxy(_arg_1:String, _arg_2:Object):Boolean
        {
            var _local_3:IFileProxy;
            var _local_4:ByteArray;
            try
            {
                _local_3 = Core.instance.fileProxy;
                if (_local_3)
                {
                    _local_4 = new ByteArray();
                    _local_4.writeObject(_arg_2);
                    _local_3.writeCache(_arg_1, _local_4);
                    var _local_6:Boolean = true;
                    return (_local_6);
                };
                var _local_7:Boolean = false;
                return (_local_7);
            }
            catch(e:Error)
            {
                Logger.log(((("Caught error when writing Object (" + _arg_1) + ") to IFileProxy: ") + e.toString()));
                return (false);
            };

            return false;
        }

        private static function readObjectFromProxy(_arg_1:String):Object
        {
            var _local_2:IFileProxy;
            var _local_3:ByteArray;
            try
            {
                _local_2 = Core.instance.fileProxy;
                if (_local_2)
                {
                    _local_3 = _local_2.readCache(_arg_1);
                    if (_local_3)
                    {
                        return _local_3.readObject();
                    };
                };

                return null;
            }
            catch(e:Error)
            {
                Logger.log(((("Caught error when reading Object (" + _arg_1) + ") from IFileProxy: ") + e.toString()));
                return (null);
            };

            return null;
        }


        public function set fileProxy(_arg_1:IFileProxy):void
        {
            _fileProxy = _arg_1;
        }

        public function get fileProxy():IFileProxy
        {
            return (_fileProxy);
        }

        public function getNumberOfFilesPending():uint
        {
            return (_SafeStr_849.length);
        }

        public function getNumberOfFilesLoaded():uint
        {
            return (_numberOfFilesInConfig - getNumberOfFilesPending());
        }

        public function get arguments():Dictionary
        {
            return (_arguments);
        }

        public function clearArguments():void
        {
            _arguments = new Dictionary();
        }

        public function initialize():void
        {
            if (hasLockedComponents())
            {
                events.addEventListener("COMPONENT_EVENT_UNLOCKED", unlockEventHandler);
            }
            else
            {
                doInitialize();
            };
        }

        private function unlockEventHandler(_arg_1:Event):void
        {
            if (!hasLockedComponents())
            {
                events.removeEventListener("COMPONENT_EVENT_UNLOCKED", unlockEventHandler);
                doInitialize();
            };
        }

        private function doInitialize():void
        {
            events.dispatchEvent(new Event("COMPONENT_EVENT_RUNNING"));
            PurgeTrigger.start();
        }

        public function hasLockedComponents():Boolean
        {
            if (_SafeStr_843 != null)
            {
                for each (var _local_1:Component in _SafeStr_843)
                {
                    if (_local_1.locked)
                    {
                        return (true);
                    };
                };
            };
            return (false);
        }

        override public function dispose():void
        {
            var _local_2:Array;
            var _local_1:UpdateDelegate;
            var _local_3:uint;
            var _local_4:uint;
            if (!disposed)
            {
                debug("Disposing core");
                PurgeTrigger.stop();
                try
                {
                    _local_4 = 0;
                    while (_local_4 < 3)
                    {
                        _local_2 = (_SafeStr_846[_local_4] as Array);
                        _local_3 = _local_2.length;
                        while (_local_3-- > 0)
                        {
                            _local_1 = _local_2.pop();
                            if ((_local_1 is UpdateDelegate))
                            {
                                UpdateDelegate(_local_1).dispose();
                            };
                        };
                        _local_4++;
                    };
                }
                catch(e:Error)
                {
                };
                if (_SafeStr_842)
                {
                    _SafeStr_842.removeEventListener("enterFrame", onEnterFrame);
                    _SafeStr_842 = null;
                };
                if (_SafeStr_849 != null)
                {
                    _SafeStr_849.dispose();
                    _SafeStr_849 = null;
                };
                super.dispose();
            };
        }

        override public function error(_arg_1:String, _arg_2:Boolean, _arg_3:int=-1, _arg_4:Error=null):void
        {
            super.error(_arg_1, _arg_2, _arg_3, _arg_4);
            _SafeStr_851.logError(_arg_1, _arg_2, _arg_3, _arg_4);
            if (_arg_2)
            {
                dispose();
            };
        }

        public function readConfigDocument(_arg_1:XML, _arg_2:IEventDispatcher=null):void
        {
            var _local_3:XML;
            var _local_7:XMLList;
            var _local_4:XML;
            var _local_8:String;
            var _local_5:LibraryLoader;
            var _local_6:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
            debug("Parsing config document");
            _loadingEventDelegate = _arg_2;
            if (_SafeStr_849 == null)
            {
                _SafeStr_849 = new LibraryLoaderQueue(_SafeStr_845);
            };
            _local_3 = _arg_1.child("asset-libraries")[0];
            if (_local_3 != null)
            {
                _local_7 = _local_3.child("library");
                for each (_local_4 in _local_7)
                {
                    _local_8 = _local_4.attribute("url").toString();
                    _local_5 = new LibraryLoader(_local_6, true, _SafeStr_845);
                    assets.loadFromFile(_local_5, true);
                    _local_5.load(new URLRequest(_local_8));
                    _SafeStr_849.push(_local_5);
                    _local_5.addEventListener("LIBRARY_LOADER_EVENT_COMPLETE", updateLoadingProcess);
                    _local_5.addEventListener("LIBRARY_LOADER_EVENT_ERROR", errorInLoadingProcess);
                    _numberOfFilesInConfig++;
                };
            };
            _local_3 = _arg_1.child("service-libraries")[0];
            if (_local_3 != null)
            {
                _local_7 = _local_3.child("library");
                for each (_local_4 in _local_7)
                {
                    _local_8 = _local_4.attribute("url").toString();
                    _local_5 = new LibraryLoader(_local_6, true, _SafeStr_845);
                    _local_5.load(new URLRequest(_local_8));
                    _SafeStr_849.push(_local_5);
                    _local_5.addEventListener("LIBRARY_LOADER_EVENT_COMPLETE", updateLoadingProcess);
                    _local_5.addEventListener("LIBRARY_LOADER_EVENT_ERROR", errorInLoadingProcess);
                    _numberOfFilesInConfig++;
                };
            };
            _local_3 = _arg_1.child("component-libraries")[0];
            if (_local_3 != null)
            {
                _local_7 = _local_3.child("library");
                for each (_local_4 in _local_7)
                {
                    _local_8 = _local_4.attribute("url").toString();
                    _local_5 = new LibraryLoader(_local_6, true, _SafeStr_845);
                    _local_5.load(new URLRequest(_local_8));
                    _SafeStr_849.push(_local_5);
                    _local_5.addEventListener("LIBRARY_LOADER_EVENT_COMPLETE", updateLoadingProcess);
                    _local_5.addEventListener("LIBRARY_LOADER_EVENT_ERROR", errorInLoadingProcess);
                    _numberOfFilesInConfig++;
                };
            };
            if (!disposed)
            {
                updateLoadingProcess();
            };
        }

        public function writeDictionaryToProxy(_arg_1:String, _arg_2:Dictionary):Boolean
        {
            return (writeObjectToProxy(_arg_1, _arg_2));
        }

        public function readDictionaryFromProxy(_arg_1:String):Dictionary
        {
            return (readObjectFromProxy(_arg_1) as Dictionary);
        }

        public function writeXMLToProxy(_arg_1:String, _arg_2:XML):Boolean
        {
            return (writeObjectToProxy(_arg_1, _arg_2));
        }

        public function readXMLFromProxy(_arg_1:String):XML
        {
            return (readObjectFromProxy(_arg_1) as XML);
        }

        public function readStringFromProxy(_arg_1:String):String
        {
            var _local_2:IFileProxy;
            var _local_3:ByteArray;
            try
            {
                _local_2 = Core.instance.fileProxy;
                if (_local_2)
                {
                    _local_3 = _local_2.readCache(_arg_1);
                    if (_local_3)
                    {
                        return _local_3.readUTFBytes(_local_3.length);
                    };
                };
                return null;
            }
            catch(e:Error)
            {
                Logger.log(((("Caught error when reading Object (" + _arg_1) + ") from IFileProxy: ") + e.toString()));
                return (null);
            };

            return null;
        }

        public function writeStringToProxy(_arg_1:String, _arg_2:String):Boolean
        {
            var _local_3:IFileProxy;
            var _local_4:ByteArray;
            try
            {
                _local_3 = Core.instance.fileProxy;
                if (_local_3)
                {
                    _local_4 = new ByteArray();
                    _local_4.writeUTFBytes(_arg_2);
                    _local_3.writeCache(_arg_1, _local_4);
                    var _local_6:Boolean = true;
                    return (_local_6);
                };
                var _local_7:Boolean = false;
                return (_local_7);
            }
            catch(e:Error)
            {
                Logger.log(((("Caught error when writing String (" + _arg_1) + ") to IFileProxy: ") + e.toString()));
                return (false);
            };

            return false;
        }

        private function errorInLoadingProcess(_arg_1:LibraryLoaderEvent=null):void
        {
            var _local_2:LibraryLoader = LibraryLoader(_arg_1.target);
            error(((((((((('Failed to download library "' + _local_2.url) + '" HTTP status ') + _arg_1.status) + " bytes loaded ") + _arg_1.bytesLoaded) + "/") + _arg_1.bytesTotal) + " : ") + _local_2.getLastErrorMessage()), true, 2);
            if (!disposed)
            {
                updateLoadingProcess(_arg_1);
            };
        }

        private function finalizeLoadingEventDelegate():void
        {
            if (_loadingEventDelegate != null)
            {
                _loadingEventDelegate.dispatchEvent(new Event("complete"));
                _loadingEventDelegate = null;
            };
        }

        private function updateLoadingProgress(_arg_1:LibraryLoaderEvent=null):void
        {
            var _local_2:LibraryLoader;
            if (_loadingEventDelegate != null)
            {
                _local_2 = (_arg_1.target as LibraryLoader);
                _loadingEventDelegate.dispatchEvent(new LibraryProgressEvent(_local_2.url, _arg_1.bytesLoaded, _arg_1.bytesTotal, _local_2.elapsedTime));
            };
        }

        private function updateLoadingProcess(_arg_1:LibraryLoaderEvent=null):void
        {
            var _local_2:LibraryLoader;
            var _local_3:String;
            if (_arg_1 != null)
            {
                if (((_arg_1.type == "LIBRARY_LOADER_EVENT_COMPLETE") || (_arg_1.type == "LIBRARY_LOADER_EVENT_ERROR")))
                {
                    _local_2 = (_arg_1.target as LibraryLoader);
                    _local_2.removeEventListener("LIBRARY_LOADER_EVENT_COMPLETE", updateLoadingProcess);
                    _local_2.removeEventListener("LIBRARY_LOADER_EVENT_ERROR", errorInLoadingProcess);
                    _local_2.removeEventListener("LIBRARY_LOADER_EVENT_PROGRESS", updateLoadingProgress);
                    _local_3 = _local_2.url;
                    debug(((('Loading library "' + _local_3) + '" ') + ((_arg_1.type == "LIBRARY_LOADER_EVENT_COMPLETE") ? "ready" : ("failed\n" + _local_2.getLastErrorMessage()))));
                    _local_2.dispose();
                    if (!disposed)
                    {
                        if (_loadingEventDelegate != null)
                        {
                            _loadingEventDelegate.dispatchEvent(new LibraryProgressEvent(_local_2.url, (_numberOfFilesInConfig - _SafeStr_849.length), _numberOfFilesInConfig, _local_2.elapsedTime));
                        };
                    };
                };
            };
            if (!disposed)
            {
                if (_SafeStr_849.length == 0)
                {
                    finalizeLoadingEventDelegate();
                    debug("All libraries loaded, Core is now running");
                };
            };
        }

        override public function registerUpdateReceiver(_arg_1:IUpdateReceiver, _arg_2:uint):void
        {
            removeUpdateReceiver(_arg_1);
            _arg_2 = ((_arg_2 >= 3) ? (3 - 1) : _arg_2);
            var _local_3:int = ((_SafeStr_848) ? 2 : (_SafeStr_852 & 0x0F));
            if (_local_3 == 4)
            {
                _SafeStr_846[_arg_2].push(new UpdateDelegate(_arg_1, this, _arg_2));
            }
            else
            {
                _SafeStr_846[_arg_2].push(_arg_1);
            };
        }

        override public function removeUpdateReceiver(_arg_1:IUpdateReceiver):void
        {
            var _local_4:Array;
            var _local_5:int;
            var _local_6:uint;
            if (disposed)
            {
                return;
            };
            var _local_3:int = ((_SafeStr_848) ? 2 : (_SafeStr_852 & 0x0F));
            _local_6 = 0;
            while (_local_6 < 3)
            {
                _local_4 = (_SafeStr_846[_local_6] as Array);
                if (_local_3 == 4)
                {
                    for each (var _local_2:UpdateDelegate in _local_4)
                    {
                        if (_local_2.receiver == _arg_1)
                        {
                            _local_2.dispose();
                            return;
                        };
                    };
                }
                else
                {
                    _local_5 = _local_4.indexOf(_arg_1);
                    if (_local_5 > -1)
                    {
                        _local_4[_local_5] = null;
                        return;
                    };
                };
                _local_6++;
            };
        }

        public function hibernate(_arg_1:int, _arg_2:int=1):void
        {
            if (!hibernating)
            {
                PurgeTrigger.stop();
                _hibernationLevel = _arg_1;
                _hibernationUpdateFrequency = (1000 / _arg_2);
            };
        }

        public function resume():void
        {
            if (hibernating)
            {
                PurgeTrigger.start();
                _hibernationLevel = -1;
            };
        }

        private function get hibernating():Boolean
        {
            return (_hibernationLevel > -1);
        }

        private function get maxPriority():uint
        {
            return ((hibernating) ? (_hibernationLevel + 1) : 3);
        }

        private function onEnterFrame(_arg_1:Event):void
        {
            if (_rebootOnNextFrame)
            {
                _SafeStr_842.removeEventListener("enterFrame", onEnterFrame);
                _rebootOnNextFrame = false;
                events.dispatchEvent(new Event("COMPONENT_EVENT_REBOOT"));
                return;
            };
            var _local_3:uint = getTimer();
            var _local_2:uint = (_local_3 - _lastUpdateTimeMs);
            if (((!(hibernating)) || (_local_2 > _hibernationUpdateFrequency)))
            {
                (_SafeStr_850(_local_3, _local_2));
                _lastUpdateTimeMs = _local_3;
            };
        }

        private function simpleFrameUpdateHandler(_arg_1:uint, _arg_2:uint):void
        {
            var _local_4:Array;
            var _local_3:IUpdateReceiver;
            var _local_5:uint;
            var _local_6:uint;
            var _local_7:uint;
            _local_7 = 0;
            while (_local_7 < maxPriority)
            {
                _SafeStr_847[_local_7] = 0;
                _local_4 = _SafeStr_846[_local_7];
                _local_6 = 0;
                _local_5 = _local_4.length;
                while (_local_6 != _local_5)
                {
                    _local_3 = IUpdateReceiver(_local_4[_local_6]);
                    if (((_local_3 == null) || (_local_3.disposed)))
                    {
                        _local_4.splice(_local_6, 1);
                        _local_5--;
                    }
                    else
                    {
                        try
                        {
                            _local_3.update(_arg_2);
                        }
                        catch(e:Error)
                        {
                            Logger.log(e.getStackTrace());
                            error(((('Error in update receiver "' + getQualifiedClassName(_local_3)) + '": ') + e.message), true, e.errorID, e);
                            return;
                        };
                        _local_6++;
                    };
                };
                _local_7++;
            };
        }

        private function complexFrameUpdateHandler(_arg_1:uint, _arg_2:uint):void
        {
            var _local_11:uint;
            var _local_6:Array;
            var _local_4:IUpdateReceiver;
            var _local_7:uint;
            var _local_9:uint;
            var _local_10:Boolean;
            var _local_5:uint;
            var _local_3:Boolean = true;
            var _local_8:uint = uint((1000 / _SafeStr_842.stage.frameRate));
            _local_11 = 0;
            while (_local_11 < maxPriority)
            {
                _local_5 = getTimer();
                _local_10 = false;
                if ((_local_5 - _arg_1) > _local_8)
                {
                    if (_SafeStr_847[_local_11] < _local_11)
                    {
                        _SafeStr_847[_local_11]++;
                        _local_10 = true;
                    };
                };
                if (!_local_10)
                {
                    _SafeStr_847[_local_11] = 0;
                    _local_6 = _SafeStr_846[_local_11];
                    _local_9 = 0;
                    _local_7 = _local_6.length;
                    while (((!(_local_9 == _local_7)) && (_local_3)))
                    {
                        _local_4 = IUpdateReceiver(_local_6[_local_9]);
                        if (((_local_4 == null) || (_local_4.disposed)))
                        {
                            _local_6.splice(_local_9, 1);
                            _local_7--;
                        }
                        else
                        {
                            try
                            {
                                _local_4.update(_arg_2);
                            }
                            catch(e:Error)
                            {
                                Logger.log(e.getStackTrace());
                                error(((('Error in update receiver "' + getQualifiedClassName(_local_4)) + '": ') + e), true, e.errorID, e);
                                _local_3 = false;
                            };
                            _local_9++;
                        };
                    };
                };
                _local_11++;
            };
        }

        private function profilerFrameUpdateHandler(_arg_1:uint, _arg_2:uint):void
        {
            var _local_4:Array;
            var _local_3:IUpdateReceiver;
            var _local_5:uint;
            var _local_6:uint;
            var _local_7:uint;
            _SafeStr_848.start();
            _local_7 = 0;
            while (_local_7 < maxPriority)
            {
                _SafeStr_847[_local_7] = 0;
                _local_4 = _SafeStr_846[_local_7];
                _local_6 = 0;
                _local_5 = _local_4.length;
                while (_local_6 != _local_5)
                {
                    _local_3 = IUpdateReceiver(_local_4[_local_6]);
                    if (((_local_3 == null) || (_local_3.disposed)))
                    {
                        _local_4.splice(_local_6, 1);
                        _local_5--;
                    }
                    else
                    {
                        try
                        {
                            _SafeStr_848.update(_local_3, _arg_2);
                        }
                        catch(e:Error)
                        {
                            error(((('Error in update receiver "' + getQualifiedClassName(_local_3)) + '": ') + e.message), true, e.errorID, e);
                            return;
                        };
                        _local_6++;
                    };
                };
                _local_7++;
            };
            _SafeStr_848.stop();
        }

        private function experimentalFrameUpdateHandler(_arg_1:uint, _arg_2:uint):void
        {
            var _local_5:int;
            var _local_3:Array;
            var _local_4:int;
            _local_5 = 0;
            while (_local_5 < 3)
            {
                _local_3 = _SafeStr_846[_local_5];
                _local_4 = (_local_3.length - 1);
                while (_local_4 > -1)
                {
                    if (_local_3[_local_4].disposed)
                    {
                        _local_3.splice(_local_4, 1);
                    };
                    _local_4--;
                };
                _local_5++;
            };
        }

        private function debugFrameUpdateHandler(_arg_1:uint, _arg_2:uint):void
        {
            var _local_4:Array;
            var _local_3:IUpdateReceiver;
            var _local_5:uint;
            var _local_6:uint;
            var _local_7:uint;
            _local_7 = 0;
            while (_local_7 < maxPriority)
            {
                _SafeStr_847[_local_7] = 0;
                _local_4 = _SafeStr_846[_local_7];
                _local_6 = 0;
                _local_5 = _local_4.length;
                while (_local_6 != _local_5)
                {
                    _local_3 = IUpdateReceiver(_local_4[_local_6]);
                    if (((_local_3 == null) || (_local_3.disposed)))
                    {
                        _local_4.splice(_local_6, 1);
                        _local_5--;
                    }
                    else
                    {
                        _local_3.update(_arg_2);
                        _local_6++;
                    };
                };
                _local_7++;
            };
        }

        public function setProfilerMode(_arg_1:Boolean):void
        {
            var _local_3:Array;
            var _local_2:Object;
            var _local_4:int;
            var _local_5:int;
            if (_arg_1)
            {
                _SafeStr_850 = profilerFrameUpdateHandler;
                if (((!(_SafeStr_848)) || (_SafeStr_848.disposed)))
                {
                    _SafeStr_848 = new Profiler(this);
                };
                attachComponent(_SafeStr_848, [new IIDProfiler()]);
                _local_5 = 0;
                while (_local_5 < 3)
                {
                    _local_3 = _SafeStr_846[_local_5];
                    _local_4 = (_local_3.length - 1);
                    while (_local_4 > -1)
                    {
                        _local_2 = _local_3[_local_4];
                        if ((_local_2 is UpdateDelegate))
                        {
                            _local_3[_local_4] = UpdateDelegate(_local_2).receiver;
                            UpdateDelegate(_local_2).dispose();
                        };
                        _local_4--;
                    };
                    _local_5++;
                };
            }
            else
            {
                detachComponent(_SafeStr_848);
                switch ((_SafeStr_852 & 0x0F))
                {
                    case 0:
                        _SafeStr_850 = simpleFrameUpdateHandler;
                        return;
                    case 1:
                        _SafeStr_850 = complexFrameUpdateHandler;
                        return;
                    case 4:
                        _SafeStr_850 = experimentalFrameUpdateHandler;
                        _local_5 = 0;
                        while (_local_5 < 3)
                        {
                            _local_3 = _SafeStr_846[_local_5];
                            _local_4 = (_local_3.length - 1);
                            while (_local_4 > -1)
                            {
                                _local_2 = _local_3[_local_4];
                                if ((_local_2 is IUpdateReceiver))
                                {
                                    _local_3[_local_4] = new UpdateDelegate(IUpdateReceiver(_local_2), this, _local_5);
                                };
                                _local_4--;
                            };
                            _local_5++;
                        };
                        return;
                    default:
                        _SafeStr_850 = debugFrameUpdateHandler;
                };
            };
        }

        public function set errorLogger(_arg_1:ICoreErrorLogger):void
        {
            if (_SafeStr_851 != null)
            {
                _SafeStr_851.errorLogger = _arg_1;
            };
        }

        public function reboot():void
        {
            _rebootOnNextFrame = true;
        }


    }
}import com.sulake.core.runtime.IDisposable;
import com.sulake.core.runtime.IUpdateReceiver;
import com.sulake.core.runtime.IContext;
import flash.utils.getTimer;
import flash.utils.getQualifiedClassName;
import flash.events.Event;

class UpdateDelegate implements IDisposable
{

    private var _receiver:IUpdateReceiver;
    private var _context:IContext;
    private var _priority:int;
    private var _lastUpdateTimeMs:uint;
    private var _framesSkipped:uint = 0;

    public function UpdateDelegate(_arg_1:IUpdateReceiver, _arg_2:IContext, _arg_3:int)
    {
        if (((_arg_2) && (_arg_1)))
        {
            _receiver = _arg_1;
            _context = _arg_2;
            _priority = _arg_3;
            _arg_2.displayObjectContainer.stage.addEventListener(((_priority == 0) ? "exitFrame" : "enterFrame"), onFrameUpdate);
            _lastUpdateTimeMs = getTimer();
        };
    }

    public function get priority():int
    {
        return (_priority);
    }

    public function get receiver():IUpdateReceiver
    {
        return (_receiver);
    }

    public function get disposed():Boolean
    {
        return ((_receiver) ? _receiver.disposed : true);
    }

    public function dispose():void
    {
        if (_receiver)
        {
            _receiver = null;
            _context.displayObjectContainer.stage.removeEventListener(((_priority == 0) ? "exitFrame" : "enterFrame"), onFrameUpdate);
            _context = null;
        };
    }

    private function onFrameUpdate(_arg_1:Event):void
    {
        var _local_2:uint;
        if (!disposed)
        {
            _local_2 = getTimer();
            var _local_3:uint = (_local_2 - _lastUpdateTimeMs);
            _lastUpdateTimeMs = _local_2;
            if (((_priority > 0) && (_framesSkipped < _priority)))
            {
                if (_local_3 > (1000 / _context.displayObjectContainer.stage.frameRate))
                {
                    _framesSkipped++;
                    return;
                };
            };
            _framesSkipped = 0;
            try
            {
                _receiver.update(_local_3);
            }
            catch(e:Error)
            {
                _context.error(((('Error in update receiver "' + getQualifiedClassName(_receiver)) + '": ') + e.message), true, e.errorID, e);
            };
        };
    }


}


// _SafeStr_13 = "_-OS" (String#8645, DoABC#3)
// _SafeStr_842 = "_-V1X" (String#8756, DoABC#3)
// _SafeStr_843 = "_-r2" (String#9122, DoABC#3)
// _SafeStr_845 = "_-w1L" (String#1051, DoABC#3)
// _SafeStr_846 = "_-t13" (String#9146, DoABC#3)
// _SafeStr_847 = "_-BW" (String#8428, DoABC#3)
// _SafeStr_848 = "_-d1D" (String#8905, DoABC#3)
// _SafeStr_849 = "_-nX" (String#9070, DoABC#3)
// _SafeStr_850 = "_-N1e" (String#8624, DoABC#3)
// _SafeStr_851 = "_-ig" (String#9004, DoABC#3)
// _SafeStr_852 = "_-h1f" (String#3427, DoABC#3)
