package com.sulake.habbo.communication.demo
{
    import com.sulake.core.runtime.events.EventDispatcherWrapper;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.core.window.ICoreWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IDropListWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.utils.CommunicationUtils;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import flash.net.Socket;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.IOErrorEvent;
    import com.sulake.core.window.events.WindowEvent;

        public class LoginEnvironmentsController extends EventDispatcherWrapper
    {

        public static const ENVIRONMENT_SELECTED_EVENT:String = "ENVIRONMENT_SELECTED_EVENT";

        private var _SafeStr_1666:ICoreConfiguration;
        private var _windowManager:ICoreWindowManager;
        private var _SafeStr_1663:IAssetLibrary;
        private var _SafeStr_1675:IWindow;
        private var _SafeStr_1676:int;
        private var _SafeStr_1677:IDropListWindow;
        private var _selectedEnvironment:String;

        public function LoginEnvironmentsController(_arg_1:IDropListWindow, _arg_2:ICoreConfiguration, _arg_3:ICoreWindowManager, _arg_4:IAssetLibrary)
        {
            _SafeStr_1666 = _arg_2;
            _windowManager = _arg_3;
            _SafeStr_1663 = _arg_4;
            _SafeStr_1677 = _arg_1;
            init();
        }

        public function get selectedEnvironment():String
        {
            return (_selectedEnvironment);
        }

        override public function dispose():void
        {
            _SafeStr_1677 = null;
            super.dispose();
        }

        private function getAvailableEnvironments():Array
        {
            return (_SafeStr_1666.getProperty("live.environment.list").split("/"));
        }

        private function createListItem(_arg_1:String):IWindow
        {
            var _local_2:XmlAsset = (_SafeStr_1663.getAssetByName(_arg_1) as XmlAsset);
            return (_windowManager.buildFromXML((_local_2.content as XML)));
        }

        private function init():void
        {
            var _local_5:int;
            var _local_6:IWindowContainer;
            _SafeStr_1675 = createListItem("login_environment_list_item");
            var _local_3:Array = getAvailableEnvironments();
            var _local_1:String = CommunicationUtils.readSOLString("environment");
            _local_1 = ((_local_1 == null) ? "d63" : _local_1);
            var _local_4:Array = getEnvironmentNames(_local_3);
            _selectedEnvironment = _local_1;
            var _local_7:int = _SafeStr_1677.numMenuItems;
            _local_5 = 0;
            while (_local_5 < _local_7)
            {
                _SafeStr_1677.removeMenuItemAt(0);
                _local_5++;
            };
            for each (var _local_2:String in _local_4)
            {
                _local_6 = (_SafeStr_1675.clone() as IWindowContainer);
                _local_6.findChildByName("title").caption = _local_2;
                _SafeStr_1677.addMenuItem(_local_6);
            };
            _SafeStr_1677.selection = _local_3.indexOf(_local_1);
            _SafeStr_1677.procedure = dropMenuEventHandler;
            _SafeStr_1676 = -1;
            testEnvironmentAvailable(false);
        }

        private function testEnvironmentAvailable(_arg_1:Boolean):void
        {
            var lastEnvironmentConnected:Boolean = _arg_1;
            if ((((_disposed) || (_SafeStr_1677 == null)) || (_SafeStr_1677.disposed)))
            {
                return;
            };
            var environmentIds:Array = getAvailableEnvironments();
            if ((((_SafeStr_1677) && (_SafeStr_1676 > -1)) && (_SafeStr_1676 < _SafeStr_1677.numMenuItems)))
            {
                var window:IWindowContainer = (_SafeStr_1677.getMenuItemAt(_SafeStr_1676) as IWindowContainer);
                (window.findChildByName("icon") as IStaticBitmapWrapperWindow).assetUri = ((lastEnvironmentConnected) ? "help_accept_icon" : "help_decline_icon");
            };
            _SafeStr_1676++;
            if (_SafeStr_1676 >= environmentIds.length)
            {
                return;
            };
            var environment:String = environmentIds[_SafeStr_1676];
            var host:String = _SafeStr_1666.getProperty(("connection.info.host." + environment));
            var ports:Array = _SafeStr_1666.getProperty(("connection.info.port." + environment)).split(",");
            var socket:Socket = new Socket();
            socket.addEventListener("connect", function (_arg_1:Event):void
            {
                (_arg_1.target as Socket).close();
                testEnvironmentAvailable(true);
            });
            socket.addEventListener("complete", function (_arg_1:Event):void
            {
                (_arg_1.target as Socket).close();
            });
            socket.addEventListener("close", function (_arg_1:Event):void
            {
                (_arg_1.target as Socket).close();
            });
            socket.addEventListener("socketData", function (_arg_1:ProgressEvent):void
            {
                (_arg_1.target as Socket).close();
            });
            socket.addEventListener("securityError", function (_arg_1:SecurityErrorEvent):void
            {
                (_arg_1.target as Socket).close();
                testEnvironmentAvailable(false);
            });
            socket.addEventListener("ioError", function (_arg_1:IOErrorEvent):void
            {
                (_arg_1.target as Socket).close();
                testEnvironmentAvailable(false);
            });
            socket.connect(host, ports[0]);
        }

        private function getEnvironmentNames(_arg_1:Array):Array
        {
            var _local_3:Array = [];
            for each (var _local_2:String in _arg_1)
            {
                _local_3.push(getEnvironmentName(_local_2));
            };
            return (_local_3);
        }

        public function getEnvironmentName(_arg_1:String):String
        {
            var _local_3:String = _arg_1;
            var _local_2:String = ("connection.info.name." + _arg_1);
            if (_SafeStr_1666.propertyExists(_local_2))
            {
                _local_3 = _SafeStr_1666.getProperty(_local_2);
            }
            else
            {
                Logger.log(("Could not find name for environment: " + _arg_1));
            };
            return (_local_3);
        }

        private function dropMenuEventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WE_SELECTED")
            {
                return;
            };
            var _local_4:Array = getAvailableEnvironments();
            var _local_5:int = _SafeStr_1677.selection;
            var _local_3:String = _local_4[_local_5];
            _selectedEnvironment = _local_3;
            dispatchEvent(new Event("ENVIRONMENT_SELECTED_EVENT"));
            _arg_1.stopPropagation();
            _arg_1.stopImmediatePropagation();
        }


    }
}