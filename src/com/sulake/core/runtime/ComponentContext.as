package com.sulake.core.runtime
{
    import __AS3__.vec.Vector;
    import com.sulake.core.utils.LibraryLoader;
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    import com.sulake.core.runtime.events.ILinkEventTracker;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.Event;
    import com.sulake.core.runtime.events.WarningEvent;
    import com.sulake.core.runtime.events.ErrorEvent;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;
    import com.sulake.core.utils.LibraryLoaderEvent;
    import flash.utils.ByteArray;
    import flash.system.ApplicationDomain;
    import com.sulake.core.assets.AssetLibrary;
    import flash.utils.getDefinitionByName;
    import com.sulake.core.runtime.exceptions.InvalidComponentException;
    import flash.utils.getQualifiedClassName;
    import com.sulake.core.runtime.events.LockEvent;

        public class ComponentContext extends Component implements IContext 
    {

        protected var _loaders:Vector.<LibraryLoader>;
        protected var _SafeStr_845:Boolean = false;
        private var _configuration:ICoreConfiguration;

        protected var _SafeStr_842:DisplayObjectContainer = new Sprite();
        protected var _SafeStr_843:Vector.<Component> = new Vector.<Component>();
        protected var _SafeStr_844:Vector.<ComponentInterfaceQueue> = new Vector.<ComponentInterfaceQueue>();
        private var _linkEventTrackers:Vector.<ILinkEventTracker> = new Vector.<ILinkEventTracker>(0);

        public function ComponentContext(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, (_arg_2 | 0x02), _arg_3);
        }

        public function get root():IContext
        {
            if (((!(context)) || (context == this)))
            {
                return (this);
            };
            return (context.root);
        }

        public function get displayObjectContainer():DisplayObjectContainer
        {
            return (_SafeStr_842);
        }

        override public function purge():void
        {
            super.purge();
            for each (var _local_1:Component in _SafeStr_843)
            {
                if (_local_1 != this)
                {
                    _local_1.purge();
                };
            };
        }

        public function debug(_arg_1:String):void
        {
            _SafeStr_837 = _arg_1;
            if (((_SafeStr_845) && (events)))
            {
                events.dispatchEvent(new Event("COMPONENT_EVENT_DEBUG"));
            };
        }

        public function getLastDebugMessage():String
        {
            return (_SafeStr_837);
        }

        public function warning(_arg_1:String):void
        {
            _SafeStr_838 = _arg_1;
            if (events != null)
            {
                events.dispatchEvent(new WarningEvent("COMPONENT_EVENT_WARNING", _arg_1));
            };
        }

        public function getLastWarningMessage():String
        {
            return (_SafeStr_838);
        }

        public function error(_arg_1:String, _arg_2:Boolean, _arg_3:int=-1, _arg_4:Error=null):void
        {
            _lastError = _arg_1;
            if (events != null)
            {
                events.dispatchEvent(new ErrorEvent("COMPONENT_EVENT_ERROR", _arg_1, _arg_2, _arg_3, _arg_4));
            };
        }

        public function getLastErrorMessage():String
        {
            return (_lastError);
        }

        final public function loadFromFile(_arg_1:URLRequest, _arg_2:LoaderContext):LibraryLoader
        {
            var _local_3:LibraryLoader;
            if (_loaders == null)
            {
                _loaders = new Vector.<LibraryLoader>();
            };
            for each (_local_3 in _loaders)
            {
                if (_local_3.url == _arg_1.url)
                {
                    return (_local_3);
                };
            };
            _local_3 = new LibraryLoader(_arg_2, _SafeStr_845);
            _local_3.addEventListener("LIBRARY_LOADER_EVENT_COMPLETE", loadReadyHandler, false);
            _local_3.addEventListener("LIBRARY_LOADER_EVENT_ERROR", loadErrorHandler, false);
            _local_3.addEventListener("LIBRARY_LOADER_EVENT_DEBUG", loadDebugHandler, false);
            _local_3.load(_arg_1);
            _loaders.push(_local_3);
            return (_local_3);
        }

        final protected function loadReadyHandler(_arg_1:LibraryLoaderEvent):void
        {
            var _local_2:LibraryLoader = (_arg_1.target as LibraryLoader);
            removeLibraryLoader(_local_2);
            prepareComponent(_local_2.resource, 0, _local_2.domain);
        }

        protected function loadErrorHandler(_arg_1:LibraryLoaderEvent):void
        {
            var _local_2:LibraryLoader;
            _local_2 = (_arg_1.target as LibraryLoader);
            var _local_3:String = _local_2.getLastErrorMessage();
            removeLibraryLoader(_local_2);
            error((((('Failed to download component resource "' + _local_2.url) + '"!') + "\r") + _local_3), true, 5);
        }

        protected function loadDebugHandler(_arg_1:LibraryLoaderEvent):void
        {
            var _local_2:LibraryLoader;
            _local_2 = (_arg_1.target as LibraryLoader);
            var _local_3:String = _local_2.getLastDebugMessage();
            debug(_local_3);
        }

        protected function removeLibraryLoader(_arg_1:LibraryLoader):void
        {
            _arg_1.removeEventListener("LIBRARY_LOADER_EVENT_COMPLETE", loadReadyHandler, false);
            _arg_1.removeEventListener("LIBRARY_LOADER_EVENT_ERROR", loadReadyHandler, false);
            _arg_1.dispose();
            var _local_2:int = _loaders.indexOf(_arg_1);
            if (_local_2 > -1)
            {
                _loaders.splice(_local_2, 1);
            };
        }

        public function prepareAssetLibrary(_arg_1:XML, _arg_2:Class):Boolean
        {
            return (assets.loadFromResource(_arg_1, _arg_2));
        }

        final public function prepareComponent(_arg_1:Class, _arg_2:uint=0, _arg_3:ApplicationDomain=null):IUnknown
        {
            var _local_11:XML;
            var _local_16:Object;
            var _local_23:ByteArray;
            var _local_8:Class;
            var _local_4:String;
            var _local_13:XMLList;
            var _local_21:Component;
            var _local_5:Array;
            var _local_9:Class;
            var _local_7:String;
            var _local_10:IID;
            var _local_18:String;
            var _local_19:IUnknown;
            var _local_6:XML;
            var _local_14:uint;
            var _local_17:XMLList;
            var _local_20:XML;
            var _local_15:uint;
            if (_arg_3 == null)
            {
                _arg_3 = ApplicationDomain.currentDomain;
            };
            try
            {
                _local_16 = (_arg_1 as Object).manifest;
                if ((_local_16 is XML))
                {
                    _local_11 = (_local_16 as XML);
                }
                else
                {
                    if ((_local_16 is Class))
                    {
                        var _local_23_cls:Class = _local_16 as Class;
                        _local_23 = new _local_23_cls() as ByteArray;
                        _local_11 = new XML(_local_23.readUTFBytes(_local_23.length));
                    };
                };
            }
            catch(e:Error)
            {
                _local_11 = null;
            };
            if (_local_11 == null)
            {
                return (null);
            };
            var _local_12:XMLList = _local_11.child("component");
            _local_14 = 0;
            while (_local_14 < _local_12.length())
            {
                _local_6 = _local_12[_local_14];
                _local_18 = _local_6.attribute("version");
                _local_4 = _local_6.attribute("class");
                _local_17 = _local_6.child("assets");
                var _local_22:XMLList = _local_6.child("aliases");
                var _local_24:IAssetLibrary = null;
                if (_local_17.length() > 0)
                {
                    _local_20 = new XML("<manifest><library /></manifest>");
                    _local_20.library.appendChild(_local_17);
                    _local_20.library.appendChild(_local_22);
                    _local_24 = new AssetLibrary(("_assets@" + _local_4), _local_20);
                    _local_24.loadFromResource(_local_20, _arg_1);
                };
                _local_8 = (_arg_3.getDefinition(_local_4) as Class);
                if (_local_8 == null)
                {
                    _local_8 = (getDefinitionByName(_local_4) as Class);
                };
                if (_local_8 == null)
                {
                    error((("Invalid component class " + _local_4) + "!"), true, 4);
                    return (null);
                };
                _local_21 = ((_local_24 == null) ? new _local_8(this, _arg_2) : new _local_8(this, _arg_2, _local_24));
                if (_local_21 != null)
                {
                    if (_local_24 != null)
                    {
                        if (_local_21.assets != _local_24)
                        {
                            _local_24.dispose();
                            error((('Component "' + _local_4) + '" did not save provided asset library!'), true, 4);
                        };
                    };
                    _local_13 = _local_6.child("interface");
                    _local_5 = [];
                    _local_15 = 0;
                    while (_local_15 < _local_13.length())
                    {
                        _local_7 = _local_13[_local_15].attribute("iid");
                        _local_9 = (_arg_3.getDefinition(_local_7) as Class);
                        if (_local_9 == null)
                        {
                            _local_9 = (getDefinitionByName(_local_7) as Class);
                        };
                        if (_local_9 == null)
                        {
                            throw (new InvalidComponentException(("Identifier class defined in manifest not found: " + _local_7)));
                        };
                        _local_10 = new _local_9();
                        _local_19 = (_local_21 as IUnknown);
                        getInterfaceStructList(_local_21).insert(new InterfaceStruct(_local_10, _local_21));
                        _local_5.push(_local_10);
                        _local_15++;
                    };
                    attachComponent(_local_21, _local_5);
                };
                _local_14++;
            };
            return (_local_21 as IUnknown);
        }

        final public function attachComponent(_arg_1:Component, _arg_2:Array):void
        {
            var _local_6:uint;
            var _local_4:IID;
            var _local_3:IID;
            if (_SafeStr_843 == null)
            {
                return;
            };
            if (_SafeStr_843.indexOf(_arg_1) > -1)
            {
                error((("Component " + _arg_1) + " already attached to context!"), false);
                return;
            };
            _SafeStr_843.push(_arg_1);
            if (_arg_1.locked)
            {
                _arg_1.events.addEventListener("_INTERNAL_EVENT_UNLOCKED", unlockEventHandler);
            };
            var _local_5:uint = _arg_2.length;
            _local_6 = 0;
            while (_local_6 < _local_5)
            {
                _local_4 = _arg_2[_local_6];
                if (getInterfaceStructList(_arg_1).find(_local_4) == null)
                {
                    getInterfaceStructList(_arg_1).insert(new InterfaceStruct(_local_4, _arg_1));
                };
                getInterfaceStructList(this).insert(new InterfaceStruct(_local_4, _arg_1));
                _local_6++;
            };
            if (!_arg_1.locked)
            {
                _local_6 = 0;
                while (_local_6 < _local_5)
                {
                    _local_3 = _arg_2[_local_6];
                    if (hasQueueForInterface(_local_3))
                    {
                        announceInterfaceAvailability(_local_3, _arg_1);
                    };
                    _local_6++;
                };
            };
        }

        final public function detachComponent(_arg_1:Component):void
        {
            var _local_2:InterfaceStruct;
            var _local_4:uint;
            var _local_5:InterfaceStructList = getInterfaceStructList(this);
            var _local_3:int = _local_5.getIndexByImplementor(_arg_1);
            while (_local_3 > -1)
            {
                _local_2 = _local_5.remove(_local_3);
                _local_3 = _local_5.getIndexByImplementor(_arg_1);
            };
            _local_4 = 0;
            while (_local_4 < _SafeStr_843.length)
            {
                if (_SafeStr_843[_local_4] == _arg_1)
                {
                    _SafeStr_843.splice(_local_4, 1);
                    _arg_1.events.removeEventListener("_INTERNAL_EVENT_UNLOCKED", unlockEventHandler);
                    return;
                };
                _local_4++;
            };
        }

        override public function queueInterface(_arg_1:IID, _arg_2:Function=null):IUnknown
        {
            var _local_5:IUnknown;
            var _local_4:InterfaceStructList = getInterfaceStructList(this);
            if (_local_4 == null)
            {
                return (null);
            };
            var _local_3:InterfaceStruct = _local_4.getStructByInterface(_arg_1);
            if (_local_3 != null)
            {
                if (((_local_3.unknown == this) && (_local_3.iis == getQualifiedClassName(_arg_1))))
                {
                    return (super.queueInterface(_arg_1, _arg_2));
                };
                _local_5 = _local_3.unknown.queueInterface(_arg_1, _arg_2);
                if (_local_5)
                {
                    return (_local_5);
                };
            };
            if (_arg_2 != null)
            {
                addQueueeForInterface(_arg_1, _arg_2);
                if (((context) && (!(context == this))))
                {
                    context.queueInterface(_arg_1, announceInterfaceAvailability);
                };
            };
            return (null);
        }

        final protected function addQueueeForInterface(_arg_1:IID, _arg_2:Function):void
        {
            var _local_3:ComponentInterfaceQueue;
            if (hasQueueForInterface(_arg_1))
            {
                _local_3 = getQueueForInterface(_arg_1);
            }
            else
            {
                _local_3 = new ComponentInterfaceQueue(_arg_1);
                _SafeStr_844.push(_local_3);
            };
            _local_3.receivers.unshift(_arg_2);
        }

        final protected function hasQueueForInterface(_arg_1:IID):Boolean
        {
            var _local_4:uint;
            if (_SafeStr_844 == null)
            {
                return (false);
            };
            var _local_2:String = getQualifiedClassName(_arg_1);
            var _local_3:uint = _SafeStr_844.length;
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                if (getQualifiedClassName(_SafeStr_844[_local_4].identifier) == _local_2)
                {
                    return (true);
                };
                _local_4++;
            };
            return (false);
        }

        final protected function getQueueForInterface(_arg_1:IID):ComponentInterfaceQueue
        {
            var _local_5:ComponentInterfaceQueue;
            var _local_4:uint;
            var _local_2:String = getQualifiedClassName(_arg_1);
            var _local_3:uint = _SafeStr_844.length;
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_5 = _SafeStr_844[_local_4];
                if (getQualifiedClassName(_local_5.identifier) == _local_2)
                {
                    return (_local_5);
                };
                _local_4++;
            };
            return (null);
        }

        final protected function announceInterfaceAvailability(_arg_1:IID, _arg_2:Component):void
        {
            var _local_6:IUnknown;
            var _local_4:uint;
            var _local_5:ComponentInterfaceQueue = getQueueForInterface(_arg_1);
            if (_local_5 == null)
            {
                return;
            };
            var _local_3:uint = _local_5.receivers.length;
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_6 = _arg_2.queueInterface(_arg_1);
                if (_local_6 == null)
                {
                    error((("Interface " + _arg_1) + " still unavailable!"), true, 6);
                };
                if (_local_5.receivers != null)
                {
                    (_local_5.receivers.pop()(_arg_1, _local_6));
                };
                _local_4++;
            };
        }

        override public function dispose():void
        {
            var _local_2:uint;
            var _local_1:LibraryLoader;
            if (!disposed)
            {
                super.dispose();
                if (_SafeStr_843 != null)
                {
                    _local_2 = _SafeStr_843.length;
                    while (_local_2-- > 0)
                    {
                        IUnknown(_SafeStr_843.pop()).dispose();
                    };
                    _SafeStr_843 = null;
                };
                if (_SafeStr_844 != null)
                {
                    _local_2 = _SafeStr_844.length;
                    while (_local_2-- > 0)
                    {
                        IDisposable(_SafeStr_844.pop()).dispose();
                    };
                    _SafeStr_844 = null;
                };
                if (_loaders != null)
                {
                    _local_2 = _loaders.length;
                    while (_local_2-- > 0)
                    {
                        _local_1 = _loaders[0];
                        removeLibraryLoader(_local_1);
                        _local_1.dispose();
                    };
                    _loaders = null;
                };
            };
        }

        private function unlockEventHandler(_arg_1:LockEvent):void
        {
            var _local_2:InterfaceStruct;
            var _local_4:Array;
            var _local_3:Component = (_arg_1.unknown as Component);
            if (!_local_3.disposed)
            {
                _local_3.events.removeEventListener("_INTERNAL_EVENT_UNLOCKED", unlockEventHandler);
            };
            if (!disposed)
            {
                _local_4 = [];
                getInterfaceStructList(this).mapStructsByImplementor(_local_3, _local_4);
                while ((((_local_4.length) && (!(_local_3.disposed))) && (!(disposed))))
                {
                    _local_2 = _local_4.pop();
                    announceInterfaceAvailability(_local_2.iid, _local_3);
                };
                root.events.dispatchEvent(new Event("COMPONENT_EVENT_UNLOCKED"));
            };
        }

        override public function toXMLString(_arg_1:uint=0):String
        {
            var _local_9:uint;
            var _local_3:InterfaceStruct;
            var _local_10:uint;
            var _local_4:Component;
            var _local_11:uint;
            var _local_6:String = "";
            _local_9 = 0;
            while (_local_9 < _arg_1)
            {
                _local_6 = (_local_6 + "\t");
                _local_9++;
            };
            var _local_7:String = getQualifiedClassName(this);
            var _local_2:String = "";
            _local_2 = (_local_2 + (((_local_6 + '<context class="') + _local_7) + '" >\n'));
            var _local_5:Array = [];
            var _local_8:uint = getInterfaceStructList(this).mapStructsByImplementor(this, _local_5);
            _local_10 = 0;
            while (_local_10 < _local_8)
            {
                _local_3 = _local_5[_local_10];
                _local_2 = (_local_2 + (((((_local_6 + '\t<interface iid="') + _local_3.iis) + '" refs="') + _local_3.references) + '"/>\n'));
                _local_10++;
            };
            _local_11 = 0;
            while (_local_11 < _SafeStr_843.length)
            {
                _local_4 = (_SafeStr_843[_local_11] as Component);
                if (_local_4 != this)
                {
                    _local_2 = (_local_2 + _local_4.toXMLString((_arg_1 + 1)));
                };
                _local_11++;
            };
            return (_local_2 + (_local_6 + "</context>\n"));
        }

        public function set configuration(_arg_1:ICoreConfiguration):void
        {
            _configuration = _arg_1;
        }

        public function get configuration():ICoreConfiguration
        {
            return (_configuration);
        }

        public function addLinkEventTracker(_arg_1:ILinkEventTracker):void
        {
            if (_linkEventTrackers.indexOf(_arg_1) < 0)
            {
                _linkEventTrackers.push(_arg_1);
            };
        }

        public function removeLinkEventTracker(_arg_1:ILinkEventTracker):void
        {
            var _local_2:int = _linkEventTrackers.indexOf(_arg_1);
            if (_local_2 > -1)
            {
                _linkEventTrackers.splice(_local_2, 1);
            };
        }

        public function createLinkEvent(_arg_1:String):void
        {
            for each (var _local_2:ILinkEventTracker in _linkEventTrackers)
            {
                if (_local_2.linkPattern.length > 0)
                {
                    if (_arg_1.substr(0, _local_2.linkPattern.length) == _local_2.linkPattern)
                    {
                        _local_2.linkReceived(_arg_1);
                    };
                }
                else
                {
                    _local_2.linkReceived(_arg_1);
                };
            };
        }

        public function get linkEventTrackers():Vector.<ILinkEventTracker>
        {
            return (_linkEventTrackers);
        }


    }
}

