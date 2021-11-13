package 
{
    import com.sulake.core.runtime.ICore;
    import flash.events.IEventDispatcher;
    import com.sulake.core.assets.AssetLibraryCollection;
    import com.sulake.core.runtime.ICoreConfiguration;
    import flash.utils.Dictionary;
    import com.sulake.core.runtime.events.EventDispatcherWrapper;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.IContext;
    import flash.display.DisplayObjectContainer;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;
    import com.sulake.core.utils.LibraryLoader;
    import com.sulake.core.runtime.Component;
    import flash.system.ApplicationDomain;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.events.ILinkEventTracker;
    import __AS3__.vec.Vector;
    import com.sulake.core.utils.IFileProxy;

    public class FakeContext implements ICore 
    {

        private var _events:IEventDispatcher;
        private var _assets:AssetLibraryCollection;
        private var _configuration:ICoreConfiguration;
        private var _arguments:Dictionary;

        public function FakeContext(_arg_1:Dictionary)
        {
            _events = new EventDispatcherWrapper();
            _assets = new AssetLibraryCollection("fakeAssetCollection");
            _arguments = _arg_1;
        }

        public function get assets():IAssetLibrary
        {
            return (_assets);
        }

        public function get events():IEventDispatcher
        {
            return (_events);
        }

        public function get root():IContext
        {
            return (null);
        }

        public function error(_arg_1:String, _arg_2:Boolean, _arg_3:int=-1, _arg_4:Error=null):void
        {
        }

        public function getLastErrorMessage():String
        {
            return ("");
        }

        public function debug(_arg_1:String):void
        {
        }

        public function getLastDebugMessage():String
        {
            return ("");
        }

        public function warning(_arg_1:String):void
        {
        }

        public function getLastWarningMessage():String
        {
            return ("");
        }

        public function get displayObjectContainer():DisplayObjectContainer
        {
            return (null);
        }

        public function loadFromFile(_arg_1:URLRequest, _arg_2:LoaderContext):LibraryLoader
        {
            return (null);
        }

        public function attachComponent(_arg_1:Component, _arg_2:Array):void
        {
        }

        public function detachComponent(_arg_1:Component):void
        {
        }

        public function prepareComponent(_arg_1:Class, _arg_2:uint=0, _arg_3:ApplicationDomain=null):IUnknown
        {
            return (null);
        }

        public function prepareAssetLibrary(_arg_1:XML, _arg_2:Class):Boolean
        {
            return (false);
        }

        public function registerUpdateReceiver(_arg_1:IUpdateReceiver, _arg_2:uint):void
        {
        }

        public function removeUpdateReceiver(_arg_1:IUpdateReceiver):void
        {
        }

        public function toXMLString(_arg_1:uint=0):String
        {
            return ("");
        }

        public function queueInterface(_arg_1:IID, _arg_2:Function=null):IUnknown
        {
            return (null);
        }

        public function release(_arg_1:IID):uint
        {
            return (0);
        }

        public function dispose():void
        {
            _assets.dispose();
            _events = null;
            _assets = null;
        }

        public function get disposed():Boolean
        {
            return (false);
        }

        public function injectDependencies(_arg_1:Component):void
        {
        }

        public function get configuration():ICoreConfiguration
        {
            return (_configuration);
        }

        public function set configuration(_arg_1:ICoreConfiguration):void
        {
            _configuration = _arg_1;
        }

        public function addLinkEventTracker(_arg_1:ILinkEventTracker):void
        {
        }

        public function removeLinkEventTracker(_arg_1:ILinkEventTracker):void
        {
        }

        public function createLinkEvent(_arg_1:String):void
        {
        }

        public function get linkEventTrackers():Vector.<ILinkEventTracker>
        {
            return (null);
        }

        public function initialize():void
        {
        }

        public function purge():void
        {
        }

        public function hibernate(_arg_1:int, _arg_2:int=1):void
        {
        }

        public function resume():void
        {
        }

        public function readConfigDocument(_arg_1:XML, _arg_2:IEventDispatcher=null):void
        {
        }

        public function writeDictionaryToProxy(_arg_1:String, _arg_2:Dictionary):Boolean
        {
            return (false);
        }

        public function readDictionaryFromProxy(_arg_1:String):Dictionary
        {
            return (new Dictionary());
        }

        public function writeXMLToProxy(_arg_1:String, _arg_2:XML):Boolean
        {
            return (false);
        }

        public function readXMLFromProxy(_arg_1:String):XML
        {
            return (new XML());
        }

        public function readStringFromProxy(_arg_1:String):String
        {
            return ("");
        }

        public function writeStringToProxy(_arg_1:String, _arg_2:String):Boolean
        {
            return (false);
        }

        public function getNumberOfFilesPending():uint
        {
            return (0);
        }

        public function getNumberOfFilesLoaded():uint
        {
            return (0);
        }

        public function setProfilerMode(_arg_1:Boolean):void
        {
        }

        public function get arguments():Dictionary
        {
            return (_arguments);
        }

        public function clearArguments():void
        {
            _arguments = new Dictionary();
        }

        public function propertyExists(_arg_1:String):Boolean
        {
            return (false);
        }

        public function getProperty(_arg_1:String, _arg_2:Dictionary=null):String
        {
            return ("");
        }

        public function setProperty(_arg_1:String, _arg_2:String, _arg_3:Boolean=false, _arg_4:Boolean=false):void
        {
        }

        public function getBoolean(_arg_1:String):Boolean
        {
            return (false);
        }

        public function getInteger(_arg_1:String, _arg_2:int):int
        {
            return (0);
        }

        public function interpolate(_arg_1:String):String
        {
            return ("");
        }

        public function updateUrlProtocol(_arg_1:String):String
        {
            return ("");
        }

        public function get fileProxy():IFileProxy
        {
            return (undefined);
        }


    }
}