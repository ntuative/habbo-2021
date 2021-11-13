package com.sulake.habbo.phonenumber
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboToolbar;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.parser.gifts.PhoneCollectionStateMessageEvent;
    import com.sulake.habbo.communication.messages.parser.gifts.TryPhoneNumberResultMessageEvent;
    import com.sulake.habbo.communication.messages.parser.gifts.TryVerificationCodeResultMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.gifts.TryPhoneNumberMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.gifts.VerifyCodeMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.gifts.SetPhoneNumberVerificationStatusMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.gifts.ResetPhoneNumberStateMessageComposer;
    import flash.utils.getTimer;

    public class HabboPhoneNumber extends Component 
    {

        protected var _communicationManager:IHabboCommunicationManager;
        protected var _localizationManager:IHabboLocalizationManager;
        protected var _sessionDataManager:ISessionDataManager;
        protected var _toolbar:IHabboToolbar;
        protected var _windowManager:IHabboWindowManager;
        private var _connection:IConnection;
        private var _SafeStr_3052:PhoneNumberCollectView;
        private var _SafeStr_3053:PhoneNumberCollectMinimizedView;
        private var _SafeStr_3054:VerificationCodeInputView;
        private var _SafeStr_3055:VerificationCodeInputMinimizedView;
        private var _retryEnableTime:int;

        public function HabboPhoneNumber(_arg_1:IContext, _arg_2:uint, _arg_3:IAssetLibrary)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communicationManager = _arg_1;
            }, true), new ComponentDependency(new IIDSessionDataManager(), function (_arg_1:ISessionDataManager):void
            {
                _sessionDataManager = _arg_1;
            }), new ComponentDependency(new IIDHabboWindowManager(), function (_arg_1:IHabboWindowManager):void
            {
                _windowManager = _arg_1;
            }), new ComponentDependency(new IIDHabboLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                _localizationManager = _arg_1;
            }), new ComponentDependency(new IIDHabboToolbar(), function (_arg_1:IHabboToolbar):void
            {
                _toolbar = _arg_1;
            })]));
        }

        override protected function initComponent():void
        {
            if (getBoolean("sms.identity.verification.enabled"))
            {
                _connection = _communicationManager.connection;
                _connection.addMessageEvent(new PhoneCollectionStateMessageEvent(onStateMessage));
                _connection.addMessageEvent(new TryPhoneNumberResultMessageEvent(onPhoneNumberResultMessage));
                _connection.addMessageEvent(new TryVerificationCodeResultMessageEvent(onVerificationCodeResultMessage));
            };
        }

        public function sendTryPhoneNumber(_arg_1:String, _arg_2:String):void
        {
            _connection.send(new TryPhoneNumberMessageComposer(_arg_1, _arg_2));
        }

        public function sendTryVerificationCode(_arg_1:String):void
        {
            if (!_arg_1)
            {
                return;
            };
            _arg_1 = _arg_1.toUpperCase();
            _connection.send(new VerifyCodeMessageComposer(_arg_1));
        }

        public function setNeverAgain():void
        {
            _connection.send(new SetPhoneNumberVerificationStatusMessageComposer(2));
            destroyCollectView();
        }

        public function setCollectViewMinimized(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                destroyCollectView();
                createCollectMinimizedView();
            }
            else
            {
                destroyCollectMinimizedView();
                createCollectView();
            };
        }

        public function setVerifyViewMinimized(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                destroyVerifyView();
                createVerifyMinimizedView();
            }
            else
            {
                destroyVerifyMinimizedView();
                createVerifyView();
            };
        }

        public function requestPhoneNumberCollectionReset():void
        {
            destroyVerifyView();
            _connection.send(new ResetPhoneNumberStateMessageComposer());
        }

        private function onPhoneNumberResultMessage(_arg_1:TryPhoneNumberResultMessageEvent):void
        {
            switch (_arg_1.getParser().resultCode)
            {
                case 2:
                    destroyCollectView();
                    return;
                case 1:
                case 3:
                case 9:
                    destroyCollectView();
                    _retryEnableTime = (_arg_1.getParser().millisToAllowProcessReset + getTimer());
                    createVerifyView();
                    return;
                case 4:
                case 5:
                case 6:
                case 10:
                    if (((!(_SafeStr_3053)) && (!(_SafeStr_3052))))
                    {
                        createCollectView();
                    }
                    else
                    {
                        if (_SafeStr_3053)
                        {
                            setCollectViewMinimized(false);
                        };
                    };
                    _windowManager.alert("${generic.alert.title}", (("${phone.number.collect.error." + _arg_1.getParser().resultCode) + "}"), 0, null);
                    _SafeStr_3052.handleSubmitFailure(_arg_1.getParser().resultCode);
                default:
            };
        }

        private function onVerificationCodeResultMessage(_arg_1:TryVerificationCodeResultMessageEvent):void
        {
            switch (_arg_1.getParser().resultCode)
            {
                case 2:
                case 3:
                    destroyVerifyView();
                    return;
                case 4:
                    if (((!(_SafeStr_3055)) && (!(_SafeStr_3054))))
                    {
                        _retryEnableTime = (getTimer() + _arg_1.getParser().millisecondsToAllowProcessReset);
                        createVerifyView();
                    }
                    else
                    {
                        if (_SafeStr_3055)
                        {
                            setVerifyViewMinimized(false);
                        };
                    };
                    _SafeStr_3054.handleSubmitFailure(_arg_1.getParser().resultCode);
                default:
            };
        }

        private function onStateMessage(_arg_1:PhoneCollectionStateMessageEvent):void
        {
            var _local_2:int = _arg_1.getParser().collectionStatusCode;
            var _local_3:int = _arg_1.getParser().phoneStatusCode;
            context.configuration.setProperty("phone.collection.status", _local_2.toString());
            context.configuration.setProperty("phone.verification.status", _local_3.toString());
            if (_local_2 == 2)
            {
                return;
            };
            if (((_local_2 == 3) && ((_local_3 == 9) || (_local_3 == 1))))
            {
                destroyCollectView();
                if (_local_2 == 1)
                {
                    createVerifyMinimizedView();
                }
                else
                {
                    _retryEnableTime = (_arg_1.getParser().millisecondsToAllowProcessReset + getTimer());
                    createVerifyView();
                };
                return;
            };
            switch (_local_3)
            {
                case 0:
                case 9:
                    createCollectView();
                    return;
                case 2:
                case 3:
                    destroyCollectView();
                    destroyVerifyView();
                    return;
                case 4:
                case 5:
                case 6:
                    Logger.log("INVALID STATE!! Phone number / verify errors should not be handled here!");
                default:
            };
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get localizationManager():IHabboLocalizationManager
        {
            return (_localizationManager);
        }

        public function get retryEnableTime():int
        {
            return (_retryEnableTime);
        }

        private function createCollectView():void
        {
            destroyCollectView();
            var _local_2:String = context.configuration.getProperty("phone.number.preferred.countries");
            var _local_1:Array = _local_2.split(",");
            _SafeStr_3052 = new PhoneNumberCollectView(this, _local_1);
        }

        private function createVerifyView():void
        {
            destroyVerifyView();
            _SafeStr_3054 = new VerificationCodeInputView(this);
        }

        private function createCollectMinimizedView():void
        {
            destroyCollectMinimizedView();
            _SafeStr_3053 = new PhoneNumberCollectMinimizedView(this);
            _toolbar.extensionView.attachExtension("phone_number", _SafeStr_3053.window, 12);
        }

        private function createVerifyMinimizedView():void
        {
            destroyVerifyMinimizedView();
            _SafeStr_3055 = new VerificationCodeInputMinimizedView(this);
            _toolbar.extensionView.attachExtension("verification_code", _SafeStr_3055.window, 12);
        }

        private function destroyCollectView():void
        {
            if (_SafeStr_3052)
            {
                _SafeStr_3052.dispose();
                _SafeStr_3052 = null;
            };
        }

        private function destroyVerifyView():void
        {
            if (_SafeStr_3054)
            {
                _SafeStr_3054.dispose();
                _SafeStr_3054 = null;
            };
        }

        private function destroyCollectMinimizedView():void
        {
            _toolbar.extensionView.detachExtension("phone_number");
            if (_SafeStr_3053)
            {
                _SafeStr_3053.dispose();
                _SafeStr_3053 = null;
            };
        }

        private function destroyVerifyMinimizedView():void
        {
            _toolbar.extensionView.detachExtension("verification_code");
            if (_SafeStr_3055)
            {
                _SafeStr_3055.dispose();
                _SafeStr_3055 = null;
            };
        }


    }
}

