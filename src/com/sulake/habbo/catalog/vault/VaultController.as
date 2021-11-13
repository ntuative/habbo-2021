package com.sulake.habbo.catalog.vault
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.events.ILinkEventTracker;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.habbo.communication.messages.parser.vault.CreditVaultStatusMessageEvent;
    import com.sulake.habbo.communication.messages.parser.vault.IncomeRewardStatusMessageEvent;
    import com.sulake.habbo.communication.messages.parser.vault.IncomeRewardClaimResponseMessageEvent;
    import com.sulake.habbo.communication.messages.parser.vault.CreditVaultStatusMessageEventParser;
    import com.sulake.habbo.communication.messages.parser.vault.IncomeRewardStatusMessageEventParser;
    import com.sulake.habbo.communication.messages.parser.vault.IncomeRewardClaimResponseMessageEventParser;

    public class VaultController extends Component implements ILinkEventTracker 
    {

        private var _communicationManager:IHabboCommunicationManager;
        private var _localizationManager:IHabboLocalizationManager;
        private var _sessionDataManager:ISessionDataManager;
        private var _windowManager:IHabboWindowManager;
        private var _SafeStr_570:VaultView;
        private var _messageEvents:Vector.<IMessageEvent>;

        public function VaultController(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
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
            })]));
        }

        override protected function initComponent():void
        {
            _messageEvents = new Vector.<IMessageEvent>(0);
            addMessageEvent(new CreditVaultStatusMessageEvent(onVaultStatusMessageEvent));
            addMessageEvent(new IncomeRewardStatusMessageEvent(onIncomeRewardStatusMessageEvent));
            addMessageEvent(new IncomeRewardClaimResponseMessageEvent(onIncomeRewardClaimResponseMessageEvent));
            context.addLinkEventTracker(this);
        }

        private function addMessageEvent(_arg_1:IMessageEvent):void
        {
            if (!_communicationManager)
            {
                return;
            };
            _messageEvents.push(_communicationManager.addHabboConnectionMessageEvent(_arg_1));
        }

        private function onVaultStatusMessageEvent(_arg_1:CreditVaultStatusMessageEvent):void
        {
            var _local_2:CreditVaultStatusMessageEventParser;
            if (_SafeStr_570)
            {
                _local_2 = _arg_1.getParser();
                _SafeStr_570.onCreditVaultDataReceived(_local_2.isUnlocked, _local_2.totalBalance, _local_2.withdrawBalance);
            };
        }

        private function onIncomeRewardStatusMessageEvent(_arg_1:IncomeRewardStatusMessageEvent):void
        {
            var _local_2:IncomeRewardStatusMessageEventParser;
            if (_SafeStr_570)
            {
                _local_2 = _arg_1.getParser();
                _SafeStr_570.onIncomeRewardDataReceived(_local_2.data);
            };
        }

        private function onIncomeRewardClaimResponseMessageEvent(_arg_1:IncomeRewardClaimResponseMessageEvent):void
        {
            var _local_2:IncomeRewardClaimResponseMessageEventParser;
            if (_SafeStr_570)
            {
                _local_2 = _arg_1.getParser();
                _SafeStr_570.onIncomeRewardClaimResponse(_local_2.rewardCategory, _local_2.result);
            };
        }

        public function openCatalogue():void
        {
            context.createLinkEvent("catalog/open");
        }

        public function get linkPattern():String
        {
            return ("habboUI/");
        }

        public function linkReceived(_arg_1:String):void
        {
            var _local_2:Array = _arg_1.split("/");
            if (_local_2.length < 3)
            {
                return;
            };
            if (_local_2[1] == "open")
            {
                switch (_local_2[2])
                {
                    case "vault":
                        showVault();
                        return;
                };
            };
        }

        public function withdrawVaultCredits():void
        {
            _sessionDataManager.withdrawCreditVault();
        }

        public function claimReward(_arg_1:int):void
        {
            _sessionDataManager.claimReward(_arg_1);
        }

        private function showVault():void
        {
            if (((!(_SafeStr_570)) || (_SafeStr_570.disposed)))
            {
                _SafeStr_570 = new VaultView(this, _windowManager);
            };
            _sessionDataManager.getCreditVaultStatus();
            _sessionDataManager.getIncomeRewardStatus();
        }

        public function removeView():void
        {
            if (_SafeStr_570)
            {
                _SafeStr_570.dispose();
                _SafeStr_570 = null;
            };
        }

        override public function dispose():void
        {
            if (((!(_messageEvents == null)) && (!(_communicationManager == null))))
            {
                for each (var _local_1:IMessageEvent in _messageEvents)
                {
                    _communicationManager.removeHabboConnectionMessageEvent(_local_1);
                };
            };
            removeView();
            _messageEvents = null;
            super.dispose();
        }


    }
}

