package com.sulake.habbo.communication.demo
{
    import com.sulake.core.runtime.events.EventDispatcherWrapper;
    import com.sulake.habbo.communication.login.ILoginViewer;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.utils.IModalDialog;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Dictionary;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.components.ITextFieldWindow;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.login.AvatarData;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.habbo.utils.CommunicationUtils;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IDropListWindow;
    import flash.events.Event;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.habbo.communication.login.ICaptchaView;
    import com.sulake.core.window.components.*;

        public class HabboLoginDemoScreen extends EventDispatcherWrapper implements ILoginViewer 
    {

        public static const INIT_LOGIN:String = "INIT_LOGIN";
        public static const AVATAR_SELECTED:String = "AVATAR_SELECTED";
        public static const ENVIRONMENT_SELECTED:String = "ENVIRONMENT_SELECTED";

        private var _SafeStr_1666:ICoreConfiguration;
        private var _SafeStr_1664:IHabboWindowManager;
        private var _SafeStr_1663:IAssetLibrary;
        private var _SafeStr_1665:IModalDialog;
        private var _window:IWindowContainer;
        private var _firstTryUsingExistingSession:Boolean = false;
        public var name:String = "";
        public var password:String = "";
        private var _SafeStr_1667:Dictionary;
        private var _SafeStr_1668:IWindow;
        private var _loginButton:_SafeStr_101;
        private var _SafeStr_1669:ITextFieldWindow;
        private var _SafeStr_1670:ITextFieldWindow;
        private var _SafeStr_1671:LoginEnvironmentsController;
        private var _avatarId:int;
        private var _SafeStr_1672:Vector.<AvatarData>;
        private var _selectedAccount:AvatarData;

        public function HabboLoginDemoScreen(_arg_1:ICoreConfiguration, _arg_2:IAssetLibrary, _arg_3:IHabboWindowManager)
        {
            _SafeStr_1666 = _arg_1;
            _SafeStr_1663 = _arg_2;
            _SafeStr_1664 = _arg_3;
            _SafeStr_1667 = new Dictionary();
            _SafeStr_1665 = getModalXmlWindow("login_window", _SafeStr_1663, _SafeStr_1664, "");
            _window = (_SafeStr_1665.rootWindow as IWindowContainer);
            createWindow();
        }

        public static function getModalXmlWindow(_arg_1:String, _arg_2:IAssetLibrary, _arg_3:IHabboWindowManager, _arg_4:String="_xml"):IModalDialog
        {
            var _local_7:IAsset;
            var _local_5:XmlAsset;
            var _local_6:IModalDialog;
            try
            {
                _local_7 = _arg_2.getAssetByName((_arg_1 + _arg_4));
                _local_5 = XmlAsset(_local_7);
                _local_6 = _arg_3.buildModalDialogFromXML(XML(_local_5.content));
            }
            catch(e:Error)
            {
                ErrorReportStorage.addDebugData("Communication", (((("Failed to build modal window " + _arg_1) + "_xml, ") + _local_7) + "!"));
                throw (e);
            };
            return (_local_6);
        }


        public function get avatarId():int
        {
            return (_avatarId);
        }

        public function get selectedAccount():AvatarData
        {
            return (_selectedAccount);
        }

        public function get selectedEnvironment():String
        {
            return (_SafeStr_1671.selectedEnvironment);
        }

        override public function dispose():void
        {
            super.dispose();
            if (_SafeStr_1665)
            {
                _SafeStr_1665.dispose();
                _SafeStr_1665 = null;
            };
            if (_SafeStr_1671)
            {
                _SafeStr_1671.removeEventListener("ENVIRONMENT_SELECTED_EVENT", onEnvironmentSelected);
                _SafeStr_1671.dispose();
                _SafeStr_1671 = null;
            };
            _SafeStr_1667 = null;
        }

        public function closeLoginWindow():void
        {
            if (_SafeStr_1665)
            {
                _SafeStr_1665.dispose();
                _SafeStr_1665 = null;
            };
        }

        public function get useWebApi():Boolean
        {
            var _local_1:ISelectableWindow = (_window.findChildByName("useTicket") as ISelectableWindow);
            if (_local_1 != null)
            {
                return (_local_1.isSelected);
            };
            return (false);
        }

        public function get useExistingSession():Boolean
        {
            return (false);
        }

        private function createWindow():void
        {
            _window.center();
            _window.caption = (_window.caption + " (air)");
            _window.findChildByName("useExistingSession").disable();
            _window.findChildByName("useExistingSession").blend = 0.5;
            _loginButton = (_window.findChildByName("login_btn") as _SafeStr_101);
            _SafeStr_1669 = (_window.findChildByName("name_field") as ITextFieldWindow);
            _SafeStr_1670 = (_window.findChildByName("pwd_field") as ITextFieldWindow);
            var _local_3:String = CommunicationUtils.readSOLString("environment");
            _loginButton.addEventListener("WME_CLICK", windowEventProcessor);
            _loginButton.caption = ((_local_3 == null) ? "Select environment above" : (("Initializing (" + _local_3) + ")"));
            _loginButton.disable();
            if (_SafeStr_1669 != null)
            {
                _SafeStr_1669.textBackground = true;
                _SafeStr_1669.textBackgroundColor = 0xFFFFFF;
                _SafeStr_1669.text = CommunicationUtils.readSOLString("login");
                _SafeStr_1669.focus();
                _SafeStr_1669.setSelection(_SafeStr_1669.text.length, _SafeStr_1669.text.length);
                _SafeStr_1669.addEventListener("WKE_KEY_UP", windowEventProcessor);
            };
            if (_SafeStr_1670 != null)
            {
                _SafeStr_1670.textBackground = true;
                _SafeStr_1670.textBackgroundColor = 0xFFFFFF;
                _SafeStr_1670.text = CommunicationUtils.restorePassword();
                _SafeStr_1670.addEventListener("WKE_KEY_UP", windowEventProcessor);
            };
            var _local_2:ISelectableWindow = (_window.findChildByName("useTicket") as ISelectableWindow);
            _local_2.addEventListener("WME_CLICK", windowEventProcessorCheckbox);
            if (_local_2)
            {
                _local_2.select();
            };
            var _local_1:ISelectableWindow = (_window.findChildByName("useExistingSession") as ISelectableWindow);
            if (_local_1)
            {
                _local_1.unselect();
            };
            if (_SafeStr_1666.getBoolean("try.existing.session"))
            {
                _firstTryUsingExistingSession = true;
                _window.visible = false;
                windowEventProcessor(WindowEvent.allocate("WE_OK", _window, null, false));
            };
            var _local_4:IItemListWindow = (_window.findChildByName("list") as IItemListWindow);
            _SafeStr_1668 = _local_4.removeListItemAt(0);
            _SafeStr_1671 = new LoginEnvironmentsController((_window.findChildByName("environment_list") as IDropListWindow), _SafeStr_1666, _SafeStr_1664, _SafeStr_1663);
            _SafeStr_1671.addEventListener("ENVIRONMENT_SELECTED_EVENT", onEnvironmentSelected);
        }

        private function onEnvironmentSelected(_arg_1:Event=null):void
        {
            dispatchEvent(new Event("ENVIRONMENT_SELECTED"));
            _loginButton.disable();
            _loginButton.caption = (("Initializing (" + _SafeStr_1671.selectedEnvironment) + ")");
            showInfoMessage((("Initializing Web Api connection to (" + _SafeStr_1671.getEnvironmentName(_SafeStr_1671.selectedEnvironment)) + ")"));
        }

        public function populateUserList(_arg_1:Map):void
        {
            var _local_3:IWindow;
            var _local_4:int;
            var _local_5:IItemListWindow = (_window.findChildByName("list") as IItemListWindow);
            if (!_local_5)
            {
                return;
            };
            _window.findChildByName("users_info").visible = false;
            var _local_2:IWindow = _SafeStr_1668.clone();
            _local_2.procedure = listEventHandler;
            _local_4 = 0;
            while (_local_4 < _arg_1.length)
            {
                _local_3 = _local_2.clone();
                _local_3.id = _arg_1.getKey(_local_4);
                _local_3.caption = _arg_1.getWithIndex(_local_4);
                _local_5.addListItem(_local_3);
                _local_4++;
            };
            _local_2.dispose();
        }

        public function displayResults(_arg_1:String):void
        {
            var _local_2:ITextWindow = (_window.findChildByName("text002") as ITextWindow);
            if (_local_2 != null)
            {
                _local_2.text = _arg_1;
            };
        }

        private function handleKeyUp(_arg_1:WindowKeyboardEvent):void
        {
            var _local_3:int;
            var _local_6:String;
            var _local_4:String;
            var _local_5:ITextFieldWindow;
            var _local_2:ITextFieldWindow;
            var _local_7:WindowKeyboardEvent = (_arg_1 as WindowKeyboardEvent);
            if (_local_7.ctrlKey)
            {
                _local_3 = (_local_7.keyCode - 49);
                if (((_local_3 >= 0) && (_local_3 < 10)))
                {
                    _local_6 = _SafeStr_1666.getProperty((("login.user." + _local_3) + ".name"));
                    _local_4 = _SafeStr_1666.getProperty((("login.user." + _local_3) + ".pass"));
                    _local_5 = (_window.findChildByName("name_field") as ITextFieldWindow);
                    _local_2 = (_window.findChildByName("pwd_field") as ITextFieldWindow);
                    if (_local_6 != "")
                    {
                        _local_5.caption = _local_6;
                    };
                    if (_local_4 != "")
                    {
                        _local_2.caption = _local_4;
                    };
                    _local_5.setSelection(_local_5.text.length, _local_5.text.length);
                    if (_local_7.cancelable)
                    {
                        _local_7.preventDefault();
                        _local_7.preventWindowOperation();
                    };
                    _arg_1.stopImmediatePropagation();
                    _arg_1.stopPropagation();
                };
            };
        }

        private function windowEventProcessor(_arg_1:WindowEvent=null, _arg_2:IWindow=null):void
        {
            if (_arg_1.type == "WKE_KEY_UP")
            {
                handleKeyUp((_arg_1 as WindowKeyboardEvent));
                if ((_arg_1 as WindowKeyboardEvent).keyCode != 13)
                {
                    return;
                };
            };
            if (_SafeStr_1669 != null)
            {
                name = _SafeStr_1669.text;
            };
            if (_SafeStr_1670 != null)
            {
                password = _SafeStr_1670.text;
            };
            CommunicationUtils.writeSOLProperty("login", name);
            CommunicationUtils.storePassword(password);
            dispatchEvent(new Event("INIT_LOGIN"));
            _loginButton.disable();
        }

        private function windowEventProcessorCheckbox(_arg_1:WindowEvent=null, _arg_2:IWindow=null):void
        {
            _loginButton.enable();
        }

        private function listEventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            if (useWebApi)
            {
                _selectedAccount = _SafeStr_1672[_arg_2.id];
            }
            else
            {
                _avatarId = _SafeStr_1672[_arg_2.id].id;
            };
            dispatchEvent(new Event("AVATAR_SELECTED"));
        }

        public function showError(_arg_1:int, _arg_2:int, _arg_3:String):void
        {
            _window.findChildByName("users_info").caption = ((("Received error: " + _arg_1) + " regarding message: ") + _arg_2);
        }

        private function showErrorMessage(_arg_1:String):void
        {
            _window.findChildByName("users_info").caption = ("Error:\n\n" + _arg_1);
        }

        private function showInfoMessage(_arg_1:String):void
        {
            _window.findChildByName("users_info").caption = _arg_1;
        }

        public function showLoginScreen():void
        {
        }

        public function showRegistrationError(_arg_1:Object):void
        {
            showErrorMessage("Registration error");
        }

        public function showInvalidLoginError(_arg_1:Object):void
        {
            showErrorMessage("Invalid login");
        }

        public function nameCheckResponse(_arg_1:Object, _arg_2:Boolean):void
        {
        }

        public function showCaptchaError():void
        {
            showErrorMessage("Captcha required, please add your IP to Housekeeping property to avoid this.");
        }

        public function showAccountError(_arg_1:Object):void
        {
            showErrorMessage("Error with account during login");
        }

        public function showLoadingScreen():void
        {
            dispose();
        }

        public function saveLooksError(_arg_1:Object):void
        {
            showErrorMessage("Save looks error ");
        }

        public function showTOS():void
        {
            showErrorMessage("Web-api wants to show Terms of Service");
        }

        public function environmentReady():void
        {
            _loginButton.enable();
            _loginButton.caption = (("Login (" + _SafeStr_1671.selectedEnvironment) + ")");
            showInfoMessage((("Web Api connection is established for (" + _SafeStr_1671.getEnvironmentName(_SafeStr_1671.selectedEnvironment)) + "). Ready to connect."));
        }

        public function populateCharacterList(_arg_1:Vector.<AvatarData>):void
        {
            var _local_3:AvatarData = null;
            _SafeStr_1672 = _arg_1;
            var _local_6:String = CommunicationUtils.readSOLString("useruniqueid");
            var _local_2:Map = new Map();
            var _local_4:int;
            for each (var _local_5:AvatarData in _arg_1)
            {
                if (_local_5.uniqueId == _local_6)
                {
                    _local_3 = _local_5;
                };
                _local_2[_local_4] = _local_5.name;
                _local_4++;
            };
            populateUserList(_local_2);
        }

        public function showSelectAvatar(_arg_1:Object):void
        {
        }

        public function showPromoHabbos(_arg_1:XML):void
        {
        }

        public function showSelectRoom():void
        {
        }

        public function showDisconnectedWithText(_arg_1:int):void
        {
            showErrorMessage("Hotel is closed");
        }

        public function showDisconnected(_arg_1:int, _arg_2:String):void
        {
            showErrorMessage((((("Disconnected reason: " + _arg_2) + " (") + _arg_1) + ")"));
        }

        public function getProperty(_arg_1:String, _arg_2:Dictionary=null):String
        {
            return ((_SafeStr_1666) ? _SafeStr_1666.getProperty(_arg_1, _arg_2) : "");
        }

        public function createCaptchaView():ICaptchaView
        {
            return (undefined);
        }

        public function captchaReady():void
        {
        }


    }
}

