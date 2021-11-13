package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.habbo.communication.messages.outgoing.quest._SafeStr_27;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.quest._SafeStr_35;
    import com.sulake.core.window.components.ITextWindow;

    public class QuestCompleted implements IDisposable 
    {

        private static const _SafeStr_3129:int = 2000;
        private static const TEXT_HEIGHT_SPACING:int = 5;
        private static const MIN_DESC_HEIGHT:int = 31;

        private var _window:IFrameWindow;
        private var _questEngine:HabboQuestEngine;
        private var _SafeStr_3125:QuestMessageData;
        private var _twinkleAnimation:Animation;
        private var _SafeStr_3130:int;

        public function QuestCompleted(_arg_1:HabboQuestEngine)
        {
            _questEngine = _arg_1;
        }

        public function dispose():void
        {
            _questEngine = null;
            _SafeStr_3125 = null;
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            if (_twinkleAnimation)
            {
                _twinkleAnimation.dispose();
                _twinkleAnimation = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_window == null);
        }

        public function onQuest(_arg_1:QuestMessageData):void
        {
            close();
        }

        public function onQuestCancelled():void
        {
            close();
        }

        public function onQuestCompleted(_arg_1:QuestMessageData, _arg_2:Boolean):void
        {
            if (_arg_2)
            {
                prepare(_arg_1);
                _SafeStr_3130 = 2000;
            };
        }

        private function close():void
        {
            if (_window)
            {
                _window.visible = false;
            };
        }

        private function onNextQuest(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            _window.visible = false;
            _questEngine.questController.questDetails.openForNextQuest = _questEngine.getBoolean("questing.showDetailsForNextQuest");
            _questEngine.send(new _SafeStr_27());
        }

        private function onMoreQuests(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _window.visible = false;
                _questEngine.send(new _SafeStr_35());
            };
        }

        public function prepare(_arg_1:QuestMessageData):void
        {
            _SafeStr_3125 = _arg_1;
            if (_window == null)
            {
                _window = IFrameWindow(_questEngine.getXmlWindow("QuestCompletedDialog"));
                _window.findChildByTag("close").procedure = onNextQuest;
                _window.findChildByName("next_quest_button").procedure = onNextQuest;
                _window.findChildByName("more_quests_button").procedure = onMoreQuests;
                _window.findChildByName("catalog_link_region").procedure = onCatalogLink;
                _twinkleAnimation = _questEngine.getTwinkleAnimation(_window);
            };
            _window.findChildByName("catalog_link_txt").caption = _questEngine.localization.getLocalization(("quests.completed.cataloglink." + _SafeStr_3125.activityPointType));
            var _local_2:String = ("quests.completed.reward." + _SafeStr_3125.activityPointType);
            _questEngine.localization.registerParameter(_local_2, "amount", _SafeStr_3125.rewardCurrencyAmount.toString());
            _window.findChildByName("reward_txt").caption = _questEngine.localization.getLocalization(_local_2, _local_2);
            _window.findChildByName("reward_txt").visible = ((_SafeStr_3125.activityPointType >= 0) && (_SafeStr_3125.rewardCurrencyAmount > 0));
            _window.visible = false;
            _window.findChildByName("congrats_txt").caption = _questEngine.localization.getLocalization(((_SafeStr_3125.lastQuestInCampaign) ? "quests.completed.campaign.caption" : "quests.completed.quest.caption"));
            _window.findChildByName("more_quests_button").visible = _SafeStr_3125.lastQuestInCampaign;
            _window.findChildByName("campaign_reward_icon").visible = _SafeStr_3125.lastQuestInCampaign;
            _window.findChildByName("catalog_link_region").visible = ((!(_SafeStr_3125.lastQuestInCampaign)) && (_SafeStr_3125.rewardCurrencyAmount > 0));
            _window.findChildByName("next_quest_button").visible = (!(_SafeStr_3125.lastQuestInCampaign));
            _window.findChildByName("reward_icon").visible = (!(_SafeStr_3125.lastQuestInCampaign));
            _window.findChildByName("campaign_reward_icon").visible = _SafeStr_3125.lastQuestInCampaign;
            _window.findChildByName("campaign_pic_bitmap").visible = _SafeStr_3125.lastQuestInCampaign;
            setWindowTitle(((_SafeStr_3125.lastQuestInCampaign) ? "quests.completed.campaign.title" : "quests.completed.quest.title"));
            _questEngine.setupCampaignImage(_window, _arg_1, _SafeStr_3125.lastQuestInCampaign);
            var _local_5:ITextWindow = ITextWindow(_window.findChildByName("desc_txt"));
            var _local_3:int = _local_5.height;
            setDesc((_SafeStr_3125.getQuestLocalizationKey() + ".completed"));
            _local_5.height = Math.max(31, (_local_5.textHeight + 5));
            var _local_4:int = (_local_5.height - _local_3);
            _window.height = (_window.height + _local_4);
        }

        private function setWindowTitle(_arg_1:String):void
        {
            _questEngine.localization.registerParameter(_arg_1, "category", _questEngine.getCampaignName(_SafeStr_3125));
            _window.caption = _questEngine.localization.getLocalization(_arg_1, _arg_1);
        }

        private function setDesc(_arg_1:String):void
        {
            _window.findChildByName("desc_txt").caption = _questEngine.localization.getLocalization(_arg_1, _arg_1);
        }

        private function onCatalogLink(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _questEngine.openCatalog(_SafeStr_3125);
            };
        }

        public function update(_arg_1:uint):void
        {
            if (_SafeStr_3130 > 0)
            {
                _SafeStr_3130 = (_SafeStr_3130 - _arg_1);
                if (_SafeStr_3130 < 1)
                {
                    _window.center();
                    _window.visible = true;
                    _window.activate();
                    if (_SafeStr_3125.lastQuestInCampaign)
                    {
                        _twinkleAnimation.restart();
                    }
                    else
                    {
                        _twinkleAnimation.stop();
                    };
                };
            };
            if (_twinkleAnimation != null)
            {
                _twinkleAnimation.update(_arg_1);
            };
        }


    }
}

