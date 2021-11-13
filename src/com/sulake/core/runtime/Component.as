package com.sulake.core.runtime
{
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.events.EventDispatcherWrapper;
    import __AS3__.vec.Vector;
    import com.sulake.core.assets.AssetLibrary;
    import com.sulake.core.runtime.exceptions.InvalidComponentException;
    import com.sulake.core.utils.ClassUtils;
    import flash.events.IEventDispatcher;
    import com.sulake.core.runtime.exceptions.ComponentDisposedException;
    import flash.events.Event;
    import com.sulake.core.runtime.events.LockEvent;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import com.sulake.core.runtime.exceptions.*;

        public class Component implements IUnknown, ICoreConfiguration
    {

        public static const COMPONENT_EVENT_RUNNING:String = "COMPONENT_EVENT_RUNNING";
        public static const COMPONENT_EVENT_DISPOSING:String = "COMPONENT_EVENT_DISPOSING";
        public static const COMPONENT_EVENT_WARNING:String = "COMPONENT_EVENT_WARNING";
        public static const COMPONENT_EVENT_ERROR:String = "COMPONENT_EVENT_ERROR";
        public static const COMPONENT_EVENT_DEBUG:String = "COMPONENT_EVENT_DEBUG";
        public static const COMPONENT_EVENT_UNLOCKED:String = "COMPONENT_EVENT_UNLOCKED";
        public static const COMPONENT_EVENT_REBOOT:String = "COMPONENT_EVENT_REBOOT";
        protected static const INTERNAL_EVENT_UNLOCKED:String = "_INTERNAL_EVENT_UNLOCKED";
        public static const COMPONENT_FLAG_NULL:uint = 0;
        public static const COMPONENT_FLAG_INTERFACE:uint = 1;
        public static const COMPONENT_FLAG_CONTEXT:uint = 2;
        public static const COMPONENT_FLAG_DISPOSABLE:uint = 4;

        protected var _SafeStr_836:uint = 0;
        protected var _lastError:String = "";
        protected var _SafeStr_837:String = "";
        protected var _SafeStr_838:String = "";
        private var _assets:IAssetLibrary;
        private var _events:EventDispatcherWrapper;
        private var _flags:uint;
        private var _SafeStr_839:InterfaceStructList;
        private var _context:IContext = null;
        private var _disposed:Boolean = false;
        private var _locked:Boolean = false;
        private var _SafeStr_840:int = 1;
        private var _requiredDependencyIids:Vector.<String>;
        private var _SafeStr_841:Vector.<Function> = new Vector.<Function>(0);

        public function Component(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            _flags = _arg_2;
            _SafeStr_839 = new InterfaceStructList();
            _events = new EventDispatcherWrapper();
            _context = _arg_1;
            _assets = ((_arg_3 != null) ? _arg_3 : new AssetLibrary("_internal_asset_library"));
            if (_context == null)
            {
                throw (new InvalidComponentException("IContext not provided to Component's constructor!"));
            };
            if (dependencies.length > 0)
            {
                lock();
            };
            _requiredDependencyIids = new Vector.<String>(0);
            for each (var _local_4:ComponentDependency in dependencies)
            {
                if (_local_4.isRequired)
                {
                    _requiredDependencyIids.push(ClassUtils.getSimpleQualifiedClassName(_local_4.identifier));
                };
                injectDependency(_local_4.identifier, _local_4.dependencySetter, _local_4.isRequired, _local_4.eventListeners);
            };
            allDependenciesRequested();
        }

        public static function getInterfaceStructList(_arg_1:Component):InterfaceStructList
        {
            return (_arg_1._SafeStr_839);
        }


        public function get locked():Boolean
        {
            return (_locked);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get context():IContext
        {
            return (_context);
        }

        public function get events():IEventDispatcher
        {
            return (_events);
        }

        public function get assets():IAssetLibrary
        {
            return (_assets);
        }

        private function injectDependency(_arg_1:IID, _arg_2:Function, _arg_3:Boolean, _arg_4:Array):void
        {
            var identifier:IID = _arg_1;
            var dependencySetter:Function = _arg_2;
            var isRequired:Boolean = _arg_3;
            var eventListeners:Array = _arg_4;
            if (isRequired)
            {
                _SafeStr_840++;
            };
            queueInterface(identifier, (function (_arg_1:Function, _arg_2:Boolean, _arg_3:Array, _arg_4:String):Function
            {
                var setter:Function = _arg_1;
                var required:Boolean = _arg_2;
                var listeners:Array = _arg_3;
                var componentName:String = _arg_4;
                return (function (_arg_1:IID, _arg_2:IUnknown):void
                {
                    var identifier:IID = _arg_1;
                    var unknown:IUnknown = _arg_2;
                    if (disposed)
                    {
                        return;
                    };
                    if (setter != null)
                    {
                        (setter(unknown));
                    };
                    if (listeners != null)
                    {
                        var eventDispatcher:IEventDispatcher = Component(unknown).events;
                        for each (var listener:Object in listeners)
                        {
                            eventDispatcher.addEventListener(listener.type, listener.callback);
                        };
                    };
                    _SafeStr_841.push((function (_arg_1:IID, _arg_2:IUnknown):Function
                    {
                        var iid:IID = _arg_1;
                        var component:IUnknown = _arg_2;
                        return (function ():void
                        {
                            var _local_2:IEventDispatcher = null;
                            if (listeners != null)
                            {
                                _local_2 = Component(component).events;
                                if (_local_2 != null)
                                {
                                    for each (var _local_1:Object in listeners)
                                    {
                                        _local_2.removeEventListener(_local_1.type, _local_1.callback);
                                    };
                                };
                            };
                            if (setter != null)
                            {
                                (setter(null));
                            };
                            component.release(iid);
                        });
                    })(identifier, unknown));
                    if (required)
                    {
                        allDependenciesRequested(ClassUtils.getSimpleQualifiedClassName(identifier));
                    };
                });
            })(dependencySetter, isRequired, eventListeners, ClassUtils.getSimpleQualifiedClassName(this)));
        }

        private function allDependenciesRequested(_arg_1:String=""):void
        {
            _SafeStr_840--;
            if (((!(_arg_1 == "")) && (_requiredDependencyIids.indexOf(_arg_1) > -1)))
            {
                _requiredDependencyIids.splice(_requiredDependencyIids.indexOf(_arg_1), 1);
            };
            if (_SafeStr_840 == 0)
            {
                initComponent();
                unlock();
            };
        }

        protected function get allRequiredDependenciesInjected():Boolean
        {
            return (_SafeStr_840 == 0);
        }

        protected function get dependencies():Vector.<ComponentDependency>
        {
            return (new Vector.<ComponentDependency>(0));
        }

        protected function initComponent():void
        {
        }

        public function queueInterface(_arg_1:IID, _arg_2:Function=null):IUnknown
        {
            var _local_3:InterfaceStruct = _SafeStr_839.getStructByInterface(_arg_1);
            if (_local_3 == null)
            {
                return (_context.queueInterface(_arg_1, _arg_2));
            };
            if (_disposed)
            {
                throw (new ComponentDisposedException((('Failed to queue interface trough disposed Component "' + ClassUtils.getSimpleQualifiedClassName(this)) + '"!')));
            };
            if (_locked)
            {
                return (null);
            };
            _local_3.reserve();
            var _local_4:IUnknown = (_local_3.unknown as IUnknown);
            if (_arg_2 != null)
            {
                (_arg_2(_arg_1, _local_4));
            };
            return (_local_4);
        }

        public function release(_arg_1:IID):uint
        {
            if (_disposed)
            {
                return (0);
            };
            var _local_2:InterfaceStruct = _SafeStr_839.getStructByInterface(_arg_1);
            if (_local_2 == null)
            {
                _lastError = (("Attempting to release unknown interface:" + _arg_1) + "!");
                throw (new Error(_lastError));
            };
            var _local_3:uint = _local_2.release();
            if ((_flags & 0x04))
            {
                if (_local_3 == 0)
                {
                    if (_SafeStr_839.getTotalReferenceCount() == 0)
                    {
                        _context.detachComponent(this);
                        this.dispose();
                    };
                };
            };
            return (_local_3);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                for each (var _local_1:Function in _SafeStr_841)
                {
                    (_local_1());
                };
                _SafeStr_841 = null;
                _events.dispatchEvent(new Event("COMPONENT_EVENT_DISPOSING"));
                _events = null;
                _SafeStr_839.dispose();
                _SafeStr_839 = null;
                _assets.dispose();
                _assets = null;
                _context = null;
                _SafeStr_836 = 0;
                _disposed = true;
            };
        }

        public function purge():void
        {
        }

        final protected function lock():void
        {
            if (!_locked)
            {
                _locked = true;
            };
        }

        final protected function unlock():void
        {
            if (_locked)
            {
                _locked = false;
                _events.dispatchEvent(new LockEvent("_INTERNAL_EVENT_UNLOCKED", this));
            };
        }

        public function toString():String
        {
            return (((("[component " + ClassUtils.getSimpleQualifiedClassName(this)) + " refs: ") + _SafeStr_836) + "]");
        }

        public function toXMLString(_arg_1:uint=0):String
        {
            var _local_7:uint;
            var _local_3:InterfaceStruct;
            var _local_8:uint;
            var _local_4:String = "";
            _local_7 = 0;
            while (_local_7 < _arg_1)
            {
                _local_4 = (_local_4 + "\t");
                _local_7++;
            };
            var _local_5:String = getQualifiedClassName(this);
            var _local_2:String = "";
            _local_2 = (_local_2 + (((_local_4 + '<component class="') + _local_5) + '">\n'));
            var _local_6:uint = _SafeStr_839.length;
            _local_8 = 0;
            while (_local_8 < _local_6)
            {
                _local_3 = _SafeStr_839.getStructByIndex(_local_8);
                _local_2 = (_local_2 + (((((_local_4 + '\t<interface iid="') + _local_3.iis) + '" refs="') + _local_3.references) + '"/>\n'));
                _local_8++;
            };
            return (_local_2 + (_local_4 + "</component>\n"));
        }

        public function get requiredDependencyIids():Vector.<String>
        {
            return (_requiredDependencyIids);
        }

        public function registerUpdateReceiver(_arg_1:IUpdateReceiver, _arg_2:uint):void
        {
            if (!_disposed)
            {
                _context.registerUpdateReceiver(_arg_1, _arg_2);
            };
        }

        public function removeUpdateReceiver(_arg_1:IUpdateReceiver):void
        {
            if (!_disposed)
            {
                _context.removeUpdateReceiver(_arg_1);
            };
        }

        public function get flags():uint
        {
            return (_flags);
        }

        public function propertyExists(_arg_1:String):Boolean
        {
            return ((_context.configuration) ? _context.configuration.propertyExists(_arg_1) : false);
        }

        public function getProperty(_arg_1:String, _arg_2:Dictionary=null):String
        {
            return ((_context.configuration) ? _context.configuration.getProperty(_arg_1, _arg_2) : "");
        }

        public function setProperty(_arg_1:String, _arg_2:String, _arg_3:Boolean=false, _arg_4:Boolean=false):void
        {
            if (_context.configuration)
            {
                _context.configuration.setProperty(_arg_1, _arg_2, _arg_3, _arg_4);
            };
        }

        public function getBoolean(_arg_1:String):Boolean
        {
            return ((_context.configuration) ? _context.configuration.getBoolean(_arg_1) : false);
        }

        public function getInteger(_arg_1:String, _arg_2:int):int
        {
            return ((_context.configuration) ? _context.configuration.getInteger(_arg_1, _arg_2) : 0);
        }

        public function interpolate(_arg_1:String):String
        {
            return ((_context.configuration) ? _context.configuration.interpolate(_arg_1) : "");
        }

        public function updateUrlProtocol(_arg_1:String):String
        {
            return ((_context.configuration) ? _context.configuration.updateUrlProtocol(_arg_1) : "");
        }


    }
}