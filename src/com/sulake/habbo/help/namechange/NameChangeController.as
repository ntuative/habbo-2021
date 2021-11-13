package com.sulake.habbo.help.namechange
{
    import com.sulake.habbo.help.INameChangeUI;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.help.HabboHelp;
    import com.sulake.habbo.communication.messages.incoming.avatar.CheckUserNameResultMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.incoming.users.UserNameChangedMessageEvent;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.help.enum.HabboHelpTutorialEvent;
    import com.sulake.habbo.communication.messages.outgoing.avatar.ChangeUserNameMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.avatar.CheckUserNameMessageComposer;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.communication.messages.parser.avatar.ChangeUserNameResultMessageParser;
    import com.sulake.habbo.communication.messages.parser.avatar.CheckUserNameResultMessageParser;
    import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.UserNameChangedMessageParser;

    public class NameChangeController implements INameChangeUI, IDisposable
    {

        public static const NAME_CHANGE:String = "TUI_NAME_VIEW";

        private var _disposed:Boolean;
        private var _help:HabboHelp;
        private var _SafeStr_2679:NameChangeView;
        private var _ownUserName:String;
        private var _ownUserId:int;

        public function NameChangeController(_arg_1:HabboHelp)
        {
            _help = _arg_1;
            _help.communicationManager.addHabboConnectionMessageEvent(new CheckUserNameResultMessageEvent(onCheckUserNameResult));
            _help.communicationManager.addHabboConnectionMessageEvent(new ChangeUserNameResultMessageEvent(onChangeUserNameResult));
            _help.communicationManager.addHabboConnectionMessageEvent(new UserObjectEvent(onUserObject));
            _help.communicationManager.addHabboConnectionMessageEvent(new UserNameChangedMessageEvent(onUserNameChange));
        }

        public function get help():HabboHelp
        {
            return (_help);
        }

        public function get assets():IAssetLibrary
        {
            return (_help.assets);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (_help.localization);
        }

        public function get myName():String
        {
            return (_ownUserName);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                disposeView();
                if (_help)
                {
                    _help = null;
                };
                _disposed = true;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function showView():void
        {
            if (((_SafeStr_2679 == null) || (_SafeStr_2679.disposed)))
            {
                _SafeStr_2679 = new NameChangeView(this);
            };
            _SafeStr_2679.showMainView();
            prepareForTutorial();
        }

        public function buildXmlWindow(_arg_1:String, _arg_2:uint=1):IWindow
        {
            if (_help.assets == null)
            {
                return (null);
            };
            var _local_3:XmlAsset = XmlAsset(_help.assets.getAssetByName((_arg_1 + "_xml")));
            if (((_local_3 == null) || (_help.windowManager == null)))
            {
                return (null);
            };
            return (_help.windowManager.buildFromXML(XML(_local_3.content), _arg_2));
        }

        private function disposeWindow(_arg_1:WindowEvent=null):void
        {
        }

        public function disposeView():void
        {
            if (_SafeStr_2679 != null)
            {
                _SafeStr_2679.dispose();
                _SafeStr_2679 = null;
            };
            disposeWindow();
        }

        public function hideView():void
        {
            if (_SafeStr_2679 != null)
            {
                _SafeStr_2679.dispose();
                _SafeStr_2679 = null;
            };
        }

        public function setRoomSessionStatus(_arg_1:Boolean):void
        {
            if (_arg_1 == false)
            {
                disposeView();
            };
        }

        public function prepareForTutorial():void
        {
            if (((_help == null) || (_help.events == null)))
            {
                return;
            };
            _help.events.dispatchEvent(new HabboHelpTutorialEvent("HHTPNUFWE_AVATAR_TUTORIAL_START"));
        }

        public function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            switch (_arg_1.type)
            {
                case "WME_CLICK":
                    if (_arg_2.name == "header_button_close")
                    {
                        disposeView();
                    };
                    return;
            };
        }

        public function changeName(_arg_1:String):void
        {
            disposeWindow();
            _help.sendMessage(new ChangeUserNameMessageComposer(_arg_1));
        }

        public function checkName(_arg_1:String):void
        {
            disposeWindow();
            _help.sendMessage(new CheckUserNameMessageComposer(_arg_1));
        }

        public function onUserNameChanged(_arg_1:String):void
        {
            var name:String = _arg_1;
            if ((((!(_help)) || (!(_help.localization))) || (!(_help.windowManager))))
            {
                return;
            };
            _help.localization.registerParameter("help.tutorial.name.changed", "name", name);
            _help.windowManager.alert("${generic.notice}", "${help.tutorial.name.changed}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
            {
                _arg_1.dispose();
            });
        }

        private function onChangeUserNameResult(_arg_1:ChangeUserNameResultMessageEvent):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            var _local_2:ChangeUserNameResultMessageParser = _arg_1.getParser();
            if (_local_2 == null)
            {
                return;
            };
            if (_local_2.resultCode == ChangeUserNameResultMessageEvent._SafeStr_505)
            {
                onUserNameChanged(_local_2.name);
                hideView();
            }
            else
            {
                if (_SafeStr_2679)
                {
                    _SafeStr_2679.setNameNotAvailableView(_local_2.resultCode, _local_2.name, _local_2.nameSuggestions);
                };
            };
        }

        private function onCheckUserNameResult(_arg_1:CheckUserNameResultMessageEvent):void
        {
            if (((!(_arg_1)) || (!(_SafeStr_2679))))
            {
                return;
            };
            var _local_2:CheckUserNameResultMessageParser = _arg_1.getParser();
            if (_local_2.resultCode == ChangeUserNameResultMessageEvent._SafeStr_505)
            {
                _SafeStr_2679.checkedName = _local_2.name;
            }
            else
            {
                _SafeStr_2679.setNameNotAvailableView(_local_2.resultCode, _local_2.name, _local_2.nameSuggestions);
            };
        }

        private function onUserObject(_arg_1:IMessageEvent):void
        {
            var _local_2:UserObjectMessageParser = UserObjectEvent(_arg_1).getParser();
            _ownUserId = _local_2.id;
            _ownUserName = _local_2.name;
        }

        private function onUserNameChange(_arg_1:IMessageEvent):void
        {
            var _local_2:UserNameChangedMessageParser = UserNameChangedMessageEvent(_arg_1).getParser();
            if (_ownUserId == _local_2.webId)
            {
                _ownUserName = _local_2.newName;
            };
        }

        public function get ownUserName():String
        {
            return (_ownUserName);
        }

        public function get ownUserId():int
        {
            return (_ownUserId);
        }


    }
}